local floor = math.floor
local pow = math.pow
_G.MAX_INT_32 = 2147483647
lmathext = {}
lmathext.deg2rad = math.pi / 180
lmathext.rad2deg = 180 / math.pi
lmathext.epsilon = 1.401298E-45

function lmathext.round(num)
  return floor(num + 0.5)
end

function lmathext.round_with_precision(what, precision)
  return floor(what * pow(10, precision) + 0.5) / pow(10, precision)
end

function lmathext.sign(num)
  if 0 < num then
    return 1
  elseif num < 0 then
    return -1
  else
    return 0
  end
end

function lmathext.isnan(number)
  return number ~= number
end

function lmathext.clamp(num, min, max)
  if num < min then
    num = min
  elseif max < num then
    num = max
  end
  return num
end

local clamp = lmathext.clamp

function lmathext.lerp(from, to, t)
  return from + (to - from) * clamp(t, 0, 1)
end

function lmathext.RandomRange(n, m)
  local range = m - n
  return math.random() * range + n
end

function lmathext.Approximately(a, b)
  return abs(b - a) < math.max(1.0E-6 * math.max(abs(a), abs(b)), 1.121039E-44)
end
