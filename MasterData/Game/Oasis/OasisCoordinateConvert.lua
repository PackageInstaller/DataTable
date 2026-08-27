local OasisCoordinateConvert = {}
local hexSize = ConfigData.game_config.OasisHexSize
local sqrt3 = math.sqrt(3)
local hexHeight = hexSize * 2
local hexWidth = hexSize * sqrt3
local size3Offset, size4Offset

local function Init()
  size3Offset = OasisCoordinateConvert.ToUnity((Vector2.New(0, 1) + Vector2.New(1, 0)) / 3)
  size4Offset = OasisCoordinateConvert.ToUnity(Vector2.New(1, 1) / 2)
end

function OasisCoordinateConvert.ToUnity(vector2)
  local z = -vector2.x - vector2.y
  local position = Vector3.New()
  position.x = hexSize * sqrt3 * (vector2.x + z / 2)
  position.z = hexSize * z * 3 / 2
  return position
end

function OasisCoordinateConvert.ToOasis(vector3)
  local position = Vector2.New()
  position.x = (sqrt3 / 3 * vector3.x - 0.3333333333333333 * vector3.z) / hexSize
  local z = 0.6666666666666666 * vector3.z / hexSize
  position.y = -z - position.x
  local rx = math.floor(position.x + 0.5)
  local ry = math.floor(position.y + 0.5)
  local rz = math.floor(z + 0.5)
  local xDiff = math.abs(rx - position.x)
  local yDiff = math.abs(ry - position.y)
  local zDiff = math.abs(rz - z)
  if xDiff > yDiff and xDiff > zDiff then
    rx = -ry - rz
  elseif yDiff > zDiff then
    ry = -rx - rz
  else
    rz = -rx - ry
  end
  position.x = rx
  position.y = ry
  return position
end

function OasisCoordinateConvert.ToUnityCenterPos(vector2, size)
  if #size ~= 2 then
    error("building size cfg error")
  end
  local position = OasisCoordinateConvert.ToUnity(vector2)
  local sizeType = size[1]
  if sizeType == 1 then
    return position
  elseif sizeType == 2 then
    return position + size3Offset
  elseif sizeType == 3 then
    return position + size4Offset
  end
end

function OasisCoordinateConvert.UnityCenterToOasis(vector3, size)
  if #size ~= 2 then
    error("building size cfg error")
  end
  local sizeType = size[1]
  if sizeType == 1 then
  elseif sizeType == 2 then
    vector3 = vector3 - size3Offset
  elseif sizeType == 3 then
    vector3 = vector3 - size4Offset
  end
  local pos = OasisCoordinateConvert.ToOasis(vector3)
  return pos
end

function OasisCoordinateConvert.GetHexWidth()
  return hexWidth
end

function OasisCoordinateConvert.GetHexHeight()
  return hexHeight
end

function OasisCoordinateConvert.GetHexArea(hexPos, size)
  local area = {}
  if #size ~= 2 then
    error("building size cfg error")
  end
  local sizeType = size[1]
  if sizeType == 1 then
    local radius = size[2]
    local n = radius - 1
    for x = -n, n do
      for y = math.max(-n, -x - n), math.min(n, -x + n) do
        local pos = Vector2.New(hexPos.x + x, hexPos.y + y)
        table.insert(area, pos)
      end
    end
  elseif sizeType == 2 then
    table.insert(area, hexPos)
    local pos = Vector2.New(hexPos.x, hexPos.y + 1)
    table.insert(area, pos)
    pos = Vector2.New(hexPos.x + 1, hexPos.y)
    table.insert(area, pos)
  elseif sizeType == 3 then
    table.insert(area, hexPos)
    local pos = Vector2.New(hexPos.x, hexPos.y + 1)
    table.insert(area, pos)
    pos = Vector2.New(hexPos.x + 1, hexPos.y)
    table.insert(area, pos)
    pos = Vector2.New(hexPos.x + 1, hexPos.y + 1)
    table.insert(area, pos)
  end
  return area
end

function OasisCoordinateConvert.HexDistance(a, b)
  local az = -a.x - a.y
  local bz = -b.x - b.y
  local distance = (math.abs(a.x - b.x) + math.abs(a.y - b.y) + math.abs(az - bz)) // 2
  return distance
end

function OasisCoordinateConvert.HexDistance2Center(hexPos)
  local distance = OasisCoordinateConvert.HexDistance(hexPos, Vector2.zero)
  return distance
end

Init()
return OasisCoordinateConvert
