local lsocket = _ejoysdk_lsocket
local pack_config = require("ejoysdk_lua.cloud_game.cloud_message.pack_config")
local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.CLOUD_GAME .. "udp_socket"
local CONNECT_INTERVAL = 3
local CONNECT_TIMEOUT = 10
local M = {}
M.State = {
  Stop = "STOP",
  DisConnect = "DISCONNECT",
  Connected = "CONNECTED",
  Connecting = "CONNECTING"
}
local TAG = "cloud_socket"

function M.create(addr, port, handlers)
  local instance = {}
  instance.status = M.State.Stop
  instance.addr = addr
  instance.port = port
  instance.fd = nil
  instance.send_list = {}
  instance.handlers = handlers
  instance.next_try_connect_time = 0
  instance.connect_time = 0
  do return setmetatable, instance end
  return setmetatable, instance, {__index = M}, M
end

function M:connect()
  _ejoysdk.log("[cloud game] socket connect to:" .. self.addr .. ":" .. self.port)
  self.status = M.State.Connecting
  local fd, err = lsocket.connect("udp", self.addr, self.port)
  if nil == fd then
    self:_on_socket_error("fd is nil, err: " .. tostring(err))
    return
  end
  self.fd = fd
  self.select_io = {fd}
  self.connect_time = 0
  E.Timer.once(0, function()
    E.LOG.debug(TAG, "start _check_connect_status_unblock")
    self:_check_connect_status_unblock()
  end)
end

function M:close()
  self.status = M.State.Stop
  self.send_list = {}
  if not self.fd then
    return
  end
  self.fd:close()
  self.fd = nil
end

function M:get_status()
  return self.status
end

function M:_check_connect_status_unblock()
  local rr, rw = lsocket.select(nil, {
    self.fd
  }, 0)
  if not (rr and rw) or next(rw) == nil then
    _ejoysdk.log("socket not ready")
    self.connect_time = self.connect_time + 1
    if self.connect_time < CONNECT_TIMEOUT then
      E.Timer.once(1, function()
        self:_check_connect_status_unblock()
      end)
    else
      local msg = "connect reach max times"
      if false == rr then
        msg = msg .. ", select return 0"
      end
      if nil == rr and type(rw) == "string" then
        msg = msg .. ", select error: " .. tostring(rw)
      end
      self:_on_socket_error("_check_connect_status_unblock: " .. msg)
    end
  else
    local ok, err = self.fd:status()
    if not ok then
      self:_on_socket_error("check connect status not ok: " .. err)
      return false
    else
      self.status = M.State.Connected
      _ejoysdk.log("socket Connected")
      if self.handlers.on_connected then
        self.handlers.on_connected()
      end
    end
  end
end

function M:tick()
  if self.status == M.State.DisConnect and os.time() > self.next_try_connect_time then
    self:connect()
    return
  end
  if self.status ~= M.State.Connected then
    return
  end
  self:_read()
end

function M:_read()
  while true do
    local rr = lsocket.select(self.select_io, 0)
    if not rr or next(rr) == nil then
      return
    end
    local recv_data, err = self.fd:recv(pack_config.MAX_BODY_SIZE)
    if not recv_data then
      self:_on_socket_error("_read error: " .. err)
    elseif self.handlers.on_message then
      local ok, msg = pcall(self.handlers.on_message, recv_data)
      if not ok then
        E.LOG.error(TAG, "socket read msg, handle error! msg >> " .. tostring(msg))
      end
    end
  end
end

function M:send(pack)
  if self.status ~= M.State.Connected then
    E.LOG.error(TAG, "[cloud game] send error status ==" .. tostring(self.status))
    return
  end
  table.insert(self.send_list, pack)
  self:_send_remain()
end

function M:_send_remain()
  if self.status ~= M.State.Connected then
    return
  end
  if next(self.send_list) == nil then
    return
  end
  for id, data in ipairs(self.send_list) do
    local _, rr = lsocket.select(nil, self.select_io, 0)
    if not rr or next(rr) == nil then
      return
    end
    local bytes, err = self.fd:send(data)
    if not bytes then
      self:_on_socket_error("_send_remain error:" .. err)
      return
    else
      if bytes ~= string.len(data) then
        E.LOG.error(TAG, "[cloud game] send bytes need_send=" .. tostring(string.len(data)) .. " true_send=" .. tostring(bytes))
      end
      self.send_list[id] = nil
    end
  end
end

function M:_on_socket_error(err)
  if self.status == M.State.Connected then
    local err_msg = "[cloud game] socket io err: " .. tostring(err)
    E.LOG.error(TAG, err_msg)
    if self.handlers.on_error then
      self.handlers.on_error(err_msg)
    end
    self.fd:close()
  else
    local err_msg = "[cloud game] socket connect err: " .. tostring(err)
    E.LOG.error(TAG, err_msg)
    if self.handlers.on_connect_error then
      self.handlers.on_connect_error(err_msg)
    end
  end
  self:close()
  self.status = M.State.DisConnect
  self.next_try_connect_time = os.time() + CONNECT_INTERVAL
end

return M
