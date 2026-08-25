local E = require("ejoysdk_lua.ejoysdk")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local CHANNEL = "HW_LOGIN"
local UNISDK_CHANNEL = "HW_LOGIN"
local TAG = EM.MODULE.VENDORS.HW_LOGIN
local M = Vendor:Inherit(CHANNEL)
local logout_listener, switch_listener, exit_listener

function M.init(opt, cb)
  logout_listener = opt.logout_listener
  switch_listener = opt.switch_listener
  exit_listener = opt.exit_listener
  E.LOG.debug(TAG, "start init!")
  UNI.register_login_listener(UNISDK_CHANNEL, function(succ, info, ext_params)
    if succ then
      E.LOG.debug(TAG, ext_params)
      local outsource = {
        platform = UNISDK_CHANNEL,
        ptoken = info.token,
        guest = false,
        ext = {
          opcode = ext_params and ext_params.opcode
        }
      }
      if ext_params and ext_params.is_switch then
        switch_listener(outsource, {})
      else
        local userInfo = {
          token = info.token,
          guest = false,
          ext = {
            opcode = ext_params and ext_params.opcode
          }
        }
        local channel_result = PROTOCOL.LoginResult.succ(UNISDK_CHANNEL, userInfo, {})
        M.login_cb(channel_result)
      end
    elseif not ext_params or not ext_params.is_switch then
      local code = info.code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED
      local msg = info.msg or "login failed unknown reason"
      local channel_result = PROTOCOL.LoginResult.fail(code, msg)
      M.login_cb(channel_result)
    end
  end)
  UNI.register_logout_listener(UNISDK_CHANNEL, function(ext_params)
    logout_listener(ext_params)
  end)
  UNI.register_exit_cb(UNISDK_CHANNEL, function(succ)
    exit_listener(succ)
  end)
  cb(true)
end

function M.use_user_center()
  return true
end

function M.login(_ext, cb)
  M.login_cb = cb
  UNI.login(UNISDK_CHANNEL, {})
end

function M.logout()
  UNI.logout(UNISDK_CHANNEL)
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

function M.can_pay()
  return false
end

function M.exit()
  UNI.exit(UNISDK_CHANNEL)
end

M:is_implemented({"ACCOUNT"})
return M
