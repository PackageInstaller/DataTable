local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local HISTORY = require("ejoysdk_lua.account.official_history")
local AIRLINE_V2_CONFIG = require("ejoysdk_lua.airline_v2.airline_v2_config")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ANT = require("ejoysdk_lua.vendors.ant")
local TAOBAO = require("ejoysdk_lua.vendors.taobao")
local TAP = require("ejoysdk_lua.vendors.taptap")
local WEIXIN = require("ejoysdk_lua.vendors.weixin")
local DOUYIN = require("ejoysdk_lua.vendors.douyin")
local APPLE = require("ejoysdk_lua.vendors.apple")
local OPPO = require("ejoysdk_lua.vendors.oppo")
local XIAOMI = require("ejoysdk_lua.vendors.xiaomi")
local PHONE_AUTH = require("ejoysdk_lua.vendors.ali_datapkg")
local HARMONY_ACCOUNT = require("ejoysdk_lua.vendors.harmony_account")
local EQL = require("ejoysdk_lua.ejoysdk_qualitylog")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ATRacer = require("ejoysdk_lua.account.account_tracer")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local LOGIN_API = require("ejoysdk_lua.account.api.login")
local AUTO_LOGIN = require("ejoysdk_lua.vendors.auto_login")
local EC = require("ejoysdk_lua.user_center.system_config")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local ACCOUNT_UPGRADE = require("ejoysdk_lua.account.account_upgrade_helper")
local LANG_UTIL = require("ejoysdk_lua.lang.util")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local SC = require("ejoysdk_lua.user_center.system_config")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local ULM = require("ejoysdk_lua.account.union_login_manager")
local VENDOR_NAME = "AIRLINE_V2"
local TAG = EM.MODULE.VENDORS.AIRLINE_V2
local M = Vendor:Inherit(VENDOR_NAME)
local H5_UI_VERSION = "v2_0"
local ASYNC_LOAD_DB_ACCOUNTS = "ASYNC_LOAD_DB_ACCOUNTS"
local ASYNC_AUTO_LOGIN_ACCOUNT = "ASYNC_AUTO_LOGIN_ACCOUNT"
local STAT_LOAD_HISTORY_STATUS = E.LazyKeyStore:New("STAT_LOAD_HISTORY_STATUS", false, false, false)
local logout_listener, exit_listener, login_span
local URL_CONFIG = {
  h5_url_base = "https://accounts.lingxigames.com",
  api_url_base = "https://account-api.lingxigames.com",
  url_query = "?ver=1.0&df=json&cver=" .. E.get_pkg_info().versions.lua_version .. "&os=" .. E.get_pkg_info().os,
  API = {
    auto_login = "account.loginWithServiceTicket",
    login = "m#/start",
    quick_login = "m#/quick",
    account = "m/account#/",
    phone_auth = "m#/sign/phoneAuth",
    login_intercept = "m#/intercept",
    harmony_auth = "m#/harmonyAuthTips",
    account_bind = "m#/bindThirdParty"
  }
}

function M.channel_id()
  return 998233
end

local function has_history_account()
  local list = HISTORY.get_list()
  E.LOG.debug(TAG, "airline history")
  E.LOG.debug(TAG, list)
  if list and next(list) ~= nil then
    return true
  end
  return false
end

function M.get_api_url(api)
  local realapi = URL_CONFIG.API[api]
  local api_url = E.HTTP.uri_join(URL_CONFIG.h5_url_base, H5_UI_VERSION, realapi or api)
  return api_url
end

