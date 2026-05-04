"""
版本管理模块
"""

import importlib.util
import subprocess
import json
import re
from typing import Optional
from dataclasses import dataclass

from rich.console import Console
from http_client import HttpClient

console = Console()


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
                config.review_download_urls = data["review"]["patch_url"]["bundle_down_url"]

            if config.review_download_urls and config.review_version:
                config.review_is_valid = True

            return config
        except json.JSONDecodeError as e:
            console.print(f"[bold red]解析国服配置失败: {e}[/bold red]")
            return config
        except Exception as e:
            console.print(f"[bold red]获取国服配置失败: {e}[/bold red]")
            return config
