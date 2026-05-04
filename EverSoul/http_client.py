"""
HTTP客户端模块
"""

import time
import requests
from typing import Optional
import urllib3

from rich.console import Console

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

console = Console()


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
