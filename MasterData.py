from __future__ import annotations

import json
import shutil
from pathlib import Path

from AMF3 import amf3_to_jsonable, try_decode_amf3
from CompressUtil import decode_custom_b64, maybe_zlib
from Config import MASTER_DIR, resolve_assets
from GSDecrypt import dump_gs_json
from Language import dump_language_json, looks_like_language
from Packed import dump_factory_pack, dump_utf_catalog


def _safe_copy(src: Path, dst: Path) -> None:
    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dst)


def extract_language(assets: Path, master: Path) -> int:
    count = 0
    seen: set[Path] = set()
    candidates: list[Path] = []
    lang_dir = assets / "language"
    if lang_dir.exists():
        candidates.extend(sorted(lang_dir.glob("*.bin")))
    candidates.extend(sorted(assets.rglob("language_*.bin")))
    etc_dir = assets / "etc"
    if etc_dir.exists():
        candidates.extend(sorted(etc_dir.glob("*.bin")))
    for src in candidates:
        key = src.resolve()
        if key in seen:
            continue
        seen.add(key)
        data = src.read_bytes()
        if looks_like_language(data) is None:
            continue
        rel = key.relative_to(assets.resolve())
        dst = master / "language" / rel.with_suffix(".json")
        try:
            n = dump_language_json(key, dst)
            print(f"[data] 语言 {rel} -> {n} 条")
            count += 1
        except Exception as exc:
            print(f"[data] 跳过语言 {rel}: {exc}")
    return count


def extract_gs(assets: Path, master: Path) -> int:
    count = 0
    for src in assets.rglob("*.gs"):
        rel = src.relative_to(assets)
        dst = master / "gs" / rel.with_suffix(".json")
        try:
            dump_gs_json(src, dst)
            count += 1
        except Exception as exc:
            print(f"[data] GS 失败 {rel}: {exc}")
    print(f"[data] 解密 {count} 个 .gs")
    return count


def extract_bins(assets: Path, master: Path) -> int:
    count = 0
    skip_names = {"huList.bin"}
    newest_all: Path | None = None
    newest_sk: Path | None = None
    others: list[Path] = []
    for src in assets.rglob("*"):
        if not src.is_file():
            continue
        if src.suffix.lower() not in {".bin", ".dat"}:
            continue
        if src.name in skip_names:
            continue
        if src.name == "all.bin":
            if newest_all is None or src.stat().st_mtime >= newest_all.stat().st_mtime:
                newest_all = src
            continue
        if src.name == "sk.bin":
            if newest_sk is None or src.stat().st_mtime >= newest_sk.stat().st_mtime:
                newest_sk = src
            continue
        others.append(src)

    if newest_all is not None:
        plain = maybe_zlib(newest_all.read_bytes())
        n = dump_factory_pack(plain, master / "database")
        print(f"[data] 工厂包 {newest_all.relative_to(assets)} -> {n} 个工厂")
        count += 1
    if newest_sk is not None:
        plain = maybe_zlib(newest_sk.read_bytes())
        n = dump_utf_catalog(plain, master / "sk")
        print(f"[data] 骨骼包 {newest_sk.relative_to(assets)} -> {n} 个文件")
        count += 1

    for src in others:
        rel = src.relative_to(assets)
        data = src.read_bytes()
        if looks_like_language(data) is not None:
            continue
        plain = maybe_zlib(data)
        out_dir = master / "bin" / rel.parent
        out_dir.mkdir(parents=True, exist_ok=True)
        if plain != data:
            raw_path = out_dir / (src.stem + ".raw")
            raw_path.write_bytes(plain)
            print(f"[data] zlib {rel} -> {raw_path.relative_to(master)} ({len(plain)} 字节)")
            count += 1
        if src.name == "notice.bin":
            (master / "notice.txt").write_bytes(plain)
        obj = try_decode_amf3(plain)
        if obj is not None:
            json_path = out_dir / (src.stem + ".json")
            json_path.write_text(
                json.dumps(amf3_to_jsonable(obj), ensure_ascii=False, indent=2),
                encoding="utf-8",
            )
            print(f"[data] AMF3 {rel}")
            count += 1
    return count


def extract_texts(assets: Path, master: Path) -> int:
    count = 0
    skip_parts = {"spine", "animation", "BGM", "video", "texture", "patchAsset"}
    for pattern in ("*.xml", "*.txt", "*.json", "*.atlas"):
        for src in assets.rglob(pattern):
            if any(part in skip_parts for part in src.parts):
                continue
            if src.suffix.lower() == ".txt" and src.name == "desc.txt":
                dst = master / "desc" / src.relative_to(assets)
            elif src.parent.name in {"xml", "etc", "guide", "config"} or src.suffix.lower() == ".xml":
                dst = master / src.relative_to(assets)
            else:
                continue
            _safe_copy(src, dst)
            count += 1
    return count


def extract_bdgs(master: Path) -> None:
    info_path = master / "info.json"
    if not info_path.exists():
        return
    info = json.loads(info_path.read_text(encoding="utf-8"))
    bdgs = info.get("bdgs")
    if not bdgs or not isinstance(bdgs, str):
        return
    raw = decode_custom_b64(bdgs)
    gs_path = master / "bdgs.gs"
    gs_path.write_bytes(raw)
    try:
        dump_gs_json(gs_path, master / "bdgs.json")
        print("[data] 已解码 info.bdgs")
    except Exception as exc:
        print(f"[data] bdgs 解密失败: {exc}")


def extract_masterdata(assets: Path | None = None, master: Path | None = None) -> None:
    assets = assets or resolve_assets()
    master = master or MASTER_DIR
    master.mkdir(parents=True, exist_ok=True)
    extract_language(assets, master)
    extract_gs(assets, master)
    extract_bins(assets, master)
    extract_texts(assets, master)
    extract_bdgs(master)
    print(f"[data] MasterData -> {master}")
