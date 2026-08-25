local E = require("ejoysdk_lua.ejoysdk")
local BaseModel = require("ejoysdk_lua.device_id.base_device_id")
local MODEL_NAME = "DEVICE_ID_ALIGAMES"
local M = BaseModel:Inherit(MODEL_NAME)
local TAG = "devices_id_aligames"
local AGST_PID_PERMANENT, AGST_ANDROID_PID, AGST_EXT_OAID, AGST_CN_EXT_SI, AGST_CURRENT_TOKEN_HAS_RISK, last_agst_android_oaid, last_agst_android_pid

local function check_android_id_valid()
  local android_id = E.get_pkg_info().android_id
  E.LOG.debug(TAG, "begin check check_android_id_valid:" .. tostring(android_id))
  if not android_id or "" == android_id or android_id:match("^[0]+$") then
    return false, android_id
  else
    return true, android_id
  end
end

local function check_oaid_valid()
  local oaid = E.get_pkg_info().oaid
  E.LOG.debug(TAG, "begin check check_oaid_valid:" .. tostring(oaid))
  if not oaid or "" == oaid or "-1" == oaid or oaid:match("^[0-]+$") then
    return false, oaid
  else
    return true, oaid
  end
end

function M.get_android_device_info(cb)
  if last_agst_android_pid and last_agst_android_oaid then
    cb(last_agst_android_pid, last_agst_android_oaid)
    return
  end
  last_agst_android_pid = AGST_ANDROID_PID:get()
  last_agst_android_oaid = AGST_EXT_OAID:get()
  if last_agst_android_pid and last_agst_android_oaid then
    cb(last_agst_android_pid, last_agst_android_oaid)
    return
  end
  local android_valid, android_id = check_android_id_valid()
  local oaid_valid, oaid = check_oaid_valid()
  if android_valid or oaid_valid then
    E.LOG.debug(TAG, "get_android_agst_info check valid， android_id:" .. tostring(android_id) .. ", oaid:" .. tostring(oaid))
    last_agst_android_pid = E.get_pkg_info().device_android_id
    last_agst_android_oaid = E.get_pkg_info().oaid or ""
    AGST_CURRENT_TOKEN_HAS_RISK:set("false")
  else
    last_agst_android_pid = E.get_pkg_info().device_android_id
    last_agst_android_oaid = AGST_CN_EXT_SI:get()
    E.LOG.debug(TAG, "get_android_agst_info check NOT valid， android_id:" .. tostring(android_id) .. ", oaid:" .. tostring(oaid) .. ", use si instead:" .. tostring(last_agst_android_oaid))
    AGST_CURRENT_TOKEN_HAS_RISK:set("true")
    local stat = require("ejoysdk_lua.ejoysdk_stat")
    local params = {}
    params.is_priority_high = true
    local action_type = "andrid:" .. tostring(android_id) .. ",oaid:" .. tostring(oaid)
    stat.stat_action("androidid_oaid_invalid", action_type, true, params)
  end
  AGST_ANDROID_PID:set(last_agst_android_pid)
  AGST_EXT_OAID:set(last_agst_android_oaid)
  cb(last_agst_android_pid, last_agst_android_oaid)
end

function M.get_ios_device_info(cb)
  local agst_permanent_pid = AGST_PID_PERMANENT:get()
  if agst_permanent_pid then
    E.LOG.debug(TAG, "get_ios_token si:" .. agst_permanent_pid)
    cb(agst_permanent_pid, "")
  else
    cb(nil)
  end
end

M.get_windows_agst_info = M.get_ios_agst_info

function M.set_si(si)
  if nil == si or "" == si then
    return
  end
  if nil ~= AGST_PID_PERMANENT then
    local saved_si = AGST_PID_PERMANENT:get()
    if nil == saved_si or "" == saved_si then
      E.LOG.debug(TAG, "received aligames system device init success, and now set ios pid to si:" .. tostring(si))
      AGST_PID_PERMANENT:set(si)
    else
      E.LOG.debug(TAG, "already has pid, skip update, origin is:" .. tostring(saved_si))
    end
  end
  if nil ~= AGST_CN_EXT_SI then
    local saved_si = AGST_CN_EXT_SI:get()
    if nil == saved_si or "" == saved_si then
      E.LOG.debug(TAG, "received aligames system device init success, and now set android ext to si:" .. tostring(si))
      AGST_CN_EXT_SI:set(si)
    else
      E.LOG.debug(TAG, "already has ext si, skip update, origin is:" .. tostring(saved_si))
    end
  end
end

function M.init()
  local os = E.Sysinfo.os()
  if "ios" == os or "windows" == os then
    AGST_PID_PERMANENT = E.LazyKeyStore:New("ALIGAMES_AGST_PID_PERMANENT", false, false, true)
  elseif "android" == os then
    AGST_ANDROID_PID = E.LazyKeyStore:New("ALIGAMES_AGST_ANDROID_PID")
    AGST_EXT_OAID = E.LazyKeyStore:New("AGST_EXT_OAID")
    AGST_CN_EXT_SI = E.LazyKeyStore:New("AGST_CN_EXT_SI")
  end
  AGST_CURRENT_TOKEN_HAS_RISK = E.LazyKeyStore:New("AGST_CURRENT_TOKEN_HAS_RISK")
end

function M.check_token_has_risk()
  local has_risk = AGST_CURRENT_TOKEN_HAS_RISK:get()
  return "true" == has_risk
end

return M
