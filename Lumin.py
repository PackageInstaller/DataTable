from __future__ import annotations

import argparse
import json
import os
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

from lumin.manifest import (
    BundleIndex,
    build_catalog_dict,
    load_manifest,
    logical_relpath,
    manifest_summary,
    migrate_hash_layout,
    restore_package_links,
)
from lumin.masterdata import (
    decompile_dlls,
    decrypt_version_txt,
    export_clientstatic_bundle,
    export_dll_bundle,
    export_localization,
    write_configs,
    write_index,
)
from lumin.progress import ProgressUI
from lumin.remote import (
    download_file,
    download_manifest,
    extract_zip,
    fetch_config,
    parse_config,
)
from lumin.unityfs import UnityFS
from LuminDecrypt import decrypt_file_in_place

ROOT = Path(__file__).resolve().parent
DEFAULT_WORK = ROOT / "Cache"
DEFAULT_MASTER = ROOT / "MasterData"
DEFAULT_DEP = ROOT / "dll"
ALL_PACKAGES = ("Assets", "ClientStatic", "Dll", "RawFile")


def log(message: str) -> None:
    print(f"[{time.strftime('%H:%M:%S')}] {message}", flush=True)


def fmt_size(value: int) -> str:
    for unit in ("B", "KB", "MB", "GB", "TB"):
        if value < 1024 or unit == "TB":
            return f"{value:.1f}{unit}" if unit != "B" else f"{value}B"
        value /= 1024
    return f"{value:.1f}TB"


def dir_size(path: Path) -> int:
    if not path.exists():
        return 0
    total = 0
    for root, _, files in os.walk(path):
        for name in files:
            try:
                total += (Path(root) / name).stat().st_size
            except OSError:
                pass
    return total


def parse_list(value: str | None, default: tuple[str, ...]) -> list[str]:
    if not value:
        return list(default)
    items = [x.strip() for x in value.split(",") if x.strip()]
    return items if items else list(default)


def load_remote(work: Path, offline: bool = False, form: dict | None = None) -> dict:
    remote_path = work / "remote.json"
    if offline:
        if not remote_path.is_file():
            raise FileNotFoundError(f"离线模式下找不到 {remote_path}")
        return json.loads(remote_path.read_text(encoding="utf-8"))
    work.mkdir(parents=True, exist_ok=True)
    cfg = fetch_config(form=form)
    remote_path.write_text(json.dumps(cfg, ensure_ascii=False, indent=2), encoding="utf-8")
    return cfg


def get_packages(cfg: dict) -> dict:
    return parse_config(cfg)


def ensure_manifest(pkg, work: Path, force: bool = False, template: str | None = None) -> Path:
    man_dir = work / "manifests"
    man_dir.mkdir(parents=True, exist_ok=True)
    out_path = man_dir / f"{pkg.name}_{pkg.version}.bytes"
    if out_path.is_file() and not force:
        return out_path
    download_manifest(pkg, man_dir, template=template, force=force)
    log(f"{pkg.name}: 清单 -> {out_path.name} ({fmt_size(out_path.stat().st_size)})")
    return out_path


