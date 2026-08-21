BuildHelper = {}
local MAX = 99999999
local MIN = -MAX
local EPSINON = 1.0E-5
local ThresholdPoint = 0.2
local ThresholdSide = 0.5
local buidingIntanceID = 0
BuildHelper.RATE = 4
local min = math.min
local max = math.max
local abs = math.abs
local dot = Vector2.Dot
local floor = math.floor

local function equal(x, y)
  return abs(x - y) < EPSINON
end

local function round(f)
  return floor(f + 0.5)
end

local function fix(f)
  local ff = round(f)
  if equal(ff, f) then
    return ff, true
  else
    return f, false
  end
end

local function cos(angle)
  angle = fix(angle)
  if angle == 0 then
    return 1
  elseif angle == 90 or angle == 270 then
    return 0
  elseif angle == 180 then
    return -1
  else
    return math.cos(math.rad(angle))
  end
end

local function sin(angle)
  angle = fix(angle)
  if angle == 0 or angle == 180 then
    return 0
  elseif angle == 90 then
    return 1
  elseif angle == 270 then
    return -1
  else
    return math.sin(math.rad(angle))
  end
end

function BuildHelper.ToInt(value)
  return floor(fix(value / EPSINON))
end

function BuildHelper.ToFloat(value)
  return value * EPSINON
end

function BuildHelper.Equal(a, b)
  return equal(a, b)
end

function BuildHelper.GetColliderPoints(collider, pos, rotY)
  local size = collider.size
  size = Vector2(size.x, size.z)
  local center = collider.center
  center = Vector2(center.x, center.z)
  if rotY ~= 0 and (center.x ~= 0 or center.y ~= 0) then
    local sinrot = fix(sin(-rotY))
    local cosrot = fix(cos(-rotY))
    local newX = center.x * cosrot - center.y * sinrot
    local newY = center.y * cosrot + center.x * sinrot
    center.x = newX
    center.y = newY
  end
  pos = Vector2(pos.x, pos.z)
  local cos = fix(cos(rotY))
  local sin = fix(sin(rotY))
  local xAxis = Vector2(cos, -sin)
  local yAxis = Vector2(sin, cos)
  local origin = pos + center - xAxis * (size.x / 2) - yAxis * (size.y / 2)
  origin.x = fix(origin.x)
  origin.y = fix(origin.y)
  local leftTop = origin + yAxis * size.y
  local rightTop = leftTop + xAxis * size.x
  local rightBottom = origin + xAxis * size.x
  return origin, leftTop, rightTop, rightBottom
end

function BuildHelper.GetOverlapColliders(colliders, parent, layer)
  local pos = parent.position
  local rot = parent.rotation
  local overlaps = {}
  for i, collider in ipairs(colliders) do
    local degY = -parent.eulerAngles.y
    local x = collider.center.x
    local z = collider.center.z
    local center
    if degY ~= 0 and (x ~= 0 or z ~= 0) then
      local sinrot = fix(sin(degY))
      local cosrot = fix(cos(degY))
      local rotX = x * cosrot - z * sinrot
      local rotZ = z * cosrot + x * sinrot
      local rotCenter = Vector3(rotX, collider.center.y, rotZ)
      center = pos + rotCenter
    else
      center = pos + collider.center
    end
    local size = collider.size / 2 - Vector3.one * EPSINON * BuildHelper.RATE
    local targets = UnityEngine.Physics.OverlapBox(center, size, rot, 1 << layer)
    if targets and 0 < targets.Length then
      for i = 1, targets.Length do
        local target = targets[i - 1]
        local isSelf = false
        for _, coll in ipairs(colliders) do
          if coll == target then
            isSelf = true
            break
          end
        end
        if not isSelf and not overlaps[target] then
          overlaps[target] = true
        end
      end
    end
  end
  return overlaps
end

function BuildHelper.CreateBuilding(architecture)
  buidingIntanceID = buidingIntanceID + 1
  local cfg = Cfg.cfg_item_architecture[architecture.asset_id]
  if not cfg then
    BuildError("cfg_item_architecture找不到建筑，无法创建:", architecture.asset_id)
  end
  if cfg.SubType == ArchitectureSubType.Land then
    return HomelandBreedLand:New(buidingIntanceID, architecture, cfg)
  elseif cfg.SubType == ArchitectureSubType.FishTank then
    return HomelandAquarium:New(buidingIntanceID, architecture, cfg)
  elseif Cfg.cfg_homeland_swimming_pool[architecture.asset_id] then
    return HomelandSwimmingPool:New(buidingIntanceID, architecture, cfg)
  elseif cfg.SubType == ArchitectureSubType.Father_Architecture then
    return HomeBuildingFather:New(buidingIntanceID, architecture, cfg)
  elseif cfg.SubType == ArchitectureSubType.Medal_Wall then
    return HomelandMedalWall:New(buidingIntanceID, architecture, cfg)
  else
    return HomeBuilding:New(buidingIntanceID, architecture, cfg)
  end
