local E = require("ejoysdk_lua.ejoysdk")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local UP = require("ejoysdk_lua.user_center.usercenter_protocol")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local AGST = require("ejoysdk_lua.vendors.agst_account")
local AGST_TOKEN = require("ejoysdk_lua.user_center.agst_token_manager")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local TAG = "account#service#overseas_account_login#"
local M = {}

local function is_sandbox_user(taglist)
  if type(taglist) == "table" then
    for _, value in ipairs(taglist) do
      if 3 == value then
        return true
      end
    end
  end
  return false
end

function M.account_login(login_type, origin_ext, channel_result, account_login_cb)
  if channel_result and channel_result:is_succ() and channel_result.ext.token_type == PROTOCOL.TOKEN_TYPE.ACCOUNT then
    account_login_cb(channel_result)
    return
  end
  AGST_TOKEN.get_token(function(agst_token)
    local guest_policy = channel_result.ext.guest_policy
    local challenge_info = channel_result.ext.challenge_info
    E.LOG.debug(TAG, "start login user center, show loading")
    E.Loading.show()
    USER.login(login_type, channel_result.token, agst_token, guest_policy, challenge_info, origin_ext, function(succ, ...)
      local account_result
      E.LOG.debug(TAG, "login user center finish, hide loading")
      E.Loading.dismiss()
      if succ then
        local user_data = (...)
        local LOGIN_API = require("ejoysdk_lua.account.api.login")
        local uid = LOGIN_API.get_uid_adapter_ejoyId(user_data)
        account_result = PROTOCOL.LoginResult.succ(login_type, {
          token = user_data.token or "",
          uid = uid
        }, {
          account_data = user_data,
          token_type = PROTOCOL.TOKEN_TYPE.ACCOUNT
        })
        E.LOG.debug(TAG, {user_data = user_data})
        channel_result.ext.is_sandbox_user = is_sandbox_user(user_data.tagList) or nil
      else
        local err_code, err_msg, user_data = ...
        account_result = PROTOCOL.LoginResult.fail(err_code, err_msg, {account_data = user_data})
      end
      channel_result.ext.guest_policy = nil
      channel_result.ext.challenge_info = nil
      if E.CONFIG.get_config(E.CONFIG.KEY.LINGXI_V2_SUPPORT) == true then
        if channel_result.ext.origin_platform then
          channel_result.platform = channel_result.ext.origin_platform
        end
        channel_result.ext.origin_platform = nil
        channel_result.ext.thirdparty_type = nil
        channel_result.ext.account_os = nil
      end
      account_result.ext.channel_result = channel_result
      E.LOG.debug(TAG, "account_login finish, account_result ====")
      E.LOG.debug(TAG, account_result)
      account_login_cb(account_result)
    end)
  end)
end

local function account_bind(login_type, _origin_ext, channel_result, account_login_cb)
  E.LOG.debug(TAG, "account_bind  called---, login_type = " .. tostring(login_type))
  E.LOG.debug(TAG, {channel_result = channel_result})
  AGST_TOKEN.get_token(function(agst_token)
    local function bind_callback(succ, ...)
      local account_result
      
      if succ then
        local EG = require("ejoysdk_lua.ejoysdk_gangplank")
        local last_login_vendor = EG.get_last_login()
        EG.set_last_login(login_type)
        local AGST_VENDOR_NAME = "AGST"
        AGST.mark_agst_official()
        if last_login_vendor == AGST_VENDOR_NAME and login_type ~= AGST_VENDOR_NAME then
          E.LOG.warn(TAG, "bind_user_center succ, and need logout for agst change to regular account")
          local userinfo = EG.user_info() or {}
          userinfo.platform = login_type
          userinfo.guest = false
          local ET = require("ejoysdk_lua.ejoysdk_topic")
          ET.publish(ET.gangplank.USER_INFO_UPDATE, userinfo)
        end
        local user_data = (...)
        local LOGIN_API = require("ejoysdk_lua.account.api.login")
        local uid = LOGIN_API.get_uid_adapter_ejoyId(user_data)
        account_result = PROTOCOL.LoginResult.succ(login_type, {
          token = user_data.token or "",
          uid = uid
        }, {
          account_data = user_data,
          token_type = PROTOCOL.TOKEN_TYPE.ACCOUNT
        })
        ESTAT.stat_action("bind_result", login_type, succ)
      else
        local code, msg = ...
        account_result = PROTOCOL.LoginResult.fail(code, msg)
        ESTAT.stat_action_fail("bind_result", login_type, ...)
      end
      account_result.ext.channel_result = channel_result
      E.LOG.debug(TAG, "account_bind finish, account_result ====")
      E.LOG.debug(TAG, account_result)
      account_login_cb(account_result)
    end
    
    local guest_policy = channel_result.ext.guest_policy
    if guest_policy == UP.GUEST_POLICY.BIND then
      USER.login(login_type, channel_result.token, agst_token, guest_policy, nil, _origin_ext, bind_callback)
    else
      USER.bind(agst_token, login_type, channel_result.token, bind_callback)
    end
  end)
end

