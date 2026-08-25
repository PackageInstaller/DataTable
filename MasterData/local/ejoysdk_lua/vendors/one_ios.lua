local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local VENDOR_NAME = "ONE"
local M = Vendor:Inherit(VENDOR_NAME)
local logout_listener
local ONE_ACCESS_TOKEN = E.LazyKeyStore:New("ONE_ACCESS_TOKEN", false, false, false)
local ONE_EXPIRE_TIME = E.LazyKeyStore:New("ONE_EXPIRE_TIME", false, false, false)
local TAG = EM.MODULE.VENDORS.ONE_IOS
local token_expiry_duration = 86400

function M.channel_id()
  return 998244
end

local function set_store(access_token, expire_time)
  ONE_ACCESS_TOKEN:set(access_token)
  ONE_EXPIRE_TIME:set(expire_time)
end

local function get_store()
  return ONE_ACCESS_TOKEN:get(), ONE_EXPIRE_TIME:get()
end

local function delete_store()
  ONE_ACCESS_TOKEN:delete()
  ONE_EXPIRE_TIME:delete()
end

local function callback_with_token(channel_token, account_token)
  local login_params = {
    channelId = M.channel_id()
  }
  local ex_info = {loginType = "ding", authCode = channel_token}
  local channel_result = PROTOCOL.LoginResult.succ(tostring(login_params.channelId), {token = channel_token}, {login_params = login_params, channel_info = ex_info})
  local login_result = channel_result
  if account_token then
    login_result = PROTOCOL.LoginResult.succ(tostring(login_params.channelId), {token = account_token}, {
      token_type = PROTOCOL.TOKEN_TYPE.ACCOUNT,
      channel_result = channel_result
    })
  end
  M.login_cb(login_result)
end

local function account_login_handler(login_result)
  if login_result and login_result:is_succ() then
    E.LOG.d(TAG, "dasheng account login finished succ ")
    local user_data = login_result.ext.account_data or {}
    local channel_info = login_result.ext.channel_info or {}
    if user_data and user_data.token and channel_info and channel_info.loginType == "ding" then
      local expireTime = tonumber(os.time()) + token_expiry_duration
      if user_data.ex and user_data.ex.expireTime then
        expireTime = tonumber(user_data.ex.expireTime)
      end
      set_store(user_data.token, expireTime)
    end
  end
end

function M.init(opt, cb)
  function logout_listener(...)
    delete_store()
    
    local fun = opt.logout_listener
    if fun then
      fun()
    end
  end
  
  UNI.register_login_listener(VENDOR_NAME, function(succ, info, _ext_params)
    E.LOG.debug(TAG, "login result ===")
    E.LOG.debug(TAG, info)
    if succ then
      callback_with_token(info.token)
    else
      delete_store()
      E.LOG.warn(TAG, "lua ding auth fail")
      E.LOG.debug(TAG, info)
      local code = info.code
      local msg = info.msg
      local channel_result = PROTOCOL.LoginResult.fail(code, msg)
      M.login_cb(channel_result)
    end
  end)
  ET.subscribe(ET.ACCOUNT.LOGIN, account_login_handler)
  cb(true)
end

function M.login(_ext, cb)
  M.login_cb = cb
  local account_token, expire_time = get_store()
  expire_time = tonumber(expire_time)
  local time_now = tonumber(os.time())
  E.LOG.debug(TAG, "expire_time ===" .. tostring(expire_time))
  E.LOG.debug(TAG, "time_now ===" .. tostring(time_now))
  if account_token and expire_time and expire_time > time_now then
    E.LOG.debug(TAG, "one quick login use ds_token")
    callback_with_token(nil, account_token)
    return
  end
  UNI.login(VENDOR_NAME, {})
end

function M.merge_info(info, pinfo)
  do return M.merge_helper, info end
  return M.merge_helper, info, pinfo
end

function M.simple_token()
  return false
end

function M.check_token(_outsource, _info)
  M.login({}, M.login_cb)
end

function M.logout()
  delete_store()
  logout_listener({})
end

function M.login_fail(status, _last_login_params, _cb)
  delete_store()
  if 4001002 == status then
    M.login(nil, M.login_cb)
    return true
  end
  return false
end

function M.open_user_center(_screen_orientation, _options, close_cb)
  E.log("ONE not support user center page")
  if close_cb then
    close_cb()
  end
end

M:is_implemented({"ACCOUNT"})
return M
