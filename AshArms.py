from __future__ import annotations

import argparse
import base64
import gzip
import hashlib
import json
import random
import re
import shutil
import sys
import threading
import zipfile
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

import requests
from Crypto.Cipher import DES
from Crypto.Util.Padding import pad, unpad
from rich.console import Console
from rich.progress import (
    BarColumn,
    Progress,
    TextColumn,
    TimeRemainingColumn,
)

GAME_TITLE = "灰烬战线"
SCRIPT_DIR = Path(__file__).resolve().parent
ASSETS_DIR = SCRIPT_DIR / "Assets"
MASTER_DIR = SCRIPT_DIR / "MasterData"
PAINTING_DIR = SCRIPT_DIR / "Painting"
MANIFEST_PATH = ASSETS_DIR / ".manifest.json"

LOGIN_URL = "http://cn-prod-bili-gl.asharms.com:7055/AsharmsLogin/getRouteVersion"
CLIENT_VERSION = "1.0.26"
CHANNEL_ID = "999"
PLATFORM = "android"
DEFAULT_JOBS = 8
USER_AGENT = "UnityPlayer/2019.4.40f1 (UnityWebRequest/1.0)"
NET_KEY = b"HgKeAEzJ"
NET_IV = b"Areyoumy"
# InstDataCommand
KNOWN_TABLES = frozenset(
    {
        "CharacterSet",
        "ArmsSet",
        "UpgradeSet",
        "ImprovementSet",
        "SkillSet",
        "TargetJson",
        "ArmsSupportJson",
        "ArmsInheritJson",
        "ItemSet",
        "CampaignSet",
        "CombateventCountSet",
        "CombateventMainCountSet",
        "AcademySet",
        "EnvironmentSet",
        "EnemyDataSet",
        "SearchSet",
        "QuestsSet",
        "CharPoolSet",
        "ItemPoolSet",
        "BuffSet",
        "SignedSet",
        "CharLevelSet",
        "ArmsDataDetail",
        "AVGTrigger",
        "CVDetailSet",
        "CVDataSet",
        "CVDataSet_Skin",
        "EventDetail_Day",
        "EventDetail_Main",
        "EventDetail_Random",
        "EventDetail_Resource",
        "EventTypeDetail",
        "JobSet",
        "ActorPoseDataSet",
        "ActivitySet",
        "MyroomDiarySet",
        "TopBarConfiguration",
        "ThemePack",
        "StoryContentSet",
        "EventDetail_Episode",
        "TrainExpeditionSet",
        "RoguelikeSet",
        "RogueZoneData",
        "MainActivitySet",
        "GameConfigSet",
        "BuildSet",
        "CampaignNpclistSet",
        "BattleNpcSet",
        "FavoriteSet",
        "CampaignEventRewardMultipleSet",
        "ItemCraftSet",
        "HeadJson",
        "SkillTag",
        "FixedTimeSet",
        "BossRushSet",
        "BossRushConfigSet",
        "CharMarrySet",
        "SpySet",
        "StoryCollectionConfigSet",
        "StoryCollectionSet",
        "CampaignSystemSet",
        "CampaignSystemConfigSet",
        "MoblistTriggerSet",
        "CampaignSystemFileSet",
        "CampaignSystemExchangeOfficeSet",
        "PlaceConfigJson",
        "PlaceJson",
        "FurnitureInfoSet",
        "RoomInfoSet",
        "RoomStringSet",
        "StudioJson",
        "votegroup",
        "AVG",
        "SYSAVG",
        "STAVG",
        "FAAVG",
        "PARTAVG",
        "BLOCKDATA",
        "ChallengeJson",
        "AdData",
        "BossRushWordSet",
    }
)

HEX32 = re.compile(r"^[0-9A-Fa-f]{32}$")
console = Console()


def find_apk(path: str | None) -> Path | None:
    if path:
        apk = Path(path)
        if not apk.is_file():
            raise FileNotFoundError(f"找不到 APK: {apk}")
        return apk
    found = sorted(SCRIPT_DIR.glob("*.apk"), key=lambda p: p.stat().st_mtime, reverse=True)
    return found[0] if found else None


