# Lua 脚本桥（ToLua）与脚本分发链路

更新器筛选（只下载 Lua bundle + tolua 运行时）：

```bash
python AetherGazer.py assets --output ./AetherGazer --only lua
```

一键下载并提取全部 Lua（默认反编译输出到 `MasterData/Lua/`，按内部路径还原）：

```bash
python AetherGazer.py lua                  # scripts64 -> Lua/x64，scripts32 -> Lua/x86
python AetherGazer.py lua --arch 64        # 只处理 64 位
python AetherGazer.py lua --no-decompile   # 只保留 LuaJIT 字节码
python AetherGazer.py lua --keep-bytecode  # 反编译后额外保留字节码到 LuaBytecode/
```

数据表模式（`masterdata`）也会下载并反编译 Lua，只是额外解析 `config.ys`
到 `MasterData/*.json`；两者共用同一份状态文件与哈希跳过逻辑。

## 1.LuaJIT 字节码反编译（luajit-decompiler）

反编译工具为 Linux 原生版（C++23 + CMake），已安装为系统命令
`luajit-decompiler`。源码与变更记录见 fork：
[PackageInstaller/luajit-decompiler](https://github.com/PackageInstaller/luajit-decompiler)

直接反编译（输入可以是单个 `.lua.bytes` 或目录，`-o` 指定输出目录）：

```bash
# 先留一份字节码（MasterData/LuaBytecode/），再手动反编译
python AetherGazer.py lua --keep-bytecode
luajit-decompiler MasterData/LuaBytecode/x64 -o MasterData/Lua/x64 -s
```

或者一键：下载两个架构的 bundle、拆出字节码、再调用系统命令反编译：

```bash
python AetherGazer.py lua --decompile --out ./MasterData
# 输出：MasterData/Lua/x64、MasterData/Lua/x86（反编译结果，行尾统一为 LF）
```
