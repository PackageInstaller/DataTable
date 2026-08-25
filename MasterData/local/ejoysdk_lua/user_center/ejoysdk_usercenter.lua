local API = require("ejoysdk_lua.user_center.usercenter_api")
local E = require("ejoysdk_lua.ejoysdk")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local PROTOCOL = require("ejoysdk_lua.user_center.usercenter_protocol")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local EM = require("ejoysdk_lua.ejoysdk_module")
local SC = require("ejoysdk_lua.user_center.system_config")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local TAG = EM.MODULE.USER_CENTER .. "ejoysdk_usercenter"
local is_first_launch = E.LazyKeyStore:New("CONFIG_CHECK_TIME", false, false, false):get() == nil
local THIRD_PARTY_TYPES = {
  FACEBOOK = "facebook",
  APPLE = "apple_game_center",
  GOOGLE = "google",
  GOOGLE_PLAY = "google_play",
  GUEST = "guest",
  AIRLINE = "airline",
  QR_LOGIN = "qr_login",
  MOCK = "mock",
  APPLE_LOGIN = "apple_login",
  APPLE_LOGIN_H5 = "apple_login_h5",
  HW_LOGIN = "hw_login",
  TWITTER_LOGIN = "twitter_login",
  LINE = "line",
  CITA_LOGIN = "cita_login",
  ST_LOGIN = "st_login",
  PGA_LOGIN = "pga_login",
  DMM_LOGIN = "dmm_login",
  STEAM = "steam_login",
  WEGAME = "wegame_login",
  EPIC = "epic_login",
  X7SY = "xiao7_login",
  ALIPAY = "alipay",
  TAOBAO = "taobao",
  HUAWEI_AUTH = "harmony_login",
  TAP_LOGIN = "tap_login",
  PHONE_AUTH = "sim_login",
  WEIXIN = "wx_login",
  DOUYIN = "douyin_login",
  WEIXIN_MINI = "wx_mini_login",
  DOUYIN_MINI = "douyin_mini_login",
  XIAOMI = "mi_login",
  OPPO = "oppo_login"
}
local VENDOR_NAME_MAP = {
  FB = THIRD_PARTY_TYPES.FACEBOOK,
  APPLE = THIRD_PARTY_TYPES.APPLE,
  GOOGLE = THIRD_PARTY_TYPES.GOOGLE,
  GOOGLE_PLAY = THIRD_PARTY_TYPES.GOOGLE_PLAY,
  AGST = THIRD_PARTY_TYPES.GUEST,
  AIRLINE = THIRD_PARTY_TYPES.AIRLINE,
  QR_LOGIN = THIRD_PARTY_TYPES.QR_LOGIN,
  APPLE_LOGIN = THIRD_PARTY_TYPES.APPLE_LOGIN,
  APPLE_LOGIN_H5 = THIRD_PARTY_TYPES.APPLE_LOGIN_H5,
  HW_LOGIN = THIRD_PARTY_TYPES.HW_LOGIN,
  TWITTER_LOGIN = THIRD_PARTY_TYPES.TWITTER_LOGIN,
  LINE = THIRD_PARTY_TYPES.LINE,
  CITA_LOGIN = THIRD_PARTY_TYPES.CITA_LOGIN,
  ST_LOGIN = THIRD_PARTY_TYPES.ST_LOGIN,
  PGA_LOGIN = THIRD_PARTY_TYPES.PGA_LOGIN,
  DMM_LOGIN = THIRD_PARTY_TYPES.DMM_LOGIN,
  STEAM = THIRD_PARTY_TYPES.STEAM,
  WEGAME = THIRD_PARTY_TYPES.WEGAME,
  EPIC = THIRD_PARTY_TYPES.EPIC,
  WEIXIN = THIRD_PARTY_TYPES.WEIXIN,
  WEIXIN_MINI = THIRD_PARTY_TYPES.WEIXIN_MINI,
  DOUYIN = THIRD_PARTY_TYPES.DOUYIN,
  DOUYIN_MINI = THIRD_PARTY_TYPES.DOUYIN_MINI,
  X7SY = THIRD_PARTY_TYPES.X7SY,
  TAP_LOGIN = THIRD_PARTY_TYPES.TAP_LOGIN,
  XIAOMI = THIRD_PARTY_TYPES.XIAOMI,
  OPPO = THIRD_PARTY_TYPES.OPPO
}
local THIRD_PARTY_TYPE_MAP = {
  [THIRD_PARTY_TYPES.FACEBOOK] = "FB",
  [THIRD_PARTY_TYPES.APPLE] = "APPLE",
  [THIRD_PARTY_TYPES.GOOGLE] = "GOOGLE",
  [THIRD_PARTY_TYPES.GOOGLE_PLAY] = "GOOGLE_PLAY",
  [THIRD_PARTY_TYPES.GUEST] = "AGST",
  [THIRD_PARTY_TYPES.AIRLINE] = "AIRLINE",
  [THIRD_PARTY_TYPES.QR_LOGIN] = "QR_LOGIN",
  [THIRD_PARTY_TYPES.APPLE_LOGIN] = "APPLE_LOGIN",
  [THIRD_PARTY_TYPES.APPLE_LOGIN_H5] = "APPLE_LOGIN_H5",
  [THIRD_PARTY_TYPES.HW_LOGIN] = "HW_LOGIN",
  [THIRD_PARTY_TYPES.TWITTER_LOGIN] = "TWITTER_LOGIN",
  [THIRD_PARTY_TYPES.CITA_LOGIN] = "CITA_LOGIN",
  [THIRD_PARTY_TYPES.ST_LOGIN] = "ST_LOGIN",
  [THIRD_PARTY_TYPES.PGA_LOGIN] = "PGA_LOGIN",
  [THIRD_PARTY_TYPES.DMM_LOGIN] = "DMM_LOGIN",
  [THIRD_PARTY_TYPES.ALIPAY] = "ANT_AUTH",
  [THIRD_PARTY_TYPES.TAOBAO] = "TAOBAO_AUTH",
  [THIRD_PARTY_TYPES.HUAWEI_AUTH] = "HARMONY_ACCOUNT",
  [THIRD_PARTY_TYPES.TAP_LOGIN] = "TAP_UPDATE",
  [THIRD_PARTY_TYPES.PHONE_AUTH] = "PHONE_AUTH"
}
local usercenter_url_base
local cache_user_info = {}
local M = {}
M.USER_CENTER_ERROR_CODES = {
  ERR_AGST_ROLE_BIND_CONFLICT = 2001000,
  ERR_TOKEN_INVALID = 4001101,
  ERR_TOKEN_EXPIRED = 4001102,
  ERR_THIRD_PART_TOKEN_FAILED = 4001103,
  ERR_ACCOUNT_TOKEN_INVALID = 5001033,
  ERR_SERVER_THIRD_PART = 5000004,
  ERR_ACCOUNT_NEED_MIGRATED = 4002007,
  ERR_NEED_CHALLENGE = 5000014,
  ERR_CHALLENGE_FAIL = 5000015
}
M.ACCOUNT_SCENE = {
  DEFAULT = "default",
  STRICT_LIMIT = "strict_limit"
}

