local Class = require("ejoysdk_lua.ejoysdk_class")
local lsocket = _ejoysdk_lsocket
local E = require("ejoysdk_lua.ejoysdk")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local string_pack, string_unpack, xpcall = compat.string.pack, compat.string.unpack, compat.xpcall
local M = Class:Inherit("ChatSocket")
local CONNECT_INTERVAL = 5
local CONNECT_TIMEOUT = 5
local connect_time = 0
local MAX_GET_NATIVE_RESOLVE_TIMES = 15
local PRE_GET_NATIVE_SEC = 0.2
local PRE_RESOLVE_TIMEOUT_SEC = 3
local first_appear_400_time = 0
local appear_400_count = 0
local appear_400_max_count = 15
local appear_check_duration = 240
local TAG = EM.MODULE.CHAT .. "socket"
M.CHAT_STOP = "STOP"
M.CHAT_DISCONNECT = "DISCONNECT"
M.CHAT_CONNECTED = "CONNECTED"
M.CHAT_LOGINED = "LOGINED"
M.EVT_CONNECT_FAILED = "CONNNECT_FAILED"

function M:_init(server, handlers)
  chat_log.call_api(chat_log_util.header(), TAG, "_init", chat_log.LOG_LEVEL.HIGH, {}, server, handlers)
  assert(server.socket_type == "TCP")
  self.status = self.STOP
  self.fd = nil
  self.recv_buf = ""
  self.send_buf = ""
  self.server = server
  self.handlers = handlers
  self.connect_interval = 0
  self.can_use_resolve = true
end

function M:run()
  self.status = self.CHAT_DISCONNECT
  self:connect()
end

function M:get_server()
  do return utils.deepcopy end
  return utils.deepcopy, self.server or {}
end

function M:close()
  self.status = self.CHAT_STOP
  if not self.fd then
    return
  end
  self.fd:close()
  self.fd = nil
  self.send_buf = ""
  self.handlers.on_disconnect()
  chat_log.info(chat_log_util.header(), TAG, "chat_on_disconnect", "chat_socket_connect", {}, {})
end

function M:get_status()
  return self.status
end

function M:check_connect_status_unblock()
  E.LOG.debug(TAG, "chat_connect: check_connect_status_unblock start")
  local rr, rw = lsocket.select(nil, {
    self.fd
  }, 0)
  if not (rr and rw) or next(rw) == nil then
    connect_time = connect_time + 1
    if connect_time < CONNECT_TIMEOUT then
      E.Timer.once(1, function()
        E.LOG.debug(TAG, "chat_connect: check_connect_status_unblock retry")
        self:check_connect_status_unblock()
      end)
    else
      local msg = "connect reach max times"
      if false == rr then
        msg = msg .. ", select return 0"
      end
      if nil == rr and type(rw) == "string" then
        msg = msg .. ", select error: " .. tostring(rw)
      end
      local code = tostring(CONSTANTS.RPC_ERROR_CODES.CODE_SOCKET_CONNECT_RETRY_REACH_MAX_TIMES)
      E.LOG.debug(TAG, "chat_connect: check_connect_status_unblock fail, error_msg=" .. tostring(msg))
      self.handlers.on_connect_error(msg, code)
    end
  else
    local ok, err = self.fd:status()
    if not ok then
      local code = tostring(CONSTANTS.RPC_ERROR_CODES.CODE_SOCKET_CONNECT_CHECK_FD_STATUS_NOT_OK)
      local msg = "check_connect_status_not_ok, err:" .. tostring(err)
      E.LOG.debug(TAG, "chat_connect: check_connect_status_unblock fail, error_msg=" .. tostring(msg))
      self.handlers.on_connect_error("connect fd status not ok, err: " .. tostring(err), code)
      return false
    else
      E.LOG.debug(TAG, "chat_connect: check_connect_status_unblock succ")
      self.status = self.CHAT_CONNECTED
      self.handlers.on_connected()
      chat_log_util.resset_header()
    end
  end
