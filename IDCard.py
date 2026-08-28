"""
IDA IDCardInfoDecryptTool：
    DEFINE_SECRET_KEY1   = "_kilqwrtyu"
    DEFINE_SECRET_KEY2   = "qwr+%mnxzv"
    DEFINE_SECRET_DRIFT  = 4
    DefineDecryptCardName @ 0x02D71DB4
    DefineDecryptIdCard   @ 0x02D7267C
"""

from __future__ import annotations

import re

KEY1 = "_kilqwrtyu"
KEY2 = "qwr+%mnxzv"
DRIFT = 4


def _swap_case(ch: str) -> str:
    return ch.upper() if ch.islower() else ch.lower()


def _undrift(ch: str, key: str) -> str:
    i = key.find(ch) - DRIFT
    if i < 0:
        i += 10
    return str(i)


def decrypt_card_name(encrypt_text: str) -> str:
    if not encrypt_text:
        return ""
    n = len(encrypt_text)
    mapped: list[str] = []
    half = n // 2
    for i, ch in enumerate(encrypt_text):
        if ch.isdigit():
            key = KEY1 if i < half else KEY2
            mapped.append(key[ord(ch) - 48])
        else:
            mapped.append(ch)
    blob = "".join(mapped)
    q = n // 4
    p0, p1, p2, p3 = blob[:q], blob[q : 2 * q], blob[2 * q : 3 * q], blob[3 * q :]
    inter: list[str] = []
    i0 = i1 = i2 = i3 = 0
    for j in range(n):
        which = j & 3
        if which == 0:
            inter.append(p0[i0])
            i0 += 1
        elif which == 1:
            inter.append(p2[i2])
            i2 += 1
        elif which == 2:
            inter.append(p1[i1])
            i1 += 1
        else:
            inter.append(p3[i3])
            i3 += 1
    s = "".join(inter)
    first = s[: n // 2]
    second = s[n // 2 :]
    out1: list[str] = []
    for ch in first:
        out1.append(_undrift(ch, KEY2) if ch in KEY2 else _swap_case(ch))
    out2: list[str] = []
    for ch in second:
        out2.append(_undrift(ch, KEY1) if ch in KEY1 else _swap_case(ch))
    hex4 = "".join(out2) + "".join(out1)
    chunks = [hex4[i : i + 4] for i in range(0, q * 4, 4)]
    escaped = "".join("\\u" + c for c in chunks)
    return re.sub(
        r"\\u([0-9a-fA-F]{4})",
        lambda m: chr(int(m.group(1), 16)),
        escaped,
    )


def decrypt_id_card(encrypt_text: str) -> str:
    if not encrypt_text or len(encrypt_text) < 15:
        return encrypt_text
    a = encrypt_text[0:4]
    b = encrypt_text[4:8]
    c = encrypt_text[8:12]
    d = encrypt_text[12:15]
    rest = encrypt_text[15:]
    buf: list[str] = []
    ia = ib = ic = 0
    for t in range(11):
        slot = ((t - 3 * (t // 3)) + 1) & 3
        if slot == 1:
            buf.append(a[ia])
            ia += 1
        elif slot == 2:
            buf.append(b[ib])
            ib += 1
        else:
            buf.append(c[ic])
            ic += 1
    mid = rest + "".join(buf) + d
    left: list[str] = []
    for i in range(9):
        ch = mid[i]
        if (i & 1) == 0:
            left.append(_swap_case(ch))
        else:
            left.append(KEY1[ord(ch) - 48] if ch.isdigit() else ch)
    right: list[str] = []
    for i in range(9, 18):
        ch = mid[i]
        if (i & 1) == 0:
            right.append(KEY2[ord(ch) - 48] if ch.isdigit() else ch)
        else:
            right.append(_swap_case(ch))
    s = "".join(left) + "".join(right)
    head, body, tail = s[0], s[1:10], s[10:]
    digits: list[str] = []
    ibody = itail = 0
    for t in range(17):
        if (t & 1) == 0:
            ch = body[ibody]
            ibody += 1
            idx = KEY1.find(ch) - DRIFT
        else:
            ch = tail[itail]
            itail += 1
            idx = KEY2.find(ch) - DRIFT
        if idx < 0:
            idx += 10
        digits.append(str(idx))
    return "".join(digits) + head