local function update_userinfo(login_result)
  E.LOG.debug(TAG, "update_userinfo")
  if login_result and login_result:is_succ() then
    E.LOG.debug(TAG, {login_result = login_result})
    local account_data = (login_result.ext or {}).account_data or {}
    local channel_result = (login_result.ext or {}).channel_result or {}
    local user_info = {
      platform = channel_result.platform,
      uid = login_result.uid,
      account = (account_data or {}).thirdPartyInfo or {}.nickname,
      ptoken = login_result.token,
      st = account_data.st,
      account_os = account_data.accountOs or "",
      thirdparty_type = login_result.platform
    }
    E.LOG.debug(TAG, {user_info = user_info})
    local login_vendor_name = USER.get_vendor_by_third_party_type(user_info.thirdparty_type)
    local login_vendor = EV.get(login_vendor_name)
    if account_data.loginPolicy and 1 == account_data.loginPolicy then
      E.LOG.debug(TAG, "此时属于账号扫码登录方式，用户授权时选择了登录仅单次有效，不能保存到登录历史")
    elseif login_vendor and login_vendor.need_sdk_login and login_vendor.need_sdk_login() then
      E.LOG.debug(TAG, "登录的插件每次都需要走sdk登录，所以登录账号不存入到登录历史")
    else
      HISTORY.update(user_info)
    end
  else
    E.LOG.debug(TAG, "login result is not success")
  end
end

local function open_one_click_for_new_user()
  E.LOG.debug(TAG, "check open one click for new user")
  local login_config = UTILS.deepcopy(EC.get("login"))
  if login_config then
    E.log(login_config)
    for _, loginItem in ipairs(login_config) do
      if loginItem and loginItem.type and string.upper(loginItem.type) == PHONE_AUTH.AUTH_VENDOR_NAME and loginItem.oneClickConfig and loginItem.oneClickConfig.openOneClickForNewUser then
        E.LOG.d(TAG, "openOneClickForNewUser is open")
        return true
      end
    end
  end
  return false
end

local function support_phone_auth()
  local login_items = M.get_login_items()
  for _, item in ipairs(login_items) do
    if item and item.type and string.upper(item.type) == PHONE_AUTH.AUTH_VENDOR_NAME then
      return true
    end
  end
  E.LOG.d(TAG, "not support phone_auth")
  return false
end

local function get_all_white_hosts()
  local white_host_list = {
    ".ejoy.com",
    ".aligames.com",
    ".alibaba.net",
    ".hepinggames.com",
    ".lingxigames.com",
    ".suixiagames.com",
    ".putonggames.com"
  }
  local new_white_hosts = AIRLINE_V2_CONFIG.get_white_hosts()
  white_host_list = UTILS.merge_array(white_host_list, new_white_hosts)
  return white_host_list
end

local function open_webview(url, options, js_callback, close_callback, account_scene)
  local OL = require("ejoysdk_lua.overseas.login")
  local local_start_up_data = OL.get_startup_data(login_span)
  E.LOG.debug(TAG, "open_webview:" .. (url or "nil"))
  E.LOG.debug(TAG, local_start_up_data)
  if account_scene then
    local_start_up_data.account_scene = account_scene
  end
  local host = {}
  local local_startup_data = {startupData = local_start_up_data, transparent = true}
  local white_host_list = get_all_white_hosts()
  for _, new_host in pairs(white_host_list) do
    host[new_host] = local_startup_data
  end
  options = options or {}
  options.compactMode = true
  options.use_fragment = true
  options.hide_close_btn = true
  E.WebView.open(url, host, options, js_callback, close_callback)
end

function M.get_login_url(ext)
  local api = "login"
  if ext and ext.authorization_info then
    if _ejoysdk.os() == "harmonyos" then
      api = "harmony_auth"
    else
      api = "account_bind"
    end
  elseif has_history_account() then
    api = "quick_login"
  elseif support_phone_auth() and open_one_click_for_new_user() then
    api = "phone_auth"
  end
  local url = M.get_api_url(api)
  return url
end

local function handler_login_result_for_airline_v2(login_result, is_manual_login)
  local channel_result = login_result.ext and login_result.ext.channel_result
  if channel_result then
    local account_channel_id
    local thirdparty_type = channel_result.ext and channel_result.ext.thirdparty_type
    local account_data = (login_result.ext or {}).account_data or {}
    if thirdparty_type and "qr_login" == thirdparty_type and account_data and account_data.channelId then
      account_channel_id = account_data.channelId
      E.LOG.debug(TAG, "当前是账号扫码登录流程，优先读取扫码账号的渠道号，当做本次登录的渠道号")
      E.LOG.debug(TAG, {account_channel_id = account_channel_id})
    end
    channel_result.platform = tostring(account_channel_id or M.channel_id())
    if E.CONFIG.get_config(E.CONFIG.KEY.LINGXI_V2_SUPPORT) == true then
      channel_result.ext.origin_platform = nil
      channel_result.ext.thirdparty_type = nil
      channel_result.ext.account_os = nil
    end
  end
  if login_result.token and login_result.uid then
    local faceverify = require("ejoysdk_lua.vendors.faceverify")
    faceverify.update_lingxi_account_info(login_result.uid, login_result.token)
  end
  if is_manual_login then
    update_userinfo(login_result)
  end
