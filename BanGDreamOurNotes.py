from __future__ import annotations

import argparse
import base64
import gzip
import hashlib
import io
import json
import re
import sys
import urllib.error
import urllib.request
from concurrent.futures import ThreadPoolExecutor
from contextlib import redirect_stdout
from pathlib import Path

from Crypto.Cipher import AES

import dec_asset

ROOT = Path(__file__).resolve().parent
DEFAULT_ASSETS = ROOT / "Assets"
DEFAULT_MASTER = ROOT / "MasterData"
DEFAULT_PAINTING = ROOT / "Painting"
GAME_TITLE = "BanGDreamOurNotes"
MASTER_SALT = base64.b64decode("tQsjpf1ijD3DhvdIj4HWsEULjIlnFXT1WjrYFfELjjA=")
MASTER_IV = base64.b64decode("m5TJHiQqVi6X/NUFt1pRKbK4BjKiaQNM+ULscpPUiaE=")
MASTER_KEY = base64.b64decode("BTJ5HFEKCOt+3mtGxrpx6pqio8+2eKWV+J1nyKXkk7Y=")
MASTER_PREFIX = 64
DEFAULT_CDN = "https://l14-prod-hk-patch-sirius.gamerfusiontech.com/prod/hk_27f3c91e8b62d6056c7a19f2e83b6d10"
DEFAULT_GS = (
    "l12-prod-hk-all-gs-sirius.gamerfusiontech.com",
    "l14-prod-hk-all-gs-sirius.gamerfusiontech.com",
)
DEFAULT_USER = "sirius"
DEFAULT_PASS = "pXrQcRvnnwkux6hp89OpgFHytDjm2DTM"
PLATFORM = "Android"
LOCALE = "zh-Hans"
_CHAR_IMAGE_RE = re.compile(r"character-image_assets_character-image-(\d+)")
NB = 8
NK = 8
NR = 14


def _xtime(a: int) -> int:
    return ((a << 1) ^ 0x1B) & 0xFF if a & 0x80 else (a << 1) & 0xFF


def _mul(a: int, b: int) -> int:
    r = 0
    for _ in range(8):
        if b & 1:
            r ^= a
        a = _xtime(a)
        b >>= 1
    return r


def _sbox() -> tuple[bytes, bytes]:
    def inv(a: int) -> int:
        if a == 0:
            return 0
        r = p = a
        e = 253
        while e:
            if e & 1:
                r = _mul(r, p)
            p = _mul(p, p)
            e >>= 1
        return r

    box = bytearray(256)
    for i in range(256):
        x = inv(i)
        y = x
        for _ in range(4):
            x = ((x << 1) | (x >> 7)) & 0xFF
            y ^= x
        box[i] = y ^ 0x63
    inv_box = bytearray(256)
    for i, v in enumerate(box):
        inv_box[v] = i
    return bytes(box), bytes(inv_box)


SBOX, INV_SBOX = _sbox()
RCON = [0]
_rc = 1
for _ in range(16):
    RCON.append(_rc)
    _rc = _xtime(_rc)


def _sub_word(w: int) -> int:
    return (
        (SBOX[(w >> 24) & 0xFF] << 24)
        | (SBOX[(w >> 16) & 0xFF] << 16)
        | (SBOX[(w >> 8) & 0xFF] << 8)
        | SBOX[w & 0xFF]
    )