end

function M:connect()
  E.LOG.debug(TAG, "chat_connect: chat_socket connect start")
  chat_log_util.resset_header()
  self.handlers.on_connect_start()
  local e_lresolve = _ejoysdk_lresolve
  if _ejoysdk.os() == "ios" and e_lresolve and self.can_use_resolve then
    local resolve = require("ejoysdk_lua.chat.ejoysdk_resolve")
    local finish_count = 0
    E.LOG.debug(TAG, "chat_connect: resolve request start on iOS")
    resolve.request(self.server.addr, PRE_RESOLVE_TIMEOUT_SEC, function(success, data)
      finish_count = 1
      if success and type(data) == "table" then
        local target_addr
        if data and #data >= 1 then
          target_addr = data[1].addr
          if not target_addr then
            self.can_use_resolve = false
            local code = tostring(CONSTANTS.RPC_ERROR_CODES.CODE_SOCKET_CONNECT_TARGET_ADDR_NIL)
            local error_msg = "lresolve: dns resolve target_addr is nil"
            E.LOG.debug(TAG, "chat_connect: resolve request fail, error_msg=" .. tostring(error_msg))
            self.handlers.on_connect_error(error_msg, code)
            return
          end
        else
          local code = tostring(CONSTANTS.RPC_ERROR_CODES.CODE_SOCKET_CONNECT_DNS_RESOLVE_EMPTY)
          local error_msg = "lresolve: dns resolve count 0"
          E.LOG.debug(TAG, "chat_connect: resolve request fail, error_msg=" .. tostring(error_msg))
          self.can_use_resolve = false
          self.handlers.on_connect_error(error_msg, code)
          return
        end
        local fd, err = lsocket.connect(target_addr, self.server.port)
        if nil == fd then
          local code = tostring(CONSTANTS.RPC_ERROR_CODES.CODE_SOCKET_CONNECT_FD_NIL)
          local msg = "fd is nil, err: " .. tostring(err)
          E.LOG.debug(TAG, "chat_connect: resolve request fail, error_msg=" .. tostring(msg))
          self.handlers.on_connect_error(msg, code)
          return
        end
        E.LOG.debug(TAG, "chat_connect: resolve request succ, on_connecting")
        self.fd = fd
        connect_time = 0
        self.handlers.on_connecting()
        self:check_connect_status_unblock()
      else
        self.can_use_resolve = false
        local code = tostring(CONSTANTS.RPC_ERROR_CODES.CODE_SOCKET_CONNECT_RESOLVE_ERR)
        local msg = "lresolve err: " .. tostring(data)
        E.LOG.debug(TAG, "chat_connect: resolve request fail, error_msg=" .. tostring(msg))
        self.handlers.on_connect_error(msg, code)
      end
    end)
    
    local function get_resolve_result_with_timer(try_times)
      if try_times > 0 and 0 == finish_count then
        E.Timer.once(PRE_GET_NATIVE_SEC, function()
          resolve.wait(PRE_GET_NATIVE_SEC)
          if 1 == finish_count then
            E.LOG.debug(TAG, "chat_connect: resolve host finish")
          else
            get_resolve_result_with_timer(try_times - 1)
          end
        end)
      end
    end
    
    get_resolve_result_with_timer(MAX_GET_NATIVE_RESOLVE_TIMES)
  else
    E.LOG.debug(TAG, "chat_connect: lsocket connect")
    local fd, err = lsocket.connect(self.server.addr, self.server.port)
    if nil == fd then
      local code = tostring(CONSTANTS.CODE_SOCKET_CONNECT_FD_NIL)
      local msg = "fd is nil, err: " .. tostring(err)
      E.LOG.debug(TAG, "chat_connect: lsocket connect fail, error_msg=" .. tostring(msg))
      self.handlers.on_connect_error(msg, code)
      return
    end
    self.fd = fd
    connect_time = 0
    E.LOG.debug(TAG, "chat_connect: lsocket connect succ, on_connecting")
    self.handlers.on_connecting()
    self:check_connect_status_unblock()
  end
