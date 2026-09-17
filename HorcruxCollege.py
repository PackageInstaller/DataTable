from __future__ import annotations

import argparse
import hashlib
import io
import json
import os
import re
import shutil
import struct
import subprocess
import sys
import tempfile
import threading
import time
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Any, Iterable
from urllib.parse import unquote

import requests
import xxtea
from rich.console import Console
from rich.progress import (
    BarColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
)


GAME_TITLE = "魂器学院"
SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MASTER_DIR = SCRIPT_DIR / "MasterData"
DOWNLOADS_DIR = SCRIPT_DIR / "Downloads"
PAINTING_DIR = SCRIPT_DIR / "Painting"
ROLE_IMAGE_DIR = ASSETS_DIR / "res" / "roleimage" / "role"

XXTEA_SIGN = b"bogehcollege"
XXTEA_KEY_RAW = b"palmpi"
XXTEA_KEY = XXTEA_KEY_RAW.ljust(16, b"\x00")

UPDATE_API_URL = "https://horcrux.aojiaostudio.com/update"
BASE_DATA_URL_TMPL = "https://download9.h-college.com/download/v{version_code}/data64.zip"
DEFAULT_CLIENT_VERSION = "1.2.14.757"
DEFAULT_VERSION_CODE = "124"
DEFAULT_CHANNEL = "270049"
DEFAULT_PLATFORM = "android"

LUA_MAGIC = b"\x1bLua"
LUAJIT_MAGIC = b"\x1bLJ"

DEFAULT_JOBS = max(1, os.cpu_count() or 8)
console = Console()



def get_luajit_decompiler_cmd() -> str | None:
    """获取 LuaJIT 反编译工具命令（优先官方标准的 luajit-decompiler）。"""
    for cmd in ["luajit-decompiler", "luajit-decompier"]:
        path = shutil.which(cmd)
        if path:
            return path
    return None


def get_unluac_cmd() -> str | None:
    """获取标准 Lua 反编译器 unluac。"""
    return shutil.which("unluac")


def find_apk(search_dir: Path | None = None) -> Path | None:
    """在指定目录中自动检索游戏 APK 文件。"""
    root = search_dir or SCRIPT_DIR
    apks = sorted(root.glob("*.apk"), key=lambda p: p.stat().st_size, reverse=True)
    return apks[0] if apks else None




def decrypt_xxtea(data: bytes) -> bytes:
    if not data.startswith(XXTEA_SIGN):
        return data

    body = data[len(XXTEA_SIGN) :]
    if not body:
        return b""

    dec = xxtea.decrypt(body, XXTEA_KEY, padding=False)
    if not dec or len(dec) < 4:
        return dec

    orig_len = struct.unpack("<I", dec[-4:])[0]
    total_len = len(dec)
    if total_len - 7 <= orig_len <= total_len - 4:
        return dec[:orig_len]

    return dec


def decrypt_file_inplace(path: Path) -> bool:
    try:
        data = path.read_bytes()
        if not data.startswith(XXTEA_SIGN):
            return False
        dec = decrypt_xxtea(data)
        path.write_bytes(dec)
        return True
    except Exception as e:
        console.print(f"[red]解密失败[/] {path}: {e}")
        return False



def query_update_info(
    force_live: bool = True
) -> dict[str, Any]:
    payload = {
        "versioncode": DEFAULT_VERSION_CODE,
        "device": "4b851e78-ef03-45b6-9878-13ef9ee521d9",
        "clientversion": DEFAULT_CLIENT_VERSION,
        "channel": DEFAULT_CHANNEL,
        "clientbranch": "android3.5",
        "platform": DEFAULT_PLATFORM,
    }

    if force_live:
        try:
            resp = requests.post(
                UPDATE_API_URL,
                data=json.dumps(payload),
                headers={"Content-Type": "application/x-www-form-urlencoded"},
                timeout=8,
            )
            if resp.status_code == 200:
                data = resp.json()
                if data.get("errcode") == 1 and "info" in data:
                    return data["info"]
        except Exception as e:
            console.print(f"[yellow]远端更新接口访问失败 ({e})")

    return {}


def build_update_package_list(info: dict[str, Any]) -> list[dict[str, Any]]:
    versions = info.get("versions", [])
    downloadpaths = info.get("downloadpath", [])
    if not downloadpaths or not versions:
        return []

    base_download_url = unquote(downloadpaths[0])
    packages: list[dict[str, Any]] = []

    for ver_tuple in versions:
        ver_str = ver_tuple[0]
        ver_size = ver_tuple[1]
        m = re.match(r"(\d+)\.(\d+)\.(\d+)\.(\d+)", ver_str)
        if m:
            v1, v2, v3, v4 = m.groups()
            url = f"{base_download_url}{v1}{v2}_{v3}_{v4}_64.zip"
            filename = f"hcollege_update_package-v{v1}{v2}_{v3}_{v4}_64.zip"
            packages.append(
                {
                    "version": ver_str,
                    "filename": filename,
                    "url": url,
                    "size": ver_size,
                }
            )

    return packages



def download_file(url: str, dest: Path, expected_size: int = 0, force: bool = False) -> bool:
    """下载单个文件，支持断点与尺寸校验。"""
    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.is_file() and not force:
        if expected_size <= 0 or dest.stat().st_size == expected_size:
            return True

    tmp_dest = dest.with_suffix(dest.suffix + ".tmp")
    try:
        with requests.get(url, stream=True, timeout=30) as r:
            r.raise_for_status()
            with open(tmp_dest, "wb") as f:
                for chunk in r.iter_content(chunk_size=1024 * 128):
                    if chunk:
                        f.write(chunk)
        tmp_dest.replace(dest)
        return True
    except Exception as e:
        if tmp_dest.exists():
            tmp_dest.unlink()
        console.print(f"[red]下载失败[/] {url}: {e}")
        return False


