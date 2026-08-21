_class("AircraftPointHolder", Object)
AircraftPointHolder = AircraftPointHolder

function AircraftPointHolder:Constructor(parent, floor, name)
  self._parent = parent
  if parent == nil then
    Log.fatal("父节点为空:", name)
    return
  end
  self._name = name
  self._count = parent.childCount
  self._point = {}
  self._available = self._count
  self._floor = floor
  if self._count == 0 then
    return
  end
  for i = 1, self._count do
    local child = parent:GetChild(i - 1)
    self._point[i] = AircraftPosPoint:New(i, child.position)
  end
end

function AircraftPointHolder:Floor()
  return self._floor
end

function AircraftPointHolder:PopPoint()
  if self._available <= 0 then
    Log.fatal("[AircraftPoint] no point, floor:", self._floor)
    return
  end
  local target = math.random(1, self._available)
  local i = 1
  for idx, point in ipairs(self._point) do
    if not self._point[idx]:IsOccupied() then
      if i == target then
        self._available = self._available - 1
        self._point[idx]:Occupy(true)
        return self._point[idx]
      end
      i = i + 1
    end
  end
end

function AircraftPointHolder:OccupyPoint(index)
  if self._available <= 0 then
    Log.fatal("[AircraftPoint] no point, floor:", self._floor)
    return
  end
  if not self._point[index]:IsOccupied() then
    self._available = self._available - 1
    self._point[index]:Occupy(true)
    return self._point[index]
  end
  return
end

function AircraftPointHolder:HasAvailablePoint()
  return self._available > 0
end

function AircraftPointHolder:ReleasePoint(point)
  if not point:IsOccupied() then
    AirLog("该点未被占据：", self._name, "，", point:Index())
    return
  end
  point:Occupy(false)
  self._available = self._available + 1
end

function AircraftPointHolder:ReleaseAll()
  if self._point then
    self._available = self._count
    for idx, point in ipairs(self._point) do
      if point:IsOccupied() then
        point:Occupy(false)
      end
    end
  end
end

_class("AircraftPosPoint", Object)
AircraftPosPoint = AircraftPosPoint

function AircraftPosPoint:Constructor(idx, pos)
  self._index = idx
  self._pos = pos:Clone()
  self._occupied = false
end

function AircraftPosPoint:Index()
  return self._index
end

function AircraftPosPoint:Pos()
  return self._pos
end

function AircraftPosPoint:IsOccupied()
  return self._occupied
end

function AircraftPosPoint:Occupy(occupy)
  self._occupied = occupy
end
