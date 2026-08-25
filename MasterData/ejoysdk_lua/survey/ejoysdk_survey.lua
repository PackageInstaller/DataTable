local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local TAG = EM.MODULE.SURVEY .. "survey"
local HTTP = E.HTTP
local GOOGLE_FORM_PREFIX = "https://docs.google.com/forms"
local GOOGLE_FORM_SUFFIX = "formResponse"
local GOOGLE_FORM_CLOSE_DELAY_SEC = 3
local SURVEY_SUBMIT_STATUS_EMPTY = {
  success = false,
  result_code = -1,
  result_msg = "canceled by user!"
}
local survey_submit_status = {
  success = SURVEY_SUBMIT_STATUS_EMPTY.success,
  result_code = SURVEY_SUBMIT_STATUS_EMPTY.result_code,
  result_msg = SURVEY_SUBMIT_STATUS_EMPTY.result_msg
}
local google_redirect_close_enable = false

local function _do_post(url, params, body, cb)
  HTTP.post(url, params, HTTP.CT_JSON, body, function(resp)
    if resp.status == 200 then
      if 0 == resp.body.code then
        cb(200, resp.body)
      else
        cb(resp.body.code, resp.body)
      end
    else
      cb(resp.status, resp.body or {})
    end
  end)
end

local function survey_url_base(api, url_base)
  return url_base .. api
end

local function survey_url(api)
  local url_base = E.CONFIG.get_config("game-adapter")
  if string.sub(api, 1, 1) ~= "/" then
    api = "/" .. api
  end
  do return survey_url_base, api end
  return survey_url_base, api, url_base, 1
end

local function request_get_survey_list(player_token, cb)
  E.LOG.debug(TAG, "get_survey_list, player_token:" .. tostring(player_token))
  if nil == player_token or "" == player_token then
    local err_msg = "get_survey_list failed, for moment-token is nil, should call this method after set role info!"
    E.LOG.debug(TAG, err_msg)
    cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_PLAYER_TOKEN_INVALID, err_msg)
    return
  end
  local api = "/survey/list"
  local url = survey_url(api)
  E.LOG.debug(TAG, "get_survey_list, url:" .. tostring(url))
  assert(url, "get_survey_list api: " .. api .. " not found")
  local params = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["Moment-Token"] = player_token
    }
  }
  local temp_body = {
    lang = E.CONFIG.get_config("lang")
  }
  E.LOG.debug(TAG, "post params---")
  E.LOG.debug(TAG, params)
  _do_post(url, params, temp_body, function(status, body)
    if 200 == status then
      cb(true, body.data)
    else
      cb(false, body.code or status, body.message or "")
    end
  end)
end

local function request_get_survey_detail(player_token, res_id, cb)
  E.LOG.debug(TAG, "get_survey_detail")
  if nil == player_token or "" == player_token then
    local err_msg = "get_survey_detail failed. moment-token is nil, should call this method after set role info!"
    E.LOG.debug(TAG, err_msg)
    cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_PLAYER_TOKEN_INVALID, err_msg)
    return
  end
  local api = "/survey/detail"
  local url = survey_url(api)
  E.LOG.debug(TAG, "get_survey_detail, url:" .. tostring(url))
  assert(url, "get_survey_detail api: " .. tostring(api) .. " not found")
  local params = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["Moment-Token"] = player_token
    }
  }
  local temp_body = {
    lang = E.CONFIG.get_config("lang"),
    resource_id = res_id
  }
  _do_post(url, params, temp_body, function(status, body)
    if 200 == status then
      cb(true, body)
    else
      cb(false, body.code or status, body.message or "")
    end
  end)
end

function M.get_survey_list(cb)
  E.LOG.debug(TAG, "开始获取问卷列表")
  local player_token = EH.get_player_token()
  if nil == player_token then
    cb(false, 0, "角色登录游戏后才能获取问卷")
    return
  end
  request_get_survey_list(player_token, function(success, ...)
    if success then
      local survey_list = (...)
      E.LOG.debug(TAG, "获取问卷列表成功！")
      E.LOG.debug(TAG, survey_list)
      cb(true, ...)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "获取问卷列表失败, code: " .. tostring(code) .. " ,msg: " .. tostring(msg))
      cb(false, ...)
    end
  end)
end

local function reset_survey_submit_status()
  survey_submit_status.success = SURVEY_SUBMIT_STATUS_EMPTY.success
  survey_submit_status.result_code = SURVEY_SUBMIT_STATUS_EMPTY.result_code
  survey_submit_status.result_msg = SURVEY_SUBMIT_STATUS_EMPTY.result_msg
end

