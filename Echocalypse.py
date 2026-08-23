"""
绯红神约 (Echocalypse) 热更资源下载 / UF / XXTEA 解密

用法:
    python3 Echocalypse.py update [--version 4025067|--all] [--jobs 8]
                                   # 下载热更+静默包，解压后自动解密图片/转换数据表
    python3 Echocalypse.py decrypt [目录...] [--lua-only] [--no-images]
                                   # 对 UF/XXTEA 文件原地解密，CCZ 可转 PNG
    python3 Echocalypse.py lua [--version 4025067|--all]
                                   # 下载热更 Lua，解密并转换到 Lua/
    python3 Echocalypse.py usm [目录...] [--out Usms] [--format mp4|ivf]
                                   # 把 CRI USM（IVF/VP9）转成可播放文件
    python3 Echocalypse.py bytecode [--src Zips] [--out Bytecode] [--only 64bit]
                                   # 从 zip 解密并还原标准 LuaJIT 2.1 字节码（.lj）
    python3 Echocalypse.py painting [--lang cn] [--out Paintings]
                                   # 只拉立绘相关 lua/语言包，解密 knight_big 并按角色名皮肤名导出
"""

from __future__ import annotations

import argparse
import hashlib
import math
import multiprocessing
import os
import re
import shutil
import struct
import subprocess
import tempfile
import threading
import time
import zipfile
import zlib
from concurrent.futures import ProcessPoolExecutor, ThreadPoolExecutor, as_completed
from pathlib import Path

import numpy as np
import requests
from rich.console import Console
from rich.progress import (
    BarColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
    TotalFileSizeColumn,
    TransferSpeedColumn,
)

SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
ZIPS_DIR = SCRIPT_DIR / "Zips"
LANG_ZIPS_DIR = SCRIPT_DIR / "ZipsLang"
USM_DIR = SCRIPT_DIR / "Usms"
BYTECODE_DIR = SCRIPT_DIR / "Bytecode"
PAINTING_DIR = SCRIPT_DIR / "Paintings"

VERSION_API_URL = "https://version-amj.gtarcade.com/opinfo"
SILENT_UPGRADE_TEMPLATE = (
    "https://cdn-wx-studio.gtarcade.com/product-2013002/cdn1/"
    "upgrade_silent/#silent_version#/upgrade.config"
)
OP_GAME_ID = "3054"
OP_ID = "2173"
CHANNEL = "0"
USER_AGENT = "curl/7.52.1"
DEFAULT_JOBS = 8

UF_KEY = bytes([
    0x13, 0x5B, 0x0C, 0x0D, 0x66, 0x16, 0x22, 0x2B, 0x11, 0x19, 0x58, 0x40,
    0x24, 0x10, 0x0E, 0x42, 0x31, 0x57, 0x38, 0x2C, 0x35, 0x1C, 0x0B, 0x05,
    0x74, 0x25, 0x3A, 0x69, 0x14, 0x0F, 0x4D, 0x07, 0x1D,
])

XXTEA_KEY = b"2dxLua"
XXTEA_SIGN = b"XXTEA"
_XXTEA_DELTA = 0x9E3779B9
_XXTEA_MASK = 0xFFFFFFFF

console = Console()


def _xor_inplace(buf: bytearray, start: int, key: bytes, start_index: int) -> None:
    """对 buf[start:] 按周期 key 原地 XOR，只多分配 key 长度级的临时内存。"""
    n = len(buf) - start
    if n <= 0:
        return
    period = len(key)
    idx = start_index % period
    rot = key[idx:] + key[:idx]
    arr = np.ndarray(n, dtype=np.uint8, buffer=buf, offset=start)
    reps, rem = divmod(n, period)
    key_arr = np.frombuffer(rot, dtype=np.uint8)
    if reps:
        arr[: reps * period].reshape(reps, period)[...] ^= key_arr
    if rem:
        arr[reps * period :] ^= key_arr[:rem]


def decrypt_uf(data: bytes) -> bytes | bytearray:
    """cocos2d::FileUtils::decryptUF 的 Python 移植。"""
    n = len(data)
    if n <= 3 or data[0] != 0x55 or data[1] != 0x46:
        return data
    if data[2] == 0x4F:
        v8, v9, v6, v7 = 1, 4, 5, 6
    else:
        v8, v9, v6, v7 = 0, 2, 3, 4
    v10 = data[v6]
    if v10 == 1:
        start = v9 + 3
        if n <= start:
            return b""
        buf = bytearray(data[start:])
        _xor_inplace(buf, 0, UF_KEY, data[v7] % 33)
        return buf
    if v10 == 2:
        start = v9 + 3
        if n <= start:
            return b""
        v13 = n - start
        v21 = data[v7]
        out = bytearray(data[:v13])
        head = 7 if v9 == 4 else 5
        for i in range(head):
            idx = v13 + i
            if idx >= n:
                break
            out[i] = data[idx] ^ UF_KEY[(v21 + i) % 33]
        b = min(95, v13 - start)
        k = v21 + start
        for i in range(b):
            out[start + i] ^= UF_KEY[(k + i) % 33]
        return out
    start = 7 if v8 else 5
    return data[start:] if n > start else b""


def _xxtea_words(data: bytes):
    n = (len(data) + 3) // 4
    b = data + b"\0" * (n * 4 - len(data))
    return list(struct.unpack(f"<{n}I", b))


def _xxtea_bytes(words, length=None):
    b = b"".join(struct.pack("<I", w & _XXTEA_MASK) for w in words)
    return b[:length] if length is not None else b


def _xxtea_mx(s, y, z, k, p, e):
    return (
        (((z >> 5) ^ (y << 2)) + ((y >> 3) ^ (z << 4)))
        ^ ((s ^ y) + (k[(p & 3) ^ e] ^ z))
    ) & _XXTEA_MASK


def _xxtea_decrypt_words(v, k):
    n = len(v)
    if n < 2:
        return v
    rounds = 6 + 52 // n
    s = (rounds * _XXTEA_DELTA) & _XXTEA_MASK
    y = v[0]
    z = v[n - 1]
    while s != 0:
        e = (s >> 2) & 3
        for p in range(n - 1, 0, -1):
            z = v[p - 1]
            v[p] = (v[p] - _xxtea_mx(s, y, z, k, p, e)) & _XXTEA_MASK
            y = v[p]
        z = v[n - 1]
        v[0] = (v[0] - _xxtea_mx(s, y, z, k, 0, e)) & _XXTEA_MASK
        y = v[0]
        s = (s - _XXTEA_DELTA) & _XXTEA_MASK
    return v


def xxtea_decrypt(data: bytes, key: bytes = XXTEA_KEY) -> bytes:
    """标准 XXTEA（带明文长度前缀），与 cocos2d-x xxtea.c 一致。"""
    if len(data) < 8:
        return b""
    k = (_xxtea_words(key) + [0] * 4)[:4]
    v = _xxtea_decrypt_words(_xxtea_words(data), k)
    length = v[0]
    return _xxtea_bytes(v[1:], length)


def decrypt_bytes(data: bytes) -> bytes:
    if data.startswith(XXTEA_SIGN):
        dec = xxtea_decrypt(data[len(XXTEA_SIGN):])
        if dec.startswith(b"\xef\xbb\xbf"):
            dec = dec[3:]
        return dec
    if data.startswith(b"UF"):
        return decrypt_uf(data)
    return data


def decompress_ccz(ccz_data: bytes) -> bytes:
    return zlib.decompress(ccz_data[16:])


