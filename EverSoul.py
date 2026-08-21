from concurrent.futures import ThreadPoolExecutor, as_completed
from enum import Enum
import importlib
import json
import multiprocessing
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path
import threading
from typing import Callable
from dataclasses import dataclass

from rich.console import Console
from rich.panel import Panel
from rich.text import Text
import time
import requests
import urllib3

from rich.console import Console
console = Console()

"""
加密解密工具模块
"""

import hashlib
from pathlib import Path
from typing import Optional
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad

from rich.console import Console
from rich.progress import DownloadColumn, Progress, BarColumn, TextColumn, TimeRemainingColumn, TransferSpeedColumn
# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
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


# 全局常量
TABLE_VERSION = 0  # 从cdn直接下载的表版本为0, 游戏下载后的表为获取的版本号
KEY_MAGIC = "!@UmWlXo"


class CryptoUtils:
    """加密解密工具类"""

    @staticmethod
    def derive_key_and_iv() -> tuple[bytes, bytes]:
        """
        密钥派生函数

        Returns:
            (解密密钥, 初始化向量)的元组

        Raises:
            RuntimeError: SHA256处理失败
        """
        try:
            # 计算 (tableVersion ^ 0x80000000) 并作为有符号整数
            xor_result = TABLE_VERSION ^ 0x80000000
            # 转换为有符号32位整数
            if xor_result >= 0x80000000:
                xor_result = xor_result - 0x100000000

            unhash_key = str(xor_result) + KEY_MAGIC

            # SHA256处理
            hash_obj = hashlib.sha256(unhash_key.encode("utf-8"))
            hash_bytes = hash_obj.digest()

            # 前16个字节作为密钥
            key = hash_bytes[:16]
            # IV与密钥相同
            iv = key

            return key, iv
        except Exception as e:
            raise RuntimeError(f"密钥派生失败: {e}")

    @staticmethod
    def decrypt_aes128_cbc(ciphertext: bytes, key: bytes, iv: bytes) -> Optional[bytes]:
        """
        使用AES-128-CBC模式解密数据

        Args:
            ciphertext: 待解密的密文数据
            key: 解密密钥
            iv: 初始化向量

        Returns:
            解密后的明文数据，失败时返回None
        """
        try:
            cipher = AES.new(key, AES.MODE_CBC, iv)
            plaintext = cipher.decrypt(ciphertext)
            # 移除填充
            plaintext = unpad(plaintext, AES.block_size)
            return plaintext
        except Exception as e:
            console.print(f"[bold red]AES解密失败: {e}[/bold red]")
            return None

    @staticmethod
    def is_file_decrypted(file_path: Path) -> bool:
        """
        检查文件是否已经被解密

        Args:
            file_path: 要检查的文件路径

        Returns:
            如果文件已解密返回True，否则返回False
        """
        try:
            with open(file_path, "rb") as f:
                header = f.read(32)
                if len(header) < 32:
                    return False

                # 检查是否有统一的偏移量模式
                has_uniform_offsets = False
                for i in range(16, 28, 4):
                    curr = int.from_bytes(header[i : i + 4], byteorder="little")
                    next_val = int.from_bytes(header[i + 4 : i + 8], byteorder="little")
                    # 检查相邻的两个4字节整数是否形成递减序列
                    if curr > next_val and (curr - next_val) < 0x1000:
                        has_uniform_offsets = True
                        break

                return has_uniform_offsets
        except Exception:
            return False

    @staticmethod
    def decrypt_file_in_place(file_path: Path, key: bytes, iv: bytes) -> bool:
        """
        在文件原位解密数据

        Args:
            file_path: 要解密的文件路径
            key: 解密密钥
            iv: 初始化向量

        Returns:
            解密成功返回True，失败返回False
        """
        try:
            # 读取文件内容
            with open(file_path, "rb") as f:
                ciphertext = f.read()

            # 解密
            plaintext = CryptoUtils.decrypt_aes128_cbc(ciphertext, key, iv)
            if plaintext is None:
                return False

            # 写回文件
            with open(file_path, "wb") as f:
                f.write(plaintext)

            return True
        except Exception as e:
            console.print(f"[bold red]解密失败 {file_path}: {e}[/bold red]")
            return False

    @staticmethod
    def decrypt_files(files: list[Path], key: bytes, iv: bytes) -> bool:
        """
        解密多个文件

        Args:
            files: 需要解密的文件路径列表
            key: 解密密钥
            iv: 初始化向量

        Returns:
            所有文件解密成功返回True，任一文件解密失败返回False
        """
        total_files = len(files)
        failed_count = 0
        failed_files = []

        with Progress(
            TextColumn("[bold blue]{task.description}"),
            BarColumn(),
            TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
            TextColumn("({task.completed}/{task.total})"),
            TimeRemainingColumn(),
            console=console,
            transient=True,
        ) as progress:
            task = progress.add_task("解密进度", total=total_files)

            for file_path in files:
                if not CryptoUtils.decrypt_file_in_place(file_path, key, iv):
                    failed_count += 1
                    failed_files.append(file_path.name)
                    console.print(
                        f"[bold yellow]警告: {file_path.name} 解密失败，跳过该文件[/bold yellow]"
                    )

                progress.update(task, advance=1)

        if failed_count > 0:
            console.print(
                f"[bold yellow]数据表解密完成，但有 {failed_count} 个文件失败[/bold yellow]"
            )
            console.print("[bold yellow]失败的文件:[/bold yellow]")
            for f in failed_files:
                console.print(f"  - {f}")

            # 如果失败文件过多（超过10%），则返回失败
            if failed_count > total_files / 10:
                console.print("[bold red]失败文件过多，可能存在严重问题[/bold red]")
                return False
            return True  # 少量文件失败，视为成功

        console.print("[bold green]数据表解密完成[/bold green]")
        return True


