"""格式识别与统一处理入口。

`AssetPipeline` 只依赖这里的 :func:`process`：给定 ``(名字, 字节)``，返回
``ExtractResult``，内部递归展开嵌套容器（``ALL4`` -> ``ALAR`` -> 表/贴图）。
"""

from __future__ import annotations

import json
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

from PIL import Image

import AlArchive
import AlCompress
import AlImage
import AlManifest
import AlScene
import AlSound
import AlTable


@dataclass(slots=True)
class ExtractResult:
    #: 单一输出文件（名字 -> 字节或 PIL.Image）
    files: dict[str, Any] = field(default_factory=dict)
    #: 单一输出时建议的扩展名（"" 表示延续调用方推断）
    ext: str = ""
    #: 处理日志
    note: str = ""


def detect(data: bytes) -> str:
    if AlCompress.is_all4(data):
        return "ALL4"
    if AlCompress.is_allz(data):
        return "ALLZ"
    if AlArchive.is_alar(data):
        return "ALAR"
    if AlTable.is_altb(data):
        return "ALTB"
    if AlTable.is_alrd(data):
        return "ALRD"
    if AlImage.is_altx(data):
        return "ALTX"
    if AlImage.is_alig(data):
        return "ALIG"
    if AlScene.is_alod(data):
        return "ALOD"
    if AlScene.is_almt(data):
        return "ALMT"
    if AlSound.is_alsn(data):
        return "ALSN"
    if AlSound.is_alft(data):
        return "ALFT"
    if AlManifest.looks_like_manifest(data):
        return "ALMANIFEST"
    if data[:4] == b"OggS":
        return "OGG"
    if data[:3] == b"ID3" or data[:2] == b"\xff\xfb":
        return "MP3"
    if data[:8] == b"\x89PNG\r\n\x1a\n":
        return "PNG"
    return ""


def process(name: str, data: bytes) -> ExtractResult:
    """把一个资源展开成最终产物（不解压/未识别的返回原样）。"""
    kind = detect(data)

    if kind == "ALL4":
        try:
            return ExtractResult({"": AlCompress.decode_all4(data)}, "", "ALL4")
        except Exception as exc:  # noqa: BLE001
            return ExtractResult({name: data}, "", f"ALL4 解压失败: {exc}")
    if kind == "ALLZ":
        try:
            return ExtractResult({"": AlCompress.decode_allz(data)}, "", "ALLZ")
        except Exception as exc:  # noqa: BLE001
            return ExtractResult({name: data}, "", f"ALLZ 解压失败: {exc}")
    if kind == "ALAR":
        try:
            archive = AlArchive.parse_alar(data)
        except ValueError as exc:
            return ExtractResult({name: data}, "", f"ALAR 解析失败: {exc}")
        members = {member: blob for member, blob in AlArchive.iter_members(data, archive)}
        return ExtractResult(members, "", f"ALAR v{archive.version} x{len(members)}")
    if kind == "ALTB":
        return ExtractResult(
            {"": AlTable.table_to_json(data).encode("utf-8")}, ".json", "ALTB"
        )
    if kind == "ALRD":
        fields, record_size, _ = AlTable.parse_schema(data, 0)
        payload = {
            "version": data[4],
            "flags": f"0x{data[5]:02X}",
            "record_size": record_size,
            "fields": [
                {
                    "name": f.name,
                    "alias": f.alias,
                    "type": f.type_name,
                    "type_code": f.type_code,
                    "offset": f.offset,
                    "size": f.size,
                }
                for f in fields
            ],
        }
        return ExtractResult(
            {"": json.dumps(payload, ensure_ascii=False, indent=2).encode("utf-8")},
            ".json",
            "ALRD",
        )
    if kind == "ALTX":
        atlas = AlImage.parse_atlas(data)
        stem = Path(name).stem if name else "atlas"
        atlas_label = atlas.name or stem
        files: dict[str, Any] = {}
        if atlas.image is not None:
            files[f"{atlas_label}.png"] = atlas.image
        files[f"{atlas_label}.atlas.json"] = AlImage.atlas_metadata(atlas).encode("utf-8")
        return ExtractResult(files, "", f"ALTX {len(atlas.children)} 个子贴图")
    if kind == "ALIG":
        try:
            return ExtractResult({"": AlImage.alig_to_image(data)}, ".png", "ALIG")
        except ValueError as exc:
            return ExtractResult({name: data}, "", f"ALIG 转换失败: {exc}")
    if kind == "ALOD":
        return ExtractResult(
            {"": AlScene.alod_to_json(data).encode("utf-8")}, ".json", "ALOD"
        )
    if kind == "ALMT":
        return ExtractResult(
            {"": AlScene.almt_to_json(data).encode("utf-8")}, ".json", "ALMT"
        )
    if kind == "ALSN":
        payload, ext = AlSound.alsn_audio(data)
        if not payload:
            return ExtractResult({name: data}, "", "ALSN 空数据")
        return ExtractResult({"": (payload, ext)}, ext, f"ALSN{ext}")
    if kind == "ALFT":
        offset = AlSound.alft_embedded_image_offset(data)
        if offset is not None:
            return ExtractResult({"": data[offset:]}, "", f"ALFT 内嵌贴图 @0x{offset:X}")
        return ExtractResult({name: data}, "", "ALFT")
    if kind == "ALMANIFEST":
        entries = AlManifest.decode(data)
        payload = json.dumps(
            [entry.to_dict() for entry in entries], ensure_ascii=False, indent=2
        ).encode("utf-8")
        return ExtractResult({"": payload}, ".json", f"ALMANIFEST {len(entries)} 条")
    if kind in ("OGG", "MP3", "PNG"):
        ext = {"OGG": ".ogg", "MP3": ".mp3", "PNG": ".png"}[kind]
        return ExtractResult({"": data}, ext, kind)
    return ExtractResult({name: data}, "", "")


def save(path, value, *, image_ext: str = ".png") -> None:
    """把 :class:`ExtractResult` 里的值写盘。"""
    path.parent.mkdir(parents=True, exist_ok=True)
    if isinstance(value, Image.Image):
        value.save(path)
    elif isinstance(value, tuple):
        payload, ext = value
        path = path.with_suffix(ext)
        path.write_bytes(payload)
    elif isinstance(value, (bytes, bytearray)):
        path.write_bytes(value)
    else:  # pragma: no cover - 防御
        raise TypeError(f"无法写出的类型 {type(value)!r}")