def ccz_to_png(data: bytes):
    """把 CCZ! 压缩的 PVR(ETC2) 转成 PIL Image；缺库时返回 None。"""
    if not data.startswith(b"CCZ!"):
        return None
    try:
        from texture2ddecoder import decode_etc2a8
        from PIL import Image
    except ImportError:
        return None
    try:
        pvr = decompress_ccz(data)
        h = struct.unpack("<IQIIIIIIIII", pvr[4:52])
        flags, _, _, _, height, width, _, _, _, _, metadata_size = h
        pixels = decode_etc2a8(pvr[52 + metadata_size:], width, height)
        arr = np.frombuffer(pixels, dtype=np.uint8).reshape(-1, 4).copy()
        arr[:, [0, 2]] = arr[:, [2, 0]]
        if flags & 0x02:
            a = arr[:, 3]
            nz = a > 0
            if nz.any():
                rgb = arr[nz, :3].astype(np.uint16) * 255
                arr[nz, :3] = np.minimum(255, rgb // a[nz, None]).astype(np.uint8)
            arr[~nz, :3] = 0
        return Image.fromarray(arr.reshape(height, width, 4), "RGBA")
    except Exception:
        return None


def restore_luajit(data: bytes) -> bytes:
    """把绯红神约魔改头还原成标准 LuaJIT 2.1，并清掉 prototype 的 NOJIT 位。"""
    if data[:3] != b"\x1bLJ":
        raise ValueError("not luajit bytecode")
    if len(data) < 7 or data[3] != 0xCC or data[4] != 0xFF or data[5] != 0x02:
        raise ValueError("unexpected luajit header")
    out = bytearray(data[:3] + b"\x02" + data[6:])
    off = 5
    n = len(out)
    while off < n:
        length, off = _read_uleb(out, off)
        if length == 0:
            break
        if off + length > n:
            raise ValueError(f"prototype block overrun at {off}")
        out[off] &= 0x07
        off += length
    return bytes(out)


def to_standard_luajit(data: bytes) -> bytes:
    """解密后若是绯红魔改头则还原；已是标准 2.1 dump 则原样返回。"""
    raw = decrypt_bytes(data)
    if raw[:3] != b"\x1bLJ":
        raise ValueError("not luajit bytecode")
    if len(raw) >= 6 and raw[3] == 0xCC and raw[4] == 0xFF:
        return restore_luajit(raw)
    if len(raw) >= 4 and raw[3] == 0x02:
        return raw
    raise ValueError(f"unexpected luajit version byte {raw[3]:#x}")


def _read_uleb(data: bytes, off: int):
    n = 0
    shift = 0
    while True:
        b = data[off]
        off += 1
        n |= (b & 0x7F) << shift
        if not (b & 0x80):
            return n, off
        shift += 7


def get_latest_server_version(session: requests.Session) -> int | None:
    try:
        url = (
            f"{VERSION_API_URL}?opGameId={OP_GAME_ID}&opId={OP_ID}"
            f"&channel={CHANNEL}&md5="
        )
        info = session.get(url, timeout=60).json()
        return int(info["config"]["version_no"])
    except Exception:
        return None


def resolve_version(args, session: requests.Session):
    """返回 (version, source)。优先 --version，否则 opinfo 的 version_no。"""
    if getattr(args, "version", None):
        return str(args.version), "cli"
    latest = get_latest_server_version(session)
    if latest:
        return str(latest), "opinfo"
    return None, "none"


_GAME_VERSION_RE = re.compile(rb"GAME_VERSION_NO\s*=\s*(\d+)")
_SILENT_CONFIG_NAMES = ("src/64bit/config.lua", "src/config.lua")


def _parse_game_version(data: bytes) -> str | None:
    try:
        text = decrypt_bytes(data)
        if isinstance(text, bytearray):
            text = bytes(text)
        m = _GAME_VERSION_RE.search(text if isinstance(text, bytes) else text.encode())
        return m.group(1).decode() if m else None
    except Exception:
        return None


_silent_cfg_cache: dict[str, dict] = {}


def fetch_silent_config(session: requests.Session, version: str) -> dict | None:
    cached = _silent_cfg_cache.get(version)
    if cached is not None:
        return cached
    url = SILENT_UPGRADE_TEMPLATE.replace("#silent_version#", version)
    r = session.get(url, timeout=120)
    if r.status_code != 200:
        return None
    try:
        cfg = r.json()
    except Exception:
        return None
    if version not in cfg:
        return None
    _silent_cfg_cache[version] = cfg
    return cfg


def resolve_silent_version(session: requests.Session) -> tuple[str | None, str]:
    """静默包目录用安装包 GAME_VERSION_NO，不是热更 version_no。"""
    for p in (
        SCRIPT_DIR / "MasterData" / "64bit" / "config.lua",
        SCRIPT_DIR / "MasterData" / "config.lua",
        ASSETS_DIR / "src" / "64bit" / "config.lua",
        ASSETS_DIR / "src" / "config.lua",
    ):
        if p.exists():
            ver = _parse_game_version(p.read_bytes())
            if ver and fetch_silent_config(session, ver):
                return ver, str(p.relative_to(SCRIPT_DIR))
    if ZIPS_DIR.exists():
        zips = sorted(
            ZIPS_DIR.glob("*.zip"),
            key=lambda p: (0 if p.stat().st_size < 8 * 1024 * 1024 else 1, p.name),
        )
        for zp in zips:
            try:
                with zipfile.ZipFile(zp) as z:
                    names = set(z.namelist())
                    for name in _SILENT_CONFIG_NAMES:
                        if name not in names:
                            continue
                        ver = _parse_game_version(z.read(name))
                        if ver and fetch_silent_config(session, ver):
                            return ver, f"zip:{zp.name}"
            except Exception:
                continue
    return None, "none"



def get_session() -> requests.Session:
    s = requests.Session()
    s.headers["User-Agent"] = USER_AGENT
    s.headers["Accept"] = "*/*"
    s.headers["Accept-Encoding"] = "identity"
    return s


def _file_md5(path: Path) -> str:
    h = hashlib.md5()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def _cdn_urls(base_url: str, rel: str) -> list[str]:
    primary = base_url.rstrip("/") + "/" + rel
    alt_host = {
        "res-wx-studio.gtarcade.com": "cdn-wx-studio.gtarcade.com",
        "cdn-wx-studio.gtarcade.com": "res-wx-studio.gtarcade.com",
    }
    urls = [primary]
    for old, new in alt_host.items():
        if old in base_url:
            alt = base_url.replace(old, new).rstrip("/") + "/" + rel
            if alt != primary:
                urls.append(alt)
            break
    return urls


def fetch_upgrade_config(session: requests.Session) -> dict:
    url = (
        f"{VERSION_API_URL}?opGameId={OP_GAME_ID}&opId={OP_ID}"
        f"&channel={CHANNEL}&md5="
    )
    console.print(f"[cyan]获取版本配置:[/cyan] {VERSION_API_URL}")
    info = session.get(url, timeout=60).json()
    cfg_url = info["config"]["android_upgrade_config"]
    console.print(f"[cyan]upgrade.config:[/cyan] {cfg_url}")
    r = session.get(cfg_url, timeout=120)
    r.raise_for_status()
    return r.json()


def collect_zips(cfg: dict, version: str | None, all_zips: bool):
    versions = cfg.get("versions", {})
    if all_zips or not version:
        seen = {}
        for items in versions.values():
            for item in items:
                seen[item["url"]] = item
        items = list(seen.values())
    else:
        items = list(versions.get(str(version), []))
    if not items:
        raise SystemExit(f"version {version} 不在 upgrade.config 中")

    def sort_key(item):
        m = re.match(r"(\d+)_", item["url"].rsplit("/", 1)[-1])
        return int(m.group(1)) if m else 0

    items.sort(key=sort_key)
    return items



def _download_curl(url: str, tmp: Path, size: int, progress_cb=None) -> None:
    """对齐 UFDownloaderImpl::performDownload 的 libcurl 选项，单连接 + 续传。"""
    existing = tmp.stat().st_size if tmp.exists() else 0
    if existing > size:
        tmp.unlink()
        existing = 0
    if existing == size:
        return

    cmd = [
        "curl",
        "-fL",
        "--silent",
        "--show-error",
        "--http1.1",
        "--max-redirs", "5",
        "--speed-limit", "1",
        "--speed-time", "5",
        "--connect-timeout", "30",
        "-A", USER_AGENT,
        "-o", str(tmp),
    ]
    if existing:
        cmd.extend(["-C", str(existing)])
    cmd.extend(["--", url])

    proc = subprocess.Popen(
        cmd, stdout=subprocess.DEVNULL, stderr=subprocess.PIPE, text=True
    )
    reported = existing
    try:
        while True:
            ret = proc.poll()
            now = tmp.stat().st_size if tmp.exists() else reported
            if progress_cb and now > reported:
                progress_cb(now - reported)
                reported = now
            if ret is not None:
                break
            time.sleep(0.2)
        err = proc.stderr.read() if proc.stderr else ""
        if ret != 0:
            raise RuntimeError((err or f"curl exit {ret}").strip())
        now = tmp.stat().st_size if tmp.exists() else reported
        if progress_cb and now > reported:
            progress_cb(now - reported)
    except BaseException:
        if proc.poll() is None:
            proc.kill()
            proc.wait()
        raise


def _download_requests(
    session: requests.Session,
    url: str,
    tmp: Path,
    size: int,
    progress_cb=None,
) -> None:
    """curl 不可用时的回退：同样单连接、只在续传时带 Range。"""
    existing = tmp.stat().st_size if tmp.exists() else 0
    if existing > size:
        tmp.unlink()
        existing = 0
    if existing == size:
        return
    headers = {}
    if existing:
        headers["Range"] = f"bytes={existing}-"
    last_data = time.time()
    with session.get(url, stream=True, timeout=(30, 30), headers=headers) as r:
        if r.status_code == 416:
            if existing >= size:
                return
            raise ValueError("416 range error")
        r.raise_for_status()
        if r.status_code == 206:
            mode = "ab"
        else:
            if existing:
                tmp.unlink()
                existing = 0
            mode = "wb"
        wrote = existing
        with open(tmp, mode) as f:
            for chunk in r.iter_content(1 << 20):
                if not chunk:
                    if time.time() - last_data >= 5:
                        raise TimeoutError("stalled 5s")
                    continue
                f.write(chunk)
                wrote += len(chunk)
                last_data = time.time()
                if progress_cb:
                    progress_cb(len(chunk))
                if wrote >= size:
                    break
    if wrote != size:
        raise ValueError(f"size mismatch {wrote} != {size}")


def _download_file(
    session: requests.Session,
    url: str,
    tmp: Path,
    size: int,
    progress_cb=None,
) -> None:
    if shutil.which("curl"):
        _download_curl(url, tmp, size, progress_cb)
    else:
        _download_requests(session, url, tmp, size, progress_cb)


def download_zip(
    session: requests.Session,
    base_url: str,
    item: dict,
    dest: Path,
    progress_cb=None,
):
    size = item["size"]
    if dest.exists() and dest.stat().st_size == size and _file_md5(dest) == item["md5"]:
        return "skip"
    if dest.exists():
        dest.unlink()

    tmp = dest.with_suffix(dest.suffix + ".part")
    if tmp.parent.exists():
        prefix = tmp.name + ".s"
        for old in tmp.parent.iterdir():
            if old.name.startswith(prefix):
                old.unlink(missing_ok=True)

    urls = _cdn_urls(base_url, item["url"])
    last_err: Exception | None = None
    for attempt in range(3):
        for url in urls:
            try:
                _download_file(session, url, tmp, size, progress_cb)
                if tmp.exists() and tmp.stat().st_size == size and _file_md5(tmp) == item["md5"]:
                    os.replace(tmp, dest)
                    return "ok"
                last_err = ValueError("size/md5 mismatch")
                tmp.unlink(missing_ok=True)
            except Exception as e:
                last_err = e
                if tmp.exists() and "range" in str(e).lower():
                    tmp.unlink()
        if attempt < 2:
            time.sleep(min(2 ** attempt, 8))
    if last_err:
        raise last_err
    raise RuntimeError("download failed")


def is_encrypted_file(path: Path) -> bool:
    try:
        with open(path, "rb") as f:
            head = f.read(5)
    except OSError:
        return False
    return head.startswith(b"UF") or head.startswith(XXTEA_SIGN)


def is_luajit_file(path: Path) -> bool:
    try:
        with open(path, "rb") as f:
            return f.read(3) == b"\x1bLJ"
    except OSError:
        return False


def _safe_zip_dest(dest_dir: Path, name: str) -> Path | None:
    name = name.replace("\\", "/").lstrip("/")
    if not name or name.endswith("/"):
        return None
    parts = name.split("/")
    if any(p in ("", "..") for p in parts):
        return None
    return dest_dir.joinpath(*parts)


def extract_zip_incremental(zip_path: Path, dest_dir: Path, force: bool = False):
    """已存在且未再加密的文件不覆盖。返回 (写入, 跳过)。"""
    wrote = skipped = 0
    with zipfile.ZipFile(zip_path) as z:
        for info in z.infolist():
            dest = _safe_zip_dest(dest_dir, info.filename)
            if dest is None:
                continue
            if dest.exists() and not force:
                skipped += 1
                continue
            dest.parent.mkdir(parents=True, exist_ok=True)
            with z.open(info) as src, open(dest, "wb") as out:
                shutil.copyfileobj(src, out)
            wrote += 1
    return wrote, skipped


def extract_zip_list(zip_paths, dest_dir: Path, force: bool = False):
    wrote = skipped = 0
    for zp in zip_paths:
        if not zp.exists():
            continue
        try:
            w, s = extract_zip_incremental(zp, dest_dir, force)
            wrote += w
            skipped += s
        except Exception as e:
            console.print(f"[red]解压失败 {zp.name}: {e}[/red]")
    return wrote, skipped


def extract_zip_members(zip_path: Path, dest_dir: Path, predicate, force: bool = False):
    """只解压满足 predicate 的成员。已存在且未 --force 则跳过。"""
    wrote = skipped = 0
    with zipfile.ZipFile(zip_path) as z:
        for info in z.infolist():
            name = info.filename.replace("\\", "/")
            if not predicate(name):
                continue
            dest = _safe_zip_dest(dest_dir, name)
            if dest is None:
                continue
            if dest.exists() and not force:
                skipped += 1
                continue
            dest.parent.mkdir(parents=True, exist_ok=True)
            with z.open(info) as src, open(dest, "wb") as out:
                shutil.copyfileobj(src, out)
            wrote += 1
    return wrote, skipped


def cmd_update(args):
    session = get_session()
    cfg = fetch_upgrade_config(session)
    version, source = resolve_version(args, session)
    if version and version in cfg.get("versions", {}) and not args.all:
        items = collect_zips(cfg, version, False)
        console.print(f"[cyan]使用版本 {version}（来源: {source}）[/cyan]")
    else:
        items = collect_zips(cfg, None, True)
        if version:
            console.print(
                f"[yellow]最新版本 {version} 不是增量起点，改为下载全量 zip[/yellow]"
            )
        elif not args.all:
            console.print("[yellow]未获取到版本号，改为下载全量 zip[/yellow]")
    base_url = cfg.get("upgrade_url2") or cfg["upgrade_url"]
    total = sum(i["size"] for i in items)
    silent_total = None
    silent_version, silent_source = (None, "none")
    if not getattr(args, "no_silent", False):
        silent_version, silent_source = resolve_silent_version(session)
        if silent_version:
            scfg = fetch_silent_config(session, silent_version)
            if scfg:
                silent_total = sum(
                    i["size"] for i in scfg.get(str(silent_version), [])
                )
    console.print(
        f"[cyan]待下载 {len(items)} 个 zip / {total / 1024 ** 3:.2f} GB"
        f"（{args.jobs} 线程）[/cyan]"
    )
    if silent_total:
        console.print(
            f"[cyan]含静默包合计 {total / 1024 ** 3 + silent_total / 1024 ** 3:.2f} GB"
            f"（主热更 + 静默包）[/cyan]"
        )
    ZIPS_DIR.mkdir(parents=True, exist_ok=True)
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    if not getattr(args, "no_silent", False):
        if silent_version:
            console.print(
                f"[yellow]主热更完成后下载静默包（安装包版本 {silent_version}）[/yellow]"
            )
        else:
            console.print(
                "[yellow]主热更完成后会从 config.lua 解析安装包版本再下静默包[/yellow]"
            )

    stats = {"ok": 0, "skip": 0, "fail": 0}
    failures = {}
    lock = threading.Lock()
    done = [0]
    total_bytes = sum(i["size"] for i in items)
    progress = Progress(
        SpinnerColumn(),
        TextColumn("{task.description}"),
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.1f}%",
        TextColumn("•"),
        TotalFileSizeColumn(),
        TextColumn("•"),
        TransferSpeedColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
        console=console,
        transient=True,
    )

    def worker(item):
        name = item["url"].rsplit("/", 1)[-1]
        dest = ZIPS_DIR / name

        def cb(n):
            with lock:
                progress.advance(task, n)

        try:
            state = download_zip(session, base_url, item, dest, progress_cb=cb)
            if state == "skip":
                with lock:
                    progress.advance(task, item["size"])
            with lock:
                done[0] += 1
                progress.update(
                    task,
                    description=f"[cyan]下载 {done[0]}/{len(items)} 文件[/cyan]",
                )
            return state, dest
        except Exception as e:
            with lock:
                failures[item["url"]] = str(e)
                done[0] += 1
                progress.update(
                    task,
                    description=f"[cyan]下载 {done[0]}/{len(items)} 文件[/cyan]",
                )
            return "fail", None

    with progress:
        task = progress.add_task(
            f"[cyan]下载 0/{len(items)} 文件", total=total_bytes
        )
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futs = [pool.submit(worker, it) for it in items]
            for fut in as_completed(futs):
                state, _ = fut.result()
                stats[state] += 1

    if failures:
        (SCRIPT_DIR / "update_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures.items()), encoding="utf-8"
        )

    console.print(
        f"[bold green]下载完成[/bold green] 新下载 {stats['ok']}，跳过 {stats['skip']}，"
        f"失败 {stats['fail']}"
    )

    force = getattr(args, "force", False)
    console.print("[cyan]解压到 Assets/ ...[/cyan]")
    zip_paths = [ZIPS_DIR / item["url"].rsplit("/", 1)[-1] for item in items]
    wrote, skipped = extract_zip_list(zip_paths, ASSETS_DIR, force)
    console.print(
        f"[bold green]完成[/bold green] 写入 {wrote}，跳过已有 {skipped} → {ASSETS_DIR}"
    )
    if not getattr(args, "no_silent", False):
        if not silent_version:
            silent_version, silent_source = resolve_silent_version(session)
        if silent_version:
            console.print(
                f"[cyan]静默包版本 {silent_version}（来源: {silent_source}）[/cyan]"
            )
            try:
                download_silent_packages(
                    session, silent_version, args.jobs, force=force
                )
            except (SystemExit, Exception) as e:
                console.print(f"[yellow]跳过静默包: {e}[/yellow]")
        else:
            console.print(
                "[yellow]未解析到安装包 GAME_VERSION_NO，跳过静默包[/yellow]"
            )
    if not getattr(args, "no_decrypt", False):
        console.print("[cyan]解密 Assets/ ...[/cyan]")
        dec_args = argparse.Namespace(
            paths=[str(ASSETS_DIR)],
            lua_only=False,
            no_images=False,
            jobs=args.jobs,
        )
        cmd_decrypt(dec_args)
    if not getattr(args, "no_decompile", False):
        src_dir = ASSETS_DIR / "src"
        if src_dir.exists():
            console.print("[cyan]转换数据表（还原+反编译 Assets/src）...[/cyan]")
            files = [p for p in src_dir.rglob("*.lua") if p.is_file()]
            decompile_inplace(files, args.jobs)