local function init_usercenter_url(cb)
  E.LOG.debug(TAG, "init_usercenter_url begin")
  if E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) then
    local current_cdn_config = EGC.get_current_cdn_config()
    if current_cdn_config then
      E.LOG.debug(TAG, "init_usercenter_url find current cdn config")
      local temp_usercenter_url_base = current_cdn_config.account_center
      PROTOCOL.set_url_base_with_type(PROTOCOL.SERVICE_TYPE.ACCOUNT_CENTER, temp_usercenter_url_base)
      local temp_edge_server_url_base = current_cdn_config.edge_center
      PROTOCOL.set_url_base_with_type(PROTOCOL.SERVICE_TYPE.EDGE_CENTER, temp_edge_server_url_base)
      cb(true, temp_usercenter_url_base)
    else
      E.LOG.warn(TAG, "init_usercenter_url NOT find current cdn config")
      cb(false, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_CONFIG_INVALID, "not find current cdn config")
    end
  else
    local temp_usercenter_url_base = PROTOCOL.get_url(PROTOCOL.SERVICE.CONFIG_CHECK)
    cb(true, temp_usercenter_url_base)
  end
end

local function region_config_change_handle(new_region)
  init_usercenter_url(function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "region_config_change_handle new region:" .. (new_region or "nil") .. ", get usercenter url success!")
    else
      local code, msg = ...
      E.LOG.warn(TAG, "region_config_change_handle new_region:" .. (new_region or "nil" .. ", get usercenter url failed, code:" .. tostring(code) .. ", msg:" .. (msg or "nil")))
    end
  end)
end

local function get_risk_info(challengeInfo)
  local aegis_info = {}
  if challengeInfo then
    aegis_info.type = "auth"
    aegis_info.challengeData = challengeInfo
  else
    aegis_info.type = "check"
    local ACD = require("ejoysdk_lua.aegis.aegis_collect_data")
    local JSON = require("ejoysdk_lua.ejoysdk_json")
    local encrypt_data = ACD.get_encrypt_data()
    aegis_info.datagram = JSON.encode({w = encrypt_data})
  end
  return aegis_info
