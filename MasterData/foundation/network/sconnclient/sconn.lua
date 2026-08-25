local crypt = require("crypt.c")
local rc4 = require("rc4.c")
local pack_data = buffer_queue.pack_data
local CACHE_MAX_COUNT = 100
local DEF_MSG_HEADER_LEN = 2
local DEF_MSG_ENDIAN = "big"
local mt = {}
local cache_mt = {}
local VERBOSE = true
local log = VERBOSE and print or function(...)
end

local function cache_create()
  local raw = {
    size = 0,
    top = 0,
    cache = {}
  }
  do return setmetatable, raw end
  return setmetatable, raw, {__index = cache_mt}, cache_mt
end

function cache_mt:insert(data)
  local cache = self.cache
  self.top = self.top + 1
  cache[self.top] = data
  self.size = self.size + #data
  local remove_cache_value = cache[self.top - CACHE_MAX_COUNT]
  cache[self.top - CACHE_MAX_COUNT] = nil
  if remove_cache_value then
    self.size = self.size - #remove_cache_value
  end
end

function cache_mt:get(nbytes)
  if nbytes > self.size then
    return false
  end
  local cache = self.cache
  local i = self.top
  local count = 0
  local ret = {}
  while nbytes > count do
    local v = cache[i]
    local len = #v
    local n = len
    local vv = v
    if nbytes < count + len then
      local sub_n = nbytes - count
      local pos = len - sub_n
      local sub_v = string.sub(v, pos + 1)
      n = sub_n
      vv = sub_v
    end
    table.insert(ret, 1, vv)
    count = count + n
    i = i - 1
  end
  do return table.concat end
  return table.concat, ret, sub_n, sub_v, table.insert, ret, 1, vv, pos + 1
end

function cache_mt:clear()
  self.size = 0
  self.top = 0
end

local function dummy(...)
  log("send dummy")
end

local function dispose_error(state_self, _success, _err, _status)
  local success = false
  local err = state_self.name
  local status = "reconnect_error"
  return success, err, status
end

local state = {
  newconnect = {
    name = "newconnect",
    request = false,
    dispatch = false,
    send = false,
    dispose = false
  },
  reconnect = {
    name = "reconnect",
    request = false,
    dispatch = false,
    send = false,
    dispose = false
  },
  forward = {
    name = "forward",
    request = false,
    dispatch = false,
    send = false,
    dispose = false
  },
  connect_error = {
    name = "connect_error",
    send = dummy,
    dispose = dispose_error
  },
  forward_error = {
    name = "forward_error",
    send = dummy,
    dispose = dispose_error
  },
  reconnect_error = {
    name = "reconnect_error",
    send = dummy,
    dispose = dispose_error
  },
  reconnect_match_error = {
    name = "reconnect_match_error",
    send = dummy,
    dispose = dispose_error
  },
  reconnect_cache_error = {
    name = "reconnect_cache_error",
    send = dummy,
    dispose = dispose_error
  },
  close = {
    name = "close",
    send = dummy,
    dispose = false
  }
}

local function switch_state(self, s, ...)
  local v = assert(state[s], s)
  log(">>>>>>>>>>>>>switch_state:", s, ...)
  self.v_state = v
  if v.request then
    v.request(self, ...)
  end
end

local out = {}

function state.newconnect:request(target_server, flag, accept_encodings)
  target_server = target_server or ""
  flag = flag or 0
  local clientkey = crypt.randomkey()
  local data = string.format([[
0
%s
%s
%d]], crypt.base64encode(crypt.dhexchange(clientkey)), target_server, flag)
  if accept_encodings then
    data = string.format([[
%s
%s]], data, accept_encodings)
  end
  data = pack_data(data, DEF_MSG_HEADER_LEN, DEF_MSG_ENDIAN)
  self.v_sock:send(data)
  self.v_clientkey = clientkey
  log("newconnect.request========================:" .. data)
  self.v_send_buf_top = 0
end

function state.newconnect:send(data)
  self.v_send_buf_top = self.v_send_buf_top + 1
  self.v_send_buf[self.v_send_buf_top] = data
end

