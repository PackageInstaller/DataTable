local socket = require("socket.c")
local buffer_queue = require("network.sconn.buffer_queue")
local OK = 0
local EINTR = socket.EINTR
local EAGAIN = socket.EAGAIN
local EINPROGRESS = socket.EINPROGRESS
local ECONNREFUSED = socket.ECONNREFUSED
local EISCONN = socket.EISCONN
local DEF_SEND_HEADER_LEN = 2
local DEF_RECV_HEADER_LEN = 4
local DEF_MSG_ENDIAN = "big"
local mt = {}

local function conn_error(errcode)
  return socket.strerror(errcode) .. "[" .. tostring(errcode) .. "]"
end

local IPV6_SIGN_TYPE = {
  [10] = true,
  [23] = true
}

local function correct_ipv6_ip(ipv6_ip)
  return UNITY_EDITOR and "[" .. ipv6_ip .. "]" or ipv6_ip
end

local function resolve(host, ipv6_ip)
  local addr_tbl, err = socket.resolve(host)
  if not addr_tbl then
    local err_msg = socket.gai_strerror(err) .. "[" .. tostring(err) .. "]"
    Util.show_error("socket resolve error: ", host, err_msg)
    return false, err_msg
  end
  assert(addr_tbl[1])
  addr_tbl[1].addr = addr_tbl[1].addr or correct_ipv6_ip(ipv6_ip)
  return addr_tbl[1]
end

local function connect(addr, port)
  local fd = socket.socket(addr.family, socket.SOCK_STREAM, 0)
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

local function connect_host(host, port, ipv6_ip)
  local addr, err = resolve(host, ipv6_ip)
  if not addr then
    return false, err
  end
  addr.addr = addr.addr or correct_ipv6_ip(ipv6_ip)
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
      if err == EAGAIN or 0 == err then
        return true
      elseif err == EINTR then
        goto lbl_54
      else
        return false, conn_error(err)
      end
    elseif 0 == #data then
      return false, "connect_break"
    else
      local len = #data
      count = count + len
      recv_buf:push(data)
      Global.recv_len = Global.recv_len + len
      Global.recv_total_len = Global.recv_total_len + len
      break
    end
    ::lbl_54::
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
    local is_net_reachable = NetworkHelper:is_net_reachable()
    if not is_net_reachable then
      return false, "connecting"
    else
      self.v_is_connect = true
      return true
    end
  end
end

function mt:send_msg(data, header_len, endian)
  local send_buf = self.v_send_buf
  header_len = header_len or DEF_SEND_HEADER_LEN
  endian = endian or DEF_MSG_ENDIAN
  send_buf:push_block(data, header_len, endian)
end

function mt:recv_msg(out_msg, header_len, endian)
  local recv_buf = self.v_recv_buf
  header_len = header_len or DEF_RECV_HEADER_LEN
  endian = endian or DEF_MSG_ENDIAN
  return recv_buf:pop_all_block(out_msg, header_len, endian)
end

function mt:pop_msg(header_len, endian)
  local recv_buf = self.v_recv_buf
  header_len = header_len or DEF_SEND_HEADER_LEN
  endian = endian or DEF_MSG_ENDIAN
  return recv_buf:pop_block(header_len, endian)
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

function mt:new_connect(addr, port)
  local fd = socket.socket(addr.family, socket.SOCK_STREAM, 0)
  fd:setblocking(false)
  local errcode = fd:connect(addr.addr, port)
  if errcode == OK or errcode == EAGAIN or errcode == EINPROGRESS or errcode == EINTR or errcode == EISCONN then
    self.v_fd:close()
    self.v_recv_buf:clear()
    self.v_send_buf:clear()
    self.v_is_connect = false
    self.v_fd = fd
    self.o_host_addr = addr
    self.o_port = port
    return true
  else
    return false, conn_error(errcode)
  end
end

function mt:close()
  self.v_fd:close()
  self.v_fd = nil
end

return {
  resolve = resolve,
  connect = connect,
  connect_host = connect_host
}
