import re
import os


def pascal_to_snake(class_name):
    if class_name.startswith("M") and len(class_name) > 1 and class_name[1].isupper():
        body = class_name[1:]
        snake = re.sub(r"(?<!^)(?=[A-Z])", "_", body).lower()
        return f"m_{snake}"
    return class_name.lower()


def main():
    cs_file = "cs/il2cpp.cs"
    output_file = "AbyssSchema.py"

    with open(cs_file, "r", encoding="utf-8", errors="ignore") as f:
        content = f.read()

    class_pattern = re.compile(
        r"\[MessagePackObject\(false\)\]\s*public\s+sealed\s+class\s+(\w+)[^{]*\{([\s\S]*?)\n\t*\}",
        re.MULTILINE,
    )

    matches = class_pattern.findall(content)
    schema = {}

    for class_name, body in matches:
        if class_name.endswith("Array"):
            continue

        field_pattern = re.compile(
            r"\[Key\((\d+)\)\]\s+public\s+([\w.\[\]<>_]+)\s+(\w+)\s*;", re.MULTILINE
        )
        field_matches = field_pattern.findall(body)

        if not field_matches:
            continue

        sorted_fields = sorted(field_matches, key=lambda x: int(x[0]))
        fields_list = [f[2] for f in sorted_fields]
        table_key = pascal_to_snake(class_name)
        schema[table_key] = fields_list

    with open(output_file, "w", encoding="utf-8") as out_f:
        out_f.write("# 由 GenerateSchema.py 自动生成的数据库字段映射 Schema\n\n")
        out_f.write("DATABASE_SCHEMA = {\n")
        for table_key, fields in sorted(schema.items()):
            out_f.write(f"    {repr(table_key)}: {repr(fields)},\n")
        out_f.write("}\n")


if __name__ == "__main__":
    main()
