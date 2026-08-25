local E = require("ejoysdk_lua.ejoysdk")
local BASE_API = require("ejoysdk_lua.libs.base_api")
local chat_api = BASE_API:New("chat-wsclient")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local CHAT_STAT = require("ejoysdk_lua.chat.chat_stat")
local M = {}
local TAG = "server_api#chat_api"

function M.get_chat_token(cb)
  local holo = require("ejoysdk_lua.ejoysdk_holo")
  local player_token = holo.get_player_token()
  local before_time = E.system_clock()
  if nil == player_token then
    cb(false, CONSTANTS.CHAT_ERROR_CODES.CODE_PLAYER_TOKEN_NIL, "player token is nil")
    CHAT_STAT.stat_action_failed("get_chat_token", nil, CONSTANTS.CHAT_ERROR_CODES.CODE_PLAYER_TOKEN_NIL, "player token is nil")
    return
  end
  local chat_base_url = E.CONFIG.get_config("chat-wsclient")
  E.LOG.debug(TAG, "chat_base_url=" .. tostring(chat_base_url))
  local opt = {use_moment_token = true, trace = true}
  local url = "/api/get_chat_token"
  local http_finish = false
  local time_out = false
  E.Timer.once(3, function()
    time_out = true
    if not http_finish then
      E.LOG.debug(TAG, "get_chat_token, succ=false, time out")
      cb(false, -1, "time out")
      CHAT_STAT.stat_action_failed("get_chat_token", nil, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_REQUEST_TIMEOUT, "player token http 3 sec timeout")
    end
  end)
  chat_api:post(url, {}, {}, opt, function(succ, ...)
    http_finish = true
    if time_out then
      return
    end
    E.LOG.debug(TAG, "get_chat_token, succ=" .. tostring(succ) .. ", no time out")
    if succ then
      local data = (...)
      cb(true, data)
      local after_time = E.system_clock()
      CHAT_STAT.stat_action_succ("get_chat_token", after_time - before_time)
    else
      cb(false, ...)
      local code, msg = ...
      CHAT_STAT.stat_action_failed("get_chat_token", nil, code, msg)
    end
  end)
end

return M
