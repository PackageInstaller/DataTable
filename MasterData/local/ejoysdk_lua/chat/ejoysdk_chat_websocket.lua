local Class = require("ejoysdk_lua.ejoysdk_class")
local E = require("ejoysdk_lua.ejoysdk")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local M = Class:Inherit("ChatWebSocket")
local CONNECT_TIMEOUT = 5000
local first_appear_400_time = 0
local appear_400_count = 0
local appear_400_max_count = 15
local appear_check_duration = 240
local TAG = EM.MODULE.CHAT .. "websocket"
M.CHAT_STOP = "STOP"
M.CHAT_DISCONNECT = "DISCONNECT"
M.CHAT_CONNECTED = "CONNECTED"
M.CHAT_LOGINED = "LOGINED"
M.EVT_CONNECT_FAILED = "CONNECT_FAILED"

function M:_init(url, handlers)
  self.status = self.STOP
  self.ws = nil
  self.messages = {}
  self.url = url
  self.handlers = handlers
  self.connect_interval = 0
end

function M:run()
  self.status = self.CHAT_DISCONNECT
  self:connect()
end

function M:get_server()
  return self.url
end

function M:close()
  self.status = self.CHAT_STOP
  if not self.ws then
    return
  end
  self.ws:close()
  self.ws = nil
  self.handlers.on_disconnect()
  chat_log.info(chat_log_util.header(), TAG, "chat_on_disconnect", "chat_socket_connect", {}, {})
end

function M:get_status()
  return self.status
end

function M:check_connect_status_unblock()
end

function M:connect()
  E.LOG.debug(TAG, "chat_connect: chat_socket connect start")
  chat_log_util.resset_header()
  self.handlers.on_connect_start()
  E.LOG.debug(TAG, "chat_connect: lsocket connect on Android")
  self.ws = E.WebSocket:New({
    url = self.url,
    timeout = CONNECT_TIMEOUT,
    onmessage = function(data)
      local succ, _opt = self.handlers.on_message(data)
      if succ then
        self:reset_400_count()
      end
    end,
    onopen = function()
      E.LOG.debug(TAG, "chat_connect: check_connect_status_unblock succ")
      self.status = self.CHAT_CONNECTED
      self.handlers.on_connected()
      chat_log_util.resset_header()
    end,
    onerror = function(resp)
      if -1 == resp.code then
        local err = resp and resp.errMsg or "[sdk]unknown error"
        local code = tostring(CONSTANTS.RPC_ERROR_CODES.CODE_SOCKET_CONNECT_CHECK_FD_STATUS_NOT_OK)
        local msg = "check_connect_status_not_ok, err:" .. tostring(err)
        E.LOG.debug(TAG, "chat_connect: check_connect_status_unblock fail, error_msg=" .. tostring(msg))
        self.handlers.on_connect_error("connect fd status not ok, err: " .. tostring(err), code)
        self.ws = nil
        return
      end
      self:socket_error(resp.msg, resp.code)
    end,
    onclose = function(resp)
      local code = resp and resp.code or 1000
      local reason = resp and resp.reason or "[sdk]unknown reason"
      E.LOG.debug(TAG, "chat_connect: onclose = " .. tostring(code) .. ", reason = " .. tostring(reason))
      self:socket_error("socket closed", code)
    end
  })
  self.handlers.on_connecting()
end

function M:tick()
end

function M:write(pack)
  self.ws:send(pack)
end

function M:reset_400_count()
  first_appear_400_time = 0
  appear_400_count = 0
end

function M:socket_error(err, err_code)
  self.status = self.CHAT_STOP
  if not self.ws then
    return
  end
  self.ws:close()
  self.ws = nil
  self.message = {}
  self.connect_interval = os.time()
  if 1000 == err_code then
    local need_tell_outer = false
    if 0 == first_appear_400_time then
      first_appear_400_time = os.time()
      appear_400_count = 0
    elseif os.time() - first_appear_400_time <= appear_check_duration then
      if appear_400_count >= appear_400_max_count then
        first_appear_400_time = 0
        appear_400_count = 0
        need_tell_outer = true
        local holo = require("ejoysdk_lua.ejoysdk_holo")
        local token = holo.get_player_token()
        local expire_time = (holo.get_player_token_body() or {}).expire_time or 0
        local param = {
          first_appear_400_time = first_appear_400_time,
          token = token or "null",
          expire_time = expire_time,
          is_priority_high = true
        }
        ESTAT.stat_error_with_limit(TAG, "ejoy_chat_socket_400_error_reach_max", "ejoy_chat_socket_400_error_reach_max", "chat_err_scoket_error", param)
      else
        appear_400_count = appear_400_count + 1
      end
    else
      first_appear_400_time = os.time()
      appear_400_count = 0
    end
    if need_tell_outer then
      err_code = CONSTANTS.CHAT_ERROR_CODES.CODE_SOCKET_TOKEN_ERROR
    end
  end
  self.handlers.on_error("socket error, err: " .. tostring(err), err_code or -1)
  chat_log.error(chat_log_util.header(), TAG, err_code or -1, "chat_socket_on_error", {
    err_code = err_code or -1,
    err_msg = tostring(err)
  }, {})
end

return M
