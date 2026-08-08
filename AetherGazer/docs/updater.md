# 资源下载更新器

## 原理

官方启动器通过 SDK 接口获取当前热更版本：

```text
https://open.ys4fun.com/game-website-server/pass/sdk/get_game_hot_update_version?gameId=1
```

响应中的 `downloadUrl` 是资源 CDN 镜像列表（分号分隔），`assethash` 是
资源清单文件名：

```text
<downloadUrl>/<assethash>
```

清单 `assetHashList` 每行格式为：

```text
原始路径|md5|size
```

单个资源下载 URL：

```text
<downloadUrl>/<md5>.ys
```

本地布局与官方修复逻辑一致，按**原始路径**保存（不做 hash 重命名）：

```text
<输出目录>/Assets/<清单原始路径>
```

## 使用

```bash
# 首次：全量下载到 Assets/（默认 all,voice + zh,ja）
python updater/aethergazer_updater.py --output ./aethergazer --jobs 8

# 增量：有变更下载到 Updates/
python updater/aethergazer_updater.py --output ./aethergazer --jobs 8

# 只生成清单/下载链接
python updater/aethergazer_updater.py --output ./aethergazer --list-only

# 指定包/分组
python updater/aethergazer_updater.py --output ./aethergazer --only newbie,advance,permanent
python updater/aethergazer_updater.py --output ./aethergazer --only assetpend_common_chapter_2

# 下载 + MD5 校验
python updater/aethergazer_updater.py --output ./aethergazer --verify

# 强制重新全量
python updater/aethergazer_updater.py --output ./aethergazer --force-full

# 下载完成后自动解析数据表
python updater/aethergazer_updater.py --output ./aethergazer --masterdata
```

生成的辅助文件：

| 文件                                     | 说明                     |
| ---------------------------------------- | ------------------------ |
| `hot_version.json`                     | 热更接口原始响应         |
| `assethash.json`                       | 资源清单                 |
| `download_urls.txt`                    | 全部资源 URL 列表        |
| `filelist.txt`                         | 路径/md5/大小            |
| `voice_info.json` / `voice_urls.txt` | 语音包信息               |
| `updater_state.json`                   | 本地状态（增量更新依据） |

## 语音包

语音包列表：`voice_package_list_<app>_<res>.bytes`（如
`voice_package_list_307_229.bytes`），语音哈希清单：
`voice_hash_<语言>_<版本>.bytes`。

```bash
# 中日一起（默认）
python updater/aethergazer_updater.py --output ./aethergazer --only voice
# 只中文
python updater/aethergazer_updater.py --output ./aethergazer --only voice --voice-lang zh
# 只日文
python updater/aethergazer_updater.py --output ./aethergazer --only voice --voice-lang ja
```

中日语音按语言分目录保存，互不覆盖：

```text
Assets/voice/zh/activity_v_2_0.acb
Assets/voice/ja/activity_v_2_0.acb
```

## 立绘模式

只下载 `textureconfig/character/portrait` 与 `portraitdlc`，直接放入
`Illustration/`（不带上级目录）：

```bash
python updater/aethergazer_updater.py --output ./aethergazer --illustration
```

```text
Illustration/portrait/10014_split_1.ys
Illustration/portraitdlc/101502.ys
```

## SDK 配置解密（browser/ 导出物）

`ysmix_channel_config.txt`、`ysmix_config.txt`、`ys_config.txt`、
`gm_config.txt` 为 AES-256-ECB（PKCS7）加密，密钥为字符串 `ys4fun`
补零到 32 字节。生产 SDK BaseUrl：

```text
https://open.ys4fun.com/mix-sdk-api/
```

SDK 请求签名：参数按 key 升序拼接 `key=value&`，末尾追加
`appSecret=<secret>`，整体 UTF-8 MD5 小写。
