local M = {}
local math = require("math")
local os = require("os")
local string = require("string")
local bitsize = 32
local lua_version = tonumber(_VERSION:match("%d%.*%d*"))
local MATRIX_AND = {
  {0, 0},
  {0, 1}
}
local MATRIX_OR = {
  {0, 1},
  {1, 1}
}
local HEXES = "0123456789abcdef"
local math_floor = math.floor
local math_random = math.random
local math_abs = math.abs
local string_sub = string.sub
local to_number = tonumber
local assert = _ENV.assert
local type = _ENV.type

local function BITWISE(x, y, matrix)
  local z = 0
  local pow = 1
  while x > 0 or y > 0 do
    z = z + matrix[x % 2 + 1][y % 2 + 1] * pow
    pow = pow * 2
    x = math_floor(x / 2)
    y = math_floor(y / 2)
  end
  return z
end

local function INT2HEX(x)
  local s, base = "", 16
  local d
  while x > 0 do
    d = x % base + 1
    x = math_floor(x / base)
    s = string_sub(HEXES, d, d) .. s
  end
  while #s < 2 do
    s = "0" .. s
  end
  return s
end

function M.new(hwaddr)
  local bytes = {
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255)
  }
  if hwaddr then
    assert("string" == type(hwaddr), "Expected hex string, got " .. type(hwaddr))
    local i, str = #hwaddr, hwaddr
    hwaddr = ""
    while i > 0 and #hwaddr < 12 do
      local c = str:sub(i, i):lower()
      if HEXES:find(c, 1, true) then
        hwaddr = c .. hwaddr
      end
      i = i - 1
    end
    assert(12 == #hwaddr, "Provided string did not contain at least 12 hex characters, retrieved '" .. hwaddr .. "' from '" .. str .. "'")
    bytes[11] = to_number(hwaddr:sub(1, 2), 16)
    bytes[12] = to_number(hwaddr:sub(3, 4), 16)
    bytes[13] = to_number(hwaddr:sub(5, 6), 16)
    bytes[14] = to_number(hwaddr:sub(7, 8), 16)
    bytes[15] = to_number(hwaddr:sub(9, 10), 16)
    bytes[16] = to_number(hwaddr:sub(11, 12), 16)
  end
  bytes[7] = BITWISE(bytes[7], 15, MATRIX_AND)
  bytes[7] = BITWISE(bytes[7], 64, MATRIX_OR)
  bytes[9] = BITWISE(bytes[7], 63, MATRIX_AND)
  bytes[9] = BITWISE(bytes[7], 128, MATRIX_OR)
  return INT2HEX(bytes[1]) .. INT2HEX(bytes[2]) .. INT2HEX(bytes[3]) .. INT2HEX(bytes[4]) .. "-" .. INT2HEX(bytes[5]) .. INT2HEX(bytes[6]) .. "-" .. INT2HEX(bytes[7]) .. INT2HEX(bytes[8]) .. "-" .. INT2HEX(bytes[9]) .. INT2HEX(bytes[10]) .. "-" .. INT2HEX(bytes[11]) .. INT2HEX(bytes[12]) .. INT2HEX(bytes[13]) .. INT2HEX(bytes[14]) .. INT2HEX(bytes[15]) .. INT2HEX(bytes[16])
end

function M.random_i64()
  local bytes = {
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255),
    math_random(0, 255)
  }
  return INT2HEX(bytes[1]) .. INT2HEX(bytes[2]) .. INT2HEX(bytes[3]) .. INT2HEX(bytes[4]) .. INT2HEX(bytes[5]) .. INT2HEX(bytes[6]) .. INT2HEX(bytes[7]) .. INT2HEX(bytes[8])
end

function M.randomseed(seed)
  seed = math_floor(math_abs(seed))
  if seed >= 2 ^ bitsize then
    seed = seed - math_floor(seed / 2 ^ bitsize) * 2 ^ bitsize
  end
  if lua_version < 5.2 then
    math.randomseed(seed - 2 ^ (bitsize - 1))
  else
    math.randomseed(seed)
  end
  return seed
end

function M.seed()
  if package.loaded.socket and package.loaded.socket.gettime then
    do return M.randomseed end
    return M.randomseed, package.loaded.socket.gettime() * 10000
  else
    do return M.randomseed, os.time() end
    return M.randomseed, os.time()
  end
end

do return setmetatable, M end
return setmetatable, M, {
  __call = function(self, hwaddr)
    do return self.new end
    return self.new, hwaddr
  end
}, function(self, hwaddr)
  do return self.new end
  return self.new, hwaddr
end
