local base = require("Game.ActivityFrame.ActivityBase")
local ActivitySaveMoneyData = class("ActivitySaveMoneyData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivitySaveMoneyEnum = require("Game.ActivitySaveMoney.Enum.ActivitySaveMoneyEnum")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local CurActType = ActivityFrameEnum.eActivityType.SaveMoney
local __InitActivityFunc = {
  [ActivitySaveMoneyEnum.SaveMoneyActivityState.saveState] = function(self, msg)
    self.updateTimeDirty = true
  end,
  [ActivitySaveMoneyEnum.SaveMoneyActivityState.getState] = function(self, msg)
    if self.lastUpdateStage ~= self.currentStage then
      self.updateTimeDirty = true
    end
    self.lastUpdateStage = self.currentStage
    local currentRewardCfg = self:GetSaveMoneySelectedLevelCfg()
    for iStage = 1, #currentRewardCfg do
      if iStage < self.currentStage then
        self.selectLevelStageStateList[iStage] = ActivitySaveMoneyEnum.SaveMoneyStageState.expire
      elseif iStage == self.currentStage then
        self.selectLevelStageStateList[iStage] = ActivitySaveMoneyEnum.SaveMoneyStageState.canGet
      else
        self.selectLevelStageStateList[iStage] = ActivitySaveMoneyEnum.SaveMoneyStageState.lock
      end
    end
    for gotStageId, gotType in ipairs(msg.gotStage) do
      if msg.gotStage[gotStageId] == 1 then
        self.selectLevelStageStateList[gotStageId] = ActivitySaveMoneyEnum.SaveMoneyStageState.gotten
      end
    end
  end,
  [ActivitySaveMoneyEnum.SaveMoneyActivityState.expire] = function(self, msg)
    local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    activityCtrl:HideActivityByExtraLogic(CurActType, self.actId)
  end
}

function ActivitySaveMoneyData:InitActivitySaveMoneyDataByMsg(msg)
  self.actId = msg.actId
  self.saveLevel = msg.saveLevel
  self:SetActFrameDataByType(CurActType, self.actId)
  self._mainCfg = ConfigData.activity_saveMoney_main[self.actId]
  self._rewardsCfg = ConfigData.activity_saveMoney_rewards[self.actId]
  self._saveCfg = ConfigData.activity_saveMoney_save[self.actId]
  self.selectLevelStageStateList = {}
  self.currentStage = self:GetSaveMoneyCurrentStage()
  local currentTm = PlayerDataCenter.timestamp
  if self.currentStage ~= nil then
    if currentTm < self._mainCfg.reward_end_time then
      self.currentState = ActivitySaveMoneyEnum.SaveMoneyActivityState.getState
    else
      self.currentState = ActivitySaveMoneyEnum.SaveMoneyActivityState.expire
    end
  elseif currentTm < self._mainCfg.save_end_time then
    self.currentState = ActivitySaveMoneyEnum.SaveMoneyActivityState.saveState
  else
    self.currentState = ActivitySaveMoneyEnum.SaveMoneyActivityState.expire
  end
  if __InitActivityFunc[self.currentState] ~= nil then
    __InitActivityFunc[self.currentState](self, msg)
  else
    return
  end
  self:__UpdateSaveMoney()
end

function ActivitySaveMoneyData:__UpdateSaveMoney()
  self:__UpdateSaveMoneyRedDot()
end

function ActivitySaveMoneyData:__UpdateSaveMoneyRedDot()
  self:__RefreshRedDotLooked()
  self:__RefreshRedDotReward()
end

function ActivitySaveMoneyData:__RefreshRedDotLooked()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySaveMoneyEnum.RedDotType.redDotLooked)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  if not saveUserData:GetSaveMoneyLooked(self:GetActId()) then
    childReddot:SetRedDotCount(1)
    return
  end
  childReddot:SetRedDotCount(0)
end

function ActivitySaveMoneyData:__RefreshRedDotReward()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySaveMoneyEnum.RedDotType.redDotReward)
  local flag = self:GetSaveMoneyCanPickReward()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySaveMoneyData:GetSaveMoneyMainCfg()
  return self._mainCfg
end

function ActivitySaveMoneyData:GetSaveMoneyRewardsCfg()
  return self._rewardsCfg
end

function ActivitySaveMoneyData:GetSaveMoneySaveCfg()
  return self._saveCfg
end

function ActivitySaveMoneyData:GetSaveMoneyActivityState()
  return self.currentState
end

function ActivitySaveMoneyData:GetSaveMoneyCanPickReward()
  for _, stageState in ipairs(self.selectLevelStageStateList) do
    if stageState == ActivitySaveMoneyEnum.SaveMoneyStageState.canGet then
      return true
    end
  end
  return false
end

function ActivitySaveMoneyData:GetSaveMoneySelectedLevelCfg()
  return self._rewardsCfg[self.saveLevel]
end

function ActivitySaveMoneyData:GetSaveMoneyNextStateChangeTm()
  if self.currentState == ActivitySaveMoneyEnum.SaveMoneyActivityState.saveState then
    return self._mainCfg.save_end_time
  end
  if self.currentState == ActivitySaveMoneyEnum.SaveMoneyActivityState.getState then
    if self.currentStage == 0 then
      local currentStageCfg = self:GetSaveMoneySelectedLevelCfg()[1]
      if currentStageCfg ~= nil then
        return currentStageCfg.start_time
      end
    end
    local currentStageCfg = self:GetSaveMoneySelectedLevelCfg()[self.currentStage]
    if currentStageCfg ~= nil then
      return currentStageCfg.end_time
    end
  end
  return 0
