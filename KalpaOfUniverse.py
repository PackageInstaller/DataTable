from __future__ import annotations

import argparse
import functools
import hashlib
import json
import os
import re
import shutil
import struct
import subprocess
import tempfile
import time
import warnings
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import requests
import UnityPy
import UnityPy.config
from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    Progress,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)

try:
    from UnityPy.enums.BundleFile import CompressionFlags
    from UnityPy.helpers.CompressionHelper import DECOMPRESSION_MAP as UNITYFS_DECOMPRESSION_MAP
except Exception:
    CompressionFlags = None
    UNITYFS_DECOMPRESSION_MAP = None

warnings.filterwarnings("ignore", category=UserWarning, module="UnityPy")

console = Console()

ROOT_DIR = os.path.dirname(os.path.abspath(__file__))
MASTER_DIR = os.path.join(ROOT_DIR, "MasterData")
SCHEMA_DIR = os.path.join(ROOT_DIR, "schema")
LEGACY_SCHEMA_DIR = os.path.join(ROOT_DIR, "output")
DLL_DIR = os.path.join(ROOT_DIR, "dll")
SCHEMA_GENERATOR_EXE = os.path.join(
    ROOT_DIR, "SchemaGenerate", "bin", "Debug", "net8.0", "DNFBDmp"
)
SCHEMA_GENERATOR_DLL = os.path.join(
    ROOT_DIR, "SchemaGenerate", "bin", "Debug", "net8.0", "DNFBDmp.dll"
)
# proto 推断缓存：同一个 DLL/生成器指纹只推断一次，之后直接读缓存
SCHEMA_CACHE_DIR = os.path.join(MASTER_DIR, "schema")
# 推断 proto 用的程序集：只挑真正装了黑杰克配置表的游戏程序集
SCHEMA_DLL_CANDIDATES = ("Assembly-CSharp.dll", "Assembly-CSharp-firstpass.dll")
# 热更 DLL（重建产物）：优先用它反编译出来的 C# 推断 proto，覆盖热更新增的类型
HOTUPDATE_DLL_CANDIDATES = (
    "Assembly-CSharp.hotupdate.rebuilt.dll",
    "Assembly-CSharp.hotupdate.dll",
    "Assembly-CSharp.rebuilt.dll",
)
CS_SCHEMA_NAMESPACE = "BlackJack.ConfigData"
# 解析器版本：规则变化时自动让旧的 C# / proto 缓存失效
CS_PARSER_VERSION = 2
SCHEMA_TIMEOUT = int(os.environ.get("TDJ_SCHEMA_TIMEOUT", "1800") or 1800)

SETTING_URL = (
    "http://tdjclient.zlongame.com/TDJ/android_ob71/android_bilibili_serversetting.txt"
)
UNITYCN_KEY_HEX = "426C61636B4A61636B54444A50726F6A"
TARGET_BUNDLE_NAME = "configdata_abs.b"
MANIFEST_BUNDLE_NAME = "assets_gameproject_runtimeassets_bundledataandroid_asset.b"
MERGED_PROTO_NAME = "BlackJack.ConfigData_inferred_merged.proto"

ASSETS_DIR = os.path.join(ROOT_DIR, "Assets")
HOT_UPDATE_DIR = os.path.join(ROOT_DIR, "HotUpdate")
HOT_UPDATE_REMOTE_DIR = "HotUpdateDatas/Default/Android"
DEFAULT_JOBS = 8
DEFAULT_RETRIES = 3

os.makedirs(MASTER_DIR, exist_ok=True)

decrypt_key = bytes.fromhex(UNITYCN_KEY_HEX)
try:
    UnityPy.set_assetbundle_decrypt_key(decrypt_key)
except AttributeError:
    pass
try:
    UnityPy.config.UNITYCN_KEY = decrypt_key
except AttributeError:
    pass


def schema_dir() -> str:
    if os.path.isdir(SCHEMA_DIR):
        return SCHEMA_DIR
    if os.path.isdir(LEGACY_SCHEMA_DIR):
        return LEGACY_SCHEMA_DIR
    return SCHEMA_DIR


def fetch_server_setting() -> Dict[str, List[str]]:
    """解析 ServerSetting，返回资源与热更服务器列表。"""
    console.print(f"正在请求 ServerSetting: {SETTING_URL}")
    r = requests.get(SETTING_URL, timeout=20)
    r.raise_for_status()
    text = r.text

    def parse_list(key: str) -> List[str]:
        m = re.search(rf"^{re.escape(key)}\s*=\s*(.+)$", text, re.M)
        if not m:
            return []
        return [x.strip().rstrip("/") for x in m.group(1).split(",") if x.strip()]

    settings = {
        "asset": parse_list("AssetBundleDownLoadServerList"),
        "hot": parse_list("HotUpdateDataDownLoadServerList"),
    }
    if not settings["asset"] and not settings["hot"]:
        raise RuntimeError("未能从 ServerSetting 中解析热更新下载路径")
    return settings


def get_base_url() -> str:
    settings = fetch_server_setting()
    base = (settings["asset"] or settings["hot"])[0]
    console.print(f"[bold green]✔ 获取到基础下载路径: {base}[/]")
    return base


def download_bytes(
    url: str, expected_size: Optional[int] = None, retries: int = 3
) -> Optional[bytes]:
    for attempt in range(1, retries + 1):
        try:
            chunks: List[bytes] = []
            with requests.get(url, stream=True, timeout=30) as r:
                r.raise_for_status()
                total = int(r.headers.get("Content-Length", "0")) or expected_size or 0
                with Progress(
                    TextColumn("Downloading {task.description}"),
                    BarColumn(),
                    DownloadColumn(),
                    TransferSpeedColumn(),
                    TimeRemainingColumn(),
                    console=console,
                ) as progress:
                    task = progress.add_task(
                        url.rsplit("/", 1)[-1], total=total if total > 0 else None
                    )
                    for chunk in r.iter_content(chunk_size=1024 * 256):
                        if not chunk:
                            continue
                        chunks.append(chunk)
                        progress.update(task, advance=len(chunk))
            blob = b"".join(chunks)
            if expected_size is not None and len(blob) != expected_size:
                raise RuntimeError(f"文件大小不匹配: {len(blob)} != {expected_size}")
            console.print(f"[bold green]✔ 下载完成: {url.rsplit('/', 1)[-1]}[/]")
            return blob
        except Exception as e:
            console.print(f"[yellow]⚠ 下载失败 (尝试 {attempt}/{retries}): {e}[/]")
            time.sleep(1)
    return None


def file_md5(path: Path) -> str:
    h = hashlib.md5()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest().upper()


def unityfs_is_complete(path: Path) -> bool:
    """UnityFS 结构自洽（块表能解析、压缩数据不超出文件）。

    清单里的 size 偶尔和实际文件差几个字节（例如包里那个名为 Android 的
    清单包，且它的 hash 是全 0 占位），这时用它兜底判断文件是否完整。
    """
    if not is_unity_bundle_file(path):
        return False
    blocks = get_unityfs_blocks(Path(path))
    if not blocks:
        return False
    try:
        file_size = os.path.getsize(path)
    except OSError:
        return False
    total_compressed = sum(compressed for _uncompressed, compressed, _flags in blocks)
    return 0 < total_compressed <= file_size


def download_file(
    url: str,
    dest,
    expected_size: int = 0,
    force: bool = False,
    retries: int = DEFAULT_RETRIES,
    verify_md5: str = "",
) -> bool:
    """下载单个文件；已存在且大小/校验通过则跳过。"""
    dest = Path(dest)
    if dest.exists() and not force:
        size_ok = not expected_size or dest.stat().st_size == expected_size
        md5_ok = (not verify_md5) or file_md5(dest) == verify_md5.upper()
        if size_ok and md5_ok:
            return True

    dest.parent.mkdir(parents=True, exist_ok=True)
    tmp = dest.with_suffix(dest.suffix + ".tmp")

    for attempt in range(1, retries + 1):
        try:
            with requests.get(url, stream=True, timeout=(15, 120)) as r:
                r.raise_for_status()
                declared = int(r.headers.get("Content-Length", "0") or 0)
                with open(tmp, "wb") as f:
                    for chunk in r.iter_content(1024 * 256):
                        if chunk:
                            f.write(chunk)

            got = tmp.stat().st_size
            if declared and got != declared:
                raise RuntimeError(f"传输不完整 {got} != {declared}")
            if expected_size and got != expected_size:
                # 清单 size 不准时，退化为 UnityFS 完整性校验
                if not unityfs_is_complete(tmp):
                    raise RuntimeError(f"大小不匹配 {got} != {expected_size}")
            if verify_md5 and file_md5(tmp) != verify_md5.upper():
                raise RuntimeError("MD5 校验失败")

            os.replace(tmp, dest)
            return True
        except Exception as e:
            console.print(f"[yellow]⚠ 下载失败 ({attempt}/{retries}) {os.path.basename(url)}: {e}[/]")
            if tmp.exists():
                tmp.unlink()
            time.sleep(1)
    return False


def parse_hot_update_filelist(text: str) -> List[Dict[str, Any]]:
    entries: List[Dict[str, Any]] = []
    for line in text.splitlines():
        line = line.strip()
        if not line:
            continue
        parts = line.split(",")
        if len(parts) < 3:
            continue
        try:
            size = int(parts[2])
        except ValueError:
            size = 0
        entries.append({
            "name": parts[0],
            "md5": parts[1].strip().upper(),
            "size": size,
        })
    return entries


def get_asset_bundle_list(asset_base: str, out_dir: Path, force: bool, retries: int) -> List[Dict[str, Any]]:
    """下载并解析 AssetBundleManifest，返回全部资源包信息。"""
    out_dir.mkdir(parents=True, exist_ok=True)
    manifest_url = f"{asset_base}/Android/{MANIFEST_BUNDLE_NAME}"
    manifest_path = out_dir / MANIFEST_BUNDLE_NAME

    # 清单必须每次刷新，否则无法发现新增/变更资源
    if not download_file(manifest_url, manifest_path, force=True, retries=retries):
        raise RuntimeError(f"下载 AssetBundleManifest 失败: {manifest_url}")

    data = manifest_path.read_bytes()
    manifest = extract_bundle_manifest_from_bytes(data)
    bundle_list = manifest.get("m_bundleList", []) or manifest.get("bundleList", [])
    result = []
    for b in bundle_list:
        name = b.get("m_bundleName")
        if not name:
            continue
        try:
            size = int(b.get("m_size") or 0)
        except (TypeError, ValueError):
            size = 0
        result.append({
            "name": name,
            "size": size,
            "version": b.get("m_version"),
            "hash": str(b.get("m_bundleHash") or "").upper(),
        })
    return result


UNITY_BUNDLE_MAGICS = (b"UnityFS", b"UnityRaw", b"UnityWeb", b"UnityNEt")

# UnityFS 头部 / compressedBlockInfo 中用到的一些标志位
UNITYFS_FLAG_BLOCK_INFO_AT_END = 0x80  # BlockInfoAtTheEnd：compressedBlockInfo 在文件末尾
UNITYFS_COMPRESSION_MASK = 0x3F
UNITYFS_COMPRESSION_NONE = 0
UNITYFS_BLOCK_ENCRYPTED = 0x100  # block flags 上的 UnityCN 加密位
UNITYFS_ENCRYPTION_FLAGS = 0x1400  # 头部 flags 上的 UnityCN 加密位（旧 0x400 / 新 0x1000）


def is_unity_bundle_file(path: Path) -> bool:
    """注意：UnityFS 后跟的是 \0，不能直接和 b"UnityFS" 比较。"""
    try:
        with open(path, "rb") as f:
            magic = f.read(8)
        return magic.rstrip(b"\0") in UNITY_BUNDLE_MAGICS
    except OSError:
        return False


def get_unityfs_flags(path: Path) -> Optional[int]:
    """快速读取 UnityFS 头部的 flags（仅作为 compressedBlockInfo 解析失败时的兜底）。"""
    try:
        with open(path, "rb") as f:
            head = f.read(0x100)
        if not head.startswith(b"UnityFS\0"):
            return None
        off = 8
        off += 4  # version
        # unityVersion + unityRevision 两个 C 字符串
        off = head.index(b"\0", off) + 1
        off = head.index(b"\0", off) + 1
        off += 8  # size
        off += 8  # compressedBlockInfoSize + decompressedBlockInfoSize
        return struct.unpack_from(">I", head, off)[0]
    except Exception:
        return None


def _read_cstring(buf: bytes, off: int) -> Tuple[bytes, int]:
    end = buf.index(b"\0", off)
    return buf[off:end], end + 1


def _unityfs_needs_block_align(version: int, unity_revision: bytes) -> bool:
    """version >= 7 或 Unity 2019.4.15+ 时，block 数据前会做 16 字节对齐。"""
    if version >= 7:
        return True
    m = re.match(rb"(\d+)\.(\d+)\.(\d+)", unity_revision)
    if not m:
        return False
    return tuple(int(g) for g in m.groups()) >= (2019, 4, 15)


def _decompress_unityfs_block_info(
    blob: bytes, uncompressed_size: int, flags: int
) -> Optional[bytes]:
    """按头部 flags 的压缩方式解压 compressedBlockInfo；失败返回 None。"""
    comp = flags & UNITYFS_COMPRESSION_MASK
    if comp == UNITYFS_COMPRESSION_NONE:
        return blob
    if UNITYFS_DECOMPRESSION_MAP is None:
        return None
    try:
        data = UNITYFS_DECOMPRESSION_MAP[CompressionFlags(comp)](blob, uncompressed_size)
    except Exception:
        return None
    return data if len(data) == uncompressed_size else None


def get_unityfs_blocks(path: Path) -> Optional[List[Tuple[int, int, int]]]:
    """解析 UnityFS 的 compressedBlockInfo，返回 [(uncompressedSize, compressedSize, flags), ...]。

    加密包与已解密的包，compressedBlockInfo 本身都是普通压缩数据（UnityCN 只加密
    数据块，加密位写在 block flags 的 0x100 上），所以两种包都能在这里解出来。
    解析/解压失败（文件截断、压缩方式不支持等）返回 None。
    """
    try:
        with open(path, "rb") as f:
            file_size = os.fstat(f.fileno()).st_size
            head = f.read(0x100)
            if not head.startswith(b"UnityFS\0"):
                return None
            off = 8
            version = struct.unpack_from(">I", head, off)[0]
            off += 4
            _, off = _read_cstring(head, off)  # unityVersion
            unity_revision, off = _read_cstring(head, off)  # unityRevision
            off += 8  # size
            compressed_size = struct.unpack_from(">I", head, off)[0]
            off += 4
            uncompressed_size = struct.unpack_from(">I", head, off)[0]
            off += 4
            flags = struct.unpack_from(">I", head, off)[0]
            off += 4

            if flags & UNITYFS_FLAG_BLOCK_INFO_AT_END:
                positions = [file_size - compressed_size]
            else:
                # UnityCN 加密包在 flags 之后多了 70 字节解密表，compressedBlockInfo 在其后
                positions = [off, off + 70]
                if _unityfs_needs_block_align(version, unity_revision):
                    positions = [(p + 15) & ~15 for p in positions]

            block_info = None
            for pos in positions:
                if pos < 0 or pos + compressed_size > file_size:
                    continue
                f.seek(pos)
                block_info = _decompress_unityfs_block_info(
                    f.read(compressed_size), uncompressed_size, flags
                )
                if block_info is not None:
                    break
            if block_info is None or len(block_info) < 20:
                return None

            # compressedBlockInfo 结构：16 字节 hash + u32 blockCount + blockCount * (u32, u32, u16)
            count = struct.unpack_from(">I", block_info, 16)[0]
            blocks = []
            pos = 20
            for _ in range(count):
                if pos + 10 > len(block_info):
                    return None
                uncompressed, compressed, block_flags = struct.unpack_from(">IIH", block_info, pos)
                pos += 10
                blocks.append((uncompressed, compressed, block_flags))
            return blocks
    except Exception:
        return None