def download_silent_packages(
    session: requests.Session, version: str, jobs: int, force: bool = False
):
    url = SILENT_UPGRADE_TEMPLATE.replace("#silent_version#", version)
    console.print(f"[cyan]静默包版本 {version}，配置:[/cyan] {url}")
    cfg = fetch_silent_config(session, version)
    if not cfg:
        raise SystemExit(
            f"静默包配置无效（版本 {version}）。请确认这是安装包 GAME_VERSION_NO"
        )
    key = str(version)
    items = list(cfg[key])
    base_url = cfg.get("upgrade_url2") or cfg["upgrade_url"]
    total = sum(i["size"] for i in items)
    console.print(
        f"[cyan]静默包 {len(items)} 个 zip / {total / 1024 ** 3:.2f} GB"
        f"（{jobs} 线程）[/cyan]"
    )
    zip_dir = SCRIPT_DIR / "ZipsSilent"
    zip_dir.mkdir(parents=True, exist_ok=True)
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)

    stats = {"ok": 0, "skip": 0, "fail": 0}
    failures = {}
    lock = threading.Lock()
    done = [0]
    progress = Progress(
        SpinnerColumn(),
        TextColumn("{task.description}"),
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.1f}%",
        TextColumn("•"),
        TotalFileSizeColumn(),
        TextColumn("•"),
        TransferSpeedColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
        console=console,
        transient=True,
    )

    def worker(item):
        name = item["name"]
        dest = zip_dir / name
        fake = {"url": name, "size": item["size"], "md5": item["md5"]}

        def cb(n):
            with lock:
                progress.advance(task, n)

        try:
            state = download_zip(
                session,
                base_url.replace("#silent_version#", version),
                fake,
                dest,
                progress_cb=cb,
            )
            if state == "skip":
                with lock:
                    progress.advance(task, item["size"])
            with lock:
                done[0] += 1
                progress.update(
                    task,
                    description=f"[cyan]下载静默包 {done[0]}/{len(items)} 文件[/cyan]",
                )
            return state, dest
        except Exception as e:
            with lock:
                failures[name] = str(e)
                done[0] += 1
                progress.update(
                    task,
                    description=f"[cyan]下载静默包 {done[0]}/{len(items)} 文件[/cyan]",
                )
            return "fail", None

    with progress:
        task = progress.add_task(
            f"[cyan]下载静默包 0/{len(items)} 文件", total=total
        )
        with ThreadPoolExecutor(max_workers=jobs) as pool:
            futs = [pool.submit(worker, it) for it in items]
            for fut in as_completed(futs):
                state, _ = fut.result()
                stats[state] += 1

    if failures:
        (SCRIPT_DIR / "silent_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures.items()), encoding="utf-8"
        )
    console.print(
        f"[bold green]静默包下载完成[/bold green] 新下载 {stats['ok']}，"
        f"跳过 {stats['skip']}，失败 {stats['fail']}"
    )

    console.print("[cyan]解压到 Assets/ ...[/cyan]")
    zip_paths = [zip_dir / item["name"] for item in items]
    wrote, skipped = extract_zip_list(zip_paths, ASSETS_DIR, force)
    console.print(
        f"[bold green]完成[/bold green] 写入 {wrote}，跳过已有 {skipped} → {ASSETS_DIR}"
    )


def cmd_silent(args):
    session = get_session()
    version = getattr(args, "version", None)
    source = "cli"
    if version:
        if not fetch_silent_config(session, str(version)):
            raise SystemExit(f"静默包配置无效（版本 {version}）")
        version = str(version)
    else:
        version, source = resolve_silent_version(session)
    if not version:
        raise SystemExit("未解析到安装包 GAME_VERSION_NO；请使用 --version")
    console.print(f"[cyan]静默包版本 {version}（来源: {source}）[/cyan]")
    download_silent_packages(session, version, args.jobs)



def collect_files(paths, lua_only, encrypted_only=False):
    files = []
    for t in paths:
        p = Path(t)
        if p.is_dir():
            cand = [
                x for x in p.rglob("*")
                if x.is_file() and (not lua_only or x.suffix.lower() == ".lua")
            ]
        elif p.is_file() and (not lua_only or p.suffix.lower() == ".lua"):
            cand = [p]
        else:
            cand = []
        if encrypted_only:
            cand = [x for x in cand if is_encrypted_file(x)]
        files += cand
    return sorted(set(files))