def extract_apk_assets(apk_path: Path, dest_dir: Path, force: bool = False) -> int:
    """从 APK 中解压 assets/ 到 Assets/ 根目录。"""
    dest_dir.mkdir(parents=True, exist_ok=True)
    count = 0
    with zipfile.ZipFile(apk_path, "r") as zf:
        members = [
            m
            for m in zf.namelist()
            if m.startswith("assets/")
            and not m.endswith("/")
            and not m.startswith("assets/dexopt/")
        ]

        for m in members:
            rel_path = m[len("assets/") :]
            target_path = dest_dir / rel_path
            if target_path.is_file() and not force:
                count += 1
                continue
            target_path.parent.mkdir(parents=True, exist_ok=True)
            with zf.open(m) as src, open(target_path, "wb") as dst:
                shutil.copyfileobj(src, dst)
            count += 1

    return count


def extract_update_zip(zip_path: Path, dest_dir: Path) -> int:
    dest_dir.mkdir(parents=True, exist_ok=True)
    count = 0
    with zipfile.ZipFile(zip_path, "r") as zf:
        for m in zf.namelist():
            if m.endswith("/"):
                continue
            rel_path = m
            if rel_path.startswith("v12/"):
                rel_path = rel_path[len("v12/") :]
            elif rel_path.startswith("v124/"):
                rel_path = rel_path[len("v124/") :]

            target_path = dest_dir / rel_path
            target_path.parent.mkdir(parents=True, exist_ok=True)
            with zf.open(m) as src, open(target_path, "wb") as dst:
                shutil.copyfileobj(src, dst)
            count += 1
    return count


def decrypt_all_under_assets(assets_dir: Path, jobs: int = DEFAULT_JOBS) -> tuple[int, int]:
    all_files = [p for p in assets_dir.rglob("*") if p.is_file()]
    to_decrypt: list[Path] = []

    for p in all_files:
        try:
            with open(p, "rb") as f:
                head = f.read(12)
                if head == XXTEA_SIGN:
                    to_decrypt.append(p)
        except OSError:
            continue

    if not to_decrypt:
        return 0, len(all_files)

    success_count = 0
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
        TimeElapsedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task(f"XXTEA 解密资产 ({len(to_decrypt)} 个文件)", total=len(to_decrypt))
        with ThreadPoolExecutor(max_workers=jobs) as executor:
            future_to_file = {
                executor.submit(decrypt_file_inplace, file_path): file_path
                for file_path in to_decrypt
            }
            for future in as_completed(future_to_file):
                if future.result():
                    success_count += 1
                progress.advance(task, 1)

    return success_count, len(all_files)


_thread_local = threading.local()


def get_thread_lua_runtime():
    if not hasattr(_thread_local, "runtime"):
        try:
            from lupa import LuaRuntime

            _thread_local.runtime = LuaRuntime(unpack_returned_tuples=True)
        except Exception:
            _thread_local.runtime = None
    return _thread_local.runtime


def decompile_lua_bytecode(
    bytecode: bytes,
    luajit_cmd: str | None,
    unluac_cmd: str | None,
    temp_prefix: str = "decomp",
) -> str | None:
    is_lj = bytecode.startswith(LUAJIT_MAGIC)
    is_lua = bytecode.startswith(LUA_MAGIC)

    if not is_lj and not is_lua:
        try:
            return bytecode.decode("utf-8-sig")
        except UnicodeDecodeError:
            try:
                return bytecode.decode("gbk", errors="replace")
            except Exception:
                return None

    with tempfile.TemporaryDirectory(prefix="hk_decomp_") as tmp_dir:
        tmp_in = Path(tmp_dir) / f"{temp_prefix}.luac"
        tmp_in.write_bytes(bytecode)

        if is_lj:
            if not luajit_cmd:
                return None
            cmd = [luajit_cmd, str(tmp_in), "-o", tmp_dir, "-f", "-s"]
            subprocess.run(cmd, capture_output=True, text=True)
            out_file = tmp_in.with_suffix(".luac.lua")
            if not out_file.is_file():
                candidates = list(Path(tmp_dir).glob("*.lua"))
                if candidates:
                    out_file = candidates[0]

            if out_file.is_file():
                try:
                    return out_file.read_text(encoding="utf-8-sig")
                except UnicodeDecodeError:
                    return out_file.read_text(encoding="gbk", errors="replace")
        elif is_lua:
            if not unluac_cmd:
                return None
            out_file = Path(tmp_dir) / f"{temp_prefix}.lua"
            cmd = [unluac_cmd, str(tmp_in), "--output", str(out_file)]
            subprocess.run(cmd, capture_output=True, text=True)
            if out_file.is_file():
                try:
                    return out_file.read_text(encoding="utf-8-sig")
                except UnicodeDecodeError:
                    return out_file.read_text(encoding="gbk", errors="replace")

    return None


def lua_table_to_python(val: Any) -> Any:
    import lupa

    if lupa.lua_type(val) == "table":
        keys = list(val.keys())
        if not keys:
            return {}
        if all(isinstance(k, int) and k > 0 for k in keys) and sorted(keys) == list(
            range(1, len(keys) + 1)
        ):
            return [lua_table_to_python(val[k]) for k in sorted(keys)]
        else:
            out: dict[str, Any] = {}
            for k, v in val.items():
                out[str(k)] = lua_table_to_python(v)
            return out
    elif isinstance(val, (int, float, str, bool)) or val is None:
        return val
    else:
        return str(val)


