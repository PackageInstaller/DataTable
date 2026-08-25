local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local AGST = require("ejoysdk_lua.vendors.agst_account")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local AEGIS_DATA = require("ejoysdk_lua.aegis.aegis_collect_data")
local HISTORY = require("ejoysdk_lua.account.official_history")
local EM = require("ejoysdk_lua.ejoysdk_module")
local AUTO_LOGIN = require("ejoysdk_lua.vendors.auto_login")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local LANGUtil = require("ejoysdk_lua.lang.util")
local EG
local TAG = EM.MODULE.VENDORS.OFFICIAL
local RES_GAME_LOGIN = "${brand}_usercenter"
local VENDOR_NAME = "OFFICIAL"
local OFFICIAL = Vendor:Inherit(VENDOR_NAME)
local LAST_LOGIN_SUCC_VENDOR = E.SPKeyStore:New("com.ejoy.sdk.lua", "LAST_LOGIN_SUCC_VENDOR")
local HTTP = E.HTTP
local URL_CONFIG = {
  host = "qookkagames.com",
  url_base_airline_center = "https://ww-hk-account.qookkagames.com",
  url_base_account_center = "https://ww-hk-id-api.qookkagames.com",
  airline_info = {brand = "qookka", node = "hk"},
  API = {
    login = "m#/start",
    quick_login = "m#/quick",
    user_center = "m#/account",
    real_name = "m#/realname",
    login_intercept = "m#/intercept",
    user_detail_completion = "m#/account/completion?from=sdk",
    recharge_limit_err_tips = "#/tips/recharge-jp",
    recharge_limit_user_info = "#/real-name/jp",
    recharge_limit_update_user_info = "client/sdk.edit.userInfo.by.token"
  }
}

local function update_airline_url()
  local gangplank_config = EGC.get_current_cdn_config()
  if not gangplank_config then
    return
  end
  URL_CONFIG.url_base_airline_center = gangplank_config.airline_center or URL_CONFIG.url_base_airline_center
  URL_CONFIG.url_base_account_center = gangplank_config.account_center or URL_CONFIG.url_base_account_center
  URL_CONFIG.host = E.HTTP.parse(URL_CONFIG.url_base_airline_center).host
  URL_CONFIG.airline_info = gangplank_config.ext and gangplank_config.ext.airline_info or URL_CONFIG.airline_info
  RES_GAME_LOGIN = string.gsub(RES_GAME_LOGIN, "${brand}", URL_CONFIG.airline_info.brand)
end

function OFFICIAL.get_api_url(api)
  local realapi = URL_CONFIG.API[api]
  local api_url = HTTP.uri_join(URL_CONFIG.url_base_airline_center, realapi or api)
  return api_url
end

function OFFICIAL.get_account_center_api_url(api)
  local realapi = URL_CONFIG.API[api]
  local api_url = HTTP.uri_join(URL_CONFIG.url_base_account_center, realapi or api)
  return api_url
end

local pay_inited = false
local logining_vendor_name

local function update_userinfo(vendor, user_info)
  if user_info and VENDOR_NAME == user_info.with and vendor and string.len(vendor) > 0 then
    E.LOG.debug(TAG, "update user info, and vendor is " .. tostring(vendor))
    AUTO_LOGIN.set_last_login(vendor)
    LAST_LOGIN_SUCC_VENDOR:set(vendor)
    local login_vendor = EV.get(vendor)
    if login_vendor and login_vendor.need_sdk_login and login_vendor.need_sdk_login() then
      E.LOG.debug(TAG, tostring(vendor) .. " need sdk login, do not save history")
      HISTORY.delete(user_info.uid)
    else
      HISTORY.update(user_info)
    end
  end
end

local function auth_handler(user_info)
  E.LOG.debug(TAG, "official auth_handler-----")
  E.log(user_info)
  if user_info and VENDOR_NAME == user_info.with and logining_vendor_name and string.len(logining_vendor_name) > 0 then
    update_userinfo(user_info.platform or logining_vendor_name, user_info)
  end
end

