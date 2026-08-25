local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EC = require("ejoysdk_lua.user_center.system_config")
local EUUID = require("ejoysdk_lua.ejoysdk_uuid")
local BaseModel = require("ejoysdk_lua.user_center.agst_token_model_base")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local MODEL_NAME = "AGST_TOKEN_OVERSEA"
local M = BaseModel:Inherit(MODEL_NAME)
local TAG = "agst_token_oversea"
local AGST_IOS_PID_PERMANENT, AGST_IOS_EXT_PERMANENT, AGST_IOS_EXT, AGST_PID, AGST_EXT_GAID
local AGST_VER = "AGST_VER"
local last_agst_android_gaid, last_agst_android_pid

local function android_userinfo_handler(_user_info)
  E.LOG.debug(TAG, "is official, now save gaid and pid")
  local gaid = AGST_EXT_GAID:get()
  if not gaid then
    E.LOG.debug(TAG, "android set agst gaid: " .. tostring(last_agst_android_gaid))
    AGST_EXT_GAID:set(last_agst_android_gaid)
  else
    E.LOG.debug(TAG, "android has agst gaid: " .. tostring(last_agst_android_gaid))
  end
  local pid = AGST_PID:get()
  if not pid then
    E.LOG.debug(TAG, "android set agst pid: " .. tostring(last_agst_android_pid))
    AGST_PID:set(last_agst_android_pid)
  else
    E.LOG.debug(TAG, "android has agst pid： " .. tostring(last_agst_android_pid))
  end
end

function M.check_android_id_valid(android_id)
  local is_android_id_valid = false
  if type(android_id) == "string" and "" ~= android_id and "0000000000000000" ~= android_id then
    is_android_id_valid = true
  end
  return is_android_id_valid
end

function M.get_android_agst_info(cb)
  local pid = AGST_PID:get()
  local is_pid_from_cache = false
  if not pid then
    pid = E.Sysinfo.device_with_android_id()
  else
    is_pid_from_cache = true
  end
  
  local function get_gaid_callback(gaid)
    last_agst_android_gaid = gaid
    last_agst_android_pid = pid
    E.LOG.debug(TAG, "last_agst_android_gaid >> " .. tostring(last_agst_android_gaid) .. " and last_agst_android_pid >> " .. tostring(last_agst_android_pid))
    E.LOG.debug(TAG, "is pid from cache >> " .. tostring(is_pid_from_cache))
    local android_id = E.Sysinfo.android_id()
    if not M.check_android_id_valid(android_id) and not is_pid_from_cache then
      local user_center = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
      last_agst_android_pid = user_center.get_si()
      local params = {si = last_agst_android_pid}
      ESTAT.stat_action("use_si_replace_pid", nil, true, params)
      E.LOG.debug(TAG, "gaid and and android_id is invalid, set pid = si >> " .. tostring(last_agst_android_pid))
    end
    local new_android_pid = last_agst_android_pid .. "|||" .. gaid
    local result = M.build_agst_info(new_android_pid, last_agst_android_gaid, 3)
    E.LOG.debug(TAG, "callback agst info")
    E.log(result)
    cb(result)
  end
  
  local gaid = AGST_EXT_GAID:get()
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

function M.get_ios_agst_info(cb)
  local agst_ios_pid = AGST_PID:get()
  if agst_ios_pid then
    E.LOG.debug(TAG, "get_ios_token si:" .. agst_ios_pid)
    local ios_ext = AGST_IOS_EXT:get() or {}
    local result = M.build_agst_info(agst_ios_pid, "", ios_ext[AGST_VER])
    cb(result)
  else
    cb(nil)
  end
end

M.get_windows_agst_info = M.get_ios_agst_info

local function is_pid_nil(pid)
  return nil == pid or "" == pid
end

function M.init()
  local os = E.Sysinfo.os()
  if "ios" == os or "windows" == os or "harmonyos" == os or "douyin" == os or "weixin" == os then
    AGST_IOS_PID_PERMANENT = E.LazyKeyStore:New("OFFICIAL_AGST_IOS_PID")
    AGST_PID = E.LazyKeyStore:New("OFFICIAL_AGST_IOS_PID_UD", false, false, false)
    AGST_IOS_EXT_PERMANENT = E.LazyKeyStore:New("OFFICIAL_AGST_IOS_EXT", false, true)
    AGST_IOS_EXT = E.LazyKeyStore:New("OFFICIAL_AGST_IOS_EXT_UD", false, true, false)
  elseif "android" == os then
    AGST_PID = E.LazyKeyStore:New("OFFICIAL_AGST_ANDROID_PID")
    AGST_EXT_GAID = E.LazyKeyStore:New("AGST_EXT_GAID")
    ET.subscribe(ET.gangplank.ACQUIRE, android_userinfo_handler)
  end
  ET.subscribe(ET.user_center.USER_CENTER_INIT_SUCCESS, function(values)
    local user_center = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
    local si = user_center.get_si()
    local guest_persist = EC.get("guest_persist") or 0
    local sp_pid = AGST_PID:get()
    E.LOG.debug(TAG, "guest_persist = " .. guest_persist)
    if 0 == guest_persist and is_pid_nil(sp_pid) and values.first_launch then
      E.LOG.debug(TAG, "first launch, reset pid ")
      AGST_PID:set(si .. (EUUID.random_i64() or E.time()))
      if "ios" == os or "windows" == os then
        AGST_IOS_EXT:set({
          [AGST_VER] = 2
        })
      end
      return
    end
    E.LOG.debug(TAG, "keep pid record")
    if "ios" == os or "windows" == os then
      local permanent_pid = AGST_IOS_PID_PERMANENT:get()
      if is_pid_nil(sp_pid) then
        if is_pid_nil(permanent_pid) then
          AGST_IOS_PID_PERMANENT:set(si .. (EUUID.random_i64() or E.time()))
          AGST_IOS_EXT_PERMANENT:set({
            [AGST_VER] = 2
          })
        end
        AGST_PID:set(AGST_IOS_PID_PERMANENT:get())
        AGST_IOS_EXT:set(AGST_IOS_EXT_PERMANENT:get())
      elseif is_pid_nil(permanent_pid) then
        AGST_IOS_PID_PERMANENT:set(sp_pid)
        AGST_IOS_EXT_PERMANENT:set(AGST_IOS_EXT:get())
      end
    end
  end)
end

return M