def is_unityfs_encrypted(path: Path) -> bool:
    """判断 AssetBundle 是否仍处于 UnityCN 加密状态（也就是还没解密）。

    UnityCN 加密包的 compressedBlockInfo 本身可以正常解压，但其中每个数据块
    的 flags 都带 0x100 加密位（UnityPy 正是按该位决定是否 decrypt_block）；
    解密后由 UnityPy 重新打包，flags 只剩普通压缩类型，加密位被清掉。
    """
    blocks = get_unityfs_blocks(path)
    if blocks is None:
        # compressedBlockInfo 解析失败时，退回头部 flags 判断
        flags = get_unityfs_flags(path)
        return bool(flags & UNITYFS_ENCRYPTION_FLAGS) if flags is not None else False
    return any(block_flags & UNITYFS_BLOCK_ENCRYPTED for _, _, block_flags in blocks)


def decrypt_asset_file_inplace(path: Path, force: bool = False) -> bool:
    """用 UnityCN key 原地解密一个 AssetBundle。"""
    tmp = path.with_suffix(path.suffix + ".dec.tmp")
    try:
        env = UnityPy.load(str(path))
        # 用 lz4 packer 重新打包，输出标准 UnityFS，BlockInfoAtTheEnd 会置位，
        # 也就是 compressedBlockInfo 位于文件末尾。
        data = env.file.save("lz4")
        if not data:
            return False
        with open(tmp, "wb") as f:
            f.write(data)
        os.replace(tmp, path)
        return True
    except Exception:
        if tmp.exists():
            tmp.unlink()
        return False


def load_decrypt_state(state_path: Path) -> set:
    if not state_path.exists():
        return set()
    try:
        return set(json.loads(state_path.read_text(encoding="utf-8")))
    except Exception:
        return set()


def save_decrypt_state(state_path: Path, state: set) -> None:
    state_path.parent.mkdir(parents=True, exist_ok=True)
    state_path.write_text(
        json.dumps(sorted(state), ensure_ascii=False, indent=2),
        encoding="utf-8",
    )


def decrypt_asset_dir(
    root,
    jobs: int = DEFAULT_JOBS,
    force: bool = False,
    state_path: Optional[Path] = None,
) -> Tuple[int, int]:
    """原地解密目录下所有 UnityCN AssetBundle；state 避免重复解密。"""
    root = Path(root)
    if not root.exists():
        return 0, 0
    if state_path is None:
        state_path = root / ".unitycn_decrypted.json"

    state = load_decrypt_state(state_path)
    files = [
        p for p in root.rglob("*")
        if p.is_file() and p.suffix != ".tmp" and is_unity_bundle_file(p)
    ]

    targets = []
    for p in files:
        rel = str(p.relative_to(root))
        if force or rel not in state or is_unityfs_encrypted(p):
            targets.append((p, rel))

    if not targets:
        return 0, 0

    console.print(f"[cyan]UnityCN 原地解密[/cyan] {len(targets)} 个 AssetBundle")
    ok = fail = 0
    with Progress(
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        TextColumn("{task.completed}/{task.total}"),
        console=console,
    ) as progress:
        task = progress.add_task("[cyan]解密", total=len(targets))

        def one(item: Tuple[Path, str]) -> bool:
            path, _ = item
            return decrypt_asset_file_inplace(path, force=force)

        with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
            futs = {pool.submit(one, t): t for t in targets}
            for fut in as_completed(futs):
                path, rel = futs[fut]
                if fut.result():
                    ok += 1
                    state.add(rel)
                else:
                    fail += 1
                    console.print(f"[red]✗ 解密失败: {path}[/red]")
                progress.advance(task)

    save_decrypt_state(state_path, state)
    console.print(f"[green]UnityCN 解密完成[/green] 成功={ok} 失败={fail}")
    return ok, fail


ASSET_STATE_FILE = "assets_state.json"
ASSET_MANIFEST_FILE = "asset_manifest.json"
# 数据表模式的导出状态（记录 MasterData 目录对应的是哪个版本的 configdata_abs.b）
MASTER_STATE_FILE = ".master_state.json"
# 立绘相关的 AssetBundle 关键字（prefab 包与全部贴图分件包）
PAINTING_BUNDLE_KEYWORD = "heropainting"


def asset_state_path(assets_dir: Path) -> Path:
    return assets_dir / ASSET_STATE_FILE


def load_json_file(path: Path) -> Dict[str, Any]:
    """读一个 JSON 文件，失败返回 {}（状态文件损坏时按“没有状态”处理）。"""
    try:
        data = json.loads(Path(path).read_text(encoding="utf-8"))
    except Exception:
        return {}
    return data if isinstance(data, dict) else {}


def save_json_file(path: Path, data: Any) -> None:
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")


def load_asset_states(path: Path) -> Dict[str, Dict[str, Any]]:
    return load_json_file(path)


def save_asset_states(path: Path, states: Dict[str, Dict[str, Any]]) -> None:
    save_json_file(path, states)


def asset_entry_hash(entry: Dict[str, Any]) -> str:
    """清单里的包 hash；全 0/空表示清单没提供，按“未知”返回空串。"""
    value = str(entry.get("hash") or "").strip().upper()
    if not value or set(value) <= {"0"}:
        return ""
    return value


def plan_asset_jobs(
    entries: List[Dict[str, Any]],
    assets_dir: Path,
    states: Dict[str, Dict[str, Any]],
    decrypted_state: set,
    only=None,
    force: bool = False,
    verify: bool = False,
    decrypt: bool = True,
) -> Dict[str, Any]:
    """按清单和本地状态决定要下载/更新/解密的文件。

    判定顺序：
      1. 状态文件里记录的远端 hash 与清单一致 -> 已是最新；
      2. 本地已是解密后的包（大小通常和远端不一致，但内容是对的）-> 跳过；
      3. 大小一致（--verify 时再确认 UnityFS 结构完整）-> 已下载；
      4. 其余（缺失 / hash 或大小不一致）-> 下载；
    已下载但仍是 UnityCN 加密的包会进入 pending_decrypt。

    注意：清单里的 m_bundleHash 是 Unity 的资源包 hash（用于判断版本变化），
    不是文件 MD5，所以本地校验用“大小 + UnityFS 结构”而不是 MD5。
    """
    plan = {
        "download": [],      # [(entry, reason)]
        "pending_decrypt": [],
        "skipped": 0,
        "unchanged": 0,
        "updated": 0,
        "added": 0,
    }
    for e in entries:
        name = str(e.get("name") or "")
        if not name or (only and not only(name)):
            continue
        dest = assets_dir / name
        state = states.get(name) or {}
        remote_hash = asset_entry_hash(e)
        remote_size = int(e.get("size") or 0)

        if not dest.is_file():
            plan["download"].append((e, "新增"))
            plan["added"] += 1
            continue
        if force:
            plan["download"].append((e, "强制"))
            plan["updated"] += 1
            continue
        # 1) 状态显示就是当前远端版本
        if state and remote_hash and str(state.get("hash") or "").upper() == remote_hash and not verify:
            plan["skipped"] += 1
            plan["unchanged"] += 1
            continue
        # 2) 已是解密后的包
        if is_unity_bundle_file(dest) and (name in decrypted_state or not is_unityfs_encrypted(dest)):
            states[name] = {
                "version": e.get("version"), "hash": remote_hash,
                "size": remote_size, "decrypted": True,
            }
            plan["skipped"] += 1
            plan["unchanged"] += 1
            continue
        # 3) 大小一致（必要时确认文件本身是完整的 UnityFS）
        size_ok = (not remote_size) or dest.stat().st_size == remote_size
        if size_ok and verify and is_unity_bundle_file(dest) and not unityfs_is_complete(dest):
            size_ok = False
        if size_ok:
            if decrypt and is_unity_bundle_file(dest) and is_unityfs_encrypted(dest):
                plan["pending_decrypt"].append(name)
            else:
                states[name] = {
                    "version": e.get("version"), "hash": remote_hash,
                    "size": remote_size, "decrypted": False,
                }
            plan["skipped"] += 1
            plan["unchanged"] += 1
            continue
        # 4) 需要下载/更新
        plan["download"].append((e, "更新"))
        plan["updated"] += 1
    return plan


def fetch_bundle_entries(
    out_root: str, retries: int = DEFAULT_RETRIES
) -> Tuple[str, List[Dict[str, Any]]]:
    """请求 ServerSetting，并下载+解析 AssetBundleManifest。

    清单每次都重新拉取，否则发现不了新增/变更的资源包。
    """
    settings = fetch_server_setting()
    asset_bases = settings["asset"] or settings["hot"]
    if not asset_bases:
        raise RuntimeError("ServerSetting 里没有可用的资源下载地址")
    asset_base = asset_bases[0]
    out = Path(out_root) / "Assets" / "Android"
    out.mkdir(parents=True, exist_ok=True)
    entries = get_asset_bundle_list(asset_base, out, force=False, retries=retries)
    if not entries:
        raise RuntimeError("AssetBundleManifest 中没有资源包")
    return asset_base, entries


def download_asset_bundles(
    out_root: str,
    jobs: int = DEFAULT_JOBS,
    force: bool = False,
    retries: int = DEFAULT_RETRIES,
    decrypt: bool = True,
    only=None,
    verify: bool = False,
    label: str = "资产",
    manifest: Optional[Tuple[str, List[Dict[str, Any]]]] = None,
) -> Dict[str, Any]:
    """检查远端清单并按需下载/更新 AssetBundle（可用 only 只处理一部分包）。

    检查更新的判定顺序（见 plan_asset_jobs）：
      状态文件记录的 hash 与清单一致 → 已是最新，跳过；
      本地已是 UnityCN 解密后的包 → 内容正确，跳过；
      大小一致（--verify 时再核对 MD5） → 已下载，跳过；
      其余（缺失 / hash 大小不一致） → 下载并解密。

    返回报告：{total, checked, added, updated, unchanged, failed,
               downloaded, manifest}
    """
    if manifest is not None:
        asset_base, entries_all = manifest
    else:
        asset_base, entries_all = fetch_bundle_entries(out_root, retries)
    out = Path(out_root) / "Assets" / "Android"

    entries = [e for e in entries_all if (not only) or only(str(e.get("name") or ""))]
    report: Dict[str, Any] = {
        "total": len(entries_all),
        "checked": len(entries),
        "added": 0,
        "updated": 0,
        "unchanged": 0,
        "failed": 0,
        "downloaded": [],
        "manifest": {str(e.get("name")): e for e in entries},
    }
    if not entries:
        console.print(f"[yellow]{label}：清单里没有匹配的资源包，跳过[/yellow]")
        save_json_file(out / ASSET_MANIFEST_FILE, entries_all)
        return report

    state_path = asset_state_path(out)
    states = load_asset_states(state_path)
    decrypt_state_path = out / ".unitycn_decrypted.json"
    if force and decrypt_state_path.exists():
        decrypt_state_path.unlink()
    decrypted_state = load_decrypt_state(decrypt_state_path)

    plan = plan_asset_jobs(
        entries, out, states, decrypted_state,
        only=None, force=force, verify=verify, decrypt=decrypt,
    )
    report["added"] = plan["added"]
    report["updated"] = plan["updated"]
    report["unchanged"] = plan["unchanged"]
    targets = plan["download"]
    console.print(
        f"[cyan]{label}清单[/cyan] 检查 {len(entries)} 个："
        f"新增 {plan['added']}，更新 {plan['updated']}，"
        f"待解密 {len(plan['pending_decrypt'])}，最新 {plan['unchanged']}"
    )
    for e, reason in targets[:5]:
        console.print(f"   [dim]{reason}[/dim] {e.get('name')}")
    if len(targets) > 5:
        console.print(f"   [dim]… 其余 {len(targets) - 5} 个[/dim]")

    ok = fail = 0
    if targets:
        with Progress(
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            DownloadColumn(),
            TransferSpeedColumn(),
            TimeRemainingColumn(),
            console=console,
        ) as progress:
            task = progress.add_task(f"[cyan]下载并解密{label}[/cyan]", total=len(targets))

            def one(item) -> Tuple[str, bool, bool]:
                e, _reason = item
                name = str(e.get("name"))
                size = int(e.get("size") or 0)
                dest = out / name
                url = f"{asset_base}/Android/{name}"
                # 不能用清单 hash 当文件 MD5（那是 Unity 的资源包 hash），
                # 完整性靠 HTTP Content-Length + UnityFS 结构校验
                if not download_file(
                    url, dest, expected_size=size, force=True,
                    retries=retries,
                ):
                    return name, False, False
                if decrypt and is_unity_bundle_file(dest):
                    return name, True, decrypt_asset_file_inplace(dest, force=True)
                return name, True, True

            with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
                futs = [pool.submit(one, t) for t in targets]
                for fut in as_completed(futs):
                    name, dl_ok, dec_ok = fut.result()
                    e = next((x for x, _ in targets if x.get("name") == name), {})
                    if dl_ok:
                        ok += 1
                        report["downloaded"].append(name)
                        states[name] = {
                            "version": e.get("version"),
                            "hash": asset_entry_hash(e),
                            "size": int(e.get("size") or 0),
                            "decrypted": bool(dec_ok),
                        }
                        if decrypt and dec_ok:
                            decrypted_state.add(name)
                        elif decrypt and not dec_ok:
                            console.print(f"[red]✗ 边下边解失败: {name}[/red]")
                    else:
                        fail += 1
                    progress.advance(task)

    report["failed"] = fail
    save_json_file(out / ASSET_MANIFEST_FILE, entries_all)
    save_asset_states(state_path, states)
    save_decrypt_state(decrypt_state_path, decrypted_state)

    # 处理之前已下载但未解密的文件
    pending = [n for n in plan["pending_decrypt"] if (out / n).exists()]
    if decrypt and pending:
        still = [
            p for p in (out / n for n in pending)
            if p.exists() and is_unity_bundle_file(p)
        ]
        if still:
            decrypt_asset_dir(out, jobs=jobs, force=False, state_path=decrypt_state_path)
            for n in pending:
                if not is_unityfs_encrypted(out / n):
                    decrypted_state.add(n)
            save_decrypt_state(decrypt_state_path, decrypted_state)

    console.print(
        f"[green]{label}完成[/green] 下载/更新={ok} 失败={fail} "
        f"最新={plan['unchanged']}"
    )
    return report


