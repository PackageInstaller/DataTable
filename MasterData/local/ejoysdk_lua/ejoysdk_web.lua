local EM = require("ejoysdk_lua.ejoysdk_module")
local WC = require("ejoysdk_lua.ejoysdk_web_config")
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "web"
local WEBVIEW_CLOSE_EVENT_ID = 0
local MAX_ID = 10000000
local M = {}

local function gen_webview_close_event_id()
  WEBVIEW_CLOSE_EVENT_ID = (WEBVIEW_CLOSE_EVENT_ID + 1) % MAX_ID
  return "web_close_event_id_" .. WEBVIEW_CLOSE_EVENT_ID
end

local preload_jsargs_cache = {}

local function webview_insert_cache_callback(url, callback)
  if url and "" ~= url then
    local cb_list = {}
    if nil ~= preload_jsargs_cache[url] then
      cb_list = preload_jsargs_cache[url]
    else
      preload_jsargs_cache[url] = cb_list
    end
    table.insert(cb_list, callback)
  end
end

function M.webview_remove_cache_callback(url)
  local E = require("ejoysdk_lua.ejoysdk")
  local ET = require("ejoysdk_lua.ejoysdk_topic")
  url = url or ""
  E.LOG.debug(TAG, "clear cache with url:" .. url)
  local cb_list = preload_jsargs_cache[url] or {}
  for _, cb in ipairs(cb_list) do
    ET.unsubscribe("webview_jsargs", cb)
  end
end

function M.webview_callback_helper(url, option, on_js_callback, on_close_callback)
  local E = require("ejoysdk_lua.ejoysdk")
  local ET = require("ejoysdk_lua.ejoysdk_topic")
  option = option or {}
  local close_event_data = gen_webview_close_event_id()
  if not option.closeEventData or option.closeEventData == "" then
    option.closeEventData = close_event_data
  else
    close_event_data = option.closeEventData
  end
  E.LOG.debug(TAG, "subscribe_js_event url:" .. url .. ", close_event_data:" .. close_event_data)
  
  local function local_on_js_callback(_value)
    local args = _value.args
    if args and args.type then
      E.LOG.debug(TAG, "local_on_js_callback received, type:" .. tostring(args.type) .. ", callback >>")
    end
    local cbid = _value.cbid or nil
    if cbid then
      function _value.callback(message, ext)
        E.WebView.callback_js(cbid, message, ext)
      end
    end
    if on_js_callback then
      E.LOG.debug(TAG, "local_on_js_callback, on_js_callback not nil, now callback >>")
      on_js_callback(_value)
    else
      E.LOG.warn(TAG, "local_on_js_callback, on_js_callback is nil, NOT callback >>")
    end
  end
  
  local function local_webview_close_callback(_value)
    _ejoysdk.log(TAG .. "#webview_close_callback, receive close event")
    if _value and _value.args == close_event_data then
      E.LOG.debug(TAG, "receive close event for id:" .. close_event_data)
      if on_close_callback then
        E.LOG.debug(TAG, "local_webview_close_callback, now callback on_close_callback")
        on_close_callback(_value)
      else
        E.LOG.warn(TAG, "local_webview_close_callback, on_close_callback is nil, NOT callback >>")
      end
      ET.unsubscribe("webview_close", local_webview_close_callback)
      ET.unsubscribe("webview_jsargs", local_on_js_callback)
    end
  end
  
  if option.preload == true then
    webview_insert_cache_callback(url, local_on_js_callback)
  else
    ET.subscribe("webview_close", local_webview_close_callback)
  end
  ET.subscribe("webview_jsargs", local_on_js_callback)
end

function M.handle_hide_event()
end

local function fill_webview_startup_data(data)
  local E = require("ejoysdk_lua.ejoysdk")
  local EJ_SIGN = require("ejoysdk_lua.libs.signature")
  data.pkg_info = E.get_pkg_info()
  local EH = require("ejoysdk_lua.ejoysdk_holo")
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local tokens = {}
  tokens.ejoy_token = EG.user_info().token or ""
  tokens.ptoken = EG.user_info().ptoken or ""
  tokens.player_token = EH.get_player_token() or ""
  tokens.player_token_secret = EJ_SIGN.get_secret(tokens.player_token) or ""
  tokens.signature_versions = EJ_SIGN.get_server_signature_versions(tokens.player_token)
  data.tokens = tokens
  return data
end

