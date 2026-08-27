local DormUtil = {}
local RoomPosOffset = 256
local cs_HighLighting = CS.HighLighting
local cs_RenderManager = CS.RenderManager
local DormEnum = require("Game.Dorm.DormEnum")
local hexSize = 30
local sqrt3 = math.sqrt(3)
local bedcount = 6
local sinTab = {
  [0] = 0,
  [90] = 1,
  [180] = 0,
  [270] = -1,
  [360] = 0
}
local cosTab = {
  [0] = 1,
  [90] = 0,
  [180] = -1,
  [270] = 0,
  [360] = 1
}
DormUtil.FntForOffset = {
  {x = -1, y = -1},
  {x = -1, y = 0},
  {x = -1, y = 1},
  {x = 0, y = -1},
  {x = 0, y = 1},
  {x = 1, y = -1},
  {x = 1, y = 0},
  {x = 1, y = 1}
}
local DormWallRotation = {
  [1] = Quaternion.Euler(0, 0, 0),
  [2] = Quaternion.Euler(0, 90, 0),
  [3] = Quaternion.Euler(0, 180, 0),
  [4] = Quaternion.Euler(0, 270, 0)
}
local DormWallRotReverse = {
  [1] = Quaternion.Euler(0, 180, 0),
  [2] = Quaternion.Euler(0, 270, 0),
  [3] = Quaternion.Euler(0, 0, 0),
  [4] = Quaternion.Euler(0, 90, 0)
}
local cs_Screen = CS.UnityEngine.Screen
DormUtil.NearInterPointDistance = 100 * cs_Screen.width / 1920

function DormUtil.GetDormConfigAsset()
  local ctrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  return ctrl:GetDormConfigAsset()
end

function DormUtil:GetBedCount()
  return 10
end

function DormUtil.RoomCoordToXY(pos)
  local x = (pos >> 16) - RoomPosOffset
  local y = (pos & CommonUtil.UInt16Max) - RoomPosOffset
  return x, y
end

function DormUtil.XYToRoomCoord(x, y)
  local pos = x + RoomPosOffset << 16 | y + RoomPosOffset
  return pos
end

function DormUtil.FntCoord2XY(pos)
  local x = pos >> 16
  local y = pos & CommonUtil.UInt16Max
  return x, y
end

function DormUtil.XYCoord2Fnt(x, y)
  local pos = x << 16 | y
  return pos
end

function DormUtil.ToRectTransformPos(x, y)
  local z = -x - y
  local position = Vector2.New()
  position.x = hexSize * sqrt3 * (x + z / 2)
  position.y = hexSize * z * 3 / 2
  return position
end

local roomPos2IndexDic = {}

function DormUtil.GetRoomIndexByRoomposToxy(x, y, r)
  local pos2IdxDic = roomPos2IndexDic[r]
  if pos2IdxDic == nil then
    pos2IdxDic = {}
    roomPos2IndexDic[r] = pos2IdxDic
    local n = r
    local idx = 0
    for dz = n, -n, -1 do
      for dx = math.max(-n, -dz - n), math.min(n, -dz + n) do
        local dy = -dz - dx
        idx = idx + 1
        pos2IdxDic[dx] = pos2IdxDic[dx] or {}
        pos2IdxDic[dx][dy] = idx
      end
    end
  end
  local idx = pos2IdxDic[x] and pos2IdxDic[x][y] or nil
  if idx == nil then
    error("Cant get room index")
    return 0
  end
  return idx
end

function DormUtil.FntCoord2Unity(x, y, fntType)
  local uX = x * ConfigData.game_config.HouseGridWidth
  local uY = y * ConfigData.game_config.HouseGridWidth
  local unityPos
  if DormEnum.IsFntWallType(fntType) then
    unityPos = Vector3.New(-uX, -uY, 0)
  else
    unityPos = Vector3.New(uY, 0, uX)
  end
  return unityPos
end