def parse_lua_data_to_dict(lua_code: str) -> dict[str, Any] | list[Any] | None:
    try:
        lua = get_thread_lua_runtime()
        if not lua:
            return None
        clean_code = lua_code.lstrip("\ufeff")
        res = lua.execute(clean_code)
        if res is not None:
            return lua_table_to_python(res)
    except Exception:
        pass
    return None


def process_single_masterdata_file(
    src_file: Path,
    rel_path: Path,
    luajit_cmd: str | None,
    unluac_cmd: str | None,
    precomputed_text: str | None = None,
) -> tuple[str, bool]:
    """处理单个 Lua 文件：反编译（如果被编译）并直接提取为 .lua 明文保存到 MasterData/。"""
    try:
        if precomputed_text is not None:
            lua_text = precomputed_text
        else:
            raw_data = src_file.read_bytes()
            if raw_data.startswith(XXTEA_SIGN):
                raw_data = decrypt_xxtea(raw_data)
            lua_text = decompile_lua_bytecode(
                raw_data, luajit_cmd, unluac_cmd, temp_prefix=src_file.stem
            )

        if lua_text is None:
            return str(rel_path), False

        out_path = (MASTER_DIR / rel_path).with_suffix(".lua")
        out_path.parent.mkdir(parents=True, exist_ok=True)
        out_path.write_text(lua_text.lstrip("\ufeff"), encoding="utf-8")
        return str(rel_path), True
    except Exception as e:
        return str(rel_path), False



def cmd_status(args: argparse.Namespace) -> int:
    """查询并展示游戏包、本地资产与远端补丁状态。"""
    apk_file = args.apk or find_apk()
    console.print(f"[bold cyan]== {GAME_TITLE} 状态查询 ==[/bold cyan]\n")

    if apk_file and apk_file.is_file():
        size_mb = apk_file.stat().st_size / (1024 * 1024)
        console.print(f"[green]✔[/] 检测到底包 APK: [bold]{apk_file.name}[/] ({size_mb:.2f} MB)")
    else:
        console.print("[yellow]⚠ 未在当前目录找到 APK 文件，可通过 --apk 指定[/]")

    if ASSETS_DIR.is_dir():
        asset_files = list(ASSETS_DIR.rglob("*"))
        enc_count = 0
        for f in asset_files:
            if f.is_file():
                try:
                    with open(f, "rb") as fp:
                        if fp.read(12) == XXTEA_SIGN:
                            enc_count += 1
                except OSError:
                    pass
        console.print(
            f"[green]✔[/] 本地 Assets: 共 {len(asset_files)} 个文件 (待解密加密文件: {enc_count} 个)"
        )
    else:
        console.print("[dim]本地 Assets 目录尚未创建[/]")

    if MASTER_DIR.is_dir():
        json_count = len(list(MASTER_DIR.rglob("*.json")))
        lua_count = len(list(MASTER_DIR.rglob("*.lua")))
        console.print(f"[green]✔[/] 本地 MasterData: 已生成 {json_count} 个 JSON, {lua_count} 个 Lua")
    else:
        console.print("[dim]本地 MasterData 目录尚未创建[/]")

    if PAINTING_DIR.is_dir():
        paint_count = len(list(PAINTING_DIR.glob("*.png")))
        console.print(f"[green]✔[/] 本地 Painting: 已导出 {paint_count} 张角色卡面立绘")
    else:
        console.print("[dim]本地 Painting 目录尚未创建[/]")

    console.print("\n[cyan]正在查询远端热更服务器及补丁清单...[/]")
    skip_dl = getattr(args, "skip_download", False)
    info = query_update_info(force_live=not skip_dl)
    if info:
        packages = build_update_package_list(info)
        total_patch_size = sum(p["size"] for p in packages) / (1024 * 1024)
        latest_ver = packages[-1]["version"] if packages else "未知"
        console.print(f"[bold green]✔ 最新热更版本: {latest_ver}[/bold green]")
        console.print(f"  增量补丁数量: {len(packages)} 个补丁包")
        console.print(f"  增量补丁总大小: {total_patch_size:.2f} MB")
        console.print(
            f"  全量数据包 (v{DEFAULT_VERSION_CODE}/data64.zip): 约 297 MB (解压含 25,120 个文件)"
        )
    else:
        console.print("[red]未能获取远端补丁信息[/]")

    lj_cmd = get_luajit_decompiler_cmd()
    unluac_cmd = get_unluac_cmd()
    console.print("\n[bold]反编译工具链状态:[/]")
    console.print(f"  LuaJIT Decompiler : {'[green]✔ 已就绪 (' + lj_cmd + ')[/]' if lj_cmd else '[red]✘ 未安装 (luajit-decompiler)[/]'}")
    console.print(f"  unluac (Lua 5.1+) : {'[green]✔ 已就绪 (' + unluac_cmd + ')[/]' if unluac_cmd else '[red]✘ 未安装[/]'}")

    return 0