def download_hotupdate_files(
    out_root: str,
    jobs: int = DEFAULT_JOBS,
    force: bool = False,
    retries: int = DEFAULT_RETRIES,
    verify: bool = False,
) -> Tuple[int, int, int]:
    settings = fetch_server_setting()
    hot_bases = settings["hot"]
    if not hot_bases:
        raise RuntimeError("未配置 HotUpdateDataDownLoadServerList")
    hot_base = hot_bases[0]
    out = Path(out_root) / "HotUpdate" / "Default" / "Android"
    out.mkdir(parents=True, exist_ok=True)

    list_url = f"{hot_base}/{HOT_UPDATE_REMOTE_DIR}/AllFilesPath.txt"
    list_path = out / "AllFilesPath.txt"
    # 热更清单每次刷新
    if not download_file(list_url, list_path, force=True, retries=retries):
        raise RuntimeError(f"下载 AllFilesPath.txt 失败: {list_url}")

    entries = parse_hot_update_filelist(list_path.read_text(encoding="utf-8"))
    targets = []
    skipped = 0
    for e in entries:
        dest = out / e["name"]
        if dest.exists() and not force:
            size_ok = not e["size"] or dest.stat().st_size == e["size"]
            md5_ok = (not verify) or file_md5(dest) == e["md5"]
            if size_ok and md5_ok:
                skipped += 1
                continue
        targets.append(e)

    console.print(
        f"[cyan]热更清单[/cyan] 共 {len(entries)} 个，跳过 {skipped}，待下载 {len(targets)}"
    )
    if not targets:
        return len(entries), skipped, 0

    ok = fail = 0
    with Progress(
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        DownloadColumn(),
        TransferSpeedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("[cyan]下载热更文件", total=len(targets))

        def one(e: Dict[str, Any]) -> bool:
            url = f"{hot_base}/{HOT_UPDATE_REMOTE_DIR}/{e['name']}"
            return download_file(
                url, out / e["name"],
                expected_size=e["size"],
                force=force,
                retries=retries,
                verify_md5=e["md5"] if verify else "",
            )

        with ThreadPoolExecutor(max_workers=max(1, jobs)) as pool:
            futs = [pool.submit(one, e) for e in targets]
            for fut in as_completed(futs):
                if fut.result():
                    ok += 1
                else:
                    fail += 1
                progress.advance(task)

    console.print(f"[green]热更下载完成[/green] 成功={ok} 失败={fail} 跳过={skipped}")
    return len(entries), skipped, fail


def _str_to_script_bytes(s: str) -> bytes:
    return s.encode("utf-8", errors="surrogateescape") if s else b""


def get_textasset_bytes(obj, data) -> bytes:
    try:
        tt = obj.read_typetree()
        if isinstance(tt, dict):
            for key in ("m_Script", "script", "Script", "m_ScriptData"):
                v = tt.get(key)
                if isinstance(v, memoryview):
                    b = v.tobytes()
                    if b:
                        return b
                if isinstance(v, (bytes, bytearray)) and v:
                    return bytes(v)
                if isinstance(v, str) and v:
                    return _str_to_script_bytes(v)
    except Exception:
        pass

    for attr in ("script", "m_Script", "m_ScriptData", "bytes", "raw_data"):
        v = getattr(data, attr, None)
        if isinstance(v, memoryview):
            b = v.tobytes()
            if b:
                return b
        if isinstance(v, (bytes, bytearray)) and v:
            return bytes(v)
        if isinstance(v, str) and v:
            return _str_to_script_bytes(v)
    return b""


def _safe_name(name: str) -> str:
    return re.sub(r'[<>:"/\\\\|?*]+', "_", name).strip() or "unnamed"


def extract_bundle_manifest_from_bytes(bundle_data: bytes) -> Dict[str, Any]:
    env = UnityPy.load(bundle_data)
    for obj in env.objects:
        if obj.type.name not in ("MonoBehaviour", "AssetBundleManifest", "TextAsset"):
            continue
        try:
            tt = obj.read_typetree()
        except Exception:
            continue
        if not isinstance(tt, dict):
            continue
        for key in ("m_bundleList", "bundleList"):
            if isinstance(tt.get(key), list):
                console.print(
                    "[bold green]✔ 成功解析出目标清单 (Name: BundleDataAndroid)[/]"
                )
                return tt
    raise RuntimeError("未找到可用的 BundleDataAndroid 清单对象")


def collect_configdata_assets_from_bytes(bundle_data: bytes) -> Dict[str, bytes]:
    env = UnityPy.load(bundle_data)
    files: Dict[str, bytes] = {}
    total_entries = 0
    text_asset_count = 0

    with Progress(
        TextColumn("Extracting"),
        BarColumn(),
        TextColumn("{task.completed}/{task.total} Files"),
        console=console,
    ) as progress:
        task = progress.add_task("extract", total=len(env.container))
        for path, obj in env.container.items():
            total_entries += 1
            progress.advance(task)
            try:
                if obj.type.name != "TextAsset":
                    continue
                norm = path.replace("\\", "/").lower()
                if "/configdata00/" not in norm:
                    continue
                data = obj.read()
                blob = get_textasset_bytes(obj, data)
                base_name = _safe_name(
                    os.path.basename(path) or getattr(data, "name", "unnamed")
                )
                if not os.path.splitext(base_name)[1]:
                    base_name += ".bytes"
                files[base_name] = blob
                text_asset_count += 1
            except Exception:
                continue
    return files


def _generator_command() -> Optional[List[str]]:
    if os.path.isfile(SCHEMA_GENERATOR_EXE) and os.access(
        SCHEMA_GENERATOR_EXE, os.X_OK
    ):
        return [SCHEMA_GENERATOR_EXE]
    if os.path.isfile(SCHEMA_GENERATOR_DLL):
        return ["dotnet", SCHEMA_GENERATOR_DLL]
    return None


def _generator_stamp_mtime() -> float:
    cmd = _generator_command()
    if not cmd:
        return 0.0
    stamp = cmd[0] if len(cmd) == 1 else cmd[1]
    return os.path.getmtime(stamp) if os.path.isfile(stamp) else 0.0


def schema_dll_files(
    dll_dir: str = DLL_DIR, names: Optional[List[str]] = None
) -> List[str]:
    """参与 proto 推断的 DLL 列表。

    只挑 Assembly-CSharp*.dll：其余 70 多个是引擎/三方库，跟配置表无关。
    尤其**不要**把 Assembly-CSharp.hotupdate.rebuilt.dll 这类重建产物放进来：
    DNFBDmp 为了找嵌入描述符会遍历所有方法里的 ldstr，撞上这种超大 IL 会卡几十分钟
    （实测 20 分钟都跑不完），而 APK 里的 Assembly-CSharp.dll 只要几秒。
    """
    if not os.path.isdir(dll_dir):
        return []
    if names:
        return [os.path.join(dll_dir, n) for n in names]
    picked = [
        os.path.join(dll_dir, name)
        for name in SCHEMA_DLL_CANDIDATES
        if os.path.isfile(os.path.join(dll_dir, name))
    ]
    if picked:
        return picked
    return sorted(
        os.path.join(dll_dir, name)
        for name in os.listdir(dll_dir)
        if name.lower().endswith(".dll")
    )


def _schema_cache_key(dll_files: List[str]) -> str:
    h = hashlib.md5()
    for path in dll_files:
        try:
            st = os.stat(path)
        except OSError:
            continue
        h.update(f"{os.path.basename(path)}:{st.st_size}:{int(st.st_mtime)};".encode())
    h.update(f"gen:{_generator_stamp_mtime()}".encode())
    return h.hexdigest()[:16]


def _run_schema_generator(cmd: List[str], timeout: int) -> Tuple[int, str]:
    """跑 DNFBDmp，并把关键日志实时转发出来（否则看着像卡死）。"""
    keep = ("Loading DLL", "共 ", "推断合并", "[推断合并]", "完成：", "错误", "Exception")
    proc = subprocess.Popen(
        cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, bufsize=1
    )
    lines: List[str] = []
    try:
        if proc.stdout is not None:
            for raw in proc.stdout:
                line = raw.rstrip()
                if not line:
                    continue
                lines.append(line)
                del lines[:-20]
                if any(k in line for k in keep):
                    console.print(f"   [dim]{line}[/dim]")
        proc.wait(timeout=timeout)
    except subprocess.TimeoutExpired:
        proc.kill()
        return -9, f"超时（>{timeout}s）"
    return proc.returncode or 0, lines[-1] if lines else ""


def _schema_input_dir(dll_files: List[str], key: str) -> str:
    """DNFBDmp 只接受目录：准备一个只装目标 DLL 的目录（软链接，避免复制）。"""
    out = os.path.join(SCHEMA_CACHE_DIR, f"dll_{key}")
    os.makedirs(out, exist_ok=True)
    for src in dll_files:
        dst = os.path.join(out, os.path.basename(src))
        if os.path.exists(dst):
            continue
        try:
            os.symlink(os.path.abspath(src), dst)
        except OSError:
            shutil.copy2(src, dst)
    return out


def build_merged_fdset(dll_files: List[str], key: str, refresh: bool = False) -> bytes:
    """生成（优先读缓存）合并后的 FileDescriptorSet 字节。"""
    os.makedirs(SCHEMA_CACHE_DIR, exist_ok=True)
    fdset_path = os.path.join(SCHEMA_CACHE_DIR, f"merged_{key}.pb")
    if os.path.isfile(fdset_path) and not refresh:
        return Path(fdset_path).read_bytes()
    if not dll_files:
        raise FileNotFoundError(f"没有可用于推断 proto 的 DLL：{DLL_DIR}")

    protoc = shutil.which("protoc")
    if not protoc:
        raise EnvironmentError("未找到 protoc，请先安装 protobuf-compiler")
    gen_cmd = _generator_command()
    if not gen_cmd:
        raise FileNotFoundError("未找到 SchemaGenerate 生成器，请先构建 DNFBDmp")

    out_dir = os.path.join(SCHEMA_CACHE_DIR, f"out_{key}")
    os.makedirs(out_dir, exist_ok=True)
    merged_proto_path = os.path.join(out_dir, MERGED_PROTO_NAME)
    if refresh or not os.path.isfile(merged_proto_path):
        console.print(
            f"[cyan]推断 proto[/cyan] {MERGED_PROTO_NAME}"
            f"（{len(dll_files)} 个 DLL，首次较慢，之后走缓存）"
        )
        rc, last = _run_schema_generator(
            [
                *gen_cmd,
                _schema_input_dir(dll_files, key),
                out_dir,
                "--merge-infer",
            ],
            SCHEMA_TIMEOUT,
        )
        if rc != 0 or not os.path.isfile(merged_proto_path):
            raise RuntimeError(f"生成 merged proto 失败：{last or f'退出码 {rc}'}")

    tmp_fdset = os.path.join(out_dir, "merged.pb")
    r = subprocess.run(
        [
            protoc,
            "-I",
            out_dir,
            "--include_imports",
            f"--descriptor_set_out={tmp_fdset}",
            merged_proto_path,
        ],
        capture_output=True,
        text=True,
        timeout=600,
    )
    if r.returncode != 0:
        raise RuntimeError(f"编译 merged proto 失败：{(r.stderr or r.stdout).strip()}")
    data = Path(tmp_fdset).read_bytes()
    Path(fdset_path).write_bytes(data)
    return data


# ---------------------------------------------------------------------------
# proto 推断：C# 源码路线
#
# DNFBDmp 走 dnlib 读 IL，遇到重建过的热更 DLL（Assembly-CSharp.hotupdate.rebuilt.dll）
# 会因为遍历所有方法里的 ldstr 卡几十分钟；而 ilspycmd 反编译很快（整包约 70 秒，
# 一次即可缓存），反编译出来的 C# 里 `public const int XxxFieldNumber = n` 与
# `private <type> Xxx_;` 正好够推断 proto —— 规则与 DNFBDmp 的
# MessageTypeProtoGenerator 一致（scalar 映射、RepeatedField/MapField、嵌套类型用
# Outer_Inner 扁平名、认不出的类型退回 bytes）。
# ---------------------------------------------------------------------------

_CS_DECL_RE = re.compile(
    r'^(?:public|internal|private|protected)[\w \t]*?(class|enum)[ \t]+(\w+)'
)
_CS_FIELDNUM_RE = re.compile(r'public\s+const\s+int\s+(\w+)FieldNumber\s*=\s*(\d+)\s*;')
_CS_BACKFIELD_RE = re.compile(
    r'^[ \t]*(?:private|protected|internal)[ \t]+(?!static[ \t])'
    r'([A-Za-z_][\w\.]*(?:<[^;{}]*?>)?(?:\[\])?)[ \t]+(\w+)_[ \t]*(?:=[^;]*)?;',
    re.M,
)
_CS_ENUM_MEMBER_RE = re.compile(
    r'^(\w+)\s*(?:=\s*(-?(?:0[xX][0-9a-fA-F]+|\d+)))?$'
)
_CS_SCALARS = {
    "string": "string",
    "ByteString": "bytes",
    "bool": "bool",
    "int": "int32",
    "short": "int32",
    "sbyte": "int32",
    "uint": "uint32",
    "ushort": "uint32",
    "byte": "uint32",
    "long": "int64",
    "ulong": "uint64",
    "float": "float",
    "double": "double",
}


def find_hotupdate_dll(dll_dir: str = DLL_DIR) -> Optional[str]:
    """热更 DLL（重建产物）路径：schema 优先从它反编译出来的 C# 推断。"""
    for name in HOTUPDATE_DLL_CANDIDATES:
        path = os.path.join(dll_dir, name)
        if os.path.isfile(path):
            return path
    return None


def _cs_cache_key(dll_path: str) -> str:
    """反编译缓存键：只看 DLL 指纹（解析规则变化不需要重新反编译）。"""
    return _schema_cache_key([dll_path])


def _cs_strip_attrs(line: str) -> str:
    return re.sub(r'\[[^\]]*\]', '', line).strip()


def _cs_type_body(src: str, pos: int) -> str:
    """取从 pos 之后第一个 '{' 开始的类型体。"""
    start = src.find("{", pos)
    if start < 0:
        return ""
    depth = 0
    for i in range(start, len(src)):
        if src[i] == "{":
            depth += 1
        elif src[i] == "}":
            depth -= 1
            if depth == 0:
                return src[start + 1 : i]
    return src[start + 1 :]


def _cs_parse_types(
    body: str,
    prefix: str,
    messages: Dict[str, List[Tuple[int, str, str]]],
    enums: Dict[str, List[Tuple[str, int]]],
) -> None:
    """递归解析一段 C# 类型体，收集消息类与枚举。"""
    depth = 0
    line_start = 0
    decls: List[Tuple[int, str, str]] = []
    for i, ch in enumerate(body):
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
        elif ch == "\n":
            line = body[line_start:i]
            line_start = i + 1
            if depth != 0:
                continue
            text = _cs_strip_attrs(line)
            if not text or text.startswith("//"):
                continue
            m = _CS_DECL_RE.match(text)
            if m:
                decls.append((i + 1, m.group(1), m.group(2)))

    for pos, kind, name in decls:
        full = f"{prefix}_{name}" if prefix else name
        inner = _cs_type_body(body, pos)
        if kind == "enum":
            members: List[Tuple[str, int]] = []
            next_value = 0
            for raw in inner.splitlines():
                text = _cs_strip_attrs(raw).rstrip(",").strip()
                if not text or text.startswith("//"):
                    continue
                em = _CS_ENUM_MEMBER_RE.match(text)
                if not em:
                    continue
                value = int(em.group(2), 0) if em.group(2) else next_value
                next_value = value + 1
                members.append((em.group(1), value))
            members.sort(key=lambda item: (item[1], item[0]))
            enums[full] = members
            continue
        consts = _CS_FIELDNUM_RE.findall(inner)
        if consts:
            # 正则里的 (\w+)_ 捕获的就是 LOGICAL 名（不含下划线），例如 ID_ -> ID
            back = {name: type_name.strip() for type_name, name in _CS_BACKFIELD_RE.findall(inner)}
            rows = [
                (int(num), field, back.get(field))
                for field, num in consts
            ]
            rows.sort(key=lambda row: row[0])
            messages[full] = rows
        _cs_parse_types(inner, full, messages, enums)


def _cs_map_type(
    type_name: Optional[str],
    messages: Dict[str, Any],
    enums: Dict[str, Any],
) -> str:
    text = (type_name or "").strip()
    if not text:
        return "bytes"
    repeated = re.match(r"^RepeatedField<(.+)>$", text)
    if repeated:
        inner = _cs_map_type(repeated.group(1), messages, enums)
        if inner.startswith("repeated ") or inner.startswith("map<"):
            return "bytes"
        return f"repeated {inner}"
    mapping = re.match(r"^MapField<(.+),\s*(.+)>$", text)
    if mapping:
        return (
            f"map<{_cs_map_type(mapping.group(1), messages, enums)}, "
            f"{_cs_map_type(mapping.group(2), messages, enums)}>"
        )
    if text in _CS_SCALARS:
        return _CS_SCALARS[text]
    simple = text.rsplit(".", 1)[-1]
    if simple in enums:
        return simple
    if simple in messages:
        return simple
    return "bytes"


def parse_cs_schema(cs_dir: Path) -> Tuple[Dict[str, List[Tuple[int, str, str]]], Dict[str, List[Tuple[str, int]]]]:
    """把一个目录下的 C# 文件解析成 {消息名: [(字段号, 字段名, C# 类型)]} 与枚举表。"""
    messages: Dict[str, List[Tuple[int, str, str]]] = {}
    enums: Dict[str, List[Tuple[str, int]]] = {}
    for path in sorted(Path(cs_dir).glob("*.cs")):
        try:
            src = path.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        _cs_parse_types(src, "", messages, enums)
    return messages, enums


def compose_merged_proto(
    messages: Dict[str, List[Tuple[int, str, str]]],
    enums: Dict[str, List[Tuple[str, int]]],
) -> str:
    """把解析结果拼成一份 proto3（package 与 DNFBDmp 输出保持一致）。"""
    used_enums = set()
    for rows in messages.values():
        for _num, _field, type_name in rows:
            for word in re.findall(r"\b(\w+)\b", type_name or ""):
                if word in enums:
                    used_enums.add(word)
    lines = ["syntax = \"proto3\";", "", "package BlackJack.ConfigData;", ""]
    for name in sorted(used_enums):
        members = enums[name]
        if not members:
            continue
        lines.append(f"enum {name} {{")
        for member, value in members:
            lines.append(f"  {member} = {value};")
        lines.append("}")
        lines.append("")
    for name in sorted(messages):
        rows = [
            (num, field, _cs_map_type(type_name, messages, enums))
            for num, field, type_name in messages[name]
        ]
        if not rows:
            continue
        lines.append(f"message {name} {{")
        for num, field, proto_type in rows:
            lines.append(f"  {proto_type} {field} = {num};")
        lines.append("}")
        lines.append("")
    return "\n".join(lines)


def ensure_cs_schema_dir(dll_path: str, key: str, refresh: bool = False) -> Optional[Path]:
    """用 ilspycmd 反编译热更 DLL，只留下 BlackJack.ConfigData 命名空间的 C#。"""
    ns_dir = Path(SCHEMA_CACHE_DIR) / f"cs_{key}" / CS_SCHEMA_NAMESPACE
    if ns_dir.is_dir() and any(ns_dir.glob("*.cs")) and not refresh:
        return ns_dir
    ilspy = shutil.which("ilspycmd")
    if not ilspy:
        return None
    tmp = tempfile.mkdtemp(prefix="tdj_ilspy_")
    try:
        console.print(
            f"[cyan]反编译热更 DLL[/cyan] {os.path.basename(dll_path)}"
            "（ilspycmd，首次约 1 分钟，之后走缓存）"
        )
        proc = subprocess.run(
            [ilspy, "-p", "-o", tmp, dll_path],
            capture_output=True,
            text=True,
            timeout=SCHEMA_TIMEOUT,
        )
        src_ns = Path(tmp) / CS_SCHEMA_NAMESPACE
        files = sorted(src_ns.glob("*.cs")) if src_ns.is_dir() else []
        if len(files) < 100:
            console.print(
                f"[yellow]⚠ ilspycmd 反编译不完整（{(proc.stdout or proc.stderr or '').strip()[-200:]}）[/yellow]"
            )
            return None
        ns_dir.parent.mkdir(parents=True, exist_ok=True)
        if ns_dir.exists():
            shutil.rmtree(ns_dir)
        shutil.copytree(src_ns, ns_dir)
        console.print(f"   反编译完成：{len(files)} 个 C# → {ns_dir}")
        return ns_dir
    except Exception as e:  # noqa: BLE001
        console.print(f"[yellow]⚠ ilspycmd 失败: {e}[/yellow]")
        return None
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


def build_cs_fdset(dll_path: str, key: str, refresh: bool = False) -> Optional[bytes]:
    """热更 DLL → C# → proto → FileDescriptorSet（带缓存）。"""
    fdset_path = os.path.join(SCHEMA_CACHE_DIR, f"cs_{key}_v{CS_PARSER_VERSION}.pb")
    cs_dir = ensure_cs_schema_dir(dll_path, key, refresh=refresh)
    if cs_dir is None:
        return None
    out_dir = Path(SCHEMA_CACHE_DIR) / f"cs_{key}"
    out_dir.mkdir(parents=True, exist_ok=True)
    proto_path = out_dir / MERGED_PROTO_NAME
    fdset_tmp = out_dir / "merged.pb"
    version_path = out_dir / "parser.version"
    cached_version = (
        version_path.read_text(encoding="utf-8").strip() if version_path.is_file() else ""
    )
    if cached_version != str(CS_PARSER_VERSION):
        messages, enums = parse_cs_schema(cs_dir)
        if not messages:
            return None
        proto_path.write_text(compose_merged_proto(messages, enums), encoding="utf-8")
        version_path.write_text(str(CS_PARSER_VERSION), encoding="utf-8")
        console.print(
            f"[green]proto 来源[/green] {os.path.basename(dll_path)} 反编译的 C#："
            f"{len(messages)} 个消息类 → {proto_path}"
        )
    if os.path.isfile(fdset_path) and not refresh:
        return Path(fdset_path).read_bytes()
    protoc = shutil.which("protoc")
    if not protoc:
        raise EnvironmentError("未找到 protoc，请先安装 protobuf-compiler")
    r = subprocess.run(
        [
            protoc,
            "-I",
            str(out_dir),
            "--include_imports",
            f"--descriptor_set_out={fdset_tmp}",
            str(proto_path),
        ],
        capture_output=True,
        text=True,
        timeout=600,
    )
    if r.returncode != 0:
        raise RuntimeError(f"编译 C# 推断的 proto 失败：{(r.stderr or r.stdout).strip()}")
    data = fdset_tmp.read_bytes()
    Path(fdset_path).write_bytes(data)
    return data


def build_schema_fdset(
    refresh: bool = False,
    source: str = "auto",
    dll_names: Optional[List[str]] = None,
) -> Tuple[bytes, str]:
    """按来源生成 FileDescriptorSet：热更 DLL 反编译的 C# 优先，DNFBDmp 兜底。"""
    source = (source or "auto").lower()
    if source in ("auto", "cs"):
        dll_path = find_hotupdate_dll()
        if dll_path:
            key = _cs_cache_key(dll_path)
            data = build_cs_fdset(dll_path, key, refresh=refresh)
            if data is not None:
                console.print(
                    f"[cyan]proto 来源[/cyan] {os.path.basename(dll_path)}"
                    " 反编译的 C#（ilspycmd + 自研推断）"
                )
                return data, f"C# 推断（{os.path.basename(dll_path)}）"
            if source == "cs":
                raise RuntimeError(f"从 {dll_path} 反编译推断 proto 失败")
            console.print("[yellow]⚠ C# 推断不可用，回退 DNFBDmp[/yellow]")
        elif source == "cs":
            raise FileNotFoundError(
                f"没找到热更 DLL（{DLL_DIR} 下的 {'/'.join(HOTUPDATE_DLL_CANDIDATES)}）"
            )
    dll_files = schema_dll_files(names=dll_names)
    key = _schema_cache_key(dll_files)
    console.print(
        f"[cyan]proto 来源[/cyan] DNFBDmp 推断"
        f"（{', '.join(os.path.basename(p) for p in dll_files)}）"
    )
    return build_merged_fdset(dll_files, key, refresh=refresh), "DNFBDmp 推断（Assembly-CSharp*.dll）"


@functools.lru_cache(maxsize=8)
def _load_merged_pool_and_index_cached(
    schema_key: str,
    refresh: bool,
    source: str = "auto",
    dll_names: Optional[Tuple[str, ...]] = None,
):
    from google.protobuf.descriptor_pb2 import FileDescriptorSet
    from google.protobuf.descriptor_pool import DescriptorPool
    from google.protobuf.message_factory import GetMessageClass

    fds = FileDescriptorSet.FromString(
        build_schema_fdset(
            refresh=refresh,
            source=source,
            dll_names=list(dll_names) if dll_names else None,
        )[0]
    )
    pool = DescriptorPool()
    for fd in fds.file:
        try:
            pool.Add(fd)
        except Exception:
            pool.AddSerializedFile(fd.SerializeToString())

    simple_index: Dict[str, List[str]] = {}

    def add_index(key: str, full_name: str):
        low = key.lower()
        bucket = simple_index.setdefault(low, [])
        if full_name not in bucket:
            bucket.append(full_name)

    def walk(pkg: str, prefix: str, messages):
        for msg in messages:
            full_name = ".".join(part for part in (pkg, prefix, msg.name) if part)
            simple = full_name.split(".")[-1]
            add_index(simple, full_name)
            if simple.lower().endswith("info"):
                add_index(simple[:-4], full_name)
            walk(
                pkg,
                ".".join(part for part in (prefix, msg.name) if part),
                msg.nested_type,
            )

    for fd in fds.file:
        walk(fd.package, "", fd.message_type)

    def make_message(full_name: str):
        desc = pool.FindMessageTypeByName(full_name)
        cls = GetMessageClass(desc)
        return cls()

    return pool, make_message, simple_index


def load_merged_pool_and_index(
    refresh: bool = False,
    source: str = "auto",
    dll_names: Optional[List[str]] = None,
):
    """按来源+DLL 指纹加载 proto 池（没缓存时才跑推断，结果落盘复用）。"""
    source = (source or "auto").lower()
    names = tuple(dll_names) if dll_names else None
    hot = find_hotupdate_dll()
    if source in ("auto", "cs") and hot and not names:
        key = _cs_cache_key(hot)
    else:
        key = _schema_cache_key(schema_dll_files(names=list(names) if names else None))
    return _load_merged_pool_and_index_cached(
        f"{key}:{source}:{names}", bool(refresh), source, names
    )


def build_schema_index() -> Dict[str, str]:
    index: Dict[str, str] = {}
    sdir = schema_dir()
    if not os.path.isdir(sdir):
        return index
    for name in os.listdir(sdir):
        if not name.lower().endswith(".proto"):
            continue
        stem = os.path.splitext(name)[0]
        index[stem.lower()] = stem
        if stem.lower().endswith("info"):
            index[stem[:-4].lower()] = stem
    return index


def _iter_file_lookup_keys(stem: str):
    seen = set()

    def add(v: str):
        v = v.lower()
        if v and v not in seen:
            seen.add(v)
            yield v

    low = stem.lower()
    base = re.sub(r"_\d+$", "", low)
    for item in add(low):
        yield item
    if base != low:
        for item in add(base):
            yield item
    for candidate in (low, base):
        if candidate.endswith("info"):
            for item in add(candidate[:-4]):
                yield item
        else:
            for item in add(candidate + "info"):
                yield item


SPECIAL_STEM_ALIASES = {
    "configdatamozicontentbossfeature": "configdatamozicontentbossfeatureinfo",
}


def resolve_message_candidates(
    stem: str,
    schema_index: Dict[str, str],
    merged_index: Dict[str, List[str]],
) -> Tuple[Optional[str], List[str]]:
    candidates: List[str] = []
    seen_full = set()
    canonical_schema = None

    def add_full(full_name: str):
        if full_name not in seen_full:
            seen_full.add(full_name)
            candidates.append(full_name)

    keys = list(_iter_file_lookup_keys(stem))
    for key in list(keys):
        alias = SPECIAL_STEM_ALIASES.get(key)
        if alias and alias not in keys:
            keys.append(alias)

    for key in keys:
        schema_stem = schema_index.get(key)
        if schema_stem and canonical_schema is None:
            canonical_schema = schema_stem
        if schema_stem:
            for full_name in merged_index.get(schema_stem.lower(), []):
                add_full(full_name)
        for full_name in merged_index.get(key, []):
            add_full(full_name)

    if canonical_schema is None and candidates:
        canonical_schema = candidates[0].split(".")[-1]
    return canonical_schema, candidates


def parse_configdata_messages(
    raw: bytes, make_message, full_type: str
) -> Optional[List[Any]]:
    if not raw:
        return None
    if len(raw) == 4 and raw == b"\x00\x00\x00\x00":
        return []

    def _one(blob: bytes) -> Any:
        msg = make_message(full_type)
        msg.ParseFromString(blob)
        return msg

    if len(raw) >= 8:
        count, first_len = struct.unpack(">II", raw[:8])
        if count > 0 and first_len > 0:
            pos = 8
            msgs: List[Any] = []
            msg_len = first_len
            ok = True
            for i in range(count):
                if msg_len <= 0 or pos + msg_len > len(raw):
                    ok = False
                    break
                try:
                    msgs.append(_one(raw[pos : pos + msg_len]))
                except Exception:
                    ok = False
                    break
                pos += msg_len
                if i < count - 1:
                    if pos == len(raw) and msgs:
                        return msgs
                    if pos + 4 > len(raw):
                        ok = False
                        break
                    msg_len = struct.unpack(">I", raw[pos : pos + 4])[0]
                    pos += 4
            if ok and pos == len(raw) and msgs:
                return msgs

    if len(raw) > 8:
        c1, _ = struct.unpack(">II", raw[:8])
        if c1 == 1:
            try:
                return [_one(raw[8:])]
            except Exception:
                pass

    if len(raw) >= 12:
        _c, zero, body_len = struct.unpack(">III", raw[:12])
        if zero == 0 and body_len > 0 and 12 + body_len == len(raw):
            try:
                return [_one(raw[12:])]
            except Exception:
                pass

    if len(raw) >= 12:
        count, zero, first_len = struct.unpack(">III", raw[:12])
        if count > 0 and zero == 0 and first_len > 0:
            pos = 12
            msgs = []
            msg_len = first_len
            ok = True
            for i in range(count):
                if msg_len <= 0 or pos + msg_len > len(raw):
                    ok = False
                    break
                try:
                    msgs.append(_one(raw[pos : pos + msg_len]))
                except Exception:
                    ok = False
                    break
                pos += msg_len
                if i < count - 1:
                    if pos == len(raw) and msgs:
                        return msgs
                    if pos + 4 > len(raw):
                        ok = False
                        break
                    msg_len = struct.unpack(">I", raw[pos : pos + 4])[0]
                    pos += 4
            if ok and pos == len(raw) and msgs:
                return msgs

    if len(raw) >= 12:
        _c, second = struct.unpack(">II", raw[:8])
        if second == 0:
            pos = 12
            short_msgs: List[Any] = []
            while pos + 2 <= len(raw):
                if pos + 4 <= len(raw) and raw[pos : pos + 4] == b"\x00\x00\x00\x02":
                    pos += 4
                if pos + 2 <= len(raw) and raw[pos] == 0x10:
                    try:
                        short_msgs.append(_one(raw[pos : pos + 2]))
                    except Exception:
                        short_msgs.clear()
                        break
                    pos += 2
                else:
                    break
            if short_msgs:
                return short_msgs

    try:
        return [_one(raw)]
    except Exception:
        return None


def _read_varint(buf: bytes, pos: int) -> Tuple[int, int]:
    value = 0
    shift = 0
    while True:
        if pos >= len(buf):
            raise EOFError("unexpected eof while reading varint")
        b = buf[pos]
        pos += 1
        value |= (b & 0x7F) << shift
        if b < 0x80:
            return value, pos
        shift += 7
        if shift > 64:
            raise ValueError("varint too long")


def _parse_wire_fields(blob: bytes) -> List[Tuple[int, int, bytes]]:
    pos = 0
    out: List[Tuple[int, int, bytes]] = []
    while pos < len(blob):
        tag, pos = _read_varint(blob, pos)
        field_number = tag >> 3
        wire_type = tag & 0x07
        if wire_type == 0:
            start = pos
            _, pos = _read_varint(blob, pos)
            out.append((field_number, wire_type, blob[start:pos]))
        elif wire_type == 1:
            out.append((field_number, wire_type, blob[pos : pos + 8]))
            pos += 8
        elif wire_type == 2:
            size, pos = _read_varint(blob, pos)
            out.append((field_number, wire_type, blob[pos : pos + size]))
            pos += size
        elif wire_type == 5:
            out.append((field_number, wire_type, blob[pos : pos + 4]))
            pos += 4
        else:
            raise ValueError(f"unsupported wire type: {wire_type}")
    return out


def _decode_packed_ints(blob: bytes) -> List[int]:
    pos = 0
    values: List[int] = []
    while pos < len(blob):
        value, pos = _read_varint(blob, pos)
        values.append(value)
    return values


def _decode_nested_message_dict(
    blob: bytes, make_message, full_type: str
) -> Dict[str, Any]:
    from google.protobuf.json_format import MessageToDict

    msg = make_message(full_type)
    msg.ParseFromString(blob)
    return MessageToDict(msg, preserving_proto_field_name=True)


def parse_story_sum_item_info_custom(
    raw: bytes, make_message
) -> Optional[List[Dict[str, Any]]]:
    if len(raw) < 8:
        return None
    count, first_len = struct.unpack(">II", raw[:8])
    if count <= 0 or first_len <= 0:
        return None

    pos = 8
    msg_len = first_len
    rows: List[Dict[str, Any]] = []
    for i in range(count):
        if msg_len <= 0 or pos + msg_len > len(raw):
            return None
        blob = raw[pos : pos + msg_len]
        pos += msg_len
        if i < count - 1:
            if pos + 4 > len(raw):
                return None
            next_len = struct.unpack(">I", raw[pos : pos + 4])[0]
            pos += 4
        else:
            next_len = 0

        row: Dict[str, Any] = {}
        try:
            for field_number, wire_type, value in _parse_wire_fields(blob):
                if field_number == 2 and wire_type == 0:
                    row["ID"], _ = _read_varint(value, 0)
                elif field_number == 3 and wire_type == 0:
                    row["GameFunType"], _ = _read_varint(value, 0)
                elif field_number == 4 and wire_type == 2:
                    row.setdefault("JumpGameFunType", []).append(
                        _decode_nested_message_dict(
                            value, make_message, "BlackJack.ConfigData.StoryJumpInfo"
                        )
                    )
                elif field_number == 5 and wire_type == 2:
                    row.setdefault("OpenCondition", []).append(
                        _decode_nested_message_dict(
                            value, make_message, "BlackJack.ConfigData.ConditionInfo"
                        )
                    )
                elif field_number == 6 and wire_type == 2:
                    row.setdefault("FunParam", []).append(
                        _decode_nested_message_dict(
                            value, make_message, "BlackJack.ConfigData.SSItemParam"
                        )
                    )
                elif field_number == 7 and wire_type == 2:
                    row["ExcludeDropIds"] = _decode_packed_ints(value)
                elif field_number == 8 and wire_type == 2:
                    row["ItemIds"] = _decode_packed_ints(value)
                elif field_number == 9 and wire_type == 2:
                    try:
                        row["UnknownField9"] = _decode_packed_ints(value)
                    except Exception:
                        row["UnknownField9"] = value.hex()
                elif field_number == 10 and wire_type == 2:
                    row["BGImage"] = value.decode("utf-8")
                elif field_number == 11 and wire_type == 2:
                    row["SubSmallBGImage"] = value.decode("utf-8")
                elif field_number == 12 and wire_type == 2:
                    row["SubBorderTag"] = value.decode("utf-8")
                elif field_number == 13 and wire_type == 2:
                    row.setdefault("AdjustPos", []).append(
                        _decode_nested_message_dict(
                            value, make_message, "BlackJack.ConfigData.OffsetScale"
                        )
                    )
                elif field_number == 14 and wire_type == 2:
                    row["TitleStrKey"] = value.decode("utf-8")
                elif field_number == 15 and wire_type == 2:
                    row["TitleTagStrKey"] = value.decode("utf-8")
                elif field_number == 16 and wire_type == 2:
                    row["SubTitleStrKey"] = value.decode("utf-8")
                elif field_number == 17 and wire_type == 2:
                    row["DescStrKey"] = value.decode("utf-8")
                elif field_number == 18 and wire_type == 2:
                    row["SubBottomTagStrKey"] = value.decode("utf-8")
        except Exception:
            return None

        rows.append(row)
        msg_len = next_len

    return rows if pos == len(raw) else None


def export_json_from_memory(
    schema_index: Dict[str, str],
    files: Dict[str, bytes],
    master_root: str,
    refresh_schema: bool = False,
    schema_dlls: Optional[List[str]] = None,
    schema_source: str = "auto",
) -> Tuple[int, int]:
    from google.protobuf.json_format import MessageToDict

    ok, fail, empty_tables = 0, 0, 0
    stat_no_schema = 0
    stat_parse = 0
    stat_empty_raw = 0
    stat_dict = 0
    failure_details: List[Dict[str, str]] = []
    master_root = os.path.abspath(master_root)

    def record_failure(file_name: str, reason: str, detail: str = ""):
        item = {"file": file_name, "reason": reason}
        if detail:
            item["detail"] = detail
        failure_details.append(item)

    all_files = sorted(
        name
        for name in files
        if os.path.splitext(name)[1].lower() in (".bytes", ".bin")
    )
    _, make_message, merged_index = load_merged_pool_and_index(
        refresh=refresh_schema, source=schema_source, dll_names=schema_dlls
    )
    console.print(
        f"仅处理 configdata00 目录中的 {len(all_files)} 个数据文件，并平铺导出到 {master_root}"
    )

    for base_name in all_files:
        stem, _ = os.path.splitext(base_name)
        resolved_schema, candidates = resolve_message_candidates(
            stem, schema_index, merged_index
        )
        if not candidates:
            stat_no_schema += 1
            fail += 1
            record_failure(base_name, "无可用消息类型匹配")
            continue

        raw = files[base_name]
        if len(raw) == 0:
            stat_empty_raw += 1
            fail += 1
            record_failure(base_name, "空文件")
            continue

        msgs = None
        custom_rows = None
        for full_type in candidates:
            try:
                msgs = parse_configdata_messages(raw, make_message, full_type)
                if msgs is not None:
                    break
            except Exception:
                msgs = None
        if msgs is None and stem.lower() == "configdatastorysumiteminfo":
            custom_rows = parse_story_sum_item_info_custom(raw, make_message)
        if msgs is None and custom_rows is None:
            stat_parse += 1
            fail += 1
            record_failure(
                base_name, "二进制与 proto 解析不匹配", ", ".join(candidates[:5])
            )
            continue

        try:
            if custom_rows is not None:
                d = custom_rows
            elif len(msgs) == 0:
                d = []
                empty_tables += 1
            elif len(msgs) == 1:
                d = MessageToDict(msgs[0], preserving_proto_field_name=True)
            else:
                d = [MessageToDict(m, preserving_proto_field_name=True) for m in msgs]
        except Exception:
            stat_dict += 1
            fail += 1
            record_failure(base_name, "转 JSON 异常")
            continue

        out_name = stem if re.search(r"_\d+$", stem) else (resolved_schema or stem)
        with open(
            os.path.join(master_root, f"{out_name}.json"), "w", encoding="utf-8"
        ) as jf:
            json.dump(d, jf, ensure_ascii=False, indent=2)
        ok += 1

    if empty_tables:
        console.print(
            f"[gray]其中空表（仅写入 []）{empty_tables} 个，多为 4 字节全 0 占位。[/]"
        )
    console.print(
        "[dim]失败原因统计："
        f"无可用消息类型匹配：{stat_no_schema}；"
        f"二进制与 proto 解析不匹配：{stat_parse}；"
        f"空文件：{stat_empty_raw}；"
        f"转 JSON 异常：{stat_dict}。[/]"
    )
    return ok, fail


# ---------------------------------------------------------------------------
# 立绘模式
#
# 真机逻辑（热更 DLL BlackJack.ProjectU.UI.DestinyUIHeroImgItem.ShowChr /
# ShareCardTenHeroShowItem.Show / GDTribulationSpListItemUIController.UpdateChar）：
#     cfg.GetCharacterShowInfo().HeroPainting
#         -> AssetUtility.GetAsset<GameObject>(prefab) -> Instantiate(prefab)
# 也就是直接实例化 ConfigDataCharacterShowInfo.HeroPainting 指向的 prefab。
#
# prefab 里立绘是多个 Image 节点：主图 + 超出 2048 画布的“边缘分件”
# （例如 Hero1016_Img_1 + Hero1016_img_02..04）。分件不是运行时拼的，
# 布局就写在 RectTransform 里，所以还原 = 按 prefab 把各节点贴回画布：
#   * 位置：anchoredPosition 按主图宽（贴图像素 / RectTransform 尺寸）缩放；
#   * 尺寸：用贴图原始像素 1:1 贴回（接缝实测比按 prefab 缩放更连续）；
#   * 顺序：主图先画、分件后画（与 prefab 层级一致）。
# ---------------------------------------------------------------------------

GAME_TITLE = "天地劫"
PAINTING_DIR = os.path.join(ROOT_DIR, "Painting")
HERO_PAINTING_PREFAB_BUNDLE = "ui_uiprefab_heropaintingprefab_abs.b"
HERO_PAINTING_IMAGE_PREFIX = "ui_uiimage_heropainting_abs"


def _safe_fs_name(text: str) -> str:
    """文件名里不能出现的字符换成全角。"""
    table = str.maketrans({
        "/": "／", "\\": "＼", ":": "：", "*": "＊", "?": "？",
        '"': "'", "<": "＜", ">": "＞", "|": "｜",
        "\n": "", "\r": "", "\t": " ",
    })
    out = str(text or "").translate(table).strip()
    return out or "未知"


def load_cn_string_table(master_dir: Optional[Path] = None) -> Dict[int, str]:
    """MasterData/configdatast_cn_*.json -> {字符串ID: 文本}。"""
    table: Dict[int, str] = {}
    root = Path(master_dir) if master_dir else Path(MASTER_DIR)
    for path in sorted(root.glob("configdatast_cn_*.json")):
        try:
            rows = json.loads(path.read_text(encoding="utf-8"))
        except Exception:
            continue
        for row in rows:
            key = row.get("ID")
            if isinstance(key, int):
                table[key] = row.get("Value")
    return table


def _str_key_text(key: str, table: Dict[int, str]) -> str:
    m = re.match(r"ST:(\d+)", str(key or ""))
    if not m:
        return str(key or "")
    return table.get(int(m.group(1)), "") or ""


# ConfigDataCharacterShowInfo / ConfigDataCharacterInfo /
# ConfigDataCharacterSkinInfo / configdatast_cn_* 的 protobuf 字段号
# （取自重建后的热更 DLL：XxxFieldNumber 常量，例如 HeroPaintingFieldNumber = 32、
#   configdatast_cn_* 的 IDFieldNumber = 2 / ValueFieldNumber = 3）
# 注意：皮肤表（CharacterSkinInfo）的主键就是 ShowInfo 的 ID（例如 251000），
# 不是 ShowInfo 里的 SkinId 字段（字段号 6，那是另一套编号）。
_SHOWINFO_FIELD_ID = 2
_SHOWINFO_FIELD_OWNER = 5
_SHOWINFO_FIELD_HERO_PAINTING = 32
_CHARINFO_FIELD_ID = 2
_CHARINFO_FIELD_NAME_KEY = 31
_SKININFO_FIELD_ID = 2
_SKININFO_FIELD_NAME_KEY = 21
_ST_FIELD_ID = 2
_ST_FIELD_VALUE = 3


def _pb_read_varint(buf: bytes, pos: int) -> Tuple[int, int]:
    value = 0
    shift = 0
    while True:
        b = buf[pos]
        pos += 1
        value |= (b & 0x7F) << shift
        shift += 7
        if not (b & 0x80):
            return value, pos


def _pb_walk(msg: bytes) -> Dict[int, Any]:
    """极简 protobuf 解析：{字段号: 值}（重复字段取第一个）。"""
    out: Dict[int, Any] = {}
    pos = 0
    size = len(msg)
    while pos < size:
        tag, pos = _pb_read_varint(msg, pos)
        field, wire = tag >> 3, tag & 7
        if wire == 0:
            value, pos = _pb_read_varint(msg, pos)
        elif wire == 2:
            length, pos = _pb_read_varint(msg, pos)
            value = msg[pos:pos + length]
            pos += length
        elif wire == 5:
            value = msg[pos:pos + 4]
            pos += 4
        elif wire == 1:
            value = msg[pos:pos + 8]
            pos += 8
        else:
            break
        out.setdefault(field, value)
    return out


def _configdata_rows(raw: bytes) -> List[Dict[int, Any]]:
    """configdata TextAsset 容器： [u32BE count][ (u32BE len)(protobuf) ]*。"""
    if len(raw) < 8:
        return []
    count = struct.unpack_from(">I", raw, 0)[0]
    pos = 4
    rows: List[Dict[int, Any]] = []
    while pos + 4 <= len(raw) and len(rows) < count:
        length = struct.unpack_from(">I", raw, pos)[0]
        pos += 4
        if length <= 0 or pos + length > len(raw):
            break
        rows.append(_pb_walk(raw[pos:pos + length]))
        pos += length
    return rows


def _bundle_text_assets(bundle_path: Path, prefixes: Tuple[str, ...]) -> Dict[str, bytes]:
    """从 configdata_abs.b 取需要的 TextAsset（当前版本原始表）。"""
    env = UnityPy.load(str(bundle_path))
    out: Dict[str, bytes] = {}
    for path, obj in env.container.items():
        if obj.type.name != "TextAsset":
            continue
        name = str(path).replace("\\", "/").rsplit("/", 1)[-1].lower()
        if name.endswith(".bytes") and name.startswith(prefixes):
            try:
                out[name[:-6]] = get_textasset_bytes(obj, obj.read())
            except Exception:
                continue
    return out


def _load_painting_entries_from_bundle(bundle_path: Path) -> List[Dict[str, str]]:
    """直接从当前 configdata_abs.b 的原始 protobuf 表解析立绘命名条目。

    MasterData/*.json 可能是旧版本导出（少掉新英雄的行、字符串表缺新条目），
    所以优先用原始表；字段号与 JSON 表一致。返回每个 HeroPainting 行一条：
    {stem(角色+皮肤), char, skin, owner, show_id}。
    """
    assets = _bundle_text_assets(bundle_path, ("configdatacharactershowinfo",
                                               "configdatacharacterinfo",
                                               "configdatacharacterskininfo",
                                               "configdatast_cn_"))
    show_raw = assets.get("configdatacharactershowinfo")
    char_raw = assets.get("configdatacharacterinfo")
    if not show_raw or not char_raw:
        return []

    st: Dict[int, str] = {}
    for name, raw in assets.items():
        if not name.startswith("configdatast_cn_"):
            continue
        for row in _configdata_rows(raw):
            sid = row.get(_ST_FIELD_ID)
            val = row.get(_ST_FIELD_VALUE)
            if isinstance(sid, int) and isinstance(val, bytes):
                st[sid] = val.decode("utf-8", "replace")

    char_name_key = {
        row.get(_CHARINFO_FIELD_ID): row.get(_CHARINFO_FIELD_NAME_KEY)
        for row in _configdata_rows(char_raw)
        if isinstance(row.get(_CHARINFO_FIELD_ID), int)
    }
    skin_name_key = {}
    skin_raw = assets.get("configdatacharacterskininfo")
    if skin_raw:
        for row in _configdata_rows(skin_raw):
            if isinstance(row.get(_SKININFO_FIELD_ID), int):
                skin_name_key[row[_SKININFO_FIELD_ID]] = row.get(_SKININFO_FIELD_NAME_KEY)

    def text(key) -> str:
        if not isinstance(key, bytes):
            return ""
        m = re.match(rb"ST:(\d+)", key)
        return st.get(int(m.group(1)), "") if m else key.decode("utf-8", "replace")

    entries: List[Dict[str, str]] = []
    for row in _configdata_rows(show_raw):
        hp = row.get(_SHOWINFO_FIELD_HERO_PAINTING)
        if not isinstance(hp, bytes) or b"HeroPaintingPrefab_ABS" not in hp:
            continue
        stem = re.sub(r"\.prefab$", "", hp.decode("utf-8", "replace").rsplit("/", 1)[-1], flags=re.I)
        entries.append({
            "stem": stem,
            "char": text(char_name_key.get(row.get(_SHOWINFO_FIELD_OWNER))),
            "skin": text(skin_name_key.get(row.get(_SHOWINFO_FIELD_ID))),
            "owner": str(row.get(_SHOWINFO_FIELD_OWNER) or ""),
            "show_id": str(row.get(_SHOWINFO_FIELD_ID) or ""),
        })
    return entries


@functools.lru_cache(maxsize=4)
def _painting_entries_cached(bundle_path: str, mtime: float) -> Tuple[Dict[str, str], ...]:
    del mtime  # 仅用于缓存失效
    return tuple(_load_painting_entries_from_bundle(Path(bundle_path)))


def load_painting_entries(
    assets_dir: Optional[Path] = None, master_dir: Optional[Path] = None
) -> List[Dict[str, str]]:
    """当前立绘命名条目（优先原始 configdata_abs.b，其次旧 MasterData JSON）。

    命名表必须用当前版本的数据表，否则新英雄（例如 Hero2510）不在表里，
    贴图包里就算有 Hero2510_Img 也不会被导出。
    """
    bundle_path = Path(assets_dir or ASSETS_DIR) / TARGET_BUNDLE_NAME
    if bundle_path.is_file():
        try:
            entries = list(_painting_entries_cached(str(bundle_path), bundle_path.stat().st_mtime))
            if entries:
                return entries
        except Exception:
            pass
    return _entries_from_json(master_dir)


def _entries_from_json(master_dir: Optional[Path] = None) -> List[Dict[str, str]]:
    root = Path(master_dir) if master_dir else Path(MASTER_DIR)
    st = load_cn_string_table(root)

    def load(name: str) -> List[Dict[str, Any]]:
        path = root / name
        if not path.is_file():
            return []
        try:
            data = json.loads(path.read_text(encoding="utf-8"))
        except Exception:
            return []
        return data if isinstance(data, list) else []

    char_info = {r.get("ID"): r for r in load("ConfigDataCharacterInfo.json")}
    skin_info = {r.get("ID"): r for r in load("ConfigDataCharacterSkinInfo.json")}
    entries: List[Dict[str, str]] = []
    for row in load("ConfigDataCharacterShowInfo.json"):
        hp = str(row.get("HeroPainting") or "")
        m = re.search(r"/([^/]+)\.prefab$", hp, re.I)
        if not m:
            continue
        char = char_info.get(row.get("OwnerCharId"), {})
        skin = skin_info.get(row.get("ID"), {})
        entries.append({
            "stem": m.group(1),
            "char": _str_key_text(char.get("NameStrKey"), st)
            or _str_key_text(row.get("NamePingYingStrKey"), st),
            "skin": _str_key_text(skin.get("NameStrKey"), st),
            "owner": str(row.get("OwnerCharId") or ""),
            "show_id": str(row.get("ID") or ""),
        })
    return entries


def load_painting_name_map(
    assets_dir: Optional[Path] = None, master_dir: Optional[Path] = None
) -> Dict[str, Dict[str, str]]:
    """HeroPainting prefab 名 -> {角色名, 皮肤名, OwnerCharId, ShowId}。
    """
    result: Dict[str, Dict[str, str]] = {}
    for entry in load_painting_entries(assets_dir, master_dir):
        stem = entry["stem"]
        old = result.get(stem)
        if old is None or (not old.get("skin") and entry["skin"]) or (
            not old.get("char") and entry["char"]
        ):
            result[stem] = dict(entry)
    if result:
        return result
    return _load_painting_name_map_from_json(master_dir)


def _load_painting_name_map_from_json(
    master_dir: Optional[Path] = None,
) -> Dict[str, Dict[str, str]]:
    """MasterData JSON 版本（旧导出的兜底）。"""
    root = Path(master_dir) if master_dir else Path(MASTER_DIR)
    st = load_cn_string_table(root)

    def load(name: str) -> List[Dict[str, Any]]:
        path = root / name
        if not path.is_file():
            return []
        try:
            data = json.loads(path.read_text(encoding="utf-8"))
        except Exception:
            return []
        return data if isinstance(data, list) else []

    char_info = {r.get("ID"): r for r in load("ConfigDataCharacterInfo.json")}
    skin_info = {r.get("ID"): r for r in load("ConfigDataCharacterSkinInfo.json")}
    result: Dict[str, Dict[str, str]] = {}
    for row in load("ConfigDataCharacterShowInfo.json"):
        hp = str(row.get("HeroPainting") or "")
        m = re.search(r"/([^/]+)\.prefab$", hp, re.I)
        if not m:
            continue
        stem = m.group(1)
        char = char_info.get(row.get("OwnerCharId"), {})
        skin = skin_info.get(row.get("ID"), {})
        entry = {
            "char": _str_key_text(char.get("NameStrKey"), st)
            or _str_key_text(row.get("NamePingYingStrKey"), st),
            "pinyin": _str_key_text(row.get("NamePingYingStrKey"), st),
            "owner": str(row.get("OwnerCharId") or ""),
            "show_id": str(row.get("ID") or ""),
        }
        old = result.get(stem)
        if old is None or (not old.get("skin") and entry["skin"]) or (
            not old.get("char") and entry["char"]
        ):
            result[stem] = entry
    return result


def painting_filename(
    char: str, used: set, notes: Optional[List[str]] = None
) -> str:
    """游戏名_角色名_皮肤名[_备注...].png，重名自动追加序号。"""
    parts = [GAME_TITLE, _safe_fs_name(char)]
    for note in notes or []:
        cleaned = _safe_fs_name(note)
        if cleaned and cleaned != "未知":
            parts.append(cleaned)
    base = "_".join(p for p in parts if p) + ".png"
    if base not in used:
        used.add(base)
        return base
    n = 2
    while f"{'_'.join(parts)}_{n}.png" in used:
        n += 1
    name = "_".join(parts) + f"_{n}.png"
    used.add(name)
    return name


def _hero_painting_assets(assets_dir: Path):
    """载入 prefab 包 + 贴图包。

    返回 (prefab env, serialized file, cab->bundle, sprite 索引, 缺失的 CAB 列表)。

    prefab 内的 m_Sprite 用 m_FileID 指向 externals[CAB]，这里把它映射回
    磁盘上的 ui_uiimage_heropainting_abs_*.b（不依赖 UnityPy 跨包解析）。
    缺失的 CAB 说明对应的 ui_uiimage_heropainting_abs_*.b 没下载，会把
    立绘导成残缺图，调用方据此给出提示。
    """
    prefab_path = assets_dir / HERO_PAINTING_PREFAB_BUNDLE
    if not prefab_path.is_file():
        return None
    env = UnityPy.load(str(prefab_path))
    bf = env.file
    sf = bf.files[list(bf.files.keys())[0]]
    cab2bundle: Dict[str, Path] = {}
    sprite_index: Dict[Tuple[str, int], Any] = {}
    for path in sorted(assets_dir.glob(HERO_PAINTING_IMAGE_PREFIX + "*.b")):
        env2 = UnityPy.load(str(path))
        sf2 = env2.file.files[list(env2.file.files.keys())[0]]
        cab2bundle[sf2.name] = path
        for pid, obj in sf2.objects.items():
            if obj.type.name == "Sprite":
                sprite_index[(path.name, pid)] = obj
    wanted = {
        str(ext.path).rsplit("/", 1)[-1] for ext in (sf.externals or [])
    }
    missing_cabs = sorted(c for c in wanted if c not in cab2bundle)
    return env, sf, cab2bundle, sprite_index, missing_cabs


def _painting_prefab_roots(sf) -> List[Tuple[int, str]]:
    objs = sf.objects

    def tt(obj):
        try:
            return obj.read_typetree()
        except Exception:
            return {}

    roots: List[Tuple[int, str]] = []
    for pid, obj in objs.items():
        if obj.type.name != "RectTransform":
            continue
        node = tt(obj)
        if node.get("m_Father", {}).get("m_PathID", 0) != 0:
            continue
        go = objs.get(node.get("m_GameObject", {}).get("m_PathID"))
        if go is None:
            continue
        name = str(tt(go).get("m_Name", ""))
        if name.startswith("Hero") or name.startswith("Boss"):
            roots.append((pid, name))
    return roots


def _collect_painting_nodes(sf, root_pid: int, cab2bundle, sprite_index):
    """按 Unity UI 规则遍历 prefab，返回每个 Image 节点。

    每个节点：{name, depth, sprite_obj, rect_min, size, sprite_rect, mesh_bounds, sprite_pivot}
      rect_min/size   : 节点 RectTransform 在 prefab 单位下的位置/尺寸（y 向上）
      sprite_rect     : Sprite.m_Rect（px）
      mesh_bounds     : 网格顶点范围（px，相对 sprite 轴心，y 向上）
      sprite_pivot    : Sprite.m_Pivot

    关键点：anchoredPosition 定位的是**轴心(pivot)**而不是矩形中心；
    Image(Simple) 会把 sprite 的 m_Rect 拉伸到 RectTransform 的 sizeDelta。
    """
    from UnityPy.helpers.MeshHelper import MeshHandler

    objs = sf.objects

    def tt(obj):
        try:
            return obj.read_typetree()
        except Exception:
            return {}

    nodes: List[Dict[str, Any]] = []

    def num(obj, key, default):
        """注意不能用 `value or default`：0.0 是合法取值（pivot/anchor 可能正好为 0）。"""
        if obj is None:
            return default
        value = obj.get(key) if isinstance(obj, dict) else getattr(obj, key, None)
        try:
            return float(value)
        except (TypeError, ValueError):
            return default

    # prefab 根节点名（Hero2022 / Boss240709...）用于识别残留的跨角色节点
    root_name = ""
    root_pid_obj = objs.get(root_pid)
    if root_pid_obj is not None:
        root_go = objs.get(tt(root_pid_obj).get("m_GameObject", {}).get("m_PathID"))
        if root_go is not None:
            root_name = str(tt(root_go).get("m_Name", ""))
    m_hero = re.search(r"(\d{3,})", root_name)
    root_hero_id = m_hero.group(1) if m_hero else None

    def walk(pid, depth, parent_rect_min, parent_rect_size):
        node = tt(objs[pid])
        go = objs.get(node.get("m_GameObject", {}).get("m_PathID"))
        if go is None:
            return
        go_tt = tt(go)
        name = str(go_tt.get("m_Name", ""))
        pos = node.get("m_AnchoredPosition") or {}
        delta = node.get("m_SizeDelta") or {}
        scale = node.get("m_LocalScale") or {}
        amin = node.get("m_AnchorMin") or {}
        amax = node.get("m_AnchorMax") or {}
        pivot = node.get("m_Pivot") or {}
        sx = num(scale, "x", 1.0)
        sy = num(scale, "y", 1.0)
        w = num(delta, "x", 0.0) * abs(sx)
        h = num(delta, "y", 0.0) * abs(sy)
        px = num(pivot, "x", 0.5)
        py = num(pivot, "y", 0.5)
        # 锚点参考位置（anchorMin==anchorMax 时为中心点）
        ax = (num(amin, "x", 0.0) + num(amax, "x", 0.5)) / 2.0
        ay = (num(amin, "y", 0.0) + num(amax, "y", 0.5)) / 2.0
        anchor = (
            parent_rect_min[0] + ax * parent_rect_size[0],
            parent_rect_min[1] + ay * parent_rect_size[1],
        )
        # 轴心对齐 anchor + anchoredPosition
        center = (anchor[0] + num(pos, "x", 0.0) * sx,
                  anchor[1] + num(pos, "y", 0.0) * sy)
        rect_min = (center[0] - px * w, center[1] - py * h)

        for comp in go_tt.get("m_Component", []) or []:
            co = objs.get(comp.get("component", {}).get("m_PathID"))
            if co is None or co.type.name != "MonoBehaviour":
                continue
            mb = tt(co)
            sprite_ptr = mb.get("m_Sprite")
            if not isinstance(sprite_ptr, dict) or not sprite_ptr.get("m_PathID"):
                continue
            fid = sprite_ptr.get("m_FileID") or 0
            cab = "*"
            if fid and fid - 1 < len(sf.externals):
                cab = sf.externals[fid - 1].path.rsplit("/", 1)[-1]
            bundle = cab2bundle.get(cab)
            if bundle is None:
                continue
            sprite_obj = sprite_index.get((bundle.name, sprite_ptr["m_PathID"]))
            if sprite_obj is None:
                continue
            sprite = sprite_obj.read()
            # 过滤从别的角色 prefab 复制粘贴后残留的节点
            # （如 Hero2022/白骨夫人 prefab 里残留了 Hero2004 的贴图节点）
            if depth > 0 and root_hero_id:
                m_sp = re.search(r"(?:[Hh]ero|[Hh]reo)(\d{3,})", str(sprite.m_Name))
                if m_sp and m_sp.group(1) != root_hero_id:
                    continue
            mesh = MeshHandler(sprite.m_RD, sf.version)
            mesh.process()
            verts = mesh.m_Vertices or []
            if not verts:
                continue
            ppu = float(getattr(sprite, "m_PixelsToUnits", 100.0) or 100.0)
            xs = [v[0] * ppu for v in verts]
            ys = [v[1] * ppu for v in verts]
            sp = sprite.m_Pivot
            sp_pivot = (num(sp, "x", 0.5), num(sp, "y", 0.5))
            nodes.append({
                "name": name,
                "depth": depth,
                "sprite_obj": sprite_obj,
                "rect_min": rect_min,
                "size": (w, h),
                "sprite_rect": (float(sprite.m_Rect.width), float(sprite.m_Rect.height)),
                "mesh_bounds": (min(xs), max(xs), min(ys), max(ys)),
                "sprite_pivot": sp_pivot,
            })
        for child in node.get("m_Children", []) or []:
            walk(child.get("m_PathID"), depth + 1, rect_min, (w, h))

    walk(root_pid, 0, (0.0, 0.0), (0.0, 0.0))
    return nodes


def compose_painting(sf, root_pid: int, cab2bundle, sprite_index):
    """把 prefab 里的立绘节点按游戏渲染方式拼回完整 PNG。

    每个节点在画布中的绘制范围（prefab 单位）：
      sx = sizeDelta.x / m_Rect.width, sy = sizeDelta.y / m_Rect.height
      X = rect_min.x + (sprite_pivot.x * m_Rect.width + mesh_x) * sx
    再换算成像素：S = 主图 m_Rect.width / 主图 sizeDelta.x。
    """
    from PIL import Image as PILImage
    from UnityPy.export.SpriteHelper import get_image_from_sprite

    nodes = _collect_painting_nodes(sf, root_pid, cab2bundle, sprite_index)
    if not nodes:
        return None
    root = nodes[0]
    root_sprite = root["sprite_obj"].read()
    root_w = float(root_sprite.m_Rect.width) or 1.0
    root_delta_w = root["size"][0] or root_w
    scale = root_w / root_delta_w  # prefab 单位 -> 画布像素

    placed = []
    for node in nodes:
        image = get_image_from_sprite(node["sprite_obj"].read())
        if image is None:
            continue
        rw = node["sprite_rect"][0] or 1.0
        rh = node["sprite_rect"][1] or 1.0
        kx, ky = node["size"][0] / rw, node["size"][1] / rh
        spx, spy = node["sprite_pivot"]
        min_x, max_x, min_y, max_y = node["mesh_bounds"]
        x0 = node["rect_min"][0] + (spx * rw + min_x) * kx
        x1 = node["rect_min"][0] + (spx * rw + max_x) * kx
        y0 = node["rect_min"][1] + (spy * rh + min_y) * ky
        y1 = node["rect_min"][1] + (spy * rh + max_y) * ky
        # prefab 单位 -> 画布像素（y 向上 -> y 向下）
        w_px = max(1, int(round((x1 - x0) * scale)))
        h_px = max(1, int(round((y1 - y0) * scale)))
        placed.append([image, int(round(x0 * scale)), int(round(-y1 * scale)), w_px, h_px])
    if not placed:
        return None

    left = min(p[1] for p in placed)
    top = min(p[2] for p in placed)
    right = max(p[1] + p[3] for p in placed)
    bottom = max(p[2] + p[4] for p in placed)
    canvas = PILImage.new("RGBA", (max(1, right - left), max(1, bottom - top)), (0, 0, 0, 0))
    for image, x, y, w, h in placed:
        if image.size != (w, h):
            image = image.resize((w, h), PILImage.LANCZOS)
        canvas.alpha_composite(image, (x - left, y - top))
    return canvas


def orphan_single_sprite(stem: str, sprite_index):
    """prefab 缺失时，若该角色在贴图包里只有一张 <stem>_Img 整图则直接用。

    有分件（<stem>_Img_02...）时无法确定布局，跳过以免导出残缺图。
    """
    hits = []
    pat = re.compile(rf"{re.escape(stem)}_", re.I)
    for o in sprite_index.values():
        try:
            nm = str(o.read().m_Name)
        except Exception:
            continue
        if pat.match(nm):
            hits.append(nm)
    if len(hits) == 1 and re.fullmatch(rf"{re.escape(stem)}_img", hits[0], re.I):
        for o in sprite_index.values():
            try:
                if str(o.read().m_Name) == hits[0]:
                    return o
            except Exception:
                continue
    return None


def plan_painting_jobs(
    names: Dict[str, Dict[str, str]],
    pid_of: Dict[str, int],
    sprite_index,
    include_all: bool = False,
    limit: int = 0,
) -> List[Dict[str, Any]]:
    """把数据表条目+prefab 清单变成导出任务（stem / 角色 / 皮肤 / 文件名）。

    文件名与导出顺序保持一致，find 之类的排障命令可以直接复用。
    """
    used: set = set()
    jobs: List[Dict[str, Any]] = []

    def add(stem: str, char: str, direct=None):
        info = names.get(stem) or {}
        jobs.append({
            "stem": stem,
            "char": char,
            "file": painting_filename(char, used),
            "direct": direct,
            "owner": str(info.get("owner") or ""),
            "show_id": str(info.get("show_id") or ""),
        })

    for stem, info in names.items():
        char = info.get("char") or info.get("pinyin") or stem
        if stem in pid_of:
            add(stem, char)
            continue
        obj = orphan_single_sprite(stem, sprite_index)
        if obj is not None:
            add(stem, char, direct=obj)
    if include_all:
        have = {j["stem"] for j in jobs}
        for stem in pid_of:
            if stem not in have:
                add(stem, stem)
    if limit > 0:
        jobs = jobs[:limit]
    return jobs


def export_hero_paintings(
    assets_dir: Path,
    out_dir: Path,
    master_dir: Optional[Path] = None,
    force: bool = False,
    include_all: bool = False,
    limit: int = 0,
) -> Tuple[int, int, int]:
    """导出立绘到 out_dir，返回 (写出, 跳过, 失败)。

    天地劫所有皮肤共用同一个 HeroPainting prefab（皮肤差异在 Spine/3D 模型 /
    展示视频，静态立绘没有皮肤差分资源），所以每个英雄只导出一张。
    include_all=True 时连配置未引用的旧 prefab 一起导出。
    """
    assets = _hero_painting_assets(assets_dir)
    if assets is None:
        raise FileNotFoundError(
            f"缺少立绘 prefab 包: {assets_dir / HERO_PAINTING_PREFAB_BUNDLE}"
        )
    _env, sf, cab2bundle, sprite_index, missing_cabs = assets
    if missing_cabs:
        console.print(
            f"[yellow]⚠ 有 {len(missing_cabs)} 个立绘贴图包没下载，"
            "相关立绘会缺分件（重跑本命令会自动补齐）[/yellow]"
        )
    names = load_painting_name_map(assets_dir, master_dir)
    roots = _painting_prefab_roots(sf)
    pid_of = {name: pid for pid, name in roots}
    jobs = plan_painting_jobs(names, pid_of, sprite_index, include_all, limit)
    if not jobs:
        return 0, 0, 0

    out_dir.mkdir(parents=True, exist_ok=True)
    console.print(f"[cyan]立绘[/cyan] {len(jobs)} 张 → {out_dir}")
    ok = skip = fail = 0
    composed: Dict[str, Any] = {}
    with Progress(
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        TextColumn("{task.completed}/{task.total}"),
        console=console,
    ) as progress:
        task = progress.add_task("导出立绘", total=len(jobs))
        for job in jobs:
            stem = job["stem"]
            dest = out_dir / job["file"]
            if dest.is_file() and not force:
                skip += 1
                progress.advance(task)
                continue
            try:
                canvas = composed.get(stem)
                if canvas is None:
                    if job["direct"] is not None:
                        from UnityPy.export.SpriteHelper import get_image_from_sprite as _gif
                        canvas = _gif(job["direct"].read()).convert("RGBA")
                    else:
                        canvas = compose_painting(sf, pid_of[stem], cab2bundle, sprite_index)
                    if canvas is None:
                        raise RuntimeError("prefab 内没有可用的 Image 节点")
                    composed[stem] = canvas
                canvas.save(dest, "PNG")
                ok += 1
            except Exception as exc:  # noqa: BLE001
                fail += 1
                console.print(f"[red]✗ 立绘失败[/red] {stem}: {exc}")
            progress.advance(task)
    return ok, skip, fail


# ---------------------------------------------------------------------------
# 三种模式：资产 / 数据表 / 立绘
#
# 共同点是“自动检查更新”：每次都重新拉 AssetBundleManifest，用清单里的
# hash/大小和本地状态比对，只下载新增或变化的文件，其余跳过。
#   assets   ：全部 AssetBundle（UpdateClientData）
#   master   ：只有 configdata_abs.b，下载后导出 MasterData/*.json
#   painting ：数据表 + ui_*heropainting* 包，拼回立绘写到 <out>/Painting
# ---------------------------------------------------------------------------


def mode_root(out_root: Optional[str]) -> Path:
    return Path(out_root) if out_root else Path(ROOT_DIR)


def sync_bundles(
    out_root: Optional[str],
    label: str,
    only,
    args,
    force: Optional[bool] = None,
    manifest: Optional[Tuple[str, List[Dict[str, Any]]]] = None,
) -> Dict[str, Any]:
    """按清单检查更新并下载（only 过滤，只动这个模式需要的包）。"""
    return download_asset_bundles(
        out_root=str(mode_root(out_root)),
        jobs=int(getattr(args, "jobs", DEFAULT_JOBS) or DEFAULT_JOBS),
        force=bool(getattr(args, "force", False)) if force is None else bool(force),
        retries=int(getattr(args, "retries", DEFAULT_RETRIES) or DEFAULT_RETRIES),
        decrypt=not bool(getattr(args, "no_decrypt", False)),
        only=only,
        verify=bool(getattr(args, "verify", False)),
        label=label,
        manifest=manifest,
    )


def ensure_datatable(
    out_root: Optional[str],
    args,
    manifest: Optional[Tuple[str, List[Dict[str, Any]]]] = None,
) -> Tuple[Path, Dict[str, Any]]:
    """确保数据表 configdata_abs.b 存在且是最新版本（只下载这一个包）。"""
    dest = mode_root(out_root) / "Assets" / "Android" / TARGET_BUNDLE_NAME
    report = sync_bundles(
        out_root, "数据表", lambda n: n == TARGET_BUNDLE_NAME, args, manifest=manifest
    )
    if report["failed"]:
        raise RuntimeError(f"{TARGET_BUNDLE_NAME} 下载失败（见上方日志）")
    if not dest.is_file():
        raise FileNotFoundError(f"缺少数据表: {dest}")
    return dest, report


def ensure_painting_assets(
    out_root: Optional[str],
    args,
    manifest: Optional[Tuple[str, List[Dict[str, Any]]]] = None,
) -> Dict[str, Any]:
    """确保立绘 prefab 包与全部分件贴图包存在且是最新版本。"""
    report = sync_bundles(
        out_root,
        "立绘资产",
        lambda n: PAINTING_BUNDLE_KEYWORD in str(n).lower(),
        args,
        manifest=manifest,
    )
    assets_dir = mode_root(out_root) / "Assets" / "Android"
    if not (assets_dir / HERO_PAINTING_PREFAB_BUNDLE).is_file():
        raise FileNotFoundError(
            f"缺少立绘 prefab 包: {assets_dir / HERO_PAINTING_PREFAB_BUNDLE}"
        )
    return report


def datatable_is_exported(master_root: Path, remote_hash: str) -> bool:
    """MasterData 目录里的 JSON 是否已经对应远端当前版本。"""
    state = load_json_file(master_root / MASTER_STATE_FILE)
    json_count = sum(1 for _ in master_root.glob("*.json"))
    return bool(
        json_count > 50
        and remote_hash
        and str(state.get("hash") or "").upper() == remote_hash
    )


def export_datatable(
    assets_dir: Path,
    master_root: Path,
    refresh_schema: bool = False,
    schema_dlls: Optional[List[str]] = None,
    schema_source: str = "auto",
) -> Tuple[int, int]:
    """把 configdata_abs.b 里的原始表导出成 MasterData/*.json。"""
    dest = Path(assets_dir) / TARGET_BUNDLE_NAME
    if is_unity_bundle_file(dest) and is_unityfs_encrypted(dest):
        console.print("[cyan]数据表仍是 UnityCN 加密包，先原地解密[/cyan]")
        if not decrypt_asset_file_inplace(dest, force=True):
            console.print("[yellow]⚠ 数据表解密失败，尝试直接解析[/yellow]")
    config_files = collect_configdata_assets_from_bytes(dest.read_bytes())
    schema_index = build_schema_index()
    good, bad = export_json_from_memory(
        schema_index,
        config_files,
        str(master_root),
        refresh_schema=refresh_schema,
        schema_dlls=schema_dlls,
        schema_source=schema_source,
    )
    console.print(f"[bold green]JSON 导出完成：成功 {good}，跳过/失败 {bad}[/]")
    console.print(f"[gray]MasterData 目录: {master_root}[/]")
    return good, bad


def sync_master_state(assets_dir: Path, master_root: Path, entry: Dict[str, Any]) -> None:
    """记录数据表状态：MasterData 侧的导出状态 + Assets 侧的资产状态。"""
    record = {
        "name": TARGET_BUNDLE_NAME,
        "version": entry.get("version"),
        "hash": asset_entry_hash(entry),
        "size": int(entry.get("size") or 0),
        "decrypted": True,
    }
    save_json_file(master_root / MASTER_STATE_FILE, record)
    # 同步资产模式的状态，避免下次资产模式把解密后的数据表当成“大小不符”重下
    assets_dir = Path(assets_dir)
    state_path = asset_state_path(assets_dir)
    states = load_asset_states(state_path)
    states[TARGET_BUNDLE_NAME] = record
    save_asset_states(state_path, states)


def cmd_painting(args) -> int:
    """立绘模式：自动补齐依赖（数据表 + 立绘包）后拼接到 <out>/Painting/。

    - 没有数据表就下数据表，没有立绘资产就下立绘资产，远端有更新则更新；
    - 不需要额外的输出参数，立绘固定写到 <out>/Painting/（默认脚本旁）。
    """
    try:
        root = mode_root(args.out)
        painting_dir = root / "Painting"
        assets_dir = root / "Assets" / "Android"

        # 清单只拉一次，数据表/立绘资产共用
        manifest = None
        try:
            manifest = fetch_bundle_entries(
                str(root), int(getattr(args, "retries", DEFAULT_RETRIES) or DEFAULT_RETRIES)
            )
        except Exception as e:  # noqa: BLE001
            console.print(f"[yellow]⚠ 获取资源清单失败，改用本地已有文件: {e}[/yellow]")
        for label, ensure in (
            ("数据表", ensure_datatable),
            ("立绘资产", ensure_painting_assets),
        ):
            try:
                ensure(args.out, args, manifest)
            except Exception as e:  # noqa: BLE001
                console.print(
                    f"[yellow]⚠ {label}检查/下载失败，改用本地已有文件: {e}[/yellow]"
                )

        if not assets_dir.is_dir():
            console.print(f"[red]缺资产目录[/red] {assets_dir}")
            return 1
        if not (assets_dir / TARGET_BUNDLE_NAME).is_file() and not (
            root / "MasterData" / "ConfigDataCharacterShowInfo.json"
        ).is_file():
            console.print(
                "[red]缺数据表（configdata_abs.b / MasterData），无法确定立绘命名[/red]"
            )
            return 1

        ok, skip, fail = export_hero_paintings(
            assets_dir,
            painting_dir,
            master_dir=root / "MasterData",
            force=bool(getattr(args, "force", False)),
            include_all=bool(getattr(args, "all", False)),
            limit=int(getattr(args, "limit", 0) or 0),
        )
        console.print(
            f"[green]立绘完成[/green] 写出={ok} 跳过={skip} 失败={fail} → {painting_dir}"
        )
        return 1 if fail else 0
    except Exception as e:
        console.print(f"[bold red]❌ 立绘导出失败: {e}[/]")
        return 1


def cmd_master(args) -> int:
    """数据表模式：只检查/下载 configdata_abs.b 并导出 MasterData/*.json。

    单独下载，不下载其他资源；清单 hash 未变且已导出过就直接跳过。
    """
    try:
        root = mode_root(args.out)
        master_root = root / "MasterData"
        master_root.mkdir(parents=True, exist_ok=True)
        assets_dir = root / "Assets" / "Android"

        dest, report = ensure_datatable(args.out, args)
        entry = report["manifest"].get(TARGET_BUNDLE_NAME) or {}
        remote_hash = asset_entry_hash(entry)
        console.print(
            f"[cyan]数据表[/cyan] {TARGET_BUNDLE_NAME} "
            f"version={entry.get('version')} size={entry.get('size')}"
        )
        if not args.force and datatable_is_exported(master_root, remote_hash):
            console.print("[bold green]✔ 数据表已是最新，跳过导出[/bold green]")
            return 0

        schema_dlls = list(getattr(args, "schema_dll", None) or []) or None
        schema_source = str(getattr(args, "schema_source", "auto") or "auto")
        if schema_dlls and schema_source == "auto":
            schema_source = "dll"  # 指定了 DLL 就按 DLL 推断
        export_datatable(
            assets_dir,
            master_root,
            refresh_schema=bool(args.force),
            schema_dlls=schema_dlls,
            schema_source=schema_source,
        )
        sync_master_state(assets_dir, master_root, entry)
        return 0
    except Exception as e:
        console.print(f"[bold red]❌ 执行过程中发生严重错误: {e}[/]")
        return 1


def cmd_assets(args) -> int:
    """资产模式：自动检查更新 -> 按需下载/更新全部 AssetBundle + 解密。"""
    try:
        report = download_asset_bundles(
            out_root=args.out,
            jobs=args.jobs,
            force=args.force,
            retries=args.retries,
            decrypt=not args.no_decrypt,
            verify=bool(getattr(args, "verify", False)),
            label="资产",
        )
        return 1 if report["failed"] else 0
    except Exception as e:
        console.print(f"[bold red]❌ 资产下载失败: {e}[/]")
        return 1


def cmd_hotupdate(args) -> int:
    try:
        total, skipped, fail = download_hotupdate_files(
            out_root=args.out,
            jobs=args.jobs,
            force=args.force,
            retries=args.retries,
            verify=args.verify,
        )
        return 1 if fail else 0
    except Exception as e:
        console.print(f"[bold red]❌ 热更下载失败: {e}[/]")
        return 1


def cmd_decrypt(args) -> int:
    try:
        root = Path(args.out) / "Assets"
        ok, fail = decrypt_asset_dir(
            root,
            jobs=args.jobs,
            force=args.force,
            state_path=root / "Android" / ".unitycn_decrypted.json",
        )
        return 1 if fail else 0
    except Exception as e:
        console.print(f"[bold red]❌ 原地解密失败: {e}[/]")
        return 1


def cmd_update(args) -> int:
    rc = cmd_assets(args)
    if rc:
        return rc
    rc = cmd_hotupdate(args)
    if rc:
        return rc
    return cmd_master(args)


def cmd_status(args) -> int:
    root = Path(args.out)
    for label, rel in (
        ("Assets", "Assets"),
        ("HotUpdate", "HotUpdate"),
        ("MasterData", "MasterData"),
        ("Painting", "Painting"),
    ):
        p = root / rel
        if not p.exists():
            console.print(f"{label}: (无)")
            continue
        if p.is_dir():
            n = sum(1 for f in p.rglob("*") if f.is_file())
            console.print(f"{label}: {n} 个文件")
        else:
            console.print(f"{label}: {p.stat().st_size} 字节")
    return 0


def cmd_find(args) -> int:
    """排障用：查某个立绘（内部名 / 角色名 / 皮肤名）到底会不会导出、叫什么。

    例：python3 tdj.py find Hero2510
    """
    keyword = str(getattr(args, "keyword", "") or "").strip()
    if not keyword:
        console.print("[red]用法: tdj.py find <Hero2510|角色名|皮肤名>[/red]")
        return 1
    low = keyword.lower()
    root = mode_root(args.out)
    assets_dir = root / "Assets" / "Android"
    painting_dir = root / "Painting"

    entries = load_painting_entries(assets_dir, root / "MasterData")
    if not entries:
        console.print("[yellow]没有可用的数据表，无法确定立绘命名[/yellow]")
        return 1
    seen: set = set()
    matches: List[Dict[str, str]] = []
    for e in entries:
        if e["stem"] in seen:
            continue
        hay = " ".join(
            str(e.get(k) or "") for k in ("stem", "char", "skin", "owner", "show_id")
        ).lower()
        if low in hay:
            seen.add(e["stem"])
            matches.append(e)

    jobs: Dict[str, Dict[str, Any]] = {}
    pid_of: Dict[str, int] = {}
    sprite_names: Dict[str, List[str]] = {}
    assets = _hero_painting_assets(assets_dir) if assets_dir.is_dir() else None
    if assets is not None:
        _env, sf, _cab2bundle, sprite_index, _missing = assets
        pid_of = {name: pid for pid, name in _painting_prefab_roots(sf)}
        for obj in sprite_index.values():
            try:
                nm = str(obj.read().m_Name)
            except Exception:
                continue
            m = re.match(r"^(.*?)(?:_img)(?:_\d+)?$", nm, re.I)
            sprite_names.setdefault((m.group(1) if m else nm), []).append(nm)
        for job in plan_painting_jobs(
            load_painting_name_map(assets_dir, root / "MasterData"), pid_of, sprite_index
        ):
            jobs[job["stem"]] = job

    if not matches:
        console.print(f"[yellow]数据表里没有匹配 “{keyword}” 的立绘条目[/yellow]")
        for stem, names in sprite_names.items():
            if low in stem.lower() or any(low in n.lower() for n in names):
                console.print(
                    f"  贴图包里存在 {stem}: {', '.join(sorted(names))}"
                    "（没有被 HeroPainting 配置引用，不会导出）"
                )
        return 1

    for e in matches:
        stem = e["stem"]
        job = jobs.get(stem)
        console.print(
            f"[bold cyan]{stem}[/bold cyan] 角色={e.get('char') or '(未命名)'} "
            f"皮肤={e.get('skin') or '(未命名)'} "
            f"owner={e.get('owner') or '-'} show={e.get('show_id') or '-'}"
        )
        names = sorted(sprite_names.get(stem) or [])
        console.print(f"  prefab: {'有' if stem in pid_of else '没有（配置里有条目但包里缺 prefab）'}")
        if names:
            console.print(f"  贴图分件: {', '.join(names)}")
        if job is None:
            console.print(
                "  [yellow]不会导出：缺少 prefab 且贴图不是单张整图（无法确定布局）[/yellow]"
            )
            continue
        dest = painting_dir / job["file"]
        mark = "[green]已存在[/green]" if dest.is_file() else "[yellow]尚未导出[/yellow]"
        console.print(f"  输出: {dest} [{mark}]")
    return 0


def add_common_args(p: argparse.ArgumentParser) -> None:
    p.add_argument("--out", default=ROOT_DIR, help="输出根目录")
    p.add_argument("--jobs", type=int, default=DEFAULT_JOBS, help="并发下载线程数")
    p.add_argument("--retries", type=int, default=DEFAULT_RETRIES, help="单文件重试次数")
    p.add_argument("--force", action="store_true", help="强制重新下载（忽略本地状态）")
    p.add_argument(
        "--verify",
        action="store_true",
        help="下载后/跳过前额外校验文件完整性（热更文件按 MD5，资源包按 UnityFS 结构）",
    )
    p.add_argument("--no-decrypt", action="store_true", help="下载后不执行 UnityCN 原地解密")


def main() -> int:
    parser = argparse.ArgumentParser(
        description=(
            "天地劫下载更新工具\n"
            "  assets   资产模式：自动检查更新/下载全部 AssetBundle\n"
            "  master   数据表模式：只检查更新/下载 configdata_abs.b 并导出 MasterData\n"
            "  painting 立绘模式：自动检查更新依赖，拼回立绘到 Painting/"
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    sub = parser.add_subparsers(dest="command")

    p_assets = sub.add_parser(
        "assets", help="资产模式：自动检查更新并下载全部 UpdateClientData AssetBundle"
    )
    add_common_args(p_assets)

    p_hot = sub.add_parser("hotupdate", help="下载/更新 AllFilesPath.txt 中的热更文件")
    add_common_args(p_hot)

    p_master = sub.add_parser(
        "masterdata", help="数据表模式：只下载/更新 configdata_abs.b 并导出 MasterData JSON"
    )
    add_common_args(p_master)
    p_master.add_argument(
        "--schema-dll",
        action="append",
        default=None,
        help="用 DNFBDmp 推断 proto 时的 DLL 文件名，可重复（默认 dll/Assembly-CSharp*.dll）",
    )
    p_master.add_argument(
        "--schema-source",
        choices=("auto", "cs", "dll"),
        default="auto",
        help=(
            "proto 来源：cs=反编译热更 DLL 走 C# 推断（默认优先），"
            "dll=DNFBDmp 直接读 Assembly-CSharp*.dll"
        ),
    )

    p_update = sub.add_parser("update", help="全资产 = assets + hotupdate + masterdata 导出")
    add_common_args(p_update)

    p_dec = sub.add_parser("decrypt", help="原地解密 Assets 目录中的 UnityCN AssetBundle")
    add_common_args(p_dec)

    p_status = sub.add_parser("status", help="查看本地 Assets/HotUpdate/MasterData 状态")
    add_common_args(p_status)

    p_paint = sub.add_parser(
        "painting",
        help=(
            "立绘模式：自动补齐数据表/立绘资产后，按 HeroPainting prefab 拼回分件，"
            "输出到 Painting/（文件名=天地劫_角色）"
        ),
    )
    add_common_args(p_paint)
    p_paint.add_argument(
        "--all", action="store_true", help="导出 prefab 包内全部立绘（含配置未引用的旧资源）"
    )
    p_paint.add_argument("--limit", type=int, default=0, help="只导出前 N 个")

    p_find = sub.add_parser(
        "find", help="排障：查某个立绘（内部名/角色名/皮肤名）会不会导出、叫什么"
    )
    add_common_args(p_find)
    p_find.add_argument("keyword", help="例如 Hero2510 / 妖佑宇韶容")

    args = parser.parse_args()
    if not args.command:
        parser.print_help()
        return 0

    handlers = {
        "assets": cmd_assets,
        "hotupdate": cmd_hotupdate,
        "masterdata": cmd_master,
        "update": cmd_update,
        "decrypt": cmd_decrypt,
        "status": cmd_status,
        "painting": cmd_painting,
        "find": cmd_find,
    }
    return handlers[args.command](args)


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/yellow]")
        raise SystemExit(130)