def _expand(key: bytes) -> list[int]:
    w = [0] * (NB * (NR + 1))
    for i in range(NK):
        w[i] = int.from_bytes(key[4 * i : 4 * i + 4], "big")
    for i in range(NK, NB * (NR + 1)):
        t = w[i - 1]
        if i % NK == 0:
            t = _sub_word(((t << 8) & 0xFFFFFFFF) | (t >> 24)) ^ (RCON[i // NK] << 24)
        elif i % NK == 4:
            t = _sub_word(t)
        w[i] = w[i - NK] ^ t
    return w


def _decrypt_block(block: bytes, w: list[int]) -> bytes:
    state = [[block[c * 4 + r] for c in range(NB)] for r in range(4)]

    def add(rnd: int) -> None:
        for c in range(NB):
            word = w[rnd * NB + c]
            for r in range(4):
                state[r][c] ^= (word >> (24 - 8 * r)) & 0xFF

    def inv_shift() -> None:
        for r, s in enumerate((0, 1, 3, 4)):
            if s:
                state[r] = state[r][-s:] + state[r][:-s]

    def inv_sub() -> None:
        for r in range(4):
            for c in range(NB):
                state[r][c] = INV_SBOX[state[r][c]]

    def inv_mix() -> None:
        for c in range(NB):
            a = [state[r][c] for r in range(4)]
            state[0][c] = _mul(a[0], 0x0E) ^ _mul(a[1], 0x0B) ^ _mul(a[2], 0x0D) ^ _mul(a[3], 0x09)
            state[1][c] = _mul(a[0], 0x09) ^ _mul(a[1], 0x0E) ^ _mul(a[2], 0x0B) ^ _mul(a[3], 0x0D)
            state[2][c] = _mul(a[0], 0x0D) ^ _mul(a[1], 0x09) ^ _mul(a[2], 0x0E) ^ _mul(a[3], 0x0B)
            state[3][c] = _mul(a[0], 0x0B) ^ _mul(a[1], 0x0D) ^ _mul(a[2], 0x09) ^ _mul(a[3], 0x0E)

    add(NR)
    for rnd in range(NR - 1, 0, -1):
        inv_shift()
        inv_sub()
        add(rnd)
        inv_mix()
    inv_shift()
    inv_sub()
    add(0)
    return bytes(state[r][c] for c in range(NB) for r in range(4))


def rijndael_cbc_decrypt(data: bytes, key: bytes, iv: bytes) -> bytes:
    w = _expand(key)
    prev = iv
    out = bytearray()
    for i in range(0, len(data), 32):
        block = data[i : i + 32]
        out += bytes(a ^ b for a, b in zip(_decrypt_block(block, w), prev))
        prev = block
    pad = out[-1]
    if not 1 <= pad <= 32 or out[-pad:] != bytes([pad]) * pad:
        raise ValueError(f"PKCS7 填充无效: {pad}")
    return bytes(out[:-pad])


def decrypt_master(blob: bytes) -> bytes:
    if blob[:32] != MASTER_SALT or blob[32:64] != MASTER_IV:
        raise ValueError("Master 文件头不是内置 salt||iv")
    plain = rijndael_cbc_decrypt(blob[MASTER_PREFIX:], MASTER_KEY, MASTER_IV)
    return gzip.decompress(plain)


def decrypt_bundle_bytes(filename: str, data: bytes) -> bytes:
    if data.startswith(b"UnityFS"):
        return data
    nonce = hashlib.sha256(dec_asset.NONCE_SEED + filename.encode()).digest()[:8]
    cipher = AES.new(dec_asset.KEY, AES.MODE_CTR, nonce=nonce)
    buf = bytearray(data)
    n = min(len(buf), dec_asset.HEADER_SIZE)
    buf[:n] = cipher.decrypt(bytes(buf[:n]))
    return bytes(buf)


def write_bytes(path: Path, data: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(data)


def dump_json(path: Path, obj: object) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def auth_header(user: str, password: str) -> str:
    if not user:
        return ""
    token = base64.b64encode(f"{user}:{password}".encode()).decode()
    return "Basic " + token


def http_get(url: str, user: str = DEFAULT_USER, password: str = DEFAULT_PASS) -> bytes:
    headers = {"User-Agent": "UnityPlayer"}
    header = auth_header(user, password)
    if header:
        headers["Authorization"] = header
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req, timeout=180) as resp:
        return resp.read()


def remote_asset_url(cdn: str, internal_id: str) -> str:
    if "://" in internal_id:
        path = internal_id.split("://", 1)[1].split("/", 1)[1]
        return cdn.rstrip("/") + "/" + path
    name = internal_id
    token = f"/{PLATFORM}/"
    if token in name:
        name = name.split(token, 1)[1]
    return f"{cdn.rstrip('/')}/asset/{PLATFORM}/{name}"


def _proto_strings(blob: bytes) -> dict[int, str]:
    out: dict[int, str] = {}
    i = 0
    n = len(blob)
    while i < n:
        key = blob[i]
        i += 1
        field, wire = key >> 3, key & 7
        if wire != 2:
            raise ValueError(f"proto wire {wire}")
        size = shift = 0
        while True:
            if i >= n:
                raise ValueError("proto truncated")
            b = blob[i]
            i += 1
            size |= (b & 0x7F) << shift
            if not b & 0x80:
                break
            shift += 7
        out[field] = blob[i : i + size].decode()
        i += size
    return out


def _probe_gs_version(host: str) -> tuple[str, str] | None:
    import grpc

    method = "/app.masterdata.MasterdataService/Version"
    creds = grpc.ssl_channel_credentials()
    try:
        with grpc.secure_channel(f"{host}:443", creds) as channel:
            stub = channel.unary_unary(
                method,
                request_serializer=lambda x: x,
                response_deserializer=lambda x: x,
            )
            fields = _proto_strings(stub(b"", timeout=8))
    except Exception:
        return None
    master = fields.get(1) or ""
    asset = fields.get(2) or ""
    if not master or not asset:
        return None
    return master, asset


def discover_versions() -> tuple[str, str]:
    cached = getattr(discover_versions, "_cached", None)
    if cached:
        return cached
    for host in DEFAULT_GS:
        got = _probe_gs_version(host)
        if got:
            discover_versions._cached = got  # type: ignore[attr-defined]
            print(f"数据表 {got[0]}  资产 {got[1]}")
            return got
    raise SystemExit("拿不到版本：MasterdataService/Version 不通")


def discover_asset_version() -> str:
    return discover_versions()[1]


def discover_master_version() -> str:
    return discover_versions()[0]


def cmd_assets(args: argparse.Namespace) -> None:
    out = Path(args.assets_dir)
    got = overlay_remote_assets(out)
    print(f"热更 {got} 个 bundle → {out}")


def overlay_remote_assets(out: Path) -> int:
    version = discover_asset_version()
    catalog_url = f"{DEFAULT_CDN}/asset/{PLATFORM}/catalog_{version}_{LOCALE}.bin"
    print(f"热更 catalog {catalog_url}")
    try:
        blob = http_get(catalog_url)
    except urllib.error.HTTPError as exc:
        raise SystemExit(f"热更 catalog 失败 HTTP {exc.code}") from exc
    write_bytes(out / "aa" / f"catalog_{version}_{LOCALE}.bin", blob)
    bundles = [b for b in catalog_bundles(blob) if "://" in b["internal_id"]]
    print(f"远端 bundle {len(bundles)}")

    def fetch_one(item: dict) -> str:
        filename = Path(item["internal_id"]).name
        dest = out / "aa" / PLATFORM / filename
        size = item.get("size") or 0
        if dest.is_file() and size and dest.stat().st_size == size:
            return "skip"
        url = remote_asset_url(DEFAULT_CDN, item["internal_id"])
        try:
            raw = http_get(url)
        except urllib.error.URLError as exc:
            code = getattr(exc, "code", exc.reason)
            print(f"  跳过 {filename} {code}")
            return "fail"
        if raw.startswith((b"UnityFS", b"@UTF", b"CRID")):
            data = raw
        else:
            data = decrypt_bundle_bytes(filename, raw)
        if filename.endswith(".bundle") and not data.startswith(b"UnityFS"):
            print(f"  解密后不是 UnityFS: {filename}")
            return "fail"
        write_bytes(dest, data)
        return "ok"

    got = 0
    with ThreadPoolExecutor(max_workers=16) as pool:
        for i, status in enumerate(pool.map(fetch_one, bundles), 1):
            if status == "ok":
                got += 1
            if i % 500 == 0 or i == len(bundles):
                print(f"  热更 {i}/{len(bundles)}")
    return got


def catalog_bundles(blob: bytes) -> list[dict]:
    from UnityCatalogReader import UnityCatalogReader

    with redirect_stdout(io.StringIO()):
        reader = UnityCatalogReader(blob)
        assets = reader.get_asset_list()
    bundles = []
    seen = set()
    for asset in assets:
        internal = asset.get("internal_id") or ""
        if not internal.endswith(".bundle") or internal in seen:
            continue
        seen.add(internal)
        bundles.append(
            {
                "internal_id": internal,
                "hash": asset.get("hash") or "",
                "crc": asset.get("crc"),
                "size": asset.get("bundle_size"),
                "primary_key": asset.get("primary_key"),
            }
        )
    return bundles


def cmd_masterdata(args: argparse.Namespace) -> None:
    master = Path(args.master_dir)
    version = discover_master_version()
    manifest = json.loads(http_get(f"{DEFAULT_CDN}/master/{version}/MasterManifest.json"))
    ok = 0
    for entry in manifest["files"]:
        filename = entry["name"]
        raw = fetch_remote_bin(version, filename)
        if not raw:
            print(f"  缺少 {filename}")
            continue
        text = json.loads(decrypt_master(raw))
        dump_json(master / (Path(filename).stem + ".json"), text)
        ok += 1
    print(f"数据表 {ok} → {master}")


def fetch_remote_bin(version: str, filename: str) -> bytes | None:
    url = f"{DEFAULT_CDN}/master/{version}/{filename}"
    try:
        return http_get(url)
    except urllib.error.HTTPError as exc:
        print(f"  {filename} HTTP {exc.code}")
        return None


def cmd_all(args: argparse.Namespace) -> None:
    cmd_assets(args)
    cmd_masterdata(args)
    if not getattr(args, "skip_painting", False):
        cmd_painting(args)


def cmd_status(args: argparse.Namespace) -> None:
    assets = Path(args.assets_dir)
    master = Path(args.master_dir)
    painting = Path(args.painting_dir)
    bundles = list(assets.rglob("*.bundle")) if assets.is_dir() else []
    tables = list(master.glob("*.json")) if master.is_dir() else []
    portraits = list(painting.glob("*.png")) if painting.is_dir() else []
    print(f"Assets {assets}  bundle {len(bundles)}")
    print(f"MasterData {master}  表 {len(tables)}")
    print(f"Painting {painting}  立绘 {len(portraits)}")
    print(f"热更 catalog  {DEFAULT_CDN}/asset/{PLATFORM}/catalog_<版本>_{LOCALE}.bin")
    print(f"热更 bundle   {DEFAULT_CDN}/asset/{PLATFORM}/<文件名>")
    print(f"热更 master   {DEFAULT_CDN}/master/<版本>/MasterManifest.json")


def load_json_table(master: Path, name: str) -> list[dict]:
    path = master / f"{name}.json"
    if not path.is_file():
        return []
    return json.loads(path.read_text(encoding="utf-8")).get("_allData") or []


def text_map(master: Path) -> dict[str, str]:
    out = {}
    for row in load_json_table(master, "MasterText"):
        tid = row.get("_id") or ""
        if tid:
            out[tid] = row.get("_simplifiedChinese") or row.get("_japanese") or tid
    return out


def _safe_fs_name(text: str) -> str:
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
    return out or "未知"


def painting_filename(cha: str, skin: str, used: set[str], notes: list[str] | None = None) -> str:
    parts = [GAME_TITLE, _safe_fs_name(cha), _safe_fs_name(skin)]
    for note in notes or []:
        cleaned = _safe_fs_name(str(note))
        if cleaned and cleaned != "未知":
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


def resolve_character_name(char_id: int, characters: dict[int, dict], texts: dict[str, str]) -> str:
    row = characters.get(char_id)
    if not row:
        return str(char_id)
    tid = row.get("_nameTextID") or ""
    return texts.get(tid) or tid.split("_")[-1] or str(char_id)


def _export_character_texture(bundle: Path, dest: Path) -> str:
    import UnityPy

    env = UnityPy.load(str(bundle))
    textures = []
    for obj in env.objects:
        if getattr(obj.type, "name", None) != "Texture2D":
            continue
        data = obj.read()
        image = data.image
        if image is None:
            continue
        textures.append((str(data.m_Name or ""), image))
    if not textures:
        return "skip"
    by_name = {name.lower(): image for name, image in textures}
    picked = by_name.get("character_casual")
    if picked is None:
        picked = max(textures, key=lambda item: item[1].width * item[1].height)[1]
    dest.parent.mkdir(parents=True, exist_ok=True)
    picked.save(dest, "PNG")
    return "ok"


def cmd_painting(args: argparse.Namespace) -> None:
    assets = Path(args.assets_dir)
    master = Path(args.master_dir)
    out = Path(args.painting_dir)
    out.mkdir(parents=True, exist_ok=True)
    characters = {int(row["_id"]): row for row in load_json_table(master, "MasterCharacter") if "_id" in row}
    texts = text_map(master)
    if not characters:
        raise SystemExit("没有 MasterCharacter.json，先跑 masterdata")
    bundles = sorted(assets.rglob("character-image_assets_character-image-*.bundle"))
    if not bundles:
        raise SystemExit(f"没有 character-image bundle：{assets}")
    used: set[str] = set()
    jobs = []
    for bundle in bundles:
        match = _CHAR_IMAGE_RE.search(bundle.name)
        if not match:
            continue
        char_id = int(match.group(1))
        cha = resolve_character_name(char_id, characters, texts)
        fname = painting_filename(cha, "日常", used)
        jobs.append((bundle, out / fname))
    limit = getattr(args, "limit", 0) or 0
    if limit:
        jobs = jobs[:limit]
    ok = skip = 0
    force = getattr(args, "force", False)
    for bundle, dest in jobs:
        if dest.is_file() and not force:
            skip += 1
            continue
        status = _export_character_texture(bundle, dest)
        if status == "ok":
            ok += 1
        else:
            print(f"  跳过 {bundle.name}")
    print(f"立绘 {ok} 跳过 {skip} → {out}")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="BanG Dream Our Notes 资产还原、数据表与立绘导出")
    shared = argparse.ArgumentParser(add_help=False)
    shared.add_argument("--assets-dir", default=str(DEFAULT_ASSETS), help="解密资产输出目录")
    shared.add_argument("--master-dir", default=str(DEFAULT_MASTER), help="数据表输出目录")
    shared.add_argument("--painting-dir", default=str(DEFAULT_PAINTING), help="立绘输出目录")
    shared.add_argument("--force", action="store_true", help="覆盖已有立绘")
    shared.add_argument("--limit", type=int, default=0, help="立绘只导出前 N 张")
    shared.add_argument("--skip-painting", action="store_true", help="all 时跳过立绘")
    sub = parser.add_subparsers(dest="command", required=True)
    sub.add_parser("assets", parents=[shared], help="热更 bundle → Assets/")
    sub.add_parser("masterdata", parents=[shared], help="Master *.bin 解密解压 → MasterData/*.json")
    sub.add_parser("painting", parents=[shared], help="导出 character-image 立绘到 Painting/")
    sub.add_parser("all", parents=[shared], help="assets + masterdata + painting")
    sub.add_parser("status", parents=[shared], help="本地目录与热更 URL")
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    {
        "assets": cmd_assets,
        "masterdata": cmd_masterdata,
        "painting": cmd_painting,
        "all": cmd_all,
        "status": cmd_status,
    }[args.command](args)
    return 0


if __name__ == "__main__":
    sys.exit(main())
