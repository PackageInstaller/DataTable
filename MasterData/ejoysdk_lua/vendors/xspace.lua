local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local HTTP = E.HTTP
local Vendor = require("ejoysdk_lua.vendors.vendor")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EM = require("ejoysdk_lua.ejoysdk_module")
local VENDOR_NAME = "XSPACE"
local TAG = EM.MODULE.VENDORS.XSPACE
local M = Vendor:Inherit("XSPACE")
local xspace_url
local NOT_LOGIN = 1
local LOGIN_ACCOUNT = 2
local LOGIN_PLAYER = 3
local login_type = NOT_LOGIN

local function get_body_signature(body)
  local body_json = JSON.encode(body)
  local secret = "4c7e8e8f2950482ba1df770759d99645"
  if type(_ejoysdk_crypt.md5) == "function" then
    do return _ejoysdk_crypt.hexencode, _ejoysdk_crypt.md5(body_json .. secret) end
    return _ejoysdk_crypt.hexencode, _ejoysdk_crypt.md5(body_json .. secret)
  elseif type(_ejoysdk_crypt.md5) == "table" and _ejoysdk_crypt.md5.sum then
    do return _ejoysdk_crypt.hexencode, _ejoysdk_crypt.md5.sum(body_json .. secret) end
    return _ejoysdk_crypt.hexencode, _ejoysdk_crypt.md5.sum(body_json .. secret)
  end
end

local function get_xspace_url()
  local url = "http://customer.lingxigames.com/login/helpCenterDomain"
  local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
  local gangplank_config = EGC.get_current_cdn_config()
  if gangplank_config and gangplank_config.xspace then
    url = gangplank_config.xspace
    E.LOG.debug(TAG, "use cdn config xspace url: " .. tostring(url))
    return url
  end
  local UNI = require("ejoysdk_lua.vendors.unisdk")
  local sdk_infos = UNI.get_sdk_infos()
  local vendor_info = sdk_infos[VENDOR_NAME]
  if vendor_info and vendor_info.meta and vendor_info.meta.url then
    url = vendor_info.meta.url
    E.LOG.debug(TAG, "use sdk_config xspace url: " .. tostring(url) .. ", vendor_info >>")
    E.LOG.debug(TAG, vendor_info)
    return url
  end
  E.LOG.debug(TAG, "use default xspace url: " .. tostring(url))
  return url
end

local function request_get_xspace_url(cb)
  local body = {
    appCode = "sdk",
    reqTime = E.time(),
    nonce = _ejoysdk_crypt.base64encode(_ejoysdk_crypt.randomkey()),
    gameId = E.get_game_id(),
    loginType = login_type,
    language = E.CONFIG.get_config("lang"),
    region = E.CONFIG.get_config("district"),
    platform = E.Sysinfo.os(),
    deviceId = E.Sysinfo.utdid(),
    publishArea = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA) or ""
  }
  local usercenter = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local user_info = usercenter.user_info() or {}
  body.accountToken = user_info.token or ""
  body.accountId = user_info.openId or ""
  local eg_user_info = EG.user_info() or {}
  body.serverId = eg_user_info.server or ""
  local player_info = EG.player_info() or {}
  body.roleId = player_info.player_id or ""
  body.roleName = player_info.player_name or ""
  local params = {
    acceptable = HTTP.CT_JSON,
    headers = {
      signature = get_body_signature(body)
    }
  }
  E.LOG.debug(TAG, "request_get_xspace_url >>")
  xspace_url = get_xspace_url()
  HTTP.post(xspace_url, params, HTTP.CT_JSON, body, function(resp)
    E.LOG.debug(TAG, "获取帮助中心 url 回调")
    if resp.status == 200 and resp.body and resp.body.state then
      if resp.body.state.code == 2000000 then
        cb(true, resp.body.result)
      else
        cb(false, tostring(resp.body.state.code), tostring(resp.body.state.msg))
      end
    else
      cb(false, resp.status, "http error")
    end
  end)
end

local function listen_webview_js_event()
  local function webview_js_callback(value)
    local args = value.args
    
    E.LOG.debug(TAG, "webview_js_callback >>")
    E.LOG.debug(TAG, args)
    ET.unsubscribe("webview_jsargs", webview_js_callback)
  end
  
  ET.subscribe("webview_jsargs", webview_js_callback)
end

local function listen_webview_close_event()
  local function webview_close_callback(value)
    E.LOG.debug(TAG, "webview_close >>")
    
    E.LOG.debug(TAG, value)
    ET.unsubscribe("webview_close", webview_close_callback)
  end
  
  ET.subscribe("webview_close", webview_close_callback)
end

local function get_startupdata()
  local startupdata = {
    nonce = _ejoysdk_crypt.base64encode(_ejoysdk_crypt.randomkey()),
    gameId = E.get_game_id(),
    language = E.CONFIG.get_config("lang"),
    region = E.CONFIG.get_config("district"),
    platform = E.Sysinfo.os(),
    deviceId = E.Sysinfo.utdid(),
    publishArea = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA) or ""
  }
  local usercenter = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local user_info = usercenter.user_info() or {}
  startupdata.accountToken = user_info.token or ""
  startupdata.accountId = user_info.openId or ""
  local eg_user_info = EG.user_info() or {}
  startupdata.serverId = eg_user_info.server or ""
  local player_info = EG.player_info() or {}
  startupdata.roleId = player_info.player_id or ""
  startupdata.roleName = player_info.player_name or ""
  E.LOG.debug(TAG, "xspace startupdata >>")
  E.LOG.debug(TAG, startupdata)
  return startupdata
end

function M.init(opt, cb)
  ET.subscribe(ET.gangplank.LOGIN, function()
    login_type = LOGIN_ACCOUNT
  end)
  ET.subscribe(ET.gangplank.LOGOUT, function()
    login_type = NOT_LOGIN
  end)
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, function()
    login_type = LOGIN_PLAYER
  end)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, function()
    login_type = LOGIN_ACCOUNT
  end)
  if cb then
    cb(true)
  end
end

function M.show_custom_service(params, cb, close_cb)
  request_get_xspace_url(function(succ, ...)
    if succ then
      local result = (...)
      local url = result.helpCenterDomain
      E.LOG.debug(TAG, "open url: " .. tostring(url))
      if not url then
        E.LOG.error(TAG, " url is nil, can not open custom service")
        if cb then
          cb(false, "xcpase url is nil, can not open custom service")
        end
        return
      end
      listen_webview_js_event()
      listen_webview_close_event()
      local host = HTTP.parse(url).host
      local xspace_host = HTTP.parse(xspace_url).host
      E.LOG.debug(TAG, "host: " .. tostring(host))
      local startupdata = get_startupdata()
      local enable_toolbar = params and params.enable_toolbar or false
      local toolbar_theme = params and params.toolbar_theme or "light_bottom"
      E.WebView.open(url, {
        [host] = {transparent = false, startupData = startupdata},
        [xspace_host] = {transparent = false, startupData = startupdata}
      }, {
        compactMode = true,
        screen_orientation = params.orientation,
        closeEventData = "xspace_webview_close",
        enable_toolbar = enable_toolbar,
        toolbar_theme = toolbar_theme
      }, nil, function()
        E.LOG.debug(TAG, "xspace web closed")
        if close_cb then
          close_cb()
        end
      end)
      if cb then
        cb(true)
      end
    else
      if close_cb then
        close_cb()
      end
      if cb then
        cb(succ, ...)
      end
    end
  end)
end

M:is_implemented({
  Vendor.ABILITY.CUSTOM_SERVICE
})
return M