end

local function login_manual(ext, option, callback)
  local url = M.get_login_url(ext)
  local is_preload = (option or {}).preload == true
  ESTAT.sdk_account_pfcomm({
    biz_mod = "login",
    biz_func = is_preload and "sdk.preload_page" or "sdk.open_login_page",
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200",
    biz_params = {url = url, is_preload = is_preload}
  })
  local host = E.HTTP.parse(url).host
  local white_host_list = get_all_white_hosts()
  local fallback = {url = url, host = host}
  local preferred = UTILS.deepcopy(fallback)
  E.LOG.debug(TAG, "prefered url: " .. tostring(preferred.url) .. ",fallback url: " .. tostring(fallback.url))
  local areaCodeList_config = UTILS.deepcopy(SC.get("areaCodeList"))
  E.LOG.debug(TAG, "print areaCodeList config")
  E.LOG.debug(TAG, {areaCodeList = areaCodeList_config})
  if areaCodeList_config then
    ext.areaCodeList = areaCodeList_config
  end
  local OL = require("ejoysdk_lua.overseas.login")
  OL.login_with_h5({
    preferred = preferred,
    fallback = fallback,
    white_host_list = white_host_list
  }, ext, option, function(login_result)
    if callback then
      if login_result:is_succ() then
        handler_login_result_for_airline_v2(login_result, true)
      end
      callback(login_result)
    end
  end)
  EQL.commit_action_main("al2_show_h5_login", url)
end

local function login_h5(login_type, pass_ext, cb)
  local vendor_name = string.upper(login_type)
  E.LOG.debug(TAG, "login to " .. vendor_name)
  local login_switch = {
    TAOBAO_AUTH = TAOBAO.login,
    ANT_AUTH = ANT.login,
    PHONE_AUTH = PHONE_AUTH.login,
    HUAWEI_AUTH = HARMONY_ACCOUNT.huawei_login,
    TAP_LOGIN = TAP.login,
    WEIXIN = WEIXIN.login,
    DOUYIN = DOUYIN.login,
    APPLE = APPLE.login,
    OPPO = OPPO.login,
    XIAOMI = XIAOMI.login
  }
  ;(login_switch[vendor_name] or function()
    E.LOG.debug(TAG, "not support " .. vendor_name)
    PROTOCOL.fail_callback(cb, -1, "not support")
  end)(pass_ext or {}, function(channel_result)
    if not channel_result then
      PROTOCOL.fail_callback(cb, CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_NO_LOGIN, "not login")
      E.LOG.debug(TAG, "channel login return empty result, return")
      return
    end
    if channel_result:is_succ() then
      local token = channel_result.token
      local ext = channel_result.ext or {}
      E.LOG.debug(TAG, "channel login succ, vendor_name >> " .. tostring(vendor_name) .. ", and token >> " .. tostring(token))
      E.LOG.debug(TAG, {ext = ext})
      PROTOCOL.succ_callback(cb, {token = token, ext = ext})
      EQL.commit_action_succ_main("al2_login_method_end", vendor_name)
      ESTAT.sdk_accountlogin_report({
        biz_act = "finish",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {login_type = vendor_name}
      })
    else
      local code = channel_result.code
      local message = channel_result.message
      local ext = channel_result.ext
      E.LOG.debug(TAG, "channel login fail, code >> " .. tostring(code) .. ", and message >> " .. tostring(message))
      PROTOCOL.fail_callback(cb, code, message, ext)
      EQL.commit_action_fail_main("al2_login_method_end", vendor_name, code, message)
      ESTAT.sdk_accountlogin_report({
        biz_act = "finish",
        biz_st = "fail",
        biz_co = "400",
        biz_params = {
          login_type = vendor_name,
          code = code,
          message = message
        }
      })
    end
  end)
  EQL.commit_action_main("al2_login_method_begin", vendor_name)
  ESTAT.sdk_accountlogin_report({
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200",
    biz_params = {login_type = vendor_name}
  })