function state.newconnect:dispatch()
  local data = self.v_sock:pop_msg(DEF_MSG_HEADER_LEN, DEF_MSG_ENDIAN)
  if not data then
    return
  end
  log("------dispatch:", table.tostring(data))
  local lines = {}
  for str in string.gmatch(data, [[
([^
]+)]]) do
    table.insert(lines, str)
  end
  local id, key, encoding = lines[1], lines[2], lines[3]
  self.v_id = tonumber(id)
  Logger.Info("flow id:", id)
  key = crypt.base64decode(key)
  local secret = crypt.dhsecret(key, self.v_clientkey)
  local rc4_key = crypt.hmac64_md5(secret, "\000\000\000\000\000\000\000\000") .. crypt.hmac64_md5(secret, "\001\000\000\000\000\000\000\000") .. crypt.hmac64_md5(secret, "\002\000\000\000\000\000\000\000") .. crypt.hmac64_md5(secret, "\003\000\000\000\000\000\000\000")
  self.v_secret = secret
  self.v_rc4_c2s = rc4.rc4(rc4_key)
  self.v_rc4_s2c = rc4.rc4(rc4_key)
  local direction
  if encoding and "" ~= encoding and "!" ~= encoding then
    direction = encoding:sub(1, 1)
    encoding = encoding:sub(2, -1)
    if "<" == direction or "!" == direction then
      self.v_decompress_s2c = compress.new_decompressor(encoding)
      if not self.v_decompress_s2c then
        log("decompressor:", encoding, "not exist")
        switch_state(self, "connect_error")
        if self.v_conn_cb then
          self.v_conn_cb(false)
          self.v_conn_cb = nil
        end
        return
      end
    end
    if ">" == direction or "!" == direction then
      self.v_compress_c2s = compress.new_compressor(encoding)
      if not self.v_compress_c2s then
        log("compressor:", encoding, "not exist")
        switch_state(self, "connect_error")
        if self.v_conn_cb then
          self.v_conn_cb(false)
          self.v_conn_cb = nil
        end
        return
      end
    end
  end
  log("encoding:", encoding, "direction:", direction)
  switch_state(self, "forward")
  for i = 1, self.v_send_buf_top do
    self:send(self.v_send_buf[i])
  end
  self.v_send_buf_top = 0
  self.v_send_buf = {}
  if self.v_conn_cb then
    self.v_conn_cb(true)
    self.v_conn_cb = nil
  end
end

function state.newconnect.dispose(state_self, success, err, status)
  if success then
    return true, nil, "connect"
  else
    err = string.format("sock_error:%s sock_status:%s sconn_state:newconnect", err, status)
    return false, err, "connect"
  end
end

function state.reconnect:request()
  self.v_reconnect_index = self.v_reconnect_index + 1
  local content = string.format([[
%d
%d
%d
]], self.v_id, self.v_reconnect_index, self.v_recvnumber)
  local hmac = crypt.base64encode(crypt.hmac64_md5(crypt.hashkey(content), self.v_secret))
  local data = string.format("%s%s\n", content, hmac)
  data = pack_data(data, DEF_MSG_HEADER_LEN, DEF_MSG_ENDIAN)
  log("reconnect request:", data)
  self.v_sock:send(data)
end

function state.reconnect:send(data)
  local rc4_c2s = self.v_rc4_c2s
  local cache = self.v_cache
  local compressor = self.v_compress_c2s
  if compressor then
    local err
    data, err = compressor:compress(data)
    if err then
      log("compress err:", err)
      switch_state(self, "forward_error")
      return
    end
  end
  data = rc4_c2s:crypt(data)
  self.v_sendnumber = self.v_sendnumber + #data
  cache:insert(data)
end

