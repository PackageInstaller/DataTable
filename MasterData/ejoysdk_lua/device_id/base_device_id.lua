local Class = require("ejoysdk_lua.ejoysdk_class")
local E = require("ejoysdk_lua.ejoysdk")
local M = Class:Inherit("DeviceIdModel")
local TAG = "device_id_model_base"

function M.init()
  E.LOG.warn(TAG, "init not implements")
end

function M.get_android_device_info(cb)
  E.LOG.warn(TAG, "get_android_agst_info not implements")
  cb(nil)
end

function M.get_ios_device_info(cb)
  E.LOG.warn(TAG, "get_ios_agst_info not implements")
  cb(nil)
end

function M.get_windows_device_info(cb)
  E.LOG.warn(TAG, "get_windows_agst_info not implements")
  cb(nil)
end

function M.clear_token()
  E.LOG.warn(TAG, "clear_token empty implements")
end

function M:get_device_info(cb)
  local os = E.Sysinfo.os()
  if "android" == os then
    self.get_android_device_info(cb)
  elseif "ios" == os then
    self.get_ios_device_info(cb)
  elseif "windows" == os then
    self.get_windows_device_info(cb)
  end
end

function M.check_token_has_risk()
  _ejoysdk.log("check_token_has_risk in base")
  return false
end

return M
