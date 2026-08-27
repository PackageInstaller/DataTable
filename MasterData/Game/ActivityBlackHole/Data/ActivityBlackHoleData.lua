local base = require("Game.ActivityFrame.ActivityBase")
local ActivityBlackHoleData = class("ActivityBlackHoleData", base)
local ActBHFloorData = require("Game.ActivityBlackHole.Data.ActBHFloorData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityBlackHoleEnum = require("Game.ActivityBlackHole.Data.ActivityBlackHoleEnum")
local CurActType = ActivityFrameEnum.eActivityType.ActBlackHole

function ActivityBlackHoleData:InitBlackHoleData(msg)
  self._actId = msg.actId
  self:SetActFrameDataByType(CurActType, self._actId)
  self._mainCfg = ConfigData.activity_blackhole_main[self._actId]
  self._floorCfg = ConfigData.activity_blackhole_floor[self._actId]
  self._rewardCfg = ConfigData.activity_blackhole_reward[self._actId]
  self._uiCfg = ConfigData.activity_blackhole_ui_config[self._actId]
  self:UpdateBlackHoleData(msg)
  self:GenBlackHoleFloorData()
end

function ActivityBlackHoleData:UpdateBlackHoleData(msg, isUpdate)
  self.totalScore = msg.totalScore
  self.currentFloor = msg.currentFloor
  self.rewardGot = msg.RewardGot
  self.blackHoleDatas = msg.blackHoleDatas
  if isUpdate then
    self:UpdateBlackHoleFloorData()
    MsgCenter:Broadcast(eMsgEventId.ActivityBlackHoleChange)
  end
  self:RefreshRewardRedDot()
  self:RefreshLookedRedDot()
end

function ActivityBlackHoleData:GenBlackHoleFloorData()
  self.blackHoleFloorDataList = {}
  for i, cfg in ipairs(self._floorCfg) do
    local data = ActBHFloorData.CreatActBHFloorData(cfg, self.blackHoleDatas[i], self)
    table.insert(self.blackHoleFloorDataList, data)
  end
end

function ActivityBlackHoleData:UpdateBlackHoleFloorData()
  for i, data in ipairs(self.blackHoleFloorDataList) do
    data:UpdateBHFloorData(self.blackHoleDatas[i])
  end
end

function ActivityBlackHoleData:RefreshRewardRedDot()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local nextCfg = self:GetNextStageRewardCfg()
  local redDotCount = 0
  if nextCfg and self.totalScore >= nextCfg.score then
    redDotCount = 1
  end
  local childReddot = reddot:AddChild(ActivityBlackHoleEnum.reddotType.RewardGot)
  if childReddot:GetRedDotCount() ~= redDotCount then
    childReddot:SetRedDotCount(redDotCount)
  end
end

function ActivityBlackHoleData:GetHaveRewardRedDot()
  local reddot = self:GetActivityReddot()
  local childReddot = reddot:AddChild(ActivityBlackHoleEnum.reddotType.RewardGot)
  return childReddot ~= nil and childReddot:GetRedDotCount() > 0
end

function ActivityBlackHoleData:RefreshLookedRedDot()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isLooked = saveUserData:GetBlackHoleLooked(self:GetActId())
  local redDotNum = isLooked and 0 or 1
  local childReddot = reddot:AddChild(ActivityBlackHoleEnum.reddotType.Look)
  if childReddot:GetRedDotCount() ~= redDotNum then
    childReddot:SetRedDotCount(redDotNum)
  end
end

function ActivityBlackHoleData:SetNowSelectFloor(id)
  self.nowSelectFloorId = id
end

function ActivityBlackHoleData:SetBlackHoleLooked()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetBlackHoleLooked(self:GetActId())
  self:RefreshLookedRedDot()
end

function ActivityBlackHoleData:GetBlackHoleMainCfg()
  return self._mainCfg
end

function ActivityBlackHoleData:GetBlackHoleFloorCfg()
  return self._floorCfg
end

function ActivityBlackHoleData:GetBlackHoleUICfg()
  return self._uiCfg
end

function ActivityBlackHoleData:GetBlackHoleRewardCfg()
  return self._rewardCfg
end

function ActivityBlackHoleData:GetNowSelectFloorId()
  return self.nowSelectFloorId
end

function ActivityBlackHoleData:GetBlackHoleTagList()
  return self._uiCfg.tag_id
end

function ActivityBlackHoleData:GetNowRewardStage()
  local stage = 0
  local numStage = 0
  local totalScore = self:GetActTotalScore()
  for i, cfg in pairs(self._rewardCfg) do
    if self.rewardGot >= cfg.score then
      stage = i
    end
    if totalScore >= cfg.score then
      numStage = i
    end
  end
  return stage, numStage
end

function ActivityBlackHoleData:GetNextStageRewardCfg()
  for i, cfg in pairs(self._rewardCfg) do
    if self.rewardGot < cfg.score then
      return cfg
    end
  end
  return nil
end

function ActivityBlackHoleData:GetActTotalScore()
  return self.totalScore or 0
end

function ActivityBlackHoleData:GetNowRewardGotScore()
  return self.rewardGot or 0
end

function ActivityBlackHoleData:GetBlackHoleLastFloor()
  local floorData
  for id, data in pairs(self.blackHoleFloorDataList) do
    if id == 1 then
      floorData = data
    elseif self.blackHoleFloorDataList[id - 1]:GetNowScore() > 0 then
      floorData = data
    else
      break
    end
  end
  return floorData
end

function ActivityBlackHoleData:GetBlackHoleBossFloor()
  for i = #self.blackHoleFloorDataList, 1, -1 do
    local floorData = self.blackHoleFloorDataList[i]
    if floorData:GetFloorIsBoss() then
      return floorData
    end
  end
  return nil
end

function ActivityBlackHoleData:GetBlackHoleFloorData(floorId)
  return self.blackHoleFloorDataList[floorId]
end

function ActivityBlackHoleData:GetBlackHoleFloorDataList()
  return self.blackHoleFloorDataList
end

function ActivityBlackHoleData:GetBlackHoleRankId()
  return self:GetBlackHoleMainCfg().rank_id
end

function ActivityBlackHoleData:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(ActivityBlackHoleEnum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

return ActivityBlackHoleData