"""
版本管理模块
"""


@dataclass
class CNServerConfig:
    """国服配置信息结构"""

    version: str = ""
    download_urls: list[str] = None
    is_valid: bool = False

    # Review环境配置
    review_version: str = ""
    review_download_urls: list[str] = None
    review_is_valid: bool = False

    def __post_init__(self):
        if self.download_urls is None:
            self.download_urls = []
        if self.review_download_urls is None:
            self.review_download_urls = []


class VersionManager:
    """版本管理类"""

    @staticmethod
    def compare(v1: str, v2: str) -> int:
        """
        比较两个版本号

        Args:
            v1: 第一个版本号
            v2: 第二个版本号

        Returns:
            如果v1 < v2返回-1，如果v1 > v2返回1，如果v1 == v2返回0
        """
        ver1 = [int(x) for x in v1.split(".")]
        ver2 = [int(x) for x in v2.split(".")]

        for i in range(min(len(ver1), len(ver2))):
            if ver1[i] < ver2[i]:
                return -1
            if ver1[i] > ver2[i]:
                return 1

        return 0

    @staticmethod
    def check_and_install_python_libraries() -> bool:
        """
        检查并安装必要的Python库

        Returns:
            如果Python环境正确且所需库已安装或成功安装则返回True，否则返回False
        """
        # 检查google_play_scraper库是否已安装
        spec = importlib.util.find_spec("google_play_scraper")

        if spec is None:
            console.print("检测到缺失依赖，正在安装...")
            try:
                result = subprocess.run(
                    ["pip", "install", "google_play_scraper", "--user"],
                    capture_output=True,
                    text=True,
                    timeout=60,
                )
                if result.returncode != 0:
                    console.print("[bold red]安装缺失依赖失败[/bold red]")
                    return False
                console.print("[bold green]成功安装缺失依赖[/bold green]")
            except Exception as e:
                console.print(f"[bold red]安装依赖时出错: {e}[/bold red]")
                return False

        return True

    @staticmethod
    def get_version_from_google_play() -> str:
        """
        使用Python脚本从Google Play获取最新的应用版本号

        Returns:
            成功时返回版本号字符串，失败时返回空字符串
        """
        try:
            from google_play_scraper import app as playstore_app

            result = playstore_app(
                app_id="com.kakaogames.eversoul", lang="en", country="kr"
            )
            version = result.get("version", "")
            # if version:
            #     console.print(f"获取到版本号: [bold cyan]{version}[/bold cyan]")
            return version
        except Exception as e:
            console.print(f"[bold yellow]Python获取版本号失败: {e}[/bold yellow]")
            return ""

    @staticmethod
    def generate_possible_versions(base_version: str) -> list[str]:
        """
        生成一系列可能的版本号（用于检查Review服务器）

        Args:
            base_version: 基础版本号

        Returns:
            包含所有可能版本号的列表
        """
        versions = []

        # 解析基础版本号
        match = re.match(r"(\d+)\.(\d+)\.(\d+)", base_version)
        if not match:
            return versions

        major = int(match.group(1))
        minor = int(match.group(2))
        patch = int(match.group(3))

        # 当前minor版本，从当前patch开始，向上检查到200
        for p in range(patch, 201):
            versions.append(f"{major}.{minor}.{p}")

        # 下一个minor版本，从0开始，向上检查到200
        for p in range(0, 201):
            versions.append(f"{major}.{minor + 1}.{p}")

        # major递增，minor从0开始，patch从0开始，向上检查到200
        for p in range(0, 201):
            versions.append(f"{major + 1}.0.{p}")

        return versions

    @staticmethod
    def get_cn_server_config() -> CNServerConfig:
        """
        从国服apps.json获取配置信息（包括formal和review环境）

        Returns:
            包含版本号和下载URL的配置结构
        """
        config = CNServerConfig()

        try:
            url = "http://yhlh-client.zlongame.com/YHLH/obt/android/apps.json"
            response = HttpClient.get(url)

            if not response:
                return config

            data = json.loads(response)

            # === 获取 formal 正式服配置 ===
            # 从 formal.custom.patchversion 获取版本号
            if (
                "formal" in data
                and "custom" in data["formal"]
                and "patchversion" in data["formal"]["custom"]
            ):
                config.version = data["formal"]["custom"]["patchversion"]
            else:
                console.print("[bold red]国服formal配置中未找到版本号[/bold red]")

            # 从 formal.patch_url.bundle_down_url 获取下载URL列表
            if (
                "formal" in data
                and "patch_url" in data["formal"]
                and "bundle_down_url" in data["formal"]["patch_url"]
                and isinstance(data["formal"]["patch_url"]["bundle_down_url"], list)
            ):
                config.download_urls = data["formal"]["patch_url"]["bundle_down_url"]
            else:
                console.print("[bold red]国服formal配置中未找到下载URL[/bold red]")

            if config.download_urls and config.version:
                config.is_valid = True

            # === 获取 review 审核服配置 ===
            # 从 review.custom.patchversion 获取版本号
            if (
                "review" in data
                and "custom" in data["review"]
                and "patchversion" in data["review"]["custom"]
            ):
                config.review_version = data["review"]["custom"]["patchversion"]
                # console.print(f"获取到国服review版本号: [bold cyan]{config.review_version}[/bold cyan]")

            # 从 review.patch_url.bundle_down_url 获取下载URL列表
            if (
                "review" in data
                and "patch_url" in data["review"]
                and "bundle_down_url" in data["review"]["patch_url"]
                and isinstance(data["review"]["patch_url"]["bundle_down_url"], list)
            ):
                config.review_download_urls = data["review"]["patch_url"][
                    "bundle_down_url"
                ]

            if config.review_download_urls and config.review_version:
                config.review_is_valid = True

            return config
        except json.JSONDecodeError as e:
            console.print(f"[bold red]解析国服配置失败: {e}[/bold red]")
            return config
        except Exception as e:
            console.print(f"[bold red]获取国服配置失败: {e}[/bold red]")
            return config



