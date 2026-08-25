local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local PC_MANAGER = require("ejoysdk_lua.account.pc_channel_manager")
local UNISDK_CHANNEL = "ALIGAMES"
local TAG = EM.MODULE.VENDORS.ALIGAMES .. "#v1#"
local VENDOR_NAME = "AIRILNE_V1"
local M = Vendor:Inherit(VENDOR_NAME)
local EVENT_NOTIFY_ACCOUNT_DATA = "EVENT_NOTIFY_ACCOUNT_DATA"
local SYNC_UTDID = "SYNC_UTDID"
local SYNC_IS_EMULATOR = "SYNC_IS_EMULATOR"
local SYNC_GET_CHANNELID = "SYNC_GET_CHANNELID"
local SYNC_GET_SUB_CHANNELID = "SYNC_GET_SUB_CHANNELID"
local SYNC_GET_FT_VERSION = "SYNC_GET_FT_VERSION"
local SYNC_IS_DELETE_MSG_CHECK = "SYNC_IS_DELETE_MSG_CHECK"
local SYNC_IS_DELETE_APP_UPDATE = "SYNC_IS_DELETE_APP_UPDATE"
local SYNC_IS_SUPPORT_ALI_AUTH = "SYNC_IS_SUPPORT_ALI" .. "PAY_AUTH"
local SYNC_SHOULD_LUA_LOGIN = "SYNC_SHOULD_LUA_LOGIN"
local SYNC_IS_SUPPORT_IOS_LOGOUT = "SYNC_IS_SUPPORT_IOS_LOGOUT"
local ASYNC_ALI_AUTH = "ASYNC_ALI" .. "PAY_AUTH"
local ASYNC_ALI_AUTH_V2 = "ASYNC_ALI" .. "PAY_AUTH_V2"
local ASYNC_READ_APK_CHANNEL_EXTRA_INFO = "ASYNC_READ_APK_CHANNEL_EXTRA_INFO"
local CAST_UPDATE_ALIGAMES_CLIENT_EXTRA_DATA = "CAST_UPDATE_ALIGAMES_CLIENT_EXTRA_DATA"
local CUR_PRODUCTCODE_SP = E.LazyKeyStore:New("EJOY_CUR_PRODUCTCODE_SP", false, false, false)
local aligames_login_data, logout_listener, switch_listener, exit_listener, login_callback
local aligames_ext_params = {}
local role_info = {}

local function logout_callback(params)
  logout_listener(params)
  aligames_login_data = nil
end

local function update_ext_params()
  E.LOG.debug(TAG, "init_handler CAST_UPDATE_ALIGAMES_CLIENT_EXTRA_DATA params >>")
  E.LOG.debug(TAG, aligames_ext_params)
  UNI.cast(UNISDK_CHANNEL, CAST_UPDATE_ALIGAMES_CLIENT_EXTRA_DATA, aligames_ext_params)
end

local function init_handler()
  E.LOG.debug(TAG, "监听到gangplank初始化成功")
  local UIM = require("ejoysdk_lua.user_info_manager")
  local cloud_game_info = UIM.get_cloud_game_info()
  local cloud_game_run_mode = cloud_game_info[UIM.PKG_INFO_KEY.KEY_CLOUD_GAME_RUN_MODE]
  aligames_ext_params.mobileRunMode = cloud_game_run_mode
  local product_code = E.CONFIG.get_config("product"):lower()
  aligames_ext_params.productCode = product_code
  update_ext_params()
  E.LOG.debug(TAG, "init save productcode:" .. tostring(product_code))
  CUR_PRODUCTCODE_SP:set(product_code)
end

local function productcode_change_handler()
  local cur_product = E.CONFIG.get_config("product")
  if cur_product ~= aligames_ext_params.productCode then
    E.LOG.debug(TAG, "update productCode:" .. tostring(cur_product) .. ", previous:" .. tostring(aligames_ext_params.productCode))
    aligames_ext_params.productCode = cur_product
    update_ext_params()
    CUR_PRODUCTCODE_SP:set(cur_product)
  end