def process_file(path: Path, convert_images: bool) -> str:
    with open(path, "rb") as f:
        head = f.read(5)
        if not (head.startswith(b"UF") or head.startswith(XXTEA_SIGN)):
            return "plain"
        data = head + f.read()
    dec = decrypt_bytes(data)
    if dec == data:
        return "plain"
    tmp = path.with_name(path.name + ".tmp")
    if dec.startswith(b"CCZ!") and convert_images:
        img = ccz_to_png(dec)
        if img is not None:
            try:
                img.save(tmp, format="PNG")
                os.replace(tmp, path)
                return "png"
            finally:
                tmp.unlink(missing_ok=True)
    try:
        tmp.write_bytes(dec)
        os.replace(tmp, path)
    finally:
        tmp.unlink(missing_ok=True)
    return "dec"


def write_atomic(path: Path, data: bytes):
    """先写同目录 .tmp，再覆盖目标，最后清理临时文件。"""
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_name(path.name + ".tmp")
    try:
        tmp.write_bytes(data)
        os.replace(tmp, path)
    finally:
        tmp.unlink(missing_ok=True)


def _decrypt_worker_batch(paths: list[str], convert_images: bool):
    stats = {"dec": 0, "png": 0, "plain": 0, "fail": 0}
    failures = []
    for p in paths:
        try:
            stats[process_file(Path(p), convert_images)] += 1
        except Exception as e:
            stats["fail"] += 1
            failures.append(f"{p}\t{e}")
    return stats, failures


def cmd_decrypt(args):
    targets = args.paths or [str(ASSETS_DIR)]
    files = collect_files(targets, args.lua_only, encrypted_only=True)
    if not files:
        console.print("[green]没有待解密文件，跳过[/green]")
        return
    console.print(f"[cyan]待解密 {len(files)} 个文件[/cyan]")
    stats = {"dec": 0, "png": 0, "plain": 0, "fail": 0}
    failures = {}
    progress = Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.1f}%",
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
        console=console,
        transient=True,
    )
    chunk = max(64, (len(files) + args.jobs * 8 - 1) // (args.jobs * 8)) if files else 64
    batches = [
        [str(p) for p in files[i:i + chunk]]
        for i in range(0, len(files), chunk)
    ]

    with progress:
        task = progress.add_task("[cyan]解密", total=len(files))
        mp_ctx = multiprocessing.get_context("fork")
        with ProcessPoolExecutor(max_workers=args.jobs, mp_context=mp_ctx) as pool:
            futs = [
                pool.submit(_decrypt_worker_batch, batch, not args.no_images)
                for batch in batches
            ]
            for fut in as_completed(futs):
                try:
                    part, errs = fut.result()
                    for k, v in part.items():
                        stats[k] += v
                    for line in errs:
                        path, _, msg = line.partition("\t")
                        failures[path] = msg
                    progress.advance(task, part["dec"] + part["png"] + part["plain"] + part["fail"])
                except Exception as e:
                    stats["fail"] += 1
                    failures["batch"] = str(e)
                    progress.advance(task)
    if failures:
        (SCRIPT_DIR / "decrypt_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures.items()), encoding="utf-8"
        )
    console.print(
        f"[bold green]完成[/bold green] 解密 {stats['dec']}，转图 {stats['png']}，"
        f"跳过 {stats['plain']}，失败 {stats['fail']}"
    )


def cmd_lua(args):
    out_dir = SCRIPT_DIR / "MasterData"
    out_dir.mkdir(parents=True, exist_ok=True)
    stats = {"hot": 0, "fail": 0}
    failures = {}

    session = get_session()
    cfg = fetch_upgrade_config(session)
    version, source = resolve_version(args, session)
    if version and version in cfg.get("versions", {}) and not getattr(args, "all", False):
        items = collect_zips(cfg, version, False)
        console.print(f"[cyan]热更版本 {version}（来源: {source}）[/cyan]")
    else:
        items = collect_zips(cfg, None, True)
        if version and not getattr(args, "all", False):
            console.print(
                f"[yellow]版本 {version} 不是增量起点，改为下载全量热更 zip[/yellow]"
            )
        else:
            console.print("[cyan]下载全量热更 zip[/cyan]")
    base_url = cfg.get("upgrade_url2") or cfg["upgrade_url"]
    ZIPS_DIR.mkdir(parents=True, exist_ok=True)
    total = sum(i["size"] for i in items)
    console.print(
        f"[cyan]下载 {len(items)} 个热更 zip / {total / 1024 ** 3:.2f} GB，"
        f"仅提取 src/*.lua[/cyan]"
    )

    progress = Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.1f}%",
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
        console=console,
        transient=True,
    )
    lock = threading.Lock()

    def dl(item):
        dest = ZIPS_DIR / item["url"].rsplit("/", 1)[-1]
        try:
            download_zip(session, base_url, item, dest)
            with lock:
                progress.advance(task)
            return dest
        except Exception as e:
            with lock:
                failures[item["url"]] = str(e)
                progress.advance(task)
            return None

    with progress:
        task = progress.add_task("[cyan]下载热更 zip", total=len(items))
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futs = [pool.submit(dl, it) for it in items]
            for fut in as_completed(futs):
                fut.result()

    console.print("[cyan]提取热更 Lua...[/cyan]")
    hot_paths = []
    for item in items:
        zip_path = ZIPS_DIR / item["url"].rsplit("/", 1)[-1]
        if not zip_path.exists():
            continue
        try:
            with zipfile.ZipFile(zip_path) as z:
                for name in z.namelist():
                    if not (name.startswith("src/") and name.endswith(".lua")):
                        continue
                    rel = name[len("src/"):]
                    try:
                        dec = decrypt_bytes(z.read(name))
                    except Exception as e:
                        failures[f"hot:{name}"] = str(e)
                        stats["fail"] += 1
                        continue
                    dest = out_dir / rel
                    write_atomic(dest, dec)
                    hot_paths.append(dest)
                    stats["hot"] += 1
        except Exception as e:
            failures[zip_path.name] = str(e)
            stats["fail"] += 1
    if hot_paths and not getattr(args, "no_decompile", False):
        console.print("[cyan]热更 Lua 提取完成，开始转换...[/cyan]")
        decompile_inplace(hot_paths, args.jobs)

    if failures:
        (SCRIPT_DIR / "lua_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures.items()), encoding="utf-8"
        )
    console.print(
        f"[bold green]完成[/bold green] 热更 Lua {stats['hot']}，"
        f"失败 {stats['fail']} -> {out_dir}"
    )


def cmd_restore(args):
    src = Path(args.src)
    dst = Path(args.dst)
    write_atomic(dst, restore_luajit(src.read_bytes()))
    console.print(f"[green]已还原[/green] {src} -> {dst}")


def run_decompile(src_dir: Path, out_dir: Path, only=None, jobs: int = DEFAULT_JOBS):
    decompiler = shutil.which("luajit-decompiler")
    if not decompiler:
        raise SystemExit("未找到系统 luajit-decompiler 命令")
    files = sorted(p for p in src_dir.rglob("*.lua") if p.is_file())
    if only:
        files = [p for p in files if any(k in str(p) for k in only)]
    console.print(f"[cyan]待反编译 {len(files)} 个文件 -> {out_dir}[/cyan]")
    stats = {"ok": 0, "skip": 0, "plain": 0, "fail": 0}
    failures = []

    def one(src: Path):
        rel = src.relative_to(src_dir)
        dest = out_dir / rel.with_suffix(".lua")
        if dest.exists():
            return "skip", rel
        if not src.read_bytes().startswith(b"\x1bLJ"):
            return "plain", rel
        try:
            restored = restore_luajit(src.read_bytes())
        except Exception as e:
            return "fail", (rel, str(e))
        with tempfile.TemporaryDirectory() as td:
            tmp = Path(td) / src.name
            tmp.write_bytes(restored)
            out_tmp = Path(td) / "out"
            out_tmp.mkdir()
            r = subprocess.run(
                [decompiler, str(tmp), "-o", str(out_tmp), "-f"],
                capture_output=True,
                text=True,
            )
            if r.returncode != 0:
                return "fail", (rel, (r.stderr or r.stdout)[-300:])
            produced = list(out_tmp.rglob("*.lua"))
            if not produced:
                return "fail", (rel, "no output")
            dest.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(produced[0], dest)
        return "ok", rel

    with ThreadPoolExecutor(max_workers=jobs) as pool:
        futs = [pool.submit(one, p) for p in files]
        for fut in as_completed(futs):
            state, info = fut.result()
            stats[state] += 1
            if state == "fail":
                failures.append((str(info[0]), info[1]))
    if failures:
        (SCRIPT_DIR / "decompile_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures), encoding="utf-8"
        )
    console.print(
        f"[bold green]完成[/bold green] 成功 {stats['ok']}，跳过 {stats['skip']}，"
        f"非字节码 {stats['plain']}，失败 {stats['fail']}"
    )


def decompile_inplace(paths, jobs: int = DEFAULT_JOBS):
    """把 Lua 目录里的字节码就地还原并反编译成源码。"""
    decompiler = shutil.which("luajit-decompiler")
    if not decompiler:
        raise SystemExit("未找到系统 luajit-decompiler 命令")
    paths = [p for p in paths if is_luajit_file(p)]
    if not paths:
        console.print("[green]没有待转换的 Lua 字节码，跳过[/green]")
        return
    stats = {"ok": 0, "plain": 0, "fail": 0}
    failures = {}
    progress = Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.1f}%",
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
        console=console,
        transient=True,
    )
    lock = threading.Lock()

    def one(path: Path):
        try:
            data = path.read_bytes()
            if not data.startswith(b"\x1bLJ"):
                return "plain"
            restored = restore_luajit(data)
            with tempfile.TemporaryDirectory() as td:
                tmp = Path(td) / path.name
                tmp.write_bytes(restored)
                out = Path(td) / "out"
                out.mkdir()
                r = subprocess.run(
                    [decompiler, str(tmp), "-o", str(out), "-f"],
                    capture_output=True,
                    text=True,
                )
                if r.returncode != 0:
                    raise RuntimeError((r.stderr or r.stdout)[-300:])
                produced = list(out.rglob("*.lua"))
                if not produced:
                    raise RuntimeError("no output")
                write_atomic(path, produced[0].read_bytes())
            with lock:
                progress.advance(task)
            return "ok"
        except Exception as e:
            with lock:
                failures[str(path)] = str(e)
                progress.advance(task)
            return "fail"

    with progress:
        task = progress.add_task("[cyan]转换 Lua", total=len(paths))
        with ThreadPoolExecutor(max_workers=jobs) as pool:
            futs = [pool.submit(one, p) for p in paths]
            for fut in as_completed(futs):
                stats[fut.result()] += 1
    if failures:
        (SCRIPT_DIR / "lua_convert_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures.items()), encoding="utf-8"
        )
    console.print(
        f"[bold green]转换完成[/bold green] 成功 {stats['ok']}，"
        f"非字节码 {stats['plain']}，失败 {stats['fail']}"
    )


