function math.isEmpty(value)
  return value == nil or value == 0
end

function math.clamp(value, min, max)
  if min and value < min then
    value = min
  elseif max and max < value then
    value = max
  end
  return value
end

function math.round(value)
  return math.floor(value + 0.5)
end

function math.integrate(value)
  local v = math.round(value * 10000)
  return math.floor(v / 10000)
end

function math.pow(a, b)
  local result = a
  if 1 < b then
    for i = 1, b - 1 do
      result = result * a
    end
  end
  return result
end

function math.lerp(a, b, lerpVal)
  return 1 <= lerpVal and b or a + (b - a) * lerpVal
end
