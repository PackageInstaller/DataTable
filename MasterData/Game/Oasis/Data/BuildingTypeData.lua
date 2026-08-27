local BuildingTypeData = class("BuildingTypeData")
local BuildingData = require("Game.Oasis.Data.OasisBuildingData")
local BuildingEnum = require("Game.Oasis.Data.BuildingEnum")

function BuildingTypeData.CreateAllBuildTypeData()
  local buildTypeDataList = {}
  for typeId, buildIdList in pairs(ConfigData.building.buildingTypeDic) do
    local typeData = BuildingTypeData.New(typeId, buildIdList)
    table.insert(buildTypeDataList, typeData)
  end
  return buildTypeDataList
end

function BuildingTypeData:ctor(typeId, buildIdList)
  self.typeId = typeId
  self.buildIdList = buildIdList
  self:UpdateBuildTypeDataState()
end

function BuildingTypeData:GetBuildTypeNum()
  local num = 0
  for k, buildId in ipairs(self.buildIdList) do
    if PlayerDataCenter.AllBuildingData.built[buildId] ~= nil then
      num = num + 1
    end
  end
  local maxNum = #self.buildIdList
  return num, maxNum
end

function BuildingTypeData:GetNextUnlockBuildData()
  for k, buildId in ipairs(self.buildIdList) do
    local buildData = PlayerDataCenter.AllBuildingData.built[buildId]
    if buildData == nil then
      local dynData = PlayerDataCenter.AllBuildingData.unbuilt[buildId]
      buildData = BuildingData.New()
      buildData:InitializeWithDynData(nil, dynData)
      return buildData
    end
  end
  return PlayerDataCenter.AllBuildingData.built[self.buildIdList[1]]
end

function BuildingTypeData:UpdateBuildTypeDataState()
  local curNum, maxNum = self:GetBuildTypeNum()
  local buildingData = self:GetNextUnlockBuildData()
  if buildingData.isBuild then
    if curNum == maxNum then
      self.buildTypeState = BuildingEnum.BuildingTypeState.MaxNum
    else
      error("error BuildingTypeState state")
    end
  elseif buildingData.dynData:Unlock() then
    self.buildTypeState = BuildingEnum.BuildingTypeState.CanBuild
  elseif curNum == 0 then
    self.buildTypeState = BuildingEnum.BuildingTypeState.Lock
  else
    self.buildTypeState = BuildingEnum.BuildingTypeState.MoreNumLock
  end
  return self.buildTypeState
end

function BuildingTypeData:GetBuildTypeState()
  return self.buildTypeState
end

return BuildingTypeData
