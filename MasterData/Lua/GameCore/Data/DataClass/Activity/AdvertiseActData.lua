local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local AdvertiseActData = class("AdvertiseActData", ActivityDataBase)

function AdvertiseActData:Init()
  self.nStatus = 0
  self.jointDrillActCfg = nil
  self.adCfg = ConfigTable.GetData("AdControl", self.actCfg.Id)
  self.bIsMove = self.adCfg.IsMove
  self:InitConfig()
end

function AdvertiseActData:InitConfig()
end

function AdvertiseActData:RefreshInfinityTowerActData(msgData)
end

function AdvertiseActData:CheckHideFromActList()
  if self.bIsMove and self:isFinishAllTasks() then
    return true
  end
  if self.actCfg ~= nil then
    return self.actCfg.HideFromActivityList
  end
  return true
end

function AdvertiseActData:GetActivityRedDot()
  if self.bRedDot then
    return true
  end
  if self.adCfg == nil or self.bCheckIncludeRedDot then
    return false
  end
  self.bCheckIncludeRedDot = true
  local bRedDot = false
  for _, nActId in ipairs(self.adCfg.IncludeAct or {}) do
    local actData = PlayerData.Activity:GetActivityDataById(nActId)
    if actData ~= nil and actData:CheckActShow() and actData:GetActivityRedDot() then
      bRedDot = true
      break
    end
  end
  self.bCheckIncludeRedDot = false
  return bRedDot
end

function AdvertiseActData:CheckShowBanner()
  if self.bIsMove and self:isFinishAllTasks() then
    return false
  end
  return self:CheckActPlay() and self.actCfg.BannerRes ~= "" and self.bBanner == false
end

function AdvertiseActData:isFinishAllTasks()
  local nTotalCount, nReceivedCount = PlayerData.TutorialData:GetProgress()
  local bHasReceiveAllGroup = PlayerData.Quest:CheckTourGroupReward(PlayerData.Quest:GetMaxTourGroupOrderIndex())
  local nAttrQuestCount = #PlayerData.Quest.tbTeamFormationAttr or 1
  local nAttrReceivedCount, nAttrTotalCount = 0, 0
  for i = 1, nAttrQuestCount do
    local nThisReceivedCount, nThisTotalCount = PlayerData.Quest:GetTeamFormationAttributeProgress(i)
    nAttrReceivedCount = nAttrReceivedCount + nThisReceivedCount
    nAttrTotalCount = nAttrTotalCount + nThisTotalCount
  end
  if bHasReceiveAllGroup and nTotalCount == nReceivedCount and nAttrReceivedCount == nAttrTotalCount then
    return true
  end
  return false
end

return AdvertiseActData
