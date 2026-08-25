local MathUtils = System.NewClass("MathUtils")

function MathUtils.CalcSignedAngle(angle, dir)
  if dir >= 0 then
    do return MathUtils.RoundAngle360 end
    return MathUtils.RoundAngle360, angle
  end
  return MathUtils.RoundAngle360(angle) - 360
end

function MathUtils.RoundAngle(angle)
  local ret = angle % 360
  if ret < 0 then
    ret = ret + 360
  end
  if ret > 180 then
    ret = ret - 360
  end
  return ret
end

function MathUtils.RoundAngle360(angle)
  local ret = angle % 360
  if ret < 0 then
    ret = ret + 360
  end
  return ret
end

function MathUtils.ComputeK(p1, p2)
  return p1.x ~= p2.x and (p2.y - p1.y) / (p2.x - p1.x) or p2.y > p1.y and math.huge or -math.huge
end

function MathUtils.Clamp(value, min, max)
  if value < min then
    return min
  elseif max < value then
    return max
  end
  return value
end

function MathUtils.GetIntPart(num)
  local ret = math.ceil(num)
  if ret > 0 and ret ~= num then
    ret = ret - 1
  end
  return ret
end

function MathUtils.Distance(x1, y1, x2, y2)
  do return math.sqrt end
  return math.sqrt, (x2 - x1) ^ 2 + (y2 - y1) ^ 2, (y2 - y1) ^ 2
end

function MathUtils.Distance3(x1, x2, y1, y2, z1, z2)
  do return math.sqrt end
  return math.sqrt, (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1) + (z2 - z1) * (z2 - z1), (z2 - z1) * (z2 - z1), z2 - z1
end

function MathUtils.Distance3Sqr(x1, x2, y1, y2, z1, z2)
  return (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1) + (z2 - z1) * (z2 - z1)
end

function MathUtils.DistancePoint3(point1, point2)
  local p1, p2 = point1, point2
  do return math.sqrt end
  return math.sqrt, (p1.x - p2.x) ^ 2 + (p1.y - p2.y) ^ 2 + (p1.z - p2.z) ^ 2, (p1.z - p2.z) ^ 2, p2.z
end

function MathUtils.DistancePoint3Square(point1, point2)
  local p1, p2 = point1, point2
  return (p1.x - p2.x) ^ 2 + (p1.y - p2.y) ^ 2 + (p1.z - p2.z) ^ 2
end

function MathUtils.Vector2DistanceSqr(p1, p2)
  return (p1.x - p2.x) ^ 2 + (p1.y - p2.y) ^ 2
end

function MathUtils.PolyHitTest(vertCount, vertsX, vertsY, testX, testY)
  table.sort(vertsX, function(a, b)
    return a < b
  end)
  table.sort(vertsY, function(a, b)
    return a < b
  end)
  if testX < vertsX[1] or testX > vertsX[vertCount] or testY < vertsY[1] or testY > vertsY[vertCount] then
    return false
  end
  local ret = false
  for i = 1, vertCount do
    for j = vertCount, 1, -1 do
      if testY < vertsY[i] ~= (testY < vertsY[j]) and testX < (vertsX[j] - vertsX[i]) * (testY - vertsY[i]) / (vertsY[j] - vertsY[i]) + vertsX[i] then
        ret = not ret
      end
    end
  end
  return ret
end

function MathUtils.GetAngleByPos(p1, p2)
  local dX = p2.x - p1.x
  local dY = p2.y - p1.y
  local r = math.atan(dY, dX) * 180 / math.pi
  return r
end

function MathUtils.GetPloyCenterPoint(points)
  local function getMiniXY()
    local minX = points[1] and points[1].x or 0
    
    local minY = points[1] and points[1].y or 0
    for _, point in ipairs(points) do
      if minX > point.x then
        minX = point.x
      end
      if minY > point.y then
        minY = point.y
      end
    end
    return minX, minY
  end
  
  local function getMaxXY()
    local maxX = points[1] and points[1].x or 0
    local maxY = points[1] and points[1].y or 0
    for _, point in ipairs(points) do
      if maxX < point.x then
        maxX = point.x
      end
      if maxY < point.y then
        maxY = point.y
      end
    end
    return maxX, maxY
  end
  
  local minX, minY = getMiniXY()
  local maxX, maxY = getMaxXY()
  return {
    x = (minX + maxX) / 2,
    y = (minY + maxY) / 2
  }
end

function MathUtils.Round(num, decimals)
  if not decimals or 0 == decimals then
    do return math.floor end
    return math.floor, num + 0.5, nil
  end
  local factor = 10 ^ decimals
  return math.floor(num * factor + 0.5) / factor
end

function MathUtils.GetTargetRandomNumbers(list, targetNum)
  if not list then
    return nil
  end
  if type(list) ~= "table" then
    return nil
  end
  local numbers = {}
  for i, v in ipairs(list) do
    if type(v) == "number" then
      table.insert(numbers, v)
    end
  end
  if 0 == #numbers then
    return nil
  end
  if targetNum > #numbers then
    return numbers
  end
  local result = {}
  local usedIndices = {}
  math.randomseed(os.time())
  while targetNum > #result do
    local randomIndex = math.random(1, #numbers)
    if not usedIndices[randomIndex] then
      table.insert(result, numbers[randomIndex])
      usedIndices[randomIndex] = true
    end
  end
  return result
end

return MathUtils