end

function M.request_system_config(cb)
  SC.init(nil, function(succ, ...)
    if succ then
      local si, config_time, config_data = ...
      E.LOG.d(TAG, {
        si = si or "nil"
      })
      E.LOG.d(TAG, {
        configtime = config_time or "nil"
      })
      E.LOG.d(TAG, {
        config_data = config_data or "nil"
      })
      if nil == si or nil == config_time or nil == config_data then
        E.LOG.warn(TAG, "usercenter_system_config_check failed, data is empty:")
        cb(false, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_SYSTEM_CONFIG_DATA_EMPTY, "system config response data is empty")
      else
        PROTOCOL.set_si(si)
        cb(true)
      end
    else
      local code, msg = ...
      E.LOG.warn(TAG, "usercenter_system_config_check failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, ...)
    end
  end)
end

function M.init_si()
  local si = SC.get_si()
  PROTOCOL.set_si(si)
  E.LOG.debug(TAG, "init_si last_si:" .. tostring(si))
end

function M.init(cb)
  M.init_si()
  init_usercenter_url(function(succ, ...)
    if succ then
      usercenter_url_base = (...)
      E.LOG.debug(TAG, "init usercenter url >> " .. tostring(usercenter_url_base))
      if not usercenter_url_base or "" == usercenter_url_base then
        cb(false, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_GET_URL_BASE_FAILED, "get usercenter url failed")
      else
        E.LOG.debug(TAG, "init start request for system config")
        M.request_system_config(function(_succ, ...)
          if _succ then
            ET.publish(ET.user_center.USER_CENTER_INIT_SUCCESS, {first_launch = is_first_launch})
          end
          cb(_succ, ...)
        end)
      end
    else
      cb(false, ...)
    end
  end)
  ET.subscribe(ET.config.CONFIG_CHANGED .. "_" .. E.CONFIG.KEY.REGION, region_config_change_handle)
end

local function get_third_party_type_by_name(vendor_name)
  if not vendor_name or "" == vendor_name then
    E.LOG.warn(TAG, "bind >> NOT find third party name for vendor is empty")
    return nil
  end
  return VENDOR_NAME_MAP[vendor_name]
end

function M.get_third_party_type_by_vendor(vendor_name)
  do return get_third_party_type_by_name end
  return get_third_party_type_by_name, vendor_name
end

function M.get_vendor_by_third_party_type(third_party_type)
  if not third_party_type or "" == third_party_type then
    E.LOG.warn(TAG, "NOT find vendor for third party name >> " .. tostring(third_party_type))
    return nil
  end
  return THIRD_PARTY_TYPE_MAP[third_party_type]
end

local function update_current_region_user_cache(user_data)
  local region = E.CONFIG.get_config(E.CONFIG.KEY.REGION) or "default-region"
  if region then
    cache_user_info[region] = user_data or {}
    E.LOG.debug(TAG, "update_current_region_user_cache succ, region:" .. tostring(region))
  else
    E.LOG.warn(TAG, "update_current_region_user_cache failed, region is nil")
  end
end

local function get_current_region_user_cache()
  local region = E.CONFIG.get_config(E.CONFIG.KEY.REGION) or "default-region"
  local result_data = {}
  if region then
    result_data = cache_user_info[region] or {}
    E.LOG.debug(TAG, "get_current_region_user_cache succ, region:" .. tostring(region))
  else
    E.LOG.warn(TAG, "get_current_region_user_cache failed, region is nil")
  end
  return result_data
end

local function clear_user_cache()
  cache_user_info = {}
end

function M.usercenter_login_succ(user_data)
  if user_data then
    update_current_region_user_cache(user_data)
    M.set_limit_data_usage(user_data.limitDataUsage == true or false)
  end
end

function M.login(vendor_name, third_party_token, agst_token, guest_policy, challenge_info, ext, cb)
  E.LOG.debug(TAG, "login begin， vendor_name = " .. tostring(vendor_name))
  ext = ext or {}
  local ucenter_login_span = ATracer.start_login_sub_span(ATracer.ACCOUNT_FLOWS_SPANS.UCENTER_LOGIN)
  
  local function callback_wrapper(succ, ...)
    local tags = {
      ...
    }
    ATracer.finish_login_sub_span(ucenter_login_span, tags)
    if cb then
      cb(succ, ...)
    end
  end
  
  local third_party_type = get_third_party_type_by_name(vendor_name)
  if not third_party_type or "" == third_party_type then
    E.LOG.warn(TAG, "login >> NOT find third party name for vendor is empty")
    callback_wrapper(false, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_INVALID_PARAMETER, "vendor name is empty")
    return
  end
  local migrate_token = ""
  local account_os
  if not UTILS.STR.is_empty(ext.migrate_token) then
    migrate_token = ext.migrate_token
  elseif not UTILS.STR.is_empty(ext.account_os) then
    account_os = ext.account_os
  end
  local risk = get_risk_info(challenge_info)
  if third_party_type then
    E.LOG.debug(TAG, "login >> find third party name:" .. tostring(third_party_type) .. ", vendor_name:" .. tostring(vendor_name))
    API.usercenter_login(third_party_type, third_party_token, agst_token, migrate_token, guest_policy, risk, account_os, function(succ, ...)
      if succ then
        E.LOG.debug(TAG, "login usercenter_login succ")
        local user_data = (...)
        M.usercenter_login_succ(user_data or {})
        callback_wrapper(succ, user_data)
      else
        E.LOG.warn(TAG, "login usercenter_login failed")
        local code, msg, data = ...
        if code == M.USER_CENTER_ERROR_CODES.ERR_ACCOUNT_NEED_MIGRATED then
          callback_wrapper(false, code, msg, migrate_token)
        else
          callback_wrapper(false, code, msg, data)
        end
      end
    end)
  else
    E.LOG.warn(TAG, "login >> NOT find third party name with vendor:" .. tostring(vendor_name))
    callback_wrapper(false, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_INVALID_PARAMETER, "vendor name not recognized, vendor name:" .. tostring(vendor_name))
  end
end

function M.logout()
  E.LOG.debug(TAG, "usercenter logout")
  clear_user_cache()
end

function M.user_info()
  local current_region_user_info = get_current_region_user_cache()
  do return UTILS.deepcopy end
  return UTILS.deepcopy, current_region_user_info
end

function M.async_user_info(cb)
  if cb then
    cb(M.user_info())
  end
end

function M.bind(agst_token, vendor_name, third_party_token, cb)
  local third_party_type = get_third_party_type_by_name(vendor_name)
  if not third_party_type or "" == third_party_type then
    E.LOG.warn(TAG, "login >> NOT find third party name for vendor is empty")
    cb(false, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_INVALID_PARAMETER, "vendor name is empty")
    return
  end
  local current_region_user_info = get_current_region_user_cache()
  local usercenter_token = current_region_user_info.token or ""
  if "" == usercenter_token then
    E.LOG.debug(TAG, "bind with usercenter_token nil, its outside game bind")
  else
    E.LOG.debug(TAG, "bind with usercenter_token nil, its inside game bind")
  end
  API.usercenter_bind(usercenter_token, agst_token, third_party_type, third_party_token, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "bind success")
      local user_data = (...)
      update_current_region_user_cache(user_data)
      cb(succ, user_data)
    else
      E.LOG.warn(TAG, "bind failed")
      cb(false, ...)
    end
  end)
