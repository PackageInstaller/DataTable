local assert = _ENV.assert
local error = _ENV.error
local pairs = _ENV.pairs
local pcall = _ENV.pcall
local setmetatable = _ENV.setmetatable
local tostring = _ENV.tostring
local type = _ENV.type
local char = require("string").char
local math_type = require("math").type
local tointeger = require("math").tointeger
local tconcat = require("table").concat
local pack = require("string").pack
local unpack = require("string").unpack
local _ENV
local m = {}

local function argerror(caller, narg, extramsg)
  error("bad argument #" .. tostring(narg) .. " to " .. caller .. " (" .. extramsg .. ")")
end

local function typeerror(caller, narg, arg, tname)
  argerror(caller, narg, tname .. " expected, got " .. type(arg))
end

local function checktype(caller, narg, arg, tname)
  if type(arg) ~= tname then
    typeerror(caller, narg, arg, tname)
  end
end

local packers = setmetatable({}, {
  __index = function(t, k)
    error("pack '" .. k .. "' is unimplemented")
  end
})
m.packers = packers
packers["nil"] = function(buffer)
  buffer[#buffer + 1] = char(192)
end

function packers.boolean(buffer, bool)
  if bool then
    buffer[#buffer + 1] = char(195)
  else
    buffer[#buffer + 1] = char(194)
  end
end

function packers.string_compat(buffer, str)
  local n = #str
  if n <= 31 then
    buffer[#buffer + 1] = char(160 + n)
  elseif n <= 65535 then
    buffer[#buffer + 1] = char(218)
    buffer[#buffer + 1] = pack(">I2", n)
  elseif n <= 4294967295 then
    buffer[#buffer + 1] = char(219)
    buffer[#buffer + 1] = pack(">I4", n)
  else
    error("overflow in pack 'string_compat'")
  end
  buffer[#buffer + 1] = str
end

function packers._string(buffer, str)
  local n = #str
  if n <= 31 then
    buffer[#buffer + 1] = char(160 + n)
  elseif n <= 255 then
    buffer[#buffer + 1] = char(217, n)
  elseif n <= 65535 then
    buffer[#buffer + 1] = char(218)
    buffer[#buffer + 1] = pack(">I2", n)
  elseif n <= 4294967295 then
    buffer[#buffer + 1] = char(219)
    buffer[#buffer + 1] = pack(">I4", n)
  else
    error("overflow in pack 'string'")
  end
  buffer[#buffer + 1] = str
end

function packers.binary(buffer, str)
  local n = #str
  if n <= 255 then
    buffer[#buffer + 1] = char(196, n)
  elseif n <= 65535 then
    buffer[#buffer + 1] = char(197)
    buffer[#buffer + 1] = pack(">I2", n)
  elseif n <= 4294967295 then
    buffer[#buffer + 1] = char(198)
    buffer[#buffer + 1] = pack(">I4", n)
  else
    error("overflow in pack 'binary'")
  end
  buffer[#buffer + 1] = str
end

local function set_string(str)
  if "string_compat" == str then
    packers.string = packers.string_compat
  elseif "string" == str then
    packers.string = packers._string
  elseif "binary" == str then
    packers.string = packers.binary
  else
    argerror("set_string", 1, "invalid option '" .. str .. "'")
  end
end

m.set_string = set_string

function packers.map(buffer, tbl, n)
  if n <= 15 then
    buffer[#buffer + 1] = char(128 + n)
  elseif n <= 65535 then
    buffer[#buffer + 1] = char(222)
    buffer[#buffer + 1] = pack(">I2", n)
  elseif n <= 4294967295 then
    buffer[#buffer + 1] = char(223)
    buffer[#buffer + 1] = pack(">I4", n)
  else
    error("overflow in pack 'map'")
  end
  for k, v in pairs(tbl) do
    packers[type(k)](buffer, k)
    packers[type(v)](buffer, v)
  end
end

function packers.array(buffer, tbl, n)
  if n <= 15 then
    buffer[#buffer + 1] = char(144 + n)
  elseif n <= 65535 then
    buffer[#buffer + 1] = char(220)
    buffer[#buffer + 1] = pack(">I2", n)
  elseif n <= 4294967295 then
    buffer[#buffer + 1] = char(221)
    buffer[#buffer + 1] = pack(">I4", n)
  else
    error("overflow in pack 'array'")
  end
  for i = 1, n do
    local v = tbl[i]
    packers[type(v)](buffer, v)
  end
end

local function set_array(array)
  if "without_hole" == array then
    function packers._table(buffer, tbl)
      local is_map, n, max = false, 0, 0
      
      for k in pairs(tbl) do
        if "number" == type(k) and k > 0 then
          if k > max then
            max = k
          end
        else
          is_map = true
        end
        n = n + 1
      end
      if max ~= n then
        is_map = true
      end
      if is_map then
        return packers.map(buffer, tbl, n)
      else
        return packers.array(buffer, tbl, n)
      end
    end
  elseif "with_hole" == array then
    function packers._table(buffer, tbl)
      local is_map, n, max = false, 0, 0
      
      for k in pairs(tbl) do
        if "number" == type(k) and k > 0 then
          if k > max then
            max = k
          end
        else
          is_map = true
        end
        n = n + 1
      end
      if is_map then
        return packers.map(buffer, tbl, n)
      else
        return packers.array(buffer, tbl, max)
      end
    end
  elseif "always_as_map" == array then
    function packers._table(buffer, tbl)
      local n = 0
      
      for k in pairs(tbl) do
        n = n + 1
      end
      return packers.map(buffer, tbl, n)
    end
  else
    argerror("set_array", 1, "invalid option '" .. array .. "'")
  end
end

m.set_array = set_array

function packers.table(buffer, tbl)
  return packers._table(buffer, tbl)
end

function packers.unsigned(buffer, n)
  if n >= 0 then
    if n <= 127 then
      buffer[#buffer + 1] = char(n)
    elseif n <= 255 then
      buffer[#buffer + 1] = char(204, n)
    elseif n <= 65535 then
      buffer[#buffer + 1] = char(205)
      buffer[#buffer + 1] = pack(">I2", n)
    elseif n <= 4294967295 then
      buffer[#buffer + 1] = char(206)
      buffer[#buffer + 1] = pack(">I4", n)
    else
      buffer[#buffer + 1] = char(207)
      buffer[#buffer + 1] = pack(">I8", n)
    end
  elseif n >= -32 then
    buffer[#buffer + 1] = char(256 + n)
  elseif n >= -128 then
    buffer[#buffer + 1] = char(208)
    buffer[#buffer + 1] = pack(">i1", n)
  elseif n >= -32768 then
    buffer[#buffer + 1] = char(209)
    buffer[#buffer + 1] = pack(">i2", n)
  elseif n >= -2147483648 then
    buffer[#buffer + 1] = char(210)
    buffer[#buffer + 1] = pack(">i4", n)
  else
    buffer[#buffer + 1] = char(211)
    buffer[#buffer + 1] = pack(">i8", n)
  end
end

function packers.signed(buffer, n)
  if n >= 0 then
    if n <= 127 then
      buffer[#buffer + 1] = char(n)
    elseif n <= 32767 then
      buffer[#buffer + 1] = char(209)
      buffer[#buffer + 1] = pack(">i2", n)
    elseif n <= 2147483647 then
      buffer[#buffer + 1] = char(210)
      buffer[#buffer + 1] = pack(">i4", n)
    else
      buffer[#buffer + 1] = char(211)
      buffer[#buffer + 1] = pack(">i8", n)
    end
  elseif n >= -32 then
    buffer[#buffer + 1] = char(256 + n)
  elseif n >= -128 then
    buffer[#buffer + 1] = char(208)
    buffer[#buffer + 1] = pack(">i1", n)
  elseif n >= -32768 then
    buffer[#buffer + 1] = char(209)
    buffer[#buffer + 1] = pack(">i2", n)
  elseif n >= -2147483648 then
    buffer[#buffer + 1] = char(210)
    buffer[#buffer + 1] = pack(">i4", n)
  else
    buffer[#buffer + 1] = char(211)
    buffer[#buffer + 1] = pack(">i8", n)
  end
end

local function set_integer(integer)
  if "unsigned" == integer then
    packers.integer = packers.unsigned
  elseif "signed" == integer then
    packers.integer = packers.signed
  else
    argerror("set_integer", 1, "invalid option '" .. integer .. "'")
  end
end

m.set_integer = set_integer

function packers.float(buffer, n)
  buffer[#buffer + 1] = char(202)
  buffer[#buffer + 1] = pack(">f", n)
end

function packers.double(buffer, n)
  buffer[#buffer + 1] = char(203)
  buffer[#buffer + 1] = pack(">d", n)
end

local function set_number(number)
  if "integer" == number then
    packers.number = packers.signed
  elseif "float" == number then
    function packers.number(buffer, n)
      if "float" == math_type(n) then
        return packers.float(buffer, n)
      else
        return packers.integer(buffer, n)
      end
    end
  elseif "double" == number then
    function packers.number(buffer, n)
      if "float" == math_type(n) then
        return packers.double(buffer, n)
      else
        return packers.integer(buffer, n)
      end
    end
  else
    argerror("set_number", 1, "invalid option '" .. number .. "'")
  end
end

m.set_number = set_number
for k = 0, 4 do
  local n = tointeger(2 ^ k)
  local fixext = 212 + k
  packers["fixext" .. tostring(n)] = function(buffer, tag, data)
    assert(#data == n, "bad length for fixext" .. tostring(n))
    buffer[#buffer + 1] = char(fixext)
    buffer[#buffer + 1] = pack(">i1", tag)
    buffer[#buffer + 1] = data
  end
end

function packers.ext(buffer, tag, data)
  local n = #data
  if n <= 255 then
    buffer[#buffer + 1] = char(199, n)
    buffer[#buffer + 1] = pack(">i1", tag)
  elseif n <= 65535 then
    buffer[#buffer + 1] = char(200)
    buffer[#buffer + 1] = pack(">I2", n)
    buffer[#buffer + 1] = pack(">i1", tag)
  elseif n <= 4294967295 then
    buffer[#buffer + 1] = char(201)
    buffer[#buffer + 1] = pack(">I4", n)
    buffer[#buffer + 1] = pack(">i1", tag)
  else
    error("overflow in pack 'ext'")
  end
  buffer[#buffer + 1] = data
end

function m.pack(data)
  local buffer = {}
  packers[type(data)](buffer, data)
  return tconcat(buffer)
end

local types_map = setmetatable({
  [192] = "nil",
  [194] = "false",
  [195] = "true",
  [196] = "bin8",
  [197] = "bin16",
  [198] = "bin32",
  [199] = "ext8",
  [200] = "ext16",
  [201] = "ext32",
  [202] = "float",
  [203] = "double",
  [204] = "uint8",
  [205] = "uint16",
  [206] = "uint32",
  [207] = "uint64",
  [208] = "int8",
  [209] = "int16",
  [210] = "int32",
  [211] = "int64",
  [212] = "fixext1",
  [213] = "fixext2",
  [214] = "fixext4",
  [215] = "fixext8",
  [216] = "fixext16",
  [217] = "str8",
  [218] = "str16",
  [219] = "str32",
  [220] = "array16",
  [221] = "array32",
  [222] = "map16",
  [223] = "map32"
}, {
  __index = function(t, k)
    if k < 192 then
      if k < 128 then
        return "fixnum_pos"
      elseif k < 144 then
        return "fixmap"
      elseif k < 160 then
        return "fixarray"
      else
        return "fixstr"
      end
    elseif k > 223 then
      return "fixnum_neg"
    else
      return "reserved" .. tostring(k)
    end
  end
})
m.types_map = types_map
local unpackers = setmetatable({}, {
  __index = function(t, k)
    error("unpack '" .. k .. "' is unimplemented")
  end
})
m.unpackers = unpackers

local function unpack_array(c, n)
  local t = {}
  local decode = unpackers.any
  for i = 1, n do
    t[i] = decode(c)
  end
  return t
end

local function unpack_map(c, n)
  local t = {}
  local decode = unpackers.any
  for i = 1, n do
    local k = decode(c)
    local val = decode(c)
    if nil == k or k ~= k then
      k = m.sentinel
    end
    if nil ~= k then
      t[k] = val
    end
  end
  return t
end

function unpackers.any(c)
  local s, i, j = c.s, c.i, c.j
  if i > j then
    c:underflow(i)
    s, i, j = c.s, c.i, c.j
  end
  local val = s:sub(i, i):byte()
  c.i = i + 1
  return unpackers[types_map[val]](c, val)
end

unpackers["nil"] = function()
  return nil
end
unpackers["false"] = function()
  return false
end
unpackers["true"] = function()
  return true
end

function unpackers.float(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 3 then
    c:underflow(i + 3)
    s, i, j = c.s, c.i, c.j
  end
  c.i = i + 4
  return unpack(">f", s, i)
end

function unpackers.double(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 7 then
    c:underflow(i + 7)
    s, i, j = c.s, c.i, c.j
  end
  c.i = i + 8
  return unpack(">d", s, i)
end

function unpackers.fixnum_pos(c, val)
  return val
end

function unpackers.uint8(c)
  local s, i, j = c.s, c.i, c.j
  if i > j then
    c:underflow(i)
    s, i, j = c.s, c.i, c.j
  end
  c.i = i + 1
  return unpack(">I1", s, i)
end

function unpackers.uint16(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 1 then
    c:underflow(i + 1)
    s, i, j = c.s, c.i, c.j
  end
  c.i = i + 2
  return unpack(">I2", s, i)
end

function unpackers.uint32(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 3 then
    c:underflow(i + 3)
    s, i, j = c.s, c.i, c.j
  end
  c.i = i + 4
  return unpack(">I4", s, i)
end

function unpackers.uint64(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 7 then
    c:underflow(i + 7)
    s, i, j = c.s, c.i, c.j
  end
  c.i = i + 8
  return unpack(">I8", s, i)
end

function unpackers.fixnum_neg(c, val)
  return val - 256
end

function unpackers.int8(c)
  local s, i, j = c.s, c.i, c.j
  if i > j then
    c:underflow(i)
    s, i, j = c.s, c.i, c.j
  end
  c.i = i + 1
  return unpack(">i1", s, i)
end

function unpackers.int16(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 1 then
    c:underflow(i + 1)
    s, i, j = c.s, c.i, c.j
  end
  c.i = i + 2
  return unpack(">i2", s, i)
end

function unpackers.int32(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 3 then
    c:underflow(i + 3)
    s, i, j = c.s, c.i, c.j
  end
  c.i = i + 4
  return unpack(">i4", s, i)
end

function unpackers.int64(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 7 then
    c:underflow(i + 7)
    s, i, j = c.s, c.i, c.j
  end
  c.i = i + 8
  return unpack(">i8", s, i)
end

function unpackers.fixstr(c, val)
  local s, i, j = c.s, c.i, c.j
  local n = val & 31
  local e = i + n - 1
  if j < e then
    c:underflow(e)
    s, i, j = c.s, c.i, c.j
    e = i + n - 1
  end
  c.i = i + n
  return s:sub(i, e)
end

function unpackers.str8(c)
  local s, i, j = c.s, c.i, c.j
  if i > j then
    c:underflow(i)
    s, i, j = c.s, c.i, c.j
  end
  local n = unpack(">I1", s, i)
  i = i + 1
  c.i = i
  local e = i + n - 1
  if j < e then
    c:underflow(e)
    s, i, j = c.s, c.i, c.j
    e = i + n - 1
  end
  c.i = i + n
  return s:sub(i, e)
end

function unpackers.str16(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 1 then
    c:underflow(i + 1)
    s, i, j = c.s, c.i, c.j
  end
  local n = unpack(">I2", s, i)
  i = i + 2
  c.i = i
  local e = i + n - 1
  if j < e then
    c:underflow(e)
    s, i, j = c.s, c.i, c.j
    e = i + n - 1
  end
  c.i = i + n
  return s:sub(i, e)
end

function unpackers.str32(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 3 then
    c:underflow(i + 3)
    s, i, j = c.s, c.i, c.j
  end
  local n = unpack(">I4", s, i)
  i = i + 4
  c.i = i
  local e = i + n - 1
  if j < e then
    c:underflow(e)
    s, i, j = c.s, c.i, c.j
    e = i + n - 1
  end
  c.i = i + n
  return s:sub(i, e)
end

unpackers.bin8 = unpackers.str8
unpackers.bin16 = unpackers.str16
unpackers.bin32 = unpackers.str32

function unpackers.fixarray(c, val)
  return unpack_array(c, val & 15)
end

function unpackers.array16(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 1 then
    c:underflow(i + 1)
    s, i, j = c.s, c.i, c.j
  end
  local n = unpack(">I2", s, i)
  c.i = i + 2
  return unpack_array(c, n)
end

function unpackers.array32(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 3 then
    c:underflow(i + 3)
    s, i, j = c.s, c.i, c.j
  end
  local n = unpack(">I4", s, i)
  c.i = i + 4
  return unpack_array(c, n)
end

function unpackers.fixmap(c, val)
  return unpack_map(c, val & 15)
end

function unpackers.map16(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 1 then
    c:underflow(i + 1)
    s, i, j = c.s, c.i, c.j
  end
  local n = unpack(">I2", s, i)
  c.i = i + 2
  return unpack_map(c, n)
end

function unpackers.map32(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 3 then
    c:underflow(i + 3)
    s, i, j = c.s, c.i, c.j
  end
  local n = unpack(">I4", s, i)
  c.i = i + 4
  return unpack_map(c, n)
end

function m.build_ext(tag, data)
  return nil
end

for k = 0, 4 do
  local n = tointeger(2 ^ k)
  unpackers["fixext" .. tostring(n)] = function(c)
    local s, i, j = c.s, c.i, c.j
    if i > j then
      c:underflow(i)
      s, i, j = c.s, c.i, c.j
    end
    local tag = unpack(">i1", s, i)
    i = i + 1
    c.i = i
    local e = i + n - 1
    if j < e then
      c:underflow(e)
      s, i, j = c.s, c.i, c.j
      e = i + n - 1
    end
    c.i = i + n
    return m.build_ext(tag, s:sub(i, e))
  end
end

function unpackers.ext8(c)
  local s, i, j = c.s, c.i, c.j
  if i > j then
    c:underflow(i)
    s, i, j = c.s, c.i, c.j
  end
  local n = unpack(">I1", s, i)
  i = i + 1
  c.i = i
  if j < i then
    c:underflow(i)
    s, i, j = c.s, c.i, c.j
  end
  local tag = unpack(">i1", s, i)
  i = i + 1
  c.i = i
  local e = i + n - 1
  if j < e then
    c:underflow(e)
    s, i, j = c.s, c.i, c.j
    e = i + n - 1
  end
  c.i = i + n
  return m.build_ext(tag, s:sub(i, e))
end

function unpackers.ext16(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 1 then
    c:underflow(i + 1)
    s, i, j = c.s, c.i, c.j
  end
  local n = unpack(">I2", s, i)
  i = i + 2
  c.i = i
  if j < i then
    c:underflow(i)
    s, i, j = c.s, c.i, c.j
  end
  local tag = unpack(">i1", s, i)
  i = i + 1
  c.i = i
  local e = i + n - 1
  if j < e then
    c:underflow(e)
    s, i, j = c.s, c.i, c.j
    e = i + n - 1
  end
  c.i = i + n
  return m.build_ext(tag, s:sub(i, e))
end

function unpackers.ext32(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 3 then
    c:underflow(i + 3)
    s, i, j = c.s, c.i, c.j
  end
  local n = unpack(">I4", s, i)
  i = i + 4
  c.i = i
  if j < i then
    c:underflow(i)
    s, i, j = c.s, c.i, c.j
  end
  local tag = unpack(">i1", s, i)
  i = i + 1
  c.i = i
  local e = i + n - 1
  if j < e then
    c:underflow(e)
    s, i, j = c.s, c.i, c.j
    e = i + n - 1
  end
  c.i = i + n
  return m.build_ext(tag, s:sub(i, e))
end

local function cursor_string(str)
  return {
    s = str,
    i = 1,
    j = #str,
    underflow = function(self)
      error("missing bytes")
    end
  }
end

local function cursor_loader(ld)
  return {
    s = "",
    i = 1,
    j = 0,
    underflow = function(self, e)
      self.s = self.s:sub(self.i)
      e = e - self.i + 1
      self.i = 1
      self.j = 0
      while e > self.j do
        local chunk = ld()
        if not chunk then
          error("missing bytes")
        end
        self.s = self.s .. chunk
        self.j = #self.s
      end
    end
  }
end

function m.unpack(s)
  checktype("unpack", 1, s, "string")
  local cursor = cursor_string(s)
  local data = unpackers.any(cursor)
  if cursor.i < cursor.j then
    error("extra bytes")
  end
  return data
end

function m.unpacker(src)
  if "string" == type(src) then
    local cursor = cursor_string(src)
    return function()
      if cursor.i <= cursor.j then
        return cursor.i, unpackers.any(cursor)
      end
    end
  elseif "function" == type(src) then
    local cursor = cursor_loader(src)
    return function()
      if cursor.i > cursor.j then
        pcall(cursor.underflow, cursor, cursor.i)
      end
      if cursor.i <= cursor.j then
        return true, unpackers.any(cursor)
      end
    end
  else
    argerror("unpacker", 1, "string or function expected, got " .. type(src))
  end
end

set_string("string_compat")
set_integer("unsigned")
if math_type(0.0) == math_type(0) then
  set_number("integer")
elseif 4 == #pack("n", 0.0) then
  m.small_lua = true
  set_number("float")
else
  m.full64bits = true
  set_number("double")
  if #pack("n", 0.0) > 8 then
    m.long_double = true
  end
end
set_array("without_hole")
m._VERSION = "0.3.4"
m._DESCRIPTION = "lua-MessagePack : a pure Lua implementation"
m._COPYRIGHT = "Copyright (c) 2012-2016 Francois Perrad"
return m