def split_hashed_name(filename: str) -> tuple[str, str | None]:
    if "." in filename:
        stem, ext = filename.rsplit(".", 1)
        if stem and HEX32.match(ext):
            return stem, ext.upper()
    return filename, None


def file_md5(path: Path) -> str:
    h = hashlib.md5()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest().upper()


def des_crypt(data: bytes, key: bytes, iv: bytes, decrypt: bool) -> bytes:
    cipher = DES.new(key, DES.MODE_CBC, iv)
    if decrypt:
        return unpad(cipher.decrypt(data), 8)
    return cipher.encrypt(pad(data, 8))


def fetch_route(login_url: str, version: str, channel: str, timeout: int) -> dict:
    plain = (
        f"version={version}&channelid={channel}&session=UNLOGIN"
        f"&subkey={random.randint(10000, 99999)}&uid=-1"
    )
    data = des_crypt(plain.encode(), NET_KEY, NET_IV, decrypt=False).hex().upper()
    resp = requests.post(
        login_url,
        data={"data": data},
        headers={"User-Agent": USER_AGENT},
        timeout=timeout,
    )
    resp.raise_for_status()
    info = resp.json()
    if str(info.get("code")) != "1" or not info.get("resourceurl") or not info.get("MD5"):
        raise RuntimeError(f"getRouteVersion 返回异常: {info}")
    return info


def parse_download_list(text: str) -> tuple[dict | None, list[dict]]:
    """Neko_ResUpdater.ReadResInfoStr：按 # 分段，再按逗号。"""
    text = text.replace(" ", "").replace("\r", "").replace("\n", "")
    version = None
    items = []
    for part in text.split("#"):
        if not part:
            continue
        fields = part.split(",")
        if len(fields) < 4:
            continue
        name, url, md5, extra = fields[0], fields[1], fields[2], fields[3]
        if name == "Version":
            bits = extra.split("|")
            version = {
                "url": url,
                "app": bits[0] if bits else "",
                "res": bits[1] if len(bits) > 1 else "",
            }
            continue
        try:
            size = int(extra)
        except ValueError:
            size = 0
        items.append({"name": name, "url": url, "md5": md5.upper(), "size": size})
    return version, items


def join_url(base: str, *parts: str) -> str:
    url = base.rstrip("/")
    for part in parts:
        url += "/" + part.strip("/")
    return url


def download_text(url: str, timeout: int) -> str:
    resp = requests.get(url, headers={"User-Agent": USER_AGENT}, timeout=timeout)
    resp.raise_for_status()
    resp.encoding = "utf-8"
    return resp.text


def fetch_remote(login_url: str, version: str, channel: str, timeout: int) -> tuple[dict, dict | None, list[dict]]:
    route = fetch_route(login_url, version, channel, timeout)
    bases = [u for u in route["resourceurl"].split("|") if u]
    last_err = None
    for base in bases:
        url = join_url(base, PLATFORM, "DownLoadList.txt") + "." + route["MD5"]
        try:
            text = download_text(url, timeout)
            ver, items = parse_download_list(text)
            if items:
                route["cdn"] = base
                route["list_url"] = url
                return route, ver, items
        except Exception as exc:  # noqa: BLE001
            last_err = exc
    raise RuntimeError(f"下载 DownLoadList 失败: {last_err}")


def index_apk(apk: Path) -> dict[str, dict]:
    out = {}
    with zipfile.ZipFile(apk) as zf:
        for info in zf.infolist():
            if not info.filename.startswith("assets/") or info.filename.startswith("assets/bin/"):
                continue
            if info.is_dir():
                continue
            filename = info.filename.split("/", 1)[1]
            if "/" in filename:
                continue
            name, md5 = split_hashed_name(filename)
            prev = out.get(name)
            if prev and prev["md5"] and (not md5 or prev["size"] >= info.file_size):
                continue
            out[name] = {"member": info.filename, "md5": md5, "size": info.file_size}
    return out


