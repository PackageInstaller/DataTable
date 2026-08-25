local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local TAG = EM.MODULE.AEGIS .. "aegis"
local EJOY_AEGIS_CLIENT_ID = 1015
local EJOY_LOGIN_SCENE = 1
local EJOY_LOGIN_SCENE_WIN = 3
local AEGIS_URL = "https://general.aligames.com/ieu-sdk-h5/challenge.html"
local AEGIS_URL_DEBUG = "https://general.aligames.com/ieu-sdk-h5-test/challenge.html"
local aegis_callback, target_ptoken
local l_env = ECC.ENV.RELEASE
local AEGIS_LOGIN_CLOSE_EVENT_DATA = "aegis_login_error"
local aegis_result = {challenge_data = nil}
local M = {}
M.ERR_CODE_REJECT_FOR_AEGIS_NEED_VERIFY = 424
M.ERR_CODE_REJECT_FOR_AEGIS_NEED_VERIFY_AGAIN = 425

function M.set_env(env)
  E.LOG.debug(TAG, "set_env: " .. tostring(env))
  l_env = env
end

local function show_aegis_webview(closeEventData, challenge_suggest, screen_orientation)
  local aegis_url
  local _scene = EJOY_LOGIN_SCENE
  if E.Sysinfo.os() == "windows" then
    _scene = EJOY_LOGIN_SCENE_WIN
  end
  if l_env == ECC.ENV.DEBUG then
    aegis_url = AEGIS_URL_DEBUG
  else
    aegis_url = AEGIS_URL
  end
  local aegis_start_up_data = {
    clientId = EJOY_AEGIS_CLIENT_ID,
    scene = _scene,
    challengeType = challenge_suggest.challengeType,
    challengeInfo = challenge_suggest.challengeInfo
  }
  E.LOG.debug(TAG, "show_aegis_webview:" .. tostring(aegis_url))
  E.LOG.debug(TAG, challenge_suggest)
  E.WebView.open(aegis_url, {
    [".ejoy.com"] = {transparent = true, startupData = aegis_start_up_data},
    [".aligames.com"] = {transparent = true, startupData = aegis_start_up_data},
    ["magic-user-node2.daily.uc.cn"] = {transparent = true, startupData = aegis_start_up_data}
  }, {
    use_cutout = true,
    compactMode = true,
    closeEventData = closeEventData,
    screen_orientation = screen_orientation
  })
end

local function request_aegis_auth_eurl(challenge_data, ptoken, cb)
  local eg = require("ejoysdk_lua.ejoysdk_gangplank")
  local url = eg.gangplank_url("/auth_code", "2")
  E.LOG.debug(TAG, "request aegis auth begin, url:" .. tostring(url))
  local params = {}
  params.ptoken = ptoken
  params.challengeData = challenge_data
  params.pkg_info = E.get_pkg_info()
  E.HTTP.post(url, {
    trace = true,
    acceptable = E.HTTP.CT_JSON
  }, E.HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      if 0 == resp.body.code then
        cb(true, resp.body)
      else
        cb(false, resp.body.code, resp.body.message)
      end
    else
      cb(false, resp.status, "http error")
    end
  end)
end

local function webview_js_callback(_value)
  E.LOG.debug(TAG, "webview_js_callback receive agreement_result event!")
  local args = _value.args
  if args.type == "aegis_result" then
    aegis_result.challenge_data = args.challengeData
    E.LOG.debug(TAG, "webview_js_callback receive aegis_result，challenge data:" .. tostring(args.challengeData))
    ET.unsubscribe("webview_jsargs", webview_js_callback)
    E.WebView.close()
  end
end

local function webview_close_callback(_value)
  E.LOG.debug(TAG, "listen_webview_close_event")
  if not _value or _value.args ~= AEGIS_LOGIN_CLOSE_EVENT_DATA then
    local event_data = "nil"
    if _value and _value.args then
      event_data = _value.args
    end
    E.LOG.debug(TAG, "webview_close_callback not handled, close_event_data:" .. tostring(event_data))
    return
  end
  E.LOG.debug(TAG, aegis_result)
  if aegis_result.challenge_data ~= nil and aegis_result.challenge_data ~= "" then
    E.LOG.debug(TAG, "aegis page result: true, use challenge success")
    request_aegis_auth_eurl(aegis_result.challenge_data, target_ptoken, function(succ, ...)
      if aegis_callback then
        if succ then
          local body = (...)
          aegis_callback(true, body)
        else
          local _code, _msg = ...
          aegis_callback(false)
        end
      end
    end)
  else
    E.LOG.debug(TAG, "aegis page result: false, user challenge failed")
    if aegis_callback then
      aegis_callback(false)
    end
  end
  aegis_result = {challenge_data = nil}
  ET.unsubscribe("webview_close", webview_close_callback)
  ET.unsubscribe("webview_jsargs", webview_js_callback)
  E.LOG.debug(TAG, "unsubscribe event webview_close")
  E.LOG.debug(TAG, "unsubscribe event webview_jsargs")
end

function M.handle_login_reject_error(status, ptoken, challenge_suggest, cb)
  if status ~= M.ERR_CODE_REJECT_FOR_AEGIS_NEED_VERIFY then
    E.LOG.debug(TAG, "not handle aegis for status is not ok")
    return false
  end
  if nil == ptoken or "" == ptoken or nil == challenge_suggest then
    E.LOG.debug(TAG, "not handle aegis for ptoken or challenge_suggest is nil!")
    return false
  end
  local os = E.Sysinfo.os()
  if "windows" == os and not E.support_webview() then
    E.log("do not has webview component, return now.")
    return
  end
  E.LOG.debug(TAG, "handle_login_reject_error aegis handler handled this status")
  aegis_callback = cb
  target_ptoken = ptoken
  show_aegis_webview(AEGIS_LOGIN_CLOSE_EVENT_DATA, challenge_suggest)
  ET.unsubscribe("webview_jsargs", webview_js_callback)
  ET.unsubscribe("webview_close", webview_close_callback)
  ET.subscribe("webview_jsargs", webview_js_callback)
  ET.subscribe("webview_close", webview_close_callback)
  return true
end

return M
