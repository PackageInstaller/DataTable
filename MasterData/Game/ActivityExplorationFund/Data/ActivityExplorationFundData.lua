local base = require("Game.ActivityFrame.ActivityBase")
local ActivityExplorationFundData = class("ActivityExplorationFundData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.ExplorationFund
local ActivityExplorationFundEnum = require("Game.ActivityExplorationFund.Data.ActivityExplorationFundEnum")
local ActivityExplorationFundSingleFundData = require("Game.ActivityExplorationFund.Data.ActivityExplorationFundSingleFundData")

function ActivityExplorationFundData:InitExplorationFundData(msg)
  local actId = msg.actId
  self:SetActFrameDataByType(CurActType, actId)
  self._mainCfg = ConfigData.activity_explore_main[actId]
  self._fundDataDic = {}
  self:UpdateExplorationFundData(msg)
end

function ActivityExplorationFundData:UpdateExplorationFundData(msg)
  self._actId = msg.actId
  self._funds = msg.funds
  self:__UpdateExplorationFundRewardData(msg.funds)
  self:__RefreshExplorationFundRedReward()
  if self:GetNeedHideExplorationFund() then
    local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    activityCtrl:HideActivityByExtraLogic(CurActType, self._actId)
  end
  MsgCenter:Broadcast(eMsgEventId.ActivityExplorationFundChange)
end

function ActivityExplorationFundData:__UpdateExplorationFundRewardData(funds)
  for _, msgFund in ipairs(funds) do
    if self._fundDataDic[msgFund.id] == nil then
      local singleFundData = ActivityExplorationFundSingleFundData.CreateSingleFundData(msgFund)
      self._fundDataDic[msgFund.id] = singleFundData
    else
      self._fundDataDic[msgFund.id]:UpdateSingleFundDataByMsg(msgFund)
    end
  end
end

function ActivityExplorationFundData:ForceUpdateExplorationFundRewardData()
  self:__UpdateExplorationFundRewardData(self._funds)
  self:__RefreshExplorationFundRedReward()
  MsgCenter:Broadcast(eMsgEventId.ActivityExplorationFundChange)
end

function ActivityExplorationFundData:__RefreshExplorationFundRedReward()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivityExplorationFundEnum.EReddotType.Reward)
  local flag = false
  for _, vFundData in pairs(self._fundDataDic) do
    if vFundData:GetSingleFundDataHasCompleteReward() then
      flag = true
      break
    end
  end
  flag = flag and not self:GetNeedHideExplorationFund()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityExplorationFundData:GetNeedHideExplorationFund()
  for _, singleFundData in pairs(self._fundDataDic) do
    if not singleFundData:GetIsFundOver() then
      return false
    end
  end
  return true
end

function ActivityExplorationFundData:GetExplorationFundIds()
  return self._mainCfg.group_id
end

function ActivityExplorationFundData:GetExplorationFundDataById(fundId)
  return self._fundDataDic[fundId]
end

function ActivityExplorationFundData:GetIsExplorationFundUnlockSenior(fundId)
  if self._fundDataDic[fundId] == nil then
    return false
  end
  return self._fundDataDic[fundId]:GetIsSingleFundDataUnlockSenior()
end

function ActivityExplorationFundData:GetIsExplorationFundRewardState(fundId, stepLevel)
  if self._fundDataDic[fundId] == nil then
    return false
  end
  return self._fundDataDic[fundId]:GetSingleFundDataRewardState(stepLevel)
end

function ActivityExplorationFundData:GetLastCanGetRewardFoundId()
  for id, singleFundData in pairs(self._fundDataDic) do
    if not singleFundData:GetIsFundOver() then
      return id
    end
  end
  return 1
end

return ActivityExplorationFundData
