local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local BaseModel = require("ejoysdk_lua.device_id.base_device_id")
local MODEL_NAME = "DEVICE_ID_OVERSEA"
local M = BaseModel:Inherit(MODEL_NAME)
local TAG = "device_id_oversea"
local DEVICE_PID, DEVICE_EXT_GAID

function M.get_android_device_info(cb)
  local pid = DEVICE_PID:get()
  pid = pid or E.Sysinfo.device_with_android_id()
  
  local function get_gaid_callback(gaid)
    DEVICE_EXT_GAID:set(gaid)
    cb(pid, gaid)
  end
  
  local gaid = DEVICE_EXT_GAID:get()
  E.LOG.debug(TAG, "agst# login and check cache gaid:" .. tostring(gaid))
  if gaid then
    get_gaid_callback(gaid)
  else
    E.LOG.debug(TAG, "agst# start get gaid async")
    E.Sysinfo.gaid_async(function(result)
      gaid = result.value
      E.LOG.debug(TAG, "gaid# async callback:" .. tostring(gaid))
      gaid = gaid or ""
      get_gaid_callback(gaid)
    end)
  end
end

function M.get_ios_device_info(cb)
  local agst_ios_pid = DEVICE_PID:get()
  if agst_ios_pid then
    E.LOG.debug(TAG, "get_ios_token si:" .. agst_ios_pid)
    cb(agst_ios_pid, "")
  else
    cb(nil)
  end
end

M.get_windows_device_info = M.get_ios_device_info

function M.init()
  local os = E.Sysinfo.os()
  if "ios" == os or "windows" == os then
    DEVICE_PID = E.LazyKeyStore:New("OFFICIAL_IOS_DEVICE_PID")
    local device_pid = DEVICE_PID:get()
    if nil == device_pid or "" == device_pid then
      local AGST_PID = E.LazyKeyStore:New("OFFICIAL_AGST_IOS_PID")
      local pid = AGST_PID:get()
      if nil == pid or "" == pid then
        ET.subscribe(ET.user_center.USER_CENTER_INIT_SUCCESS, function()
          E.LOG.debug(TAG, "received user_center init success, and now set ios pid to si")
          local user_center = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
          local si = user_center.get_si()
          DEVICE_PID:set(si)
        end)
      else
        DEVICE_PID:set(pid)
      end
    end
  elseif "android" == os then
    DEVICE_PID = E.LazyKeyStore:New("OFFICIAL_ANDROID_DEVICE_PID")
    DEVICE_EXT_GAID = E.LazyKeyStore:New("DEVICE_EXT_GAID")
  end
end

return M