end

local function set_player_info_handler(player_info, type)
  role_info = {
    roleId = player_info.player_id,
    roleName = player_info.player_name,
    roleLevel = player_info.level,
    zoneId = player_info.server_id,
    zoneName = player_info.server_name,
    opportunityType = type
  }
  E.LOG.debug(TAG, "=================== set_role_info ===========================")
  E.LOG.debug(TAG, role_info)
  UNI.set_player_info(UNISDK_CHANNEL, player_info, type)
end

function M.init(opt, cb)
  logout_listener = opt.logout_listener
  switch_listener = opt.switch_listener
  exit_listener = opt.exit_listener
  ET.subscribe(ET.gangplank.INITED, init_handler)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO_WITH_TYPE, set_player_info_handler)
  ET.subscribe(ET.config.CONFIG_CHANGED, productcode_change_handler)
  UNI.register_login_listener(UNISDK_CHANNEL, function(succ, info, ext_params)
    if succ then
      E.LOG.debug(TAG, "aligames login success")
      E.LOG.debug(TAG, "info ===")
      E.LOG.debug(TAG, info)
      E.LOG.debug(TAG, "ext_params ===")
      E.LOG.debug(TAG, ext_params)
      local token_type = PROTOCOL.TOKEN_TYPE.ACCOUNT
      if ext_params and ext_params.token_type == PROTOCOL.TOKEN_TYPE.CHANNEL then
        token_type = PROTOCOL.TOKEN_TYPE.CHANNEL
      end
      local AUTH_INFO = {
        platform = tostring(M.channel_id()),
        ptoken = info.token,
        guest = false,
        with = UNISDK_CHANNEL,
        with_account = nil,
        ext = {
          opcode = ext_params.opcode,
          token_type = token_type
        }
      }
      if ext_params and ext_params.cloudGameExt then
        local cloudGameExt = ext_params.cloudGameExt
        if cloudGameExt.cloudGameLogin then
          E.LOG.debug(TAG, "channel cloud game login stat")
          local UIM = require("ejoysdk_lua.user_info_manager")
          UIM.set_channel_cloud_game_tag(true)
          ESTAT.stat_action("channel_cloud_game_login", nil, true, cloudGameExt)
        else
          E.LOG.debug(TAG, "has cloudGameExt but cloudGameLogin is false")
        end
      end
      if ext_params and ext_params.is_switch then
        switch_listener(AUTH_INFO, {})
      else
        local user_info = {
          token = info.token,
          uid = info.userId
        }
        if ext_params and ext_params.channel_info and ext_params.channel_info.ucid and ext_params.channel_info.token and E.get_channel() == "998233" then
          local faceverify = require("ejoysdk_lua.vendors.faceverify")
          faceverify.update_lingxi_account_info(ext_params.channel_info.ucid, ext_params.channel_info.token)
        end
        local channel_result = PROTOCOL.LoginResult.succ(AUTH_INFO.platform, user_info, {
          channel_info = ext_params and ext_params.channel_info
        })
        local login_result = channel_result
        if token_type == PROTOCOL.TOKEN_TYPE.ACCOUNT then
          login_result = PROTOCOL.LoginResult.succ(UNISDK_CHANNEL, user_info, {
            token_type = PROTOCOL.TOKEN_TYPE.ACCOUNT,
            channel_result = channel_result
          })
        end
        if login_callback then
          login_callback(login_result)
        end
      end
    else
      if info and info.msg then
        local code = string.match(info.msg, "错误码=(-*%d+)")
        if code and #code > 0 then
          info.ds_code = code
        elseif info.code and #tostring(info.code) > 0 then
          info.ds_code = info.code
        end
        code = string.match(info.msg, "%((-*%d+)%)")
        if code and #code > 0 then
          info.ds_server_code = code
        elseif info.code and #tostring(info.code) > 0 then
          info.ds_server_code = code
        end
      end
      E.LOG.error(TAG, "aligames login fail info")
      E.LOG.error(TAG, info)
      local error_code = info.ds_code or info.ds_server_code or info.code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED
      local channel_result = PROTOCOL.LoginResult.fail(error_code, info.msg, ext_params)
      if login_callback then
        login_callback(channel_result)
      end
    end
  end)
  UNI.register_logout_listener(UNISDK_CHANNEL, function(ext_params)
    logout_callback(ext_params)
  end)
  UNI.register_exit_cb(UNISDK_CHANNEL, function(succ)
    exit_listener(succ)
  end)
  UNI.register_event_cb(UNISDK_CHANNEL, function(type, data)
    if type == EVENT_NOTIFY_ACCOUNT_DATA then
      aligames_login_data = data
      E.LOG.debug(TAG, "iOS灵犀登录接口返回数据 === ")
      E.LOG.debug(TAG, data)
    end
  end)
  cb(true)
