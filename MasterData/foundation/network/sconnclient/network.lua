local pcall = _ENV.pcall
local mt = {}
local sproto_index

local function load_sproto(file)
  sproto_index = 1
  local bin = CS.Framework.AssetLoadUtil.LoadByteData("Assets/Sproto/proto.spb.bytes")
  if nil == bin then
    Debug.LogError("!!LoadFileData faild ", file, debug.traceback())
  end
  sprotoloader.save(bin, sproto_index)
end

local function new(client_pbin, server_pbin)
  load_sproto("Foundation/Network/SconnClient/sproto/proto.spb.bytes")
  local client_proto = sprotoloader.load(sproto_index)
  local client = client_proto:host("Base.Pack")
  local client_request = client:attach(client_proto)
  local raw = {
    v_session_index = 0,
    v_request_session = {},
    v_response_handle = {},
    v_out = {},
    v_conn = false,
    v_client = client,
    v_client_request = client_request,
    v_default_request_handle = false
  }
  do return setmetatable, raw end
  return setmetatable, raw, {__index = mt}, mt
end

function mt:connect(type, host, port, targetserver, flag, accept_encodings, callback)
  self.v_request_session = {}
  local obj, errcode = sconn.connect_host(type, host, port, targetserver, flag, accept_encodings, callback)
  if not obj then
    return false, errcode
  else
    self.v_conn = obj
    return true
  end
end

local function dispatch(self, resp)
  local client = self.v_client
  local _type, v1, v2, v3 = client:dispatch(resp)
  if "RESPONSE" == _type then
    local session, response = v1, v2
    local session_item = self.v_request_session[session]
    if not session_item then
      return
    end
    local handle = session_item.handle
    local tt = type(handle)
    if "function" == tt then
      handle(session_item.param, response, session)
    elseif "thread" == tt then
      local success, err = coroutine.resume(handle, response)
      if not success then
        error(err)
      end
    else
      error("error handle type:" .. tt .. " from msg:" .. tostring(session_item.name))
    end
    self.v_request_session[session] = nil
  elseif "REQUEST" == _type then
    local name, request, response = v1, v2, v3
    local handle = self.v_response_handle[name]
    if handle then
      local data = handle(request)
      if response then
        data = response(data)
        self.v_conn:send_msg(data)
      end
    elseif self.v_default_request_handle then
      self.v_default_request_handle(name, request)
    else
      error("error type= " .. tostring(_type) .. " name=" .. tostring(name))
    end
  else
    error("error dispatch type: " .. tostring(_type))
  end
end

function mt:update()
  if not self.v_conn then
    return
  end
  local success, err, status = self.v_conn:update()
  if self.v_conn:is_connect() then
    local out = self.v_out
    local count = self.v_conn:recv_msg(out)
    local err_dispatch
    for i = 1, count do
      local resp = out[i]
      if not pcall(dispatch, self, resp) then
        err_dispatch = true
      end
    end
    if err_dispatch then
      return false, "error dispatch", "dispatch error"
    end
  end
  return success, err, status
end

local function request(self, name, t, session_index)
  local req = self.v_client_request(name, t, session_index)
  do return self.v_conn.send_msg, self.v_conn end
  return self.v_conn.send_msg, self.v_conn, req
end

function mt:call(name, t, cb, param)
  local session_index = self.v_session_index
  self.v_session_index = session_index + 1
  assert(self.v_request_session[session_index] == nil, session_index)
  local session_item = {
    name = name,
    handle = false,
    param = param
  }
  self.v_request_session[session_index] = session_item
  if cb then
    session_item.handle = cb
    request(self, name, t, session_index)
    return session_index
  elseif coroutine.isyieldable() then
    session_item.handle = coroutine.running()
    request(self, name, t, session_index)
    do return end
    return coroutine.yield, self, name, t, session_index
  else
    assert(cb)
  end
end

function mt:invoke(name, t)
  do return request, self, name end
  return request, self, name, t
end

function mt:register(name, cb)
  assert(cb)
  assert(self.v_response_handle[name] == nil)
  self.v_response_handle[name] = cb
end

function mt:set_default_request_handle(cb)
  self.v_default_request_handle = cb
end

return new
