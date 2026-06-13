local socket = require("socket.c")
local buffer_queue = require("network.sconn.buffer_queue")
local OK = 0
local EINTR = socket.EINTR
local EAGAIN = socket.EAGAIN
local EINPROGRESS = socket.EINPROGRESS
local EISCONN = socket.EISCONN
local RECV_BUFSIZE = 8192
local WSAEINVAL = 10022
local mt = {}

local function conn_error(errcode)
  return socket.strerror(errcode) .. "[" .. tostring(errcode) .. "]"
end

local function resolve(host)
  local addr_tbl, err = socket.resolve(host)
  if not addr_tbl then
    return false, socket.gai_strerror(err) .. "[" .. tostring(err) .. "]"
  end
  return assert(addr_tbl[1])
end

local function connect(addr, port)
  local fd = socket.socket(addr.family, socket.SOCK_DGRAM, 0)
  fd:setblocking(false)
  local errcode = fd:connect(addr.addr, port)
  if errcode == OK or errcode == EAGAIN or errcode == EINPROGRESS or errcode == EINTR or errcode == EISCONN then
    local raw = {
      v_send_buf = buffer_queue.create(),
      v_recv_buf = buffer_queue.create(),
      v_fd = fd,
      v_is_connect = false,
      o_host_addr = addr,
      o_port = port
    }
    return setmetatable(raw, {__index = mt})
  else
    return nil, conn_error(errcode)
  end
end

local function connect_host(host, port)
  local addr, err = resolve(host)
  if not addr then
    return false, err
  end
  return connect(addr, port)
end

local function _flush_send(self)
  local send_buf = self.v_send_buf
  local v = send_buf:get_head_data()
  local fd = self.v_fd
  local count = 0
  while v do
    local len = #v
    local n, err = fd:send(v)
    if not n then
      if err == EAGAIN or err == EINTR then
        break
      end
      return false, conn_error(err)
    else
      count = count + n
      send_buf:pop(n)
      if len > n then
        break
      end
    end
    v = send_buf:get_head_data()
  end
  return count
end

local function _flush_recv(self)
  local recv_buf = self.v_recv_buf
  local fd = self.v_fd
  local count = 0
  while true do
    local data, err = fd:recv()
    if not data then
      if err == EAGAIN or 0 == err or Util.is_windows_plat() and err == WSAEINVAL then
        return true
      elseif err == EINTR then
        goto lbl_58
      else
        return false, conn_error(err)
      end
    else
      if 0 == #data then
        break
      end
      local len = #data
      count = count + len
      recv_buf:push(data)
      Global.recv_len = Global.recv_len + len
      Global.recv_total_len = Global.recv_total_len + len
      break
    end
    ::lbl_58::
  end
  return count
end

local function _check_connect(self)
  if not self.v_fd then
    return false
  end
  local fd = self.v_fd
  local success, err = fd:check_async_connect()
  if not success then
    return false, err and conn_error(err) or "connecting"
  else
    self.v_is_connect = true
    return true
  end
end

function mt:send(data)
  self.v_send_buf:push(data)
end

function mt:recv(out)
  local recv_buf = self.v_recv_buf
  return recv_buf:pop_all(out)
end

function mt:update()
  local success, err = _check_connect(self)
  if not success then
    return false, err, "connect"
  end
  success, err = _flush_send(self)
  if not success then
    return false, err, "send"
  end
  success, err = _flush_recv(self)
  if not success then
    return false, err, "recv"
  end
  return true
end

function mt:getsockname()
  return self.v_fd:getsockname()
end

function mt:close()
  self.v_fd:close()
  self.v_fd = nil
end

return {connect_host = connect_host}
