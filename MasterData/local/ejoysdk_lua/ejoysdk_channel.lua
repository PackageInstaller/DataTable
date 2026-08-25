local Class = require("ejoysdk_lua.ejoysdk_class")
local C = _ejoysdk.channel
local M = {}
local Channel = Class:Inherit("LuaChannel")
M.Channel = Channel

function Channel:_init()
  self._main = true
  self._in = C.new(1024)
  self._out = C.new(1024)
end

function Channel:sync_main_channel_info()
  _ejoysdk.log("sync_main_channel_info begin")
  if C.sync_channel_queue_info then
    C.sync_channel_queue_info(self._out, self._in)
  else
    _ejoysdk.log("sync_main_channel_info failed, sync_channel_queue_info is undefined")
  end
end

function Channel:push(...)
  local msg = C.pack(...)
  do return C.push, self._out end
  return C.push, self._out, msg
end

function Channel:pop()
  local msg = C.pop(self._in)
  do return C.unpack_remove end
  return C.unpack_remove, msg
end

function Channel:pedding()
  do return C.len end
  return C.len, self._in
end

function Channel:get_entry()
  local in_entry = C.entry(self._in)
  local out_entry = C.entry(self._out)
  return in_entry .. ":" .. out_entry
end

function Channel:__gc()
  _ejoysdk.log("on free")
  if self._main then
    C.free(self._in)
    C.free(self._out)
  end
end

local function split(inputstr, sep)
  if nil == sep then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

function M.attach(entry)
  local channel = Channel:New()
  channel._main = false
  local in_out = split(entry, ":")
  channel._in = C.new(in_out[2])
  channel._out = C.new(in_out[1])
  return channel
end

return M
