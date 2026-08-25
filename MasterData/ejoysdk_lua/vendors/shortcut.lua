local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EI = require("ejoysdk_lua.ejoysdk_init")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local VENDOR_NAME = "SHORTCUT"
local M = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.SHORTCUT
local inited
local SYNC_START_GAME = "SYNC_START_GAME"
local ASYNC_ADD_SHORTCUT = "ASYNC_ADD_SHORTCUT"
local SYNC_IS_SUPPORT_SHORTCUT = "SYNC_IS_SUPPORT_SHORTCUT"
local LUA_KEY_DIRECT_START_GAME_ACTIVITY = "direct_start_game_activity"
M.EVENT = {
  ON_RECEIVE_SHORTCUT_MESSAGE = "ON_RECEIVE_SHORTCUT_MESSAGE"
}
M.Type = {WebView = 1}
local INTERNAL_EVENT = {
  EVT_ON_SHORTCUT_OPEN = "EVT_ON_SHORTCUT_OPEN",
  EVT_ON_NOTIFICATION_OPEN = "EVT_ON_NOTIFICATION_OPEN"
}
M.KEY = {
  IOS_SHORTCUT_LINK = "shortcut_link",
  IOS_FULL_GEN_URL = "ios_full_gen_url"
}
local EVT_HANDLERS = {}
local is_gp_logined, _icon_open_handler

function M.set_icon_open_handler(cb)
  if nil == cb then
    function _icon_open_handler(_biz_type, _params)
    end
  end
  _icon_open_handler = cb
end

EVT_HANDLERS[INTERNAL_EVENT.EVT_ON_SHORTCUT_OPEN] = function(body)
  if body and type(body) == "table" then
    local EVS = require("ejoysdk_lua.vendors.shortcut")
    local SC = require("ejoysdk_lua.shortcut.ejoysdk_shortcut_webview")
    if body.page_type == EVS.Type.WebView and body.biz_type ~= nil then
      local _params = {}
      _params.from_source_data = {
        open_type = "shortcut_icon"
      }
      if body.biz_data and type(body.biz_data) == "string" then
        local JSON = require("ejoysdk_lua.ejoysdk_json")
        local biz_data = JSON.safe_decode(body.biz_data)
        if biz_data and type(biz_data) and nil ~= next(biz_data) then
          _params.from_source_data.biz_data = biz_data
        end
      end
      if not is_gp_logined then
        E.LOG.debug(TAG, "open_shortcut_webview ignore, need login")
        return
      end
      local EH = require("ejoysdk_lua.ejoysdk_holo")
      local pltoken = EH.get_player_token()
      if nil == pltoken then
        E.LOG.debug(TAG, "open_shortcut_webview ignore, need player login and get mtoken")
        return
      end
      local call_js_str = "window.luaNotify('" .. tostring(body.biz_type) .. "', 'shortcut_icon');"
      _params.from_source_data.call_js_script = call_js_str
      if E.WebView.is_opened() then
        E.LOG.debug(TAG, "webview is opening, not enable to open")
        if SC.is_opened_biz(body.biz_type) then
          SC.call_js(body.biz_type, call_js_str, false)
        end
        return
      end
      if _icon_open_handler then
        E.LOG.debug(TAG, "icon_open_handler, send params to game open")
        _icon_open_handler(body.biz_type, _params)
      else
        E.LOG.debug(TAG, "no icon_open_handler, sdk open")
        SC.open_shortcut_webview(body.biz_type, _params)
      end
    end
  end
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_ON_NOTIFICATION_OPEN] = function(body)
  if body and type(body) == "table" then
    local EVS = require("ejoysdk_lua.vendors.shortcut")
    local SC = require("ejoysdk_lua.shortcut.ejoysdk_shortcut_webview")
    if body.page_type == EVS.Type.WebView and body.biz_type ~= nil then
      local _params = {}
      _params.local_params = {from_source = "shortcut"}
      if body.biz_data and type(body.biz_data) == "string" then
        local JSON = require("ejoysdk_lua.ejoysdk_json")
        local biz_data = JSON.safe_decode(body.biz_data)
        if biz_data and type(biz_data) == "table" and nil ~= next(biz_data) then
          _params.from_source_data = {biz_data = biz_data}
        end
      end
      if body.biz_type == SC.Type.Community then
        local ECO = require("ejoysdk_lua.ejoysdk_community")
        ECO.notification_open(_params)
      end
    end
  end
end

local function login_handler(_user_info)
  is_gp_logined = true
end

local function gangplank_logout_handler()
  is_gp_logined = false
  local ESW = require("ejoysdk_lua.shortcut.ejoysdk_shortcut_webview")
  ESW.clear_shortcut_webview_data()
