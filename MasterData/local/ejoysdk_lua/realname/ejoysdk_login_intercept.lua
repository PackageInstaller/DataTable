local E = require("ejoysdk_lua.ejoysdk")
local POPUP = require("ejoysdk_lua.realname.popup_handler")
local REALNAME_INFO = require("ejoysdk_lua.realname.realname_info")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local CC = require("ejoysdk_lua.ejoysdk_constants")
local CONFIG = require("ejoysdk_lua.airline_v2.airline_v2_config")
local TAG = "ejoysdk_login_intercept#"
local M = {}
M.SCENE_TYPE = {
  SCENE_AFTER_LOGIN = 1,
  SCENE_BEFORE_CREATE_ORDER = 2,
  SCENE_IN_GAME = 3
}
M.REALNAME_PAGE_TYPE = {
  BIND_URL = "BIND_URL",
  REALNAME_URL = "REALNAME_URL"
}
local REALNAME_PAGES = {}
if E.Sysinfo.os() == "ios" then
  REALNAME_PAGES[M.REALNAME_PAGE_TYPE.REALNAME_URL] = "https://account-lingxi.aligames.com/request_cas.html?can_close=true&notify_type=msg_realname"
  REALNAME_PAGES[M.REALNAME_PAGE_TYPE.BIND_URL] = "https://account-lingxi.aligames.com/common_bind_phone.html?theme_type=light"
else
  REALNAME_PAGES[M.REALNAME_PAGE_TYPE.REALNAME_URL] = "http://render.aligames.com/p/q/ieu-sdk-h5/common_request_cas.html?can_close=true&notify_type=msg_realname"
  REALNAME_PAGES[M.REALNAME_PAGE_TYPE.BIND_URL] = "http://render.aligames.com/p/q/ieu-sdk-h5/common_bind_phone.html?theme_type=light"
end
local UC_REALNAME_STATUS = {
  STATUS_SUCCESS = "20000",
  STATUS_LOGIN_STATUS_INVALID = "50002",
  STATUS_REALNAME_CLOSED_BY_USER = "50318"
}
M.USERCENTER_REALNAME_STATUS = UC_REALNAME_STATUS
local REALNAME_STAT_BIZID = {
  REALNAME_STAT_FORCE = "211001",
  REALNAME_STAT_FORCE_RESULT = "211002",
  REALNAME_STAT_NOT_FORCE = "211003",
  REALNAME_STAT_NOT_FORCE_CLOSE = "211004",
  REALNAME_STAT_NOT_FORCE_RESULT = "211005"
}
local POPUP_TYPE = {
  TYPE_REALNAME = 1,
  TYPE_ANTI_ADDICTION = 2,
  TYPE_OPERATION = 3,
  TYPE_OVERSEAS_REALNAME = 4,
  TYPE_DEFAULT = -1
}

local function get_ali_ios_authinfo(auth_info)
  local auth_type
  auth_info:gsub("auth_type=\"(.-)\"", function(value)
    auth_type = value or "PURE_OAUTH_SDK"
  end)
  local app_id
  auth_info:gsub("app_id=\"(.-)\"", function(value)
    app_id = value
  end)
  local scope
  auth_info:gsub("scope=\"(.-)\"", function(value)
    scope = value or "auth_user"
  end)
  local state
  auth_info:gsub("state=\"(.-)\"", function(value)
    state = value or "auth_state"
  end)
  return "https://authweb.ali" .. "p" .. "a" .. "y.com/auth?auth_type=" .. tostring(auth_type) .. "&app_id=" .. tostring(app_id) .. "&scope=" .. tostring(scope) .. "&state=" .. tostring(state)
end

local function webview_close_fail(status, popup_type, can_close, callback)
  if popup_type == POPUP_TYPE.TYPE_OVERSEAS_REALNAME then
    callback(UC_REALNAME_STATUS.STATUS_REALNAME_CLOSED_BY_USER)
    QL.commit_action_main("ejoy_realname_result", popup_type, false)
  elseif can_close then
    E.LOG.warn(TAG, "default_close_callback, the popup can close, so notify gangplank to continue")
    callback(REALNAME_INFO.REALNAME_RESULT.STATUS_COMPLETE_WITH_REALNAME_FAILED)
    QL.commit_action_main("ejoy_realname_result", REALNAME_INFO.REALNAME_RESULT.STATUS_COMPLETE_WITH_REALNAME_FAILED, true)
  else
    E.LOG.warn(TAG, "default_close_callback, the popup can not close, so notify gangplank to logout")
    callback(REALNAME_INFO.REALNAME_RESULT.STATUS_UNCOMPLETE)
    QL.commit_action_main("ejoy_realname_result", status, false)
  end
