GridHelper = {}
local GridSize = 0.25
local MAXNUMBER = 99999999
local FloatRate = 10000
GridHelper.SIZE = GridSize
GridHelper.PICKUPHEIGHT = 0.1
local Min = math.min
local Max = math.max
local Abs = math.abs

local function Cos(angle)
  return math.cos(math.rad(angle))
end

local function Sin(angle)
  return math.sin(math.rad(angle))
end

local Dot = Vector2.Dot
local Floor = math.floor

local function Round(f)
  return Floor(f + 0.5)
end

local function FixFloat(f)
  local ff = Floor(f + 0.5)
  if Abs(ff - f) < 1.0E-6 then
    return ff, true
  else
    return f, false
  end
end

local furnitureSeq = 0
local edges = {
  {
    ori = Vector2(-1, 1),
    dir = Vector2(1, 0)
  },
  {
    ori = Vector2(1, 1),
    dir = Vector2(0, -1)
  },
  {
    ori = Vector2(1, -1),
    dir = Vector2(-1, 0)
  },
  {
    ori = Vector2(-1, -1),
    dir = Vector2(0, 1)
  }
}

local function calBound(points)
  local xMin, yMin = MAXNUMBER, MAXNUMBER
  local xMax, yMax = -MAXNUMBER, -MAXNUMBER
  for _, p in ipairs(points) do
    xMin = Min(p.x, xMin)
    xMax = Max(p.x, xMax)
    yMin = Min(p.y, yMin)
    yMax = Max(p.y, yMax)
  end
  xMin = Floor(xMin)
  xMax = Floor(xMax)
  yMin = Floor(yMin)
  yMax = Floor(yMax)
  return xMin, xMax, yMin, yMax
end

local function isValidPos(sur, pos, layer)
  local tiles = sur:Tiles()
  if tiles[pos.x] then
    local tile = tiles[pos.x][pos.y]
    if tile then
      return not tile:Occupied(layer)
    end
  end
  return false
end