def ensure_package_zips(
    pkg,
    work: Path,
    tags: set[str] | None = None,
    force: bool = False,
    ui: ProgressUI | None = None,
) -> None:
    say = ui.log if ui else log
    zips_dir = work / "zips" / pkg.name
    bundle_dir = work / "bundles" / pkg.name
    zips_dir.mkdir(parents=True, exist_ok=True)
    bundle_dir.mkdir(parents=True, exist_ok=True)

    manifest_file = work / "manifests" / f"{pkg.name}_{pkg.version}.bytes"
    hash_map: dict[str, str] = {}
    manifest = None
    if manifest_file.is_file():
        try:
            manifest = load_manifest(manifest_file)
            idx = BundleIndex.build(manifest)
            for b in manifest.bundle_list:
                assets = idx.assets_by_bundle_hash.get(b.file_hash, [])
                hash_map[b.file_hash] = logical_relpath(b, assets, pkg.name)
        except Exception:
            pass

    if manifest:
        migrate_hash_layout(bundle_dir, manifest, log_fn=say)

    entries = [z for z in pkg.zips if tags is None or z.tag in tags]
    for entry in entries:
        zip_path = zips_dir / entry.name
        need_download = force or not zip_path.is_file() or zip_path.stat().st_size != entry.size
        if not need_download:
            say(f"{pkg.name}: 已存在 {entry.name}")
        else:
            task = ui.add_download(entry.name, entry.size) if ui else None

            def callback(name: str, done: int, total: int, finished: bool = False) -> None:
                if ui and task is not None:
                    ui.update_download(task, done, total)

            try:
                download_file(
                    pkg.cdn + entry.url,
                    zip_path,
                    expected_size=entry.size,
                    resume=True,
                    progress=callback,
                )
            except Exception as exc:
                if not pkg.backup_cdn:
                    raise
                say(f"{pkg.name}: 主 CDN 失败 ({exc})，尝试备用 CDN")
                download_file(
                    pkg.backup_cdn + entry.url,
                    zip_path,
                    expected_size=entry.size,
                    resume=True,
                    progress=callback,
                )
            if ui and task is not None:
                ui.finish_download(task)

        count = extract_zip(zip_path, bundle_dir, force=force, hash_map=hash_map)
        say(f"{pkg.name}: 解包 {entry.name} -> {count} 个 bundle")


def decrypt_bundles_in_dir(
    bundles_dir: Path,
    workers: int = 4,
    ui: ProgressUI | None = None,
    manifest: PackageManifest | None = None,
) -> tuple[int, int]:
    if not bundles_dir.is_dir():
        return 0, 0
    if manifest:
        idx = BundleIndex.build(manifest)
        files = [idx.bundle_path(bundles_dir, b, manifest.package_name) for b in manifest.bundle_list]
        files = [f for f in files if f.is_file()]
    else:
        files = [f for f in bundles_dir.rglob("*") if f.is_file() and not f.name.startswith(".")]

    if not files:
        return 0, 0

    task = ui.add_extract(bundles_dir.name, len(files)) if ui else None
    decrypted = 0

    if workers <= 1:
        for f in files:
            if decrypt_file_in_place(f):
                decrypted += 1
            if ui:
                ui.advance(task)
    else:
        with ThreadPoolExecutor(max_workers=workers) as pool:
            futures = [pool.submit(decrypt_file_in_place, f) for f in files]
            for fut in as_completed(futures):
                if fut.result():
                    decrypted += 1
                if ui:
                    ui.advance(task)

    return len(files), decrypted



def cmd_status(args) -> int:
    work = Path(args.workdir)
    master = Path(args.master)
    try:
        cfg = load_remote(work, offline=args.offline, form=args.form)
        pkgs = get_packages(cfg)
        log("远端版本: " + ", ".join(f"{p.name}={p.version}" for p in pkgs.values()))
        for p in pkgs.values():
            total_sz = sum(z.size for z in p.zips)
            log(f"  {p.name:<12} {len(p.zips)} zips {fmt_size(total_sz)}")
    except Exception as exc:
        log(f"无法获取远端状态: {exc}")

    bundle_count = sum(1 for f in (work / "bundles").rglob("*") if f.is_file() and not f.name.startswith(".")) if (work / "bundles").exists() else 0
    zip_count = sum(1 for _ in (work / "zips").rglob("*.zip")) if (work / "zips").exists() else 0
    log(f"缓存目录: {work} ({fmt_size(dir_size(work))})")
    log(f"  bundles: {bundle_count} 个")
    log(f"  zips:    {zip_count} 个")
    log(f"MasterData: {master} ({fmt_size(dir_size(master))})")
    return 0


