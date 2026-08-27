local OasisBuildingUIModel = class("OasisBuildingUIModel")
local BuildingData = require("Game.Oasis.Data.OasisBuildingData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")

function OasisBuildingUIModel:ctor(buildingData)
  self:UpdateBuildingData(buildingData)
end

function OasisBuildingUIModel:UpdateBuildingData(buildingData)
  self.buildingData = buildingData
  self.buildingDataList = self:__handleBuildingData(buildingData)
end

function OasisBuildingUIModel:__handleBuildingData(buildingData)
  local allOasisBuildingList = {}
  for id, data in pairs(self.buildingData.oasisBuilt) do
    table.insert(allOasisBuildingList, data)
  end
  for id, data in pairs(self.buildingData.unbuilt) do
    if data.belong == BuildingBelong.Oasis then
      local buildData = BuildingData.New()
      buildData:InitializeWithDynData(nil, data)
      table.insert(allOasisBuildingList, buildData)
    end
  end
  table.sort(allOasisBuildingList, function(a, b)
    local aUnlockLevel, bUnlockLevel
    local alevelCfg = a.levelConfig[1]
    local blevelCfg = b.levelConfig[1]
    for index, condition in ipairs(alevelCfg.pre_condition) do
      if condition == 4 and alevelCfg.pre_para1[index] == 1001 then
        aUnlockLevel = alevelCfg.pre_para2[index]
      end
    end
    for index, condition in ipairs(blevelCfg.pre_condition) do
      if condition == 4 and blevelCfg.pre_para1[index] == 1001 then
        bUnlockLevel = blevelCfg.pre_para2[index]
      end
    end
    if aUnlockLevel == bUnlockLevel or aUnlockLevel == nil or bUnlockLevel == nil then
      return a.id < b.id
    else
      return aUnlockLevel < bUnlockLevel
    end
  end)
  return allOasisBuildingList
end

return OasisBuildingUIModel
