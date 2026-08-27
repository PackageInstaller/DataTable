MathUtil = {}
local bezierPool = CommonPool.New(function()
  return {}
end, function(p)
  while 0 < #p do
    table.remove(p)
  end
  return true
end)

function MathUtil.BezierN(t, p)
  if #p < 2 then
    return p[1]
  end
  local newp = bezierPool:PoolGet()
  for i = 1, #p - 1 do
    local p0p1 = p[i] * (1 - t) + p[i + 1] * t
    table.insert(newp, p0p1)
  end
  local result = MathUtil.BezierN(t, newp)
  bezierPool:PoolPut(newp)
  return result
end

function MathUtil:GetIntersectWithLineAndPlane(point, direct, planeNormal, planePoint)
  local directNormal = Vector3.Normalize(direct)
  local result = Vector3.Dot(directNormal, planeNormal)
  if result == 0 then
    return nil
  end
  local d = Vector3.Dot(planePoint - point, planeNormal) / result
  return directNormal * d + point
end

local function CrossV2(a, b)
  return a.x * b.y - b.x * a.y
end

function MathUtil:SegmentsInterPointV2(a, b, c, d)
  local ab = b - a
  local ac = c - a
  local ad = d - a
  local abXac = CrossV2(ab, ac)
  local abXad = CrossV2(ab, ad)
  if 0 <= abXac * abXad then
    return false
  end
  local cd = d - c
  local ca = a - c
  local cb = b - c
  local cdXca = CrossV2(cd, ca)
  local cdXcb = CrossV2(cd, cb)
  if 0 <= cdXca * cdXcb then
    return false
  end
  local t = CrossV2(ca, cd) / CrossV2(cd, b - a)
  local dx = t * (b.x - a.x)
  local dy = t * (b.y - a.y)
  local IntrPos = Vector2.New(a.x + dx, a.y + dy)
  return true, IntrPos
end
