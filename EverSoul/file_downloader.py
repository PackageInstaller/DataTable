"""
文件下载模块
"""

import time
import requests
from pathlib import Path
from typing import Optional

from rich.console import Console
from rich.progress import (
    Progress,
    BarColumn,
    DownloadColumn,
    TransferSpeedColumn,
    TimeRemainingColumn,
    TextColumn,
)

console = Console()


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