"""
文件下载模块
"""
class FileDownloader:
    """文件下载器类"""

    @staticmethod
    def download(url: str, filepath: str, show_progress: bool = True) -> bool:
        """
        下载指定URL的文件到本地

        Args:
            url: 要下载的文件的URL
            filepath: 保存下载文件的本地路径
            show_progress: 是否显示下载进度，默认为True

        Returns:
            下载成功返回True，失败返回False
        """
        try:
            # 发起请求
            response = requests.get(url, stream=True, timeout=30, verify=False)
            response.raise_for_status()

            total_size = int(response.headers.get("content-length", 0))

            # 创建目标目录
            Path(filepath).parent.mkdir(parents=True, exist_ok=True)

            if show_progress and total_size > 0:
                with Progress(
                    TextColumn("[bold blue]{task.description}"),
                    BarColumn(),
                    DownloadColumn(),
                    TransferSpeedColumn(),
                    TimeRemainingColumn(),
                    console=console,
                    transient=True,
                ) as progress:
                    task = progress.add_task("下载进度", total=total_size)

                    with open(filepath, "wb") as f:
                        for chunk in response.iter_content(chunk_size=8192):
                            if chunk:
                                f.write(chunk)
                                progress.update(task, advance=len(chunk))
            else:
                # 不显示进度条
                with open(filepath, "wb") as f:
                    for chunk in response.iter_content(chunk_size=8192):
                        if chunk:
                            f.write(chunk)

            return True
        except Exception as e:
            console.print(f"[bold red]下载失败: {e}[/bold red]")
            return False

    @staticmethod
    def download_with_retry(
        url: str, filepath: str, max_retries: int = 3, show_progress: bool = True
    ) -> bool:
        """
        下载文件，带重试

        Args:
            url: 要下载的文件的URL
            filepath: 保存下载文件的本地路径
            max_retries: 最大重试次数，默认为3次
            show_progress: 是否显示下载进度，默认为True

        Returns:
            下载成功返回True，失败返回False
        """
        for retry in range(1, max_retries + 1):
            if FileDownloader.download(url, filepath, show_progress):
                return True

            if retry < max_retries:
                console.print(
                    f"[yellow]下载失败，正在重试 ({retry}/{max_retries})...[/yellow]"
                )
                time.sleep(1)

        console.print(f"[bold red]下载失败，已重试 {max_retries} 次[/bold red]")
        return False


