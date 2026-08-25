local E = require("ejoysdk_lua.ejoysdk")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _agreement_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local EC = require("ejoysdk_lua.ejoysdk_config")
local TAG = EM.MODULE.AGREEMENT .. "agreement"
local AGREEMENT_SERVICE = {
  agreement_for_sign = "/policy/eurl_sign",
  agreement_for_view = "/policy/eurl",
  game_agreement_for_view = "/game_agreement/protocol"
}
local agree_result = {result = false, url_version = 0}
local agree_callback, agree_ejoy_token
local M = {}
M.ERR_CODE_REJECT_FOR_AGREEMENT = 421

local function stat_action(action, type, result, params)
  local _params = params or {}
  _params[ESTAT.STAT_KEY.IS_PRIORITY_HIGH] = true
  ESTAT.stat_action(action, type, result, _params)
end

local function get_agreement_url(service)
  local holo_url_base
  if EC.is_force_use_rule_service_splice_in_path("holo") then
    holo_url_base = E.CONFIG.get_config("gangplank")
  else
    holo_url_base = E.CONFIG.get_config("holo")
  end
  return holo_url_base .. service
end

local function get_game_agreement_url(service)
  return E.CONFIG.get_config("gangplank") .. service
end

local webview_js_callback, webview_close_callback

local function open_url(service, screen_orientation, params, is_game_agreement, close_cb)
  E.WebView.is_opened_async(function(is_opened)
    if is_opened then
      E.Timer.once(1, function()
        open_url(service, screen_orientation, params, is_game_agreement, close_cb)
      end)
    else
      local url = get_agreement_url(service)
      if is_game_agreement then
        url = get_game_agreement_url(service)
      end
      url = url .. "?language=" .. E.CONFIG.get_config("lang")
      local publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA)
      if publish_area and "" ~= publish_area then
        url = url .. "&area=" .. publish_area
      end
      local channel_id = E.get_channel()
      if channel_id and "" ~= channel_id then
        url = url .. "&channel=" .. channel_id
      end
      local user_info = USER.user_info()
      local country = (user_info or {}).location or {}.userLocation or {}.country
      if country and "" ~= country then
        url = url .. "&user_location=" .. country
      end
      local pkg_name = E.get_pkg_info().pkg_name
      if pkg_name and "" ~= pkg_name then
        url = url .. "&pkg_name=" .. pkg_name
      end
      if params and type(params) == "table" then
        local query = E.HTTP.urlencode2(params)
        if query and "" ~= query then
          url = url .. "&" .. query
        end
      end
      E.LOG.debug(TAG, "agreement_url: " .. url)
      local options = {
        [".ejoy.com"] = {transparent = true}
      }
      local server_domain = E.CONFIG.get_config(E.CONFIG.KEY.SERVER_DOMAIN)
      if server_domain and "" ~= server_domain then
        options[server_domain] = {transparent = true}
      end
      E.WebView.open(url, options, {
        compactMode = true,
        use_cutout = true,
        screen_orientation = screen_orientation
      }, webview_js_callback, close_cb or webview_close_callback)
    end
  end)
end

local function show_agreement_webview(service, screen_orientation, params)
  open_url(service, screen_orientation, params)
end

local function show_game_agreement_webview(service, screen_orientation, params, close_cb)
  open_url(service, screen_orientation, params, true, close_cb)
end

function M.show_agreement(screen_orientation, params, close_cb)
  if _ejoysdk.os() == "weixin" then
    _ejoysdk.js_log("require privacy")
    E.require_privacy({
      success = function()
        if params and params.is_readonly then
          _ejoysdk.js_log("open privacy")
          E.open_privacy({})
        end
        if close_cb then
          close_cb(true)
        end
      end,
      fail = function()
        _ejoysdk.js_log("require privacy fail")
        if close_cb then
          close_cb(false)
        end
      end
    })
  elseif _ejoysdk.os() == "douyin" then
    _ejoysdk.log("douyin not support require_privacy, please use get_protocol api to get privacy content")
    return
  else
    function agree_callback(...)
      E.LOG.debug(TAG, "回调用户协议结果，并清理本次回调的callback，避免下次打开时有多余的回调")
      
      if close_cb then
        close_cb()
      end
      agree_callback = nil
    end
    
    show_agreement_webview(AGREEMENT_SERVICE.agreement_for_view, screen_orientation, params)
  end
end