local function acquire_handler(user_info)
  E.LOG.debug(TAG, "official acquire_handler -----")
  E.log(user_info)
  if user_info and VENDOR_NAME == user_info.with and logining_vendor_name and string.len(logining_vendor_name) > 0 then
    update_userinfo(user_info.platform or logining_vendor_name, user_info)
    logining_vendor_name = nil
  end
end

local function login_handler(_user_info)
  E.LOG.debug(TAG, "gangplank login_handler -----")
  if pay_inited then
    return
  end
  EG.product_infos_base(VENDOR_NAME, function(succ, infos)
    if succ then
      E.LOG.debug(TAG, "获取 OFFICIAL product info success >>")
      ET.publish("purchase_inited", VENDOR_NAME, infos)
      E.LOG.debug(TAG, {infos = infos})
      pay_inited = true
    else
      local status = infos
      E.LOG.warn(TAG, "获取 OFFICIAL product info failure: " .. tostring(status))
    end
  end)
end

local function check_login_res()
  ET.unsubscribe(ET.gangplank.GLOBAL_CDN_CONFIG_SUCC, check_login_res)
  update_airline_url()
end

local preload_login_webview_if_needed
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
    local url = OFFICIAL.get_login_url()
    local local_url = LIGHTBOAT.get_url_from_cache(url)
    E.WebView.remove_cache(url)
    E.WebView.remove_cache(local_url)
  end
end

local function logout_handler()
  E.LOG.d(TAG, "logout invoke, preload now")
  preload_login_webview_if_needed(false)
end

function OFFICIAL.init(opt, cb)
  OFFICIAL.opt = opt
  HISTORY.init(history_update_listener)
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_handler)
  ET.subscribe(ET.gangplank.USER_INFO_UPDATE, acquire_handler)
  ET.subscribe(ET.gangplank.AUTH_SUCC, auth_handler)
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, logout_handler)
  ET.subscribe(ET.analytics.REGISTER, function(user_info)
    ESTAT.stat_action("register_result", logining_vendor_name, true, {
      trace_id = user_info.uid
    })
  end)
  ET.subscribe(ET.ACCOUNT.LOGIN_NEED_PRELOAD, function()
    E.LOG.d(TAG, "acquire failed, preload now")
    preload_login_webview_if_needed(false)
  end)
  last_game_lang = E.CONFIG.get_config("lang")
  ET.subscribe(ET.config.CONFIG_CHANGED .. "_" .. "lang", lang_config_change_callback)
  E.LOG.debug(TAG, "official init begin")
  if EGC.get_global_cdn_config() then
    E.LOG.debug(TAG, "official init has cdn config")
    check_login_res()
  else
    E.LOG.debug(TAG, "official init wait for cdn config")
    ET.subscribe(ET.gangplank.GLOBAL_CDN_CONFIG_SUCC, check_login_res)
  end
  preload_login_webview_if_needed(true)
  cb(true)
end

function OFFICIAL.get_login_url()
  local api = "login"
  local url = OFFICIAL.get_api_url(api)
  local official_history = require("ejoysdk_lua.account.official_history")
  if next(official_history.get_list()) then
    api = "quick_login"
    url = OFFICIAL.get_api_url(api)
  end
  local airline_brand = URL_CONFIG.airline_info.brand
  local airline_node = URL_CONFIG.airline_info.node
  local append_params = "?"
  if string.find(url, "?") then
    append_params = "&"
  end
  append_params = append_params .. "airlineType=" .. airline_brand
  append_params = append_params .. "&" .. "serverNode=" .. airline_node
  url = E.Utils.string_insert(url, append_params, string.find(url, "#"))
  return url
end

local function login_manual(ext, option, cb)
  local host = URL_CONFIG.host
  local url = OFFICIAL.get_login_url()
  local fallback = {url = url, host = host}
  local preferred = UTILS.deepcopy(fallback)
  E.LOG.debug(TAG, "prefered url: " .. tostring(preferred.url) .. ",fallback url: " .. tostring(fallback.url))
  local OL = require("ejoysdk_lua.overseas.login")
  OL.login_with_h5({preferred = preferred, fallback = fallback}, ext, option, cb)
end

