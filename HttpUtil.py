from __future__ import annotations

import ssl
import time
import urllib.error
import urllib.request
from pathlib import Path

from Config import REFERER, USER_AGENT

CTX = ssl.create_default_context()


def http_get(url: str, timeout: int = 60, retries: int = 5) -> bytes:
    last: Exception | None = None
    req = urllib.request.Request(
        url,
        headers={"User-Agent": USER_AGENT, "Referer": REFERER, "Accept": "*/*"},
    )
    for i in range(retries):
        try:
            with urllib.request.urlopen(req, timeout=timeout, context=CTX) as resp:
                return resp.read()
        except (urllib.error.URLError, TimeoutError, ConnectionError) as exc:
            last = exc
            time.sleep(min(2 ** i, 8))
    raise RuntimeError(f"下载失败 {url}: {last}")


def http_download(
    url: str,
    dest: Path,
    timeout: int = 120,
    retries: int = 5,
    expected_size: int | None = None,
) -> Path:
    dest.parent.mkdir(parents=True, exist_ok=True)
    if expected_size and dest.exists() and dest.stat().st_size == expected_size:
        return dest
    tmp = dest.with_suffix(dest.suffix + ".part")
    last: Exception | None = None
    for i in range(retries):
        try:
            existing = tmp.stat().st_size if tmp.exists() else 0
            headers = {"User-Agent": USER_AGENT, "Referer": REFERER, "Accept": "*/*"}
            if existing:
                headers["Range"] = f"bytes={existing}-"
            req = urllib.request.Request(url, headers=headers)
            with urllib.request.urlopen(req, timeout=timeout, context=CTX) as resp:
                status = getattr(resp, "status", None) or resp.getcode()
                mode = "ab" if status == 206 else "wb"
                if status not in (200, 206):
                    raise RuntimeError(f"HTTP {status}")
                with open(tmp, mode) as f:
                    while True:
                        chunk = resp.read(1024 * 256)
                        if not chunk:
                            break
                        f.write(chunk)
            tmp.replace(dest)
            return dest
        except (urllib.error.URLError, TimeoutError, ConnectionError, RuntimeError) as exc:
            last = exc
            time.sleep(min(2 ** i, 8))
    raise RuntimeError(f"下载失败 {url}: {last}")