function webview_js_callback(_value)
  E.LOG.debug(TAG, "webview_js_callback receive agreement_result event!")
  local args = _value.args
  if args.type == "agreement_result" or args.type == "game_agreement_result" then
    agree_result.result = args.result
    agree_result.url_version = args.version
    local params
    if args.type == "game_agreement_result" then
      agree_result.type = "game_agreement"
      agree_result.category = args.category
      params = {}
      params.category = args.category
    end
    local action_name = "ejoy_" .. args.type
    stat_action(action_name, agree_result.url_version, agree_result.result, params)
    E.LOG.debug(TAG, "webview_js_callback receive agreement_result:")
    E.LOG.debug(TAG, args)
    E.WebView.close()
  end
end

local function request_agree_url(url, ejoy_token, params, cb)
  cb = cb or function(...)
  end
  local eg = require("ejoysdk_lua.ejoysdk_gangplank")
  local sign_url = eg.gangplank_logined_url(url, "2")
  E.LOG.debug(TAG, "request agree begin: " .. tostring(sign_url))
  params = params or {}
  params.pkg_info = E.get_pkg_info()
  local user_info = USER.user_info()
  if user_info and user_info.location then
    params.location_info = user_info.location
  end
  local headers = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["ejoy-token"] = ejoy_token
    }
  }
  E.HTTP.post(sign_url, headers, E.HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      if 0 == resp.body.code then
        cb(true)
      else
        cb(false, resp.body.code, resp.body.message)
      end
    else
      cb(false, resp.status, "http error")
    end
  end)
end

local function inner_agree_eurl(agree_h5_ver, ejoy_token, cb)
  local params = {}
  params.version = tostring(agree_h5_ver)
  request_agree_url("/eurl_signed", ejoy_token, params, cb)
end

local function inner_agree_game_eurl(agree_h5_ver, category, ejoy_token, cb)
  local params = {}
  params.version = tonumber(agree_h5_ver)
  params.category = category
  local eg = require("ejoysdk_lua.ejoysdk_gangplank")
  ejoy_token = ejoy_token or eg.user_info().token
  request_agree_url("/game_agreement/sign", ejoy_token, params, cb)
end

local function inner_get_protocol(params, is_game_agreement, cb)
  params = params or {}
  local channel_id = E.get_channel()
  local user_info = USER.user_info()
  local publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA)
  local user_location = (user_info or {}).location or {}.userLocation or {}.country
  local pkg_name = E.get_pkg_info().pkg_name
  local lang = E.CONFIG.get_config("lang")
  local req_param = {
    area = params.area or publish_area,
    channel = params.channel or channel_id,
    pkg_name = params.pkg_name or pkg_name,
    user_location = params.user_location or user_location,
    language = params.lang or lang or "zh-hans"
  }
  local gp_ex = require("ejoysdk_lua.server_api.gangplank_ex")
  if is_game_agreement then
    req_param.category = params.category
    gp_ex.get_game_protocol(req_param, cb)
  else
    gp_ex.get_protocol(req_param, cb)
  end
end

function webview_close_callback(_value)
  E.LOG.debug(TAG, "listen_webview_close_event")
  if agree_result.result then
    E.LOG.debug(TAG, "agreement page result: true, user agree")
    inner_agree_eurl(agree_result.url_version, agree_ejoy_token, function(succ, ...)
      if agree_callback then
        if succ then
          E.LOG.debug(TAG, "request_agree_eurl result succ")
          agree_callback(true)
          stat_action("ejoy_agreement_close_eurl_result", true, agree_result.url_version)
        else
          local code, msg = ...
          E.LOG.warn(TAG, "request_agree_eurl result fail, code:" .. tostring(code) .. ", errMsg:" .. tostring(msg))
          agree_callback(false)
          local stat_msg = tostring(code) .. "-" .. tostring(msg)
          stat_action("ejoy_agreement_close_eurl_result", false, stat_msg)
        end
      end
    end)
    stat_action("ejoy_agreement_close_request_eurl", agree_result.url_version, agree_result.result)
  else
    E.LOG.warn(TAG, "agreement page result: false, user decline")
    if agree_callback then
      agree_callback(false)
    end
    stat_action("ejoy_agreement_close_skip_eurl", agree_result.url_version, agree_result.result)
  end
  agree_result = {
    result = false,
    url_version = 0,
    type = nil,
    category = nil
  }
end