function DormUtil.GetFntUnityCoord(x, y)
  return DormUtil.FntCoord2Unity(x, y, DormEnum.eDormFntType.Furniture)
end

function DormUtil.UnityCoord2Fnt(pos, fntType)
  local x, y
  if DormEnum.IsFntWallType(fntType) then
    x = -pos.x / ConfigData.game_config.HouseGridWidth
    y = -pos.y / ConfigData.game_config.HouseGridWidth
  else
    x = pos.z / ConfigData.game_config.HouseGridWidth
    y = pos.x / ConfigData.game_config.HouseGridWidth
  end
  x = math.floor(x + 0.5)
  y = math.floor(y + 0.5)
  return x, y
end

function DormUtil.GetFntArea(posX, posY, sizeX, sizeY, angle)
  local areaList = {}
  for i = 0, sizeX - 1 do
    for j = 0, sizeY - 1 do
      local x = i
      local y = j
      local pos = {
        x = x * cosTab[angle] - y * sinTab[angle] + posX,
        y = x * sinTab[angle] + y * cosTab[angle] + posY
      }
      table.insert(areaList, pos)
    end
  end
  return areaList
end

function DormUtil.IsDmRoomDefaultDoorId(fntId)
  return fntId == ConfigData.game_config.DmRoomDoorDefaultId or fntId == 0
end

local DoorR = {
  [2] = proto_object_FT_R.R_0,
  [3] = proto_object_FT_R.R_90,
  [4] = proto_object_FT_R.R_180,
  [1] = proto_object_FT_R.R_270
}

function DormUtil.GetFntDoorR(wallId)
  local r = DoorR[wallId]
  if r == nil then
    error("Cant get fnt door R,wallId = " .. tostring(wallId))
    return 0
  end
  return r
end

local genDoorPosFunc = {
  [2] = function(wallPosX, gridLength)
    return wallPosX, 0
  end,
  [3] = function(wallPosX, gridLength)
    return gridLength - 1, wallPosX
  end,
  [4] = function(wallPosX, gridLength)
    return gridLength - 1 - wallPosX, gridLength - 1
  end,
  [1] = function(wallPosX, gridLength)
    return 0, gridLength - 1 - wallPosX
  end
}

function DormUtil.GetFntDoorPosByWall(wallId, wallPosX, gridLength)
  local func = genDoorPosFunc[wallId]
  if func == nil then
    error("Cant get genDoorPosFunc,wallId = " .. tostring(wallId))
    return 0, 0
  end
  return func(wallPosX, gridLength)
end

function DormUtil.FntAreaOutMap(posX, posY, sizeX, sizeY, angle, fntType, roomCfg)
  local mapX = roomCfg.grid_length - 1
  local mapY = roomCfg.grid_height - 1
  local areaList = {
    {0, 0}
  }
  if 1 < sizeX then
    table.insert(areaList, {
      sizeX - 1,
      0
    })
  end
  if 1 < sizeY then
    table.insert(areaList, {
      0,
      sizeY - 1
    })
  end
  if 1 < sizeX and 1 < sizeY then
    table.insert(areaList, {
      sizeX - 1,
      sizeY - 1
    })
  end
  local outX = false
  local outY = false
  local offsetX = 0
  local offsetY = 0
  for k, v in pairs(areaList) do
    local x, y = v[1], v[2]
    local areaX = x * cosTab[angle] - y * sinTab[angle] + posX
    local areaY = x * sinTab[angle] + y * cosTab[angle] + posY
    if areaX < 0 then
      outX = true
      offsetX = math.max(-areaX, offsetX)
    elseif mapX < areaX then
      outX = true
      offsetX = math.min(mapX - areaX, offsetX)
    end
    if DormEnum.IsFntWallType(fntType) then
      if areaY < 0 then
        outY = true
        offsetY = math.max(offsetY, -areaY)
      elseif mapY < areaY then
        outY = true
        offsetY = math.min(offsetY, mapY - areaY)
      end
    elseif areaY < 0 then
      outY = true
      offsetY = math.max(offsetY, -areaY)
    elseif mapX < areaY then
      outY = true
      offsetY = math.min(offsetY, mapX - areaY)
    end
  end
  local newX = posX + offsetX
  local newY = posY + offsetY
  return outX, outY, newX, newY