def cmd_download(args) -> int:
    work = Path(args.workdir)
    cfg = load_remote(work, offline=args.offline, form=args.form)
    pkgs = get_packages(cfg)
    selected = parse_list(args.packages, ALL_PACKAGES)
    tags = set(args.tags.split(",")) if getattr(args, "tags", None) else None

    with ProgressUI() as ui:
        for name in selected:
            if name not in pkgs:
                ui.log(f"未知包名: {name}")
                continue
            pkg = pkgs[name]
            ensure_manifest(pkg, work, force=args.force, template=getattr(args, "manifest_template", None))
            if getattr(args, "manifest_only", False):
                continue
            ensure_package_zips(pkg, work, tags=tags, force=args.force, ui=ui)
    return 0


def cmd_decrypt(args) -> int:
    if getattr(args, "file", None):
        target = Path(args.file)
        if not target.is_file():
            log(f"文件不存在: {target}")
            return 1
        changed = decrypt_file_in_place(target)
        log(f"{target.name}: {'已解密并就地保存' if changed else '此前已是明文'}")
        return 0

    work = Path(args.workdir)
    selected = parse_list(args.packages, ALL_PACKAGES)
    with ProgressUI() as ui:
        for name in selected:
            bundles_dir = work / "bundles" / name
            cands = sorted((work / "manifests").glob(f"{name}_*.bytes")) if (work / "manifests").exists() else []
            manifest = load_manifest(cands[-1]) if cands else None
            total, dec = decrypt_bundles_in_dir(bundles_dir, workers=args.jobs, ui=ui, manifest=manifest)
            msg = f"{name}: 检查 {total} 个 bundle，新解密 {dec} 个"
            if ui:
                ui.log(msg)
            else:
                log(msg)
    return 0


def cmd_masterdata(args) -> int:
    work = Path(args.workdir)
    master = Path(args.master)
    cfg = None
    try:
        cfg = load_remote(work, offline=args.offline, form=args.form)
    except Exception:
        pass
    pkgs = get_packages(cfg) if cfg else {}
    tables: list[str] = []
    aot: list[str] = []

    for name, kind in (("ClientStatic", "ClientStatic"), ("Dll", "Dll")):
        pkg = pkgs.get(name)
        if pkg:
            manifest_path = ensure_manifest(pkg, work, template=getattr(args, "manifest_template", None))
        else:
            cands = sorted((work / "manifests").glob(f"{name}_*.bytes")) if (work / "manifests").exists() else []
            if not cands:
                log(f"{name}: 缺少清单")
                continue
            manifest_path = cands[-1]

        manifest = load_manifest(manifest_path)
        index = BundleIndex.build(manifest)
        bundles_dir = work / "bundles" / name

        for b in manifest.bundle_list:
            path = index.bundle_path(bundles_dir, b)
            if not path.is_file():
                continue
            try:
                raw = UnityFS(path.read_bytes()).decrypted_bytes()
            except Exception as exc:
                log(f"{name}: 解密失败 {b.bundle_name}: {exc}")
                continue

            if kind == "ClientStatic":
                st = export_clientstatic_bundle(raw, master / "ClientStatic", args.overwrite)
                tables.extend(st["files"])
            else:
                st = export_dll_bundle(raw, master / "AOT", args.overwrite)
                aot.extend(st["names"])
        log(f"{name}: 数据表 {len(tables)} / AOT {len(aot)}")

    if cfg:
        manifests = {}
        for name, pkg in pkgs.items():
            mp = work / "manifests" / f"{name}_{pkg.version}.bytes"
            if mp.is_file():
                manifests[name] = manifest_summary(load_manifest(mp))
        version_txt = None
        for candidate in (work / "version.txt", ROOT / "version.txt"):
            if candidate.is_file():
                version_txt = decrypt_version_txt(candidate.read_text(encoding="utf-8", errors="replace"))
                if version_txt:
                    break
        write_configs(master / "config", remote_config=cfg, manifests=manifests, version_txt=version_txt)

    if not getattr(args, "no_decompile", False) and (master / "AOT").is_dir():
        deps = get_dep_dirs(args)
        decompile_dlls(master / "AOT", dep_dirs=deps, overwrite=args.overwrite, jobs=args.jobs, log_fn=log)

    loc_bundle = work / "bundles" / "ClientStatic" / "clientstatic" / "assets" / "generate" / "database" / "localization.bundle"
    if not loc_bundle.is_file():
        cands = list((work / "bundles" / "ClientStatic").rglob("*localization*.bundle"))
        if cands:
            loc_bundle = cands[0]

    loc_count = export_localization(loc_bundle, master / "Localization", overwrite=args.overwrite, log_fn=log)
    if loc_count:
        log(f"Localization: 已导出 {loc_count} 张多语言数据表 -> {master / 'Localization'}")
    write_index(master, tables, aot, loc_count)
    log(f"MasterData: {master} ({fmt_size(dir_size(master))})")
    return 0


