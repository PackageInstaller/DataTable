# 数据表解析

## 背景

游戏主配置表打包在资源文件 `config.ys`（AssetBundle）中，内部含一个
`TextAsset("Config")`。该数据为自定义 protobuf 容器（见
[config-format.md](config-format.md)），行数据是 `Google.Protobuf`
序列化的消息。字段名/编号映射来自 `cs/il2cpp.cs` 中的
`Config.*` 消息类（`IMessage<T>` 的 `XxxFieldNumber` 常量 + 属性），
由 `schema` 子命令提取为 `Schema.json`。

## 一键运行（数据表模式）

```bash
python AetherGazer.py masterdata
```

数据表模式只下载数据表资产 `config.ys` 与 Lua bundle（`scripts64` /
`scripts32`），不会下载整包资源：

1. `config.ys` 落到 `MasterData/config.ys`；
2. 按字段映射反序列化全部 89 张表到 `MasterData/*.json`；
3. Lua bundle 提取字节码后调用 `luajit-decompiler` 反编译到
   `MasterData/Lua/x64`、`MasterData/Lua/x86`。

```bash
# 只解析数据表，不下载 Lua
python AetherGazer.py masterdata --no-lua

# Lua 只保留 LuaJIT 字节码（需要系统命令 luajit-decompiler）
python AetherGazer.py masterdata --no-decompile

# 忽略状态重新下载 / 重新解析
python AetherGazer.py masterdata --force
```

重复运行按 `MasterData/masterdata_state.json` 里的 md5 增量跳过：
`config.ys` 与 Lua bundle 只有在清单哈希变化时才重新下载解析。

## 输出

`MasterData/` 下每表一个 JSON 文件（数组，元素含 `id` 与全部字段），
另附 `masterdata_index.json` 汇总；Lua 源码在 `MasterData/Lua/`。

## Schema 更新

游戏更新后字段可能变化，重新从 `il2cpp.cs` 提取：

```bash
python AetherGazer.py schema --cs cs/il2cpp.cs --out Schema.json
```

提取器使用花括号平衡定位类体，兼容 `IMessage<X>` 与
`IMessage<Config.X>` 两种写法；当前提取 180 个消息、1460 个枚举。
