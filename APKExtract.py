from __future__ import annotations

import zipfile
from pathlib import Path

from Config import ROOT, resolve_assets


def find_apk(root: Path | None = None) -> Path:
    root = root or ROOT
    apks = sorted(root.glob("*.apk"), key=lambda p: p.stat().st_mtime, reverse=True)
    if not apks:
        raise FileNotFoundError(f"未在 {root} 找到 APK")
    return apks[0]


def extract_apk_assets(apk_path: Path | None = None, dest: Path | None = None) -> Path:
    apk_path = apk_path or find_apk()
    dest = dest or resolve_assets()
    dest.mkdir(parents=True, exist_ok=True)
    copied = skipped = 0
    with zipfile.ZipFile(apk_path) as zf:
        members = [n for n in zf.namelist() if n.startswith("assets/") and not n.endswith("/")]
        print(f"[apk] {apk_path.name} 中有 {len(members)} 个 assets 文件")
        for name in members:
            rel = name[len("assets/") :]
            if not rel:
                continue
            out = dest / rel
            info = zf.getinfo(name)
            if out.exists() and out.stat().st_size == info.file_size:
                skipped += 1
                continue
            out.parent.mkdir(parents=True, exist_ok=True)
            with zf.open(name) as src, open(out, "wb") as dst:
                dst.write(src.read())
            copied += 1
    print(f"[apk] 写入 {copied}，跳过已存在 {skipped} -> {dest}")
    return dest