end

function M.login(_params, cb)
  function login_callback(...)
    if cb then
      cb(...)
    end
  end
  
  local windows_channel_vendor
  if PC_MANAGER.check_is_pc_channel_pkg() then
    windows_channel_vendor = PC_MANAGER.get_channel_vendor()
  end
  if windows_channel_vendor and windows_channel_vendor.is_support_channel_sdk() then
    windows_channel_vendor.login(_params, cb)
    return
  end
  E.LOG.debug(TAG, "走原来灵犀1.0的native登录流程")
  local nonce = _ejoysdk_crypt.base64encode(_ejoysdk_crypt.randomkey())
  local login_params = _params or {}
  login_params.nonce = nonce
  UNI.login(UNISDK_CHANNEL, login_params)
end

function M.logout()
  E.LOG.debug(TAG, "logout called ---")
  aligames_login_data = nil
  if _ejoysdk.os() == "android" then
    UNI.logout(UNISDK_CHANNEL)
  elseif _ejoysdk.os() == "ios" then
    local value = UNI.sync_call(UNISDK_CHANNEL, SYNC_IS_SUPPORT_IOS_LOGOUT, {})
    if value and value.support then
      UNI.logout(UNISDK_CHANNEL)
    else
      logout_callback({})
    end
  else
    local windows_channel_vendor
    if PC_MANAGER.check_is_pc_channel_pkg() then
      windows_channel_vendor = PC_MANAGER.get_channel_vendor()
    end
    if windows_channel_vendor and windows_channel_vendor.is_support_channel_sdk() then
      windows_channel_vendor.logout()
      return
    end
    logout_callback({})
  end
end

function M.get_current_login_user_data()
  return aligames_login_data or {}
end

function M.utdid()
  local ret = UNI.sync_call(UNISDK_CHANNEL, SYNC_UTDID, {}) or {}
  return ret.value
end

function M.is_emulator()
  local ret = UNI.sync_call(UNISDK_CHANNEL, SYNC_IS_EMULATOR, {}) or {}
  return ret.value
end

function M.channel_id()
  local ret = UNI.sync_call(UNISDK_CHANNEL, SYNC_GET_CHANNELID, {}) or {}
  return ret.value
end

function M.sub_channel_id()
  local ret = UNI.sync_call(UNISDK_CHANNEL, SYNC_GET_SUB_CHANNELID, {}) or {}
  return ret.value
end

function M.get_ft_version()
  local ret = UNI.sync_call(UNISDK_CHANNEL, SYNC_GET_FT_VERSION, {})
  if ret and ret.value then
    E.LOG.debug(TAG, "get_ft_version success:" .. tostring(ret.value))
    return ret.value
  else
    E.LOG.warn(TAG, "get_ft_version failed")
    return ""
  end
end

function M.check_function_support(func)
  local ret = UNI.sync_call(UNISDK_CHANNEL, func, {})
  if ret and ret.value then
    E.LOG.debug(TAG, "check " .. func .. ": " .. tostring(ret.value))
    return ret.value
  else
    E.LOG.warn(TAG, "check " .. func .. " failed")
    return false
  end
