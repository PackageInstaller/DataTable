local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local CM = require("ejoysdk_lua.vm_channel.ejoy_vm_manager")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local LANG_UTIL = require("ejoysdk_lua.lang.util")
local CHANNEL = "HARMONY_ACCOUNT"
local M = Vendor:Inherit(CHANNEL)
local TAG = EM.MODULE.VENDORS.HARMONY_ACCOUNT
local HAS_CALL_UNION_LOGIN = E.LazyKeyStore:New("HAS_CALL_UNION_LOGIN", false, true, false)
local logout_listener, exit_listener, currentChannelPlayerId
local environmentStatus = false
local inited = false
M.CHANNEL = {HUAWEI = "982299", OFFICIAL = "998233"}

local function check_environment_status()
  E.async_call_once("harmony_query_environment_status", function(succ)
    environmentStatus = succ
  end)
end

local function update_channel_id_handler(user_info)
  if _ejoysdk.os() == "harmonyos" then
    local harmony_account = require("ejoysdk_lua.vendors.harmony_account")
    if user_info and user_info.platform == harmony_account.CHANNEL.HUAWEI then
      E.LOG.debug(TAG, "hook ds_channel_id to 998299")
      E.reset_channel()
      
      function E.Sysinfo.ds_channel_id()
        return harmony_account.CHANNEL.HUAWEI
      end
    else
      E.LOG.debug(TAG, "hook ds_channel_id to 998233")
      E.reset_channel()
      
      function E.Sysinfo.ds_channel_id()
        return harmony_account.CHANNEL.OFFICIAL
      end
    end
    local UIM = require("ejoysdk_lua.user_info_manager")
    UIM.refresh_channel_id()
    local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
    ESTAT.reset_env_info()
  end
end

local function verify_local_player(thirdOpenId, isRealName, isAdult, cb)
  E.LOG.debug(TAG, "verify local player-")
  E.async_call_once("verify_local_player", function(succ, ...)
    local code, message = ...
    local realNameInfo = {
      isRealName = succ,
      errorCode = code,
      errorMsg = message
    }
    E.LOG.debug(TAG, "verify local player return")
    E.log(realNameInfo)
    cb(realNameInfo)
  end, thirdOpenId, isRealName, isAdult)
end

local function set_player_info_handler(player_info, type)
  local role_info = {
    roleId = player_info.player_id,
    roleName = player_info.player_name,
    roleLevel = player_info.level,
    zoneId = player_info.server_id,
    zoneName = player_info.server_name,
    opportunityType = type
  }
  E.LOG.debug(TAG, "=================== set_role_info ===========================")
  E.LOG.debug(TAG, role_info)
  if "enterGame" ~= type then
    E.LOG.debug(TAG, "do not submit role info with not enterGame type")
  end
  check_environment_status()
  E.async_cast("harmony_create_set_player_info", player_info, currentChannelPlayerId)
end

local function logout_handler()
  E.LOG.debug(TAG, "receive gp logout event")
  HAS_CALL_UNION_LOGIN:set(false)
  update_channel_id_handler()
end

local function acquire_fail_handler()
  E.LOG.debug(TAG, "receive acquire fail event")
  HAS_CALL_UNION_LOGIN:set(false)
  update_channel_id_handler()
end

local function pack_channel_login_data(authCode, localPlayer)
  local user_info = {token = authCode}
  local channel_result = PROTOCOL.LoginResult.succ(M.CHANNEL.HUAWEI, user_info, {
    channel_info = {
      authorizationCode = authCode,
      gamePlayerId = localPlayer.gamePlayerId
    },
    login_params = {
      channelId = M.CHANNEL.HUAWEI
    }
  })
  return channel_result
end

function M.pre_init(_, cb)
  local ejoy_vm_func = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_account")
  ejoy_vm_func.init_game_player(function(is_success)
    cb(is_success)
  end)
end