end

function DormUtil.FntSize2Unity(sizeX, sizeY, fntType)
  local uX = sizeX * ConfigData.game_config.HouseGridWidth
  local uY = sizeY * ConfigData.game_config.HouseGridWidth
  if DormEnum.IsFntWallType(fntType) then
    return Vector3.New(uX, 1, uY)
  else
    return Vector3.New(uY, 1, uX)
  end
end

function DormUtil.AddFntToMapDic(mapDic, posX, posY, sizeX, sizeY, angle)
  for x = 0, sizeX - 1 do
    for y = 0, sizeY - 1 do
      local curx = x * cosTab[angle] - y * sinTab[angle] + posX
      local cury = x * sinTab[angle] + y * cosTab[angle] + posY
      local pos = DormUtil.XYCoord2Fnt(curx, cury)
      mapDic[pos] = 1
    end
  end
end

function DormUtil.IsFntCoordLegal(x, y, gridLenth)
  if x < 0 or gridLenth <= x then
    return false
  end
  if y < 0 or gridLenth <= y then
    return false
  end
  return true
end

function DormUtil.GetFntOffsetCoord(fntX, fntY, fntR, x, y)
  local dstX = x * cosTab[fntR] - y * sinTab[fntR] + fntX
  local dstY = x * sinTab[fntR] + y * cosTab[fntR] + fntY
  return dstX, dstY
end

function DormUtil.GetDormWallRot(wallId, reverse)
  if reverse then
    return DormWallRotReverse[wallId]
  else
    return DormWallRotation[wallId]
  end
end

function DormUtil.GetDmFntPrefabPath(roomType, fntCfg)
  local path = fntCfg.prefab
  if roomType ~= 0 then
    local keyStr = "prefab_" .. tostring(roomType)
    if not string.IsNullOrEmpty(fntCfg[keyStr]) then
      path = fntCfg[keyStr]
    end
  end
  return PathConsts:GetDormFntPath(path)
end

function DormUtil.GetDmFntNumLimit(roomType, fntCatCfg)
  local value = fntCatCfg.limit
  if roomType ~= 0 then
    local keyStr = "limit_" .. tostring(roomType)
    value = fntCatCfg[keyStr]
  end
  return value
end

function DormUtil.AddHighLightTarget(gameObject)
  cs_HighLighting.Instance:AddHighLightTarget(gameObject)
  if cs_RenderManager.IsRenderTextureMode == false then
    cs_RenderManager.IsRenderTextureMode = true
  end
end

function DormUtil.RemovePointFntHighlight(gameObject)
  cs_HighLighting.Instance:RemoveHighLightTarget(gameObject)
end

function DormUtil.IsPositionWalkable(position, containNoLocked)
  containNoLocked = containNoLocked or false
  return CS.DormAStarUtils.IsPositionWalkable(position, containNoLocked)
end

function DormUtil.IsPositionOnNavmesh(position)
  return CS.DormAStarUtils.IsPositionOnNavmesh(position)
end

function DormUtil.FindNearestActivePoint(position)
  return CS.DormAStarUtils.FindNearestActivePoint(position)
end

function DormUtil.GetDormCmderResName()
  if PlayerDataCenter:GetCmderSex() then
    return "professor"
  else
    return "professor_boy"
  end
end

function DormUtil.GetDormCmderConfig()
  return ConfigData.dorm_special_hero[1]
end

function DormUtil.TryEnterOtherDorm(userId, userName)
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  if isUnlock then
    local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm, true)
    if dormCtrl:GetDormOwnerUserId() == userId then
      CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(9367))
      return
    end
    dormCtrl:EnterOtherDorm(userId, userName)
  end
end

return DormUtil