function M.handle_login_reject_error(status, ejoy_token, cb)
  if status ~= M.ERR_CODE_REJECT_FOR_AGREEMENT then
    return false
  end
  local os = E.Sysinfo.os()
  if "windows" == os and not E.support_webview() then
    E.LOG.warn(TAG, "do not has webview component, return now.")
    return
  elseif "weixin" == os then
    M.show_agreement("portrait", {}, cb)
    return true
  end
  E.LOG.debug(TAG, "handle_login_reject_error agreement handler handled this status")
  
  function agree_callback(...)
    cb(...)
    E.LOG.debug(TAG, "回调用户协议结果，并清理本次回调的callback，避免下次打开时有多余的回调")
    agree_callback = nil
  end
  
  agree_ejoy_token = ejoy_token
  E.LOG.debug(TAG, "handle_login_reject_error, need user agreement!")
  show_agreement_webview(AGREEMENT_SERVICE.agreement_for_sign)
  return true
end

function M.get_protocol(params, cb)
  inner_get_protocol(params, false, cb)
end

function M.agree_eurl(vsn, cb)
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local req_ejoy_token = agree_ejoy_token
  if not req_ejoy_token then
    E.LOG.debug(TAG, "agree_ejoy_token is nil, not in login flow")
    req_ejoy_token = EG.user_info().token
  end
  inner_agree_eurl(vsn, req_ejoy_token, function(succ, ...)
    if not agree_callback then
      E.LOG.debug(TAG, "agree_callback is nil")
    end
    if succ then
      E.LOG.debug(TAG, "agree_eurl: request_agree_eurl result succ")
      stat_action("ejoy_agreement_close_eurl_result", true, vsn)
      cb(true)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "agree_eurl: request_agree_eurl result fail, code:" .. tostring(code) .. ", errMsg:" .. tostring(msg))
      local stat_msg = tostring(code) .. "-" .. tostring(msg)
      stat_action("ejoy_agreement_close_eurl_result", false, stat_msg)
      cb(false, code, msg)
    end
  end)
end

function M.show_game_agreement(screen_orientation, category, params, close_cb)
  local function agree_game_callback(_value)
    if agree_result.result and agree_result.type == "game_agreement" then
      E.LOG.debug(TAG, "game agreement page result: true, user agree")
      
      local stat_params = {
        category = agree_result.category
      }
      inner_agree_game_eurl(agree_result.url_version, agree_result.category, agree_ejoy_token)
      if close_cb then
        close_cb(true)
      end
      stat_action("ejoy_game_agreement_close_request_eurl", agree_result.url_version, agree_result.result, stat_params)
    else
      E.LOG.warn(TAG, "game agreement page result: false, user decline")
      if close_cb then
        close_cb(false)
      end
      stat_action("ejoy_game_agreement_close_skip_eurl", agree_result.url_version, agree_result.result)
    end
    agree_result = {
      result = false,
      url_version = 0,
      type = nil,
      category = nil
    }
  end
  
  params.category = category
  local url_for_open = AGREEMENT_SERVICE.game_agreement_for_view
  show_game_agreement_webview(url_for_open, screen_orientation, params, agree_game_callback)
end

function M.get_game_protocol(category, params, cb)
  params = params or {}
  params.category = category
  inner_get_protocol(params, true, cb)
end

function M.agree_game_eurl(vsn, category, cb)
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local req_ejoy_token = agree_ejoy_token
  if not req_ejoy_token then
    E.LOG.debug(TAG, "agree_ejoy_token is nil, not in login flow")
    req_ejoy_token = EG.user_info().token
  end
  inner_agree_game_eurl(vsn, category, req_ejoy_token, function(succ, ...)
    if not agree_callback then
      E.LOG.debug(TAG, "agree_callback is nil")
    end
    if succ then
      E.LOG.debug(TAG, "agree_game_eurl: request_agree_eurl result succ")
      stat_action("ejoy_game_agreement_close_eurl_result", true, vsn)
      cb(true)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "agree_game_eurl: request_agree_eurl result fail, code:" .. tostring(code) .. ", errMsg:" .. tostring(msg))
      local stat_msg = tostring(code) .. "-" .. tostring(msg)
      stat_action("ejoy_game_agreement_close_eurl_result", false, stat_msg)
      cb(false, code, msg)
    end
  end)
end

function M.is_game_agreement_need_sign(category, cb)
  local req_param = {
    pkg_info = E.get_pkg_info(),
    location_info = (USER.user_info() or {}).location,
    category = category
  }
  local eg = require("ejoysdk_lua.ejoysdk_gangplank")
  local url = eg.gangplank_logined_url("/game_agreement/check", "2")
  local headers = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["ejoy-token"] = eg.user_info().token
    }
  }
  E.HTTP.post(url, headers, E.HTTP.CT_JSON, req_param, function(resp)
    if resp.status == 200 then
      if 0 == resp.body.code then
        cb(true, resp.body.signature_info)
      else
        cb(false, resp.body.code, resp.body.message)
      end
    else
      cb(false, resp.status, "http error")
    end
  end)
end

return M