def cmd_assets(args: argparse.Namespace) -> int:
    apk_file = args.apk or find_apk()
    jobs = args.jobs

    console.print(f"[bold cyan]== 开始整合还原 {GAME_TITLE} 游戏资产到 Assets/ ==[/bold cyan]")
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    DOWNLOADS_DIR.mkdir(parents=True, exist_ok=True)

    if not args.skip_apk:
        if not apk_file or not apk_file.is_file():
            console.print("[red]错误: 未找到 APK 文件，无法提取底包资源。请指定 --apk 参数[/]")
            return 1
        console.print(f"\n[cyan]正在从 APK ({apk_file.name}) 解压 assets/...[/]")
        extracted = extract_apk_assets(apk_file, ASSETS_DIR, force=args.force)
        console.print(f"[green]✔ APK 基础资源提取完成，共 {extracted} 个文件[/]")
    else:
        console.print("[dim]已跳过 APK 解包步骤[/]")

    if not args.skip_download:
        info = query_update_info(force_live=True)
        if not info:
            console.print("[yellow]无法获取补丁信息，跳过下载步骤[/]")
        else:
            base_url = BASE_DATA_URL_TMPL.format(version_code=DEFAULT_VERSION_CODE)
            base_zip_path = DOWNLOADS_DIR / f"data64_v{DEFAULT_VERSION_CODE}.zip"
            console.print(f"\n[cyan]正在获取全量基础数据包: {base_zip_path.name}...[/]")
            if download_file(base_url, base_zip_path, force=args.force):
                console.print(f"[green]正在解压并对齐全量基础数据包到 Assets/...[/]")
                count = extract_update_zip(base_zip_path, ASSETS_DIR)
                console.print(f"[green]✔ 基础数据包解压完成，提取 {count} 个文件[/]")

            packages = build_update_package_list(info)
            if packages:
                console.print(f"\n[cyan]正在下载并整合 {len(packages)} 个增量补丁包...[/]")
                with Progress(
                    SpinnerColumn(),
                    TextColumn("[progress.description]{task.description}"),
                    BarColumn(),
                    TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
                    TimeElapsedColumn(),
                    console=console,
                ) as progress:
                    dl_task = progress.add_task("下载增量补丁", total=len(packages))
                    for pkg in packages:
                        pkg_path = DOWNLOADS_DIR / pkg["filename"]
                        download_file(pkg["url"], pkg_path, expected_size=pkg["size"], force=args.force)
                        extract_update_zip(pkg_path, ASSETS_DIR)
                        progress.advance(dl_task, 1)
                console.print("[green]✔ 所有增量补丁包合并完成[/]")

    if not args.no_decrypt:
        console.print("\n[cyan]正在执行 XXTEA 原地解密 (递归扫描 Assets/)...[/]")
        dec_count, total = decrypt_all_under_assets(ASSETS_DIR, jobs=jobs)
        console.print(
            f"[bold green]✔ Assets 资产整合与解密完成！[/bold green] 共扫描 {total} 个文件，解密 {dec_count} 个加密资产。"
        )
    else:
        console.print("[yellow]已跳过 XXTEA 解密步骤 (--no-decrypt)[/]")

    return 0


