from __future__ import annotations

from pathlib import Path

from Config import ROOT, resolve_assets
from Decode import batch


def find_all_bin(assets: Path) -> Path | None:
    for cand in (assets / "bin" / "all.bin", assets / "hu" / "bin" / "all.bin"):
        if cand.exists():
            return cand
    found = list(assets.rglob("all.bin"))
    return found[0] if found else None


def find_desc(assets: Path) -> Path | None:
    for cand in (
        assets / "desc" / "desc.txt",
        assets / "texture" / "desc.txt",
        assets / "hu" / "desc" / "desc.txt",
    ):
        if cand.exists():
            return cand
    found = list(assets.rglob("desc.txt"))
    return found[0] if found else None


def decrypt_enc_files(assets: Path | None = None) -> None:
    assets = assets or resolve_assets()
    all_bin = find_all_bin(assets)
    desc = find_desc(assets)
    if not all_bin:
        print("[enc] 未找到 all.bin，按文件名回退输出")
        all_bin = ROOT / "all.bin"
    if not desc:
        print("[enc] 未找到 desc.txt，尺寸信息可能缺失")
        desc = ROOT / "desc.txt"
    print(f"[enc] all.bin={all_bin}")
    print(f"[enc] desc.txt={desc}")
    batch(
        texPath=str(assets),
        allbin=str(all_bin) if all_bin.exists() else "all.bin",
        desc=str(desc) if desc.exists() else "desc.txt",
        exts=(".enc", ".cet"),
        subfolder=True,
    )
