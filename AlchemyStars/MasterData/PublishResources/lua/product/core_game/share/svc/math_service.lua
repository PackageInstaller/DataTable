require("random")
_class("MathService", BaseService)
MathService = MathService

function MathService:Constructor(world)
end

function MathService:ClampValue(value, min, max)
  if value < min then
    value = min
  elseif max < value then
    value = max
  end
  return value
end

function MathService:Rounding(value)
  local f = math.floor(value)
  if f == value then
    return f
  else
    return math.floor(value + 0.5)
  end
end

function MathService:LerpGetY(v0, v1, x)
  local x0 = v0.x
  local y0 = v0.y
  local x1 = v1.x
  local y1 = v1.y
  return y0 + (y1 - y0) / (x1 - x0) * (x - x0)
end

function MathService:LerpGetX(v0, v1, y)
  return self:LerpGetY(Vector2.New(v0.y, v0.x), Vector2.New(v1.y, v1.x), y)
end