end

local function webview_close_callback(value, popup_type, can_close, callback)
  if value and value.args == value.close_event_data then
    E.LOG.debug(TAG, "#listen_webview_close_event, event>>" .. tostring(value.args))
    E.LOG.debug(TAG, {value = value})
    if not value.processed then
      E.LOG.debug(TAG, "#listen_webview_close_event, receive close event，it's user close")
      if popup_type == POPUP_TYPE.TYPE_REALNAME and can_close then
        ESTAT.stat_bizid(REALNAME_STAT_BIZID.REALNAME_STAT_NOT_FORCE_CLOSE, "3", "1", {is_priority_high = true})
      end
      QL.commit_action_main("ej_realname_web_close", popup_type, can_close)
      webview_close_fail(CC.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_REALNAME_CANCELLED, popup_type, can_close, callback)
    end
  end
end

local function webview_js_callback(value, popup_type, can_close, callback)
  local args = value.args or {}
  local aliAuth = "ali" .. "p" .. "a" .. "y" .. "Auth"
  local stat_params = {
    msg = args.type
  }
  value.processed = true
  E.LOG.debug(TAG, "webview_js_callback----called")
  E.LOG.debug(TAG, {value = value})
  E.LOG.debug(TAG, "args ====")
  E.LOG.debug(TAG, args)
  
  local function msg_realname()
    local status = args.params and args.params.status or -1
    local status_str = tostring(status)
    E.LOG.debug(TAG, "#webview_js_callback receive realname callback, status:" .. status_str)
    local switch = {
      [UC_REALNAME_STATUS.STATUS_SUCCESS] = function()
        if popup_type == POPUP_TYPE.TYPE_OVERSEAS_REALNAME then
          callback(UC_REALNAME_STATUS.STATUS_SUCCESS)
          return
        end
        REALNAME_INFO.update_realname_status(REALNAME_INFO.LX_REALNAME_STATUS.SUCCESS)
        if can_close then
          ESTAT.stat_bizid(REALNAME_STAT_BIZID.REALNAME_STAT_NOT_FORCE_RESULT, "4", "1", {is_priority_high = true})
        else
          ESTAT.stat_bizid(REALNAME_STAT_BIZID.REALNAME_STAT_FORCE_RESULT, "4", "1", {is_priority_high = true})
        end
        local realname_info = (args.params or {}).realNameInfo
        E.LOG.debug(TAG, "realname_info >>>")
        E.LOG.d(TAG, {realname_args = args})
        E.LOG.debug(TAG, realname_info)
        REALNAME_INFO.set_realname_info(realname_info)
        if realname_info.realNameStatus == REALNAME_INFO.LX_REALNAME_STATUS.SUCCESS then
          E.LOG.debug(TAG, "realname succ,popup dialog closed")
          callback(REALNAME_INFO.REALNAME_RESULT.STATUS_COMPLETE_WITH_REALNAME_SUCC)
          QL.commit_action_main("ejoy_realname_result", nil, true)
        else
          webview_close_fail(CC.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_REALNAME_REPORT_RESULT_INVALID, popup_type, can_close, callback)
        end
      end,
      [UC_REALNAME_STATUS.STATUS_LOGIN_STATUS_INVALID] = function()
        E.LOG.warn(TAG, "webview_js_callback realname callback login status invalid!")
        QL.commit_action_main("ej_realname_status_login_invalid", popup_type, can_close, stat_params)
        callback(REALNAME_INFO.REALNAME_RESULT.STATUS_UNCOMPLETE)
      end,
      [UC_REALNAME_STATUS.STATUS_REALNAME_CLOSED_BY_USER] = function()
        E.LOG.warn(TAG, "webview_js_callback realname callback dialog closed by user!")
        if can_close and popup_type ~= POPUP_TYPE.TYPE_OVERSEAS_REALNAME then
          ESTAT.stat_bizid(REALNAME_STAT_BIZID.REALNAME_STAT_NOT_FORCE_CLOSE, "3", "1", {is_priority_high = true})
        end
        QL.commit_action_main("ej_realname_status_close_by_user", popup_type, can_close, stat_params)
        webview_close_fail(status, popup_type, can_close, callback)
      end
    }
    ;(switch[status_str] or function()
      E.LOG.d(TAG, "not process")
      value.processed = false
      E.LOG.debug(TAG, {value = value})
      if popup_type ~= POPUP_TYPE.TYPE_OVERSEAS_REALNAME then
        if can_close then
          ESTAT.stat_bizid(REALNAME_STAT_BIZID.REALNAME_STAT_NOT_FORCE_RESULT, "4", "0", {is_priority_high = true})
        else
          ESTAT.stat_bizid(REALNAME_STAT_BIZID.REALNAME_STAT_FORCE_RESULT, "4", "0", {is_priority_high = true})
        end
      end
      QL.commit_action_main("ej_realname_status_other_result", popup_type, can_close, stat_params)
    end)()
  end
  
  local function msg_login_intercept()
    local status = args.params and args.params.status or -1
    local status_str = tostring(status)
    E.LOG.debug(TAG, "#webview_js_callback receive msg_login_intercept callback, status:" .. tostring(status))
    if status == UC_REALNAME_STATUS.STATUS_SUCCESS then
      callback(UC_REALNAME_STATUS.STATUS_SUCCESS)
    else
      callback(status_str)
    end
    stat_params.code = status_str
    QL.commit_action_main("ej_realname_status_intercept", popup_type, can_close, stat_params)
  end
  
  local function msg_aliauth()
    E.LOG.debug(TAG, "#webview_js_callback receive aliAuth")
    local v_aligames = require("ejoysdk_lua.vendors.aligames")
    local auth_info = args.authInfo or ""
    if E.Sysinfo.os() == "ios" then
      auth_info = get_ali_ios_authinfo(auth_info)
    end
    v_aligames.ali_auth(auth_info, function(succ, ...)
      if succ then
        local cbid = value.cbid
        E.LOG.debug(TAG, "cbid: " .. tostring(cbid))
        local auth_result = (...)
        if cbid then
          E.WebView.callback_js(cbid, auth_result)
        end
        stat_params.code = auth_result
        QL.commit_action_main("ej_realname_status_ali_auth_ret", popup_type, can_close, stat_params)
      end
    end)
  end
  
  local function logout_bind()
    if popup_type == POPUP_TYPE.TYPE_REALNAME then
      return
    end
    E.LOG.debug(TAG, "#webview_js_callback receive bind phone callback, and notify user relogin")
    local v_aligames = require("ejoysdk_lua.vendors.aligames")
    v_aligames.set_lx_guest_bind_state()
    callback(REALNAME_INFO.REALNAME_RESULT.STATUS_COMPLETE_BIND_PHONE)
    QL.commit_action_main("ej_realname_status_bind_relogin", popup_type, can_close, stat_params)
  end
  
  local function exit()
    E.LOG.debug(TAG, "#webview_js_callback receive msg_exit_login, and notify user relogin")
    if popup_type == POPUP_TYPE.TYPE_REALNAME and can_close then
      ESTAT.stat_bizid(REALNAME_STAT_BIZID.REALNAME_STAT_NOT_FORCE_CLOSE, "3", "1", {is_priority_high = true})
    end
    callback(REALNAME_INFO.REALNAME_RESULT.STATUS_UNCOMPLETE)
    QL.commit_action_main("ej_realname_status_exit_login", popup_type, can_close, stat_params)
  end
  
  local function exit_app()
    E.LOG.debug(TAG, "#webview_js_callback receive msg_exit_app, and notify game exit")
    QL.commit_action_main("ej_realname_status_exit_app", popup_type, can_close, stat_params)
    local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
    gangplank.notify_exit(true)
  end
  
  local switch = {
    msg_realname = msg_realname,
    msg_login_intercept = msg_login_intercept,
    [aliAuth] = msg_aliauth,
    logout = logout_bind,
    bind_succ = logout_bind,
    msg_exit_login = exit,
    msg_exit_app = exit_app
  }
  if args and args.type then
    E.LOG.d(TAG, "msg invoke:" .. (args and args.type or ""))
  end
  ;(switch[args and args.type or ""] or function()
    value.processed = false
    E.LOG.d(TAG, "不知名的回调")
    E.LOG.debug(TAG, {value = value})
  end)()