def cmd_decompile(args):
    run_decompile(Path(args.src), Path(args.out), only=args.only, jobs=args.jobs)



_USM_FOURCC = {b"CRID", b"@SFV", b"@SFA", b"@SBT", b"@ALP", b"@CUE"}
_USM_SKIP_PREFIX = (b"@UTF", b"#HEA", b"#MET")


def _iter_usm_chunks(data: bytes):
    i = 0
    n = len(data)
    while i + 16 <= n:
        fourcc = data[i:i + 4]
        if fourcc not in _USM_FOURCC:
            break
        size = struct.unpack(">I", data[i + 4:i + 8])[0]
        header_size = data[i + 9]
        footer_size = data[i + 10]
        pad = data[i + 11]
        end = i + 8 + size
        if header_size < 8 or end > n or end - footer_size < i + header_size:
            break
        yield fourcc, pad, data[i + header_size:end - footer_size]
        i = end


def _usm_stream_bytes(payload: bytes, pad: int) -> bytes | None:
    if len(payload) < 8:
        return None
    body = payload[8:]
    if pad:
        if pad >= len(body):
            return None
        body = body[:-pad]
    return body


def _usm_collect_ivf(data: bytes, fourcc: bytes) -> tuple[bytes, list[bytes]]:
    header = b""
    frames: list[bytes] = []
    for fcc, pad, payload in _iter_usm_chunks(data):
        if fcc != fourcc:
            continue
        body = _usm_stream_bytes(payload, pad)
        if body is None:
            continue
        if body.startswith(_USM_SKIP_PREFIX):
            continue
        if body.startswith(b"DKIF"):
            header = body[:32]
            rest = body[32:]
            if len(rest) >= 12:
                fsz = struct.unpack_from("<I", rest)[0]
                if 12 + fsz <= len(rest):
                    frames.append(rest[:12 + fsz])
            continue
        if len(body) < 12:
            continue
        fsz = struct.unpack_from("<I", body)[0]
        if fsz < 1 or 12 + fsz > len(body):
            continue
        frames.append(body[:12 + fsz])
    return header, frames


def _usm_collect_mpeg(data: bytes, fourcc: bytes) -> bytes:
    parts: list[bytes] = []
    for fcc, pad, payload in _iter_usm_chunks(data):
        if fcc != fourcc:
            continue
        body = _usm_stream_bytes(payload, pad)
        if body is None or body.startswith(_USM_SKIP_PREFIX) or body.startswith(b"DKIF"):
            continue
        parts.append(body)
    return b"".join(parts)


def _usm_collect_audio(data: bytes) -> bytes:
    parts: list[bytes] = []
    for fcc, pad, payload in _iter_usm_chunks(data):
        if fcc != b"@SFA":
            continue
        body = _usm_stream_bytes(payload, pad)
        if body is None or body.startswith(_USM_SKIP_PREFIX):
            continue
        parts.append(body)
    return b"".join(parts)


def _usm_audio_suffix(audio: bytes) -> str | None:
    if audio.startswith(b"\x80\x00"):
        return ".adx"
    if audio.startswith(b"HCA\x00") or audio.startswith(b"\x13\x07"):
        return ".hca"
    return None


def _usm_rel_out(src: Path, out_root: Path) -> Path:
    try:
        rel = src.resolve().relative_to(ASSETS_DIR.resolve())
    except ValueError:
        rel = Path(src.name)
    return out_root / rel


def _ffmpeg_bin() -> str | None:
    return shutil.which("ffmpeg")


def _run_ffmpeg(args: list[str]) -> None:
    exe = _ffmpeg_bin()
    if not exe:
        raise RuntimeError("未找到 ffmpeg")
    cmd = [exe, "-y", "-hide_banner", "-loglevel", "error", *args]
    proc = subprocess.run(cmd, capture_output=True, text=True)
    if proc.returncode != 0:
        err = (proc.stderr or proc.stdout or "").strip() or f"exit {proc.returncode}"
        raise RuntimeError(err.splitlines()[-1][:240])


def _usm_write_audio(dest: Path, audio: bytes) -> Path | None:
    suffix = _usm_audio_suffix(audio) if audio else None
    if not suffix:
        return None
    path = dest.with_suffix(suffix)
    path.write_bytes(audio)
    return path


def _usm_mux_mp4(video: Path, audio: Path | None, mp4: Path, copy_video: bool) -> None:
    ff_in = ["-i", str(video)]
    vcodec = ["-c:v", "copy"] if copy_video else ["-c:v", "libx264", "-pix_fmt", "yuv420p", "-crf", "18"]
    if audio is not None:
        ff_in += ["-i", str(audio)]
        ff_out = vcodec + ["-c:a", "aac", "-b:a", "192k"]
    else:
        ff_out = vcodec + ["-an"]
    try:
        _run_ffmpeg(ff_in + ff_out + ["-movflags", "+faststart", str(mp4)])
    except Exception:
        if audio is None:
            raise
        _run_ffmpeg(["-i", str(video), *vcodec, "-an", "-movflags", "+faststart", str(mp4)])


def convert_usm_file(src: Path, dest: Path, fmt: str, keep_alpha: bool) -> str:
    data = src.read_bytes()
    if not data.startswith(b"CRID"):
        return "skip"
    dest.parent.mkdir(parents=True, exist_ok=True)
    header, frames = _usm_collect_ivf(data, b"@SFV")
    audio_path = _usm_write_audio(dest, _usm_collect_audio(data))
    temps: list[Path] = []

    if header and frames:
        video = dest.with_suffix(".ivf")
        video.write_bytes(header + b"".join(frames))
        if keep_alpha:
            a_hdr, a_frames = _usm_collect_ivf(data, b"@ALP")
            if a_hdr and a_frames:
                video.with_name(video.stem + "_alpha.ivf").write_bytes(
                    a_hdr + b"".join(a_frames)
                )
        if fmt == "ivf":
            return "ok"
        temps.append(video)
        _usm_mux_mp4(video, audio_path, dest.with_suffix(".mp4"), True)
    else:
        mpeg = _usm_collect_mpeg(data, b"@SFV")
        if not mpeg.startswith(b"\x00\x00\x01"):
            raise RuntimeError("没有可提取的视频流")
        video = dest.with_suffix(".m2v")
        video.write_bytes(mpeg)
        if keep_alpha:
            alpha = _usm_collect_mpeg(data, b"@ALP")
            if alpha.startswith(b"\x00\x00\x01"):
                video.with_name(video.stem + "_alpha.m2v").write_bytes(alpha)
        if fmt == "ivf":
            return "ok"
        temps.append(video)
        _usm_mux_mp4(video, audio_path, dest.with_suffix(".mp4"), False)

    for p in temps:
        p.unlink(missing_ok=True)
    if audio_path is not None:
        audio_path.unlink(missing_ok=True)
    return "ok"


def _usm_worker(src: str, dest: str, fmt: str, keep_alpha: bool, force: bool) -> str:
    dest_path = Path(dest)
    final = dest_path.with_suffix(".mp4" if fmt == "mp4" else ".ivf")
    if final.exists() and final.stat().st_size > 0 and not force:
        return "skip"
    return convert_usm_file(Path(src), dest_path, fmt, keep_alpha)


def cmd_usm(args):
    targets = args.paths or [str(ASSETS_DIR)]
    files = [
        p for p in collect_files(targets, False)
        if p.suffix.lower() == ".usm"
    ]
    out_root = Path(args.out)
    fmt = args.format
    if fmt == "mp4" and not _ffmpeg_bin():
        console.print("[yellow]未找到 ffmpeg，改为输出 ivf[/yellow]")
        fmt = "ivf"
    console.print(f"[cyan]待转换 {len(files)} 个 usm → {fmt}（{args.jobs} 线程）[/cyan]")
    stats = {"ok": 0, "skip": 0, "fail": 0}
    failures = {}
    progress = Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.1f}%",
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
        console=console,
        transient=True,
    )

    with progress:
        task = progress.add_task("[cyan]转换 USM", total=len(files))
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            fut_map = {}
            for src in files:
                dest = _usm_rel_out(src, out_root).with_suffix("")
                fut = pool.submit(
                    _usm_worker, str(src), str(dest), fmt, args.alpha, args.force
                )
                fut_map[fut] = src
            for fut in as_completed(fut_map):
                src = fut_map[fut]
                try:
                    stats[fut.result()] += 1
                except Exception as e:
                    stats["fail"] += 1
                    failures[str(src)] = str(e)
                progress.advance(task)

    if failures:
        (SCRIPT_DIR / "usm_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures.items()), encoding="utf-8"
        )
    console.print(
        f"[bold green]完成[/bold green] 转换 {stats['ok']}，跳过 {stats['skip']}，"
        f"失败 {stats['fail']}  输出 {out_root}"
    )


def _lj_header_flags(data: bytes) -> int | None:
    """标准 LuaJIT 2.1 dump：ESC L J + version + flags(uleb)。flags 通常一字节。"""
    if len(data) < 5 or data[:3] != b"\x1bLJ" or data[3] != 0x02:
        return None
    return data[4] & 0x7F


def cmd_bytecode(args):
    """从 zip 抽出 Lua，解密并写成标准 LuaJIT 2.1 字节码，供反编译器反复调试。"""
    src = Path(args.src) if args.src else ZIPS_DIR
    out_root = Path(args.out) if args.out else BYTECODE_DIR
    only = args.only or []
    force = args.force

    zips = sorted(src.glob("*.zip")) if src.is_dir() else ([src] if src.is_file() else [])
    if not zips:
        raise SystemExit(f"没有 zip：{src}")

    work = []
    for zp in zips:
        try:
            with zipfile.ZipFile(zp) as z:
                for info in z.infolist():
                    name = info.filename.replace("\\", "/")
                    if not name.lower().endswith(".lua"):
                        continue
                    if only and not any(k in name for k in only):
                        continue
                    dest = _safe_zip_dest(out_root, name)
                    if dest is None:
                        continue
                    work.append((str(zp), info.filename, dest.with_suffix(".lj")))
        except Exception as e:
            console.print(f"[red]读 zip 失败 {zp.name}: {e}[/red]")

    if not work:
        console.print("[green]没有匹配的 Lua 成员[/green]")
        return

    stats = {"ok": 0, "skip": 0, "plain": 0, "fail": 0}
    flags_count = {0x02: 0, 0x0A: 0, "other": 0, "nostrip": 0}
    failures = {}
    progress = Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.1f}%",
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
        console=console,
        transient=True,
    )
    lock = threading.Lock()

    def one(zip_path: str, member: str, dest: Path):
        if dest.exists() and not force:
            data = dest.read_bytes()
            return "skip", _lj_header_flags(data)
        with zipfile.ZipFile(zip_path) as z:
            data = z.read(member)
        raw = decrypt_bytes(data)
        if not raw.startswith(b"\x1bLJ"):
            return "plain", None
        restored = to_standard_luajit(raw)
        write_atomic(dest, restored)
        return "ok", _lj_header_flags(restored)

    with progress:
        task = progress.add_task("[cyan]导出字节码", total=len(work))
        with ThreadPoolExecutor(max_workers=args.jobs) as pool:
            futs = {pool.submit(one, zp, member, dest): dest for zp, member, dest in work}
            for fut in as_completed(futs):
                dest = futs[fut]
                try:
                    state, flags = fut.result()
                    with lock:
                        stats[state] += 1
                        if flags is not None:
                            if flags & 0x02:
                                if flags in flags_count:
                                    flags_count[flags] += 1
                                else:
                                    flags_count["other"] += 1
                            else:
                                flags_count["nostrip"] += 1
                except Exception as e:
                    with lock:
                        stats["fail"] += 1
                        failures[str(dest)] = str(e)
                progress.advance(task)

    if failures:
        (SCRIPT_DIR / "bytecode_failed.txt").write_text(
            "\n".join(f"{k}\t{v}" for k, v in failures.items()), encoding="utf-8"
        )
    console.print(
        f"[bold green]完成[/bold green] 写出 {stats['ok']}，跳过 {stats['skip']}，"
        f"非字节码 {stats['plain']}，失败 {stats['fail']}  输出 {out_root}"
    )
    console.print(
        f"  dump flags：STRIP {flags_count[0x02]}，"
        f"STRIP|FR2 {flags_count[0x0A]}，"
        f"其它 STRIP {flags_count['other']}，"
        f"未 STRIP {flags_count['nostrip']}"
    )