"""
数据表更新模块
"""


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
        base_version: str,
        server_region: str,
        table_info_path: str = "./table_info.json",
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
                console.print(
                    "[bold red]所有URL都无法获取国服review数据表信息[/bold red]"
                )
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


class HttpClient:
    """HTTP客户端类"""

    # 默认的HTTP请求头
    DEFAULT_HEADERS = {
        "Cache-Control": "no-cache",
        "Pragma": "no-cache",
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    }

    @staticmethod
    def get(url: str, retries: int = 5, timeout: int = 10) -> str:
        """
        执行HTTP GET请求并返回响应内容

        Args:
            url: 请求的URL
            retries: 重试次数，默认为5次
            timeout: 超时时间（秒），默认为10秒

        Returns:
            服务器响应的内容，如果请求失败则返回空字符串
        """
        for attempt in range(retries):
            try:
                response = requests.get(
                    url,
                    headers=HttpClient.DEFAULT_HEADERS,
                    timeout=timeout,
                    verify=False,  # 不验证SSL证书
                    allow_redirects=True,
                )

                if response.status_code == 200:
                    return response.text

                # 如果状态码不是200，则继续重试
                if attempt < retries - 1:
                    time.sleep(1)
                    continue

                return ""
            except requests.exceptions.RequestException:
                if attempt < retries - 1:
                    time.sleep(1)
                    continue
                return ""

        return ""

    @staticmethod
    def check_redirect(url: str) -> tuple[bool, str]:
        """
        检查URL是否有效（不执行实际请求，只检查重定向）

        Args:
            url: 要检查的URL

        Returns:
            (是否有效, 重定向URL)的元组
        """
        try:
            headers = {
                **HttpClient.DEFAULT_HEADERS,
                "x-device-abis": "x86_64,arm64-v8a,x86,armeabi-v7a,armeabi",
            }

            response = requests.head(
                url, headers=headers, allow_redirects=False, verify=False, timeout=5
            )

            redirect_url = response.headers.get("Location", "")
            if redirect_url:
                return True, redirect_url

            return False, ""
        except Exception:
            return False, ""

    @staticmethod
    def get_json(url: str, retries: int = 5) -> Optional[dict]:
        """
        执行HTTP GET请求并返回JSON响应

        Args:
            url: 请求的URL
            retries: 重试次数，默认为5次

        Returns:
            解析后的JSON对象，失败时返回None
        """
        response_text = HttpClient.get(url, retries)
        if not response_text:
            return None

        try:
            import json

            return json.loads(response_text)
        except json.JSONDecodeError:
            return None


