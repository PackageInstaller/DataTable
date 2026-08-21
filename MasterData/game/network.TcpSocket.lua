local SOCKET_TICK_TIME = 0.1
local SOCKET_RECONNECT_TIME = 5
local SOCKET_CONNECT_FAIL_TIMEOUT = 5
local STATUS_CLOSED = "closed"
local STATUS_NOT_CONNECTED = "Socket is not connected"
local STATUS_ALREADY_CONNECTED = "already connected"
local STATUS_ALREADY_IN_PROGRESS = "Operation already in progress"
local STATUS_TIMEOUT = "timeout"
local socket = require("socket")
local TcpSocket = class("TcpSocket")
TcpSocket.EVENT_DATA = "SOCKET_TCP_DATA"
TcpSocket.EVENT_CLOSE = "SOCKET_TCP_CLOSE"
TcpSocket.EVENT_CLOSED = "SOCKET_TCP_CLOSED"
TcpSocket.EVENT_CONNECTED = "SOCKET_TCP_CONNECTED"
TcpSocket.EVENT_CONNECT_FAILURE = "SOCKET_TCP_CONNECT_FAILURE"
TcpSocket._VERSION = socket._VERSION
TcpSocket._DEBUG = socket._DEBUG

function TcpSocket.getTime()
  return socket.gettime()
end

function TcpSocket:ctor(__host, __port, __retryConnectWhenFailure)
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  self.host = __host
  self.port = __port
  self.tickScheduler = nil
  self.reconnectScheduler = nil
  self.connectTimeTickScheduler = nil
  self.name = "TcpSocket"
  self.tcp = nil
  self.isRetryConnect = __retryConnectWhenFailure
  self.isConnected = false
end

function TcpSocket:setName(__name)
  self.name = __name
  return self
end

function TcpSocket:setTickTime(__time)
  SOCKET_TICK_TIME = __time
  return self
end

function TcpSocket:setReconnTime(__time)
  SOCKET_RECONNECT_TIME = __time
  return self
end

function TcpSocket:setConnFailTime(__time)
  SOCKET_CONNECT_FAIL_TIMEOUT = __time
  return self
end

function TcpSocket:connect(__host, __port, __retryConnectWhenFailure)
  if __host then
    self.host = __host
  end
  if __port then
    self.port = __port
  end
  if __retryConnectWhenFailure ~= nil then
    self.isRetryConnect = __retryConnectWhenFailure
  end
  assert(self.host or self.port, "Host and port are necessary!")
  local isipv6_only = false
  local addrinfo, err = socket.dns.getaddrinfo(self.host)
  if addrinfo then
    for i, v in ipairs(addrinfo) do
      if v.family == "inet6" then
        isipv6_only = true
        break
      end
    end
  end
  if isipv6_only then
    self.tcp = socket.tcp6()
  else
    self.tcp = socket.tcp()
  end
  self.tcp:settimeout(SOCKET_CONNECT_FAIL_TIMEOUT)
  local __succ = self:_connect()
  if __succ then
    self:_onConnected()
    self.tcp:settimeout(0)
  else
    self:dispatchEvent({
      name = TcpSocket.EVENT_CONNECT_FAILURE
    })
  end
  return __succ
end

function TcpSocket:send(__data)
  if not self.isConnected then
    return false
  end
  local dataLength = string.len(__data)
  local result, status, pos_send
  local pos_begin = 1
  local send_length = 0
  result, status, pos_send = self.tcp:send(__data, pos_begin)
  while true do
    if result == nil then
      if status == STATUS_CLOSED then
        self:_onDisconnect(__data)
        return false
      end
      send_length = send_length + pos_send - pos_begin + 1
      if send_length == dataLength then
        return true
      end
      pos_begin = pos_send + 1
      result, status, pos_send = self.tcp:send(__data, pos_begin)
    else
      send_length = send_length + result - pos_begin + 1
      if send_length == dataLength then
        return true
      end
      pos_begin = result + 1
      result, status, pos_send = self.tcp:send(__data, pos_begin)
    end
  end
end

function TcpSocket:close(...)
  self.tcp:close()
  if self.reconnectScheduler then
    scheduler.unscheduleGlobal(self.reconnectScheduler)
  end
  if self.tickScheduler then
    scheduler.unscheduleGlobal(self.tickScheduler)
  end
  if self.connectTimeTickScheduler then
    scheduler.unscheduleGlobal(self.connectTimeTickScheduler)
  end
end

function TcpSocket:disconnect()
  self:_disconnect()
  self.isRetryConnect = false
end

function TcpSocket:_connect()
  local __succ, __status = self.tcp:connect(self.host, self.port)
  return __succ == 1 or __status == STATUS_ALREADY_CONNECTED
end

function TcpSocket:_disconnect()
  self.isConnected = false
  self.tcp:shutdown()
  self:dispatchEvent({
    name = TcpSocket.EVENT_CLOSED
  })
end

function TcpSocket:_onDisconnect(__data)
  self.isConnected = false
  self:dispatchEvent({
    name = TcpSocket.EVENT_CLOSED,
    data = __data
  })
  self:_reconnect()
end

function TcpSocket:_onConnected()
  self.isConnected = true
  self:dispatchEvent({
    name = TcpSocket.EVENT_CONNECTED
  })
  if self.connectTimeTickScheduler then
    scheduler.unscheduleGlobal(self.connectTimeTickScheduler)
  end
  
  local function __tick()
    while true do
      local __body, __status, __partial = self.tcp:receive(16384)
      if __status == STATUS_CLOSED or __status == STATUS_NOT_CONNECTED then
        self:close()
        if self.isConnected then
          self:_onDisconnect()
        else
          self:_connectFailure()
        end
        return
      end
      if __body and string.len(__body) == 0 or __partial and string.len(__partial) == 0 then
        return
      end
      if __body and __partial then
        __body = __body .. __partial
      end
      self:dispatchEvent({
        name = TcpSocket.EVENT_DATA,
        data = __partial or __body,
        partial = __partial,
        body = __body
      })
    end
  end
  
  self.tickScheduler = scheduler.scheduleGlobal(__tick, SOCKET_TICK_TIME)
end

function TcpSocket:_connectFailure(status)
  self:dispatchEvent({
    name = TcpSocket.EVENT_CONNECT_FAILURE
  })
  self:_reconnect()
end

function TcpSocket:_reconnect(__immediately)
  if not self.isRetryConnect then
    return
  end
  if __immediately then
    self:connect()
    return
  end
  if self.reconnectScheduler then
    scheduler.unscheduleGlobal(self.reconnectScheduler)
  end
  
  local function __doReConnect()
    self:connect()
  end
  
  self.reconnectScheduler = scheduler.performWithDelayGlobal(__doReConnect, SOCKET_RECONNECT_TIME)
end

return TcpSocket
