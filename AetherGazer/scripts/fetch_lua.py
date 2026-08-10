"""
用法：
    python scripts/fetch_lua.py                  # scripts64+scripts32 -> Lua/x64 与 Lua/x86
    python scripts/fetch_lua.py --arch 64        # 只拆 64 位 -> Lua/x64
    python scripts/fetch_lua.py --arch 32        # 只拆 32 位 -> Lua/x86
    python scripts/fetch_lua.py --decompile      # 拆完后调用系统命令 luajit-decompiler 反编译
    python scripts/fetch_lua.py --output ./Lua   # 自定义输出根目录
    python scripts/fetch_lua.py --keep-prefix    # 保留 assets/luabuilds/... 前缀
"""

from __future__ import annotations

import argparse
import json
import shutil
import subprocess
import sys
import urllib.request
from pathlib import Path

from rich.console import Console
from rich.progress import (
    BarColumn,
    DownloadColumn,
    Progress,
    TextColumn,
    TimeRemainingColumn,
    TransferSpeedColumn,
)

DEFAULT_API = (
    "https://open.ys4fun.com/game-website-server/pass/sdk/"
    "get_game_hot_update_version?gameId=1"
)
USER_AGENT = (
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
    "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
)
ARCH_DIR = {"64": "x64", "32": "x86"}
LUA_ROOT = "assets/luabuilds/luajit2.0/"


def http_get(url: str, timeout: int = 60) -> bytes:
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return resp.read()


def find_lua_entries(
    entries: list[str], archs: list[str]
) -> dict[str, tuple[str, str, int]]:
    found: dict[str, tuple[str, str, int]] = {}
    for line in entries:
        parts = line.split("|")
        if len(parts) < 3:
            continue
        name = parts[0]
        if name.startswith("scripts") and name[7:] in archs:
            found[name[7:]] = (name, parts[1], int(parts[2]))
    missing = [a for a in archs if a not in found]
    if missing:
        raise RuntimeError(
            "热更清单中没有 " + ", ".join(f"scripts{a}" for a in missing)
        )
    return found


def download_bundle(url: str, dest: Path, size: int, console: Console) -> None:
    progress = Progress(
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        DownloadColumn(),
        TransferSpeedColumn(),
        TimeRemainingColumn(),
        console=console,
    )
    with progress:
        task = progress.add_task("[cyan]下载 bundle", total=size)
        req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
        with urllib.request.urlopen(req, timeout=120) as resp:
            with dest.open("wb") as f:
                while True:
                    chunk = resp.read(1024 * 256)
                    if not chunk:
                        break
                    f.write(chunk)
                    progress.update(task, advance=len(chunk))
    if dest.stat().st_size != size:
        raise RuntimeError(f"大小不匹配: {dest.stat().st_size} != {size}")


def extract_bundle(
    bundle: Path, arch: str, out_root: Path, console: Console,
    keep_prefix: bool = False, limit: int = 0,
) -> tuple[int, int]:
    """剥掉 10 字节填充头，UnityPy 解析并导出全部 .lua.bytes。"""
    raw = bundle.read_bytes()
    if raw[:10] != b"\x00" * 10:
        console.print("[yellow][!] 未检测到 10 字节填充头，仍按原样尝试[/yellow]")
    stripped = bundle.with_suffix(".stripped.ys")
    stripped.write_bytes(raw[10:])

    console.print(f"[*] UnityPy 解析 {bundle.name} ...")
    import UnityPy

    env = UnityPy.load(str(stripped))
    arch_dir = out_root / ARCH_DIR[arch]
    arch_dir.mkdir(parents=True, exist_ok=True)

    count = 0
    total = 0
    for path, obj in env.container.items():
        if not path.endswith(".lua.bytes"):
            continue
        if keep_prefix:
            rel = Path(path)
        elif path.startswith(LUA_ROOT):
            # assets/luabuilds/luajit2.0/<arch>/<rest> -> <rest>（arch 已作为目录）
            rest = path[len(LUA_ROOT) :]
            parts = rest.split("/", 1)
            rel = Path(parts[1]) if len(parts) > 1 else Path(rest)
        else:
            rel = Path(path)
        target = arch_dir / rel
        target.parent.mkdir(parents=True, exist_ok=True)
        data = obj.read()
        # m_Script 是 UTF-8 surrogateescape 解码的 str，反向编码可无损还原原始字节
        script = data.m_Script.encode("utf-8", "surrogateescape")
        target.write_bytes(script)
        count += 1
        total += len(script)
        if limit and count >= limit:
            break
    return count, total


