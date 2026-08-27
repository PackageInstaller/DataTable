local base = require("Game.Oasis.Ctrl.OasisCtrlBase")
local OasisLittleManCtrl = class("OasisLittleManCtrl", base)
local CoordinateConvert = require("Game.Oasis.OasisCoordinateConvert")
local LittleManCharacterAI = require("Game.LittleMan.AI.LittleManCharacterAI")

function OasisLittleManCtrl:InitOasisLittleManCtrl()
  self.littleManManager = CS.LittleManManager.Instance
  self.hasSetScenePointY = false
end

function OasisLittleManCtrl:GenerateLittleMan(buildItems, oasisAreaList)
  if IsNull(self.littleManManager) then
    return
  end
  local systemData = PersistentManager:GetDataModel(PersistentConfig.ePackage.SystemData)
  local openLittleMan = systemData:GetDisplaySettingValue("open_little_man") == 1
  if not openLittleMan then
    return
  end
  local maxLittleManCount = 100
  self.littleManManager:Init()
  self.littleManManager:RemoveAllLittleMan()
  self:DisableCacheLittleManPoint()
  local littleManPointList = self:__FindAllLittleManPoint(buildItems, oasisAreaList)
  local heroDataList = {}
  for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
    table.insert(heroDataList, heroData)
  end
  self:shuffle(littleManPointList)
  self:shuffle(heroDataList)
  local index = 1
  self.aiCtrlList = {}
  for _, heroData in ipairs(heroDataList) do
    if index > math.min(math.min(PlayerDataCenter.heroCount, maxLittleManCount), #littleManPointList) then
      break
    end
    local heroId = heroData.dataId
    local dormModelResPath = PathConsts:GetCharacterDormModelPath(heroData:GetResModelName())
    local littleMan = self.littleManManager:CreateLittleMan(littleManPointList[index], Vector4.New(-1, 1, -1, 1), heroId, dormModelResPath)
    local offsetX, offsetY = self:__GetLittleManTextureOffset(heroId)
    littleMan:SetLittleManSkin(offsetX, offsetY)
    local aiCfg = ConfigData.dorm_ai[2001]
    local aiCtrl = LittleManCharacterAI.New(aiCfg, true, littleMan)
    aiCtrl:RandNewAction()
    table.insert(self.aiCtrlList, aiCtrl)
    index = index + 1
  end
end

function OasisLittleManCtrl:__FindAllLittleManPoint(buildItems, oasisAreaList)
  local littleManPointList = {}
  local scenePoints = self.littleManManager:GetComponentsInChildren(typeof(CS.LittleManPoint))
  for i = 0, scenePoints.Length - 1 do
    table.insert(littleManPointList, scenePoints[i])
  end
  if buildItems ~= nil then
    for key, value in pairs(buildItems) do
      local gameObject = value.gameObject
      if not IsNull(gameObject) then
        local buildingPoints = gameObject:GetComponentsInChildren(typeof(CS.LittleManPoint))
        for i = 0, buildingPoints.Length - 1 do
          table.insert(littleManPointList, buildingPoints[i])
        end
      end
    end
  end
  if self.littleManPointMap == nil then
    self.littleManPointMap = {}
  end
  if oasisAreaList ~= nil then
    for areaId, oasisArea in pairs(oasisAreaList) do
      local unlock = PlayerDataCenter.AllBuildingData:OsisAreaUnlock(areaId)
      if unlock then
        local radius = oasisArea.cfg.size - 1
        for x = -radius, radius do
          for y = math.max(-radius, -x - radius), math.min(radius, -x + radius) do
            if oasisArea.buildingMap[x][y] == nil then
              local littleManPoint = self:GetHexLittleManPoint(areaId, x, y, self.littleManPointMap, oasisAreaList)
              table.insert(littleManPointList, littleManPoint)
            end
          end
        end
      end
    end
  end
  local count = #littleManPointList
  if not self.hasSetScenePointY then
    for i = 1, count do
      local transform = littleManPointList[i].transform
      local pos = transform.position
      local offset = (i - count / 2) / count * 1.5
      pos.y = pos.y + offset
      transform.position = pos
    end
    self.hasSetScenePointY = true
  end
  return littleManPointList
end

function OasisLittleManCtrl:shuffle(tableList)
  local length = #tableList
  while 0 < length do
    local idx = math.random(length)
    tableList[length], tableList[idx] = tableList[idx], tableList[length]
    length = length - 1
  end
  return tableList
end

function OasisLittleManCtrl:__GetLittleManTextureOffset(heroId)
  local offset = heroId - 1000 - 1
  local offsetX = math.fmod(offset, 16) * 0.0625
  local offsetY = math.modf(offset / 16) * 0.0625
  return offsetX, offsetY
end

local dir = {
  Vector2.New(-1, 0),
  Vector2.New(1, 0),
  Vector2.New(0, -1),
  Vector2.New(0, 1),
  Vector2.New(1, -1),
  Vector2.New(-1, 1)
}

function OasisLittleManCtrl:GetHexLittleManPoint(areaId, x, y, littleManPointTable, oasisAreaList)
  if littleManPointTable[areaId] == nil then
    littleManPointTable[areaId] = {}
  end
  if littleManPointTable[areaId][x] == nil then
    littleManPointTable[areaId][x] = {}
  end
  local oasisArea = oasisAreaList[areaId]
  local radius = oasisArea.cfg.size - 1
  local cachePoint = littleManPointTable[areaId][x][y]
  if cachePoint ~= nil then
    cachePoint.gameObject:SetActive(true)
    return cachePoint
  else
    local parent = CS.UnityEngine.GameObject()
    parent.transform.parent = self.littleManManager.transform
    parent.transform.position = oasisArea.transform.position + CoordinateConvert.ToUnity(Vector2.New(x, y))
    local littleManPoint = parent:AddComponent(typeof(CS.LittleManPoint))
    littleManPointTable[areaId][x][y] = littleManPoint
  end
  local point = littleManPointTable[areaId][x][y]
  for i = 1, #dir do
    local nerX = x + dir[i].x
    local nerY = y + dir[i].y
    if oasisArea.buildingMap[nerX] ~= nil and oasisArea.buildingMap[nerX][nerY] == nil and nerX >= -radius and radius >= nerX and nerY >= math.max(-radius, -nerX - radius) and nerY <= math.min(radius, -nerX + radius) then
      point.NeighbourPoints:Add(self:GetHexLittleManPoint(areaId, nerX, nerY, littleManPointTable, oasisAreaList))
    end
  end
  return littleManPointTable[areaId][x][y]
end

function OasisLittleManCtrl:RemoveLittleMan(isClearCache)
  if IsNull(self.littleManManager) then
    return
  end
  if isClearCache == true then
    self.littleManManager:Clear()
  else
    self.littleManManager:RemoveAllLittleMan()
  end
  self.aiCtrlList = {}
end

function OasisLittleManCtrl:DisableCacheLittleManPoint()
  if self.littleManPointMap ~= nil then
    for areaId, areaTable in pairs(self.littleManPointMap) do
      for x, xTable in pairs(areaTable) do
        for y, littleManPoint in pairs(xTable) do
          littleManPoint.gameObject:SetActive(false)
        end
      end
    end
  end
end

function OasisLittleManCtrl:RemoveLittleManPoint()
  if self.littleManPointMap ~= nil then
    for areaId, areaTable in pairs(self.littleManPointMap) do
      for x, xTable in pairs(areaTable) do
        for y, littleManPoint in pairs(xTable) do
          DestroyUnityObject(littleManPoint.gameObject)
        end
      end
    end
  end
  self.littleManPointMap = nil
end

function OasisLittleManCtrl:LittleManAIUpdate()
  if self.aiCtrlList ~= nil then
    for _, aiCtrl in pairs(self.aiCtrlList) do
      aiCtrl:OnUpdate()
    end
  end
end

return OasisLittleManCtrl
