local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local VENDOR_NAME = "OTHERS"
local _TAG = EM.MODULE.VENDORS.OTHERS
local M = Vendor:Inherit(VENDOR_NAME)
local logout_listener, user_id, user_token

function M.init(opt, cb)
  logout_listener = opt.logout_listener
  E.LOG.debug("OTHERS", "init---called")
  cb(true)
end

local function exec_login(cb)
  assert(user_token, "please invoke VENDOR_OTHERS.set_token(token) before login")
  local account_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, {token = user_token}, {
    token_type = PROTOCOL.TOKEN_TYPE.ACCOUNT,
    channel_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, {token = user_token})
  })
  if user_id then
    account_result.pid = user_id
  end
  if cb then
    cb(account_result)
  end
end

function M.login(_ext, cb)
  E.LOG.d(_TAG, "others login start")
  exec_login(cb)
end

function M.set_token(token)
  user_token = token
end

function M.set_uid_and_token(uid, token)
  user_id = uid
  user_token = token
end

function M.merge_info(info, pinfo)
  do return M.merge_helper, info end
  return M.merge_helper, info, pinfo
end

function M.simple_token()
  return false
end

function M.check_token(_outsource, _info)
end

function M.logout()
  E.LOG.debug(_TAG, "OTHERS logout")
  if logout_listener then
    logout_listener({})
  end
end

M:is_implemented({"ACCOUNT"})
return M