function state.reconnect:dispatch()
  local data = self.v_sock:pop_msg(DEF_MSG_HEADER_LEN, DEF_MSG_ENDIAN)
  if not data then
    return
  end
  local recv, msg = data:match([[
([^
]*)
([^
]*)]])
  recv = tonumber(recv)
  local sendnumber = self.v_sendnumber
  log("reconnect dispatch: recv:%s msg:%s data:%s", recv, msg, data)
  local cb = self.v_reconnect_cb
  self.v_reconnect_cb = nil
  if "200" ~= msg then
    log("msg:", msg)
    if cb then
      cb(false)
    end
    switch_state(self, "reconnect_error")
    return
  end
  if recv > sendnumber then
    if cb then
      cb(false)
    end
    switch_state(self, "reconnect_match_error")
    return
  end
  local nbytes = 0
  if recv < sendnumber then
    nbytes = sendnumber - recv
    local data = self.v_cache:get(nbytes)
    if not data then
      if cb then
        cb(false)
      end
      switch_state(self, "reconnect_cache_error")
      return
    end
    assert(#data == nbytes)
    self.v_sock:send(data)
  end
  switch_state(self, "forward")
  if cb then
    cb(true)
  end
end

function state.reconnect.dispose(state_self, success, err, status)
  if success then
    return true, nil, "reconnect"
  else
    err = string.format("sock_error:%s sock_status:%s sconn_state:reconnect", err, status)
    return false, err, "reconnect"
  end
end

function state.forward:dispatch()
  local recv_buf = self.v_recv_buf
  local rc4_s2c = self.v_rc4_s2c
  local decompressor = self.v_decompress_s2c
  local sock = self.v_sock
  local count = sock:recv(out)
  for i = 1, count do
    local v = out[i]
    self.v_recvnumber = self.v_recvnumber + #v
    v = rc4_s2c:crypt(v)
    if decompressor then
      local err
      v, err = decompressor:decompress(v)
      if err then
        log("decompress err:", err)
        switch_state(self, "forward_error")
        return
      end
    end
    recv_buf:push(v)
  end
end

function state.forward:send(data)
  local sock = self.v_sock
  local rc4_c2s = self.v_rc4_c2s
  local cache = self.v_cache
  local compressor = self.v_compress_c2s
  if compressor then
    local err
    data, err = compressor:compress(data)
    if err then
      log("compress err:", err)
      switch_state(self, "forward_error")
      return
    end
  end
  data = rc4_c2s:crypt(data)
  sock:send(data)
  self.v_sendnumber = self.v_sendnumber + #data
  cache:insert(data)
end

function state.forward.dispose(state_self, success, err, status)
  if success then
    if "forward" ~= status then
      error(string.format("invalid sock_status:%s", status))
    end
    return true, nil, "forward"
  else
    err = string.format("sock_error:%s sock_status:%s sconn_state:forward", err, status)
    return false, err, "forward"
  end
end

function state.close.dispose(state_self, success, err, status)
  err = string.format("sock_error:%s sock_status:%s sconn_state:close", err, status)
  return false, err, "close"
end

local function connect(network, host, port, targetserver, flag, accept_encodings, conn_cb)
  local sock, err = conn.connect_host(network, host, port)
  if not sock then
    if conn_cb then
      conn_cb(false)
    end
    return nil, err
  end
  local raw = {
    v_state = false,
    v_sock = sock,
    v_clientkey = false,
    v_secret = false,
    v_id = false,
    v_rc4_c2s = false,
    v_rc4_s2c = false,
    v_compress_c2s = false,
    v_decompress_s2c = false,
    v_sendnumber = 0,
    v_recvnumber = 0,
    v_reconnect_index = 0,
    v_cache = cache_create(),
    v_send_buf = {},
    v_send_buf_top = 0,
    v_conn_cb = conn_cb,
    v_recv_buf = buffer_queue.create()
  }
  local obj = setmetatable(raw, {__index = mt})
  switch_state(obj, "newconnect", targetserver, flag, accept_encodings)
  return obj
end

function mt:cur_state()
  return self.v_state.name
end

function mt:reconnect(cb)
  local state_name = self.v_state.name
  if "forward" ~= state_name and "close" ~= state_name and "reconnect" ~= state_name then
    return false, string.format("error state switch `%s` to reconnect", state_name)
  end
  local addr = self.v_sock.o_host_addr
  local port = self.v_sock.o_port
  local network = self.v_sock.o_network
  local success, err = self.v_sock:new_connect(network, addr, port)
  if not success then
    return false, err
  end
  self.v_reconnect_cb = cb
  switch_state(self, "reconnect")
  return true
end

function mt:flush_send()
end

function mt:update(msnow)
  local sock = self.v_sock
  local v_state = self.v_state
  local success, err, status = sock:update(msnow)
  local dispatch = v_state.dispatch
  if (success or v_state.name == "forward" or v_state.name == "reconnect") and dispatch then
    local ok, derr = pcall(dispatch, self)
    if not ok then
      log("sconn dispatch error:", derr)
    end
  end
  if "connect_break" == status then
    return success, err, status
  end
  do return v_state.dispose, v_state, success, err end
  return v_state.dispose, v_state, success, err, status
end

function mt:send(data)
  local _send = self.v_state.send
  if _send then
    _send(self, data)
  end
  return true
end

function mt:send_msg(data, header_len, endian)
  local _send = self.v_state.send
  header_len = header_len or DEF_MSG_HEADER_LEN
  endian = endian or DEF_MSG_ENDIAN
  data = pack_data(data, header_len, endian)
  if _send then
    _send(self, data)
  end
  return true
end

function mt:recv(out)
  local recv_buf = self.v_recv_buf
  do return recv_buf.pop_all, recv_buf end
  return recv_buf.pop_all, recv_buf, out
end

function mt:recv_msg(out_msg, header_len, endian)
  header_len = header_len or DEF_MSG_HEADER_LEN
  endian = endian or DEF_MSG_ENDIAN
  local recv_buf = self.v_recv_buf
  do return recv_buf.pop_all_block, recv_buf, out_msg, header_len end
  return recv_buf.pop_all_block, recv_buf, out_msg, header_len, endian
end

function mt:poll(events, timeout)
  do return self.v_sock.poll, self.v_sock, events end
  return self.v_sock.poll, self.v_sock, events, timeout
end

function mt:is_connect()
  if self.v_state then
    return self.v_state.name == state.forward.name
  end
end

function mt:close()
  self.v_sock:close()
  self.v_recv_buf:clear()
  switch_state(self, "close")
end

return {connect_host = connect}
