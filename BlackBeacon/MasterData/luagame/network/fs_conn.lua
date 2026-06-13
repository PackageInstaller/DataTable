local sconn = require("network.sconn.sconn")
local Latency = require("network.latency")
local Defines = require("network.sconn.defines")
local _floor = math.floor
local _sformat = string.format
local HEARTBEAT_INTERVAL = 5
local conn_mt = {}
conn_mt.__index = conn_mt

function conn_mt.new(info)
  local o = {}
  setmetatable(o, conn_mt)
  o:_init(info)
  return o
end

function conn_mt:_init(info)
  self.v_fs_token = assert(info.fs_token)
  local cfg = {}
  self.v_sconn = sconn.create(cfg, self)
  self.v_latency_obj = Latency.new(_sformat("role<%s> tcp", Global.player_uuid))
  self.v_login_cb = false
  self.v_reconnect_cb = false
  self.v_last_ping_send = 0
end

function conn_mt:set_login_cb(v)
  self.v_login_cb = v
end

function conn_mt:set_reconnect_cb(v)
  self.v_reconnect_cb = v
end

function conn_mt:name()
  return "战斗"
end

function conn_mt:get_login_request()
  local body = {
    token = self.v_fs_token
  }
  return body
end

function conn_mt:is_fs_conn()
  return true
end

function conn_mt:on_retry_newconnect(sock)
  return true
end

function conn_mt:on_reconnect(sock)
  if self.v_reconnect_cb then
    return self.v_reconnect_cb()
  end
  return true
end

function conn_mt:on_login_cb(ok, resp)
  if self.v_login_cb then
    self.v_login_cb(false, resp and resp.errcode or -2)
  end
end

function conn_mt:on_recover_cb(ok, resp)
  if self.v_login_cb then
    self.v_login_cb(true, resp and resp.errcode or -2)
  end
end

function conn_mt:update()
  if self.v_sconn then
    self.v_sconn:update()
  end
end

function conn_mt:on_update(state)
  if state == Defines.STATE_FORWARD then
    if Global.real_time - self.v_last_ping_send >= HEARTBEAT_INTERVAL then
      self.v_is_forward = true
      self.v_last_ping_send = Global.real_time
      self.v_latency_obj:start()
      Network:call("c2gs_heartbeat_fs", E, function(ok, resp)
        if not ok then
          return
        end
        self.v_latency_obj:stop()
        if 0 == resp.errcode then
          Network:call("c2gs_heartbeat_fs_ack", E)
        end
      end)
    end
  else
    self.v_is_forward = false
  end
end

function conn_mt:send_msg(data, proto_id)
  self.v_sconn:send_msg(data, proto_id)
end

function conn_mt:get_is_forward()
  return self.v_is_forward
end

function conn_mt:close()
  if self.v_sconn then
    self.v_sconn:close()
    self.v_sconn = nil
  end
end

function conn_mt:on_throw_error(...)
  Network:quit_fs()
end

function conn_mt:latency_dump()
  self.v_latency_obj:dump()
end

local function connect(info)
  local c = conn_mt.new(info)
  local host, port = string.match(info.fs_addr, "(%g+):(%g+)")
  local ipv6_addr = info.ipv6_addr
  print("connect fsconn: ", host, port)
  port = _floor(port)
  local sock, err = c.v_sconn:connect(host, port, ipv6_addr)
  if not sock then
    return nil, err
  end
  return c
end

return {connect_host = connect}