end

local function handle_interception(type, url, wv_option, params, cb)
  local can_close = wv_option and wv_option.can_close or false
  wv_option.close_event_data = "close_event_data_" .. tostring(type)
  local processed = false
  POPUP.show_webview(url, wv_option, params, function(value)
    value.close_event_data = wv_option.close_event_data
    webview_js_callback(value, type, can_close, cb)
    processed = value.processed
    E.LOG.debug(TAG, "webview_js_callback----excute finish, processed = " .. tostring(processed))
    E.LOG.debug(TAG, {value = value})
  end, function(value)
    value.close_event_data = wv_option.close_event_data
    value.processed = processed
    webview_close_callback(value, type, can_close, cb)
  end)
  if type == POPUP_TYPE.TYPE_REALNAME or type == POPUP_TYPE.TYPE_ANTI_ADDICTION then
    if can_close then
      ESTAT.stat_bizid(REALNAME_STAT_BIZID.REALNAME_STAT_NOT_FORCE, "2", "1", {is_priority_high = true})
    else
      ESTAT.stat_bizid(REALNAME_STAT_BIZID.REALNAME_STAT_FORCE, "2", "1", {is_priority_high = true})
    end
  end
end

function M.handle_lx_realname(page_type, scene, can_close, cb)
  assert(type(page_type) == "string", "page_type should not recognized:" .. (page_type or "nil"))
  local url = REALNAME_PAGES[page_type]
  assert(type(url) == "string", "url not found with page_type:" .. page_type)
  local params = {scene_type = scene}
  local need_cas = false
  if page_type == M.REALNAME_PAGE_TYPE.REALNAME_URL then
    need_cas = true
  end
  local modify_url = POPUP.append_sdk_query_params(url, need_cas, params)
  local wv_option = {can_close = can_close}
  handle_interception(POPUP_TYPE.TYPE_REALNAME, modify_url, wv_option, {}, cb)
