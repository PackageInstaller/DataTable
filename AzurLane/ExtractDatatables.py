import argparse
import json
import os
import sys

import UnityPy

from Scipio import scipio_www


def parse_proto(data):
    pos = [5]

    def rd_uleb():
        r = 0
        sh = 0
        while True:
            c = data[pos[0]]
            pos[0] += 1
            r |= (c & 0x7F) << sh
            if c < 0x80:
                return r
            sh += 7

    def rd_uleb33():
        b = data[pos[0]]
        pos[0] += 1
        v = b >> 1
        if v >= 0x40:
            v &= 0x3F
            sh = -1
            while True:
                c = data[pos[0]]
                pos[0] += 1
                sh += 7
                v |= (c & 0x7F) << sh
                if c < 0x80:
                    return v
        return v

    def ktabk():
        k = rd_uleb()
        if k >= 5:
            raw = data[pos[0] : pos[0] + k - 5]
            pos[0] += k - 5
            return (
                "str",
                bytes((~b ^ i) & 0xFF for i, b in enumerate(raw)).decode(
                    "utf-8", "replace"
                ),
            )
        if k == 3:
            v = rd_uleb()
            if v >= 0x80000000:
                v -= 0x100000000
            return ("int", v)
        if k == 4:
            lo = rd_uleb()
            hi = rd_uleb()
            return ("num", lo, hi)
        return ("pri", k)

    ln = rd_uleb()
    f0, f1, f2, f3 = data[pos[0] : pos[0] + 4]
    pos[0] += 4
    nkn = rd_uleb()
    nkgc = rd_uleb()
    nbc = rd_uleb() + 1
    pos[0] += (nbc - 1) * 4  # instructions
    # sizeuv = f3 ^ f2 ^ flags, flags = f1 ^ f0
    nuv = f3 ^ f2 ^ (f1 ^ f0)
    pos[0] += nuv * 2

    kn = []
    for _ in range(nkn):
        b = data[pos[0]]
        pos[0] += 1
        v = b >> 1
        if v >= 0x40:
            v &= 0x3F
            sh = -1
            while True:
                c = data[pos[0]]
                pos[0] += 1
                sh += 7
                v |= (c & 0x7F) << sh
                if c < 0x80:
                    break
        if b & 1:
            hi = 0
            sh = 0
            while True:
                c = data[pos[0]]
                pos[0] += 1
                hi |= (c & 0x7F) << sh
                if c < 0x80:
                    break
                sh += 7
            kn.append({"num": [v, hi]})
        else:
            kn.append({"int": v})

    kgc = []
    for _ in range(nkgc):
        t = rd_uleb()
        if t == 0:
            kgc.append({"child": True})
            continue
        if t == 1:
            nh = rd_uleb()
            na = rd_uleb()
            h = []
            for _ in range(nh):
                h.append([ktabk(), ktabk()])
            a = []
            for _ in range(na):
                a.append(ktabk())
            kgc.append({"tab": {"hash": h, "array": a}})
            continue
        if t >= 5:
            raw = data[pos[0] : pos[0] + t - 5]
            pos[0] += t - 5
            kgc.append(
                {
                    "str": bytes((~b ^ i) & 0xFF for i, b in enumerate(raw)).decode(
                        "utf-8", "replace"
                    )
                }
            )
            continue
        pos[0] += (4 if t == 4 else 2) * 5
        kgc.append({"cdata": t})
    return kn, kgc


def process_file(path, out_dir):
    raw = open(path, "rb").read()
    dec = scipio_www(raw)
    tmp = path + ".dec_tmp"
    open(tmp, "wb").write(dec)
    env = UnityPy.load(tmp)
    os.unlink(tmp)

    n = 0
    for obj in env.objects:
        if obj.type.name != "TextAsset":
            continue
        d = obj.read()
        script = d.m_Script
        if isinstance(script, str):
            script = script.encode("utf-8", "surrogateescape")
        if script[:3] != b"\x1bLJ":
            continue
        try:
            kn, kgc = parse_proto(script)
        except Exception as e:
            print(f"  SKIP {d.m_Name}: {e}")
            continue
        container = getattr(obj, "container", None) or ""
        rel = container.replace("\\", "/").strip("/")
        if not rel:
            rel = d.m_Name.replace("/", "_").replace("\\", "_") + ".json"
        else:
            if rel.endswith(".bytes"):
                rel = rel[: -len(".bytes")]
            if rel.endswith(".lua"):
                rel = rel[: -len(".lua")]
            rel += ".json"
        out = {
            "name": d.m_Name,
            "numbers": kn,
            "strings": [x.get("str") for x in kgc if "str" in x],
            "tables": [x["tab"] for x in kgc if "tab" in x],
        }
        dst = os.path.join(out_dir, rel)
        os.makedirs(os.path.dirname(dst) or ".", exist_ok=True)
        with open(dst, "w", encoding="utf-8") as f:
            json.dump(out, f, ensure_ascii=False, indent=1)
        n += 1
    print(f"{path}: exported {n} scripts")
    return n


def main():
    ap = argparse.ArgumentParser(description="碧蓝航线 Lua 数据表导出")
    ap.add_argument("input", help="scripts32.ys / scripts64.ys")
    ap.add_argument("-o", "--out", default="datatables", help="输出目录")
    args = ap.parse_args()
    os.makedirs(args.out, exist_ok=True)
    process_file(args.input, args.out)
    return 0


if __name__ == "__main__":
    sys.exit(main())
