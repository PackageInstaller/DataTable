"""
数据表更新模块
"""

import json
import re
import subprocess
import shutil
import threading
from pathlib import Path
from enum import Enum
from dataclasses import dataclass
from typing import Optional
from concurrent.futures import ThreadPoolExecutor, as_completed
import multiprocessing

from rich.console import Console
from rich.progress import Progress, BarColumn, TextColumn, TimeRemainingColumn

from http_client import HttpClient
from file_downloader import FileDownloader
from crypto_utils import CryptoUtils
from table_converter import TableConverter
from version_manager import VersionManager

console = Console()


class ServerType(Enum):
    """服务器类型枚举"""

    GLOBAL_LIVE = "GlobalLive"
    GLOBAL_REVIEW = "GlobalReview"
    CN_LIVE = "CNLive"
    CN_REVIEW = "CNReview"


@dataclass
class TableInfo:
    """数据表信息"""

    version: int = 0
    action: int = 0


@dataclass
class ReviewServerInfo:
    """Review服务器信息"""

    exists: bool = False
    version: str = ""
    cdn_date: str = ""
    table_info: TableInfo = None

    def __post_init__(self):
        if self.table_info is None:
            self.table_info = TableInfo()


class TableUpdater:
    """数据表更新类"""

    @staticmethod
    def get_table_info(version: str) -> TableInfo:
        """
        获取指定版本的数据表信息

        Args:
            version: 游戏版本号

        Returns:
            包含数据表版本和操作信息的结构体
        """
        url = f"https://patch.esoul.kakaogames.com/Live/{version}/Table/const_data_version.json"
        response = HttpClient.get(url)

        data = json.loads(response)
        info = TableInfo()
        info.version = data["version"]
        info.action = data["action"]
        return info

    @staticmethod
    def check_review_version(
        version: str, stop_event: Optional[threading.Event] = None
    ) -> tuple[bool, str]:
        """
        检查指定版本是否为可用的Review服务器版本

        Args:
            version: 要检查的版本号
            stop_event: 停止事件，当其他线程找到版本时会设置此事件

        Returns:
            (是否可用, CDN日期字符串)的元组
        """
        # 如果已经找到版本，直接返回
        if stop_event and stop_event.is_set():
            return False, 0

        url = (
            f"https://gc-infodesk-zinny3.kakaogames.com/v2/app?"
            f"appId=743491&appVer={version}&market=googlePlay&sdkVer=1&os=android&lang=en"
        )

        try:
            # 使用更短的超时时间和重试次数
            response = HttpClient.get(url, retries=2, timeout=5)
            if not response:
                return False, ""

            # 再次检查停止事件
            if stop_event and stop_event.is_set():
                return False, ""

            data = json.loads(response)

            # 检查是否是review版本
            if (
                data.get("content", {}).get("appOption", {}).get("appVerSvcStatus")
                == "review"
            ):

                cdn_addr = data.get("content", {}).get("appOption", {}).get("cdnAddr")
                if cdn_addr and cdn_addr != "null":
                    match = re.search(r"/Review/(\d+)", cdn_addr)
                    if match:
                        cdn_date = match.group(1)
                        return True, cdn_date
        except Exception:
            return False, ""

        return False, ""

    @staticmethod
    def check_review_server(
        base_version: str, server_region: str, table_info_path: str = "./table_info.json"
    ) -> ReviewServerInfo:
        """
        检查Review服务器并获取相关信息

        Args:
            base_version: 基础版本号，用于生成可能的版本号
            server_region: 服务器区域（如 "Global", "CN" 等）

        Returns:
            包含Review服务器信息的结构体
        """
        info = ReviewServerInfo()

        # 首先搜索新版本
        versions = VersionManager.generate_possible_versions(base_version)

        # 获取CPU核心数
        cpu_cores = multiprocessing.cpu_count()
        # 将线程数设置为核心数的18倍，但不超过1024
        max_threads = min(1024, cpu_cores * 18 if cpu_cores > 0 else 128)

        total_versions = len(versions)
        checked_versions = 0
        found_version = False

        # 创建停止事件，用于通知所有线程停止
        stop_event = threading.Event()

        with Progress(
            TextColumn("[bold blue]{task.description}"),
            BarColumn(),
            TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
            TextColumn("({task.completed}/{task.total})"),
            TextColumn("{task.fields[version]}"),
            console=console,
            transient=True,
        ) as progress:
            task = progress.add_task("检查进度", total=total_versions, version="")

            with ThreadPoolExecutor(max_workers=max_threads) as executor:
                future_to_version = {
                    executor.submit(
                        TableUpdater.check_review_version, ver, stop_event
                    ): ver
                    for ver in versions
                }

                for future in as_completed(future_to_version):
                    ver = future_to_version[future]
                    checked_versions += 1

                    try:
                        success, cdn_date = future.result()
                        if success:
                            info.exists = True
                            info.version = ver
                            info.cdn_date = cdn_date
                            found_version = True
                            # 设置停止事件，通知所有线程停止
                            stop_event.set()
                            # 更新进度条到100%
                            progress.update(task, completed=total_versions, version=ver)
                            break
                    except Exception:
                        pass

                    progress.update(task, advance=1, version=ver)

                    if found_version:
                        break

        if not info.exists:
            # 尝试从本地配置读取
            table_info_file = Path(table_info_path)
            if table_info_file.exists():
                try:
                    with open(table_info_file, "r", encoding="utf-8") as f:
                        table_info = json.load(f)

                    if (
                        server_region in table_info
                        and "Review" in table_info[server_region]
                        and table_info[server_region]["Review"].get("version")
                        and table_info[server_region]["Review"].get("cdnDate")
                        and table_info[server_region]["Review"].get("tableVersion")
                    ):

                        info.exists = True
                        info.version = table_info[server_region]["Review"]["version"]
                        info.cdn_date = table_info[server_region]["Review"]["cdnDate"]
                        info.table_info.version = table_info[server_region]["Review"][
                            "tableVersion"
                        ]

                        # 验证这个版本是否可访问
                        url = (
                            f"https://patch.esoul.kakaogames.com/Review/{info.cdn_date}/"
                            f"{info.version}/Table/const_data_version.json"
                        )

                        response = HttpClient.get(url)
                        if response:
                            try:
                                data = json.loads(response)
                                info.table_info.action = data.get("action", 0)
                            except:
                                pass
                except Exception as e:
                    console.print(f"[bold yellow]JSON解析错误: {e}[/bold yellow]")

        if not info.exists:
            console.print("[bold yellow]未找到可用的 Review 服务器版本[/bold yellow]")

        return info

    @staticmethod
    def update_data_tables(
        server_type: ServerType,
        version: str = "",
        review_info: Optional[ReviewServerInfo] = None,
        config: Optional[any] = None,
    ) -> bool:
        """
        统一的数据表更新函数

        Args:
            server_type: 服务器类型
            version: 版本号
            review_info: Review服务器信息（可选）
            config: 应用程序配置（可选，包含所有路径配置）

        Returns:
            如果数据表需要更新并成功更新则返回True，否则返回False
        """
        # 获取路径配置
        if config:
            global_live_dir = config.GLOBAL_LIVE_TABLE_DIR
            global_review_dir = config.GLOBAL_REVIEW_TABLE_DIR
            cn_live_dir = config.CN_LIVE_TABLE_DIR
            cn_review_dir = config.CN_REVIEW_TABLE_DIR
            global_schema_dir = config.GLOBAL_SCHEMA_DIR
            cn_schema_dir = config.CN_SCHEMA_DIR
            table_info_path = config.TABLE_INFO_PATH
            temp_dir = config.TEMP_DIR
        else:
            # 默认路径
            global_live_dir = "../../Table/Global/Live"
            global_review_dir = "../../Table/Global/Review"
            cn_live_dir = "../../Table/CN/Live"
            cn_review_dir = "../../Table/CN/Review"
            global_schema_dir = "../../FlatBuffers/Schema/Global"
            cn_schema_dir = "../../FlatBuffers/Schema/CN"
            table_info_path = "./table_info.json"
            temp_dir = "../../"
        
        # 1. 准备阶段：获取版本信息、下载链接、目标路径等
        zip_url = ""
        table_version = 0
        current_version = version
        server_region = ""
        table_type = ""  # "Live" or "Review"
        target_dir = Path()
        schema_dir = Path()
        cdn_date = ""  # Only for Review

        if server_type == ServerType.GLOBAL_LIVE:
            server_region = "Global"
            table_type = "Live"
            target_dir = Path(global_live_dir)
            schema_dir = Path(global_schema_dir)

            # 获取服务器上的实际版本信息
            version_url = f"https://patch.esoul.kakaogames.com/Live/{current_version}/Table/const_data_version.json"
            console.print(f"检查版本URL: {version_url}")

            info = TableUpdater.get_table_info(current_version)
            if info.version == 0:
                console.print("[bold red]获取数据表信息失败[/bold red]")
                return False
            table_version = info.version
            console.print(f"服务器数据表版本: {table_version}")

            zip_url = f"https://patch.esoul.kakaogames.com/Live/{current_version}/Table/data_{table_version}.zip"

        elif server_type == ServerType.CN_LIVE:
            server_region = "CN"
            table_type = "Live"
            target_dir = Path(cn_live_dir)
            schema_dir = Path(cn_schema_dir)  # 国服使用CN的Schema

            # 获取国服配置
            cn_config = VersionManager.get_cn_server_config()
            if not cn_config.is_valid:
                console.print("[bold red]获取国服配置失败[/bold red]")
                return False
            current_version = cn_config.version

            # 尝试从每个URL获取数据表版本信息
            working_base_url = ""
            for base_url in cn_config.download_urls:
                try:
                    version_url = (
                        f"{base_url}/{current_version}/Table/const_data_version.json"
                    )
                    console.print(f"检查版本URL: {version_url}")

                    response = HttpClient.get(version_url)
                    if response:
                        data = json.loads(response)
                        table_version = data["version"]
                        working_base_url = base_url
                        console.print(f"服务器数据表版本: {table_version}")
                        break
                except:
                    continue

            if table_version == 0 or not working_base_url:
                console.print("[bold red]所有URL都无法获取数据表信息[/bold red]")
                return False

            zip_url = (
                f"{working_base_url}/{current_version}/Table/data_{table_version}.zip"
            )

        elif server_type == ServerType.CN_REVIEW:
            server_region = "CN"
            table_type = "Review"
            target_dir = Path(cn_review_dir)
            schema_dir = Path(cn_schema_dir)  # 国服使用CN的Schema

            # 获取国服配置
            cn_config = VersionManager.get_cn_server_config()
            if not cn_config.review_is_valid:
                console.print("[bold red]获取国服review配置失败[/bold red]")
                return False
            current_version = cn_config.review_version

            # 尝试从每个URL获取数据表版本信息
            working_base_url = ""
            for base_url in cn_config.review_download_urls:
                try:
                    version_url = (
                        f"{base_url}/{current_version}/Table/const_data_version.json"
                    )
                    console.print(f"检查版本URL: {version_url}")

                    response = HttpClient.get(version_url)
                    if response:
                        data = json.loads(response)
                        table_version = data["version"]
                        working_base_url = base_url
                        console.print(f"服务器数据表版本: {table_version}")
                        break
                except:
                    continue

            if table_version == 0 or not working_base_url:
                console.print("[bold red]所有URL都无法获取国服review数据表信息[/bold red]")
                return False

            zip_url = (
                f"{working_base_url}/{current_version}/Table/data_{table_version}.zip"
            )

        elif server_type == ServerType.GLOBAL_REVIEW:
            server_region = "Global"
            table_type = "Review"
            target_dir = Path(global_review_dir)
            schema_dir = Path(global_schema_dir)

            # 如果没有提供 review_info，则自动检查
            if not review_info:
                if not version:
                    console.print(
                        "[bold red]GlobalReview 需要提供 base_version 或 review_info[/bold red]"
                    )
                    return False
                review_info = TableUpdater.check_review_server(
                    version, server_region, table_info_path
                )
                if not review_info.exists:
                    console.print(
                        "[bold yellow]未找到可用的 Review 服务器版本[/bold yellow]"
                    )
                    return False

            current_version = review_info.version
            cdn_date = review_info.cdn_date

            table_version = TableUpdater.get_server_table_version(review_info)
            if table_version == -1:
                return False

            zip_url = (
                f"https://patch.esoul.kakaogames.com/Review/{cdn_date}/"
                f"{current_version}/Table/data_{table_version}.zip"
            )

        # 2. 检查本地信息，是否需要更新
        table_info_file = Path(table_info_path)
        table_info = {}
        table_exist = target_dir.exists() and any(target_dir.iterdir())

        if table_info_file.exists():
            try:
                with open(table_info_file, "r", encoding="utf-8") as f:
                    table_info = json.load(f)

                if (
                    server_region in table_info
                    and table_type in table_info[server_region]
                    and table_info[server_region][table_type]["version"]
                    == current_version
                    and table_info[server_region][table_type]["tableVersion"]
                    == table_version
                    and table_exist
                ):

                    if (
                        server_type == ServerType.GLOBAL_REVIEW
                        and "cdnDate" in table_info[server_region][table_type]
                        and table_info[server_region][table_type]["cdnDate"] != cdn_date
                    ):
                        # Continue update if cdnDate mismatch for Review
                        pass
                    else:
                        console.print(
                            f"[bold green]{server_region} {table_type} 数据表已是最新版本[/bold green]"
                        )
                        return False
                else:
                    # Just log/print reason if needed
                    if (
                        server_region in table_info
                        and table_type in table_info[server_region]
                    ):
                        if (
                            table_info[server_region][table_type]["tableVersion"]
                            != table_version
                        ):
                            console.print(
                                f"表版本不同: {table_info[server_region][table_type]['tableVersion']} -> {table_version}"
                            )
            except:
                pass
        else:
            console.print("table_info.json 不存在，将创建新文件")

        # 3. 下载
        zip_filename = f"data_{server_region}_{table_type}_{table_version}.zip"
        zip_path = str(Path(temp_dir) / zip_filename)
        if not FileDownloader.download_with_retry(zip_url, zip_path, 3, True):
            return False

        # 4. 清理旧目录并解压
        if target_dir.exists():
            shutil.rmtree(target_dir)
        target_dir.mkdir(parents=True, exist_ok=True)

        unzip_command = ["unzip", "-o", zip_path, "-d", str(target_dir) + "/"]
        subprocess.run(unzip_command, capture_output=True, text=True)
        Path(zip_path).unlink()

        # 5. 解密
        key, iv = CryptoUtils.derive_key_and_iv()

        files_to_decrypt = []
        for file_path in target_dir.iterdir():
            if file_path.is_file() and not CryptoUtils.is_file_decrypted(file_path):
                files_to_decrypt.append(file_path)

        if not CryptoUtils.decrypt_files(files_to_decrypt, key, iv):
            console.print("[bold red]数据表解密失败[/bold red]")
            return False

        # 6. 转换
        if not TableConverter.convert_tables_to_json(
            str(schema_dir), str(target_dir), str(target_dir)
        ):
            console.print("[bold red]数据表转换失败[/bold red]")
            return False

        # 7. 清理 .tbl
        for file_path in target_dir.iterdir():
            if file_path.is_file() and file_path.suffix == ".tbl":
                file_path.unlink()

        # 8. 更新 JSON
        try:
            if server_region not in table_info:
                table_info[server_region] = {}

            table_info[server_region][table_type] = {
                "version": current_version,
                "tableVersion": table_version,
            }

            if server_type == ServerType.GLOBAL_REVIEW and cdn_date:
                table_info[server_region][table_type]["cdnDate"] = cdn_date

            with open(table_info_file, "w", encoding="utf-8") as f:
                json.dump(table_info, f, indent=4, ensure_ascii=False)
        except:
            pass

        console.print(
            f"[bold green]{server_region} {table_type} 数据表已更新到最新版本[/bold green]"
        )
        return True

    @staticmethod
    def get_server_table_version(review_info: ReviewServerInfo) -> int:
        """
        获取服务器数据表版本信息

        Args:
            review_info: Review服务器信息

        Returns:
            服务器数据表版本号，失败时返回-1
        """
        version_url = (
            f"https://patch.esoul.kakaogames.com/Review/{review_info.cdn_date}/"
            f"{review_info.version}/Table/const_data_version.json"
        )
        console.print(f"检查版本URL: {version_url}")

        version_response = HttpClient.get(version_url)
        if not version_response:
            console.print("[bold red]获取 Review 服务器版本信息失败[/bold red]")
            return -1

        try:
            version_data = json.loads(version_response)
            server_version = version_data["version"]
            console.print(f"服务器数据表版本: {server_version}")
            return server_version
        except Exception as e:
            console.print(f"[bold red]解析版本信息失败: {e}[/bold red]")
            return -1