end

_class("BuildRect", Object)
BuildRect = BuildRect

function BuildRect:Constructor(pos, size, rot)
  self._pos = pos
  self._size = size
  self._rot = rot
  local cos = fix(cos(rot))
  local sin = fix(sin(rot))
  self._xAxis = Vector2(cos, -sin)
  self._yAxis = Vector2(sin, cos)
  self._aabb = BuildAABB:New()
  self._obb = nil
  self:onChange()
end

function BuildRect:ChangePos(pos)
  self._pos = pos
  self:onChange()
end

function BuildRect:ChangeRot(rot)
  self._rot = rot
  local cos = fix(cos(rot))
  local sin = fix(sin(rot))
  self._xAxis = Vector2(cos, -sin)
  self._yAxis = Vector2(sin, cos)
  self:onChange()
end

function BuildRect:onChange()
  local halfWidth = self._size.x / 2
  local halfHeight = self._size.y / 2
  local lb = self._pos - self._xAxis * halfWidth - self._yAxis * halfHeight
  local lt = self._pos - self._xAxis * halfWidth + self._yAxis * halfHeight
  local rt = self._pos + self._xAxis * halfWidth + self._yAxis * halfHeight
  local rb = self._pos + self._xAxis * halfWidth - self._yAxis * halfHeight
  local points = {
    lb,
    lt,
    rt,
    rb
  }
  self._aabb:OnChange(points)
  self._obb = OBB:New(points, self._xAxis, self._yAxis, self._rot)
  self._points = points
end

function BuildRect:GetAABB()
  return self._aabb
end

function BuildRect:GetOBB()
  return self._obb
end

function BuildRect:Overlap(other)
  if not self._aabb:Overlap(other:GetAABB()) then
    return false
  end
  local obb = other:GetOBB()
  if self._obb:Intersect(obb) and obb:Intersect(self._obb) then
    return true
  end
  return false
end

function BuildRect:ContainedBy(poly)
  for _, point in ipairs(self._points) do
    if not poly:Contains(point) then
      return false
    end
  end
  return true
end

_class("BuildAABB", Object)
BuildAABB = BuildAABB

function BuildAABB:Constructor()
end

function BuildAABB:OnChange(points)
  local xMin, xMax = MAX, MIN
  local yMin, yMax = MAX, MIN
  for _, p in ipairs(points) do
    xMin = min(p.x, xMin)
    xMax = max(p.x, xMax)
    yMin = min(p.y, yMin)
    yMax = max(p.y, yMax)
  end
  self._xMin = xMin
  self._xMax = xMax
  self._yMin = yMin
  self._yMax = yMax
  self._diagonalLength = math.sqrt((self._xMax - self._xMin) ^ 2 + (self._yMax - self._yMin) ^ 2)
end

function BuildAABB:Overlap(other)
  if other._xMin < self._xMax and other._xMin > self._xMin and other._yMin < self._yMax and other._yMin > self._yMin then
    return true
  end
  if self._xMin < other._xMax and self._xMin > other._xMin and self._yMin < other._yMax and self._yMin > other._yMin then
    return true
  end
  return false
end

function BuildAABB:DiagonalLength()
  return self._diagonalLength
end

_class("BuildPoly", Object)
BuildPoly = BuildPoly