def apk_h4s_names(apk: Path, index: dict[str, dict]) -> set[str]:
    names = set()
    with zipfile.ZipFile(apk) as zf:
        for name, meta in index.items():
            with zf.open(meta["member"]) as f:
                if f.read(4) == b"H4sI":
                    names.add(name)
    return names


def is_dolls_bundle(name: str) -> bool:
    """dolls2006 这种包里有立绘。cv_dolls*.acb 是语音。"""
    return name.startswith("dolls") and "." not in name


def is_painting_name(name: str) -> bool:
    return split_painting_stem(name) is not None


_PAINT_STEM = re.compile(r"^(ARM\d+)_(battle|normal)$", re.IGNORECASE)
_FS_NAME = str.maketrans(
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
        "\u00a0": " ",
    }
)
_POSE_NOTE = {"battle": "战斗", "normal": "通常"}


def _clean_name(text: str) -> str:
    out = (text or "").translate(_FS_NAME).strip()
    return out or "未知"


def split_painting_stem(name: str) -> tuple[str, str] | None:
    match = _PAINT_STEM.match(name or "")
    if not match:
        return None
    return match.group(1), _POSE_NOTE[match.group(2).lower()]


def painting_filename(cha: str, skin: str, used: set[str], notes: list[str]) -> str:
    """游戏名_角色名_皮肤名[_备注].png，重名再追加序号。"""
    parts = [GAME_TITLE, _clean_name(cha), _clean_name(skin)]
    for note in notes:
        cleaned = _clean_name(note)
        if cleaned != "未知":
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


def load_painting_index(root: Path) -> dict:
    """ItemSet.itemskins 是皮肤名，ArmsSet/CharacterSet 补角色名。"""
    item_path = root / "ItemSet.json"
    if not item_path.is_file():
        raise RuntimeError(f"缺 {item_path}，先跑 masterdata")
    skins = json.loads(item_path.read_text(encoding="utf-8"))["itemskins"]
    arms = {}
    arms_path = root / "ArmsSet.json"
    if arms_path.is_file():
        arms = {row["armsid"]: row for row in json.loads(arms_path.read_text(encoding="utf-8")) if row.get("armsid")}
    chars = {}
    char_path = root / "CharacterSet.json"
    if char_path.is_file():
        chars = {row["charid"]: row for row in json.loads(char_path.read_text(encoding="utf-8")) if row.get("charid")}
    return {
        "skins": {row["itemid"]: row for row in skins if row.get("itemid")},
        "arms": arms,
        "chars": chars,
    }


def _char_from_armsids(armsids: str, index: dict) -> str:
    for armsid in (armsids or "").split(","):
        row = index["arms"].get(armsid.strip())
        if not row:
            continue
        char = index["chars"].get(row.get("charid") or "")
        name = (char or {}).get("charName") or row.get("armsName") or ""
        if name.strip():
            return name
    return ""


def resolve_painting_name(tex_name: str, index: dict) -> tuple[str, str, list[str], bool]:
    parsed = split_painting_stem(tex_name)
    if not parsed:
        return "未知", tex_name, [], False
    arm_id, pose = parsed
    notes = [pose]
    row = index["skins"].get(arm_id)
    if not row:
        return _char_from_armsids(arm_id, index) or "未知", arm_id, notes, False
    skin = (row.get("name") or "").strip() or arm_id
    desc = (row.get("description") or "").strip()
    if "·" in desc:
        cha = desc.split("·", 1)[0].strip()
    else:
        cha = _char_from_armsids(row.get("armsids") or "", index) or skin
    return cha, skin, notes, True


def is_table_name(name: str, h4s: set[str]) -> bool:
    # ponytail: 只按表名后缀 + apk 里已确认的 H4sI 下载。
    # 服务器上新增、且名字不像 Set/Json、apk 里也没有的表，要等 assets 全量后再解码。
    return name in KNOWN_TABLES or name in h4s or name.endswith("Set") or name.endswith("Json")