def decompile_with_system_command(
    lua_root: Path, decomp_root: Path, console: Console
) -> bool:
    """调用系统命令 luajit-decompiler 反编译 Lua/x64 与 Lua/x86。"""
    cmd = shutil.which("luajit-decompiler")
    if not cmd:
        console.print(
            "[red]未找到系统命令 luajit-decompiler，请先安装：[/red]\n"
            "  cd /home/rikka/ArchPackages/luajit-decompiler-git && makepkg -i\n"
            "或直接从 fork 构建：cmake -B build -S . && cmake --build build"
        )
        return False

    ok = True
    for arch_dir in sorted(p for p in lua_root.iterdir() if p.is_dir()):
        out_dir = decomp_root / arch_dir.name
        console.print(f"[*] 反编译 {arch_dir} -> {out_dir}")
        proc = subprocess.run(
            [cmd, str(arch_dir), "-o", str(out_dir), "-s"],
            capture_output=True, text=True,
        )
        if proc.returncode != 0:
            console.print(f"[red]{arch_dir.name} 反编译失败（exit={proc.returncode}）[/red]")
            ok = False
        else:
            count = sum(1 for _ in out_dir.rglob("*.lua")) if out_dir.exists() else 0
            console.print(f"[green]  {arch_dir.name}: {count} 个 Lua[/green]")
    return ok


def main() -> int:
    parser = argparse.ArgumentParser(
        description="下载并提取深空之眼 Lua 脚本（scripts64 -> Lua/x64，scripts32 -> Lua/x86）"
    )
    parser.add_argument("--api", default=DEFAULT_API, help="热更新版本接口")
    parser.add_argument("--output", default="./Lua", help="Lua 输出根目录")
    parser.add_argument(
        "--arch", default="all", choices=("all", "32", "64"),
        help="提取架构：all=64+32（默认），32 / 64 只提取单个",
    )
    parser.add_argument("--keep-prefix", action="store_true", help="保留完整内部路径")
    parser.add_argument("--limit", type=int, default=0, help="每个架构只提取前 N 个（调试用）")
    parser.add_argument(
        "--decompile", action="store_true",
        help="提取完成后调用系统命令 luajit-decompiler 反编译到 LuaDecomp/",
    )
    args = parser.parse_args()

    archs = ["64", "32"] if args.arch == "all" else [args.arch]
    console = Console()

    console.print("[*] 获取热更新版本信息 ...")
    info = json.loads(http_get(args.api).decode("utf-8"))["data"]
    bases = [b for b in info["downloadUrl"].split(";") if b]

    console.print(f"[*] 下载资源清单 {info['assethash']} ...")
    manifest = None
    for base in bases:
        url = base.rstrip("/") + "/" + info["assethash"]
        try:
            manifest = json.loads(http_get(url).decode("utf-8"))
            break
        except Exception as exc:  # noqa: BLE001
            console.print(f"[yellow][!] {url}: {exc}")
    if manifest is None:
        console.print("[red]清单获取失败[/red]")
        return 1

    found = find_lua_entries(manifest["assetHashList"], archs)
    out_root = Path(args.output)
    out_root.mkdir(parents=True, exist_ok=True)

    for arch in archs:
        name, hash_, size = found[arch]
        console.print(
            f"[*] Lua bundle: {name} ({size / 1048576:.1f} MiB, md5={hash_})"
        )
        # 清单路径名 scripts64，但 CDN 上按 hash.ys 命名
        url = bases[0].rstrip("/") + "/" + hash_ + ".ys"
        bundle = Path(f"/tmp/aethergazer_{name}.ys")
        console.print(f"[*] 下载 {url}")
        try:
            download_bundle(url, bundle, size, console)
            count, total = extract_bundle(
                bundle, arch, out_root, console,
                keep_prefix=args.keep_prefix, limit=args.limit,
            )
            console.print(
                f"[green]完成: {count} 个 Lua 脚本（{total / 1048576:.2f} MiB）"
                f" -> {out_root / ARCH_DIR[arch]}[/green]"
            )
        except Exception as exc:  # noqa: BLE001
            console.print(f"[red]{name} 处理失败: {exc}[/red]")
            return 1

    if args.decompile:
        decomp_root = out_root.parent / "LuaDecomp"
        console.print(f"[*] 调用系统命令反编译 -> {decomp_root}")
        if not decompile_with_system_command(out_root, decomp_root, console):
            return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
