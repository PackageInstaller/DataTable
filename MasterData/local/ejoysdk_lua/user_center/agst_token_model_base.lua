local Class = require("ejoysdk_lua.ejoysdk_class")
local E = require("ejoysdk_lua.ejoysdk")
local M = Class:Inherit("AgstTokenModel")
local TAG = "agst_token_model_base"
M.AGST_VERSION = 1
M.KEY = {
  PID = "pid",
  EXT = "ext",
  VER = "ver"
}

function M.init()
  E.LOG.warn(TAG, "init not implements")
end

function M.get_android_agst_info(cb)
  E.LOG.warn(TAG, "get_android_agst_info not implements")
  cb(nil)
end

function M.get_ios_agst_info(cb)
  E.LOG.warn(TAG, "get_ios_agst_info not implements")
  cb(nil)
end

function M.get_windows_agst_info(cb)
  E.LOG.warn(TAG, "get_windows_agst_info not implements")
  cb(nil)
end

function M.clear_token()
  E.LOG.warn(TAG, "clear_token empty implements")
end

function M.build_agst_info(pid, ext, ver)
  return {
    [M.KEY.PID] = pid,
    [M.KEY.EXT] = ext,
    [M.KEY.VER] = ver or M.AGST_VERSION
  }
end

function M:get_agst_pid_ext_info(cb)
  local os = E.Sysinfo.os()
  if "android" == os then
    self.get_android_agst_info(cb)
  elseif "ios" == os then
    self.get_ios_agst_info(cb)
  elseif "windows" == os then
    self.get_windows_agst_info(cb)
  elseif "harmonyos" == os then
    self.get_harmonyos_agst_info(cb)
  elseif "douyin" == os then
    self.get_douyin_agst_info(cb)
  elseif "weixin" == os then
    self.get_weixin_agst_info(cb)
  end
end

return M
