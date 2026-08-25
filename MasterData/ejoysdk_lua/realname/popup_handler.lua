local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local DS_PROTOCOL = require("ejoysdk_lua.protocol.aligames_protocol")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local REALNAME_INFO = require("ejoysdk_lua.realname.realname_info")
local TAG = "popup_handler#"
local ANDROID_ALI_PKG_NAME = "com.eg.android." .. "Ali" .. "p" .. "a" .. "y" .. "Gphone"
local M = {}

local function webview_js_callback(_value)
  E.LOG.debug(TAG, "webview_js_callback received>>")
  local args = _value.args or {}
  E.LOG.debug(TAG, args)
end

local function webview_close_callback(_value)
  E.LOG.debug(TAG, "webview_close_callback received>>")
  local args = _value.args or {}
  E.LOG.debug(TAG, args)
end

function M.show_webview(url, wv_option, startup_data, js_callback, close_callback)
  local white_host_list = {
    ".ejoy.com",
    "30.103.73.187",
    ".uc.cn",
    ".aligames.com",
    ".9game.cn",
    ".alibaba-inc.com",
    ".hepinggames.com",
    ".lingxigames.com",
    ".qookkagames.com",
    ".sialiagames.com.tw",
    ".sialiagamesinc.com.tw",
    ".suixiagames.com",
    ".vntth.com"
  }
  local CONFIG = require("ejoysdk_lua.airline_v2.airline_v2_config")
  local new_white_hosts = CONFIG.get_white_hosts()
  white_host_list = UTILS.merge_array(white_host_list, new_white_hosts)
  local host = {}
  local host_now = E.HTTP.parse(url).host
  local root_host = UTILS.STR.get_root_host_from_host(host_now)
  if root_host and type(root_host) == "string" then
    if root_host:sub(1, 1):lower() ~= "." then
      root_host = "." .. root_host
    end
    E.LOG.debug(TAG, {host_now = host_now, root_host = root_host})
    host[root_host] = {transparent = true, startupData = startup_data}
  end
  for _, hostname in ipairs(white_host_list) do
    host[hostname] = {transparent = true, startupData = startup_data}
  end
  wv_option = wv_option or {}
  E.WebView.open(url, host, {
    compactMode = true,
    use_cutout = true,
    screen_orientation = wv_option.screen_orientation,
    closeEventData = wv_option.close_event_data,
    use_fragment = wv_option.use_fragment or true,
    hide_close_btn = wv_option.hide_close_btn or false,
    disable_backkey_press = wv_option.disable_backkey_press or false
  })
  local js_callback_wrap, close_callback_wrap
  
  function js_callback_wrap(value)
    if value and value.args and value.args.chl then
      local chl = value.args.chl
      if type(chl) == "string" and "biz_stat" == chl then
        E.LOG.debug(TAG, "receive stat js event, do nothing")
        return
      end
    end
    webview_js_callback(value)
    js_callback(value)
  end
  
  function close_callback_wrap(value)
    E.LOG.debug(TAG, {
      close_callback_wrap_args = value.args
    })
    if value and value.args == wv_option.close_event_data then
      ET.unsubscribe("webview_close", close_callback_wrap)
      ET.unsubscribe("webview_jsargs", js_callback_wrap)
      webview_close_callback(value)
      close_callback(value)
    end
  end
  
  ET.subscribe("webview_close", close_callback_wrap)
  ET.subscribe("webview_jsargs", js_callback_wrap)
end

local function is_current_vendor_lingxi()
  local v_aligames = require("ejoysdk_lua.vendors.aligames")
  local is_for_lingxi = v_aligames.is_for_lingxi()
  if is_for_lingxi then
    E.LOG.debug(TAG, "is_current_vendor_lingxi: current IS for lingxi vendor")
  else
    E.LOG.debug(TAG, "is_current_vendor_lingxi: current is NOT for lingxi vendor")
  end
  return is_for_lingxi
end