function OFFICIAL.login(ext, cb)
  update_airline_url()
  logining_vendor_name = nil
  local official_login_span = ATracer.start_login_sub_span(ATracer.ACCOUNT_FLOWS_SPANS.OFFICIAL_LOGIN)
  
  local function login_callback(result)
    local account_data = (result.ext or {}).account_data or {}
    if account_data.loginPolicy and 1 == account_data.loginPolicy then
      E.LOG.debug(TAG, "此时属于账号扫码登录方式，用户授权时选择了登录仅单次有效，不能保存到登录历史")
      E.LOG.debug(TAG, "此时也不能把扫码记录为上次登录的插件名")
    else
      logining_vendor_name = result and result.platform
    end
    if result and result:is_succ() then
      result.platform = VENDOR_NAME
    end
    E.LOG.debug(TAG, "login_callback---called, result = ")
    E.LOG.debug(TAG, result)
    ATracer.finish_login_sub_span(official_login_span, result)
    cb(result)
  end
  
  local x7sy = require("ejoysdk_lua.vendors.x7sy")
  if x7sy.check_if_support_vendor("X7SY") then
    E.LOG.debug(TAG, "start x7sy login")
    local AL = require("ejoysdk_lua.account.service.account_login")
    AL.login("X7SY", {}, function(login_result)
      E.LOG.debug(TAG, "x7sy login callback")
      E.log(login_result)
      login_callback(login_result)
    end)
    return
  end
  AUTO_LOGIN.login(function(result)
    E.LOG.debug(TAG, "自动登录结果 result = ")
    E.LOG.debug(TAG, result)
    if result and result:is_succ() then
      login_callback(result)
    else
      if result and result.silent_login then
        login_callback(result)
        return
      end
      E.LOG.debug(TAG, "自动登录尝试失败，切换回手动登录---")
      login_manual(ext, {}, login_callback)
    end
  end)
end

function preload_login_webview_if_needed(refresh)
  if not E.support_webview() then
    E.LOG.debug(TAG, "preload_login_webview_if_needed called, but do not support_webview, return now.")
    return
  end
  update_airline_url()
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

function OFFICIAL.open_webview_with_url(url, js_cb, close_cb, extra_data)
  update_airline_url()
  local gangplank_user_info = EG.user_info()
  local usercenter_user_info = USER.user_info()
  local host_now = E.HTTP.parse(url).host
  local host_data = {
    startupData = {
      area = E.CONFIG.get_config("district"),
      language = E.CONFIG.get_config("lang"):lower(),
      publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA) or "",
      pkg_info = E.get_pkg_info(),
      ejoy_token = gangplank_user_info.token,
      uc_token = usercenter_user_info.token,
      aegis_data = AEGIS_DATA.get_encrypt_data(),
      extra_data = extra_data
    },
    transparent = true
  }
  local injection = {
    [URL_CONFIG.host] = host_data
  }
  if host_now ~= URL_CONFIG.host then
    injection = {
      [URL_CONFIG.host] = host_data,
      [host_now] = host_data
    }
  end
  local root_host = UTILS.STR.get_root_host_from_host(host_now)
  if root_host and type(root_host) == "string" then
    if root_host:sub(1, 1):lower() ~= "." then
      root_host = "." .. root_host
    end
    E.LOG.debug(TAG, {host_now = host_now, root_host = root_host})
    if not injection[root_host] then
      E.LOG.debug(TAG, "解析下根域名，插入这个根域名同样的数据到injection，可以避免旧收银台跳转新收银台时，缺少transparent的问题")
      injection[root_host] = host_data
    end
  end
  E.WebView.open(url, injection, {
    compactMode = true,
    use_fragment = true,
    hide_close_btn = false
  }, function(_values)
    if js_cb then
      js_cb(_values.args)
    end
  end, function(_values)
    if close_cb then
      close_cb(_values.args)
    end
  end)
end

local function open_webview(api, js_cb, close_cb, extra_data)
  update_airline_url()
  local url = OFFICIAL.get_api_url(api)
  OFFICIAL.open_webview_with_url(url, js_cb, close_cb, extra_data)
end

function OFFICIAL.open_webview(api, js_cb, close_cb, extra_data)
  open_webview(api, js_cb, close_cb, extra_data)
end

