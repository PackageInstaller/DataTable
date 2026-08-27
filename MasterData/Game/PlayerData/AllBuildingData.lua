local AllBuildingData = class("AllBuildingData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local BuildingDynData = require("Game.Oasis.Data.OasisBuildingDynData")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local NoticeData = require("Game.Notice.NoticeData")
local JumpManager = require("Game.Jump.JumpManager")
local BuildingEnum = require("Game.Oasis.Data.BuildingEnum")

function AllBuildingData:ctor()
  self.built = {}
  self.builtSort = {}
  self.unbuilt = {}
  self.unbuiltSort = {}
  self.oasisBuilt = {}
  self.sectorBuilt = {}
  self.oasisAreaDic = {}
  self.oasisTotalLevel = 0
  self.stoTotalLevel = 0
  self.careerTotalLevel = 0
  for _, v in ipairs(ConfigData.building.id_sort_list) do
    local stcData = ConfigData.building[v]
    local data = BuildingDynData.New()
    data:Initialize(stcData)
    self.unbuilt[data.id] = data
    table.insert(self.unbuiltSort, data)
    if data.belong == BuildingBelong.Oasis then
      self.oasisTotalLevel = self.oasisTotalLevel + data.maxLevel
    end
  end
  table.sort(self.unbuiltSort, function(a, b)
    return a.id < b.id
  end)
end

function AllBuildingData:InitOasisAreaData(areaData)
  for areaId, areaCfg in ipairs(ConfigData.oasis_area) do
    self.oasisAreaDic[areaId] = areaData[areaId] ~= nil
    if areaData[areaId] == nil then
      for index, pre_conditionId in ipairs(areaCfg.pre_condition) do
        local pre_para1 = areaCfg.pre_para1[index]
        local pre_para2 = areaCfg.pre_para2[index]
        NoticeManager:Add2PreConditionDic(pre_conditionId, pre_para1, pre_para2, function()
          if CheckCondition.CheckLua(areaCfg.pre_condition, areaCfg.pre_para1, areaCfg.pre_para2) then
            NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.OasisAreaUnlock, {
              jumpType = JumpManager.eJumpTarget.Oasis,
              argList = nil
            }, {
              " " .. tostring(areaCfg.id) .. " "
            }, {areaId = areaId}))
            return true
          end
        end)
      end
    end
  end
  self._isInited = true
end

function AllBuildingData:IsBuildingDataInited()
  return self._isInited
end

function AllBuildingData:UpdateOasisAreaData(areaId, unlock)
  if self.oasisAreaDic[areaId] == nil then
    error("Cant get oasisArea, areaId = " .. tostring(areaId))
    return
  end
  self.oasisAreaDic[areaId] = unlock
end

function AllBuildingData:OsisAreaUnlock(areaId)
  return self.oasisAreaDic[areaId]
end

function AllBuildingData:UpdateData()
  self:UpdateBuilt()
end

function AllBuildingData:UpdateBuilt()
  self.sectorBuilt = {}
  self.oasisBuilt = {}
  for k, v in pairs(self.built) do
    if v.belong == BuildingBelong.Sector then
      self.sectorBuilt[v.id] = v
    elseif v.belong == BuildingBelong.Oasis then
      self.oasisBuilt[v.id] = v
    end
  end
end

function AllBuildingData:FullBuildQue(buildingBelong)
  local inQueCount = 0
  if buildingBelong == BuildingBelong.Oasis then
    for k, v in pairs(self.oasisBuilt) do
      if v.state ~= proto_object_BuildingState.BuildingStateNormal then
        inQueCount = inQueCount + 1
        if inQueCount >= PlayerDataCenter.playerBonus:GetBuildQueueCount(eBuildQueueType.Oasis) then
          return true
        end
      end
    end
  elseif buildingBelong == BuildingBelong.Sector then
    for k, v in pairs(self.sectorBuilt) do
      if v.state ~= proto_object_BuildingState.BuildingStateNormal then
        inQueCount = inQueCount + 1
        if inQueCount >= PlayerDataCenter.playerBonus:GetBuildQueueCount(eBuildQueueType.Sector) then
          return true
        end
      end
    end
  end
  return false
end

function AllBuildingData:FullOasisBuildQue()
  return self:FullBuildQue(BuildingBelong.Oasis)
end

function AllBuildingData:FullSectorBuildQue()
  return self:FullBuildQue(BuildingBelong.Sector)
end

function AllBuildingData:GetResOutputEfficiency(id)
  local value = PlayerDataCenter.playerBonus:GetResOutputEfficiency(id)
  local value0 = PlayerDataCenter.playerBonus:GetResOutputEfficiency(0)
  value = value + value0
  return value
end

function AllBuildingData:GetBuiltDataById(buildId)
  local bulidData = self.built[buildId]
  if bulidData == nil then
    return nil
  end
  return bulidData:GetResDatas()
end

function AllBuildingData:GetOasisBuiltRate()
  local totalBuiltLevel = 0
  for _, built in pairs(self.oasisBuilt) do
    totalBuiltLevel = totalBuiltLevel + (built.level or 0)
  end
  return totalBuiltLevel / self.oasisTotalLevel
end

function AllBuildingData:UpdateBuildLevelRecord(buildId, curLevel, oriLevel)
  local cfg = ConfigData.building[buildId]
  if cfg == nil then
    return
  end
  if cfg.type == BuildingEnum.BuildingType.SectorProduct or cfg.type == BuildingEnum.BuildingType.SectorAddtion then
    self.stoTotalLevel = self.stoTotalLevel - (oriLevel or 0)
    self.stoTotalLevel = self.stoTotalLevel + (curLevel or 0)
    return
  end
  if cfg.type == BuildingEnum.BuildingType.CareerMaster then
    self.careerTotalLevel = self.careerTotalLevel - (oriLevel or 0)
    self.careerTotalLevel = self.careerTotalLevel + (curLevel or 0)
    return
  end
end

return AllBuildingData