end

local function get_player_token_succ_handler()
  local ESW = require("ejoysdk_lua.shortcut.ejoysdk_shortcut_webview")
  ESW.save_shortcut_webview_data()
end

local is_gangplank_inited = false

function M.start_game_activity(direct_start_game_activity)
  local params = {
    [LUA_KEY_DIRECT_START_GAME_ACTIVITY] = direct_start_game_activity
  }
  if is_gangplank_inited then
    E.LOG.debug(TAG, "gangplank initted, now start_game_activity")
    UNI.sync_call(VENDOR_NAME, SYNC_START_GAME, params, nil)
  else
    local ALL_CHANNEL = "ALL"
    UNI.register_init_listener(ALL_CHANNEL, function(succ2, msg)
      if succ2 then
        E.LOG.debug(TAG, "native init succ, now start game activity")
        UNI.sync_call(VENDOR_NAME, SYNC_START_GAME, params, nil)
      else
        E.LOG.warn(TAG, "native init failed, ")
      end
    end)
    local _params = {}
    UNI.init(ALL_CHANNEL, _params)
  end
end

local function gangplank_inited_handler()
  E.LOG.debug(TAG, "recev gangplank inited")
  is_gangplank_inited = true
end

function M.add_shortcut(params, cb, option)
  if not M.is_support_shortcut() then
    cb(false, CONSTANTS.SHORTCUT.CODE_NOT_SUPPORT, "system did not suppport shortcut")
    return
  end
  params = params or {}
  if not params.id then
    params.id = params.biz_type
  end
  if not params.page_type then
    params.page_type = M.Type.WebView
  end
  if not params.android_long_title then
    params.android_long_title = params.title
  end
  if not params.android_icon_name then
    params.android_icon_name = "shortcut_community_icon"
  end
  local add_option = option or {}
  local os_strt = _ejoysdk.os()
  if "android" == os_strt and not add_option.disable_alert then
    local Lang = require("ejoysdk_lua.lang.util")
    local shortcut_alert_title = Lang.getString("shortcut_alert_title", "已尝试添加到桌面")
    local default_scstr = Lang.getString("shortcut_str", "快捷方式")
    local shortcut_alert_confirm = Lang.getString("shortcut_alert_confirm", "我知道了")
    local shortcut_alert_setting = Lang.getString("shortcut_alert_setting", "跳转到设置")
    local shortcut_alert_tips = Lang.getString("shortcut_alert_tips", "请在桌面上查看是否成功添加“")
    local shortcut_alert_tips2 = Lang.getString("shortcut_alert_tips2", "”，如果添加失败请跳转到设置启用“桌面快捷方式”权限。")
    local sc_title = params and params.title or default_scstr
    local message = shortcut_alert_tips .. sc_title .. shortcut_alert_tips2
    local options = {
      title = shortcut_alert_title,
      message = message,
      buttons = {shortcut_alert_confirm, shortcut_alert_setting},
      style = "lingxi",
      is_open_from_webview = add_option.is_open_from_webview
    }
    
    local function show_setting_usage_dialog_cb(ret)
      if 1 == ret then
        E.Permission.openSetting()
      end
    end
    
    E.Modal.open(shortcut_alert_title, options, show_setting_usage_dialog_cb)
  elseif "ios" == os_strt then
    local meta_config = E.CONFIG.get_vendor_config_v2(VENDOR_NAME) or {}
    if meta_config and meta_config[M.KEY.IOS_SHORTCUT_LINK] then
      local shortcut_link = meta_config[M.KEY.IOS_SHORTCUT_LINK]
      local sc_scheme = shortcut_link .. "shortcut"
      sc_scheme = sc_scheme .. "?biz_type=" .. tostring(params.biz_type or "")
      sc_scheme = sc_scheme .. "&page_type=" .. tostring(params.page_type or "")
      sc_scheme = sc_scheme .. "&id=" .. tostring(params.id or "")
      local ios_full_gen_url = params.ios_gen_url or ""
      local sc_parmas = {
        sc_title = params.title or "",
        sc_icon = params.ios_icon_url or "",
        sc_scheme = sc_scheme
      }
      local language = E.CONFIG.get_config("lang")
      local publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA)
      if language and #language > 0 then
        sc_parmas.language = language
      end
      if publish_area and #publish_area > 0 then
        sc_parmas.publish_area = publish_area
      end
      local sc_query = E.HTTP.urlencode2(sc_parmas)
      if sc_query and "" ~= sc_query then
        ios_full_gen_url = ios_full_gen_url .. "?" .. sc_query
      end
      E.LOG.debug(TAG, ios_full_gen_url)
      params[M.KEY.IOS_FULL_GEN_URL] = ios_full_gen_url
    else
      E.LOG.debug(TAG, "sdkconfig shortcut_link is nil")
      cb(false, CONSTANTS.SHORTCUT.CODE_ADD_FAIL, "sdkconfig shortcut_link is nil")
      return
    end
  end
  UNI.async_call(VENDOR_NAME, ASYNC_ADD_SHORTCUT, params, nil, function(succ, ...)
    if succ then
      cb(true)
    else
      local code, body = ...
      E.LOG.debug(TAG, "add_shortcut fail:" .. tostring(code) .. " ,msg: " .. tostring(body and body.msg))
      cb(false, tostring(code), tostring(body and body.msg))
    end
  end)