function OFFICIAL.open_user_center(_screen_orientation, _options, close_cb)
  open_webview("user_center", nil, function()
    E.LOG.debug(TAG, "user_center closed")
    if close_cb then
      close_cb()
    end
  end)
end

function OFFICIAL.open_userinfo_completion(cb)
  local result = false
  open_webview("user_detail_completion", function(_args)
    if cb and _args.type == "update_user_info" then
      result = _args.result or false
    end
  end, function()
    if cb then
      cb(result)
    end
  end)
end

function OFFICIAL.merge_info(info, pinfo)
  do return OFFICIAL.merge_helper, info end
  return OFFICIAL.merge_helper, info, pinfo
end

function OFFICIAL.simple_token()
  return false
end

function OFFICIAL.check_token(_outsource, _info)
  OFFICIAL.login()
end

function OFFICIAL.logout()
  E.WebView.close()
  local last_vendor = AUTO_LOGIN.get_last_login()
  AUTO_LOGIN.clear_last_login()
  local channel_vendor = EV.get(last_vendor)
  if channel_vendor then
    channel_vendor.logout()
  else
    OFFICIAL.opt.logout_listener({})
  end
end

function OFFICIAL.use_user_center()
  return true
end

function OFFICIAL.can_show_user_center()
  if _ejoysdk.os() == "android" then
    local login_vendor = AUTO_LOGIN.get_last_login()
    E.LOG.debug(TAG, "get_last_login:" .. tostring(login_vendor))
    local vendor = EV.get(login_vendor)
    if vendor and type(vendor.can_show_user_center) == "function" then
      E.LOG.debug(TAG, "vendor.can_show_user_center")
      do return end
      return vendor.can_show_user_center, TAG, "vendor.can_show_user_center", login_vendor
    end
  end
  return true
end

OFFICIAL:is_implemented({"ACCOUNT"})

local function proxy_logout_listener(_vendor_name, logout_listener, proxy)
  return function(ext_params)
    if proxy.bind_logout_listener then
      E.LOG.debug(TAG, "proxy_logout_listener call bind_logout_listener")
      proxy.bind_logout_listener(ext_params)
      proxy.bind_logout_listener = nil
    else
      E.LOG.debug(TAG, "proxy_logout_listener call logout_listener")
      logout_listener(ext_params)
    end
  end
end

local function make_vendor_proxy(vendor_name, vendor)
  vendor = vendor or EV.get(vendor_name)
  if vendor then
    local proxy = vendor:Inherit(vendor_name .. "_PROXY")
    E.LOG.debug(TAG, "------make " .. vendor_name .. " official proxy-------")
    proxy.vendor_name = vendor_name
    
    function proxy.init(opt, cb)
      if opt.auth_listener then
        proxy.proxy_old_auth_listener = opt.auth_listener
      end
      if opt.logout_listener then
        opt.logout_listener = proxy_logout_listener(vendor_name, opt.logout_listener, proxy)
      end
      opt.proxy = proxy
      vendor.init(opt, cb)
    end
    
    proxy.login_fail_intercept_times = 0
    
    function proxy.login_fail(status, last_login_params, fail_cb)
      last_login_params = last_login_params or {}
      local stat_params = {
        outsource = last_login_params.outsource or {},
        info = last_login_params.info or {}
      }
      ESTAT.stat_action("login_result", vendor_name, false, stat_params)
      if proxy.login_fail_intercept_times > 1 then
        proxy.login_fail_intercept_times = 0
        return false
      end
      if vendor.login_fail then
        local result = vendor.login_fail(status, last_login_params, fail_cb)
        if result then
          proxy.login_fail_intercept_times = proxy.login_fail_intercept_times + 1
          E.LOG.debug(TAG, "proxy.login_fail_intercept_times: " .. tostring(proxy.login_fail_intercept_times))
        end
        return result
      else
        return false
      end
    end
    
    function proxy.logout()
      E.LOG.debug(TAG, "make_vendor_proxy receive logout, vendor_name:" .. tostring(vendor_name))
      USER.logout()
      ESTAT.stat_action("logout", vendor_name)
      vendor.logout()
    end
    
    function proxy.login(ext, channel_login_cb)
      proxy.proxy_login_type = "login"
      ESTAT.stat_action("login", vendor_name)
      ext = ext or {}
      ext.vendor = vendor_name
      local proxy_login_span = ATracer.start_login_sub_span(ATracer.ACCOUNT_FLOWS_SPANS.OFFICIAL_PROXY_LOGIN, {vendor = vendor_name})
      vendor.login(ext, function(channel_result)
        ATracer.finish_login_sub_span(proxy_login_span, channel_result)
        channel_login_cb(channel_result)
        if channel_result:is_succ() then
          proxy.login_fail_intercept_times = 0
        end
      end)
    end
    
    function proxy.bind(bind_listener)
      proxy.proxy_login_type = "bind"
      proxy.proxy_bind_listener = bind_listener
      ESTAT.stat_action("bind", vendor_name)
      vendor.login({vendor = vendor_name})
    end
    
    function proxy.bind_logout(cb)
      proxy.bind_logout_listener = cb
      vendor.logout({vendor = vendor_name})
    end
    
    function proxy.use_user_center()
      return true
    end
    
    function proxy.is_support_ability(_self, abilities)
      for _, ability in ipairs(abilities) do
        local l = Vendor.get_methods(ability)
        for _, v in ipairs(l) do
          local result = rawget(vendor, v)
          if not result then
            return false
          end
        end
      end
      return true
    end
    
    return proxy
  end
  return nil