def load_manifest() -> dict:
    if not MANIFEST_PATH.is_file():
        return {}
    return json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))


def save_manifest(rows: dict) -> None:
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    MANIFEST_PATH.write_text(json.dumps(rows, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def copy_apk_member(apk: Path, member: str, dest: Path) -> None:
    dest.parent.mkdir(parents=True, exist_ok=True)
    tmp = dest.with_name(dest.name + ".part")
    with zipfile.ZipFile(apk) as zf, zf.open(member) as src, tmp.open("wb") as out:
        shutil.copyfileobj(src, out, 1 << 20)
    tmp.replace(dest)


def download_to(url: str, dest: Path, timeout: int, retries: int) -> None:
    dest.parent.mkdir(parents=True, exist_ok=True)
    tmp = dest.with_name(dest.name + ".part")
    err = None
    for _ in range(retries):
        try:
            with requests.get(url, headers={"User-Agent": USER_AGENT}, timeout=timeout, stream=True) as resp:
                resp.raise_for_status()
                with tmp.open("wb") as out:
                    for chunk in resp.iter_content(1 << 20):
                        if chunk:
                            out.write(chunk)
            tmp.replace(dest)
            return
        except Exception as exc:  # noqa: BLE001
            err = exc
            tmp.unlink(missing_ok=True)
    raise RuntimeError(f"{url}: {err}")


def place_item(
    item: dict,
    apk: Path | None,
    apk_index: dict[str, dict],
    cdn: str,
    timeout: int,
    retries: int,
    force: bool,
    prev: dict,
) -> tuple[str, dict]:
    dest = ASSETS_DIR / item["name"]
    want = item["md5"]
    if not force and dest.is_file() and prev.get("md5") == want and dest.stat().st_size == prev.get("size"):
        return "skip", prev
    if not force and dest.is_file() and file_md5(dest) == want:
        return "skip", {"md5": want, "size": dest.stat().st_size, "source": prev.get("source", "local")}
    local = apk_index.get(item["name"])
    if apk and local and local.get("md5") == want:
        copy_apk_member(apk, local["member"], dest)
        if file_md5(dest) == want:
            return "apk", {"md5": want, "size": dest.stat().st_size, "source": "apk"}
    if not cdn:
        raise RuntimeError(f"{item['name']} 不在 APK 里")
    url = join_url(cdn, PLATFORM, item["url"]) + "." + want
    download_to(url, dest, timeout, retries)
    got = file_md5(dest)
    if got != want:
        raise RuntimeError(f"{item['name']} MD5 {got} != {want}")
    return "cdn", {"md5": want, "size": dest.stat().st_size, "source": "cdn"}


def cmd_assets(args: argparse.Namespace) -> int:
    apk = find_apk(args.apk)
    if apk:
        console.print(f"[cyan]APK[/cyan] {apk.name}")
    apk_index = index_apk(apk) if apk else {}
    if args.apk_only:
        if not apk:
            raise RuntimeError("apk-only 需要 APK")
        items = [
            {"name": name, "url": name, "md5": meta["md5"] or "", "size": meta["size"]}
            for name, meta in sorted(apk_index.items())
            if meta["md5"]
        ]
        cdn = ""
        ver = None
    else:
        route, ver, items = fetch_remote(args.login, args.version, args.channel, args.timeout)
        cdn = route["cdn"]
        console.print(
            f"[cyan]热更[/cyan] res={ver and ver.get('res')}  文件 {len(items)}  "
            f"CDN {cdn}{PLATFORM}/"
        )
    only = {n for n in args.only.split(",") if n} if args.only else None
    if only:
        items = [it for it in items if it["name"] in only]
    if getattr(args, "dolls_only", False):
        items = [it for it in items if is_dolls_bundle(it["name"])]
    if args.tables_only:
        h4s = apk_h4s_names(apk, apk_index) if apk else set()
        items = [it for it in items if is_table_name(it["name"], h4s)]
        have = {it["name"] for it in items}
        for name, meta in apk_index.items():
            if name in have or (name not in h4s and name not in KNOWN_TABLES):
                continue
            items.append(
                {"name": name, "url": name, "md5": meta["md5"] or "", "size": meta["size"]}
            )
    if args.limit:
        items = items[: args.limit]
    manifest = {} if args.force else load_manifest()
    stats = {"skip": 0, "apk": 0, "cdn": 0, "fail": 0}
    progress = Progress(
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        TextColumn("{task.completed}/{task.total}"),
        TimeRemainingColumn(),
        console=console,
    )
    with progress:
        task = progress.add_task("资产", total=len(items))
        with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as pool:
            futs = {
                pool.submit(
                    place_item,
                    it,
                    apk,
                    apk_index,
                    cdn,
                    args.timeout,
                    args.retries,
                    args.force,
                    manifest.get(it["name"]) or {},
                ): it
                for it in items
            }
            for fut in as_completed(futs):
                it = futs[fut]
                try:
                    kind, row = fut.result()
                    stats[kind] += 1
                    manifest[it["name"]] = row
                except Exception as exc:  # noqa: BLE001
                    stats["fail"] += 1
                    console.print(f"[red]失败[/red] {it['name']}: {exc}")
                progress.advance(task)
    save_manifest(manifest)
    console.print(
        f"[bold green]Assets[/bold green] 跳过 {stats['skip']}  APK {stats['apk']}  "
        f"下载 {stats['cdn']}  失败 {stats['fail']}  -> {ASSETS_DIR}"
    )
    return 1 if stats["fail"] else 0


def decode_table(raw: bytes):
    """FileTool.UnZip：Base64 -> gzip -> 去掉 BOM -> Trim。"""
    if not raw.startswith(b"H4sI"):
        return None
    try:
        text = gzip.decompress(base64.b64decode(raw))
        data = text.decode("utf-8-sig").replace("\ufeff", " ").strip()
        if not data or data[0] not in "{[":
            return None
        # LitJson 允许字符串里出现未转义的控制字符
        return json.loads(data, strict=False)
    except Exception:
        return None


def read_named(name: str, apk: Path | None, apk_index: dict[str, dict]) -> bytes | None:
    path = ASSETS_DIR / name
    if path.is_file():
        return path.read_bytes()
    meta = apk_index.get(name)
    if apk and meta:
        with zipfile.ZipFile(apk) as zf:
            return zf.read(meta["member"])
    return None


def iter_local_files(apk: Path | None, apk_index: dict[str, dict]):
    if ASSETS_DIR.is_dir() and any(p.is_file() and not p.name.startswith(".") for p in ASSETS_DIR.iterdir()):
        for path in sorted(ASSETS_DIR.iterdir()):
            if path.is_file() and not path.name.startswith("."):
                yield path.name, path.read_bytes()
        return
    if not apk:
        return
    with zipfile.ZipFile(apk) as zf:
        for name, meta in sorted(apk_index.items()):
            yield name, zf.read(meta["member"])


def cmd_masterdata(args: argparse.Namespace) -> int:
    apk = find_apk(args.apk)
    apk_index = index_apk(apk) if apk else {}
    if not args.no_download:
        ns = argparse.Namespace(**vars(args))
        ns.tables_only = True
        ns.apk_only = False
        rc = cmd_assets(ns)
        if rc:
            console.print("[yellow]热更有失败，继续转换已有文件[/yellow]")
    out = Path(args.out)
    written = 0
    for name, raw in iter_local_files(apk, apk_index):
        obj = decode_table(raw)
        if obj is None:
            continue
        dest = out / f"{name}.json"
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        written += 1
    console.print(f"[bold green]MasterData[/bold green] {written} 个 JSON -> {out}")
    return 0 if written else 1


def export_dolls_bundle(
    src: Path,
    out: Path,
    force: bool,
    index: dict,
    used: set[str],
    lock: threading.Lock,
) -> tuple[int, int, int]:
    """UnityPy 读 dolls 包。battle/normal 按皮肤表写成 游戏名_角色_皮肤_姿态.png。"""
    import UnityPy

    written = skipped = named = 0
    env = UnityPy.load(str(src))
    seen: set[str] = set()
    for obj in env.objects:
        if obj.type.name != "Texture2D":
            continue
        data = obj.read()
        tex_name = data.m_Name or ""
        if tex_name in seen or split_painting_stem(tex_name) is None:
            continue
        seen.add(tex_name)
        cha, skin, notes, hit = resolve_painting_name(tex_name, index)
        with lock:
            filename = painting_filename(cha, skin, used, notes)
        if hit:
            named += 1
        dest = out / filename
        if dest.is_file() and not force:
            skipped += 1
            continue
        dest.parent.mkdir(parents=True, exist_ok=True)
        data.image.save(dest)
        written += 1
    return written, skipped, named


def local_dolls() -> list[Path]:
    if not ASSETS_DIR.is_dir():
        return []
    return [p for p in sorted(ASSETS_DIR.iterdir()) if p.is_file() and is_dolls_bundle(p.name)]


def cmd_painting(args: argparse.Namespace) -> int:
    out = Path(args.out)
    if not args.no_download:
        ns = argparse.Namespace(**vars(args))
        ns.tables_only = False
        ns.dolls_only = True
        rc = cmd_assets(ns)
        if rc:
            console.print("[yellow]有 dolls 包没拉下来，继续导出已有的[/yellow]")
    sources = local_dolls()
    if not sources:
        apk = find_apk(args.apk)
        index = index_apk(apk) if apk else {}
        names = [name for name in sorted(index) if is_dolls_bundle(name)]
        if args.limit:
            names = names[: args.limit]
        for name in names:
            copy_apk_member(apk, index[name]["member"], ASSETS_DIR / name)
        sources = [ASSETS_DIR / name for name in names]
    elif args.limit:
        sources = sources[: args.limit]
    if not sources:
        console.print("[yellow]没有 dolls 包[/yellow]")
        return 1
    index = load_painting_index(MASTER_DIR)
    used: set[str] = set()
    lock = threading.Lock()
    stats = {"ok": 0, "skip": 0, "fail": 0, "png": 0, "named": 0}
    progress = Progress(
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        TextColumn("{task.completed}/{task.total}"),
        TimeRemainingColumn(),
        console=console,
    )

    def one(path: Path) -> tuple[str, int, int, int, str | None]:
        try:
            written, skipped, named = export_dolls_bundle(path, out, args.force, index, used, lock)
            return path.name, written, skipped, named, None
        except Exception as exc:  # noqa: BLE001
            return path.name, 0, 0, 0, str(exc)

    with progress:
        task = progress.add_task("立绘", total=len(sources))
        with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as pool:
            futs = [pool.submit(one, path) for path in sources]
            for fut in as_completed(futs):
                name, written, skipped, named, err = fut.result()
                if err:
                    stats["fail"] += 1
                    console.print(f"[red]立绘失败[/red] {name}: {err}")
                else:
                    stats["ok"] += 1
                    stats["png"] += written
                    stats["skip"] += skipped
                    stats["named"] += named
                progress.advance(task)
    tex_total = stats["png"] + stats["skip"]
    console.print(
        f"[cyan]立绘名称[/cyan] itemskins 命中 {stats['named']}/{tex_total}  "
        f"皮肤 {len(index['skins'])}  → {out}"
    )
    console.print(
        f"[bold green]立绘[/bold green] 包 {stats['ok']}  写出 {stats['png']}  "
        f"跳过 {stats['skip']}  失败 {stats['fail']}"
    )
    return 1 if stats["fail"] and not stats["png"] else 0


def cmd_update(args: argparse.Namespace) -> int:
    rc = cmd_assets(args)
    rc2 = cmd_masterdata(argparse.Namespace(**{**vars(args), "no_download": True}))
    return rc or rc2


def cmd_status(args: argparse.Namespace) -> int:
    apk = find_apk(args.apk)
    console.print(f"APK: {apk if apk else '(无)'}")
    if ASSETS_DIR.is_dir():
        files = [p for p in ASSETS_DIR.rglob("*") if p.is_file() and not p.name.startswith(".")]
        console.print(f"Assets: {len(files)} 文件")
    else:
        console.print("Assets: (无)")
    if MASTER_DIR.is_dir():
        files = [p for p in MASTER_DIR.rglob("*") if p.is_file()]
        console.print(f"MasterData: {len(files)} 文件")
    else:
        console.print("MasterData: (无)")
    if PAINTING_DIR.is_dir():
        files = [p for p in PAINTING_DIR.glob("*.png")]
        console.print(f"Painting: {len(files)} 张")
    else:
        console.print("Painting: (无)")
    return 0


def build_parser() -> argparse.ArgumentParser:
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--apk", default=None, help="APK 路径，默认脚本目录下最新的 .apk")
    shared.add_argument("--login", default=LOGIN_URL, help="getRouteVersion 地址")
    shared.add_argument("--version", default=CLIENT_VERSION, help="协议 version，抓包为 1.0.26")
    shared.add_argument("--channel", default=CHANNEL_ID, help="channelid，bilibili 抓包为 999")
    shared.add_argument("--jobs", type=int, default=DEFAULT_JOBS)
    shared.add_argument("--timeout", type=int, default=60)
    shared.add_argument("--retries", type=int, default=4)
    shared.add_argument("--force", action="store_true", help="忽略本地 MD5 重新拉取")
    shared.add_argument("--limit", type=int, default=0, help="只处理前 N 个文件")
    shared.add_argument("--only", default="", help="只处理这些逻辑名，逗号分隔")

    parser = argparse.ArgumentParser(
        prog="AshArms.py",
        description=f"{GAME_TITLE}：APK + 热更还原到 Assets，数据表导出到 MasterData",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "示例:\n"
            "  python AshArms.py assets\n"
            "  python AshArms.py masterdata\n"
            "  python AshArms.py update\n"
            "  python AshArms.py painting\n"
            "  python AshArms.py status\n"
        ),
    )
    sub = parser.add_subparsers(dest="cmd", required=True)

    assets = sub.add_parser("assets", parents=[shared], help="APK 与热更叠到 Assets/（逻辑文件名）")
    assets.add_argument("--apk-only", action="store_true", help="只解 APK，不拉热更")
    assets.add_argument("--tables-only", action="store_true", help="只拉 JSON 数据表")

    data = sub.add_parser("masterdata", aliases=["data"], parents=[shared], help="JSON 数据表 -> MasterData")
    data.add_argument("--out", default=str(MASTER_DIR))
    data.add_argument("--no-download", action="store_true", help="不拉热更，只转本地 / APK")
    data.set_defaults(apk_only=False, tables_only=True)

    update = sub.add_parser("update", parents=[shared], help="assets + masterdata")
    update.add_argument("--out", default=str(MASTER_DIR))
    update.add_argument("--apk-only", action="store_true")
    update.add_argument("--tables-only", action="store_true")

    painting = sub.add_parser("painting", parents=[shared], help="dolls 包里的 battle/normal 立绘 -> Painting/")
    painting.add_argument("--out", default=str(PAINTING_DIR))
    painting.add_argument("--apk-only", action="store_true", help="只从 APK 取 dolls 包")
    painting.add_argument("--no-download", action="store_true", help="不拉热更，只导出本地 / APK")
    painting.set_defaults(tables_only=False, dolls_only=True)

    sub.add_parser("status", parents=[shared], help="看 APK / Assets / MasterData")
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    handlers = {
        "assets": cmd_assets,
        "masterdata": cmd_masterdata,
        "data": cmd_masterdata,
        "update": cmd_update,
        "painting": cmd_painting,
        "status": cmd_status,
    }
    return handlers[args.cmd](args)


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except KeyboardInterrupt:
        console.print("\n[yellow]已中断[/yellow]")
        raise SystemExit(130)
    except (RuntimeError, FileNotFoundError) as exc:
        console.print(f"[red]{exc}[/red]")
        raise SystemExit(1)
