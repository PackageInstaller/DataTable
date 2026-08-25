local BezierUtils = {}

function BezierUtils.GetCubicPoint(t, startPoint, ctrlPoint, endPoint)
  local u = 1 - t
  local tt = t * t
  local uu = u * u
  local p = startPoint * uu
  p = p + ctrlPoint * 2 * u * t
  p = p + endPoint * tt
  return p
end

function BezierUtils.GetCubicPointsList(startPoint, ctrlPoint, endPoint, segment)
  local pointsList = {}
  for i = 1, segment do
    local t = i / segment
    local p = BezierUtils.GetCubicPoint(t, startPoint, ctrlPoint, endPoint)
    table.insert(pointsList, p)
  end
  return pointsList
end

function BezierUtils.GetQuadPoint(t, startPoint, ctrlPoint0, ctrlPoint1, endPoint)
  local a = 1.0 - t
  local aaa = a * a * a
  local aa = a * a
  local tt = t * t
  local ttt = t * t * t
  local taa3 = aa * t * 3.0
  local tta3 = tt * a * 3.0
  local currPoint = Vector3Pool.Instance:Pop()
  currPoint.x = startPoint.x * aaa + ctrlPoint0.x * taa3 + ctrlPoint1.x * tta3 + endPoint.x * ttt
  currPoint.y = startPoint.y * aaa + ctrlPoint0.y * taa3 + ctrlPoint1.y * tta3 + endPoint.y * ttt
  currPoint.z = startPoint.z * aaa + ctrlPoint0.z * taa3 + ctrlPoint1.z * tta3 + endPoint.z * ttt
  return currPoint
end

function BezierUtils.GetQuadPointsList(startPoint, ctrlPoint0, ctrlPoint1, endPoint, segment, pointsList)
  pointsList = pointsList or {}
  for i = 1, segment do
    local t = i / segment
    local p = BezierUtils.GetQuadPoint(t, startPoint, ctrlPoint0, ctrlPoint1, endPoint)
    pointsList[i] = p
  end
  return pointsList, segment
end

function BezierUtils.GetCubicLength(points, t)
  local n = math.floor(100.0 * t + 0.5)
  if 0 == n then
    return 0
  end
  local h = t / n
  local sum1 = 0
  local sum2 = 0
  local val = 0
  for i = 1, n do
    sum1 = sum1 + BezierUtils.CalculateCubicSpeed(points, val + h * 0.5)
    if i > 1 then
      sum2 = sum2 + BezierUtils.CalculateCubicSpeed(points, val)
    end
    val = val + h
  end
  local result = BezierUtils.CalculateCubicSpeed(points, 0.0) + BezierUtils.CalculateCubicSpeed(points, t)
  result = result + 4.0 * sum1 + 2.0 * sum2
  result = result * h / 6.0
  return result
end

function BezierUtils.GetQuadLength(points, t)
  local n = math.floor(100.0 * t + 0.5)
  if 0 == n then
    return 0
  end
  local h = t / n
  local sum1 = 0
  local sum2 = 0
  local val = 0
  for i = 1, n do
    sum1 = sum1 + BezierUtils.CalculateQuadSpeed(points, val + h * 0.5)
    if i > 1 then
      sum2 = sum2 + BezierUtils.CalculateQuadSpeed(points, val)
    end
    val = val + h
  end
  local result = BezierUtils.CalculateQuadSpeed(points, 0.0) + BezierUtils.CalculateQuadSpeed(points, t)
  result = result + 4.0 * sum1 + 2.0 * sum2
  result = result * h / 6.0
  return result
end

function BezierUtils.CalculateCubicSpeed(points, u)
  local sx = points[2].x - 2.0 * points[1].x + u * 2.0 * (points[1].x + points[3].x - points[2].x)
  local sy = points[2].y - 2.0 * points[1].y + u * 2.0 * (points[1].y + points[3].y - points[2].y)
  local sz = points[2].z - 2.0 * points[1].z + u * 2.0 * (points[1].z + points[3].z - points[2].z)
  do return math.sqrt end
  return math.sqrt, sx * sx + sy * sy + sz * sz, sz * sz
end

function BezierUtils.CalculateQuadSpeed(points, u)
  local sx = BezierUtils.CalculateQuadSpeedValue(points[1].x, points[2].x, points[3].x, points[4].x, u)
  local sy = BezierUtils.CalculateQuadSpeedValue(points[1].y, points[2].y, points[3].y, points[4].y, u)
  local sz = BezierUtils.CalculateQuadSpeedValue(points[1].z, points[2].z, points[3].z, points[4].z, u)
  do return math.sqrt end
  return math.sqrt, sx * sx + sy * sy + sz * sz, sz * sz, points[4].z, u
end

function BezierUtils.CalculateQuadSpeedValue(v1, v2, v3, v4, u)
  local result = 3.0 * (v2 - v1)
  local tmp = u
  result = result + tmp * 6.0 * (v1 + v4 - 2.0 * v2)
  tmp = tmp * u
  result = result + tmp * 3.0 * (v3 - v1 + 3.0 * (v2 - v3))
  return result
end

return BezierUtils