end

local proxies = {
  FB = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "FB"
  end,
  APPLE = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "APPLE"
  end,
  APPLE_LOGIN = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "APPLE_LOGIN"
  end,
  APPLE_LOGIN_H5 = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "APPLE_LOGIN_H5"
  end,
  GOOGLE = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "GOOGLE"
  end,
  GOOGLE_PLAY = function()
    do return make_vendor_proxy, "GOOGLE_PLAY", EV.get("GOOGLE") end
    return make_vendor_proxy, "GOOGLE_PLAY", EV.get("GOOGLE")
  end,
  AGST = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, AGST.VENDOR_NAME
  end,
  AIRLINE = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "AIRLINE"
  end,
  TWITTER_LOGIN = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "TWITTER_LOGIN"
  end,
  HW_LOGIN = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "HW_LOGIN"
  end,
  LINE = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "LINE"
  end,
  CITA_LOGIN = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "CITA_LOGIN"
  end,
  ST_LOGIN = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "ST_LOGIN"
  end,
  PGA_LOGIN = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "PGA_LOGIN"
  end,
  QR_LOGIN = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "QR_LOGIN"
  end,
  DMM_LOGIN = function()
    do return make_vendor_proxy end
    return make_vendor_proxy, "DMM_LOGIN"
  end,
  OFFICIAL = function()
    do return make_vendor_proxy, "OFFICIAL" end
    return make_vendor_proxy, "OFFICIAL", OFFICIAL
  end
}

function OFFICIAL.get_umbrella_vendors(vendors)
  EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local out = {}
  for name, _ in pairs(vendors) do
    if proxies[name] then
      out[name] = proxies[name]()
    end
  end
  return out
end

function OFFICIAL.exit()
  if _ejoysdk.os() == "windows" then
    if not E.is_support_ejoy_style_alert() then
      E.LOG.debug(TAG, "now is old ejoysdk version, can not show lingxi style alert")
      OFFICIAL.opt.exit_listener(true)
      return
    end
    E.LOG.debug(TAG, "now is new ejoysdk version, can show lingxi style alert, so show user the alert.")
  end
  local title = LANGUtil.getString("exit_alert_title", "Exit Confirmation")
  local param = {
    message = LANGUtil.getString("exit_alert_content", "Are you sure you want to quit the game?"),
    buttons = {
      LANGUtil.getString("exit_alert_ensure", "Quit now"),
      LANGUtil.getString("exit_alert_cancel", "Keep Playing")
    }
  }
  E.Modal.open(title, param, function(answer)
    E.LOG.debug(TAG, "on exit callback >> " .. tostring(answer))
    if 0 == answer then
      OFFICIAL.opt.exit_listener(true)
    else
      OFFICIAL.opt.exit_listener(false)
    end
  end)
end

return OFFICIAL
