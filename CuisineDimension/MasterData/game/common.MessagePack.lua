local r, jit = pcall(require, "jit")
if not r then
  jit = nil
end
local SIZEOF_NUMBER = string.pack and #string.pack("n", 0) or 8
local NUMBER_INTEGRAL = math.type and math.type(0) == math.type(0) or false
if not jit and _VERSION < "Lua 5.3" then
  local loadstring = loadstring or load
  local luac = string.dump(loadstring("a = 1"))
  local header = {
    luac:sub(1, 12):byte(1, 12)
  }
  SIZEOF_NUMBER = header[11]
  NUMBER_INTEGRAL = 1 == header[12]
end
local assert = assert
local error = error
local pairs = pairs
local pcall = pcall
local setmetatable = setmetatable
local tostring = tostring
local type = type
local char = require("string").char
local floor = require("math").floor
local tointeger = require("math").tointeger or floor
local frexp = require("math").frexp or require("mathx").frexp
local ldexp = require("math").ldexp or require("mathx").ldexp
local huge = require("math").huge
local tconcat = require("table").concat
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
    buffer[#buffer + 1] = char(218, floor(n / 256), n % 256)
  elseif n <= 4294967295 then
    buffer[#buffer + 1] = char(219, floor(n / 16777216), floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
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
    buffer[#buffer + 1] = char(218, floor(n / 256), n % 256)
  elseif n <= 4294967295 then
    buffer[#buffer + 1] = char(219, floor(n / 16777216), floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
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
    buffer[#buffer + 1] = char(197, floor(n / 256), n % 256)
  elseif n <= 4294967295 then
    buffer[#buffer + 1] = char(198, floor(n / 16777216), floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
  else
    error("overflow in pack 'binary'")
  end
  buffer[#buffer + 1] = str
end

local function set_string(str)
  if str == "string_compat" then
    packers.string = packers.string_compat
  elseif str == "string" then
    packers.string = packers._string
  elseif str == "binary" then
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
    buffer[#buffer + 1] = char(222, floor(n / 256), n % 256)
  elseif n <= 4294967295 then
    buffer[#buffer + 1] = char(223, floor(n / 16777216), floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
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
    buffer[#buffer + 1] = char(220, floor(n / 256), n % 256)
  elseif n <= 4294967295 then
    buffer[#buffer + 1] = char(221, floor(n / 16777216), floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
  else
    error("overflow in pack 'array'")
  end
  for i = 1, n do
    local v = tbl[i]
    packers[type(v)](buffer, v)
  end
end

local function set_array(array)
  if array == "without_hole" then
    function packers._table(buffer, tbl)
      local is_map, n, max = false, 0, 0
      
      for k in pairs(tbl) do
        if type(k) == "number" and 0 < k then
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
  elseif array == "with_hole" then
    function packers._table(buffer, tbl)
      local is_map, n, max = false, 0, 0
      
      for k in pairs(tbl) do
        if type(k) == "number" and 0 < k then
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
  elseif array == "always_as_map" then
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
  if 0 <= n then
    if n <= 127 then
      buffer[#buffer + 1] = char(n)
    elseif n <= 255 then
      buffer[#buffer + 1] = char(204, n)
    elseif n <= 65535 then
      buffer[#buffer + 1] = char(205, floor(n / 256), n % 256)
    elseif n <= 4294967295 then
      buffer[#buffer + 1] = char(206, floor(n / 16777216), floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
    else
      buffer[#buffer + 1] = char(207, 0, floor(n / 281474976710656) % 256, floor(n / 1099511627776) % 256, floor(n / 4294967296) % 256, floor(n / 16777216) % 256, floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
    end
  elseif -32 <= n then
    buffer[#buffer + 1] = char(256 + n)
  elseif -128 <= n then
    buffer[#buffer + 1] = char(208, 256 + n)
  elseif -32768 <= n then
    n = 65536 + n
    buffer[#buffer + 1] = char(209, floor(n / 256), n % 256)
  elseif -2147483648 <= n then
    n = 4294967296 + n
    buffer[#buffer + 1] = char(210, floor(n / 16777216), floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
  else
    buffer[#buffer + 1] = char(211, 255, floor(n / 281474976710656) % 256, floor(n / 1099511627776) % 256, floor(n / 4294967296) % 256, floor(n / 16777216) % 256, floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
  end
end

function packers.signed(buffer, n)
  if 0 <= n then
    if n <= 127 then
      buffer[#buffer + 1] = char(n)
    elseif n <= 32767 then
      buffer[#buffer + 1] = char(209, floor(n / 256), n % 256)
    elseif n <= 2147483647 then
      buffer[#buffer + 1] = char(210, floor(n / 16777216), floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
    else
      buffer[#buffer + 1] = char(211, 0, floor(n / 281474976710656) % 256, floor(n / 1099511627776) % 256, floor(n / 4294967296) % 256, floor(n / 16777216) % 256, floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
    end
  elseif -32 <= n then
    buffer[#buffer + 1] = char(256 + n)
  elseif -128 <= n then
    buffer[#buffer + 1] = char(208, 256 + n)
  elseif -32768 <= n then
    n = 65536 + n
    buffer[#buffer + 1] = char(209, floor(n / 256), n % 256)
  elseif -2147483648 <= n then
    n = 4294967296 + n
    buffer[#buffer + 1] = char(210, floor(n / 16777216), floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
  else
    buffer[#buffer + 1] = char(211, 255, floor(n / 281474976710656) % 256, floor(n / 1099511627776) % 256, floor(n / 4294967296) % 256, floor(n / 16777216) % 256, floor(n / 65536) % 256, floor(n / 256) % 256, n % 256)
  end
end

local function set_integer(integer)
  if integer == "unsigned" then
    packers.integer = packers.unsigned
  elseif integer == "signed" then
    packers.integer = packers.signed
  else
    argerror("set_integer", 1, "invalid option '" .. integer .. "'")
  end
end

m.set_integer = set_integer

function packers.float(buffer, n)
  local sign = 0
  if n < 0 then
    sign = 128
    n = -n
  end
  local mant, expo = frexp(n)
  if mant ~= mant then
    buffer[#buffer + 1] = char(202, 255, 136, 0, 0)
  elseif mant == huge or 128 < expo then
    if sign == 0 then
      buffer[#buffer + 1] = char(202, 127, 128, 0, 0)
    else
      buffer[#buffer + 1] = char(202, 255, 128, 0, 0)
    end
  elseif mant == 0 and expo == 0 or expo < -126 then
    buffer[#buffer + 1] = char(202, sign, 0, 0, 0)
  else
    expo = expo + 126
    mant = (mant * 2 - 1) * ldexp(0.5, 24)
    buffer[#buffer + 1] = char(202, sign + floor(expo / 2), expo % 2 * 128 + floor(mant / 65536), floor(mant / 256) % 256, mant % 256)
  end
end

function packers.double(buffer, n)
  local sign = 0
  if n < 0 then
    sign = 128
    n = -n
  end
  local mant, expo = frexp(n)
  if mant ~= mant then
    buffer[#buffer + 1] = char(203, 255, 248, 0, 0, 0, 0, 0, 0)
  elseif mant == huge then
    if sign == 0 then
      buffer[#buffer + 1] = char(203, 127, 240, 0, 0, 0, 0, 0, 0)
    else
      buffer[#buffer + 1] = char(203, 255, 240, 0, 0, 0, 0, 0, 0)
    end
  elseif mant == 0 and expo == 0 then
    buffer[#buffer + 1] = char(203, sign, 0, 0, 0, 0, 0, 0, 0)
  else
    expo = expo + 1022
    mant = (mant * 2 - 1) * ldexp(0.5, 53)
    buffer[#buffer + 1] = char(203, sign + floor(expo / 16), expo % 16 * 16 + floor(mant / 281474976710656), floor(mant / 1099511627776) % 256, floor(mant / 4294967296) % 256, floor(mant / 16777216) % 256, floor(mant / 65536) % 256, floor(mant / 256) % 256, mant % 256)
  end
end

local function set_number(number)
  if number == "integer" then
    packers.number = packers.signed
  elseif number == "float" then
    function packers.number(buffer, n)
      if floor(n) ~= n or n ~= n or 3.40282347E38 < n or n < -3.40282347E38 then
        return packers.float(buffer, n)
      else
        return packers.integer(buffer, n)
      end
    end
  elseif number == "double" then
    function packers.number(buffer, n)
      if floor(n) ~= n or n ~= n or n == huge or n == -huge then
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
    buffer[#buffer + 1] = char(fixext, tag < 0 and tag + 256 or tag)
    buffer[#buffer + 1] = data
  end
end

function packers.ext(buffer, tag, data)
  local n = #data
  if n <= 255 then
    buffer[#buffer + 1] = char(199, n, tag < 0 and tag + 256 or tag)
  elseif n <= 65535 then
    buffer[#buffer + 1] = char(200, floor(n / 256), n % 256, tag < 0 and tag + 256 or tag)
  elseif n <= 4294967295 then
    buffer[#buffer + 1] = char(201, floor(n / 16777216), floor(n / 65536) % 256, floor(n / 256) % 256, n % 256, tag < 0 and tag + 256 or tag)
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
    elseif 223 < k then
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
    if k == nil then
      k = m.sentinel
    end
    if k ~= nil then
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
  local b1, b2, b3, b4 = s:sub(i, i + 3):byte(1, 4)
  local sign = 127 < b1
  local expo = b1 % 128 * 2 + floor(b2 / 128)
  local mant = (b2 % 128 * 256 + b3) * 256 + b4
  if sign then
    sign = -1
  else
    sign = 1
  end
  local n
  if mant == 0 and expo == 0 then
    n = sign * 0
  elseif expo == 255 then
    if mant == 0 then
      n = sign * huge
    else
      n = 0 / 0
    end
  else
    n = sign * ldexp(1 + mant / 8388608, expo - 127)
  end
  c.i = i + 4
  return n
end

function unpackers.double(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 7 then
    c:underflow(i + 7)
    s, i, j = c.s, c.i, c.j
  end
  local b1, b2, b3, b4, b5, b6, b7, b8 = s:sub(i, i + 7):byte(1, 8)
  local sign = 127 < b1
  local expo = b1 % 128 * 16 + floor(b2 / 16)
  local mant = (((((b2 % 16 * 256 + b3) * 256 + b4) * 256 + b5) * 256 + b6) * 256 + b7) * 256 + b8
  if sign then
    sign = -1
  else
    sign = 1
  end
  local n
  if mant == 0 and expo == 0 then
    n = sign * 0
  elseif expo == 2047 then
    if mant == 0 then
      n = sign * huge
    else
      n = 0 / 0
    end
  else
    n = sign * ldexp(1 + mant / 4503599627370496, expo - 1023)
  end
  c.i = i + 8
  return n
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
  local b1 = s:sub(i, i):byte()
  c.i = i + 1
  return b1
end

function unpackers.uint16(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 1 then
    c:underflow(i + 1)
    s, i, j = c.s, c.i, c.j
  end
  local b1, b2 = s:sub(i, i + 1):byte(1, 2)
  c.i = i + 2
  return b1 * 256 + b2
end

function unpackers.uint32(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 3 then
    c:underflow(i + 3)
    s, i, j = c.s, c.i, c.j
  end
  local b1, b2, b3, b4 = s:sub(i, i + 3):byte(1, 4)
  c.i = i + 4
  return ((b1 * 256 + b2) * 256 + b3) * 256 + b4
end

function unpackers.uint64(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 7 then
    c:underflow(i + 7)
    s, i, j = c.s, c.i, c.j
  end
  local b1, b2, b3, b4, b5, b6, b7, b8 = s:sub(i, i + 7):byte(1, 8)
  c.i = i + 8
  return ((((((b1 * 256 + b2) * 256 + b3) * 256 + b4) * 256 + b5) * 256 + b6) * 256 + b7) * 256 + b8
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
  local b1 = s:sub(i, i):byte()
  c.i = i + 1
  if b1 < 128 then
    return b1
  else
    return b1 - 256
  end
end

function unpackers.int16(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 1 then
    c:underflow(i + 1)
    s, i, j = c.s, c.i, c.j
  end
  local b1, b2 = s:sub(i, i + 1):byte(1, 2)
  c.i = i + 2
  if b1 < 128 then
    return b1 * 256 + b2
  else
    return (b1 - 255) * 256 + (b2 - 255) - 1
  end
end

function unpackers.int32(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 3 then
    c:underflow(i + 3)
    s, i, j = c.s, c.i, c.j
  end
  local b1, b2, b3, b4 = s:sub(i, i + 3):byte(1, 4)
  c.i = i + 4
  if b1 < 128 then
    return ((b1 * 256 + b2) * 256 + b3) * 256 + b4
  else
    return (((b1 - 255) * 256 + (b2 - 255)) * 256 + (b3 - 255)) * 256 + (b4 - 255) - 1
  end
end

function unpackers.int64(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 7 then
    c:underflow(i + 7)
    s, i, j = c.s, c.i, c.j
  end
  local b1, b2, b3, b4, b5, b6, b7, b8 = s:sub(i, i + 7):byte(1, 8)
  c.i = i + 8
  if b1 < 128 then
    return ((((((b1 * 256 + b2) * 256 + b3) * 256 + b4) * 256 + b5) * 256 + b6) * 256 + b7) * 256 + b8
  else
    return (((((((b1 - 255) * 256 + (b2 - 255)) * 256 + (b3 - 255)) * 256 + (b4 - 255)) * 256 + (b5 - 255)) * 256 + (b6 - 255)) * 256 + (b7 - 255)) * 256 + (b8 - 255) - 1
  end
end

function unpackers.fixstr(c, val)
  local s, i, j = c.s, c.i, c.j
  local n = val % 32
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
  local n = s:sub(i, i):byte()
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
  local b1, b2 = s:sub(i, i + 1):byte(1, 2)
  i = i + 2
  c.i = i
  local n = b1 * 256 + b2
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
  local b1, b2, b3, b4 = s:sub(i, i + 3):byte(1, 4)
  i = i + 4
  c.i = i
  local n = ((b1 * 256 + b2) * 256 + b3) * 256 + b4
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
  return unpack_array(c, val % 16)
end

function unpackers.array16(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 1 then
    c:underflow(i + 1)
    s, i, j = c.s, c.i, c.j
  end
  local b1, b2 = s:sub(i, i + 1):byte(1, 2)
  c.i = i + 2
  return unpack_array(c, b1 * 256 + b2)
end

function unpackers.array32(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 3 then
    c:underflow(i + 3)
    s, i, j = c.s, c.i, c.j
  end
  local b1, b2, b3, b4 = s:sub(i, i + 3):byte(1, 4)
  c.i = i + 4
  return unpack_array(c, ((b1 * 256 + b2) * 256 + b3) * 256 + b4)
end

function unpackers.fixmap(c, val)
  return unpack_map(c, val % 16)
end

function unpackers.map16(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 1 then
    c:underflow(i + 1)
    s, i, j = c.s, c.i, c.j
  end
  local b1, b2 = s:sub(i, i + 1):byte(1, 2)
  c.i = i + 2
  return unpack_map(c, b1 * 256 + b2)
end

function unpackers.map32(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 3 then
    c:underflow(i + 3)
    s, i, j = c.s, c.i, c.j
  end
  local b1, b2, b3, b4 = s:sub(i, i + 3):byte(1, 4)
  c.i = i + 4
  return unpack_map(c, ((b1 * 256 + b2) * 256 + b3) * 256 + b4)
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
    local tag = s:sub(i, i):byte()
    i = i + 1
    c.i = i
    local e = i + n - 1
    if j < e then
      c:underflow(e)
      s, i, j = c.s, c.i, c.j
      e = i + n - 1
    end
    c.i = i + n
    return m.build_ext(tag < 128 and tag or tag - 256, s:sub(i, e))
  end
end

function unpackers.ext8(c)
  local s, i, j = c.s, c.i, c.j
  if i > j then
    c:underflow(i)
    s, i, j = c.s, c.i, c.j
  end
  local n = s:sub(i, i):byte()
  i = i + 1
  c.i = i
  if j < i then
    c:underflow(i)
    s, i, j = c.s, c.i, c.j
  end
  local tag = s:sub(i, i):byte()
  i = i + 1
  c.i = i
  local e = i + n - 1
  if j < e then
    c:underflow(e)
    s, i, j = c.s, c.i, c.j
    e = i + n - 1
  end
  c.i = i + n
  return m.build_ext(tag < 128 and tag or tag - 256, s:sub(i, e))
end

function unpackers.ext16(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 1 then
    c:underflow(i + 1)
    s, i, j = c.s, c.i, c.j
  end
  local b1, b2 = s:sub(i, i + 1):byte(1, 2)
  i = i + 2
  c.i = i
  local n = b1 * 256 + b2
  if j < i then
    c:underflow(i)
    s, i, j = c.s, c.i, c.j
  end
  local tag = s:sub(i, i):byte()
  i = i + 1
  c.i = i
  local e = i + n - 1
  if j < e then
    c:underflow(e)
    s, i, j = c.s, c.i, c.j
    e = i + n - 1
  end
  c.i = i + n
  return m.build_ext(tag < 128 and tag or tag - 256, s:sub(i, e))
end

function unpackers.ext32(c)
  local s, i, j = c.s, c.i, c.j
  if j < i + 3 then
    c:underflow(i + 3)
    s, i, j = c.s, c.i, c.j
  end
  local b1, b2, b3, b4 = s:sub(i, i + 3):byte(1, 4)
  i = i + 4
  c.i = i
  local n = ((b1 * 256 + b2) * 256 + b3) * 256 + b4
  if j < i then
    c:underflow(i)
    s, i, j = c.s, c.i, c.j
  end
  local tag = s:sub(i, i):byte()
  i = i + 1
  c.i = i
  local e = i + n - 1
  if j < e then
    c:underflow(e)
    s, i, j = c.s, c.i, c.j
    e = i + n - 1
  end
  c.i = i + n
  return m.build_ext(tag < 128 and tag or tag - 256, s:sub(i, e))
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
  if type(src) == "string" then
    local cursor = cursor_string(src)
    return function()
      if cursor.i <= cursor.j then
        return cursor.i, unpackers.any(cursor)
      end
    end
  elseif type(src) == "function" then
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
if NUMBER_INTEGRAL then
  packers.double = packers.integer
  packers.float = packers.integer
  set_number("integer")
elseif SIZEOF_NUMBER == 4 then
  packers.double = packers.float
  m.small_lua = true
  set_number("float")
else
  set_number("double")
end
set_array("without_hole")
m._VERSION = "0.3.3"
m._DESCRIPTION = "lua-MessagePack : a pure Lua implementation"
m._COPYRIGHT = "Copyright (c) 2012-2015 Francois Perrad"
return m