function M.account_login_fail(login_type, origin_ext, account_result, origin_cb)
  E.LOG.debug(TAG, "account_login_fail called---")
  E.LOG.debug(TAG, {
    login_type = login_type,
    origin_ext = origin_ext,
    account_result = account_result
  })
  if account_result.code == USER.USER_CENTER_ERROR_CODES.ERR_AGST_ROLE_BIND_CONFLICT then
    local function agst_transfer_real_account_intercept(caller, ext, bind_callback)
      local channel_result = account_result.ext.channel_result or {}
      
      UTILS.merge_table(channel_result.ext or {}, ext or {})
      if "PGA_LOGIN" == login_type then
        local pga_login = EV.get(login_type) or {}
        pga_login.update_auth_code(channel_result.token, function(new_token)
          channel_result.token = new_token
          caller(login_type, origin_ext, channel_result, bind_callback)
        end)
      else
        caller(login_type, origin_ext, channel_result, bind_callback)
      end
    end
    
    function account_result.ext.create_new_account()
      E.LOG.debug(TAG, "create_new_account click")
      agst_transfer_real_account_intercept(M.account_login, {
        guest_policy = UP.GUEST_POLICY.IGNORE
      }, origin_cb)
    end
    
    function account_result.ext.bind_agst()
      E.LOG.debug(TAG, "bind_guest click")
      agst_transfer_real_account_intercept(account_bind, {
        guest_policy = UP.GUEST_POLICY.BIND
      }, origin_cb)
    end
  elseif account_result.code == USER.USER_CENTER_ERROR_CODES.ERR_NEED_CHALLENGE then
    E.LOG.debug(TAG, "账号登录失败，触发风控")
    account_result.ext.account_data = account_result.ext.account_data or {}
    account_result.ext.account_data.ptoken = account_result.ext.channel_result and account_result.ext.channel_result.token or ""
    
    function account_result.ext.login_with_challenge(challenge_info)
      E.LOG.debug(TAG, "风控挑战结束，继续账号登录, challenge_info =")
      E.LOG.debug(TAG, challenge_info)
      if challenge_info then
        local channel_result = account_result.ext.channel_result or {}
        channel_result.ext.challenge_info = challenge_info
        M.account_login(login_type, origin_ext, channel_result, origin_cb)
      else
        origin_cb(PROTOCOL.LoginResult.fail(CONSTANTS.USER_CENTER_ERROR_CODES.CODE_CHALLENGE_INFO_EMPTY, "Challenge info is empty"))
      end
    end
  end
  origin_cb(account_result)
end

function M.bind(bind_type, origin_ext, origin_cb)
  E.LOG.debug(TAG, "bind function called---")
  E.LOG.debug(TAG, "bind_type = " .. tostring(bind_type))
  E.LOG.debug(TAG, {origin_ext = origin_ext})
  origin_cb = origin_cb or function()
  end
  local vendor = EV.get(bind_type)
  if not vendor or not vendor.bind then
    E.LOG.debug(TAG, "bind vendor_name not has bind method, return:" .. bind_type)
    origin_cb(CONSTANTS.OFFICIAL_ERR_CODES.CODE_BIND_NOT_SUPPORT, "Channel Vendor Not Support To Bind")
    return
  end
  
  local function bind_callback(bind_result)
    E.LOG.d(TAG .. "bind", {account_result = bind_result})
    if not bind_result then
      origin_cb(PROTOCOL.LoginResult.fail(CONSTANTS.USER_CENTER_ERROR_CODES.CODE_ACCOUNT_BIND_RESULT_EMPTY, "Bind failed, bind result is empty"))
      return
    end
    if bind_result:is_succ() then
      origin_cb(bind_result)
    else
      local err_code = bind_result.code
      if err_code == USER.USER_CENTER_ERROR_CODES.ERR_TOKEN_EXPIRED or err_code == USER.USER_CENTER_ERROR_CODES.ERR_TOKEN_INVALID then
        E.LOG.warn(TAG, "bind err_code:" .. err_code .. ", token is invalid or expired, now need logout")
        local EG = require("ejoysdk_lua.ejoysdk_gangplank")
        EG.logout()
      end
      if vendor.login_fail and vendor.login_fail(err_code, nil, function(code, msg)
        origin_cb(PROTOCOL.LoginResult.fail(code, msg))
      end) then
        E.LOG.debug(TAG, "handle bind fail for err_code: " .. tostring(err_code))
      else
        origin_cb(bind_result)
      end
      ESTAT.stat_action_fail("bind_result", bind_type, bind_result.code, bind_result.msg)
    end
  end
  
  local function login_callback(channel_result)
    E.LOG.d(TAG .. "bind", {channel_result = channel_result})
    if not channel_result then
      ESTAT.stat_action_fail("bind_result", bind_type, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_RESULT_EMPTY, "Channel result is empty, account_bind_fail")
    elseif channel_result:is_succ() then
      account_bind(bind_type, origin_ext, channel_result, bind_callback)
    else
      bind_callback(PROTOCOL.LoginResult.fail(channel_result.code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED, channel_result.msg or "Channel Login failed"))
    end
  end
  
  if vendor.bind_logout then
    E.LOG.debug(TAG, "bind_logout called")
    vendor.bind_logout(function(_ext_paramt)
      E.LOG.debug(TAG, "bind logout succ!")
      vendor.login(origin_ext, login_callback)
    end)
  else
    E.LOG.debug(TAG, "logout called")
    vendor.logout({vendor = bind_type})
    vendor.login(origin_ext, login_callback)
  end
end

return M