end

function ActivitySaveMoneyData:GetSaveMoneyStageState(stageId)
  return self.selectLevelStageStateList[stageId]
end

function ActivitySaveMoneyData:GetSaveMoneyCurrentStage()
  local selectedCfg = self:GetSaveMoneySelectedLevelCfg()
  if selectedCfg == nil then
    return nil
  end
  local currentStage = 0
  local currentTm = PlayerDataCenter.timestamp
  for iStage, rewardCfg in ipairs(selectedCfg) do
    if currentTm < rewardCfg.start_time then
      return currentStage
    else
      currentStage = currentStage + 1
    end
    if currentTm < rewardCfg.end_time then
      return currentStage
    end
  end
  return #selectedCfg + 1
end

function ActivitySaveMoneyData:GetSaveMoneyCountDownTime()
  return self:GetSaveMoneyCountDownTimeByState(self.currentState)
end

function ActivitySaveMoneyData:GetSaveMoneyCountDownTimeByState(state)
  local nextTime
  if state == ActivitySaveMoneyEnum.SaveMoneyActivityState.saveState then
    nextTime = self._mainCfg.save_end_time
  else
    nextTime = self._mainCfg.reward_end_time
  end
  return ActivityFrameUtil.GetCountdownTimeStr(nextTime)
end

function ActivitySaveMoneyData:GetSaveMoneyCountDownTimeReward(level, stageId, isShortStr)
  local stageCfg = self:GetSaveMoneyRewardsCfg()[level][stageId]
  if stageCfg ~= nil then
    return ActivityFrameUtil.GetCountdownTimeStr(stageCfg.start_time, isShortStr)
  end
  return nil
end

function ActivitySaveMoneyData:GetSaveMoneyStateStartEndTime()
  return self:GetSaveMoneyStateStartEndTimeByState(self.currentState)
end

function ActivitySaveMoneyData:GetSaveMoneyStateStartEndTimeByState(state)
  local startTm, endTm
  if state == ActivitySaveMoneyEnum.SaveMoneyActivityState.saveState then
    startTm = self._mainCfg.save_start_time
    endTm = self._mainCfg.save_end_time
  else
    startTm = self._mainCfg.reward_start_time
    endTm = self._mainCfg.reward_end_time
  end
  local startTimeStr, endTimeStr
  local startTimeTable = TimeUtil:TimestampToDate(startTm, false, true)
  startTimeStr = string.format("%02d/%02d %02d:%02d", startTimeTable.month, startTimeTable.day, startTimeTable.hour, startTimeTable.min)
  local endTimeTable = TimeUtil:TimestampToDate(endTm, false, true)
  endTimeStr = string.format("%02d/%02d %02d:%02d", endTimeTable.month, endTimeTable.day, endTimeTable.hour, endTimeTable.min)
  return startTimeStr, endTimeStr
end

function ActivitySaveMoneyData:GetSaveMoneyStageStartEndTime(level, stage)
  local levelCfg = self._rewardsCfg[level]
  if levelCfg == nil then
    return nil, nil
  end
  local rewardCfg = levelCfg[stage]
  if rewardCfg == nil then
    return nil, nil
  end
  local startTm = rewardCfg.start_time
  local endTm = rewardCfg.end_time
  local startTimeStr, endTimeStr
  local startTimeTable = TimeUtil:TimestampToDate(startTm, false, true)
  startTimeStr = string.format("%02d/%02d %02d:%02d", startTimeTable.month, startTimeTable.day, startTimeTable.hour, startTimeTable.min)
  local endTimeTable = TimeUtil:TimestampToDate(endTm, false, true)
  endTimeStr = string.format("%02d/%02d %02d:%02d", endTimeTable.month, endTimeTable.day, endTimeTable.hour, endTimeTable.min)
  return startTimeStr, endTimeStr
end

function ActivitySaveMoneyData:SetSaveMoneyUILooked()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetSaveMoneyLooked(self:GetActId())
  self:__UpdateSaveMoney()
end

function ActivitySaveMoneyData:SetSaveMoneyCantPopToday()
  local time = TimeUtil:TimestampToDate(math.floor(TimeUtil:TimpApplyLogicOffset(PlayerDataCenter.timestamp)))
  time.hour = 0
  time.min = 0
  time.sec = 0
  local cantShowTime = TimeUtil:DateToTimestamp(time) + 86400 + 3600 * TimeUtil:GetDayPassTime()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetSaveMoneyCantShowTime(self:GetActId(), cantShowTime)
  self:__UpdateSaveMoney()
end

function ActivitySaveMoneyData:IsSaveMoneyCanPop()
  if self:GetSaveMoneyActivityState() == ActivitySaveMoneyEnum.SaveMoneyActivityState.expire then
    return false
  end
  if self:GetSaveMoneyActivityState() == ActivitySaveMoneyEnum.SaveMoneyActivityState.getState and not self:GetSaveMoneyCanPickReward() then
    return false
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return saveUserData:GetSaveMoneyCanPop(self:GetActId())
end

return ActivitySaveMoneyData
