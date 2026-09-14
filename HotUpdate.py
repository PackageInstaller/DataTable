from __future__ import annotations

import gzip
import hashlib
import http.client
import json
import time
import urllib.error
import urllib.request
import zlib
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

from rich.progress import (
    BarColumn,
    DownloadColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)

import AlManifest
from Config import (
    CACHE_DIR,
    HTTP_RETRIES,
    HTTP_TIMEOUT,
    USER_AGENT,
    ensure_dirs,
    manifest_url,
)

FILE_CACHE = CACHE_DIR / "cdn"
MANIFEST_CACHE = FILE_CACHE / "manifest.bin"
CHUNK = 1 << 18
RETRYABLE = (
    http.client.IncompleteRead,
    http.client.HTTPException,
    urllib.error.URLError,
    TimeoutError,
    ConnectionError,
    OSError,
)



def _request(url: str, *, expected_size: int | None = None) -> bytes:
    """下载一个文件；断线/半包时用 ``Range`` 续传重试。

    CDN 对象自带 ``Content-Encoding: gzip``，urllib 不自动解压，这里自己处理。
    """
    last: Exception | None = None
    # 缓冲区要跨重试保留，断线时才能用 Range 续传
    buffer = bytearray()
    for attempt in range(HTTP_RETRIES):
        try:
            while True:
                headers = {"User-Agent": USER_AGENT, "Accept-Encoding": "identity"}
                if buffer:
                    headers["Range"] = f"bytes={len(buffer)}-"
                request = urllib.request.Request(url, headers=headers)
                with urllib.request.urlopen(request, timeout=HTTP_TIMEOUT) as response:
                    if response.status not in (200, 206):
                        raise urllib.error.HTTPError(
                            url, response.status, "bad status", response.headers, None
                        )
                    while True:
                        chunk = response.read(CHUNK)
                        if not chunk:
                            break
                        buffer += chunk
                break
        except http.client.IncompleteRead as exc:
            # 半包：留下已读部分，下一轮带 Range 续传
            buffer += exc.partial or b""
            last = exc
            print(f"[hotupdate] 连接中断，续传 {len(buffer)} 字节…（{url}）")
            time.sleep(min(2**attempt, 5))
            continue
        except RETRYABLE as exc:
            last = exc
            print(f"[hotupdate] 重试 {attempt + 1}/{HTTP_RETRIES}（{exc}）：{url}")
            time.sleep(min(2**attempt, 5))
            continue

        data = bytes(buffer)
        encoding = ""  # 续传后的字节流是整个文件，解压失败就重下
        try:
            if data[:2] == b"\x1f\x8b":
                data = gzip.decompress(data)
            elif encoding == "deflate":
                data = zlib.decompress(data)
        except (gzip.BadGzipFile, zlib.error, EOFError) as exc:
            last = exc
            print(f"[hotupdate] 解压失败，重下：{url}")
            time.sleep(min(2**attempt, 5))
            continue
        if expected_size and len(data) != expected_size:
            last = ValueError(f"大小不符 {len(data)} != {expected_size}")
            time.sleep(min(2**attempt, 5))
            continue
        return data
    raise RuntimeError(f"下载失败 {url}: {last}")


# ------------------------------------------------------------------ 清单


def load_manifest(name: str = "base", *, refresh: bool = False) -> list[AlManifest.AssetEntry]:
    """取清单（默认用缓存，``refresh=True`` 强制重下）。"""
    cache = FILE_CACHE / f"manifest_{name}.bin"
    if cache.is_file() and not refresh:
        try:
            return AlManifest.decode(cache.read_bytes())
        except ValueError:
            pass
    url = manifest_url(name)
    print(f"[hotupdate] 下载清单 {url}")
    data = _request(url)
    try:
        entries = AlManifest.decode(data)
    except ValueError as exc:
        raise RuntimeError(f"{url} 返回的不是清单（magic={data[:4]!r}）") from exc
    FILE_CACHE.mkdir(parents=True, exist_ok=True)
    cache.write_bytes(data)
    AlManifest.dump_json(entries, CACHE_DIR / f"manifest_{name}.json")
    info = AlManifest.stats(entries)
    print(f"[hotupdate] 清单 {name}: {info['entries']} 条 / {info['mb']} MB")
    return entries


# ------------------------------------------------------------------ 下载


def download(
    entries: list[AlManifest.AssetEntry],
    *,
    jobs: int = 8,
    on_entry=None,
) -> dict:
    """下载/更新一批资源（带 rich 进度条），返回统计。

    ``on_entry(entry, data, cached)`` 可用来即时处理（例如提取到 Assets/）。
    """
    ensure_dirs()
    stats = {"ok": 0, "cached": 0, "fail": 0, "mismatch": 0, "bytes": 0, "total": len(entries)}

    def fetch(entry: AlManifest.AssetEntry):
        path = FILE_CACHE / "files" / entry.group / entry.md5
        if path.is_file() and path.stat().st_size == entry.size:
            data = path.read_bytes()
            if hashlib.md5(data).hexdigest() == entry.md5:
                return entry, data, True
        try:
            data = _request(entry.url, expected_size=entry.size)
        except Exception as exc:  # noqa: BLE001
            print(f"[hotupdate] 下载失败 {entry.name}: {exc}")
            return entry, None, False
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(data)
        return entry, data, False

    total_bytes = sum(e.size for e in entries)
    with Progress(
        SpinnerColumn(),
        TextColumn("[bold blue]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        DownloadColumn(),
        TransferSpeedColumn(),
        TimeRemainingColumn(compact=True),
    ) as progress:
        task = progress.add_task("下载资产", total=total_bytes or len(entries))
        with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
            for entry, data, cached in pool.map(fetch, entries):
                # 失败的条目也推进进度，否则进度条走不满
                progress.advance(task, len(data) if data else entry.size or 1)
                if data is None:
                    stats["fail"] += 1
                    continue
                if hashlib.md5(data).hexdigest() != entry.md5 or len(data) != entry.size:
                    stats["mismatch"] += 1
                    print(f"[hotupdate] 校验不符 {entry.name}")
                    continue
                stats["bytes"] += len(data)
                stats["cached" if cached else "ok"] += 1
                if on_entry is not None:
                    on_entry(entry, data, cached)
    print(
        f"[hotupdate] 完成：新下载 {stats['ok']} / 复用 {stats['cached']} / "
        f"失败 {stats['fail']} / 校验不符 {stats['mismatch']}，"
        f"共 {stats['bytes'] / 1048576:.1f} MB"
    )
    return stats


def manifest_path(name: str) -> Path:
    return FILE_CACHE / f"manifest_{name}.bin"


def dump_json(data: dict, path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
