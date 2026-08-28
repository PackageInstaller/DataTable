from __future__ import annotations

import argparse
import sys

from Config import MASTER_DIR, PAINTING_DIR, ROOT, SWF_DIR, resolve_assets


def cmd_apk(_args: argparse.Namespace) -> None:
    from APKExtract import extract_apk_assets

    extract_apk_assets()


def cmd_hotupdate(args: argparse.Namespace) -> None:
    from HotUpdate import update_hotupdate

    update_hotupdate(full=args.full)


def cmd_enc(_args: argparse.Namespace) -> None:
    from EncDecrypt import decrypt_enc_files

    decrypt_enc_files()


def cmd_masterdata(_args: argparse.Namespace) -> None:
    from MasterData import extract_masterdata

    extract_masterdata()


def cmd_painting(args: argparse.Namespace) -> None:
    from Painting import export_paintings

    export_paintings(include_other=args.include_other)


def cmd_swf(_args: argparse.Namespace) -> None:
    from SWFExport import export_swf

    export_swf()


def cmd_all(args: argparse.Namespace) -> None:
    cmd_apk(args)
    cmd_hotupdate(args)
    if not args.skip_enc:
        cmd_enc(args)
    cmd_masterdata(args)
    cmd_painting(args)
    if not args.skip_swf:
        cmd_swf(args)


def build_parser() -> argparse.ArgumentParser:
    common = argparse.ArgumentParser(add_help=False)
    common.add_argument("--full", action="store_true", help="额外下载 asset_apk 大资源（约 1GB+）")
    common.add_argument("--skip-enc", action="store_true", help="跳过 enc 贴图解密")
    common.add_argument("--include-other", action="store_true", help="立绘同时导出怪物/机甲/黑影/NPC")
    parser = argparse.ArgumentParser(description="机动战队大作战资源提取", parents=[common])
    sub = parser.add_subparsers(dest="cmd")
    sub.add_parser("apk", help="只从 APK 提取 assets", parents=[common])
    sub.add_parser("hotupdate", help="只下载/更新热更", parents=[common])
    sub.add_parser("enc", help="只解密 enc/cet", parents=[common])
    sub.add_parser("masterdata", help="只提取 MasterData", parents=[common])
    sub.add_parser("painting", help="导出角色立绘到 Painting/", parents=[common])
    sub.add_parser("swf", help="只导出 SWF", parents=[common])
    sub.add_parser("all", help="完整流程（默认）", parents=[common])
    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    print(f"[jdzd] ROOT={ROOT}")
    print(f"[jdzd] Assets={resolve_assets()}")
    print(f"[jdzd] MasterData={MASTER_DIR}")
    print(f"[jdzd] Painting={PAINTING_DIR}")
    print(f"[jdzd] SWF={SWF_DIR}")
    cmd = args.cmd or "all"
    handlers = {
        "apk": cmd_apk,
        "hotupdate": cmd_hotupdate,
        "enc": cmd_enc,
        "masterdata": cmd_masterdata,
        "painting": cmd_painting,
        "swf": cmd_swf,
        "all": cmd_all,
    }
    handlers[cmd](args)
    return 0


if __name__ == "__main__":
    sys.exit(main())