end

function M:tick()
  if self.status == self.CHAT_DISCONNECT and os.time() - self.connect_interval < CONNECT_INTERVAL then
    self:connect()
  end
  if self.status ~= self.CHAT_CONNECTED then
    return
  end
  self:read()
  self:send_remain()
end

function M:read()
  if self.status ~= self.CHAT_CONNECTED then
    return
  end
  while true do
    local succ, opt = self:on_message(self.recv_buf)
    if succ then
      local n = opt
      self.recv_buf = self.recv_buf:sub(n)
      self:reset_400_count()
    else
      local error_code = opt
      local rr = lsocket.select({
        self.fd
      }, 0)
      if not rr or next(rr) == nil then
        return
      end
      local p, err = self.fd:recv()
      if not p then
        self:socket_error(err, error_code)
        return
      end
      self.recv_buf = self.recv_buf .. p
    end
  end
end

local function parse_plaintext_recv(recv)
  local lines = E.Utils.split_string(recv, "\n")
  if lines then
    local first_line = lines[1]
    local first_line_splits = E.Utils.split_string(first_line, " ")
    if #first_line_splits > 1 then
      local second_split = first_line_splits[2]
      local res = tonumber(second_split)
      return res or CONSTANTS.CHAT_ERROR_CODES.CODE_SERVER_PLAINTEXT_CODE_FIRST_LINE_MISS
    end
  end
  return CONSTANTS.CHAT_ERROR_CODES.CODE_SERVER_PLAINTEXT_CODE_EMPTY
end

function M:on_message(recv)
  if "" == recv then
    return false
  end
  local ok, pack, n = xpcall(string_unpack, function(x)
    chat_log.warn(chat_log_util.header(), TAG, "string_unpack_error", {
      lua_error_msg = tostring(x)
    }, {})
  end, ">s4", recv)
  if not ok then
    local error_code = parse_plaintext_recv(recv)
    chat_log.warn(chat_log_util.header(), TAG, "parse_plaintext_recv_error", {
      err_code = CONSTANTS.CHAT_ERROR_CODES.CODE_PARSE_PLAINTEXT_RECV,
      detail_err_code = error_code,
      err_msg = "parse_plaintext_recv_error"
    })
    return false, error_code
  end
  local ret = self.handlers.on_message(pack)
  if ret then
    return ret, n
  else
    return ret, -1
  end
end

function M:write(pack)
  pack = string_pack(">s4", pack)
  self.send_buf = self.send_buf .. pack
  self:send_remain()
end

function M:send_remain()
  if self.send_buf == "" then
    return
  end
  local rr, rw = lsocket.select(nil, {
    self.fd
  }, 0)
  if not (rr and rw) or next(rw) == nil then
    return
  end
  local bytes, err = self.fd:send(self.send_buf)
  if not bytes then
    self:socket_error(err)
    return
  else
    self.send_buf = self.send_buf:sub(bytes + 1)
  end
end

function M:reset_400_count()
  first_appear_400_time = 0
  appear_400_count = 0
end

function M:socket_error(err, err_code)
  self.status = self.CHAT_STOP
  if not self.fd then
    return
  end
  self.fd:close()
  self.fd = nil
  self.send_buf = ""
  self.connect_interval = os.time()
  if 400 == err_code then
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
  if nil == err_code or -1 == err_code then
    chat_log.warn(chat_log_util.header(), TAG, err_code or -1, "chat_socket_on_error", {
      err_code = err_code or -1,
      err_msg = tostring(err)
    }, {})
  else
    chat_log.error(chat_log_util.header(), TAG, err_code or -1, "chat_socket_on_error", {
      err_code = err_code or -1,
      err_msg = tostring(err)
    }, {})
  end
end

return M
