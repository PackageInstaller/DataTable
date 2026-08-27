local MilestoneData = class("MilestoneData")
local MilestoneEnum = require("Game.MileStone.MilestoneEnum")
local MilestoneDimensionData = require("Game.MileStone.Data.MilestoneDimensionData")
local MilestoneHeroBandData = require("Game.MileStone.Data.MilestoneHeroBandData")

function MilestoneData:ctor(userInfoData)
  self.userInfoData = userInfoData
  self.diemensionDataDic = {}
  self.bandDataDic = {}
  local msMsg = userInfoData:GetMilestoneMsg()
  for _, msModuleId in pairs(MilestoneEnum.eMileStoneModule) do
    local moduleElemMsg
    if msMsg ~= nil then
      moduleElemMsg = msMsg.module[msModuleId]
    end
    local data = MilestoneDimensionData.New(msModuleId, moduleElemMsg)
    self.diemensionDataDic[msModuleId] = data
    if userInfoData:GetIsSelfUserInfo() then
      self:_UpdStageRewardReddot(msModuleId)
    end
  end
  if userInfoData:GetIsSelfUserInfo() then
    for bandId = 1, ConfigData.milestones_mile_band.maxBandId do
      if ConfigData.milestones_mile_band[bandId] ~= nil then
        local bandElemMsg = msMsg and msMsg.band[bandId]
        local data = MilestoneHeroBandData.New(bandId, bandElemMsg)
        self.bandDataDic[bandId] = data
      end
    end
    self:_UpdBandStageRewardReddot()
  end
end

function MilestoneData:UpdateMilestoneData(userInfoData)
  self.userInfoData = userInfoData
  local msMsg = userInfoData:GetMilestoneMsg()
  if msMsg ~= nil then
    for msModuleId, moduleElemMsg in pairs(msMsg.module) do
      local msDData = self.diemensionDataDic[msModuleId]
      msDData:UpdateByModuleMsg(moduleElemMsg)
      if userInfoData:GetIsSelfUserInfo() then
        self:_UpdStageRewardReddot(msModuleId)
      end
    end
    if userInfoData:GetIsSelfUserInfo() and not table.IsEmptyTable(msMsg.band) then
      for bandId, bandElemMsg in pairs(msMsg.band) do
        local bandData = self.bandDataDic[bandId]
        bandData:UpdateByMSBandMsg(bandElemMsg)
      end
      self:_UpdBandStageRewardReddot()
    end
  end
end

function MilestoneData:GetMilestoneDimensionData(moduleId)
  return self.diemensionDataDic[moduleId]
end

function MilestoneData:GetMilestoneBandDataDic()
  return self.bandDataDic
end

function MilestoneData:GetDataForStar2Show()
  local stageDic = {}
  local processDic = {}
  for _, msModuleId in pairs(MilestoneEnum.eMileStoneModule) do
    local msDData = self.diemensionDataDic[msModuleId]
    if msDData ~= nil then
      stageDic[msModuleId] = msDData:GetMlstDimensionStage()
      processDic[msModuleId] = msDData:GetMlstDimensionScoreProgress()
    else
      stageDic[msModuleId] = 0
      processDic[msModuleId] = 0
    end
  end
  return stageDic, processDic
end

function MilestoneData:GetMSUserInfoData()
  return self.userInfoData
end

function MilestoneData:_UpdStageRewardReddot(msModuleId)
  local node = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.MlstModulePath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Milestone, msModuleId):AddChild(RedDotStaticTypeId.MlstModuleStageReward)
  local canPickReward = self.diemensionDataDic[msModuleId]:IsMlstDimensionCanPickStageReward()
  node:SetRedDotCount(canPickReward and 1 or 0)
end

function MilestoneData:_UpdBandStageRewardReddot()
  local dotNum = 0
  for k, v in pairs(self.bandDataDic) do
    if v:CanPickMlstBandStageReward() then
      dotNum = 1
      break
    end
  end
  local node = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.MlstModulePath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Milestone, MilestoneEnum.eMileStoneModule.mind):AddChild(RedDotStaticTypeId.MlstModuleBandReward)
  node:SetRedDotCount(dotNum)
end

return MilestoneData
