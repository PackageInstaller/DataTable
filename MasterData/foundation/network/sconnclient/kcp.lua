local socket = require("socket.c")
local lkcp = require("lkcp")
local EINTR = socket.EINTR
local EAGAIN = socket.EAGAIN
local mt = {}
mt.__index = mt
local M = {}

local function conn_error(errcode)
  return socket.strerror(errcode) .. "[" .. tostring(errcode) .. "]"
end

function M.new(addr, port)
  local fd = socket.socket(addr.family, socket.SOCK_DGRAM, 0)
  fd:setblocking(false)
  local errcode = fd:connect(addr.addr, port)
  local conv = math.random(4294967295)
  local kcp = lkcp.lkcp_create(conv, function(buf)
    fd:send(buf)
  end)
  local obj = {
    v_send_buf = buffer_queue.create(),
    v_recv_buf = buffer_queue.create(),
    v_fd = fd,
    kcp = kcp,
    conv = conv
  }
  return setmetatable(obj, mt), errcode
end

function mt:flush_send()
  local send_buf = self.v_send_buf
  local v = send_buf:get_head_data()
  local count = 0
  while v do
    local len = #v
    self.kcp:lkcp_send(v)
    count = count + len
    send_buf:pop(len)
    v = send_buf:get_head_data()
  end
  return count
end

function mt:flush_recv()
  local recv_buf = self.v_recv_buf
  local fd = self.v_fd
  local has_data = false
  local count = 0
  while true do
    local data, err = fd:recv()
    if not data then
      if err == EAGAIN or 0 == err then
        break
      end
      if err == EINTR then
        goto lbl_38
      else
        return false, conn_error(err)
      end
    elseif 0 == #data then
      return false, "connect_break"
    else
      has_data = true
      self.kcp:lkcp_input(data)
    end
    ::lbl_38::
  end
  while has_data do
    local len, buf = self.kcp:lkcp_recv()
    if len <= 0 then
      break
    end
    count = count + len
    recv_buf:push(buf)
  end
  return count
end

function mt:update(msnow)
  self.kcp:lkcp_update(msnow)
end

return M
