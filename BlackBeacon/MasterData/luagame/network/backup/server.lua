local socket = require("socket.c")
local buffer_queue = require("buffer_queue")
local mt = {}
mt.__index = mt
local session_mt = {}
session_mt.__index = session_mt
local OK = 0
local EINTR = socket.EINTR
local EAGAIN = socket.EAGAIN

local function new(host, port)
  if nil == port and type(host) == "number" then
    port = host
    host = "127.0.0.1"
  end
  local self = {
    v_max_accept_count = 8,
    v_session_idx = 0,
    v_session = {},
    __replace_session = {},
    v_sock = false,
    v_handle = {
      accept = false,
      recv = false,
      send = false,
      error = false
    }
  }
  local sock, errcode = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  if not sock then
    return false, errcode
  end
  local ok, errcode = sock:setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
  if not ok then
    return false, errcode
  end
  local errcode = sock:bind(host, port)
  if 0 ~= errcode then
    return false, errcode
  end
  sock:listen()
  sock:setblocking(false)
  self.v_sock = sock
  return setmetatable(self, mt)
end

function mt:register_handle(type, func)
  assert(self.v_handle[type] ~= nil)
  self.v_handle[type] = func
end

local function on_handle(self, type, ...)
  local func = self.v_handle[type]
  if func then
    return func(...)
  end
end

local function new_session(self, csock)
  self.v_session_idx = self.v_session_idx + 1
  local session = {
    o_idx = self.v_session_idx,
    v_server = self,
    v_csock = csock,
    v_recv_buf = buffer_queue.create(),
    v_send_buf = buffer_queue.create()
  }
  setmetatable(session, session_mt)
  table.insert(self.v_session, session)
  return session
end

function session_mt:__tostring()
  local csock = self.v_csock
  if csock then
    return csock:getsockname()
  else
    return tostring(csock)
  end
end

local pass_code = {
  [EAGAIN] = true,
  [OK] = true,
  [EINTR] = true
}

function session_mt:update_recv()
  local recv_buf = self.v_recv_buf
  local csock = self.v_csock
  local data, err = csock:recv()
  if not data then
    if not pass_code[err] then
      return false, err
    else
      return true
    end
  elseif 0 == #data then
    return false, "break"
  end
  local none = on_handle(self.v_server, "recv", self, data)
  if not none then
    recv_buf:push(data)
  end
  return true
end

function session_mt:update_send()
  local send_buf = self.v_send_buf
  local csock = self.v_csock
  local v = send_buf:get_head_data()
  local count = 0
  while v do
    local len = #v
    local n, err = csock:send(v)
    if not n then
      return false, err
    else
      count = count + n
      send_buf:pop(n)
      if len > n then
        break
      end
    end
    v = send_buf:get_head_data()
  end
  if count > 0 then
    on_handle(self.v_server, "send", self, count)
  end
  return count
end

function session_mt:send_msg(msg)
  self.v_send_buf:push(msg .. "\n")
end

function mt:update()
  local session_count = #self.v_session
  local max_accept_count = self.v_max_accept_count
  if max_accept_count and session_count <= max_accept_count then
    local csock, err = self.v_sock:accept()
    if csock then
      csock:setblocking(false)
      local session = new_session(self, csock)
      on_handle(self, "accept", session)
    end
  end
  local session_list = self.v_session
  local session_list2 = self.__replace_session
  session_count = #session_list
  for i = 1, session_count do
    local ok, err
    local session = session_list[i]
    ok, err = session:update_recv()
    if ok then
      ok, err = session:update_send()
    end
    session_list[i] = nil
    if ok then
      session_list2[#session_list2 + 1] = session
    else
      on_handle(self, "error", session, err)
      session.v_csock:close()
    end
  end
  self.v_session, self.__replace_session = session_list2, session_list
end

return new