CFG_DIR = ASSETS_DIR / "src" / "app" / "core" / "config" / "cfg"
KNIGHT_BIG_DIR = ASSETS_DIR / "res" / "common" / "icon" / "knight_big"
PAINTING_LUA_STEMS = (
    "knight_base_info",
    "knight_base_info_2",
    "skin_info",
    "skin_info_2",
)
_KNIGHT_BIG_IN_ZIP = re.compile(r"(?:^|/)res/common/icon/knight_big/[^/]+\.(?:png|pvr|ccz)$", re.I)
_SAFE_FILENAME = re.compile(r'[\\/:*?"<>|\x00-\x1f]')
_KNIGHT_BASE_FIELDS = {
    "id": 1,
    "name": 2,
    "painted_id": 12,
    "icon_id": 15,
}
_SKIN_FIELDS = {
    "id": 1,
    "name": 2,
    "res": 13,
    "knight_advance_id": 17,
}


def _lua_unescape(raw: str) -> str:
    if "\\" not in raw:
        return raw
    out = []
    i = 0
    while i < len(raw):
        if raw[i] != "\\" or i + 1 >= len(raw):
            out.append(raw[i])
            i += 1
            continue
        nxt = raw[i + 1]
        mapping = {"n": "\n", "r": "\r", "t": "\t", '"': '"', "'": "'", "\\": "\\"}
        out.append(mapping.get(nxt, nxt))
        i += 2
    return "".join(out)


def _lua_tokenize(src: str):
    i, n = 0, len(src)
    while i < n:
        c = src[i]
        if c in " \t\r\n":
            i += 1
            continue
        if c == "-" and i + 1 < n and src[i + 1] == "-":
            i = src.find("\n", i)
            if i < 0:
                break
            continue
        if c in "'\"":
            q = c
            i += 1
            buf = []
            while i < n:
                if src[i] == "\\" and i + 1 < n:
                    buf.append(src[i : i + 2])
                    i += 2
                    continue
                if src[i] == q:
                    i += 1
                    break
                buf.append(src[i])
                i += 1
            yield "str", _lua_unescape("".join(buf))
            continue
        if c.isdigit() or (c == "-" and i + 1 < n and src[i + 1].isdigit()):
            m = re.match(r"-?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?", src[i:])
            lit = m.group()
            val = float(lit) if ("." in lit or "e" in lit.lower()) else int(lit)
            yield "num", val
            i += m.end()
            continue
        if c.isalpha() or c == "_":
            m = re.match(r"[A-Za-z_][A-Za-z0-9_]*", src[i:])
            yield "id", m.group()
            i += m.end()
            continue
        yield "sym", c
        i += 1


def _lua_parse_value(toks, i):
    t, v = toks[i]
    if t in ("num", "str"):
        return v, i + 1
    if t == "id" and v in ("true", "false", "nil"):
        return {"true": True, "false": False, "nil": None}[v], i + 1
    if t == "sym" and v == "{":
        return _lua_parse_table(toks, i + 1)
    raise ValueError(f"无法解析 Lua 值: {t} {v}")


def _lua_parse_table(toks, i):
    arr = []
    mapping = {}
    while i < len(toks):
        t, v = toks[i]
        if t == "sym" and v == "}":
            return (mapping if mapping and not arr else arr), i + 1
        if t == "sym" and v == ",":
            i += 1
            continue
        if t == "id" and i + 1 < len(toks) and toks[i + 1] == ("sym", "="):
            val, i = _lua_parse_value(toks, i + 2)
            mapping[v] = val
            continue
        val, i = _lua_parse_value(toks, i)
        arr.append(val)
    raise ValueError("Lua 表未闭合")


def _lua_return_table(text: str):
    toks = list(_lua_tokenize(text))
    for i, (t, v) in enumerate(toks):
        if t == "id" and v == "return":
            val, _ = _lua_parse_value(toks, i + 1)
            return val
    raise ValueError("文件没有 return 表")


def _lua_extract_defaults(text: str, nfields: int):
    toks = list(_lua_tokenize(text))
    i = 0
    while i + 4 < len(toks):
        if (
            toks[i] == ("id", "local")
            and toks[i + 1][0] == "id"
            and toks[i + 2] == ("sym", "=")
            and toks[i + 3] == ("sym", "{")
        ):
            val, j = _lua_parse_table(toks, i + 4)
            if isinstance(val, list) and len(val) == nfields:
                return val
            i = j
            continue
        i += 1
    raise ValueError(f"未找到长度为 {nfields} 的默认行")


def _decode_sparse_row(raw, defaults, nfields: int):
    nmask = math.ceil(nfields / 30)
    if len(raw) < nmask:
        return None
    values = raw[:-nmask]
    masks = raw[-nmask:]
    if any(not isinstance(m, int) for m in masks):
        return None
    out = []
    vi = 0
    for idx in range(1, nfields + 1):
        word = (idx - 1) // 30
        bit = idx % 30 or 30
        if masks[word] & (1 << (bit - 1)):
            if vi >= len(values):
                return None
            out.append(values[vi])
            vi += 1
        else:
            out.append(defaults[idx - 1])
    return out


def _cfg_record(row, defaults, nfields, fields):
    if not isinstance(row, list) or not row:
        return None
    decoded = _decode_sparse_row(row, defaults, nfields)
    if decoded is None:
        return None
    rec = {name: decoded[col - 1] for name, col in fields.items()}
    if not isinstance(rec.get("id"), int) or rec["id"] <= 0:
        return None
    return rec


def _iter_cfg_records(stem: str, nfields: int, fields):
    schema = CFG_DIR / f"{stem}.lua"
    data = CFG_DIR / f"{stem}_data.lua"
    if not schema.exists() or not data.exists():
        return
    defaults = _lua_extract_defaults(schema.read_text(encoding="utf-8"), nfields)
    rows = _lua_return_table(data.read_text(encoding="utf-8"))
    if not isinstance(rows, list):
        return
    for row in rows:
        rec = _cfg_record(row, defaults, nfields, fields)
        if rec:
            yield rec


def _lang_bin_dir(lang: str) -> Path:
    return (
        ASSETS_DIR
        / "res"
        / "language"
        / lang
        / "app"
        / "core"
        / "config"
        / "cfg"
        / "language_bins"
    )


