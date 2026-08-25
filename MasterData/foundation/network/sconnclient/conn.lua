local socket = require("socket.c")
local OK = 0
local EINTR = socket.EINTR
local EAGAIN = socket.EAGAIN
local EINPROGRESS = socket.EINPROGRESS
local EISCONN = socket.EISCONN
local DEF_MSG_HEADER_LEN = 2
local DEF_MSG_ENDIAN = "big"
local POLLOUT = socket.POLLOUT
local POLLERR = socket.POLLERR
local mt = {}

local function conn_error(errcode)
  return socket.strerror(errcode) .. "[" .. tostring(errcode) .. "]"
end

local function resolve(host)
  local addr_tbl, err = socket.resolve(host)
  if not addr_tbl then
    return false, socket.gai_strerror(err) .. "[" .. tostring(err) .. "]"
  end
  do return assert end
  return assert, addr_tbl[1], "[", tostring(err), "]"
end

local function dial(network, addr, port)
  if "tcp" == network then
    do return tcp.new, addr end
    return tcp.new, addr, port, nil
  elseif "kcp" == network then
    do return kcp.new, addr end
    return kcp.new, addr, port, nil
  else
    error(string.format("invalid network:%s", network))
  end
end

local function connect(network, addr, port)
  local fd, errcode = dial(network, addr, port)
  if errcode == OK or errcode == EAGAIN or errcode == EINPROGRESS or errcode == EINTR or errcode == EISCONN then
    local raw = {
      v_fd = fd,
      o_host_addr = addr,
      o_port = port,
      o_network = network,
      v_check_connect = true,
      v_total_send = 0
    }
    do return setmetatable, raw end
    return setmetatable, raw, {__index = mt}, mt
  else
    if fd and fd.v_fd then
      fd.v_fd:close()
    end
    return nil, conn_error(errcode)
  end
end

local function connect_host(network, host, port)
  local addr, err = resolve(host)
  if not addr then
    return false, err
  end
  do return connect, network, addr end
  return connect, network, addr, port
end

local function _check_connect(self)
  local fd = self.v_fd.v_fd
  if not fd then
    return false, "fd is nil"
  end
  if self.v_check_connect then
    local revents, err = self:poll(POLLOUT)
    if err then
      return false, conn_error(err)
    elseif revents then
      local poll_err = 0 ~= revents & POLLERR
      local poll_out = 0 ~= revents & POLLOUT
      if poll_err then
        return false, "poll error"
      elseif poll_out then
        self.v_check_connect = false
        return true
      end
      return false, "connecting"
    end
  else
    return true
  end
end

function mt:send_msg(data, header_len, endian)
  local send_buf = self.v_fd.v_send_buf
  header_len = header_len or DEF_MSG_HEADER_LEN
  endian = endian or DEF_MSG_ENDIAN
  send_buf:push_block(data, header_len, endian)
end

function mt:recv_msg(out_msg, header_len, endian)
  local recv_buf = self.v_fd.v_recv_buf
  header_len = header_len or DEF_MSG_HEADER_LEN
  endian = endian or DEF_MSG_ENDIAN
  do return recv_buf.pop_all_block, recv_buf, out_msg, header_len end
  return recv_buf.pop_all_block, recv_buf, out_msg, header_len, endian
end

function mt:pop_msg(header_len, endian)
  local recv_buf = self.v_fd.v_recv_buf
  header_len = header_len or DEF_MSG_HEADER_LEN
  endian = endian or DEF_MSG_ENDIAN
  do return recv_buf.pop_block, recv_buf, header_len end
  return recv_buf.pop_block, recv_buf, header_len, endian
end

function mt:send(data)
  self.v_fd.v_send_buf:push(data)
end

function mt:recv(out)
  do return self.v_fd.v_recv_buf.pop_all, self.v_fd.v_recv_buf end
  return self.v_fd.v_recv_buf.pop_all, self.v_fd.v_recv_buf, out
end

function mt:update(msnow)
  local fd = self.v_fd
  if not fd then
    return false, "fd is nil", "close"
  end
  local success, err = _check_connect(self)
  if not success then
    if "connecting" == err then
      return true, nil, "connect"
    else
      return false, err, "connect"
    end
  end
  success, err = fd:flush_send()
  if not success then
    return false, err, "send"
  end
  self.v_total_send = self.v_total_send + success
  success, err = fd:flush_recv()
  if not success then
    if "connect_break" == err then
      return false, "connect break", "connect_break"
    else
      return false, err, "recv"
    end
  end
  if fd.update then
    fd:update(msnow)
  end
  return true, nil, "forward"
end

function mt:flush_send()
  if not self.v_fd then
    return
  end
  local count
  repeat
    count = self.v_fd:flush_send()
  until not count or 0 == count
end

function mt:getsockname()
  do return self.v_fd.v_fd.getsockname end
  return self.v_fd.v_fd.getsockname, self.v_fd.v_fd
end

function mt:new_connect(network, addr, port)
  local fd, errcode = dial(network, addr, port)
  if errcode == OK or errcode == EAGAIN or errcode == EINPROGRESS or errcode == EINTR or errcode == EISCONN then
    if self.v_fd then
      self.v_fd.v_fd:close()
      self.v_fd.v_recv_buf:clear()
      self.v_fd.v_send_buf:clear()
    end
    self.v_fd = fd
    self.o_host_addr = addr
    self.o_port = port
    self.o_network = network
    self.v_check_connect = true
    self.v_total_send = 0
    return true
  else
    if fd and fd.v_fd then
      fd.v_fd:close()
    end
    return false, conn_error(errcode)
  end
end

function mt:poll(events, timeout)
  if self.v_fd and self.v_fd.v_fd and self.v_fd.v_fd.poll then
    do return self.v_fd.v_fd.poll, self.v_fd.v_fd, events end
    return self.v_fd.v_fd.poll, self.v_fd.v_fd, events, timeout
  end
end

function mt:close()
  if self.v_fd and self.v_fd.v_fd then
    self.v_fd.v_fd:close()
  end
  self.v_fd = nil
  self.v_check_connect = true
end

return {
  resolve = resolve,
  connect = connect,
  connect_host = connect_host
}