end

function M.login(params, cb, _cb2)
  E.LOG.debug(TAG, "login start")
  EQL.commit_action_main("al2_login_invoke")
  login_span = ATRacer.start_login_sub_span(ATRacer.ACCOUNT_FLOWS_SPANS.AIRLINE_V2_LOGIN)
  
  local function cb_wrapper(...)
    ATRacer.finish_login_sub_span(login_span, ...)
    if cb then
      cb(...)
    end
  end
  
  if params and type(params) == "string" and #params > 0 then
    local login_type = params
    local pass_ext = cb
    cb = _cb2
    E.LOG.debug(TAG, "h5 login type >> " .. tostring(login_type))
    local stat_params = {
      login_params = params,
      stack = E.HTTP.encode_uri(debug.traceback())
    }
    ESTAT.stat_action("airline_v2_login_function", "", true, stat_params)
    login_h5(login_type, pass_ext, cb_wrapper)
  else
    E.LOG.d(TAG, "auto login")
    ESTAT.sdk_accountlogin_report({
      biz_act = "start",
      biz_st = "succ",
      biz_co = "200",
      biz_params = {login_type = "st_login"}
    })
    AUTO_LOGIN.login(function(login_result)
      if login_result and login_result:is_succ() then
        E.LOG.debug(TAG, "auto_login success, login_result = ")
        E.LOG.debug(TAG, login_result)
        handler_login_result_for_airline_v2(login_result)
        cb_wrapper(login_result)
        ESTAT.sdk_accountlogin_report({
          biz_act = "finish",
          biz_st = "succ",
          biz_co = "200",
          biz_params = {login_type = "st_login"}
        })
      elseif ULM.check_is_union_pkg() then
        E.LOG.d(TAG, "channel union login")
        ULM.union_login(function(union_login_result)
          E.LOG.debug(TAG, "union login result ")
          E.LOG.debug(TAG, union_login_result)
          update_userinfo(union_login_result)
          local channel_result = union_login_result.ext and union_login_result.ext.channel_result
          if channel_result then
            channel_result.platform = tostring(M.channel_id())
          end
          cb_wrapper(union_login_result)
        end)
      else
        ESTAT.sdk_accountlogin_report({
          biz_act = "finish",
          biz_st = "fail",
          biz_co = "400",
          biz_params = {login_type = "st_login", result = login_result}
        })
        E.LOG.debug(TAG, "auto_login fail, login_result = ")
        E.LOG.debug(TAG, login_result)
        if login_result and login_result.code == 4008017 then
          local authorization_info = {}
          if login_result.ext and login_result.ext.channel_result and login_result.ext.channel_result.token then
            authorization_info.token = login_result.ext.channel_result.token
            local thirdPartyLoginType = USER.get_third_party_type_by_vendor(login_result.ext.channel_result.platform)
            E.LOG.debug(TAG, "thirdPartyLoginType >> " .. tostring(thirdPartyLoginType))
            authorization_info.thirdPartyType = thirdPartyLoginType
          end
          E.LOG.debug(TAG, "need launch bind page, authorization_info = ")
          E.LOG.debug(TAG, authorization_info)
          params.authorization_info = authorization_info
        end
        if login_result and login_result.silent_login then
          if params.authorization_info then
            E.LOG.debug(TAG, "silent login to bind page")
          else
            cb_wrapper(login_result)
            return
          end
        end
        login_manual(params, {}, cb_wrapper)
      end
    end)
  end
end

function M.show_login_h5(params, _option, cb)
  login_manual(params, {}, cb)
end

function M.exec_login(cb)
  M.login(nil, function(login_result)
    if login_result and login_result:is_succ() then
      local token = login_result.token
      local brand = AIRLINE_V2_CONFIG.get_airline_brand()
      cb(true, token, brand)
    else
      cb(false)
    end
  end)
end

