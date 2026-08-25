local Vendor = require("ejoysdk_lua.vendors.vendor")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local E = require("ejoysdk_lua.ejoysdk")
local HTTP = E.HTTP
local QR_LOGIN_VENDOR_NAME = "QR_LOGIN"
local QR_LOGIN = Vendor:Inherit(QR_LOGIN_VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.QR_LOGIN_ACC
local cb_handler_info = {}

local function is_type_for_qr_login(url)
  local ret = HTTP.parse(url)
  E.LOG.debug(TAG, ret)
  if ret.query and ret.query.type then
    local type = ret.query.type
    if "qr_login" ~= type then
      return false
    end
  end
  return true
end

local function cb_handler(succ, token, new_nonce, _new_state, login_type)
  local nonce = cb_handler_info.nonce
  local channel_result
  if not succ then
    local error_info = token
    local code = error_info.code
    local msg = error_info.msg
    channel_result = PROTOCOL.LoginResult.fail(code, msg)
  elseif nonce and new_nonce ~= nonce then
    E.LOG.debug(TAG, "nonce: " .. tostring(nonce) .. " nonce cb: " .. tostring(new_nonce))
    local code = CONSTANTS.QR_LOGIN_ERROR_CODES.CODE_NONCE_ERROR
    local msg = "nonce error"
    channel_result = PROTOCOL.LoginResult.fail(code, msg)
  else
    channel_result = PROTOCOL.LoginResult.succ(QR_LOGIN_VENDOR_NAME, {token = token}, {thirdparty_type = login_type})
  end
  E.LOG.debug(TAG, "cb_handler ready to return")
  E.LOG.debug(TAG, {channel_result = channel_result})
  QR_LOGIN.login_cb(channel_result)
end

local function on_url(url)
  local ret = HTTP.parse(url)
  if ret.host == "sdk.ejoy.com" and ret.query then
    local query = ret.query
    if query.access_token and query.nonce and query.state then
      cb_handler(true, query.access_token, query.nonce, query.state, query.login_type)
    else
      E.LOG.warn(TAG, "query error")
      cb_handler(false, {
        code = CONSTANTS.QR_LOGIN_ERROR_CODES.CODE_OAUTH_FAILED,
        msg = "ouath error callback url"
      })
    end
  end
end

local function on_login_done(value)
  E.LOG.debug(TAG, "h5 on_login_done---")
  E.log(value)
  if not is_type_for_qr_login(value.args.uri) then
    E.LOG.debug(TAG, "type 不是 qr_login，直接返回")
    return
  end
  on_url(value.args.uri)
end

function QR_LOGIN.init(opt, cb)
  E.LOG.debug(TAG, "init called----")
  QR_LOGIN.opt = opt
  ET.subscribe("logindone", on_login_done)
  cb(true)
end

function QR_LOGIN.login(_ext, cb)
  QR_LOGIN.login_cb = cb
  E.LOG.debug(TAG, "call qrcode login")
end

function QR_LOGIN.check_token(_outsource, _info)
  QR_LOGIN.login()
end

function QR_LOGIN.logout()
  QR_LOGIN.opt.logout_listener({})
end

function QR_LOGIN.merge_info(info, pinfo)
  do return QR_LOGIN.merge_helper, info end
  return QR_LOGIN.merge_helper, info, pinfo
end

function QR_LOGIN.simple_token()
  return false
end

return QR_LOGIN