function M.get_startup_data(data)
  do return fill_webview_startup_data end
  return fill_webview_startup_data, data
end

function M.open_webview(url, hosts, params, _screen_orientation, on_js_callback, on_close_callback)
  local options = {screen_orientation = _screen_orientation}
  M.open_webview_with_options(url, hosts, params, options, on_js_callback, on_close_callback)
end

local function fill_default_options(_options)
  _options = _options or {}
  if _options.compactMode == nil then
    _options.compactMode = true
  end
  if _options.compactMode and nil == _options.transparent then
    _options.transparent = true
  end
  if nil == _options.use_fragment then
    _options.use_fragment = true
  end
  if nil == _options.closeEventData then
    local closeEventData = gen_webview_close_event_id()
    _options.closeEventData = closeEventData
  end
  if nil == _options.use_cutout then
    _options.use_cutout = false
  end
  return _options
end

function M.get_fill_default_options(data)
  do return fill_default_options end
  return fill_default_options, data
end

function M.to_webview_open_params(hosts, params, options)
  local E = require("ejoysdk_lua.ejoysdk")
  local _params = params or {}
  local local_start_up_data = {init_params = _params}
  local_start_up_data = fill_webview_startup_data(local_start_up_data)
  E.LOG.debug(TAG, "startupData>>")
  E.log(local_start_up_data)
  local all_hosts = WC.merge_hosts(hosts)
  E.LOG.debug(TAG, "all_hosts>>")
  E.log(all_hosts)
  options = fill_default_options(options)
  E.LOG.debug(TAG, "options >>")
  E.log(options)
  local injection = {}
  for _, host in ipairs(all_hosts) do
    injection[host] = {
      startupData = local_start_up_data,
      transparent = options.transparent
    }
  end
  return injection, options
end

function M.open_webview_with_options(url, hosts, params, options, on_js_callback, on_close_callback)
  local E = require("ejoysdk_lua.ejoysdk")
  if not url or "" == url then
    E.LOG.warn(TAG, "open_webview failed, url is null")
    return
  end
  local injection
  injection, options = M.to_webview_open_params(hosts, params, options)
  E.LOG.debug(TAG, "open_webview begin, url:" .. url .. ", closeEventData:" .. options.closeEventData)
  E.WebView.open(url, injection, options, on_js_callback, on_close_callback)
end

local function get_common_startup_data(options)
  local E = require("ejoysdk_lua.ejoysdk")
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local USERCENTER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
  local usercenter_user_info = USERCENTER.user_info() or {}
  if not usercenter_user_info.st then
    local user_info = EG.user_info()
    local st = user_info and user_info.ext and user_info.ext.channel_info and user_info.ext.channel_info.serviceTicket
    usercenter_user_info.st = st
  end
  local res = {
    pkg_info = E.get_pkg_info() or {},
    user_info = EG.user_info() or {},
    player_info = EG.player_info() or {},
    usercenter_user_info = usercenter_user_info,
    support_luacall = options and options.support_luacall == true or false
  }
  return res
end

function M.add_injection_host(new_host)
  WC.add_injection_host(new_host)
end

function M.add_injection_hosts(hosts)
  WC.add_injection_hosts(hosts)
end

function M.remove_inject_host(remove_host)
  WC.remove_inject_host(remove_host)
end

function M.fill_injection_with_common_params(injection, options)
  injection = injection or {}
  local white_hosts = WC.white_hosts()
  for _, host in ipairs(white_hosts) do
    injection[host] = injection[host] or {}
  end
  local common_startup_data = get_common_startup_data(options)
  local token_data = fill_webview_startup_data({})
  local E = require("ejoysdk_lua.ejoysdk")
  local is_support_webview_preload = E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.SUPPORT_WEBVIEW_PRELOAD)
  for _host, sub_injection in pairs(injection) do
    sub_injection.startupData = sub_injection.startupData or {}
    if not is_support_webview_preload then
      sub_injection.startupData.common_params = common_startup_data
      sub_injection.startupData.tokens = (token_data or {}).tokens
    end
  end
  if E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.SUPPORT_WEBVIEW_PRELOAD) then
    injection.host_common_data = {
      common_params = common_startup_data,
      tokens = (token_data or {}).tokens
    }
  end
end

function M.capture_webview(callback)
  local E = require("ejoysdk_lua.ejoysdk")
  E.WebView.capture(callback)
end

return M