function M.exit()
  if _ejoysdk.os() == "windows" then
    if not E.is_support_ejoy_style_alert() then
      E.LOG.debug(TAG, "now is old ejoysdk version, can not show lingxi style alert")
      exit_listener(true)
      return
    end
    E.LOG.debug(TAG, "now is new ejoysdk version, can show lingxi style alert, so show user the alert.")
  end
  local title = LANG_UTIL.getStringSuitCNOverseas("exit_alert_title", "")
  local param = {
    message = LANG_UTIL.getStringSuitCNOverseas("exit_alert_content", ""),
    buttons = {
      LANG_UTIL.getStringSuitCNOverseas("exit_alert_ensure", ""),
      LANG_UTIL.getStringSuitCNOverseas("exit_alert_cancel", "")
    }
  }
  E.Modal.open(title, param, function(answer)
    E.LOG.debug(TAG, "on exit callback >> " .. tostring(answer))
    if 0 == answer then
      exit_listener(true)
    else
      exit_listener(false)
    end
  end)
end

local _has_history_update = false

local function history_update_listener(event, uid)
  if event == HISTORY.EVENT.ADD or event == HISTORY.EVENT.DELETE or event == HISTORY.EVENT.UPDATE then
    _has_history_update = true
  end
end

local last_game_lang

local function lang_config_change_callback(new_lang)
  E.LOG.debug(TAG, "lang_config_change_callback----, last_lang = " .. tostring(last_game_lang) .. ", new_lang = " .. tostring(new_lang))
  if new_lang ~= last_game_lang then
    last_game_lang = new_lang
    local LIGHTBOAT = require("ejoysdk_lua.res.lightboat.ejoysdk_lightboat")
    local url = M.get_login_url()
    local local_url = LIGHTBOAT.get_url_from_cache(url)
    E.WebView.remove_cache(url)
    E.WebView.remove_cache(local_url)
  end
end

local preload_login_webview_if_needed

local function logout_handler()
  E.LOG.d(TAG, "logout invoke, preload now")
  preload_login_webview_if_needed(false)
end

function M.init(opt, cb)
  logout_listener = opt.logout_listener
  exit_listener = opt.exit_listener
  E.LOG.debug(TAG, "init")
  HISTORY.init(history_update_listener)
  ET.subscribe(ET.gangplank.LOGOUT, logout_handler)
  ET.subscribe(ET.ACCOUNT.LOGIN_NEED_PRELOAD, function()
    E.LOG.d(TAG, "acquire failed, preload now")
    preload_login_webview_if_needed(false)
  end)
  last_game_lang = E.CONFIG.get_config("lang")
  ET.subscribe(ET.config.CONFIG_CHANGED .. "_" .. "lang", lang_config_change_callback)
  URL_CONFIG.api_url_base = AIRLINE_V2_CONFIG.get_airline_api_host() or URL_CONFIG.api_url_base
  E.LOG.debug(TAG, "api_url_base: " .. tostring(URL_CONFIG.api_url_base))
  URL_CONFIG.h5_url_base = AIRLINE_V2_CONFIG.get_airline_h5_url_host() or URL_CONFIG.h5_url_base
  E.LOG.debug(TAG, "h5_url_base: " .. tostring(URL_CONFIG.h5_url_base))
  local ac_center_host = AIRLINE_V2_CONFIG.get_airline_api_host()
  E.LOG.debug(TAG, "ac_center_host: " .. tostring(ac_center_host))
  local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
  DSP.update_ac_center_host(ac_center_host)
  if _ejoysdk.os() == "ios" or _ejoysdk.os() == "android" then
    M.try_load_db_accounts(function()
      preload_login_webview_if_needed(true)
    end)
  else
    preload_login_webview_if_needed(true)
  end
  if ULM.check_is_union_pkg() then
    ULM.init()
  end
  cb(true)
end

function preload_login_webview_if_needed(refresh)
  if not E.support_webview() then
    E.LOG.debug(TAG, "preload_login_webview_if_needed called, but do not support_webview, return now.")
    return
  end
  E.LOG.d(TAG, "using preload")
  local option = {
    preload = true,
    preload_keep_alive = true,
    preload_refresh = refresh
  }
  if true == _has_history_update then
    option.preload_refresh = true
    _has_history_update = false
  end
  login_manual({}, option)