function M.get_cas_client_info()
  local cas_client_info_str = ""
  local pkg_info = E.get_pkg_info()
  cas_client_info_str = cas_client_info_str .. "machine:" .. pkg_info.model .. "`"
  cas_client_info_str = cas_client_info_str .. "app_name:" .. E.Sysinfo.app_name() .. "`"
  cas_client_info_str = cas_client_info_str .. "os:" .. E.Sysinfo.os() .. "`"
  cas_client_info_str = cas_client_info_str .. "game_id:" .. pkg_info.game_id .. "`"
  cas_client_info_str = cas_client_info_str .. "utdid:" .. pkg_info.utdid .. "`"
  if E.Sysinfo.os() == "android" then
    cas_client_info_str = cas_client_info_str .. "imei:" .. pkg_info.imei .. "`"
    cas_client_info_str = cas_client_info_str .. "client_identity:" .. "lxandroid" .. "`"
  elseif E.Sysinfo.os() == "ios" then
    cas_client_info_str = cas_client_info_str .. "idfa:" .. E.Sysinfo.idfa() .. "`"
    cas_client_info_str = cas_client_info_str .. "client_identity:" .. "lxios" .. "`"
  elseif E.Sysinfo.os() == "windows" then
    cas_client_info_str = cas_client_info_str .. "idfa:" .. E.Sysinfo.idfa() .. "`"
    cas_client_info_str = cas_client_info_str .. "client_identity:" .. "lxwindows" .. "`"
  end
  return cas_client_info_str
end

function M.append_sdk_query_params(url, need_cas, params)
  local combinded_params = params or {}
  combinded_params.sdk_type = 2
  combinded_params.ver = "2.0"
  local is_support_ali_auth = false
  if is_current_vendor_lingxi() then
    E.LOG.debug(TAG, "append_sdk_query_params current is lingxi channel, now check if support ali auth")
    local v_aligames = require("ejoysdk_lua.vendors.aligames")
    is_support_ali_auth = v_aligames.is_support_ali_auth()
  end
  local is_support_key = "is_support_al" .. "ip" .. "ay_auth"
  combinded_params[is_support_key] = is_support_ali_auth
  if is_support_ali_auth then
    E.LOG.debug(TAG, "append_sdk_query_params is_support_ali_auth: true")
  else
    E.LOG.debug(TAG, "append_sdk_query_params is_support_ali_auth: false")
  end
  local os = E.Sysinfo.os()
  if "android" == os then
    combinded_params.client_id = DS_PROTOCOL.APPID.FOR_LX_ANROID
  elseif "ios" == os then
    combinded_params.client_id = DS_PROTOCOL.APPID.FOR_LX_IOS
  end
  if need_cas then
    local sdk_type = "ali" .. "p" .. "a" .. "y" .. "sdk_type"
    local is_installed = "is_" .. "ali" .. "p" .. "a" .. "y" .. "_installed"
    if "android" == os then
      combinded_params[sdk_type] = "full"
      combinded_params[is_installed] = E.Sysinfo.is_app_install(ANDROID_ALI_PKG_NAME)
    elseif "ios" == os then
      combinded_params[sdk_type] = "pure"
      local ali_bundle_name = "ali" .. "p" .. "a" .. "y:"
      combinded_params[is_installed] = E.Sysinfo.is_app_install(ali_bundle_name)
    end
    local disable_ali_key = "ej_disable_ali" .. "p" .. "a" .. "y_auth"
    local disable_ali_auth = UTILS.STR.get_query_parameter(url, disable_ali_key)
    if not disable_ali_auth or "false" == disable_ali_auth then
      E.LOG.debug(TAG, "NOT has ej_disable_ali_auth or is false, so check ali available")
      local v_aligames = require("ejoysdk_lua.vendors.aligames")
      combinded_params.is_support_ali_auth = v_aligames.is_support_ali_auth()
      if combinded_params.is_support_ali_auth and combinded_params[is_installed] then
        combinded_params.realname_type = "ali" .. "p" .. "a" .. "y" .. "_auth"
      else
        combinded_params.realname_type = "id_number"
      end
    else
      E.LOG.debug(TAG, "has ej_disable_ali_auth, so hide realname type")
      combinded_params.realname_type = "id_number"
    end
    combinded_params.client_info = M.get_cas_client_info()
  end
  local realname_ex = REALNAME_INFO.get_realname_ex()
  if realname_ex and next(realname_ex) ~= nil then
    for k, v in pairs(realname_ex) do
      combinded_params[k] = v
    end
  end
  do return UTILS.STR.append_query_params, url end
  return UTILS.STR.append_query_params, url, combinded_params, pairs(realname_ex)
end

return M
