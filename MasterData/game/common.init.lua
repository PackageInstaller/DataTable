umeng = import(".MobClickForLua")
PushManager = import(".MipushApi")
List = import(".List")
UIController = import(".UIController")
UIView = import(".UIView")
UIBase = import(".UIBase")
local ok, cmsgpack = pcall(require, "msgpack")
if ok then
  MsgPack = cmsgpack
else
  MsgPack = import(".MessagePack")
end
globalCsv = require("csvdata.GlobalDefine")