end

local is_support_cache

function M.is_support_shortcut()
  if nil == is_support_cache then
    local pkg_info = E.get_pkg_info()
    local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
    local EC = require("ejoysdk_lua.ejoysdk_config")
    if pkg_info.os == "android" then
      local game_start_activity = tostring(E.Sysinfo.manifest_meta_data("string", "game_start_activity"))
      if not game_start_activity or "nil" == game_start_activity then
        local meta_config = E.CONFIG.get_vendor_config_v2(VENDOR_NAME) or {}
        game_start_activity = meta_config and meta_config.game_start_activity or "nil"
        E.LOG.debug(TAG, "is_support_shortcut from sdkconfig: " .. tostring(game_start_activity))
      end
      is_support_cache = "nil" ~= game_start_activity and EC.has_vendor_config("shortcut") and VER_CHECK.compare_versions(pkg_info.versions.os_version, 26) >= 0
      if is_support_cache then
        local result = UNI.sync_call(VENDOR_NAME, SYNC_IS_SUPPORT_SHORTCUT, {}, nil)
        if result and result.value == false then
          E.LOG.debug(TAG, "is_support_shortcut from native: false")
          is_support_cache = false
        end
      end
    elseif pkg_info.os == "ios" then
      is_support_cache = EC.has_vendor_config("shortcut") and VER_CHECK.compare_versions(pkg_info.versions.os_version, "11.0") >= 0
    else
      is_support_cache = false
    end
  end
  return is_support_cache
end

function M.is_support_cache(_is_cache)
  is_support_cache = _is_cache
end

function M.update_shortcut_config(ucc_config)
  if not ucc_config then
    return false
  end
  if ucc_config.disable_notification_open and ucc_config.disable_notification_open == true then
    E.File.writefile("community_disable_notification_open", "ejoy sdk auto generate, do not modify!!!", false)
  else
    E.File.remove("community_disable_notification_open")
  end
  return true
end

local function get_config_from_cc()
  local sc_params
  local cc_config = ECC.get_config(ECC.NAMESPACE.EJOYSDK_BIZ)
  local sc_configs = cc_config and cc_config.config and cc_config.config.shortcut
  if sc_configs and sc_configs.items then
    for _, v in pairs(sc_configs.items) do
      if v.type == "community" then
        sc_params = v
        break
      end
    end
  end
  return sc_params
end

function M.init(_opt, cb)
  if inited then
    E.LOG.debug(TAG, "shortcut had inited")
    return
  end
  inited = true
  E.LOG.debug(TAG, "shortcut vendor start init!")
  ET.subscribe(EI.SUBSCRIBE_GANGPLANK_INITED, gangplank_inited_handler)
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, gangplank_logout_handler)
  ET.subscribe(ET.holo.GET_PLAYER_TOKEN, get_player_token_succ_handler)
  UNI.register_event_cb(VENDOR_NAME, function(evnet_type, body_data)
    if not evnet_type or "" == evnet_type then
      E.LOG.debug(TAG, "evnet_type is invalid")
      return
    end
    local handler = EVT_HANDLERS[evnet_type]
    if handler then
      E.LOG.debug(TAG, "handled event with evnet_type:" .. (evnet_type or "nil"))
      handler(body_data)
    end
  end)
  local init_config = get_config_from_cc()
  local had_config_data = M.update_shortcut_config(init_config)
  if not had_config_data and not ECC.is_data_inited then
    local function wait4_cc_handler(...)
      E.LOG.debug(TAG, "configcenter getdata inited")
      
      local ucc_config = get_config_from_cc()
      M.update_shortcut_config(ucc_config)
    end
    
    ET.subscribe(ET.config_center.DATA_INITED, wait4_cc_handler)
  end
  cb(true)
end

return M
