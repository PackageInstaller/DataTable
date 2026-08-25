local assert = _ENV.assert
local error = _ENV.error
local string = _ENV.string
local table = _ENV.table
local tostring = _ENV.tostring
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local bitutil = compat.bitutil
local compat_string = compat.string
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.CHAT .. "protocol"
local M = {}
M.StatusSucceed = 0
M.StatusUnknown = 1
M.StatusCanceled = 2
M.StatusBadRequest = 40
M.StatusMethodNotFound = 41
M.StatusCodecNotSupported = 42
M.StatusInternalServerError = 50
local ktt = {}
ktt[1] = "codec"
ktt.codec = 1
ktt[2] = "method"
ktt.method = 2
ktt[3] = "session"
ktt.session = 3
ktt[4] = "code"
ktt.code = 4
ktt[5] = "error"
ktt.error = 5
ktt[6] = "timestamp"
ktt.timestamp = 6
ktt[7] = "trace"
ktt.trace = 7
ktt[8] = "destination"
ktt.destination = 8
ktt[9] = "source"
ktt.source = 9
ktt[10] = "fragment"
ktt.fragment = 10
ktt[11] = "content_encoding"
ktt.content_encoding = 11
local vtt = {}
vtt[1] = "json"
vtt.json = 1
vtt[2] = "sproto"
vtt.sproto = 2
vtt[3] = "protobuf"
vtt.protobuf = 3
vtt[4] = "raw"
vtt.raw = 4
vtt[5] = "0"
vtt["0"] = 5
vtt[6] = "deflate"
vtt.deflate = 6

local function encode_key(k)
  k = tostring(k)
  local kt = ktt[k]
  if kt then
    do return compat_string.pack, "B", bitutil.bor(128, kt) end
    return compat_string.pack, "B", bitutil.bor(128, kt)
  else
    local lenk = #k
    assert(lenk < 127, "key length larger than 127: " .. k)
    do return compat_string.pack, ">s1" end
    return compat_string.pack, ">s1", k, k
  end
end

local function encode_value(v)
  v = tostring(v)
  local vt = vtt[v]
  if vt then
    do return compat_string.pack, "B", bitutil.bor(128, vt) end
    return compat_string.pack, "B", bitutil.bor(128, vt)
  else
    local lenv = #v
    if lenv < 64 then
      do return compat_string.pack, ">s1" end
      return compat_string.pack, ">s1", v, bitutil.bor(128, vt)
    elseif lenv < 16384 then
      do return compat_string.pack, string.format(">BBc%s", lenv), bitutil.bor(64, bitutil.rshift(lenv, 8)), (bitutil.band(lenv, 255)) end
      return compat_string.pack, string.format(">BBc%s", lenv), bitutil.bor(64, bitutil.rshift(lenv, 8)), bitutil.band(lenv, 255), v, 255, bitutil.rshift(lenv, 8)
    else
      error(string.format("Not supported string length, %s", v))
    end
  end
end

function M.encode_header(header)
  local packlist = {}
  for k, v in pairs(header) do
    table.insert(packlist, encode_key(k))
    table.insert(packlist, encode_value(v))
  end
  do return table.concat end
  return table.concat, packlist, pairs(header)
end

local function decode_key(chunk, pos)
  local key, byte, _
  byte, _ = compat_string.unpack("B", chunk, pos)
  if 0 == bitutil.band(byte, 128) then
    key, pos = compat_string.unpack(">s1", chunk, pos)
  elseif 128 == bitutil.band(byte, 128) then
    byte, pos = compat_string.unpack("B", chunk, pos)
    key = ktt[bitutil.band(byte, 127)]
  else
    error("not supported key format")
  end
  return key, pos
end

local function decode_value(chunk, pos)
  local len, value, byte, _
  byte, _ = compat_string.unpack("B", chunk, pos)
  if 0 == bitutil.band(byte, 192) then
    len, pos = compat_string.unpack("B", chunk, pos)
    if 0 == len then
      value = ""
    else
      value, pos = compat_string.unpack(string.format(">c%s", len), chunk, pos)
    end
  elseif 64 == bitutil.band(byte, 192) then
    local i1, i2
    i1, i2, pos = compat_string.unpack("BB", chunk, pos)
    len = bitutil.lshift(bitutil.band(i1, 63), 8) + i2
    value, pos = compat_string.unpack(string.format(">c%s", len), chunk, pos)
  elseif 128 == bitutil.band(byte, 128) then
    byte, pos = compat_string.unpack("B", chunk, pos)
    value = vtt[bitutil.band(byte, 127)]
  else
    error("not supported value format")
  end
  return value, pos
end

function M.decode_header(chunk)
  local header = {}
  local pos = 1
  while pos < #chunk do
    local key, value
    key, pos = decode_key(chunk, pos)
    value, pos = decode_value(chunk, pos)
    header[key] = value
  end
  return header
end

return M
