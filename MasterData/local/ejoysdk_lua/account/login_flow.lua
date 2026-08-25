local E = require("ejoysdk_lua.ejoysdk")
local AL = require("ejoysdk_lua.account.service.account_login")
local ACCOUNT_USER = require("ejoysdk_lua.account.service.account_user")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local HISTORY = require("ejoysdk_lua.account.official_history")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EC = require("ejoysdk_lua.ejoysdk_config")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local MODULE_NAME = "LOGIN_FLOW"
local TAG = MODULE_NAME
local M = {}

function M.login(vendor_name, ext, origin_cb)
  E.LOG.debug(TAG, "set login vendor name >> " .. tostring(vendor_name))
  local login_data = {}
  
  local function frontpage_callback(succ, status)
    E.LOG.debug(TAG, "账号登录后拦截处理过程结束, succ = " .. tostring(succ) .. ", status = " .. tostring(status))
    if succ then
      origin_cb(true, login_data, ext)
    else
      local result = {
        code = status,
        msg = "Login Failed, handle_frontpage not pass"
      }
      local EG = require("ejoysdk_lua.ejoysdk_gangplank")
      EG.logout()
      origin_cb(false, result, ext)
      UTILS.toast_msg("login_user_frontpage_handler_fail", result.msg)
    end
  end
  
  AL.login(vendor_name, ext, function(account_result)
    E.LOG.debug(TAG, "账号登录结束，acount_result = ")
    E.LOG.debug(TAG, account_result)
    if not account_result then
      origin_cb(false, {
        code = CONSTANTS.USER_CENTER_ERROR_CODES.CODE_ACCOUNT_RESULT_EMPTY,
        msg = "Login Failed, Account result is empty"
      }, ext)
      return
    end
    if account_result:is_succ() then
      local user_data = account_result.ext and account_result.ext.account_data or {}
      local channel_result = account_result.ext and account_result.ext.channel_result or {}
      E.LOG.debug(TAG, {
        account_result_ext_account_data = user_data or {}
      })
      E.LOG.debug(TAG, {
        account_result_ext_channel_result = channel_result or {}
      })
      local login_channel = "ALIGAMES"
      local is_oversea = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
      if channel_result.platform == "NOONE" or channel_result.platform == "OTHERS" then
        login_channel = nil
      elseif is_oversea then
        login_channel = "OFFICIAL"
      end
      login_data.ptoken = account_result.token
      login_data.platform = channel_result.platform
      login_data.thirdPartyType = user_data.thirdPartyType
      login_data.with = login_channel
      login_data.openId = account_result.uid
      login_data.uid = account_result.uid
      login_data.pid = account_result.pid
      login_data.st = user_data.st
      login_data.isPga = user_data.isPga or false
      login_data.guest = channel_result.platform == "AGST"
      if _ejoysdk.os() == "windows" then
        login_data.ds_channel_id = user_data.channelId or channel_result.platform
      end
      login_data.ext = channel_result.ext or {}
      if channel_result.ext then
        login_data.is_sandbox_user = channel_result.ext.is_sandbox_user or nil
        channel_result.ext.is_sandbox_user = nil
      end
      if _ejoysdk.os() == "harmonyos" and login_data.platform and login_data.platform == "982299" then
        E.LOG.debug(TAG, "account platform is 982299, do not save history")
      elseif user_data.loginPolicy and 1 == user_data.loginPolicy then
        E.LOG.debug(TAG, "此时属于账号扫码登录方式，用户授权时选择了登录仅单次有效，不能保存到登录历史，且需要清除本账号的登录历史")
        HISTORY.delete(login_data.uid)
      else
        local login_vendor = USER.get_vendor_by_third_party_type(login_data.thirdPartyType) or login_data.thirdPartyType
        local vendor = EV.get(login_vendor)
        if vendor and vendor.need_sdk_login and vendor.need_sdk_login() then
          E.LOG.debug(TAG, "login vendor need sdk login >> " .. tostring(login_vendor))
        else
          HISTORY.update(login_data, user_data.thirdPartyInfo)
        end
      end
      ACCOUNT_USER.handle_frontpage(user_data.frontParam, function(succ, status)
        if true == succ then
          local ET = require("ejoysdk_lua.ejoysdk_topic")
          ET.publish(ET.ACCOUNT.LOGIN, account_result)
        end
        frontpage_callback(succ, status)
      end)
    else
      E.LOG.debug(TAG, "login fail and login vendor is " .. tostring(vendor_name))
      
      local function ensure_callback()
        local result = {
          code = account_result.code,
          msg = account_result.msg
        }
        origin_cb(false, result, ext)
      end
      
      local auto_login = require("ejoysdk_lua.vendors.auto_login")
      if auto_login.is_silent_login() and not EC.get_config(EC.KEY.CLOSE_SILENT_LOGIN_TIPS) then
        auto_login.show_retry_login_tips(account_result.code, ensure_callback)
      else
        ensure_callback()
      end
    end
  end)
end

return M