"""
数据表转换模块
"""


class TableConverter:
    """数据表转换类"""

    @staticmethod
    def convert_tables_to_json(
        schema_dir: str, table_dir: str, output_dir: str
    ) -> bool:
        """
        将数据表转换为JSON格式

        Args:
            schema_dir: FlatBuffers schema文件所在的目录路径
            table_dir: 二进制数据表文件所在的目录路径
            output_dir: 输出JSON文件的目录路径

        Returns:
            转换成功返回True，失败返回False
        """
        try:
            schema_path = Path(schema_dir)
            table_path = Path(table_dir)
            output_path = Path(output_dir)

            if not output_path.exists():
                output_path.mkdir(parents=True, exist_ok=True)

            # 统计需要转换的文件数量
            total_files = 0
            files_to_convert = []
            for fbs_file in schema_path.glob("*.fbs"):
                tbl_file = table_path / f"{fbs_file.stem}.tbl"
                if tbl_file.exists():
                    total_files += 1
                    files_to_convert.append((fbs_file, tbl_file))

            result = 0
            with Progress(
                TextColumn("[bold blue]{task.description}"),
                BarColumn(),
                TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
                TextColumn("({task.completed}/{task.total})"),
                TextColumn("{task.fields[filename]}"),
                TimeRemainingColumn(),
                console=console,
                transient=True,
            ) as progress:
                task = progress.add_task("转换进度", total=total_files, filename="")

                for fbs_file, tbl_file in files_to_convert:
                    schema_name = fbs_file.stem
                    progress.update(task, filename=f"{schema_name}.tbl")

                    command = [
                        "flatc",
                        "--json",
                        "--raw-binary",
                        "--strict-json",
                        "--natural-utf8",
                        "-o",
                        str(output_path),
                        str(fbs_file),
                        "--",
                        str(tbl_file),
                    ]

                    result = subprocess.run(
                        command, capture_output=True, text=True
                    ).returncode

                    if result != 0:
                        continue

                    progress.update(task, advance=1)

            if result == 0:
                console.print("[bold green]数据表转换完成[/bold green]")
                return True
            return False
        except Exception as e:
            console.print(f"[bold red]转换过程出错: {e}[/bold red]")
            return False

    @staticmethod
    def generate_flatbuffer_python_api(schema_dir: str, output_dir: str) -> bool:
        """
        根据FlatBuffer schema文件生成Python API

        Args:
            schema_dir: FlatBuffer schema文件所在的目录路径
            output_dir: 生成的Python API文件输出目录路径

        Returns:
            生成成功返回True，失败返回False
        """
        original_cwd = os.getcwd()

        try:
            abs_schema_dir = Path(schema_dir).resolve()

            if not abs_schema_dir.exists():
                console.print(
                    f"[bold red]Schema目录不存在: {abs_schema_dir}[/bold red]"
                )
                return False

            output_path = Path(output_dir)
            if not output_path.exists():
                output_path.mkdir(parents=True, exist_ok=True)

            # 切换到输出目录
            os.chdir(output_dir)

            # 统计.fbs文件数量
            fbs_files = list(abs_schema_dir.glob("*.fbs"))
            total_files = len(fbs_files)

            if total_files == 0:
                console.print(
                    f"[bold yellow]在Schema目录中未找到.fbs文件: {abs_schema_dir}[/bold yellow]"
                )
                return False

            generated_files = []

            with Progress(
                TextColumn("[bold blue]{task.description}"),
                BarColumn(),
                TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
                TextColumn("({task.completed}/{task.total})"),
                TextColumn("{task.fields[filename]}"),
                TimeRemainingColumn(),
                console=console,
                transient=True,
            ) as progress:
                task = progress.add_task("生成进度", total=total_files, filename="")

                for fbs_file in fbs_files:
                    schema_name = fbs_file.stem
                    progress.update(task, filename=f"{schema_name}.fbs")

                    command = ["flatc", "--python", str(fbs_file)]

                    result = subprocess.run(command, capture_output=True, text=True)

                    if result.returncode == 0:
                        generated_files.append(schema_name)
                    else:
                        console.print(
                            f"[bold yellow]生成 {schema_name} 的Python API失败[/bold yellow]"
                        )

                    progress.update(task, advance=1)

            # 为每个命名空间生成__init__.py文件
            namespace_files = {}

            for root, dirs, files in os.walk("."):
                for file in files:
                    if file.endswith(".py") and file != "__init__.py":
                        dir_name = Path(root).name
                        file_name = Path(file).stem
                        if file_name.endswith("Table"):
                            if dir_name not in namespace_files:
                                namespace_files[dir_name] = []
                            namespace_files[dir_name].append(file_name)

            for namespace_dir, files in namespace_files.items():
                init_file = Path(namespace_dir) / "__init__.py"
                with open(init_file, "w", encoding="utf-8") as f:
                    f.write("# Auto-generated FlatBuffer Python API\n")
                    f.write(
                        f"# Generated from Eversoul schema files - namespace: {namespace_dir}\n\n"
                    )

                    for file_name in files:
                        f.write(f"from . import {file_name}\n")

                    f.write("\n__all__ = [\n")
                    for i, file_name in enumerate(files):
                        comma = "," if i < len(files) - 1 else ""
                        f.write(f"    '{file_name}'{comma}\n")
                    f.write("]\n")

            if generated_files:
                console.print(
                    f"[bold green]成功生成 {len(generated_files)} 个FlatBuffer Python API文件[/bold green]"
                )
                os.chdir(original_cwd)
                return True
            else:
                os.chdir(original_cwd)
                console.print("[bold red]未能生成任何Python API文件[/bold red]")
                return False
        except Exception as e:
            try:
                os.chdir(original_cwd)
            except:
                pass

            console.print(f"[bold red]生成FlatBuffer Python API出错: {e}[/bold red]")
            return False


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
            ServerType.GLOBAL_REVIEW, state.version, config=config
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
                ServerType.GLOBAL_LIVE, state.version, config=config
            ):
                state.need_generate_apis = True
            else:
                console.print("[bold red]Global Live数据表下载失败[/bold red]")
                return False
        else:
            if TableUpdater.update_data_tables(
                ServerType.GLOBAL_LIVE, state.version, config=config
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
        (
            "处理Global Review数据表",
            lambda: process_global_review_tables(state, config),
        ),
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
