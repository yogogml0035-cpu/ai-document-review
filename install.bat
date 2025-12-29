@echo off
chcp 65001 >nul 2>&1
title AI Document Review - 安装依赖

echo.
echo ============================================================
echo         AI Document Review - 安装依赖
echo ============================================================
echo.

cd /d "%~dp0"
echo 项目目录: %CD%
echo.

:: ========== 检查环境 ==========
echo ----------------------------------------
echo 环境检查
echo ----------------------------------------

:: 检查 Node.js
echo 正在检查 Node.js...
where node >nul 2>&1
if errorlevel 1 (
    echo [错误] Node.js 未安装
    echo    请访问 https://nodejs.org/ 下载安装
    pause
    exit /b 1
)
node --version >nul 2>&1
if errorlevel 1 (
    echo [警告] 无法获取 Node.js 版本
    echo [OK] Node.js 已安装（但无法获取版本）
) else (
    echo [OK] Node.js 已安装
)

:: 检查 npm
echo 正在检查 npm...
where npm >nul 2>&1
if errorlevel 1 (
    echo [错误] npm 未安装
    pause
    exit /b 1
)
npm --version >nul 2>&1
if errorlevel 1 (
    echo [警告] 无法获取 npm 版本
    echo [OK] npm 已安装（但无法获取版本）
) else (
    echo [OK] npm 已安装
)

:: 检查 Python
echo 正在检查 Python...
where python >nul 2>&1
if errorlevel 1 (
    echo [错误] Python 未安装
    echo    请访问 https://www.python.org/ 下载安装
    pause
    exit /b 1
)
python --version >nul 2>&1
if errorlevel 1 (
    echo [警告] 无法获取 Python 版本
    echo [OK] Python 已安装（但无法获取版本）
) else (
    echo [OK] Python 已安装
)

echo.
echo 环境检查完成，开始安装依赖...
echo.

:: ========== 后端依赖 ==========
echo ----------------------------------------
echo 安装后端依赖 (Python)
echo ----------------------------------------
echo.

echo 切换到 app\api 目录...
cd app\api
if errorlevel 1 (
    echo [错误] 无法切换到 app\api 目录
    echo    请确保在项目根目录运行此脚本
    pause
    exit /b 1
)
echo [OK] 当前目录: %CD%
echo.

:: 创建虚拟环境（如果不存在）
if not exist "venv" (
    echo [信息] 创建 Python 虚拟环境...
    python -m venv venv
    if errorlevel 1 (
        echo [错误] 创建虚拟环境失败
        pause
        exit /b 1
    )
    echo [OK] 虚拟环境已创建
) else (
    echo [信息] 虚拟环境已存在，跳过创建
)
echo.

:: 激活虚拟环境
echo [信息] 激活虚拟环境...
call venv\Scripts\activate.bat
if errorlevel 1 (
    echo [错误] 激活虚拟环境失败
    pause
    exit /b 1
)
echo [OK] 虚拟环境已激活
echo.

:: 安装依赖
echo [信息] 安装 Python 依赖...
pip install -r requirements.txt
if errorlevel 1 (
    echo [错误] 安装 Python 依赖失败
    pause
    exit /b 1
)
echo [OK] Python 依赖安装完成

:: 检查 .env 文件
if not exist ".env" (
    if exist ".env.tpl" (
        echo.
        echo [警告] 未找到 .env 文件，正在从模板创建...
        copy .env.tpl .env >nul
        echo [OK] 已创建 .env 文件，请编辑并配置 API Key
    )
)

cd ..\..
echo.

:: ========== 前端依赖 ==========
echo ----------------------------------------
echo 安装前端依赖 (Node.js)
echo ----------------------------------------
echo.

echo 切换到 app\ui 目录...
cd app\ui
if errorlevel 1 (
    echo [错误] 无法切换到 app\ui 目录
    echo    请确保在项目根目录运行此脚本
    pause
    exit /b 1
)
echo [OK] 当前目录: %CD%

:: 安装 npm 依赖
echo [信息] 安装 npm 依赖...
call npm install
if errorlevel 1 (
    echo [错误] 安装 npm 依赖失败
    pause
    exit /b 1
)
echo [OK] npm 依赖安装完成

cd ..\..
echo.

:: ========== 完成 ==========
echo ============================================================
echo 所有依赖安装完成！
echo.
echo 下一步:
echo    1. 编辑 app\api\.env 文件，配置必要的 API Key
echo    2. 运行 start.bat 启动服务
echo ============================================================
echo.

pause