def cmd_masterdata(args: argparse.Namespace) -> int:
    """将 Assets/ 中的 Lua 脚本与数据表反编译并转为 indent=2 JSON 存入 MasterData/。"""
    jobs = args.jobs
    console.print(f"[bold cyan]== 开始反编译与提取数据表到 MasterData/ ==[/bold cyan]")

    if not ASSETS_DIR.is_dir():
        console.print("[red]错误: Assets/ 目录不存在，请先运行 `python3 HorcruxCollege.py assets`[/]")
        return 1

    lj_cmd = get_luajit_decompiler_cmd()
    unluac_cmd = get_unluac_cmd()
    if not lj_cmd and not unluac_cmd:
        console.print("[red]错误: 未检测到 luajit-decompier (或 luajit-decompiler) 及 unluac，无法进行反编译。[/]")
        return 1

    MASTER_DIR.mkdir(parents=True, exist_ok=True)

    all_lua_files: list[tuple[Path, Path]] = []
    for ext in ["*.luac", "*.lua"]:
        for p in ASSETS_DIR.rglob(ext):
            if p.is_file():
                rel = p.relative_to(ASSETS_DIR)
                all_lua_files.append((p, rel))

    json_copied = 0
    configs_dir = MASTER_DIR / "configs"
    configs_dir.mkdir(parents=True, exist_ok=True)
    for p in ASSETS_DIR.glob("*.json"):
        if p.is_file():
            out_p = configs_dir / p.name
            try:
                data = json.loads(p.read_text(encoding="utf-8"))
                out_p.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
            except Exception:
                shutil.copy2(p, out_p)
            json_copied += 1

    for extra_cfg in ["downloaddata.txt"]:
        cfg_p = ASSETS_DIR / extra_cfg
        if cfg_p.is_file():
            shutil.copy2(cfg_p, configs_dir / extra_cfg)
            json_copied += 1

    console.print(f"[cyan]已预处理 {json_copied} 个原生游戏配置文件[/]")

    staging_dir = Path(tempfile.gettempdir()) / "horcrux_masterdata_staging"
    if staging_dir.exists():
        shutil.rmtree(staging_dir, ignore_errors=True)
    staging_dir.mkdir(parents=True, exist_ok=True)

    precomputed_map: dict[str, Path] = {}
    if lj_cmd:
        console.print(f"[cyan]正在使用 {Path(lj_cmd).name} 批量预反编译 Lua 目标...[/]")
        target_subdirs = [p for p in [ASSETS_DIR / "data", ASSETS_DIR / "src64", ASSETS_DIR / "src"] if p.is_dir()]
        for subdir in target_subdirs:
            out_sub = staging_dir / subdir.name
            out_sub.mkdir(parents=True, exist_ok=True)
            cmd = [lj_cmd, str(subdir), "-o", str(out_sub), "-f", "-s", "-j", str(jobs)]
            subprocess.run(cmd, capture_output=True)

        for p in staging_dir.rglob("*.lua"):
            if p.is_file():
                orig_key = p.name
                if orig_key.endswith(".luac.lua"):
                    orig_key = orig_key[:-4]
                precomputed_map[orig_key] = p
                precomputed_map[p.stem] = p
        console.print(f"[green]✔ 批量预反编译就绪，命中 {len(precomputed_map)} 个反编译缓存[/]")

    console.print(f"[cyan]开始并发提取反编译后的 Lua 脚本与数据表至 MasterData/，共 {len(all_lua_files)} 个目标...[/]")

    def _worker(item: tuple[Path, Path]) -> tuple[str, bool]:
        src_path, rel_path = item
        pre_text = None
        cand_p = precomputed_map.get(src_path.name) or precomputed_map.get(src_path.stem)
        if cand_p and cand_p.is_file():
            try:
                pre_text = cand_p.read_text(encoding="utf-8-sig")
            except Exception:
                pass
        return process_single_masterdata_file(
            src_path, rel_path, lj_cmd, unluac_cmd, precomputed_text=pre_text
        )

    success_count = 0
    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
        TimeElapsedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("导出 MasterData", total=len(all_lua_files))
        with ThreadPoolExecutor(max_workers=jobs) as executor:
            future_to_file = {
                executor.submit(_worker, item): item[1] for item in all_lua_files
            }
            for future in as_completed(future_to_file):
                _, ok = future.result()
                if ok:
                    success_count += 1
                progress.advance(task, 1)

    if staging_dir.exists():
        shutil.rmtree(staging_dir, ignore_errors=True)

    manifest = {
        "game": GAME_TITLE,
        "export_time": time.strftime("%Y-%m-%d %H:%M:%S"),
        "total_targets": len(all_lua_files),
        "successful_exports": success_count,
        "json_configs_copied": json_copied,
    }
    (MASTER_DIR / "manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )

    console.print(f"[bold green]✔ MasterData 数据表提取与转换完成！[/bold green]")
    console.print(f"  成功处理: {success_count}/{len(all_lua_files)} 个文件")
    console.print(f"  输出目录: {MASTER_DIR}")
    return 0


def cmd_decrypt(args: argparse.Namespace) -> int:
    """独立解密指定路径的文件或目录下所有文件。"""
    target = Path(args.path).resolve()
    if not target.exists():
        console.print(f"[red]错误: 目标路径不存在: {target}[/]")
        return 1

    if target.is_file():
        ok = decrypt_file_inplace(target)
        if ok:
            console.print(f"[green]✔ 解密成功:[/] {target.name}")
        else:
            console.print(f"[yellow]文件无需解密或未被加密:[/] {target.name}")
        return 0

    console.print(f"[cyan]正在解密目录: {target}...[/]")
    dec_count, total = decrypt_all_under_assets(target, jobs=args.jobs)
    console.print(f"[bold green]✔ 解密完成！共解密 {dec_count}/{total} 个文件[/bold green]")
    return 0



def _safe_fs_name(text: str) -> str:
    """清理文件名中的非法字符与中括号，转换为安全字符，规范化空格。"""
    text = re.sub(r"[【】\[\]]", "", str(text)).strip()
    table = str.maketrans(
        {
            "/": "／",
            "\\": "＼",
            ":": "：",
            "*": "＊",
            "?": "？",
            '"': "'",
            "<": "＜",
            ">": "＞",
            "|": "｜",
            "\n": "",
            "\r": "",
            "\t": " ",
        }
    )
    out = text.translate(table).strip()
    out = re.sub(r"\s+", "_", out)
    return out or "未知"


def painting_filename(
    cha: str,
    skin: str,
    used: set[str],
    notes: Iterable[str] | None = None,
) -> str:
    """游戏名_角色名_皮肤/变体名[_备注...].png，参考 CatFantasy / RevivedWitch 规范。"""
    c_clean = _safe_fs_name(cha)
    parts = [GAME_TITLE, c_clean]
    s_clean = _safe_fs_name(skin)
    if s_clean and s_clean not in (c_clean, "原版", "未知"):
        parts.append(s_clean)
    for note in notes or []:
        cleaned = _safe_fs_name(str(note))
        if cleaned:
            parts.append(cleaned)
    base = "_".join(parts) + ".png"
    if base not in used:
        used.add(base)
        return base
    n = 2
    while True:
        name = "_".join(parts + [str(n)]) + ".png"
        if name not in used:
            used.add(name)
            return name
        n += 1


def load_painting_mappings(data_dir: Path) -> dict[str, tuple[str, str]]:
    """从 MasterData/data 解析所有角色与皮肤的 model/role_image -> (角色名, 皮肤名) 映射。"""
    mapping: dict[str, tuple[str, str, int]] = {}

    def _parse_cha_skin(text: str) -> tuple[str, str]:
        text = text.strip()
        m = re.search(r"^[【\[](.*?)[】\]](.*)$", text)
        if m:
            s, c = m.group(1).strip(), m.group(2).strip()
            if not s:
                return re.sub(r"[【】\[\]]", "", c).strip(), ""
            if c:
                return re.sub(r"[【】\[\]]", "", c).strip(), re.sub(r"[【】\[\]]", "", s).strip()
            return "", re.sub(r"[【】\[\]]", "", s).strip()
        clean = re.sub(r"[【】\[\]]", "", text).strip()
        return clean, ""

    def _add(key: str | int | None, cha: str, skin: str, prio: int = 1) -> None:
        k = str(key).strip() if key is not None else ""
        c = str(cha).strip() if cha else ""
        s = str(skin).strip() if skin else ""
        if not k or k in ("0", "-1", "none"):
            return
        if "【" in c or "[" in c:
            tc, ts = _parse_cha_skin(c)
            if tc:
                c = tc
            if ts and not s:
                s = ts
        if "【" in s or "[" in s:
            _, ts = _parse_cha_skin(s)
            s = ts or re.sub(r"[【】\[\]]", "", s).strip()
        c = re.sub(r"[【】\[\]]", "", c).strip()
        s = re.sub(r"[【】\[\]]", "", s).strip()
        if not c and not s:
            return

        if k not in mapping:
            mapping[k] = (c, s, prio)
        else:
            old_c, old_s, old_prio = mapping[k]
            if prio > old_prio:
                new_c = c or old_c
                new_s = s or old_s
                mapping[k] = (new_c, new_s, prio)
            elif prio == old_prio:
                new_c = old_c or c
                new_s = old_s or s
                mapping[k] = (new_c, new_s, prio)
            else:
                new_c = old_c or c
                new_s = old_s or s
                mapping[k] = (new_c, new_s, old_prio)

    if not data_dir.is_dir():
        return {}

    major_names: dict[str, str] = {}
    for f in data_dir.rglob("*major_factor*.lua"):
        txt = f.read_text("utf-8", "replace")
        for m in re.finditer(r"\[\s*(\d+)\s*\]\s*=\s*\{([^}]+)\}", txt):
            mid = m.group(1)
            b = m.group(2)
            ename = re.search(r'\b(?:name_en|easy_name)\s*=\s*"([^"]+)"', b)
            name = re.search(r'\bname\s*=\s*"([^"]+)"', b)
            title_m = re.search(r'\btitle\s*=\s*"([^"]+)"', b)
            cname = ename.group(1) if ename else (name.group(1) if name else "")
            title = title_m.group(1).replace(" ", "") if title_m else ""
            if cname:
                major_names[mid] = cname
                for k in ["model_id", "servant_id", "id", "model", "role_image"]:
                    km = re.search(r"\b" + k + r'\s*=\s*"?(\w+)"?', b)
                    if km:
                        _add(km.group(1), cname, title, 5)

    for f in data_dir.rglob("*skin*.lua"):
        txt = f.read_text("utf-8", "replace")
        for chunk in re.split(r'\[\s*"?\w+"?\s*\]\s*=\s*\{', txt):
            if not chunk.strip():
                continue
            mkn = re.search(r'\bitem_market_name\s*=\s*"([^"]+)"', chunk)
            name_m = re.search(r'\bname\s*=\s*"([^"]+)"', chunk)
            major_m = re.search(r"\bmajor\s*=\s*(\d+)", chunk)
            cname = ""
            sname = ""
            if mkn:
                cname, sname = _parse_cha_skin(mkn.group(1))
            if not cname and major_m and major_m.group(1) in major_names:
                cname = major_names[major_m.group(1)]
            if not sname and name_m:
                _, sname = _parse_cha_skin(name_m.group(1))
                if not sname:
                    sname = name_m.group(1)
            for k in ["model", "shop_image", "ele", "image_id", "id"]:
                km = re.search(r"\b" + k + r'\s*=\s*"?(\w+)"?', chunk)
                if km:
                    _add(km.group(1), cname, sname, 4)

    for f in data_dir.rglob("*model*.lua"):
        txt = f.read_text("utf-8", "replace")
        for chunk in re.split(r'\[\s*"?[^"]+"?\s*\]\s*=\s*\{', txt):
            if not chunk.strip():
                continue
            name_m = re.search(r'\bname\s*=\s*"([^"]+)"', chunk)
            name_q = re.search(r'\bname_Q\s*=\s*"([^"]+)"', chunk)
            main_m = re.search(r'\bmain_name\s*=\s*"([^"]+)"', chunk)
            major_m = re.search(r"\bmajor\s*=\s*(\d+)", chunk)
            cname = ""
            sname = ""
            if name_m:
                cname, sname = _parse_cha_skin(name_m.group(1))
            if name_q and name_q.group(1):
                cname = name_q.group(1)
            if not cname and major_m and major_m.group(1) in major_names:
                cname = major_names[major_m.group(1)]
            if main_m and not sname:
                sname = main_m.group(1)
            for k in ["role_image", "broken_role", "cute_role", "head_image", "id", "spine_model"]:
                km = re.search(r"\b" + k + r'\s*=\s*"?([^",\s\}]+)"?', chunk)
                if km:
                    kid = km.group(1).strip('"')
                    _add(kid, cname, sname, 4)

    for f in data_dir.rglob("role_conversation_index_*_data.lua"):
        mid_m = re.search(r"role_conversation_index_(\d+)_data\.lua", f.name)
        if not mid_m:
            continue
        mid = mid_m.group(1)
        cname = major_names.get(mid, "")
        if not cname:
            continue
        txt = f.read_text("utf-8", "replace")
        for m in re.finditer(r'\[\s*"(\w+)"\s*\]\s*=\s*\{', txt):
            _add(m.group(1), cname, "", 3)

    for f in data_dir.rglob("*avatar*.lua"):
        txt = f.read_text("utf-8", "replace")
        for m in re.finditer(r'name\s*=\s*"(.+?)头像"[^}]+?image_id\s*=\s*"?(\w+)"?', txt):
            _add(m.group(2), m.group(1), "", 2)

    twist_f = data_dir / "package" / "package_skintwist_data.lua"
    if twist_f.is_file():
        txt = twist_f.read_text("utf-8", "replace")
        for chunk in re.split(r"\[\s*\d+\s*\]\s*=\s*\{", txt):
            nm = re.search(r'\bname\s*=\s*"([^"]+)"', chunk)
            mm = re.search(r'\bmodel\s*=\s*"?(\w+)"?', chunk)
            if nm and mm:
                _, sname = _parse_cha_skin(nm.group(1))
                _add(mm.group(1), "", sname, 2)

    for f in data_dir.rglob("*conversation*.lua"):
        txt = f.read_text("utf-8", "replace")
        for m in re.finditer(r'icon\s*=\s*"?(\w+)"?[^}]+?showName\s*=\s*"([^"]+)"', txt):
            _add(m.group(1), m.group(2), "", 1)
        for m in re.finditer(r'showName\s*=\s*"([^"]+)"[^}]+?icon\s*=\s*"?(\w+)"?', txt):
            _add(m.group(2), m.group(1), "", 1)

    photofile = data_dir / "photofile_data.lua"
    if photofile.is_file():
        text = photofile.read_text(encoding="utf-8", errors="replace")
        for m in re.finditer(r"\{\s*([^}]+)\}", text):
            b = m.group(1)
            ename = re.search(r'\beasy_name\s*=\s*"([^"]+)"', b)
            name = re.search(r'\bname\s*=\s*"([^"]+)"', b)
            title_m = re.search(r'\btitle\s*=\s*"([^"]+)"', b)
            cname = ename.group(1) if ename else (name.group(1) if name else "")
            title = title_m.group(1).replace(" ", "") if title_m else ""
            for k in ["model_id", "servant_id"]:
                km = re.search(r"\b" + k + r'\s*=\s*"?(\w+)"?', b)
                if km:
                    kid = km.group(1)
                    _add(kid, cname, title, 3)

    return {k: (v[0], v[1]) for k, v in mapping.items()}


def is_black_silhouette(img_path: Path) -> bool:
    try:
        from PIL import Image
        import numpy as np

        with Image.open(img_path) as im:
            thumb = im.resize((64, 64)).convert("RGBA")
            arr = np.array(thumb)
            alpha = arr[:, :, 3]
            vis = arr[alpha > 10]
            if len(vis) < 20:
                return True
            r, g, b = vis[:, 0], vis[:, 1], vis[:, 2]
            lum = 0.299 * r + 0.587 * g + 0.114 * b
            p95_lum = float(np.percentile(lum, 95))
            max_rgb = np.maximum(np.maximum(r, g), b)
            pct_bright = float(np.count_nonzero(max_rgb > 20) / len(vis))
            return p95_lum <= 12.0 and pct_bright < 0.05
    except Exception:
        return False


def cmd_painting(args: argparse.Namespace) -> int:
    out_dir = (args.out or PAINTING_DIR).resolve()
    out_dir.mkdir(parents=True, exist_ok=True)
    limit = getattr(args, "limit", 0) or 0
    force = getattr(args, "force", False)

    console.print(f"[bold cyan]== 开始导出 {GAME_TITLE} 角色卡面立绘到 Painting/ ==[/bold cyan]")

    if not ROLE_IMAGE_DIR.is_dir():
        console.print(
            f"[red]错误: 立绘目录不存在: {ROLE_IMAGE_DIR}[/]\n"
            f"[yellow]请先运行 `python3 HorcruxCollege.py assets` 还原游戏资产[/]"
        )
        return 1

    role_files = sorted(
        [
            p
            for p in ROLE_IMAGE_DIR.iterdir()
            if p.is_file() and p.suffix.lower() == ".png"
        ],
        key=lambda p: p.name,
    )

    if not role_files:
        console.print(f"[yellow]立绘目录下未找到 PNG 文件: {ROLE_IMAGE_DIR}[/]")
        return 0

    if limit > 0:
        role_files = role_files[:limit]
        console.print(f"[dim]已限制只处理前 {limit} 个立绘[/]")

    for old_file in out_dir.glob("*.png"):
        if is_black_silhouette(old_file) or any(c in old_file.name for c in "【】[]"):
            old_file.unlink(missing_ok=True)

    console.print(f"[cyan]发现 {len(role_files)} 个直接角色立绘文件，正在并发检测并过滤纯黑剪影...[/]")
    with ThreadPoolExecutor(max_workers=min(32, len(role_files))) as ex:
        is_sil_list = list(ex.map(is_black_silhouette, role_files))

    valid_role_files: list[Path] = []
    filtered_silhouettes: list[str] = []
    for src, is_sil in zip(role_files, is_sil_list):
        if is_sil:
            filtered_silhouettes.append(src.name)
        else:
            valid_role_files.append(src)

    if filtered_silhouettes:
        console.print(
            f"[yellow]已过滤 {len(filtered_silhouettes)} 个纯黑剪影立绘（如天公大法师等），安全保留 XMAS 等正常暗调立绘[/]"
        )
    role_files = valid_role_files

    console.print(f"[cyan]正在加载 MasterData 映射并准备导出 {len(role_files)} 张立绘...[/]")
    data_dir = MASTER_DIR / "data"
    mappings = load_painting_mappings(data_dir)

    used_names: set[str] = set()
    export_tasks: list[tuple[Path, Path, str, str]] = []

    for src in role_files:
        stem = src.stem
        notes: list[str] = []
        base_id = stem
        if stem.startswith("broken_"):
            base_id = stem[7:]
            notes.append("大破")
        elif stem.endswith("_birth"):
            base_id = stem[:-6]
            notes.append("生日")

        info = mappings.get(base_id, ("", ""))
        cha = info[0] or "未知"
        skin = info[1] or (base_id if cha == "未知" else "原版")

        fname = painting_filename(cha, skin, used_names, notes)
        dest_path = out_dir / fname
        export_tasks.append((src, dest_path, cha, skin))

    written = 0
    skipped = 0
    failed = 0

    with Progress(
        SpinnerColumn(),
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
        TimeElapsedColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("导出卡面立绘", total=len(export_tasks))
        for src, dst, cha, skin in export_tasks:
            if dst.is_file() and not force:
                skipped += 1
                progress.advance(task, 1)
                continue
            try:
                shutil.copy2(src, dst)
                written += 1
            except Exception as e:
                console.print(f"[red]复制失败[/] {src.name} -> {dst.name}: {e}")
                failed += 1
            progress.advance(task, 1)

    manifest = {
        "game": GAME_TITLE,
        "total_source_paintings": len(role_files) + len(filtered_silhouettes),
        "filtered_silhouettes": len(filtered_silhouettes),
        "exported": written,
        "skipped": skipped,
        "failed": failed,
        "output_dir": str(out_dir),
    }
    (out_dir / "manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )

    console.print(
        f"[bold green]Painting[/bold green] 写出 {written}  跳过 {skipped}  失败 {failed} → {out_dir}"
    )
    return 0


def cmd_all(args: argparse.Namespace) -> int:
    """顺序执行 assets, masterdata 和 painting 子命令。"""
    res = cmd_assets(args)
    if res != 0:
        return res
    res = cmd_masterdata(args)
    if res != 0:
        return res
    args.out = getattr(args, "out", PAINTING_DIR)
    args.limit = getattr(args, "limit", 0)
    return cmd_painting(args)


def build_parser() -> argparse.ArgumentParser:
    """构建支持子命令模式的 CLI 参数解析器。"""
    parser = argparse.ArgumentParser(
        description=f"{GAME_TITLE} 资产还原、XXTEA 解密与 MasterData 数据表导出工具"
    )
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument(
        "--jobs",
        "-j",
        type=int,
        default=DEFAULT_JOBS,
        help=f"并发工作线程数 (默认 {DEFAULT_JOBS})",
    )
    shared.add_argument(
        "--apk",
        type=Path,
        default=None,
        help="APK 文件路径 (默认自动在脚本同级目录查找 *.apk)",
    )

    sub = parser.add_subparsers(dest="command", required=True, help="可用子命令")

    sub.add_parser(
        "status",
        parents=[shared],
        help="查看 APK/本地/远端最新版本与补丁清单状态",
    )

    p_assets = sub.add_parser(
        "assets",
        parents=[shared],
        help="APK 底包提取 + 远端热更整合 + XXTEA 原地解密到 Assets/",
    )
    p_assets.add_argument("--force", "-f", action="store_true", help="强制覆盖已存在的文件")
    p_assets.add_argument(
        "--skip-download",
        action="store_true",
        help="跳过远端补丁下载，仅提取 APK 或处理已有压缩包",
    )
    p_assets.add_argument(
        "--skip-apk",
        action="store_true",
        help="跳过 APK 解包步骤",
    )
    p_assets.add_argument(
        "--no-decrypt",
        action="store_true",
        help="跳过 XXTEA 解密流程",
    )

    p_master = sub.add_parser(
        "masterdata",
        aliases=["data", "lua"],
        parents=[shared],
        help="反编译 Assets 中的 Lua 脚本与数据表，直接提取为明文 .lua 存入 MasterData/",
    )
    p_master.add_argument("--force", "-f", action="store_true", help="强制覆盖已生成的 MasterData 数据")

    p_paint = sub.add_parser(
        "painting",
        aliases=["portrait", "lihui"],
        parents=[shared],
        help="导出角色卡面立绘到 Painting/ (CatFantasy 规范命名)",
    )
    p_paint.add_argument("--out", type=Path, default=PAINTING_DIR, help=f"立绘输出目录 (默认 {PAINTING_DIR})")
    p_paint.add_argument("--force", "-f", action="store_true", help="强制覆盖已存在的立绘文件")
    p_paint.add_argument("--limit", type=int, default=0, help="限制导出的立绘数量 (0 为无限制)")

    p_dec = sub.add_parser(
        "decrypt",
        help="独立命令：对指定单文件或整个目录进行 XXTEA 原地解密",
    )
    p_dec.add_argument("path", help="待解密的文件或目录路径")
    p_dec.add_argument(
        "--jobs",
        "-j",
        type=int,
        default=DEFAULT_JOBS,
        help=f"并发工作线程数 (默认 {DEFAULT_JOBS})",
    )

    p_all = sub.add_parser(
        "all",
        parents=[shared],
        help="执行完整流程：assets + masterdata + painting",
    )
    p_all.add_argument("--force", "-f", action="store_true", help="强制覆盖")
    p_all.add_argument(
        "--skip-download",
        action="store_true",
        help="跳过远端补丁下载",
    )
    p_all.add_argument(
        "--skip-apk",
        action="store_true",
        help="跳过 APK 解包",
    )
    p_all.add_argument(
        "--no-decrypt",
        action="store_true",
        help="跳过解密",
    )

    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    if args.command == "status":
        return cmd_status(args)
    elif args.command == "assets":
        return cmd_assets(args)
    elif args.command in ("masterdata", "data", "lua"):
        return cmd_masterdata(args)
    elif args.command in ("painting", "portrait", "lihui"):
        return cmd_painting(args)
    elif args.command == "decrypt":
        return cmd_decrypt(args)
    elif args.command == "all":
        return cmd_all(args)
    else:
        parser.print_help()
        return 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        console.print("\n[yellow]操作已被用户中断[/]")
        sys.exit(130)