local function occupyGridsOBB(fur, gridPos, rotY)
  local cos = FixFloat(Cos(rotY))
  local sin = FixFloat(Sin(rotY))
  local xAxis = Vector2(cos, -sin)
  local yAxis = Vector2(sin, cos)
  local size = fur:Size()
  local origin = gridPos + xAxis * fur:Offset().x + yAxis * fur:Offset().y
  origin.x = FixFloat(origin.x)
  origin.y = FixFloat(origin.y)
  local leftTop = origin + yAxis * size.y
  local rightTop = leftTop + xAxis * size.x
  local rightBottom = origin + xAxis * size.x
  local points = {
    origin,
    leftTop,
    rightTop,
    rightBottom
  }
  local furOBB = OBB:New(points, xAxis, yAxis, fur:Size())
  local xMin, xMax, yMin, yMax = calBound(points)
  local grids = {}
  for w = xMin, xMax do
    for h = yMin, yMax do
      local cross = false
      local ps = {
        Vector2(w, h),
        Vector2(w, h + 1),
        Vector2(w + 1, h + 1),
        Vector2(w + 1, h)
      }
      local obb = OBB:New(ps, Vector2(1, 0), Vector2(0, 1), Vector2(1, 1))
      if furOBB:Intersect(obb) and obb:Intersect(furOBB) then
        grids[#grids + 1] = Vector2(w + 1, h + 1)
      end
    end
  end
  return grids
end

function GridHelper.FurnitureOccupyGrids(fur, gridPos, rotY)
  return occupyGridsOBB(fur, gridPos, rotY)
end

function GridHelper.GetFurniturePosRot(sur, gridPos, rotY)
  local pos = sur:WorldPosition()
  pos = pos + sur:Right() * (gridPos.x * GridSize) + sur:Forward() * (gridPos.y * GridSize)
  local rot = sur:WorldRotation()
  rot = rot * Quaternion.Euler(0, rotY, 0)
  return pos, rot
end

function GridHelper.GetGridsWorldPos(sur, grids)
  local right = sur:Right()
  local forward = sur:Forward()
  local worldPos = sur:WorldPosition()
  local ps = {}
  for i, pos in ipairs(grids) do
    ps[i] = worldPos + right * (pos.x - 1) * GridSize + forward * (pos.y - 1) * GridSize
  end
  return ps, sur:WorldRotation()
end

function GridHelper.CanFurniturPlaceAt(sur, fur, gridPos, rotY)
  local grids = GridHelper.FurnitureOccupyGrids(fur, gridPos, rotY)
  local w = sur:Width()
  local h = sur:Height()
  local layer = fur:Layer()
  for _, pos in ipairs(grids) do
    local valid = isValidPos(sur, pos, layer)
    if not valid then
      return false, grids
    end
  end
  return true, grids
end

function GridHelper.BeyondSurfaceEdge(sur, fur, gridPos, rotY)
  local grids = GridHelper.FurnitureOccupyGrids(fur, gridPos, rotY)
  local tiles = sur:Tiles()
  local w = sur:Width()
  local h = sur:Height()
  local layer = fur:Layer()
  local valid = true
  for _, pos in ipairs(grids) do
    if pos.x < 0 or w < pos.x or 0 > pos.y or h < pos.y then
      return true
    end
    if tiles[pos.x] == nil or tiles[pos.x][pos.y] == nil then
      return true
    end
    if not isValidPos(sur, pos, layer) and valid then
      valid = false
    end
  end
  return false, valid, grids
end

function GridHelper.FindLocationOn(furID, sur)
  local cfg = Cfg.cfg_item_furniture[furID]
  local locate = cfg.LocateType
  if locate ~= sur:GridType() then
    return false
  end
  local size = Vector2(cfg.Size[1], cfg.Size[2])
  local furLayer = cfg.Layer
  local tiles = sur:Tiles()
  local xMin, xMax = MAXNUMBER, -MAXNUMBER
  local yMin, yMax = MAXNUMBER, -MAXNUMBER
  for x, ts in pairs(tiles) do
    for y, _ in pairs(ts) do
      xMin = Min(xMin, x)
      xMax = Max(xMax, x)
      yMin = Min(yMin, y)
      yMax = Max(yMax, y)
    end
  end
  local centerX = Floor((xMin + xMax) / 2)
  local centerY = Floor((yMin + yMax) / 2)
  local layer = Max(Max(centerX - xMin, xMax - centerX), Max(centerY - yMin, yMax - centerY))
  
  local function check(x, y)
    if tiles[x] == nil then
      return false
    end
    local t = tiles[x][y]
    if t == null then
      return false
    end
    for k = 0, size.x - 1 do
      for p = 0, size.y - 1 do
        local line = tiles[x + k]
        if line == nil then
          return false
        end
        local t = line[y + p]
        if t == nil then
          return false
        end
        if t:Occupied(furLayer) then
          return false
        end
      end
    end
    return true
  end
  
  if check(centerX, centerY) then
    return true, Vector2(centerX - 1, centerY - 1)
  end
  local center = Vector2(centerX, centerY)
  for l = 1, layer do
    for e = 1, 4 do
      local ori = center + edges[e].ori * l
      local dir = edges[e].dir
      for c = 0, l do
        local cur = ori + dir * c
        if check(cur.x, cur.y) then
          check(cur.x, cur.y)
          return true, Vector2(cur.x - 1, cur.y - 1)
        end
      end
    end
  end
  return false
end

function GridHelper.ToInt(f)
  local t = f * FloatRate
  local result, fixed = FixFloat(t)
  if fixed then
    return result
  else
    return Floor(t)
  end
end

function GridHelper.ToFloat(i)
  return i / FloatRate
end

function GridHelper.CreateFurnitureInstanceID()
  furnitureSeq = furnitureSeq + 1
  return furnitureSeq
end

function GridHelper.LocalPos2GridPos(pos)
  local x = pos.x / GridSize
  local y = pos.z / GridSize
  x = Floor(FixFloat(x))
  y = Floor(FixFloat(y))
  return Vector2(x, y)
end

function GridHelper.Test(n)
  local m = AircraftRandomActionManager:New()
  local r = {}
  for i = 1, n do
    local a = m:_findRandomAction22222(10001)
    if r[a.index] == nil then
      r[a.index] = {count = 0, info = a}
    end
    r[a.index].count = r[a.index].count + 1
  end
  for idx, re in pairs(r) do
    Log.fatal("索引：", idx, "，类型：", re.info.type, "，区域：", re.info.area, "，理论权重：", re.info.weight, "，家具：", re.info.fur, "，实际次数：", re.count, "，实际概率：", re.count / n)
  end
end

_class("OBB", Object)
OBB = OBB

function OBB:Constructor(points, xAxis, yAxis, size)
  self._points = points
  self._size = size
  self._axisX = xAxis
  self._axisY = yAxis
  local leftBottom = points[1]
  local rightTop = points[3]
  self._xProjMin = Dot(leftBottom, self._axisX)
  self._xProjMax = Dot(rightTop, self._axisX)
  self._yProjMin = Dot(leftBottom, self._axisY)
  self._yProjMax = Dot(rightTop, self._axisY)
end

function OBB:Points()
  return self._points
end

function OBB:Intersect(other)
  local xMin, xMax = MAXNUMBER, -MAXNUMBER
  local yMin, yMax = MAXNUMBER, -MAXNUMBER
  for _, point in ipairs(other:Points()) do
    local x = Dot(point, self._axisX)
    local y = Dot(point, self._axisY)
    xMin = Min(xMin, x)
    xMax = Max(xMax, x)
    yMin = Min(yMin, y)
    yMax = Max(yMax, y)
  end
  if xMin >= self._xProjMax or xMax <= self._xProjMin then
    return false
  end
  if yMin >= self._yProjMax or yMax <= self._yProjMin then
    return false
  end
  return true
end
