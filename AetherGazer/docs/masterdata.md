# 数据表解析

## 背景

游戏主配置表打包在资源文件 `config.ys`（AssetBundle）中，内部含一个
`TextAsset("Config")`。该数据为自定义 protobuf 容器（见
[config-format.md](config-format.md)），行数据是 `Google.Protobuf`
序列化的消息。字段名/编号映射来自 `cs/il2cpp.cs` 中的
`Config.*` 消息类（`IMessage<T>` 的 `XxxFieldNumber` 常量 + 属性），
由 `extract_schema.py` 提取为 `config_schema.json`。

## 一键运行

```bash
python scripts/fetch_masterdata.py
```

等价分步：

```bash
python masterdata/extract_config.py aethergazer/Assets/config.ys Config.bin
python masterdata/config_parser.py Config.bin --out MasterData
```

或配合更新器：

```bash
python updater/aethergazer_updater.py --output ./aethergazer --masterdata
```

## 输出

`MasterData/` 下每表一个 JSON 文件（数组，元素含 `id` 与全部字段），
另附 `masterdata_index.json` 汇总。

## Schema 更新

游戏更新后字段可能变化，重新从 `il2cpp.cs` 提取：

```bash
python masterdata/extract_schema.py --cs cs/il2cpp.cs --out config_schema.json
```

提取器使用花括号平衡定位类体，兼容 `IMessage<X>` 与
`IMessage<Config.X>` 两种写法；当前提取 180 个消息、1460 个枚举。
