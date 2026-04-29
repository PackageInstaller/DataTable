_class("OvalShape", Object)
OvalShape = OvalShape
local EPSINON = 1.0E-5
local abs = math.abs
local sqrt = math.sqrt

local function equal(a, b)
  return abs(a - b) < EPSINON
end

function OvalShape:Constructor(a, b)
  if a < b or a < 0 or b < 0 then
    Log.exception("椭圆参数错误:", a, b)
  end
  Log.info("初始化椭圆:", a, b)
  self._a = a
  self._b = b
  self._aa = a * a
  self._bb = b * b
  self._longAxis = 2 * a
  local focusX = sqrt(a * a - b * b)
  self._focus1 = Vector2(-focusX, 0)
  self._focus2 = Vector2(focusX, 0)
end

function OvalShape:IsInside(point)
  if point.x <= -self._a or point.x >= self._a then
    return false
  elseif point.y <= -self._b or point.y >= self._b then
    return false
  end
  local distance = Vector2.Distance(point, self._focus1) + Vector2.Distance(point, self._focus2)
  return distance < self._longAxis
end

function OvalShape:CrossPoint(target)
  if equal(target.x, 0) then
    if 0 < target.y then
      return Vector2(0, self._b)
    else
      return Vector2(0, -self._b)
    end
  else
    local k = target.y / target.x
    local b = 0
    local x = sqrt(self._aa * self._bb / (self._bb + k * k * self._aa))
    if target.x < 0 then
      x = -x
    end
    local y = k * x
    return Vector2(x, y)
  end
end