function BuildPoly:Constructor(points)
  if not equal(points[1].x, points[#points].x) or not equal(points[1].y, points[#points].y) then
    BuildError("多边形没有闭合")
  end
  local segments = {}
  for i = 1, #points - 1 do
    segments[#segments + 1] = {
      P1 = points[i],
      P2 = points[i + 1]
    }
  end
  self._segments = segments
  self._points = points
end

function BuildPoly:Contains(point)
  local y = point.y
  local x = point.x
  local left, right = 0, 0
  for _, segment in ipairs(self._segments) do
    local p1 = segment.P1
    local p2 = segment.P2
    if equal(p1.x, p2.x) then
      local yMin = min(p1.y, p2.y)
      local yMax = max(p1.y, p2.y)
      if y > yMin and y < yMax then
        if equal(p1.x, x) then
          return true
        elseif x > p1.x then
          left = left + 1
        else
          right = right + 1
        end
      end
    else
      local a = (p2.y - p1.y) / (p2.x - p1.x)
      local b = p1.y - a * p1.x
      local xt = (y - b) / a
      local xMin = min(p1.x, p2.x)
      local xMax = max(p1.x, p2.x)
      if xt >= xMin and xt <= xMax then
        if equal(x, xt) then
          return true
        elseif x > xt then
          left = left + 1
        else
          right = right + 1
        end
      end
    end
  end
  if left % 2 == 1 and right % 2 == 1 then
    return true
  end
  return false
end

_class("BuildRectSide", Object)
BuildRectSide = BuildRectSide

function BuildRectSide:Constructor(p1, p2, angle)
  self:Reset(p1, p2, angle)
end

function BuildRectSide:Reset(p1, p2, angle)
  self.Start = p1
  self.End = p2
  self.Angle = angle
end

function BuildRectSide:CheckAdsorbGrid(space)
  if self.Angle % 90 ~= 0 then
    return
  end
  if equal(self.Start.x, self.End.x) then
    local x = self.Start.x
    local step = x % space
  else
    if equal(self.Start.y, self.End.y) then
    else
    end
  end
end

function BuildRectSide:CheckAdsorb(other)
  local result = BuildAdsorbType.None
  if (self.Angle - other.Angle) % 180 ~= 0 then
    return result, nil
  end
  local pointDelta, sideDelta
  local psqr = ThresholdPoint ^ 2
  if psqr >= (self.Start - other.Start):SqrMagnitude() then
    result = result | BuildAdsorbType.Start2Start
    pointDelta = other.Start - self.Start
  elseif psqr >= (self.Start - other.End):SqrMagnitude() then
    result = result | BuildAdsorbType.Start2End
    pointDelta = other.End - self.Start
  elseif psqr >= (self.End - other.End):SqrMagnitude() then
    result = result | BuildAdsorbType.End2End
    pointDelta = other.End - self.End
  elseif psqr >= (self.End - other.Start):SqrMagnitude() then
    result = result | BuildAdsorbType.End2Start
    pointDelta = other.Start - self.End
  end
  if pointDelta then
    return result, pointDelta
  end
  local x1Min, x1Max = min(self.Start.x, self.End.x), max(self.Start.x, self.End.x)
  local y1Min, y1Max = min(self.Start.y, self.End.y), max(self.Start.y, self.End.y)
  local x2Min, x2Max = min(other.Start.x, other.End.x), max(other.Start.x, other.End.x)
  local y2Min, y2Max = min(other.Start.y, other.End.y), max(other.Start.y, other.End.y)
  if x1Min <= x2Min and x1Max >= x2Min or x1Min <= x2Max and x1Max >= x2Max or y1Min <= y2Min and y1Max >= y2Min or y1Min <= y2Max and y1Max >= y2Max then
    if equal(self.Start.x, self.End.x) then
      local d = other.Start.x - self.Start.x
      if abs(d) < ThresholdSide then
        result = result | BuildAdsorbType.Side
        sideDelta = Vector2(d, 0)
      end
    else
      local k = (self.End.y - self.Start.y) / (self.End.x - self.Start.x)
      local b = self.Start.y - k * self.Start.x
      local A = k
      local B = -1
      local C1 = self.Start.y - k * self.Start.x
      local C2 = other.Start.y - k * other.Start.x
      local d = (C2 - C1) / math.sqrt(A * A + B * B)
      if abs(d) < ThresholdSide then
        result = result | BuildAdsorbType.Side
        local dir = self.End - self.Start
        local tmp = other.Start - self.Start
        local cross = dir.x * tmp.y - dir.y * tmp.x
        if equal(cross, 0) then
          sideDelta = Vector2(0, 0)
        elseif 0 < cross then
          sideDelta = Vector2(0, 0)
        else
          sideDelta = Vector2(0, 0)
        end
      end
    end
  end
  return result, sideDelta
end

function BuildLog(...)
  Log.debug("[Build] ", ...)
end

function BuildError(...)
  if EDITOR then
    Log.exception(...)
  else
    Log.fatal("[Build] ", ...)
  end
end