def get_dep_dirs(args) -> list[Path]:
    raw = getattr(args, "dep_dir", None)
    cand = Path(raw) if raw else DEFAULT_DEP
    if not cand.is_dir():
        alt = ROOT.parent.parent / "Games" / "绿梦" / "dll"
        if alt.is_dir():
            cand = alt
    return [cand] if cand.is_dir() else []


def cmd_decompile(args) -> int:
    master = Path(args.master)
    aot_dir = master / "AOT"
    if not aot_dir.is_dir():
        log(f"AOT 目录不存在: {aot_dir}，请先执行 masterdata 提取")
        return 1
    deps = get_dep_dirs(args)
    decompile_dlls(aot_dir, dep_dirs=deps, overwrite=args.overwrite, jobs=args.jobs, log_fn=log)
    return 0


def cmd_catalog(args) -> int:
    work = Path(args.workdir)
    master = Path(args.master)
    manifests_dir = work / "manifests"
    if not manifests_dir.is_dir():
        log(f"清单目录不存在: {manifests_dir}，请先执行 download --manifest-only")
        return 1

    pkgs = [p.strip() for p in args.packages.split(",")] if args.packages else ALL_PACKAGES
    catalog = {}
    restore_out = Path(args.out) if args.out else work / "restored"

    for name in ALL_PACKAGES:
        p_list = sorted(manifests_dir.glob(f"{name}_*.bytes"))
        if not p_list:
            continue
        m = load_manifest(p_list[-1])
        c_dict = build_catalog_dict(m)
        catalog[name] = c_dict

        if (args.link or args.copy) and (name in pkgs):
            bundles_dir = work / "bundles" / name
            if bundles_dir.is_dir():
                n = restore_package_links(
                    m,
                    bundles_dir,
                    restore_out / name,
                    symlink=(not args.copy),
                )
                log(f"{name}: 已还原 {n} 个文件 -> {restore_out / name}")

    if not args.no_json:
        out_json = master / "config" / "catalog.json"
        out_json.parent.mkdir(parents=True, exist_ok=True)
        out_json.write_text(json.dumps(catalog, ensure_ascii=False, indent=2), encoding="utf-8")
        log(f"已导出全量清单索引: {out_json} ({fmt_size(out_json.stat().st_size)})")

    return 0


def cmd_update(args) -> int:
    rc = cmd_download(args)
    if rc:
        return rc
    rc = cmd_decrypt(args)
    if rc:
        return rc
    if not args.no_master:
        rc = cmd_masterdata(args)
        if rc:
            return rc
    return 0


