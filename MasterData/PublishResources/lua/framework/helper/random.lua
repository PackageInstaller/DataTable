local math_floor = math.floor

local function normalize(n)
  return n % 2147483648
end

local function bit_and(a, b)
  local r = 0
  local m = 0
  for m = 0, 31 do
    if a % 2 == 1 and b % 2 == 1 then
      r = r + 2 ^ m
    end
    if a % 2 ~= 0 then
      a = a - 1
    end
    if b % 2 ~= 0 then
      b = b - 1
    end
    a = a / 2
    b = b / 2
  end
  return normalize(r)
end

local function bit_or(a, b)
  local r = 0
  local m = 0
  for m = 0, 31 do
    if a % 2 == 1 or b % 2 == 1 then
      r = r + 2 ^ m
    end
    if a % 2 ~= 0 then
      a = a - 1
    end
    if b % 2 ~= 0 then
      b = b - 1
    end
    a = a / 2
    b = b / 2
  end
  return normalize(r)
end

local function bit_xor(a, b)
  local r = 0
  local m = 0
  for m = 0, 31 do
    if a % 2 ~= b % 2 then
      r = r + 2 ^ m
    end
    if a % 2 ~= 0 then
      a = a - 1
    end
    if b % 2 ~= 0 then
      b = b - 1
    end
    a = a / 2
    b = b / 2
  end
  return normalize(r)
end

local function seed()
  return normalize(os.time())
end

mersenne_twister = {}
mersenne_twister.__index = mersenne_twister

function mersenne_twister:randomseed(s)
  s = s or seed()
  s = math.ceil(s)
  self.mt[0] = normalize(s)
  for i = 1, 623 do
    self.mt[i] = normalize(1812433253 * bit_xor(self.mt[i - 1], math_floor(self.mt[i - 1] / 1073741824)) + i)
  end
end

function mersenne_twister:random(a, b)
  local y
  if self.index == 0 then
    for i = 0, 623 do
      y = self.mt[(i + 1) % 624] % 2147483648
      self.mt[i] = bit_xor(self.mt[(i + 397) % 624], math_floor(y / 2))
      if y % 2 ~= 0 then
        self.mt[i] = bit_xor(self.mt[i], 2567483615)
      end
    end
  end
  y = self.mt[self.index]
  y = bit_xor(y, math_floor(y / 2048))
  y = bit_xor(y, bit_and(normalize(y * 128), 2636928640))
  y = bit_xor(y, bit_and(normalize(y * 32768), 4022730752))
  y = bit_xor(y, math_floor(y / 262144))
  self.index = (self.index + 1) % 624
  if not a then
    return y / 4294967295
  elseif not b then
    if a == 0 then
      return y
    else
      return 1 + y % a
    end
  else
    return a + y % (b - a + 1)
  end
end

function mersenne_twister:randomfloat()
  local randomNum = self:random(0, 100)
  local num = randomNum / 100
  return num
end

function mersenne_twister:GetPreciseDecimal(nNum, n)
  if type(nNum) ~= "number" then
    return nNum
  end
  n = n or 0
  n = math.floor(n)
  if n < 0 then
    n = 0
  end
  local nDecimal = 10 ^ n
  local nTemp = math.floor(nNum * nDecimal)
  local nRet = nTemp / nDecimal
  return nRet
end

function twister(s)
  local temp = {}
  setmetatable(temp, mersenne_twister)
  temp.mt = {}
  temp.index = 0
  temp:randomseed(s)
  return temp
end

linear_congruential_generator = {}
linear_congruential_generator.__index = linear_congruential_generator

function linear_congruential_generator:random(a, b)
  local y = (self.a * self.x + self.c) % self.m
  self.x = y
  if not a then
    return y / 65535
  elseif not b then
    if a == 0 then
      return y
    else
      return 1 + y % a
    end
  else
    return a + y % (b - a + 1)
  end
end

function linear_congruential_generator:randomseed(s)
  s = s or seed()
  self.x = normalize(s)
end

function lcg(s, r)
  local temp = {}
  setmetatable(temp, linear_congruential_generator)
  temp.a, temp.c, temp.m = 1103515245, 12345, 65536
  if r then
    if r == "nr" then
      temp.a, temp.c, temp.m = 1664525, 1013904223, 65536
    elseif r == "mvc" then
      temp.a, temp.c, temp.m = 214013, 2531011, 65536
    end
  end
  temp:randomseed(s)
  return temp
end

multiply_with_carry = {}
multiply_with_carry.__index = multiply_with_carry

function multiply_with_carry:random(a, b)
  local m = self.m
  local t = self.a * self.x + self.c
  local y = t % m
  self.x = y
  self.c = math_floor(t / m)
  if not a then
    return y / 65535
  elseif not b then
    if a == 0 then
      return y
    else
      return 1 + y % a
    end
  else
    return a + y % (b - a + 1)
  end
end

function multiply_with_carry:randomseed(s)
  s = s or seed()
  self.c = self.ic
  self.x = normalize(s)
end

function mwc(s, r)
  local temp = {}
  setmetatable(temp, multiply_with_carry)
  temp.a, temp.c, temp.m = 1103515245, 12345, 65536
  if r then
    if r == "nr" then
      temp.a, temp.c, temp.m = 1664525, 1013904223, 65536
    elseif r == "mvc" then
      temp.a, temp.c, temp.m = 214013, 2531011, 65536
    end
  end
  temp.ic = temp.c
  temp:randomseed(s)
  return temp
end