end

function M.get_bind_info(cb)
  E.LOG.debug(TAG, "get_bind_info begin")
  local current_region_user_info = get_current_region_user_cache()
  local usercenter_token = current_region_user_info.token or ""
  if "" == usercenter_token then
    E.LOG.debug(TAG, "get_bind_info failed, usercenter_token is empty! for current region")
    cb(false, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_TOKEN_INVALID, "token is nil")
    return
  end
  API.usercenter_bind_list(usercenter_token, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "usercenter_bind_list succ")
      local data = (...)
      local bind_list = {}
      if data and data.bindList then
        for _, v in pairs(data.bindList) do
          if v.thirdPartyType then
            local vendor_name = THIRD_PARTY_TYPE_MAP[v.thirdPartyType]
            if vendor_name then
              v.vendorName = vendor_name
              bind_list[vendor_name] = v
            else
              E.LOG.warn(TAG, "thirdPartyType not recognized:" .. tostring(v.thirdPartyType))
            end
          else
            E.LOG.warn(TAG, "thirdPartyType is nil:")
          end
        end
      end
      cb(true, bind_list)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "usercenter_bind_list failed, code:" .. tostring(code) .. ", msg:" .. (msg or "nil"))
      cb(false, code, msg)
    end
  end)
end

function M.get_si()
  return SC.get_si() or ""
end

function M.set_limit_data_usage(enable)
  local OVERSEA_APPLOG = require("ejoysdk_lua.vendors.oversea_applog")
  OVERSEA_APPLOG.set_limit_data_usage(enable)
end

return M
