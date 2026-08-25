local E = require("ejoysdk_lua.ejoysdk")
local CRASH = require("ejoysdk_lua.vendors.crashsdk")
local WpkComp, Super = System.NewClass("WpkComp", Component, IUpdater)

function WpkComp:ctor()
  Super.ctor(self)
end

function WpkComp:Awake(binder)
  Super.Awake(self)
  if not SdkMgr.Instance:IsSdkLogin() then
    Logger.Info("[Wpk] ejoy SDK未开启,关闭啄木鸟SDK")
    return
  end
  binder:BindEvent(EventMgr.Instance.OnSdkInitSuccess, function()
    self:InitHeaderInfo()
  end)
end

function WpkComp:InitHeaderInfo()
  local pkg_info = E.get_pkg_info()
  self:AddHeaderInfo("utdid", pkg_info.utdid)
end

function WpkComp:AddHeaderInfo(key, value)
  local keyStr = string.format("wk_%s", key)
  local valueStr = value and value or "nil"
  CRASH.add_header_info(keyStr, valueStr)
end

function WpkComp:CreateCustomLog(content, traceBack, type)
  if not SdkMgr.Instance or not SdkMgr.Instance:IsSdkLogin() then
    return
  end
  Logger.Info("上传自定义日志至啄木鸟")
  local CRASH = require("ejoysdk_lua.vendors.crashsdk")
  local extra = {uploadNow = true}
  local tracebackStr = string.format("错误信息：%s\n【Lua调用堆栈】：%s", content, traceBack)
  local typeStr = type and type or "exception"
  CRASH.create_custom_log(typeStr, "LuaException", tracebackStr, nil, extra)
end

return WpkComp
