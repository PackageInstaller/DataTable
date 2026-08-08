import os
import sys
import json
import shutil
import re

B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
_B64D = [-1] * 128
for i, c in enumerate(B64):
    _B64D[ord(c)] = i

HEX = "0123456789abcdef"
_DASH = {8, 13, 18, 23}  # 36字符UUID中连字符位置
_OUT = [i for i in range(36) if i not in _DASH]  # 32个有效位置


def decode_uuid(s: str) -> str:
    main = s.split("@")[0]
    if len(main) != 22:
        return s
    r = [""] * 36
    r[0], r[1] = main[0], main[1]
    idx = 2
    for i in range(2, 22, 2):
        a = _B64D[ord(main[i])]
        b = _B64D[ord(main[i + 1])]
        r[_OUT[idx]] = HEX[a >> 2]
        r[_OUT[idx + 1]] = HEX[((3 & a) << 2) | (b >> 4)]
        r[_OUT[idx + 2]] = HEX[15 & b]
        idx += 3
    for p in _DASH:
        r[p] = "-"
    return "".join(r)


def encode_uuid(s: str) -> str:
    main = s.split("@")[0]
    hx = main.replace("-", "")
    if len(hx) != 32:
        return s
    r = hx[0:2]
    for i in range(2, 32, 3):
        v = int(hx[i : i + 3], 16)
        r += B64[v >> 6] + B64[v & 0x3F]
    return r


def load_config(bundle_dir: str) -> dict:
    path = os.path.join(bundle_dir, "cc.config.json")
    if not os.path.isfile(path):
        sys.exit(f"找不到 {path}")

    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)

    # paths: {"idx": ["url", type_idx, sub_idx], ...}
    paths = {}
    for k, v in data.get("paths", {}).items():
        idx = int(k)
        paths[idx] = {
            "url": v[0],
            "type_idx": v[1] if len(v) > 1 else 0,
            "sub_idx": v[2] if len(v) > 2 else 0,
        }

    return {
        "name": data.get("name", "unknown"),
        "import_base": data.get("importBase", "import"),
        "native_base": data.get("nativeBase", "native"),
        "uuids": data.get("uuids", []),
        "paths": paths,
        "packs": data.get("packs", {}),
        "types": data.get("types", []),
    }


def build_mapping(cfg: dict) -> dict:
    mp = {}
    uuids = cfg["uuids"]
    paths = cfg["paths"]
    packs = cfg["packs"]
    types = cfg["types"]

    for idx, info in paths.items():
        if idx >= len(uuids):
            continue
        raw = uuids[idx]
        main = raw.split("@")[0]
        if len(main) == 36 and "-" in main:
            main = encode_uuid(main)
        mp[main] = {"url": info["url"], "is_pack": False}

    for pack_short, indices in packs.items():
        main = pack_short.split("@")[0]
        contained = []
        for idx in indices:
            if idx < len(uuids):
                raw = uuids[idx]
                m = raw.split("@")[0]
                if len(m) == 36 and "-" in m:
                    m = encode_uuid(m)
                contained.append(m)
        mp[main] = {"url": f"_pack/{main}", "is_pack": True, "contains": contained}

        for sub in contained:
            if sub not in mp:
                mp[sub] = {"url": f"_pack/{main}/{sub}", "is_pack": True}

    return mp


def clean_url(url: str) -> str:
    url = re.sub(r"^db://?", "", url)
    if url.startswith("assets/"):
        url = url[7:]
    return url


def find_uuid(filename_no_ext: str, cfg: dict, mapping: dict) -> str | None:
    name = filename_no_ext.split("@")[0]

    # 36位标准UUID → 压缩
    if len(name) == 36 and name[8] == "-":
        c = encode_uuid(name)
        return c if c in mapping else c

    # 22位压缩UUID
    if len(name) == 22:
        return name if name in mapping else name

    # 短UUID → packs / 前缀匹配
    if name in cfg["packs"]:
        return name
    for u in cfg["uuids"]:
        m = u.split("@")[0]
        if m.startswith(name):
            return m
    return None


def restore_bundle(bundle_dir: str):
    cfg = load_config(bundle_dir)
    mapping = build_mapping(cfg)

    import_dir = os.path.join(bundle_dir, cfg["import_base"])
    native_dir = os.path.join(bundle_dir, cfg["native_base"])

    parent = os.path.dirname(os.path.abspath(bundle_dir))
    out_dir = os.path.join(parent, f"{cfg['name']}_restored")

    print(f"Bundle: {cfg['name']}")
    print(f"  输出: {out_dir}")
    print(f"  映射: {len(mapping)} 条")

    copied = 0
    skipped = 0

    for src_dir, is_native in [(import_dir, False), (native_dir, True)]:
        if not os.path.isdir(src_dir):
            continue

        kind = "native" if is_native else "import"
        for root, dirs, files in os.walk(src_dir):
            for fname in files:
                fpath = os.path.join(root, fname)
                rel = os.path.relpath(fpath, src_dir)
                name_no_ext = os.path.splitext(fname)[0]
                ext = os.path.splitext(fname)[1]

                key = find_uuid(name_no_ext, cfg, mapping)
                if key is None:
                    skipped += 1
                    continue
                if key in mapping:
                    url = mapping[key]["url"]
                else:
                    url = f"_unknown/{name_no_ext}"

                dest = clean_url(url)
                if is_native and ext and not dest.endswith(ext):
                    dest += ext
                elif ext:
                    dest += ext

                dest = dest.replace("\\", "/")
                full_dest = os.path.join(out_dir, dest)

                os.makedirs(os.path.dirname(full_dest), exist_ok=True)
                shutil.copy2(fpath, full_dest)
                copied += 1

    print(f"  已还原: {copied}  跳过: {skipped}")
    return out_dir


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)

    bundle_dir = sys.argv[1]
    if not os.path.isdir(bundle_dir):
        sys.exit(f"目录不存在: {bundle_dir}")

    restore_bundle(bundle_dir)


if __name__ == "__main__":
    main()