def add_common(p: argparse.ArgumentParser) -> None:
    p.add_argument("--workdir", default=str(DEFAULT_WORK), help="工作/缓存目录")
    p.add_argument("--master", default=str(DEFAULT_MASTER), help="MasterData 输出目录")
    p.add_argument("--dep-dir", default=str(DEFAULT_DEP), help="外部依赖程序集目录（即 dll/ 目录）")
    p.add_argument(
        "--jobs",
        type=int,
        default=max(1, min(8, os.cpu_count() or 4)),
        help="并发线程数",
    )
    p.add_argument("--offline", action="store_true", help="离线模式")
    p.add_argument("--form", type=json.loads, default=None, help="覆盖远端配置 form")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="Lumin.py",
        description="绿梦：时空之声 数据表还原与资产就地解密工具",
    )
    sub = parser.add_subparsers(dest="command", required=True)

    p_status = sub.add_parser("status", help="查看远端版本与本地状态")
    add_common(p_status)
    p_status.set_defaults(func=cmd_status)

    p_dl = sub.add_parser("download", help="下载清单与全量 zip 并解包")
    add_common(p_dl)
    p_dl.add_argument("--packages", default=None, help="Assets,ClientStatic,Dll,RawFile")
    p_dl.add_argument("--tags", default=None, help="Preload,Default,Video 等")
    p_dl.add_argument("--manifest-only", action="store_true", help="只下载清单")
    p_dl.add_argument("--force", action="store_true", help="强制重新下载")
    p_dl.add_argument("--manifest-template", default=None)
    p_dl.set_defaults(func=cmd_download)

    p_dec = sub.add_parser("decrypt", help="就地解密 bundle 或单个文件")
    add_common(p_dec)
    p_dec.add_argument("file", nargs="?", default=None, help="单个待解密文件路径（可选）")
    p_dec.add_argument("--packages", default=None)
    p_dec.set_defaults(func=cmd_decrypt)

    p_md = sub.add_parser("masterdata", help="提取 MasterData 数据表与 AOT 程序集")
    add_common(p_md)
    p_md.add_argument("--overwrite", action="store_true", help="强制覆盖已存在文件")
    p_md.add_argument("--no-decompile", action="store_true", help="跳过 ilspycmd 反编译")
    p_md.add_argument("--manifest-template", default=None)
    p_md.set_defaults(func=cmd_masterdata)

    p_dec_dll = sub.add_parser("decompile", help="使用 ilspycmd 反编译 AOT 程序集为 C# 工程")
    add_common(p_dec_dll)
    p_dec_dll.add_argument("--overwrite", action="store_true", help="强制重新反编译")
    p_dec_dll.set_defaults(func=cmd_decompile)

    p_cat = sub.add_parser("catalog", help="导出全量资产清单映射 JSON 并可选还原人类可读目录")
    add_common(p_cat)
    p_cat.add_argument("--packages", default=None, help="Assets,ClientStatic,Dll,RawFile")
    p_cat.add_argument("--link", action="store_true", help="使用软链接还原到人类可读目录结构（默认 Cache/restored）")
    p_cat.add_argument("--copy", action="store_true", help="使用复制还原到人类可读目录结构")
    p_cat.add_argument("--out", default=None, help="还原输出目录，默认 Cache/restored")
    p_cat.add_argument("--no-json", action="store_true", help="不生成 catalog.json")
    p_cat.set_defaults(func=cmd_catalog)

    p_up = sub.add_parser("update", help="全流程：download + decrypt + masterdata (含 decompile)")
    add_common(p_up)
    p_up.add_argument("--packages", default=None)
    p_up.add_argument("--tags", default=None)
    p_up.add_argument("--force", action="store_true")
    p_up.add_argument("--overwrite", action="store_true")
    p_up.add_argument("--no-decompile", action="store_true", help="跳过 ilspycmd 反编译")
    p_up.add_argument("--no-master", action="store_true")
    p_up.add_argument("--manifest-template", default=None)
    p_up.set_defaults(func=cmd_update)

    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    try:
        return args.func(args)
    except KeyboardInterrupt:
        log("已中断")
        return 130
    except Exception as exc:
        log(f"错误: {exc}")
        if os.environ.get("LUMIN_DEBUG"):
            raise
        return 1


if __name__ == "__main__":
    sys.exit(main())
