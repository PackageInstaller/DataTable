local E = require("ejoysdk_lua.ejoysdk")
local M = {}
local _token_data = {}
local _TAG = "ejoysdk_chat_token_util"

function M.update_token_data(token_data)
  _token_data = token_data
end

function M.reset_token_data()
  _token_data = {}
end

function M.get_chat_token()
  return _token_data.chat_token
end

function M.get_chat_token_info_key()
  if _token_data and _token_data.chat_token_info then
    return _token_data.chat_token_info.key
  end
  return nil
end

function M.get_chat_token_expire_time()
  if _token_data and _token_data.chat_token_info then
    return _token_data.chat_token_info.expire_time
  end
  return 0
end

function M.is_chat_token_valid()
  local expire_time = M.get_chat_token_expire_time()
  if expire_time - 1 > E.time() then
    return true
  end
  return false
end

function M.refresh_chat_token(cb)
  local chat_api = require("ejoysdk_lua.server_api.ejoysdk_chat_api")
  if M.is_chat_token_valid() then
    if cb then
      cb(true)
    end
    return
  else
    E.LOG.debug(_TAG, "chat_token is not valid, fetch new chat_token")
    chat_api.get_chat_token(function(succ, ...)
      if succ then
        local data = (...)
        M.update_token_data(data)
        if cb then
          cb(true)
        end
      else
        local code, msg = ...
        E.LOG.debug(_TAG, "refresh_chat_token fail, code:" .. tostring(code) .. ", msg" .. tostring(msg))
        if cb then
          cb(false)
        end
      end
    end)
  end
end

M.LOGIN_V1 = "login_v1"
M.LOGIN_V2 = "login_v2"
M.curr_login_version = M.LOGIN_V1
return M
