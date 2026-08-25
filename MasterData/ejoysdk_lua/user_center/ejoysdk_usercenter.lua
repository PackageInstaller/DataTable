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
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
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
  DYMINICLOUDGAME = THIRD_PARTY_TYPES.DOUYIN_MINI,
  WXMINICLOUDGAME = THIRD_PARTY_TYPES.WEIXIN_MINI,
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
local UC_STAT = {
  OAUTH = {
    SDK_LOGIN = "ingame_login",
    LOGIN = "oauth_login",
    WAITING = "waiting_oauthlogin",
    START = "start_oauthlogin",
    CANCEL = "oauthlogin_cancel",
    FAIL = "oauthlogin_fail",
    SUCCESS = "oauthlogin_success",
    GET_AUTH_CODE = "get_auth_code"
  }
}
local usercenter_url_base
local cache_user_info = {}
local cache_auth_request = {}
local M = {}
M.USER_CENTER_ERROR_CODES = {
  ERR_AGST_ROLE_BIND_CONFLICT = 2001000,
  ERR_TOKEN_INVALID = 4001101,
  ERR_TOKEN_EXPIRED = 4001102,
  ERR_THIRD_PART_TOKEN_FAILED = 4001103,
  ERR_VALIDATE_LOGIN_AUTH_CODE_FAILED = 4001113,
  ERR_REDIRECTURL_CODE_FAILED = 4001114,
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

local current_auth_session_id, acquire_handler

function M.try_validate_login_auth_code(auth_code, redirect_uri, log_data)
  E.LOG.debug(TAG, "try_validate_login_auth_code")
  if current_auth_session_id then
    local last_log_data = {session_id = current_auth_session_id, is_duplicate = true}
    current_auth_session_id = nil
    E.Loading.dismiss()
    ET.unsubscribe(ET.gangplank.ACQUIRE, acquire_handler)
    acquire_handler = nil
    E.LOG.debug(TAG, "duplicate login auth code, cancel last one")
    ESTAT.sdk_login_pfcomm({
      biz_mod = UC_STAT.OAUTH.SDK_LOGIN,
      biz_func = UC_STAT.OAUTH.LOGIN,
      biz_act = UC_STAT.OAUTH.CANCEL,
      biz_st = "fail",
      biz_co = tostring(CONSTANTS.OFFICIAL_ERR_CODES.CODE_OAUTH_LOGIN_CANCEL),
      biz_params = last_log_data
    })
  end
  local uuid = require("ejoysdk_lua.ejoysdk_uuid")
  current_auth_session_id = uuid()
  if log_data then
    log_data.session_id = current_auth_session_id
  end
  local current_user_info = M.user_info()
  local is_logged_in = current_user_info and current_user_info.token and current_user_info.token ~= ""
  cache_auth_request = {
    auth_code = auth_code,
    redirect_uri = redirect_uri,
    log_data = log_data
  }
  if not is_logged_in then
    E.Timer.once(600, function()
      if acquire_handler then
        ET.unsubscribe(ET.gangplank.ACQUIRE, acquire_handler)
        acquire_handler = nil
        E.LOG.debug(TAG, "login later and timeout in 10 minutes")
      end
    end)
    
    function acquire_handler(_user_info)
      if acquire_handler then
        ET.unsubscribe(ET.gangplank.ACQUIRE, acquire_handler)
        acquire_handler = nil
        E.LOG.debug(TAG, "acquire_handler and process_login_auth_code:" .. tostring(current_auth_session_id))
        M.process_login_auth_code(cache_auth_request.auth_code, cache_auth_request.redirect_uri, cache_auth_request.log_data)
      end
    end
    
    ET.subscribe(ET.gangplank.ACQUIRE, acquire_handler)
    ESTAT.sdk_login_pfcomm({
      biz_mod = UC_STAT.OAUTH.SDK_LOGIN,
      biz_func = UC_STAT.OAUTH.LOGIN,
      biz_act = UC_STAT.OAUTH.WAITING,
      biz_st = "succ",
      biz_co = "200",
      biz_params = log_data
    })
  else
    E.LOG.debug(TAG, "logined and process_login_auth_code:" .. tostring(current_auth_session_id))
    M.process_login_auth_code(auth_code, redirect_uri, log_data)
  end
end

function M.process_login_auth_code(auth_code, redirect_uri, log_data)
  local Lang = require("ejoysdk_lua.lang.util")
  if E.Loading.is_support_custom() then
    local login_auth_title = Lang.getString("login_auth_title", "Authorizing login...")
    local login_auth_cancel_button_title = Lang.getString("cancel", "Cancel")
    local loading_options = {title = login_auth_title, cancel_button_title = login_auth_cancel_button_title}
    E.Loading.show(loading_options, function(ret)
      if ret and type(ret) == "table" and -1 == ret.value then
        if current_auth_session_id then
          current_auth_session_id = nil
          ESTAT.sdk_login_pfcomm({
            biz_mod = UC_STAT.OAUTH.SDK_LOGIN,
            biz_func = UC_STAT.OAUTH.LOGIN,
            biz_act = UC_STAT.OAUTH.CANCEL,
            biz_st = "fail",
            biz_co = tostring(CONSTANTS.OFFICIAL_ERR_CODES.CODE_OAUTH_LOGIN_CANCEL),
            biz_params = log_data
          })
        end
        local login_auth_failed_old_version = Lang.getString("login_auth_failed_cancel", "Login canceled.")
        E.Toast.show(login_auth_failed_old_version)
        E.Timer.once(2, function()
          E.Toast.hide()
        end)
      end
    end)
  else
    E.Loading.show()
    E.Timer.once(10, function()
      if current_auth_session_id then
        current_auth_session_id = nil
        E.Loading.dismiss()
        local login_auth_failed_old_version = Lang.getString("login_auth_failed_old_version", "Please try updating the game version.")
        E.Toast.show(login_auth_failed_old_version)
        E.Timer.once(3, function()
          E.Toast.hide()
        end)
      end
    end)
  end
  ESTAT.sdk_login_pfcomm({
    biz_mod = UC_STAT.OAUTH.SDK_LOGIN,
    biz_func = UC_STAT.OAUTH.LOGIN,
    biz_act = UC_STAT.OAUTH.START,
    biz_st = "succ",
    biz_co = "200",
    biz_params = log_data
  })
  local current_user_info = M.user_info()
  local token = current_user_info and current_user_info.token or ""
  local GDP = require("ejoysdk_lua.gangplank_data_provider")
  local player_info = GDP.PLAYER_INFO.get()
  local user_info = GDP.USER_INFO.get()
  local game_data = {
    player_id = player_info and player_info.player_id,
    player_name = player_info and player_info.player_name,
    server_id = player_info and player_info.server_id,
    account_id = user_info and user_info.uid
  }
  E.Timer.once(2, function()
    if nil == current_auth_session_id then
      E.LOG.debug(TAG, "user_center_validate_login_auth_code maybe cancel and ignore")
      return
    end
    API.user_center_validate_login_auth_code(token, auth_code, redirect_uri, game_data, function(succ, ...)
      if nil == current_auth_session_id then
        E.LOG.debug(TAG, "user_center_validate_login_auth_code ignore")
        return
      end
      E.Loading.dismiss()
      E.LOG.debug(TAG, "user_center_validate_login_auth_code finish:" .. tostring(current_auth_session_id))
      current_auth_session_id = nil
      if succ then
        local ret_data = (...)
        if redirect_uri and "" ~= redirect_uri and ret_data and ret_data.authCode then
          E.LOG.debug(TAG, "user_center_validate_login_auth_code redirect_uri:" .. tostring(redirect_uri))
          local final_redirect_url = E.HTTP.decode_uri(redirect_uri)
          local server_auth_code = ret_data and ret_data.authCode
          local final_redirect_url_info = E.HTTP.parse(final_redirect_url)
          E.log(final_redirect_url_info)
          if final_redirect_url_info and final_redirect_url_info.query then
            final_redirect_url_info.query.game_auth_code = server_auth_code
            local query_str = E.HTTP.urlencode(final_redirect_url_info.query)
            local fragment = final_redirect_url_info.fragment and "#" .. final_redirect_url_info.fragment or ""
            local rebuilt_url = table.concat({
              final_redirect_url_info.scheme or "",
              "://",
              final_redirect_url_info.host or "",
              final_redirect_url_info.path or "",
              "?",
              query_str or "",
              fragment
            })
            E.LOG.debug(TAG, "rebuilt_url:" .. tostring(rebuilt_url))
            E.Sysinfo.open_url(rebuilt_url)
          else
            E.Sysinfo.open_url(final_redirect_url)
          end
          ESTAT.sdk_login_pfcomm({
            biz_mod = UC_STAT.OAUTH.SDK_LOGIN,
            biz_func = UC_STAT.OAUTH.LOGIN,
            biz_act = UC_STAT.OAUTH.SUCCESS,
            biz_st = "succ",
            biz_co = "200",
            biz_params = log_data
          })
        else
          E.LOG.debug(TAG, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_INVALID_PARAMETER, "redirect_uri or auth_code is nil")
          ESTAT.sdk_login_pfcomm({
            biz_mod = UC_STAT.OAUTH.SDK_LOGIN,
            biz_func = UC_STAT.OAUTH.LOGIN,
            biz_act = UC_STAT.OAUTH.FAIL,
            biz_st = "fail",
            biz_co = tostring(CONSTANTS.USER_CENTER_ERROR_CODES.CODE_INVALID_PARAMETER),
            biz_params = log_data
          })
        end
      else
        local code, _error_msg = ...
        local final_error_msg = Lang.getString("login_auth_failed_code_timeout", "Login timed out. Please try logging in again.")
        E.LOG.debug(TAG, final_error_msg .. "(" .. tostring(code) .. "," .. tostring(_error_msg) .. ")")
        if log_data then
          log_data.msg = _error_msg
        end
        ESTAT.sdk_login_pfcomm({
          biz_mod = UC_STAT.OAUTH.SDK_LOGIN,
          biz_func = UC_STAT.OAUTH.LOGIN,
          biz_act = UC_STAT.OAUTH.FAIL,
          biz_st = "fail",
          biz_co = tostring(code),
          biz_params = log_data
        })
        E.Toast.show(final_error_msg .. "(" .. tostring(code) .. ")")
        E.Timer.once(3, function()
          E.Toast.hide()
        end)
      end
    end)
  end)
end

function M.get_login_auth_code(redirect_uri, cb)
  E.Loading.show()
  E.Timer.once(10, function()
    E.Loading.dismiss()
  end)
  ESTAT.sdk_login_pfcomm({
    biz_mod = UC_STAT.OAUTH.SDK_LOGIN,
    biz_func = UC_STAT.OAUTH.GET_AUTH_CODE,
    biz_act = UC_STAT.OAUTH.START,
    biz_st = "succ",
    biz_co = "200",
    biz_params = {redirect_uri = redirect_uri}
  })
  local current_user_info = M.user_info()
  local token = current_user_info and current_user_info.token or ""
  local GDP = require("ejoysdk_lua.gangplank_data_provider")
  local player_info = GDP.PLAYER_INFO.get()
  local user_info = GDP.USER_INFO.get()
  local game_data = {
    player_id = player_info and player_info.player_id,
    player_name = player_info and player_info.player_name,
    server_id = player_info and player_info.server_id,
    account_id = user_info and user_info.uid
  }
  API.user_center_get_login_auth_code(token, redirect_uri, game_data, function(succ, ...)
    E.Loading.dismiss()
    E.LOG.debug(TAG, "user_center_get_login_auth_code finish:" .. tostring(succ))
    if succ then
      local ret_data = (...)
      if ret_data and ret_data.authCode then
        local auth_code = ret_data.authCode
        E.LOG.debug(TAG, "user_center_get_login_auth_code redirect_uri:" .. tostring(redirect_uri))
        E.LOG.debug(TAG, "user_center_get_login_auth_code auth_code:" .. tostring(auth_code))
        cb(succ, auth_code)
        ESTAT.sdk_login_pfcomm({
          biz_mod = UC_STAT.OAUTH.SDK_LOGIN,
          biz_func = UC_STAT.OAUTH.GET_AUTH_CODE,
          biz_act = UC_STAT.OAUTH.SUCCESS,
          biz_st = "succ",
          biz_co = "200",
          biz_params = {redirect_uri = redirect_uri, auth_code = auth_code}
        })
      else
        E.LOG.debug(TAG, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_INVALID_PARAMETER, "redirect_uri or auth_code is nil")
        cb(false, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_INVALID_PARAMETER, "redirect_uri or auth_code is nil")
        ESTAT.sdk_login_pfcomm({
          biz_mod = UC_STAT.OAUTH.SDK_LOGIN,
          biz_func = UC_STAT.OAUTH.GET_AUTH_CODE,
          biz_act = UC_STAT.OAUTH.FAIL,
          biz_st = "fail",
          biz_co = tostring(CONSTANTS.USER_CENTER_ERROR_CODES.CODE_INVALID_PARAMETER),
          biz_params = {redirect_uri = redirect_uri}
        })
      end
    else
      local code, _error_msg = ...
      ESTAT.sdk_login_pfcomm({
        biz_mod = UC_STAT.OAUTH.SDK_LOGIN,
        biz_func = UC_STAT.OAUTH.GET_AUTH_CODE,
        biz_act = UC_STAT.OAUTH.FAIL,
        biz_st = "fail",
        biz_co = tostring(code),
        biz_params = {code = code, msg = _error_msg}
      })
      cb(false, code, _error_msg)
    end
  end)
end

local function on_auth_handler(link_type, url_data)
  if "url" == link_type then
    if url_data.url then
      local url_info = E.HTTP.parse(url_data.url)
      if url_info and url_info.query and url_info.query.auth_code and url_info.query.sdk_type == "auth" then
        local redirect_uri = url_info.query.redirect_uri
        local auth_code = url_info.query.auth_code
        M.try_validate_login_auth_code(auth_code, redirect_uri, {
          ref = url_info.query.ref,
          url = url_data.url
        })
      end
    end
  elseif "universal_link" == link_type then
    local data = url_data and url_data.data
    E.log(data)
    if data and type(data) == "table" and data.sdk_type == "auth" and data.auth_code then
      local redirect_uri = data.redirect_uri
      local auth_code = data.auth_code
      M.try_validate_login_auth_code(auth_code, redirect_uri, {
        ref = data.ref,
        url = data.url
      })
    end
  end
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

local did_init_auth_login = false

function M.config_auth_login_listener()
  if did_init_auth_login then
    return
  end
  did_init_auth_login = true
  ET.subscribe("urlopen_v2", on_auth_handler)
  local array_data = E.get_url_open_datas()
  for _, data in pairs(array_data or {}) do
    if data.type and data.type == "handleOpenUniversalLink" then
      if data.data and type(data.data) == "table" and data.data.sdk_type == "auth" and data.data.auth_code then
        local redirect_uri = data.data.redirect_uri
        local auth_code = data.data.auth_code
        M.try_validate_login_auth_code(auth_code, redirect_uri, {
          ref = data.data.ref,
          url = data.data.url
        })
        break
      end
    elseif data.type and data.type == "handleOpenUrl" then
      local url_info = E.HTTP.parse(data.url)
      if url_info and url_info.query and url_info.query.auth_code and "auth" == url_info.query.sdk_type then
        local redirect_uri = url_info.query.redirect_uri
        local auth_code = url_info.query.auth_code
        M.try_validate_login_auth_code(auth_code, redirect_uri, {
          ref = url_info.query.ref,
          url = data.url
        })
        break
      end
    end
  end
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
  M.config_auth_login_listener()
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