def _hash64_lang(key: str) -> tuple[int, int]:
    h0, h1 = 3421674724, 2216829733
    for b in key.encode("utf-8"):
        h1 = (h1 ^ b) & 0xFFFFFFFF
        h0 = (
            h0 * 256
            + (h1 * 256 + h0 * 435 + (h1 * 435) // 4294967296) % 4294967296
        ) & 0xFFFFFFFF
        h1 = (h1 * 435) & 0xFFFFFFFF
    return h0, h1


def _fnv1a32(key: str) -> int:
    h = 2166136261
    for b in key.encode("utf-8"):
        h ^= b
        h = (h * 16777619) & 0xFFFFFFFF
    return h


def _lang_module_name(key: str) -> str:
    pos = key.find("_")
    if pos > 0:
        return key[:pos]
    if key.isdigit():
        return "numeric"
    return "misc"


def _lang_bin_name(key: str) -> str:
    module = _lang_module_name(key)
    if module.isdigit():
        n = int(module)
        start = ((n - 1) // 200) * 200 + 1
        return f"{start}-{start + 199}.bin"
    return f"{module}.bin"


class LangBins:
    """ConfigLang 的 language_bins 查询。"""

    def __init__(self, bin_dir: Path):
        self.bin_dir = bin_dir
        self._cache: dict[str, bytes] = {}

    def get(self, key) -> str | None:
        if not key or not isinstance(key, str):
            return None
        data = self._load(_lang_bin_name(key))
        if not data or len(data) < 14:
            return None
        count = struct.unpack_from("<I", data, 6)[0]
        data_off = struct.unpack_from("<I", data, 10)[0]
        h0, h1 = _hash64_lang(key)
        fnv = _fnv1a32(key)
        lo, hi = 0, count - 1
        while lo <= hi:
            mid = (lo + hi) // 2
            off = 14 + mid * 20
            if off + 20 > len(data):
                break
            eh0, eh1, efnv, val_off, val_len = struct.unpack_from("<IIIII", data, off)
            trip = (eh0, eh1, efnv)
            want = (h0, h1, fnv)
            if trip == want:
                start = data_off + val_off
                return data[start : start + val_len].decode("utf-8", "replace")
            if want < trip:
                hi = mid - 1
            else:
                lo = mid + 1
        return None

    def _load(self, name: str) -> bytes | None:
        cached = self._cache.get(name)
        if cached is not None:
            return cached
        path = self.bin_dir / name
        if not path.is_file():
            return None
        data = path.read_bytes()
        self._cache[name] = data
        return data


def _safe_painting_name(text: str) -> str:
    text = _SAFE_FILENAME.sub("_", str(text)).strip(" .")
    return text or "未知"


def _is_needed_lua_member(name: str) -> bool:
    name = name.replace("\\", "/")
    if name.startswith("src/64bit/") or not name.startswith("src/app/core/config/cfg/"):
        return False
    base = name.rsplit("/", 1)[-1]
    return any(
        base == f"{stem}.lua" or base == f"{stem}_data.lua" or base == f"{stem}_key.lua"
        for stem in PAINTING_LUA_STEMS
    )


def _is_knight_big_member(name: str) -> bool:
    return bool(_KNIGHT_BIG_IN_ZIP.search(name.replace("\\", "/")))


def _is_lang_bin_member(name: str, lang: str) -> bool:
    name = name.replace("\\", "/")
    return f"res/language/{lang}/app/core/config/cfg/language_bins/" in name


def _needed_lua_paths():
    files = []
    for stem in PAINTING_LUA_STEMS:
        for suffix in (".lua", "_data.lua", "_key.lua"):
            files.append(CFG_DIR / f"{stem}{suffix}")
    return files


def _zip_names(path: Path) -> list[str]:
    with zipfile.ZipFile(path) as z:
        return z.namelist()


def remote_zip_member_names(session: requests.Session, url: str) -> list[str]:
    """只拉 zip 中央目录，列出成员名。"""
    r = session.get(url, headers={"Range": "bytes=0-0"}, timeout=30)
    cr = r.headers.get("Content-Range", "")
    size = int(cr.rsplit("/", 1)[-1]) if "/" in cr else int(r.headers.get("Content-Length", 0))
    if size <= 0:
        raise RuntimeError("无法获取 zip 大小")
    tail = min(size, 256 * 1024)
    r = session.get(url, headers={"Range": f"bytes={size - tail}-{size - 1}"}, timeout=40)
    r.raise_for_status()
    data = r.content
    abs_start = size - len(data)
    pos = data.rfind(b"PK\x05\x06")
    if pos < 0:
        tail = min(size, 1024 * 1024)
        r = session.get(url, headers={"Range": f"bytes={size - tail}-{size - 1}"}, timeout=40)
        r.raise_for_status()
        data = r.content
        abs_start = size - len(data)
        pos = data.rfind(b"PK\x05\x06")
    if pos < 0:
        raise RuntimeError("找不到 ZIP EOCD")
    _nthis, _ntotal, cd_size, cd_off = struct.unpack_from("<HHII", data, pos + 8)
    if cd_off < abs_start:
        r = session.get(
            url, headers={"Range": f"bytes={cd_off}-{cd_off + cd_size - 1}"}, timeout=40
        )
        r.raise_for_status()
        cd = r.content
    else:
        cd = data[cd_off - abs_start : cd_off - abs_start + cd_size]
    names = []
    i = 0
    while i + 46 <= len(cd):
        if cd[i : i + 4] != b"PK\x01\x02":
            break
        fnlen, exlen, cmlen = struct.unpack_from("<HHH", cd, i + 28)
        names.append(cd[i + 46 : i + 46 + fnlen].decode("utf-8", "replace"))
        i += 46 + fnlen + exlen + cmlen
    return names


def fetch_lang_config(session: requests.Session, lang: str) -> dict:
    info = session.get(
        f"{VERSION_API_URL}?opGameId={OP_GAME_ID}&opId={OP_ID}&channel={CHANNEL}&md5=",
        timeout=60,
    ).json()
    template = info["config"].get("lang_android_upgrade_config")
    if not template:
        raise RuntimeError("opinfo 没有 lang_android_upgrade_config")
    url = template.replace("#lang#", lang)
    console.print(f"[cyan]语言包配置:[/cyan] {url}")
    r = session.get(url, timeout=120)
    r.raise_for_status()
    return r.json()


def _download_items(session, base_url, items, dest_dir: Path, jobs: int, title: str):
    dest_dir.mkdir(parents=True, exist_ok=True)
    stats = {"ok": 0, "skip": 0, "fail": 0}
    failures = {}
    lock = threading.Lock()
    done = [0]
    total = sum(i["size"] for i in items) or 1
    progress = Progress(
        SpinnerColumn(),
        TextColumn("{task.description}"),
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.1f}%",
        TextColumn("•"),
        TotalFileSizeColumn(),
        TextColumn("•"),
        TransferSpeedColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(compact=True),
        console=console,
        transient=True,
    )

    def worker(item):
        name = item["url"].rsplit("/", 1)[-1]
        dest = dest_dir / name

        def cb(n):
            with lock:
                progress.advance(task, n)

        try:
            state = download_zip(session, base_url, item, dest, progress_cb=cb)
            if state == "skip":
                with lock:
                    progress.advance(task, item["size"])
            with lock:
                done[0] += 1
                progress.update(task, description=f"[cyan]{title} {done[0]}/{len(items)}[/cyan]")
            return state, dest
        except Exception as e:
            with lock:
                failures[item["url"]] = str(e)
                done[0] += 1
                progress.update(task, description=f"[cyan]{title} {done[0]}/{len(items)}[/cyan]")
            return "fail", None

    with progress:
        task = progress.add_task(f"[cyan]{title} 0/{len(items)}", total=total)
        with ThreadPoolExecutor(max_workers=jobs) as pool:
            futs = [pool.submit(worker, it) for it in items]
            for fut in as_completed(futs):
                state, _ = fut.result()
                stats[state] += 1
    if failures:
        console.print(f"[red]下载失败 {len(failures)} 个[/red]")
        for url, err in failures.items():
            console.print(f"  {url}: {err}")
    console.print(
        f"[bold green]{title}完成[/bold green] 新下载 {stats['ok']}，"
        f"跳过 {stats['skip']}，失败 {stats['fail']}"
    )
    return [dest_dir / it["url"].rsplit("/", 1)[-1] for it in items]


def _item_zip_path(item: dict, dest_dir: Path) -> Path:
    return dest_dir / item["url"].rsplit("/", 1)[-1]


def _names_for_item(session, base_url, item: dict, dest_dir: Path, cache: dict, cache_lock=None):
    path = _item_zip_path(item, dest_dir)
    if path.exists():
        try:
            return _zip_names(path)
        except Exception:
            pass
    key = item["url"]
    if cache_lock:
        with cache_lock:
            if key in cache:
                return cache[key]
    elif key in cache:
        return cache[key]
    last_err = None
    for url in _cdn_urls(base_url, item["url"]):
        try:
            names = remote_zip_member_names(session, url)
            if cache_lock:
                with cache_lock:
                    cache[key] = names
            else:
                cache[key] = names
            return names
        except Exception as e:
            last_err = e
    raise RuntimeError(last_err or "无法列出 zip 成员")


def _select_items_by_member(
    session, base_url, items, dest_dir, predicate, cache, label, jobs: int = DEFAULT_JOBS
):
    picked = []
    lock = threading.Lock()
    cache_lock = threading.Lock()

    def check(item):
        try:
            names = _names_for_item(
                session, base_url, item, dest_dir, cache, cache_lock
            )
        except Exception as e:
            return item, False, str(e)
        return item, any(predicate(n) for n in names), None

    with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
        futs = [pool.submit(check, it) for it in items]
        for fut in as_completed(futs):
            item, hit, err = fut.result()
            if err:
                console.print(
                    f"[yellow]跳过无法检查的 zip "
                    f"{_item_zip_path(item, dest_dir).name}: {err}[/yellow]"
                )
                continue
            if hit:
                with lock:
                    picked.append(item)
    picked.sort(key=lambda it: it.get("url") or "")
    console.print(f"[cyan]{label}: {len(picked)} / {len(items)} 个 zip[/cyan]")
    return picked


def ensure_painting_lua(session, cfg, jobs: int, force: bool):
    missing = [p for p in _needed_lua_paths() if not p.exists()]
    if not missing:
        console.print("[green]立绘所需 Lua 已在本地[/green]")
        return
    console.print(f"[cyan]缺少 {len(missing)} 个数据表，准备按需下载[/cyan]")
    items = collect_zips(cfg, None, True)
    base_url = cfg.get("upgrade_url2") or cfg["upgrade_url"]
    cache = {}
    picked = _select_items_by_member(
        session, base_url, items, ZIPS_DIR, _is_needed_lua_member, cache, "含立绘数据表", jobs
    )
    if picked:
        _download_items(session, base_url, picked, ZIPS_DIR, jobs, "下载数据表 zip")
    wrote = skipped = 0
    for item in picked:
        zp = _item_zip_path(item, ZIPS_DIR)
        if not zp.exists():
            continue
        w, s = extract_zip_members(zp, ASSETS_DIR, _is_needed_lua_member, force)
        wrote += w
        skipped += s
    console.print(f"[green]数据表解压 写入 {wrote}，跳过 {skipped}[/green]")


def ensure_lang_bins(session, lang: str, jobs: int, force: bool):
    bin_dir = _lang_bin_dir(lang)
    if (bin_dir / "1001-1200.bin").exists() and (bin_dir / "1-200.bin").exists() and not force:
        console.print(f"[green]语言包 {lang} 已在本地[/green]")
        return
    cfg = fetch_lang_config(session, lang)
    versions = cfg.get("versions") or {}
    items = []
    for ver, item in versions.items():
        row = dict(item)
        row.setdefault("url", item.get("url"))
        items.append(row)
    items.sort(key=lambda it: it.get("size") or 0)
    base_url = cfg.get("upgrade_url2") or cfg["upgrade_url"]
    cache = {}
    chosen = None
    for item in items:
        try:
            names = _names_for_item(session, base_url, item, LANG_ZIPS_DIR, cache)
        except Exception as e:
            console.print(f"[yellow]无法检查语言包 {item['url']}: {e}[/yellow]")
            continue
        if any(_is_lang_bin_member(n, lang) for n in names):
            chosen = item
            break
    if not chosen:
        raise SystemExit(f"语言包 {lang} 里找不到 language_bins")
    console.print(
        f"[cyan]选用语言包 {chosen['url'].rsplit('/', 1)[-1]} "
        f"({chosen['size'] / 1024 / 1024:.1f} MB)[/cyan]"
    )
    _download_items(session, base_url, [chosen], LANG_ZIPS_DIR, jobs, "下载语言包")
    zp = _item_zip_path(chosen, LANG_ZIPS_DIR)
    wrote, skipped = extract_zip_members(
        zp, ASSETS_DIR, lambda n: _is_lang_bin_member(n, lang), force
    )
    console.print(f"[green]语言包解压 写入 {wrote}，跳过 {skipped}[/green]")


def ensure_knight_big(session, cfg, jobs: int, force: bool):
    items = collect_zips(cfg, None, True)
    base_url = cfg.get("upgrade_url2") or cfg["upgrade_url"]
    cache = {}
    picked = _select_items_by_member(
        session, base_url, items, ZIPS_DIR, _is_knight_big_member, cache, "含立绘", jobs
    )
    if picked:
        _download_items(session, base_url, picked, ZIPS_DIR, jobs, "下载立绘 zip")
    local_zips = []
    seen = set()
    for item in picked:
        zp = _item_zip_path(item, ZIPS_DIR)
        if zp.exists():
            local_zips.append(zp)
            seen.add(zp.resolve())
    silent_dir = SCRIPT_DIR / "ZipsSilent"
    if silent_dir.exists():
        for zp in silent_dir.glob("*.zip"):
            if zp.resolve() in seen:
                continue
            try:
                if any(_is_knight_big_member(n) for n in _zip_names(zp)):
                    local_zips.append(zp)
            except Exception:
                continue
    wrote = skipped = 0
    for zp in local_zips:
        try:
            w, s = extract_zip_members(zp, ASSETS_DIR, _is_knight_big_member, force)
            wrote += w
            skipped += s
        except Exception as e:
            console.print(f"[red]解压立绘失败 {zp.name}: {e}[/red]")
    console.print(f"[green]立绘解压 写入 {wrote}，跳过已有 {skipped}[/green]")
    if KNIGHT_BIG_DIR.exists():
        dec_args = argparse.Namespace(
            paths=[str(KNIGHT_BIG_DIR)],
            lua_only=False,
            no_images=False,
            jobs=jobs,
        )
        cmd_decrypt(dec_args)


def _load_painting_tables():
    knights = {}
    for stem in ("knight_base_info", "knight_base_info_2"):
        for rec in _iter_cfg_records(stem, 55, _KNIGHT_BASE_FIELDS):
            knights[rec["id"]] = rec
    skins = {}
    skins_by_res = {}
    for stem in ("skin_info", "skin_info_2"):
        for rec in _iter_cfg_records(stem, 29, _SKIN_FIELDS):
            skins[rec["id"]] = rec
            if isinstance(rec.get("res"), int) and rec["res"]:
                skins_by_res[rec["res"]] = rec
    by_pic = {}
    for rec in knights.values():
        for key in (rec.get("id"), rec.get("painted_id"), rec.get("icon_id")):
            if isinstance(key, int) and key:
                by_pic[key] = rec
    return knights, skins, skins_by_res, by_pic


def export_paintings(out_dir: Path, lang: str, force: bool):
    if not KNIGHT_BIG_DIR.exists():
        raise SystemExit(f"没有立绘目录 {KNIGHT_BIG_DIR}")
    bins = LangBins(_lang_bin_dir(lang))
    knights, skins, skins_by_res, by_pic = _load_painting_tables()
    console.print(
        f"[cyan]数据表 角色外观 {len(knights)}，皮肤 {len(skins)}，"
        f"立绘索引 {len(by_pic)}[/cyan]"
    )
    out_dir.mkdir(parents=True, exist_ok=True)
    stats = {"ok": 0, "skip": 0, "unknown": 0}
    used_names: dict[str, int] = {}
    missing_txt = []
    for src in sorted(KNIGHT_BIG_DIR.iterdir()):
        if not src.is_file() or src.suffix.lower() != ".png":
            continue
        if is_encrypted_file(src):
            continue
        try:
            pic_id = int(src.stem)
        except ValueError:
            stats["unknown"] += 1
            missing_txt.append(f"{src.name}\t非数字文件名")
            continue
        base = by_pic.get(pic_id)
        skin = skins_by_res.get(pic_id) or skins.get(pic_id)
        char_key = base["name"] if base else None
        char_name = bins.get(char_key) if char_key else None
        if not char_name:
            char_name = str(char_key or pic_id)
        if skin and skin.get("name"):
            skin_name = bins.get(skin["name"]) or str(skin["name"])
        else:
            skin_name = "原皮"
        dest_name = f"绯红神约_{_safe_painting_name(char_name)}_{_safe_painting_name(skin_name)}.png"
        if dest_name in used_names:
            dest_name = (
                f"绯红神约_{_safe_painting_name(char_name)}_"
                f"{_safe_painting_name(skin_name)}_{pic_id}.png"
            )
        used_names[dest_name] = pic_id
        dest = out_dir / dest_name
        if dest.exists() and not force:
            stats["skip"] += 1
            continue
        shutil.copy2(src, dest)
        stats["ok"] += 1
        if not base:
            stats["unknown"] += 1
            missing_txt.append(f"{src.name}\t{dest_name}\t未找到 knight_base_info")
    if missing_txt:
        (SCRIPT_DIR / "painting_unmapped.txt").write_text(
            "\n".join(missing_txt), encoding="utf-8"
        )
    console.print(
        f"[bold green]立绘导出完成[/bold green] 写入 {stats['ok']}，"
        f"跳过 {stats['skip']}，未映射 {stats['unknown']} -> {out_dir}"
    )


def cmd_painting(args):
    session = get_session()
    lang = args.lang
    out_dir = Path(args.out)
    try:
        cfg = fetch_upgrade_config(session)
    except Exception as e:
        cfg = None
        console.print(f"[yellow]无法获取热更配置，仅处理本地文件: {e}[/yellow]")
    if cfg:
        ensure_painting_lua(session, cfg, args.jobs, args.force)
    try:
        ensure_lang_bins(session, lang, args.jobs, args.force)
    except Exception as e:
        if not (_lang_bin_dir(lang) / "1001-1200.bin").exists():
            raise
        console.print(f"[yellow]语言包更新失败，使用本地: {e}[/yellow]")
    if cfg:
        ensure_knight_big(session, cfg, args.jobs, args.force)
    elif KNIGHT_BIG_DIR.exists():
        dec_args = argparse.Namespace(
            paths=[str(KNIGHT_BIG_DIR)],
            lua_only=False,
            no_images=False,
            jobs=args.jobs,
        )
        cmd_decrypt(dec_args)
    lua_files = [p for p in _needed_lua_paths() if p.exists()]
    if lua_files and not args.no_decompile:
        decompile_inplace(lua_files, args.jobs)
    export_paintings(out_dir, lang, args.force)


def main():
    parser = argparse.ArgumentParser(description="绯红神约 Echocalypse 资源下载/解密")
    sub = parser.add_subparsers(dest="command", required=True)

    p_update = sub.add_parser("update", help="下载热更+静默包，解压后自动解密/转换")
    p_update.add_argument("--version", help="只下载某个版本对应的 zip 集合，如 4025067")
    p_update.add_argument("--all", action="store_true", help="下载全部历史版本 zip（全量）")
    p_update.add_argument("--jobs", type=int, default=DEFAULT_JOBS)
    p_update.add_argument("--no-decrypt", action="store_true", help="下载解压后不自动解密")
    p_update.add_argument("--no-silent", action="store_true", help="跳过静默包下载")
    p_update.add_argument("--no-decompile", action="store_true", help="不自动还原反编译数据表")
    p_update.add_argument("--force", action="store_true", help="覆盖已解压/已解密的文件")

    p_dec = sub.add_parser("decrypt", help="对目录内 UF/XXTEA 文件原地解密")
    p_dec.add_argument("paths", nargs="*", help="目录或文件，默认 Assets/")
    p_dec.add_argument("--lua-only", action="store_true", help="只处理 .lua")
    p_dec.add_argument("--no-images", action="store_true", help="不把 CCZ 转 PNG")
    p_dec.add_argument("--jobs", type=int, default=DEFAULT_JOBS)

    p_lua = sub.add_parser("lua", help="下载热更 Lua，解密并转换到 MasterData/")
    p_lua.add_argument("--version", help="只下载某个版本对应的 zip 集合，如 4025067")
    p_lua.add_argument("--all", action="store_true", help="下载全部历史版本 zip（全量）")
    p_lua.add_argument("--jobs", type=int, default=DEFAULT_JOBS)
    p_lua.add_argument("--no-decompile", action="store_true", help="不自动还原反编译")

    p_restore = sub.add_parser("restore", help="还原单个 LuaJIT 字节码文件")
    p_restore.add_argument("src")
    p_restore.add_argument("dst")

    p_decompile = sub.add_parser("decompile", help="批量还原并反编译 Lua")
    p_decompile.add_argument("--src", default=str(SCRIPT_DIR / "MasterData"))
    p_decompile.add_argument("--out", default=str(SCRIPT_DIR / "LuaSrc"))
    p_decompile.add_argument("--jobs", type=int, default=DEFAULT_JOBS)
    p_decompile.add_argument("--only", nargs="*", help="只反编译包含这些子串的文件")

    p_usm = sub.add_parser("usm", help="把 CRI USM（IVF/VP9）转成 mp4/ivf")
    p_usm.add_argument("paths", nargs="*", help="目录或文件，默认 Assets/")
    p_usm.add_argument("--out", default=str(USM_DIR), help="输出目录，默认 Usms/")
    p_usm.add_argument("--format", choices=("mp4", "ivf"), default="mp4")
    p_usm.add_argument("--alpha", action="store_true", help="同时导出 @ALP 透明轨为 *_alpha.ivf")
    p_usm.add_argument("--force", action="store_true", help="覆盖已存在的输出")
    p_usm.add_argument("--jobs", type=int, default=DEFAULT_JOBS)

    p_bc = sub.add_parser("bytecode", help="从 zip 解密并还原标准 LuaJIT 2.1 字节码")
    p_bc.add_argument("--src", default=str(ZIPS_DIR), help="zip 文件或目录，默认 Zips/")
    p_bc.add_argument("--out", default=str(BYTECODE_DIR), help="输出目录，默认 Bytecode/")
    p_bc.add_argument("--only", nargs="*", help="只导出路径包含这些子串的成员，如 64bit")
    p_bc.add_argument("--force", action="store_true", help="覆盖已存在的 .lj")
    p_bc.add_argument("--jobs", type=int, default=DEFAULT_JOBS)

    p_pt = sub.add_parser("painting", help="下载立绘相关资源并按角色名/皮肤名导出")
    p_pt.add_argument("--lang", default="cn", help="语言包，默认 cn")
    p_pt.add_argument("--out", default=str(PAINTING_DIR), help="导出目录，默认 Paintings/")
    p_pt.add_argument("--jobs", type=int, default=DEFAULT_JOBS)
    p_pt.add_argument("--force", action="store_true", help="覆盖已解压/已导出的文件")
    p_pt.add_argument("--no-decompile", action="store_true", help="不自动还原反编译数据表")

    args = parser.parse_args()
    if args.command == "update":
        cmd_update(args)
    elif args.command == "decrypt":
        cmd_decrypt(args)
    elif args.command == "lua":
        cmd_lua(args)
    elif args.command == "restore":
        cmd_restore(args)
    elif args.command == "decompile":
        cmd_decompile(args)
    elif args.command == "usm":
        cmd_usm(args)
    elif args.command == "bytecode":
        cmd_bytecode(args)
    elif args.command == "painting":
        cmd_painting(args)


if __name__ == "__main__":
    main()
