import sys
from pathlib import Path
from typing import Callable
from dataclasses import dataclass

from rich.console import Console
from rich.panel import Panel
from rich.text import Text

from version_manager import VersionManager
from table_updater import TableUpdater, ServerType
from table_converter import TableConverter

console = Console()


@dataclass
class AppConfig:
    """应用程序配置结构"""

    SERVER_REGION: str = "Global"
    
    # 数据表目录
    GLOBAL_LIVE_TABLE_DIR: str = "MasterData/Global/Live"
    GLOBAL_REVIEW_TABLE_DIR: str = "MasterData/Global/Review"
    CN_LIVE_TABLE_DIR: str = "MasterData/CN/Live"
    CN_REVIEW_TABLE_DIR: str = "MasterData/CN/Review"
    
    # Schema目录
    GLOBAL_SCHEMA_DIR: str = "Schema/Global"
    CN_SCHEMA_DIR: str = "Schema/CN"
    
    # 输出和临时文件目录
    OUTPUT_DIR: str = "../../"
    TEMP_DIR: str = "./"
    
    # 配置文件路径
    TABLE_INFO_PATH: str = "./table_info.json"
    
    # 下载文件命名模板
    ZIP_FILE_TEMPLATE: str = "data_{region}_{type}_{version}.zip"


@dataclass
class AppState:
    """应用程序状态"""

    version: str = ""
    need_generate_apis: bool = False
    python_ready: bool = False


def initialize_python_environment(state: AppState) -> bool:
    """
    初始化Python环境

    Args:
        state: 应用程序状态

    Returns:
        操作是否成功
    """
    try:
        state.python_ready = VersionManager.check_and_install_python_libraries()
        return True
    except Exception as e:
        console.print(f"[bold red]Python环境初始化失败: {e}[/bold red]")
        return False


def retrieve_app_version(state: AppState) -> bool:
    """
    获取应用版本号

    Args:
        state: 应用程序状态

    Returns:
        操作是否成功
    """
    try:
        # 优先使用Python方法获取版本号
        if state.python_ready:
            state.version = VersionManager.get_version_from_google_play()
            if state.version:
                return True
            else:
                console.print("Python方法获取版本号失败")
                return False
        else:
            console.print("Python环境未就绪，无法获取版本号")
            return False
    except Exception as e:
        console.print(f"[bold red]版本号获取失败: {e}[/bold red]")
        return False


def process_global_review_tables(state: AppState, config: AppConfig) -> bool:
    """
    处理Global Review数据表

    Args:
        state: 应用程序状态
        config: 应用程序配置

    Returns:
        操作是否成功
    """
    try:
        # 直接调用统一函数，会自动检查和更新
        if TableUpdater.update_data_tables(
            ServerType.GLOBAL_REVIEW, 
            state.version,
            config=config
        ):
            state.need_generate_apis = True
        return True
    except Exception as e:
        console.print(f"[bold red]Global Review数据表处理失败: {e}[/bold red]")
        return False


def process_global_live_tables(state: AppState, config: AppConfig) -> bool:
    """
    处理Global Live数据表

    Args:
        state: 应用程序状态
        config: 应用程序配置

    Returns:
        操作是否成功
    """
    try:
        table_dir = Path(config.GLOBAL_LIVE_TABLE_DIR)

        # 检查数据表目录是否存在且非空
        if not table_dir.exists() or not any(table_dir.iterdir()):
            if TableUpdater.update_data_tables(
                ServerType.GLOBAL_LIVE, 
                state.version,
                config=config
            ):
                state.need_generate_apis = True
            else:
                console.print("[bold red]Global Live数据表下载失败[/bold red]")
                return False
        else:
            if TableUpdater.update_data_tables(
                ServerType.GLOBAL_LIVE, 
                state.version,
                config=config
            ):
                console.print("Global Live数据表更新完成")
                state.need_generate_apis = True
        return True
    except Exception as e:
        console.print(f"[bold red]Global Live数据表处理失败: {e}[/bold red]")
        return False


def process_cn_live_tables(state: AppState, config: AppConfig) -> bool:
    """
    处理CN Live数据表

    Args:
        state: 应用程序状态
        config: 应用程序配置

    Returns:
        操作是否成功
    """
    try:
        if TableUpdater.update_data_tables(ServerType.CN_LIVE, "", config=config):
            state.need_generate_apis = True
        return True
    except Exception as e:
        console.print(f"[bold red]CN Live数据表处理失败: {e}[/bold red]")
        return False


def process_cn_review_tables(state: AppState, config: AppConfig) -> bool:
    """
    处理CN Review数据表

    Args:
        state: 应用程序状态
        config: 应用程序配置

    Returns:
        操作是否成功
    """
    try:
        if TableUpdater.update_data_tables(ServerType.CN_REVIEW, "", config=config):
            state.need_generate_apis = True
        return True
    except Exception as e:
        console.print(f"[bold red]CN Review数据表处理失败: {e}[/bold red]")
        return False




def run_application() -> int:
    """
    运行应用程序主逻辑

    Returns:
        程序退出码
    """
    state = AppState()
    config = AppConfig()

    operations: list[tuple[str, Callable[[], bool]]] = [
        ("初始化Python环境", lambda: initialize_python_environment(state)),
        ("获取应用版本", lambda: retrieve_app_version(state)),
        ("处理Global Review数据表", lambda: process_global_review_tables(state, config)),
        ("处理Global Live数据表", lambda: process_global_live_tables(state, config)),
        ("处理CN Live数据表", lambda: process_cn_live_tables(state, config)),
        ("处理CN Review数据表", lambda: process_cn_review_tables(state, config)),
        # ("生成API文件", lambda: generate_api_files(state, config)),
    ]

    for description, operation in operations:
        console.print(f"正在执行: {description}")

        if not operation():
            console.print(f"[bold red]操作失败: {description}[/bold red]")
            return 1

    return 0


def main() -> int:
    """主函数"""
    try:
        return run_application()
    except KeyboardInterrupt:
        console.print("\n[bold yellow]程序被用户中断[/bold yellow]")
        return 130
    except Exception as e:
        console.print(f"[bold red]程序执行错误: {e}[/bold red]")
        return 1
    except:
        console.print("[bold red]未知错误发生[/bold red]")
        return 1


if __name__ == "__main__":
    sys.exit(main())