end

function M.is_delete_msg_check()
  do return M.check_function_support end
  return M.check_function_support, SYNC_IS_DELETE_MSG_CHECK
end

function M.is_delete_app_update()
  do return M.check_function_support end
  return M.check_function_support, SYNC_IS_DELETE_APP_UPDATE
end

function M.should_lua_login()
  local os = _ejoysdk.os()
  return "android" == os and M.check_function_support(SYNC_SHOULD_LUA_LOGIN) or "ios" == os or "windows" == os or "douyin" == os or "weixin" == os
end

function M.is_support_ali_auth()
  if _ejoysdk.os() == "harmonyos" then
    E.LOG.debug(TAG, "os is harmonyos so not support ali auth")
    return false
  else
    local ret = UNI.sync_call(UNISDK_CHANNEL, SYNC_IS_SUPPORT_ALI_AUTH, {}) or {}
    return ret.value or false
  end
end

function M.ali_auth(auth_info, cb)
  local ali_auth_ver = ASYNC_ALI_AUTH
  if E.Sysinfo.os() == "android" then
    ali_auth_ver = ASYNC_ALI_AUTH_V2
  end
  E.LOG.debug(TAG, "ali_auth with native ali version:" .. ali_auth_ver)
  UNI.async_call(UNISDK_CHANNEL, ali_auth_ver, {auth_info = auth_info}, nil, function(succ, ...)
    E.LOG.debug(TAG, "lua ali_pay_simple_auth cb result: " .. tostring(succ))
    if succ then
      local auth_result = (...)
      E.log(auth_result)
      if E.Sysinfo.os() == "ios" then
        auth_result = auth_result or {}
        local resultStatus = auth_result.resultStatus
        local result = auth_result.result or {}
        local new_auth_result = "resultStatus={" .. tostring(resultStatus) .. "};memo={};"
        new_auth_result = new_auth_result .. "result={"
        for key, value in pairs(result) do
          new_auth_result = new_auth_result .. tostring(key) .. "=" .. "\"" .. tostring(value) .. "\"" .. "&"
        end
        new_auth_result = new_auth_result:sub(1, #new_auth_result - 1)
        new_auth_result = new_auth_result .. "}"
        E.LOG.debug(TAG, "new auth result: " .. tostring(new_auth_result))
        cb(true, new_auth_result)
      else
        local body = (...)
        if body and body.result then
          E.LOG.debug(TAG, "ali_auth result:" .. tostring(body.result))
          cb(true, body.result)
        else
          E.LOG.error(TAG, "ali_auth failed, result is empty!")
          E.LOG.error(TAG, body)
          cb(false)
        end
      end
    else
      cb(false)
    end
  end)
end

function M.exit()
  if E.CONFIG.get_config("os") == "android" then
    UNI.exit(UNISDK_CHANNEL)
  else
    exit_listener(true)
  end
end

function M.read_apk_channel_extra_info(key, cb)
  if E.Sysinfo.os() == "android" then
    UNI.async_call(UNISDK_CHANNEL, ASYNC_READ_APK_CHANNEL_EXTRA_INFO, {channel_extra_info_key = key}, nil, function(succ, ...)
      if succ then
        local body = (...)
        if body and body.result then
          E.LOG.debug(TAG, "read_apk_channel_extra_info key=" .. tostring(key) .. ", result=" .. tostring(body.result))
          cb(true, body.result)
        else
          E.LOG.warn(TAG, "read_apk_channel_extra_info failed, no result")
          E.LOG.warn(TAG, body)
          cb(false)
        end
      else
        E.LOG.warn(TAG, "read_apk_channel_extra_info failed")
        cb(false)
      end
    end)
  else
    E.LOG.warn(TAG, "read_apk_channel_extra_info, not implemented!")
  end
end

return M
