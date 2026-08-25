local E = require("ejoysdk_lua.ejoysdk")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local TAG = "account#service#account_login#"
local M = {}
local ACCOUNT, account_login, account_login_fail

local function init()
  if E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) == true or true == E.CONFIG.get_config(E.CONFIG.KEY.LINGXI_V2_SUPPORT) then
    E.LOG.d(TAG, "overseas protocol")
    ACCOUNT = require("ejoysdk_lua.account.service.overseas_account_login")
  else
    E.LOG.d(TAG, "aligames protocol")
    ACCOUNT = require("ejoysdk_lua.account.service.aligames_account_login")
  end
  account_login = ACCOUNT.account_login
  account_login_fail = ACCOUNT.account_login_fail
  M.bind = ACCOUNT.bind
end

function M.refresh_account_login()
  init()
end

function M.login(login_type, origin_ext, origin_cb)
  if not ACCOUNT then
    init()
  end
  local vendor = EV.get(login_type)
  local vendor_login_span = ATracer.start_login_sub_span(ATracer.ACCOUNT_FLOWS_SPANS.VENDOR_LOGIN)
  
  local function origin_cb_wrapper(account_result)
    ATracer.finish_login_sub_span(vendor_login_span, account_result)
    if origin_cb then
      origin_cb(account_result)
    end
  end
  
  if vendor then
    local function account_login_callback(account_result)
      E.LOG.d(TAG .. "login", {account_result = account_result})
      
      if not account_result then
        origin_cb_wrapper(PROTOCOL.LoginResult.fail(CONSTANTS.USER_CENTER_ERROR_CODES.CODE_ACCOUNT_RESULT_EMPTY, "Login failed, Account result is empty"))
        return
      end
      if account_result:is_succ() then
        if type(vendor.intercept_after_account_login) == "function" then
          vendor.intercept_after_account_login(account_result, function(succ, code, msg)
            if succ then
              origin_cb_wrapper(account_result)
            else
              local format_msg = "[" .. tostring(code) .. "]" .. tostring(msg)
              origin_cb_wrapper(PROTOCOL.LoginResult.fail(CONSTANTS.USER_CENTER_ERROR_CODES.CODE_VENDOR_INTERCEPT_FAIL, format_msg))
            end
          end)
        else
          origin_cb_wrapper(account_result)
        end
      elseif vendor.login_fail and vendor.login_fail(account_result.code, nil, function()
        account_login_fail(login_type, origin_ext, account_result, origin_cb_wrapper)
      end) then
        E.LOG.debug(TAG, "handle login fail for err_code: " .. tostring(account_result.code))
      else
        account_login_fail(login_type, origin_ext, account_result, origin_cb_wrapper)
      end
    end
    
    local function channel_login_callback(channel_result)
      E.LOG.d(TAG .. "login", {channel_result = channel_result})
      if not channel_result then
        origin_cb_wrapper(PROTOCOL.LoginResult.fail(CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_RESULT_EMPTY, "Login failed, Channel result is empty"))
        return
      end
      if channel_result:is_succ() then
        account_login(login_type, origin_ext, channel_result, account_login_callback)
      else
        origin_cb_wrapper(channel_result)
      end
    end
    
    vendor.login(origin_ext, channel_login_callback)
  else
    origin_cb_wrapper(PROTOCOL.LoginResult.fail(CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_NOT_SUPPORT, "Channel Vendor Not Support"))
  end
end

return M
