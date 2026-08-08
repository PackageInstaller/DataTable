from __future__ import annotations

import argparse
import json
import re
from pathlib import Path


PRIMITIVES = {
    "int",
    "uint",
    "long",
    "ulong",
    "float",
    "double",
    "bool",
    "string",
    "bytes",
}


def extract_class_blocks(src: str):
    """提取所有 `public sealed class X : IMessage<X>` 的类体。"""
    # 兼容 `IMessage<X>` 与 `IMessage<Config.X>` 两种泛型参数写法；
    # 用花括号平衡定位类体，避免嵌套/空行导致正则提前截断。
    pattern = re.compile(
        r"public sealed class (\w+) : IMessage<(?:Config\.)?\1>[^{]*\{",
        re.S,
    )
    for m in pattern.finditer(src):
        i = m.start()
        j = m.end() - 1  # 指向 '{'
        depth = 0
        k = j
        while k < len(src):
            if src[k] == "{":
                depth += 1
            elif src[k] == "}":
                depth -= 1
                if depth == 0:
                    break
            k += 1
        if depth != 0:
            continue
        yield _BlockMatch(m.group(1), src[m.start():k + 1])


def extract_enums(src: str) -> dict[str, dict[str, int]]:
    enums: dict[str, dict[str, int]] = {}
    pattern = re.compile(
        "public enum (\\w+)[^\\{]*\\{([^}]*)\\}",
        re.S,
    )
    for m in pattern.finditer(src):
        name = m.group(1)
        values: dict[str, int] = {}
        for vm in re.finditer(r"(\w+)\s*=\s*(-?\d+)", m.group(2)):
            values[vm.group(1)] = int(vm.group(2))
        enums[name] = values
    return enums


def parse_class(body: str, class_name: str) -> dict:
    fields: list[dict] = []
    # field number constants
    field_nums = {}
    for m in re.finditer(r"public const int (\w+)FieldNumber = (\d+);", body):
        prop = m.group(1)
        field_nums[prop] = int(m.group(2))

    # property declarations:  public <type> <Name> { get; set; } / { get; }
    prop_pattern = re.compile(
        r"public (?:static\s+)?([A-Za-z_][\w.<>, ]*?)\s+(\w+)\s*\{[^}]*\}",
        re.S,
    )
    prop_types: dict[str, str] = {}
    for m in prop_pattern.finditer(body):
        ptype = m.group(1).strip()
        pname = m.group(2)
        if pname in field_nums:
            prop_types[pname] = ptype

    for prop, num in sorted(field_nums.items(), key=lambda x: x[1]):
        ptype = prop_types.get(prop, "?")
        repeated = False
        elem = ptype
        mrep = re.fullmatch(r"RepeatedField<(.+)>", ptype)
        if mrep:
            repeated = True
            elem = mrep.group(1)
        fields.append(
            {
                "fieldNumber": num,
                "name": prop,
                "type": ptype,
                "repeated": repeated,
                "elementType": elem if repeated else None,
            }
        )

    return {
        "message": class_name,
        "fields": fields,
    }


class _BlockMatch:
    def __init__(self, name: str, body: str):
        self._name = name
        self._body = body

    def group(self, n):
        return self._name if n == 1 else self._body


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--cs", default="cs/il2cpp.cs")
    ap.add_argument("--out", default="config_schema.json")
    args = ap.parse_args()

    src = Path(args.cs).read_text(encoding="utf-8", errors="replace")
    enums = extract_enums(src)
    messages: list[dict] = []
    for m in extract_class_blocks(src):
        class_name = m.group(1)
        body = m.group(0)
        parsed = parse_class(body, class_name)
        if parsed["fields"]:
            messages.append(parsed)

    out = {
        "source": str(Path(args.cs).resolve()),
        "messageCount": len(messages),
        "enumCount": len(enums),
        "messages": messages,
        "enums": enums,
    }
    Path(args.out).write_text(
        json.dumps(out, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    print(f"messages={len(messages)} enums={len(enums)} -> {args.out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
