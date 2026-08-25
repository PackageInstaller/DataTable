local socket = require("socket.c")
local EINTR = socket.EINTR
local EAGAIN = socket.EAGAIN
local mt = {}
mt.__index = mt
local M = {}

local function conn_error(errcode)
  return socket.strerror(errcode) .. "[" .. tostring(errcode) .. "]"
end

function M.new(addr, port)
  local fd = socket.socket(addr.family, socket.SOCK_STREAM, 0)
  fd:setblocking(false)
  local errcode = fd:connect(addr.addr, port)
  local obj = {
    v_send_buf = buffer_queue.create(),
    v_recv_buf = buffer_queue.create(),
    v_fd = fd
  }
  return setmetatable(obj, mt), errcode
end

function mt:flush_send()
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

function mt:flush_recv()
  local recv_buf = self.v_recv_buf
  local fd = self.v_fd
  local count = 0
  ::lbl_4::
  local data, err = fd:recv()
  if not data then
    if err == EAGAIN or 0 == err then
      return count
    elseif err == EINTR then
      goto lbl_4
    else
      return false, conn_error(err)
    end
  elseif 0 == #data then
    return false, "connect_break"
  else
    local len = #data
    count = count + len
    recv_buf:push(data)
    goto lbl_4
  end
  return count
end

function mt:send(data)
  self.v_send_buf:push(data)
end

return M
