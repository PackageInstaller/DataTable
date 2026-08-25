local E = require("ejoysdk_lua.ejoysdk")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local DS_API = require("ejoysdk_lua.protocol.ds_api")
local TAG = "account#service#aligames_account_login#"
local M = {}

local function is_sandbox_user(taglist)
  if type(taglist) == "table" then
    for _, value in ipairs(taglist) do
      if 2 == value or "2" == value then
        return true
      end
    end
  end
  return false
end

local function suit_channel_ext_channel_info(channel_result)
  if channel_result and channel_result.ext and type(channel_result.ext) == "table" then
    channel_result.ext.login_params = nil
    channel_result.ext.channel_info = nil
  end
  return channel_result
end

function M.account_login(login_type, _origin_ext, channel_result, account_login_cb)
  if channel_result and channel_result:is_succ() and channel_result.ext.token_type == PROTOCOL.TOKEN_TYPE.ACCOUNT then
    channel_result.ext.channel_result = suit_channel_ext_channel_info(channel_result.ext.channel_result)
    account_login_cb(channel_result)
    return
  end
  local login_params = channel_result.ext.login_params
  local channel_info = channel_result.ext.channel_info
  E.LOG.debug(TAG, "login_type = " .. tostring(login_type))
  DS_API.login(login_params, channel_info, function(succ, user_data)
    local account_result
    if succ then
      account_result = PROTOCOL.LoginResult.succ(login_type, {
        token = user_data.token or "",
        uid = user_data.userId or ""
      }, {
        account_data = user_data,
        channel_info = channel_info,
        token_type = PROTOCOL.TOKEN_TYPE.ACCOUNT
      })
    else
      local err_code, err_msg = user_data.code, user_data.msg
      account_result = PROTOCOL.LoginResult.fail(err_code, err_msg, {account_data = user_data, channel_info = channel_info})
    end
    channel_result.ext.is_sandbox_user = is_sandbox_user(user_data.ex and user_data.ex.tagList)
    account_result.ext.channel_result = suit_channel_ext_channel_info(channel_result)
    E.LOG.debug(TAG, "ds_login finish, account_result ====")
    E.LOG.debug(TAG, account_result)
    account_login_cb(account_result)
  end)
end

function M.account_login_fail(_login_type, _origin_ext, account_result, origin_cb)
  E.LOG.debug(TAG, "account_login_fail called ---")
  origin_cb(account_result)
end

function M.bind()
end

return M
