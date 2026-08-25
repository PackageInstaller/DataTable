local ET = require("ejoysdk_lua.ejoysdk_topic")
local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local M = {}
local TAG = EM.MODULE.CHAT .. "chat_states"
M.NO_PLAYER_TOKEN = "no_player_token"
M.GET_PLAYER_TOKEN = "get_player_token"
M.GET_PLAYER_TOKEN_AUTO_LOGIN = "get_player_token_auto_login"
M.GET_CHAT_TOKEN = "get_chat_token"
M.CONNECT_INVOKE = "connect_invoke"
M.CONNECT_START = "connect_start"
M.CONNECTING = "connecting"
M.CONNECTED = "connected"
M.DISCONNECT = "disconnect"
M.CONNECT_ERROR = "connect_error"
M.ERROR = "error"
M.LOGIN_SUCC = "login_succ"
M.LOGIN_FAIL = "login_fail"
M.RETRY_CONNECT = "retry_connect"
M.SERVER_OFFLINE = "server_offline"
M.USER_CLOSE = "user_close"
M.NO_LIMIT_RECONNECT_AT_NEXT_LOOP = "no_limit_reconnect_at_next_loop"
M.CONNECT_LOST = "connect_lost"
local current_state = M.NO_PLAYER_TOKEN
local inited = false
local reconnect_stats

function M.can_retry_connect()
  local map = {
    [M.CONNECT_ERROR] = true,
    [M.ERROR] = true,
    [M.SERVER_OFFLINE] = true,
    [M.USER_CLOSE] = true,
    [M.LOGIN_FAIL] = true,
    [M.DISCONNECT] = true,
    [M.GET_PLAYER_TOKEN] = true
  }
  return map[current_state] or false
end

function M.get_current_state()
  return current_state
end

function M.reset_current_state()
  current_state = M.NO_PLAYER_TOKEN
end

function M.log_stat(stat_key, stat_value)
  if not reconnect_stats then
    reconnect_stats = {}
  end
  reconnect_stats[stat_key] = stat_value
end

function M.init()
  if inited then
    return
  end
  inited = true
  ET.subscribe(ET.chat.UPDATE_STATE, function(new_state, login_result_params)
    if new_state == M.LOGIN_SUCC or new_state == M.LOGIN_FAIL then
      if login_result_params and login_result_params.destination == "chat" then
        current_state = new_state
        E.LOG.d(TAG, "current_chat_state=" .. tostring(current_state))
      end
    else
      current_state = new_state
      E.LOG.d(TAG, "current_chat_state=" .. tostring(current_state))
    end
    if new_state == M.RETRY_CONNECT then
      M.log_stat(M.RETRY_CONNECT, E.system_ms())
      if login_result_params then
        M.log_stat("retry_connect_index", login_result_params.retry_connect_index or -1)
        M.log_stat("delay_time", login_result_params.delay_time or -1)
        M.log_stat("code", login_result_params.code or 0)
      end
    elseif new_state == M.ERROR then
      M.log_stat(M.ERROR, E.system_ms())
    elseif new_state == M.CONNECT_ERROR then
      M.log_stat(M.CONNECT_ERROR, E.system_ms())
    elseif new_state == M.LOGIN_SUCC and reconnect_stats and reconnect_stats[M.RETRY_CONNECT] then
      M.log_stat(M.LOGIN_SUCC, E.system_ms())
      M.log_stat("cost", E.system_ms() - reconnect_stats[M.RETRY_CONNECT])
      ESTAT.stat_action_apus("chat_reconnect", "reconnect", 0, {
        _sdk_apus_stats = {
          [M.LOGIN_SUCC] = reconnect_stats[M.LOGIN_SUCC] or -1,
          [M.RETRY_CONNECT] = reconnect_stats[M.RETRY_CONNECT] or -1,
          [M.CONNECT_ERROR] = reconnect_stats[M.CONNECT_ERROR] or -1,
          [M.ERROR] = reconnect_stats[M.ERROR] or -1,
          retry_connect_index = reconnect_stats.retry_connect_index or -1,
          cost = reconnect_stats.cost or -1,
          delay_time = reconnect_stats.delay_time * 1000 or -1
        },
        code = reconnect_stats.code or 0
      })
      reconnect_stats = nil
    end
  end)
end

return M