end

function M.handle_realname(url, scene, can_close, params, cb)
  params = params or {}
  params.scene_type = scene
  local wv_option = {can_close = can_close}
  local type = POPUP_TYPE.TYPE_REALNAME
  if E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) == true then
    type = POPUP_TYPE.TYPE_OVERSEAS_REALNAME
  end
  handle_interception(type, url, wv_option, params, cb)
end

M.NOTIFY_TYPE = {TIPS = "tips", WEB = "h5"}
local handle_notify_h5, handle_notify_tips

function M.handle_popup_config(config, cb)
  if not config then
    E.LOG.warn(TAG, "show_popup_with_config failed, config is nil")
    if cb then
      cb(false, -1, "config is nil")
    end
  end
  E.LOG.debug(TAG, "receive notify message with type:" .. tostring(config.type))
  if config.type == M.NOTIFY_TYPE.WEB then
    handle_notify_h5(config, cb)
  elseif config.type == M.NOTIFY_TYPE.TIPS then
    handle_notify_tips(config, cb)
  else
    E.LOG.warn(TAG, "not support popup config:" .. (config.type or "nil"))
    if cb then
      cb(false, -1, "config.type must be \"tips\" or \"h5\"")
    end
  end
end

function M.handle_popup_info(popup_info, cb)
  local popup_type = popup_info.type
  E.LOG.debug(TAG, "handle_login_reject_error, need show popup type:" .. tostring(popup_type) .. ", type_name:" .. tostring(popup_type) .. ", pageClose:" .. tostring(popup_info.pageClose))
  local url = POPUP.append_sdk_query_params(popup_info.configUrl, true)
  E.LOG.debug(TAG, "handle_login_reject_error append_cas_query result:" .. tostring(url))
  local start_up_data = {}
  CONFIG.fill_start_up_data(start_up_data)
  start_up_data.client_info = POPUP.get_cas_client_info()
  local wv_option = {
    can_close = 2 ~= popup_info.pageClose
  }
  handle_interception(popup_type, url, wv_option, start_up_data, cb)
end

function handle_notify_h5(config, cb)
  local popup_list = config.popupConfigList
  if nil == popup_list or nil == next(popup_list) then
    E.LOG.debug(TAG, "popup list is empty, no need to show h5")
    if cb then
      cb(false, -1, "config.popupConfigList is empty, no need to show h5")
    end
  else
    local popup_info = popup_list[1]
    M.handle_popup_info(popup_info, function(result_status)
      if result_status == REALNAME_INFO.REALNAME_RESULT.STATUS_COMPLETE_WITH_REALNAME_FAILED or result_status == REALNAME_INFO.REALNAME_RESULT.STATUS_COMPLETE_WITH_REALNAME_SUCC then
        E.LOG.debug(TAG, "popup complete, receive popup handle result STATUS_COMPLETE_WITH_STATE_CHANGED STATUS_PROCESS_COMPLETE")
      else
        E.LOG.debug(TAG, "receive popup handle result not complete, need logout!")
        local eg = require("ejoysdk_lua.ejoysdk_gangplank")
        eg.logout()
      end
      if cb then
        cb(true)
      end
    end)
  end
end

function handle_notify_tips(config, cb)
  if config.notifyMsg and config.notifyMsg ~= "" then
    if cb then
      cb(true)
    end
  else
    E.LOG.warn(TAG, "msg is invalid, empty or nil")
    if cb then
      cb(false, -1, "config.notifyMsg is invalid, empty or nil")
    end
  end
end

return M
