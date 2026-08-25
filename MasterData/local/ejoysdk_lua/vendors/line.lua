local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local CONTS = require("ejoysdk_lua.ejoysdk_constants")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CHANNEL = "LINE"
local TAG = EM.MODULE.VENDORS.LINE
local M = Vendor:Inherit(CHANNEL)
local logout_listener
local LINE_TOKEN_PARAMS = E.LazyKeyStore:New("LINE_CURRENT_USER", false, true, false)

local function make_text_url_scheme(text)
  return "line://msg/text/" .. E.HTTP.escape(tostring(text))
end

local function make_image_url_scheme(image_url)
  local paste_type = "public.jpeg"
  local UTILS = require("ejoysdk_lua.ejoysdk_utils")
  local paste_name = UTILS.set_file_to_pasteboard(image_url, paste_type)
  return "line://msg/image/" .. paste_name
end

local function can_open_line()
  do return E.Sysinfo.can_open_url end
  return E.Sysinfo.can_open_url, "line://"
end

local function share_text(param, cb)
  if param.message == nil or 0 == #param.message then
    cb(false, CONTS.SHARE.CODE_SHARE_TEXT_EMPTY, "share text empty")
    return
  end
  local url_scheme = make_text_url_scheme(param.message)
  E.LOG.debug(TAG, "Line 分享文本: " .. tostring(url_scheme))
  E.Sysinfo.open_url(url_scheme)
  cb(true)
end

local function share_content_url(param, cb)
  if param.content_url == nil or 0 == #param.content_url then
    cb(false, CONTS.SHARE.CODE_SHARE_TEXT_EMPTY, "share text empty")
    return
  end
  local url_scheme = make_text_url_scheme(param.content_url)
  E.LOG.debug(TAG, "Line 分享链接: " .. tostring(url_scheme))
  E.Sysinfo.open_url(url_scheme)
  cb(true)
end

local function share_image(param, cb)
  param.media = param.media or {}
  param.media[1] = param.media[1] or {}
  local image_url = param.media[1].data
  if nil == image_url or 0 == #image_url then
    cb(false, CONTS.SHARE.CODE_IMAGE_FILE_EMPTY, "image file empty")
    return
  end
  local f = io.open(image_url, "r")
  if f then
    io.close(f)
  else
    cb(false, CONTS.SHARE.CODE_IMAGE_FILE_NOT_EXIST, "image file not exist")
    return
  end
  if E.Sysinfo.os() == "android" then
    local share_to_app_params = {
      message = param.message,
      image_url = image_url,
      package_name = "jp.naver.line.android",
      type = "image_url"
    }
    E.async_call("SHARE_TO_APP", share_to_app_params, nil, function(info)
      if info.succ then
        cb(true)
      else
        cb(false, CONTS.SHARE.CODE_SHARE_OPEN_FAIL, "share open fail")
      end
    end)
  else
    local url_scheme = make_image_url_scheme(image_url)
    E.LOG.debug(TAG, "Line 分享图片: " .. tostring(url_scheme))
    E.Sysinfo.open_url(url_scheme)
    cb(true)
  end
end

function M.share(param, _chunk_data, cb)
  E.LOG.debug(TAG, "line share >>>>")
  E.LOG.debug(TAG, param)
  if E.Sysinfo.os() == "android" or E.Sysinfo.os() == "ios" then
    if can_open_line() then
      if param.media and #param.media > 0 and param.media[1].type == "image_url" then
        share_image(param, cb)
      elseif param.message then
        share_text(param, cb)
      elseif param.content_url then
        share_content_url(param, cb)
      else
        cb(false, CONTS.SHARE.CODE_PARAM_NOT_SUPPORT, "share param not support")
      end
    else
      cb(false, CONTS.SHARE.CODE_APP_NOT_INSTALL, "app not install")
    end
  else
    cb(false, CONTS.SHARE.CODE_PLATFORM_NOT_SUPPORT, "not support share platform")
  end
end

function M.is_share_support()
  do return end
  return can_open_line, nil
end

M:is_implemented({
  Vendor.ABILITY.SHARE
})

function M.init(opt, cb)
  logout_listener = opt.logout_listener
  UNI.register_login_listener(CHANNEL, function(succ, info, ext_paramas)
    if succ then
      E.LOG.debug(TAG, "register_login_listener succ, info.token:" .. tostring(info.token) .. ", >>>>")
      E.LOG.debug(TAG, info)
      E.LOG.debug(TAG, "ext params >>>>")
      E.LOG.debug(TAG, ext_paramas)
      local token_params = {
        clientId = ext_paramas.channelId,
        token = info.token,
        userId = info.pid
      }
      LINE_TOKEN_PARAMS:set(token_params)
      E.LOG.debug(TAG, "token_params >>>>")
      E.LOG.debug(TAG, token_params)
      local userInfo = {
        token = JSON.encode(token_params),
        uid = info.pid,
        guest = false
      }
      local ext = {}
      local channel_result = PROTOCOL.LoginResult.succ(CHANNEL, userInfo, ext)
      if M.login_cb then
        M.login_cb(channel_result)
      end
    else
      E.LOG.warn(TAG, "register_login_listener failed >>")
      E.LOG.debug(TAG, info)
      local code = info.code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED
      local msg = info.msg or "login failed unknown reason"
      local channel_result = PROTOCOL.LoginResult.fail(code, msg)
      if M.login_cb then
        M.login_cb(channel_result)
      end
    end
  end)
  UNI.register_logout_listener(CHANNEL, function(ext_params)
    E.LOG.debug(TAG, "logout_listener >>")
    logout_listener(ext_params)
  end)
  cb(true)
end

function M.login(_ext, cb)
  M.login_cb = cb or function()
  end
  if _ejoysdk.os() == "windows" then
    local code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_NOT_SUPPORT
    local msg = "Not Support"
    local channel_result = PROTOCOL.LoginResult.fail(code, msg)
    M.login_cb(channel_result)
    return
  end
  local token_params = LINE_TOKEN_PARAMS:get()
  if token_params and type(token_params) == "table" and token_params.token then
    E.LOG.debug(TAG, "Line has history login >>")
    E.LOG.debug(TAG, token_params)
    local userInfo = {
      token = JSON.encode(token_params),
      uid = token_params.userId,
      guest = false
    }
    local ext = {}
    local channel_result = PROTOCOL.LoginResult.succ(CHANNEL, userInfo, ext)
    M.login_cb(channel_result)
    return
  end
  UNI.login(CHANNEL, {})
end

function M.merge_info(info, pinfo)
  do return M.merge_helper, info end
  return M.merge_helper, info, pinfo
end

function M.simple_token()
  return false
end

function M.check_token(_outsource, _info)
  M.login()
end

function M.login_fail(status, _last_login_params, _login_fail_callback)
  local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
  if 406 == status or status == USER.USER_CENTER_ERROR_CODES.ERR_SERVER_THIRD_PART then
    LINE_TOKEN_PARAMS:set(nil)
    UNI.login(CHANNEL, {})
    return true
  end
  return false
end

function M.logout()
  LINE_TOKEN_PARAMS:set(nil)
  UNI.logout(CHANNEL)
end

return M
