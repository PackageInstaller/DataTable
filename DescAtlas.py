from __future__ import annotations

import re
from dataclasses import dataclass, field
from pathlib import Path

from PIL import Image

_EXPR_NUM = re.compile(r"(\d+)$")
_EXPR_KEYS = ("biaoqing", "biaoiqing")


@dataclass
class Sprite:
    name: str
    px: float
    py: float
    w: int
    h: int
    ax: int
    ay: int
    scale: float = 1.0


@dataclass
class Child:
    slot: str
    sprite: str | None
    x: float
    y: float
    rot: float = 0
    sx: float = 1
    sy: float = 1


@dataclass
class Section:
    name: str
    cw: int
    ch: int
    ow: int
    oh: int
    sprites: dict[str, Sprite] = field(default_factory=dict)
    children: list[Child] = field(default_factory=list)

    @property
    def sizes(self) -> list[int]:
        return [self.cw, self.ch, self.ow, self.oh]


def parse_desc(path: Path) -> dict[str, Section]:
    sections: dict[str, Section] = {}
    cur: Section | None = None
    for raw in path.read_text(encoding="utf-8", errors="replace").splitlines():
        line = raw.strip()
        if not line or line.startswith("//"):
            continue
        parts = line.split()
        kind = parts[0]
        if kind == "section" and len(parts) >= 6:
            cur = Section(
                name=parts[1],
                cw=int(parts[2]),
                ch=int(parts[3]),
                ow=int(parts[4]),
                oh=int(parts[5]),
            )
            sections[cur.name] = cur
            continue
        if cur is None:
            continue
        if kind == "sp" and len(parts) >= 8:
            cur.sprites[parts[1]] = Sprite(
                name=parts[1],
                px=float(parts[2]),
                py=float(parts[3]),
                w=int(float(parts[4])),
                h=int(float(parts[5])),
                ax=int(float(parts[6])),
                ay=int(float(parts[7])),
                scale=float(parts[8]) if len(parts) > 8 else 1.0,
            )
        elif kind == "child" and len(parts) >= 4:
            spr = parts[2]
            cur.children.append(
                Child(
                    slot=parts[1],
                    sprite=None if spr == "null" else spr,
                    x=float(parts[3]),
                    y=float(parts[4]) if len(parts) > 4 else 0,
                    rot=float(parts[5]) if len(parts) > 5 else 0,
                    sx=float(parts[6]) if len(parts) > 6 else 1,
                    sy=float(parts[7]) if len(parts) > 7 else 1,
                )
            )
    return sections


def section_body_name(sec: Section) -> str | None:
    prefix = f"driverAsset/{sec.name}"
    if prefix in sec.sprites:
        return prefix
    if sec.name in sec.sprites:
        return sec.name
    return None


def _looks_like_expression(slot: str, sprite: str) -> bool:
    slot_l = slot.lower()
    tail = sprite.rsplit("\\", 1)[-1].lower()
    return any(k in slot_l or k in tail for k in _EXPR_KEYS)


def expression_children(sec: Section) -> list[Child]:
    out: list[Child] = []
    seen: set[str] = set()
    for ch in sec.children:
        if ch.sprite is None or not _looks_like_expression(ch.slot, ch.sprite):
            continue
        key = ch.sprite
        if key in seen:
            continue
        seen.add(key)
        out.append(ch)
    out.sort(key=expression_sort_key)
    return out


def expression_label(child: Child) -> str:
    m = _EXPR_NUM.search(child.slot)
    if m:
        return f"表情{m.group(1)}"
    tail = (child.sprite or "").rsplit("\\", 1)[-1]
    m = _EXPR_NUM.search(tail)
    if m:
        return f"表情{m.group(1)}"
    return "表情"


def expression_sort_key(child: Child) -> tuple[int, str]:
    label = expression_label(child)
    m = _EXPR_NUM.search(label)
    return (int(m.group(1)) if m else 0, label)


def sprite_dict(spr: Sprite) -> dict:
    return {
        "px": spr.px,
        "py": spr.py,
        "w": spr.w,
        "h": spr.h,
        "ax": spr.ax,
        "ay": spr.ay,
        "scale": spr.scale,
    }


def face_dict(child: Child, spr: Sprite) -> dict:
    data = sprite_dict(spr)
    data.update(
        {
            "cx": child.x,
            "cy": child.y,
            "rot": child.rot,
            "sx": child.sx,
            "sy": child.sy,
            "label": expression_label(child),
        }
    )
    return data


def layout_payload(sec: Section) -> dict | None:
    """有表情 child、或身体小于图集时，返回合成用布局。"""
    body_n = section_body_name(sec)
    if not body_n:
        return None
    body = sec.sprites[body_n]
    faces = expression_children(sec)
    need_crop = (body.w, body.h) != (sec.cw, sec.ch) or body.ax or body.ay
    if not faces and not need_crop:
        return None
    face_payloads = []
    for ch in faces:
        spr = sec.sprites.get(ch.sprite or "")
        if spr is None:
            continue
        face_payloads.append(face_dict(ch, spr))
    if not face_payloads and not need_crop:
        return None
    return {"body": sprite_dict(body), "faces": face_payloads}


def crop_sprite(atlas: Image.Image, spr: dict) -> Image.Image:
    x, y, w, h = int(spr["ax"]), int(spr["ay"]), int(spr["w"]), int(spr["h"])
    return atlas.crop((x, y, x + w, y + h)).convert("RGBA")


def _safe_paste(base: Image.Image, patch: Image.Image, x: int, y: int) -> Image.Image:
    if patch.width <= 0 or patch.height <= 0:
        return base
    bx0, by0 = max(x, 0), max(y, 0)
    bx1 = min(x + patch.width, base.width)
    by1 = min(y + patch.height, base.height)
    if bx0 >= bx1 or by0 >= by1:
        return base
    px0, py0 = bx0 - x, by0 - y
    cropped = patch.crop((px0, py0, px0 + (bx1 - bx0), py0 + (by1 - by0)))
    out = base.copy()
    out.paste(cropped, (bx0, by0), cropped)
    return out


def composite_face(base: Image.Image, body: dict, face: dict, atlas: Image.Image) -> Image.Image:
    patch = crop_sprite(atlas, face)
    sx, sy = float(face.get("sx") or 1), float(face.get("sy") or 1)
    if sx != 1 or sy != 1:
        nw = max(1, int(round(patch.width * abs(sx))))
        nh = max(1, int(round(patch.height * abs(sy))))
        patch = patch.resize((nw, nh), Image.Resampling.LANCZOS)
        if sx < 0:
            patch = patch.transpose(Image.Transpose.FLIP_LEFT_RIGHT)
        if sy < 0:
            patch = patch.transpose(Image.Transpose.FLIP_TOP_BOTTOM)
    rot = float(face.get("rot") or 0)
    if abs(rot) > 0.01:
        patch = patch.rotate(-rot, expand=True, resample=Image.Resampling.BICUBIC)
    x = int(round(float(face["cx"]) + float(face["px"]) - float(body["px"])))
    y = int(round(float(face["cy"]) + float(face["py"]) - float(body["py"])))
    return _safe_paste(base, patch, x, y)