local function listen_webview_close_event(_service, cb)
  local function webview_close_callback(_value)
    ET.unsubscribe("webview_close", webview_close_callback)
    
    if survey_submit_status.success then
      cb(true, survey_submit_status.result_msg)
    else
      cb(false, survey_submit_status.result_code, survey_submit_status.result_msg)
    end
    reset_survey_submit_status()
  end
  
  ET.subscribe("webview_close", webview_close_callback)
end

local function startswith(str, substr)
  if nil == str or nil == substr then
    return nil, "the string or the sub-stirng parameter is nil"
  end
  if 1 ~= string.find(str, substr) then
    return false
  else
    return true
  end
end

local function update_survey_success(msg)
  survey_submit_status.success = true
  survey_submit_status.result_code = 0
  survey_submit_status.result_msg = msg
end

local function update_survey_fail(code, msg)
  survey_submit_status.success = false
  survey_submit_status.result_code = code
  survey_submit_status.result_msg = msg
end

local function listen_webview_redirect_event(service, _cb)
  if "google" == service then
    local function webview_redirect_callback(_value)
      local redirect_url = _value.url
      
      if startswith(redirect_url, GOOGLE_FORM_PREFIX) and UTILS.STR.endswith(redirect_url, GOOGLE_FORM_SUFFIX) then
        E.LOG.debug(TAG, "google 问卷提交成功！")
        update_survey_success("google survey submit success!")
        E.Timer.once(GOOGLE_FORM_CLOSE_DELAY_SEC, function()
          E.WebView.close()
        end)
      end
    end
    
    ET.subscribe("webview_url_redirect", webview_redirect_callback)
  end
end

local function listen_webview_js_event(_cb)
  local function webview_js_callback(_value)
    local args = _value.args
    
    if args.type == "survey" then
      if args.status == "success" then
        update_survey_success("submit success!")
      else
        update_survey_fail(-1, "submit err!")
      end
      ET.unsubscribe("webview_jsargs", webview_js_callback)
      E.WebView.close()
    end
  end
  
  ET.subscribe("webview_jsargs", webview_js_callback)
end

local function listen_redirect_game_event(cb)
  local function redirect_game_callback(result)
    E.LOG.debug(TAG, "监听到返回游戏")
    
    if result and result.referrerInfo and result.referrerInfo.extraData and result.referrerInfo.extraData.surveyStatus then
      if result.referrerInfo.extraData.surveyStatus == "success" then
        cb(true, "submit success!")
      else
        cb(false, -1, "submit err!")
      end
      ET.unsubscribe("APP_LIFE_CIRCLE_EVENT", redirect_game_callback)
    end
  end
  
  ET.subscribe("APP_LIFE_CIRCLE_EVENT", redirect_game_callback)
end

local function open_webview(url, screen_orientation)
  local default_hosts = {
    [".ejoybox.com"] = {},
    ["survey.alibaba-inc.com"] = {},
    ["survey.alibaba.com"] = {},
    ["survey.aiyun.com"] = {}
  }
  E.WebView.open(url, default_hosts, {
    compactMode = true,
    screen_orientation = screen_orientation or "portrait"
  })
end

function M.enable_close_on_google_redirect(enabled)
  if enabled then
    google_redirect_close_enable = true
  else
    google_redirect_close_enable = false
  end
end

function M.show_survey(resource_id, cb, screen_orientation)
  E.LOG.debug(TAG, "开始获取问卷详情")
  local player_token = EH.get_player_token()
  request_get_survey_detail(player_token, resource_id, function(success, ...)
    if success then
      local body = (...)
      if _ejoysdk.os() == "weixin" then
        _ejoysdk.log("survey url: " .. tostring(body and body.url) .. ", mini_app_id:" .. tostring(body and body.mini_app_id))
        local app_id = body and body.mini_app_id
        if not app_id then
          local meta = E.CONFIG.get_config("unisdk_meta")
          app_id = meta.survey_miniprogram_appid or ""
        end
        listen_redirect_game_event(cb)
        _ejoysdk.wx.navigateToMiniProgram({
          appId = app_id,
          extraData = {
            surveyUrl = body.url
          },
          success = function()
            E.LOG.debug(TAG, "跳转到问卷小程序成功")
          end,
          fail = function()
            E.LOG.debug(TAG, "跳转到问卷小程序失败")
          end
        })
        return
      end
      listen_webview_js_event(cb)
      listen_webview_close_event(body.service, cb)
      if google_redirect_close_enable then
        listen_webview_redirect_event(body.service, cb)
      end
      open_webview(body.url, screen_orientation or body.screen_orientation)
    else
      local code, msg = ...
      if 409 == code then
        cb(true, msg)
      else
        E.LOG.warn(TAG, "获取问卷详情失败, code: " .. tostring(code) .. " ,msg: " .. tostring(msg))
        cb(false, ...)
      end
    end
  end)
end

return M