function M.init(opt, cb)
  E.LOG.debug("init harmony_account")
  if inited then
    E.LOG.error("has call harmony_account init")
    cb(true)
    return
  end
  inited = true
  logout_listener = opt.logout_listener
  exit_listener = opt.exit_listener
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO_WITH_TYPE, set_player_info_handler)
  ET.subscribe(ET.gangplank.LOGOUT, logout_handler)
  ET.subscribe(ET.gangplank.ACQUIRE_FAILED, acquire_fail_handler)
  ET.subscribe(ET.gangplank.AUTH_SUCC, update_channel_id_handler)
  M.pre_init(opt, cb)
end

local function auth_request(cb)
  E.async_call_once("auth_request", function(succ, ...)
    if succ then
      local authCode = (...)
      if authCode then
        cb(true, authCode)
      end
    else
      local code, msg = ...
      E.LOG.debug(TAG, "auth request failure, code >> " .. tostring(code) .. ", msg >> " .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

function M.union_login(params, cb)
  E.LOG.debug(TAG, "call login")
  local showLoginDialog = true
  local has_call_union_login = HAS_CALL_UNION_LOGIN:get()
  E.LOG.debug(TAG, "has_call_union_login >> " .. tostring(has_call_union_login))
  if has_call_union_login then
    showLoginDialog = false
  end
  if params and params.is_huawei_auth then
    showLoginDialog = true
  end
  E.async_call_once("union_login", function(succ, accountName, needBinding, localPlayer)
    E.LOG.debug(TAG, "union login call back, accountName >> " .. tostring(accountName) .. ", need binding >> " .. tostring(needBinding))
    E.log(localPlayer)
    if succ then
      HAS_CALL_UNION_LOGIN:set(true)
      if "hw_account" == accountName then
        E.async_call_once("auth_request", function(succ2, ...)
          if succ2 then
            local authCode = (...)
            E.LOG.debug(TAG, "auth request success, auth code >> " .. tostring(authCode))
            local channel_result = pack_channel_login_data(authCode, localPlayer)
            cb(true, "hw_account", needBinding, channel_result)
          else
            local code, msg = ...
            E.LOG.debug(TAG, "auth request failure, code >> " .. tostring(code) .. ", msg >> " .. tostring(msg))
            if 1001502012 == code and localPlayer.teamPlayerId then
              E.LOG.debug(TAG, "call unbind player >>  " .. tostring(localPlayer.teamPlayerId))
              M.unbind_player("", localPlayer.teamPlayerId, function(success, ...)
                E.LOG.debug(TAG, "unbind player result >> " .. tostring(success))
              end)
            end
            cb(false, code, msg)
          end
        end, needBinding)
      elseif "官方账号登录" == accountName then
        cb(true, "official_account")
      end
    else
      local code = accountName
      local msg = needBinding
      cb(false, code, msg)
    end
  end, showLoginDialog)
end

local origin_cb
local is_union_login = false

function M.login(params, cb)
  origin_cb = cb
  is_union_login = true
  M.union_login(params, function(succ, ...)
    E.LOG.debug(TAG, "harmony_account login succ >> " .. tostring(succ))
    E.log({
      ...
    })
    is_union_login = false
    if succ then
      local account_name, needBinding, channel_result = ...
      if "hw_account" == account_name and false == needBinding then
        E.LOG.debug(TAG, "login_callback---called, result =")
        E.CONFIG.set_config(E.CONFIG.KEY.LINGXI_V2_SUPPORT, false)
        local account_login = require("ejoysdk_lua.account.service.account_login")
        account_login.refresh_account_login()
        E.LOG.debug(TAG, channel_result)
        if channel_result and channel_result:is_succ() then
          local config = E.CONFIG.get_vendor_config("HARMONY_ACCOUNT") or {}
          local client_id = config.client_id
          local authorization_info = {
            clientId = client_id,
            authCode = channel_result.token
          }
          channel_result.authorization_info = authorization_info
        end
        origin_cb(channel_result)
      else
        if true == needBinding then
          local authorizationCode = channel_result.token
          local config = E.CONFIG.get_vendor_config("HARMONY_ACCOUNT") or {}
          local client_id = config.client_id
          params.authorization_info = {clientId = client_id, authCode = authorizationCode}
        else
          params.authorization_info = nil
        end
        local airline_v2 = require("ejoysdk_lua.vendors.airline_v2")
        E.LOG.d(TAG, "use lingxi_v2")
        E.CONFIG.set_config(E.CONFIG.KEY.LINGXI_V2_SUPPORT, true)
        local account_login = require("ejoysdk_lua.account.service.account_login")
        account_login.refresh_account_login()
        params.invoke_timestamp = E.system_ms()
        airline_v2.login(params, function(result)
          E.LOG.debug(TAG, "login_callback---called, result = ")
          E.LOG.debug(TAG, result)
          if not is_union_login then
            origin_cb(result)
          else
            E.LOG.debug(TAG, "current is union login, do not callback")
          end
        end)
      end
    else
      local code, msg = ...
      E.LOG.debug(TAG, "harmonyos login fail, code >> " .. tostring(code) .. ", msg >> " .. tostring(msg))
      local result = PROTOCOL.LoginResult.fail(code, msg)
      origin_cb(result)
    end
  end)
end

function M.intercept_after_account_login(account_result, cb)
  local uid = (account_result or {}).uid or nil
  E.LOG.debug(TAG, "begin verify local player uid >> " .. tostring(uid))
  verify_local_player(uid, nil, nil, function(realNameInfo)
    if realNameInfo and realNameInfo.isRealName == false then
      cb(false, realNameInfo.errorCode, realNameInfo.errorMsg)
    else
      cb(true)
    end
  end)
end

function M.huawei_login(_params, cb)
  if origin_cb then
    local params = {}
    params.is_huawei_auth = true
    M.login(params, origin_cb)
  end
  local result = PROTOCOL.LoginResult.fail(-1, "huawei login")
  cb(result)
end

function M.huawei_auth(cb)
  auth_request(cb)
end

function M.bind_player(thirdOpenId, teamPlayerId, cb)
  E.async_call_once("bind_player", function(succ, ...)
    E.LOG.debug(TAG, "bind_player return, succ >> " .. tostring(succ))
    cb(succ, ...)
  end, thirdOpenId, teamPlayerId)
end

function M.unbind_player(thirdOpenId, teamPlayerId, cb)
  E.async_call_once("unbind_player", function(succ, ...)
    cb(succ, ...)
  end, thirdOpenId, teamPlayerId)
end

function M.logout()
  E.LOG.debug(TAG, "call logout")
  logout_listener({})
end

function M.pay(product_id, trade_id, pay_result_handler)
  E.LOG.debug(TAG, "call harmony os pay, product_id >> " .. tostring(product_id) .. ", trade_id: " .. tostring(trade_id))
  if false == environmentStatus then
    E.LOG.debug(TAG, "environmentStatus is false >> ")
    if pay_result_handler then
      pay_result_handler(false, trade_id, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_NOT_SUPPORT, "environmentStatus is false")
    end
    return
  end
  E.async_call_once("harmony_create_purchases", function(succ, ...)
    if pay_result_handler then
      pay_result_handler(succ, ...)
    end
  end, trade_id, product_id)
end

function M.finish_purchases(purchaseOrderInfo)
  E.async_cast("harmony_finish_purchases", purchaseOrderInfo)
end

function M.merge_info(_info, _pinfo)
  E.LOG.debug(TAG, "merge_info not implemented")
end

function M.simple_token()
  return false
end

function M.check_token(_outsource, _info)
  E.LOG.debug(TAG, "check_token not implemented")
end

function M.exit()
  local title = LANG_UTIL.getStringSuitCNOverseas("exit_alert_title", "")
  local options = {
    style = "lingxi",
    message = LANG_UTIL.getStringSuitCNOverseas("exit_alert_content", ""),
    buttons = {
      LANG_UTIL.getStringSuitCNOverseas("exit_alert_ensure", ""),
      LANG_UTIL.getStringSuitCNOverseas("exit_alert_cancel", "")
    }
  }
  
  local function cb(res)
    if 0 == res then
      exit_listener(true)
    else
      exit_listener(false)
    end
  end
  
  E.Modal.open(title, options, cb)
end

M:is_implemented({"ACCOUNT"})
return M