end

function M.exec_logout(cb)
  E.LOG.debug(TAG, "logout start")
  if cb then
    cb(true, {})
  end
  logout_listener({})
end

function M.logout(cb)
  M.exec_logout(cb)
end

function M.show_user_center(_screen_orientation, _options, close_cb)
  local last_login_info = HISTORY.get_last_login_account()
  if last_login_info and type(last_login_info.thirdparty_type) == "string" and string.upper(last_login_info.thirdparty_type) == "QRCODE" then
    E.LOG.debug(TAG, "手机扫码登录的用户暂时不支持访问用户中心！！！！")
    if close_cb then
      close_cb()
    end
    return
  end
  E.LOG.debug(TAG, "开始访问水下品牌用户中心页面")
  local url = M.get_api_url("account")
  local account_scene
  if AUTO_LOGIN.is_silent_login() and AUTO_LOGIN.get_silent_login_vendor() == "WEGAME" then
    account_scene = USER.ACCOUNT_SCENE.STRICT_LIMIT
  end
  open_webview(url, nil, nil, function()
    E.LOG.debug(TAG, "user_center closed")
    if close_cb then
      close_cb()
    end
  end, account_scene)
end

M.open_user_center = M.show_user_center

function M.use_user_center()
  local ac_center_host = AIRLINE_V2_CONFIG.get_airline_api_host()
  if type(ac_center_host) == "string" and "" ~= ac_center_host then
    local host = E.HTTP.parse(ac_center_host).host
    if "magic-account-api.flysdk.cn" == host then
      return false
    end
  end
  return true
end

function M.get_config_from_center(_cb)
  PROTOCOL.succ_callback(_cb, {})
end

function M.try_load_db_accounts(cb)
  local loaded = STAT_LOAD_HISTORY_STATUS:get()
  E.LOG.debug(TAG, "db history loaded >> " .. tostring(loaded))
  if loaded then
    E.LOG.debug(TAG, "db history had loaded")
    cb()
    return
  end
  STAT_LOAD_HISTORY_STATUS:set(1)
  HISTORY.clear_history()
  AUTO_LOGIN.set_last_login("")
  UNI.async_call(VENDOR_NAME, ASYNC_LOAD_DB_ACCOUNTS, {}, nil, function(succ, data)
    if succ then
      E.LOG.debug(TAG, "load db account return >> ")
      E.LOG.debug(TAG, data)
      if data.result then
        local histories = data.result
        if type(data.result) == "string" then
          histories = JSON.decode(data.result)
        end
        local v2_accounts = ACCOUNT_UPGRADE.upgrade_accounts(histories)
        E.LOG.debug(TAG, "after upgrade_accounts return >> ")
        E.LOG.debug(TAG, {v2_accounts = v2_accounts})
        HISTORY.fill_lingxi_history(v2_accounts)
        M.try_load_auto_login_account()
      end
    end
    cb()
  end)
end

function M.try_load_auto_login_account()
  UNI.async_call(VENDOR_NAME, ASYNC_AUTO_LOGIN_ACCOUNT, {}, nil, function(succ, data)
    if succ then
      E.LOG.debug(TAG, "load last account return >> ")
      E.LOG.debug(TAG, data)
      if data.result then
        local account = data.result
        if type(data.result) == "string" then
          account = JSON.decode(data.result)
        end
        if type(account) == "table" then
          local v2_account = ACCOUNT_UPGRADE.upgrade_account(account)
          E.LOG.debug(TAG, "after upgrade last account return >> ")
          E.LOG.debug(TAG, v2_account)
          if v2_account and v2_account.st then
            AUTO_LOGIN.set_last_login("ST_LOGIN")
            local st_login = require("ejoysdk_lua.vendors.st_account")
            st_login.set_official_query({
              st = v2_account.st
            })
          end
        else
          E.LOG.debug(TAG, "auto account is nil")
        end
      end
    end
  end)
end

function M.get_ui_version()
  return H5_UI_VERSION
end

M.get_login_items = LOGIN_API.get_login_items
M.get_login_history = LOGIN_API.get_login_history
M.delete_history = LOGIN_API.delete_history
return M
