local ActivityExplorationFundSingleFundData = class("ActivityExplorationFundSingleFundData")
local ActivityExplorationFundEnum = require("Game.ActivityExplorationFund.Data.ActivityExplorationFundEnum")
local ERewardState = ActivityExplorationFundEnum.ERewardState

function ActivityExplorationFundSingleFundData.CreateSingleFundData(msgFund)
  local singleFundData = ActivityExplorationFundSingleFundData.New()
  singleFundData.id = msgFund.id
  singleFundData._rewardMask = msgFund.rewardMask
  singleFundData._seniorRewardMask = msgFund.seniorRewardMask
  singleFundData.unlockSenior = msgFund.unlockSenior
  singleFundData.hasCompletedReward = false
  singleFundData._commonRewardStateDic = {}
  singleFundData._seniorRewardStateDic = {}
  singleFundData._rewardCfgs = ConfigData.activity_explore_reward[msgFund.id]
  singleFundData._rewardLevels = {}
  singleFundData._fundCfg = ConfigData.activity_explore_fund[msgFund.id]
  singleFundData:UpdateSingleFundDataByMsg(msgFund)
  return singleFundData
end

function ActivityExplorationFundSingleFundData:UpdateSingleFundDataByMsg(msgFund)
  if msgFund.id ~= self.id then
    error("UpdateSingleFundDataByMsg Fail, msgFundId not match!")
    return
  end
  table.clearmap(self._rewardLevels)
  self._rewardMask = msgFund.rewardMask
  self._seniorRewardMask = msgFund.seniorRewardMask
  self.unlockSenior = msgFund.unlockSenior
  self.hasCompletedReward = false
  self._isFundOver = true
  for _, rewardCfg in ipairs(self._rewardCfgs) do
    local commonPicked = 1 << rewardCfg.order & self._rewardMask ~= 0
    local seniorPicked = 1 << rewardCfg.order & self._seniorRewardMask ~= 0
    local isInprogress = not CheckCondition.CheckLua(rewardCfg.pre_condition, rewardCfg.pre_para1, rewardCfg.pre_para2)
    local commonState = isInprogress and ERewardState.InProgress or commonPicked and ERewardState.IsPicked or ERewardState.Complete
    local seniorState = isInprogress and ERewardState.InProgress or seniorPicked and ERewardState.IsPicked or ERewardState.Complete
    self._commonRewardStateDic[rewardCfg.order] = commonState
    self._seniorRewardStateDic[rewardCfg.order] = seniorState
    table.insert(self._rewardLevels, rewardCfg.order)
    if commonState == ERewardState.Complete and self:GetIsSingleFundDataUnlock() or seniorState == ERewardState.Complete and self:GetIsSingleFundDataUnlockSenior() then
      self.hasCompletedReward = true
    end
    if commonState ~= ERewardState.IsPicked or seniorState ~= ERewardState.IsPicked then
      self._isFundOver = false
    end
  end
  table.sort(self._rewardLevels, function(levelA, levelB)
    local seniorRewardStateA = self._seniorRewardStateDic[levelA]
    local seniorRewardStateB = self._seniorRewardStateDic[levelB]
    if levelA == levelB then
      return false
    end
    if seniorRewardStateA ~= ERewardState.IsPicked and seniorRewardStateB ~= ERewardState.IsPicked then
      return levelA < levelB
    else
      return seniorRewardStateA ~= ERewardState.IsPicked
    end
  end)
end

function ActivityExplorationFundSingleFundData:GetSingleFundDataHasCompleteReward()
  return self.hasCompletedReward
end

function ActivityExplorationFundSingleFundData:GetSingleFundDataRewardLevels()
  return self._rewardLevels
end

function ActivityExplorationFundSingleFundData:GetSingleFundDataRewardLevelCfg(level)
  return self._rewardCfgs[level]
end

function ActivityExplorationFundSingleFundData:GetSingleFundDataSeniorRewardCanPick()
  local rewardDic = {}
  for level = 1, #self._rewardCfgs do
    if self._seniorRewardStateDic[level] == ERewardState.Complete then
      local rewardCfg = self:GetSingleFundDataRewardLevelCfg(level)
      for rewardId, rewardNum in pairs(rewardCfg.senior_item) do
        if rewardDic[rewardId] == nil then
          rewardDic[rewardId] = rewardNum
        else
          rewardDic[rewardId] = rewardDic[rewardId] + rewardNum
        end
      end
    end
  end
  if table.IsEmptyTable(rewardDic) then
    return table.emptytable, table.emptytable
  else
    local rewardIds = {}
    local rewardNums = {}
    for rewardId, rewardNum in pairs(rewardDic) do
      table.insert(rewardIds, rewardId)
      table.insert(rewardNums, rewardNum)
    end
    return rewardIds, rewardNums
  end
end

function ActivityExplorationFundSingleFundData:GetSingleFundDataFundCfg()
  return self._fundCfg
end

function ActivityExplorationFundSingleFundData:GetSingleFundDataRewardState(level)
  return self._commonRewardStateDic[level], self._seniorRewardStateDic[level]
end

function ActivityExplorationFundSingleFundData:GetIsSingleFundDataUnlock()
  return CheckCondition.CheckLua(self._fundCfg.pre_condition, self._fundCfg.pre_para1, self._fundCfg.pre_para2)
end

function ActivityExplorationFundSingleFundData:GetSingleFundDataLockDes()
  return CheckCondition.GetUnlockInfoLua(self._fundCfg.pre_condition, self._fundCfg.pre_para1, self._fundCfg.pre_para2)
end

function ActivityExplorationFundSingleFundData:GetIsSingleFundDataUnlockSenior()
  return self.unlockSenior
end

function ActivityExplorationFundSingleFundData:GetIsSingleFundDataCanBuySenior()
  return CheckCondition.CheckLua(self._fundCfg.pre_condition2, self._fundCfg.pre_para3, self._fundCfg.pre_para4)
end

function ActivityExplorationFundSingleFundData:GetSingleFundDataSeniorLockDes()
  return CheckCondition.GetUnlockInfoLua(self._fundCfg.pre_condition2, self._fundCfg.pre_para3, self._fundCfg.pre_para4)
end

function ActivityExplorationFundSingleFundData:GetSingleFundDataSeniorPrice()
  local payCtr = ControllerManager:GetController(ControllerTypeId.Pay)
  return payCtr:GetPayPriceShow(self._fundCfg.senior_price)
end

function ActivityExplorationFundSingleFundData:GetIsFundOver()
  return self._isFundOver
end

return ActivityExplorationFundSingleFundData
