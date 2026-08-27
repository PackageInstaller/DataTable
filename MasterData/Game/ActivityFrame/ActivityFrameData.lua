local ActivityFrameData = class("ActivityFrameData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")

function ActivityFrameData.CreateActivityFrameData(activityElemMsg)
  local data = ActivityFrameData.New()
  data:__SetData(activityElemMsg)
  return data
end

function ActivityFrameData:UpdateActivityFrameData(newData)
  if self.id ~= newData.id then
    error("activity id is diff C:" .. tostring(self.activityId) .. " S:" .. tostring(newData.id))
    return
  end
  self:__SetData(newData)
end

function ActivityFrameData:__SetData(dataMsg)
  self.id = dataMsg.id
  self.actCat = dataMsg.actCat
  self.actId = dataMsg.actId
  self.lifeCat = dataMsg.lifeCat
  local diffTime = 0
  if self.lifeCat == ActivityFrameEnum.eActivityLiftType.ServerTime then
    diffTime = PlayerDataCenter.serverTm
  elseif self.lifeCat == ActivityFrameEnum.eActivityLiftType.RoleTime then
    diffTime = PlayerDataCenter.createRelativeTm
  end
  if dataMsg.tm ~= nil then
    self.bornTime = dataMsg.tm.bornTm ~= -1 and dataMsg.tm.bornTm + diffTime or -1
    self.startTime = dataMsg.tm.startTm ~= -1 and dataMsg.tm.startTm + diffTime or -1
    self.endTime = dataMsg.tm.endTm ~= -1 and dataMsg.tm.endTm + diffTime or -1
    self.rewardStartTime = dataMsg.tm.rewardStartTm ~= -1 and dataMsg.tm.rewardStartTm + diffTime or -1
    self.rewardEndTime = dataMsg.tm.rewardEndTm ~= -1 and dataMsg.tm.rewardEndTm + diffTime or -1
    self.destoryTime = dataMsg.tm.destoryTm ~= -1 and dataMsg.tm.destoryTm + diffTime or -1
    self.durationTm = dataMsg.tm.durationTm
  else
    self.bornTime = -1
    self.startTime = -1
    self.endTime = -1
    self.rewardStartTime = -1
    self.rewardEndTime = -1
    self.destoryTime = -1
    self.durationTm = -1
  end
  if self.destoryTime ~= -1 and (self.endTime == -1 or self.endTime > self.destoryTime) then
    self.endTime = self.destoryTime
    error(" rewardTime or destoryTime ERROR")
  end
  self.conditionKey = {}
  self.condition = {}
  self.conditionPara1 = {}
  self.conditionPara2 = {}
  if dataMsg.cond ~= nil and dataMsg.cond.data ~= nil then
    for _, data in ipairs(dataMsg.cond.data) do
      table.insert(self.condition, data.data[1])
      table.insert(self.conditionPara1, data.data[2] or 0)
      table.insert(self.conditionPara2, data.data[3] or 0)
      self.conditionKey[data.data[1]] = true
    end
  end
  self.enterType = dataMsg.ct.enterType
  self.order = dataMsg.ct.order
  self.previewTime = dataMsg.ct.preview or 0
  self.isPreviewType = self.previewTime ~= 0 and self.previewTime < self.bornTime
  local name = ActivityFrameUtil.GetActivityRealName(self.id)
  local nameCfg = ConfigData.activity_name[dataMsg.ct.nameId]
  if string.IsNullOrEmpty(LanguageUtil.GetLocaleText(name)) then
    name = nameCfg ~= nil and nameCfg.name
  end
  self.name = not string.IsNullOrEmpty(LanguageUtil.GetLocaleText(name)) and LanguageUtil.GetLocaleText(name) or tostring(dataMsg.ct.nameId)
  self.icon = nameCfg ~= nil and nameCfg.icon or nil
end

function ActivityFrameData.CreateActivityFrameDataFromFakeData(fakeData)
  local data = ActivityFrameData.New()
  data.id = fakeData.id
  data.actCat = fakeData.actCat
  data.actId = fakeData.actId
  data.bornTime = -1
  data.startTime = -1
  data.endTime = -1
  data.rewardStartTime = -1
  data.rewardEndTime = -1
  data.destoryTime = -1
  data.durationTm = -1
  data.enterType = fakeData.enterType
  data.order = fakeData.order
  local nameCfg = ConfigData.activity_name[fakeData.id]
  data.name = LanguageUtil.GetLocaleText(nameCfg.name)
  data.icon = nameCfg.icon
  return data
end

function ActivityFrameData:ctor()
  self._unlockTempActivityState = ActivityFrameEnum.eActivityState.WaitState
  self._activityState = ActivityFrameEnum.eActivityState.WaitState
end

function ActivityFrameData:GetActivityFrameId()
  return self.id
end

function ActivityFrameData:GetActId()
  return self.actId
end

function ActivityFrameData:GetActivityFrameCat()
  return self.actCat
end

function ActivityFrameData:GetEnterType()
  return self.enterType
end

function ActivityFrameData:GetActivityFrameName()
  return self.name
end

function ActivityFrameData:GetActivityStartTime()
  return self.startTime
end

function ActivityFrameData:GetActivityEndTime()
  return self.endTime
end

function ActivityFrameData:GetActivityRewardEndTime()
  return self.rewardEndTime
end

function ActivityFrameData:GetActivityRewardStartTime()
  return self.rewardStartTime
end

function ActivityFrameData:IsPreviewType()
  return self.isPreviewType
end

function ActivityFrameData:GetActivityBornTime()
  return self.bornTime
end

function ActivityFrameData:GetActivityDestroyTime()
  return self.destoryTime
end

function ActivityFrameData:GetActivityPreviewTime()
  return self.previewTime
end

function ActivityFrameData:GetLockTip(noNeedTimeTip)
  if self._conditionDes ~= nil then
    return self._conditionDes
  end
  local timeTip
  local checker = CheckerGlobalConfig[CheckerTypeId.TimeRange]
  if checker ~= nil and checker.Checker ~= nil then
    timeTip = checker.Checker.GetUnlockInfo({
      CheckerTypeId.TimeRange,
      self.bornTime,
      self.destoryTime
    })
  end
  if self.condition == nil or #self.condition == 0 then
    self._conditionDes = timeTip
  else
    self._conditionDes = CheckCondition.GetUnlockInfoLua(self.condition, self.conditionPara1, self.conditionPara2)
    if not string.IsNullOrEmpty(timeTip) and not noNeedTimeTip then
      self._conditionDes = self._conditionDes .. "\n" .. timeTip
    end
  end
  return self._conditionDes
end

function ActivityFrameData:GetIsActivityLocked()
  return self._unlockTempActivityState ~= nil
end

function ActivityFrameData:IsActivityOpen()
  return self._activityState >= ActivityFrameEnum.eActivityState.OpenState and self._activityState < ActivityFrameEnum.eActivityState.DestroyState
end

function ActivityFrameData:GetIsActivityFinished()
  return self._activityState >= ActivityFrameEnum.eActivityState.DestroyState
end

function ActivityFrameData:IsActivityRunningTimeout()
  return self._activityState > ActivityFrameEnum.eActivityState.OpenState
end

function ActivityFrameData:GetCouldShowActivity()
  return self._activityState > ActivityFrameEnum.eActivityState.WaitState and self._activityState < ActivityFrameEnum.eActivityState.DestroyState
end

function ActivityFrameData:GetActivityFrameState()
  return self._activityState
end

function ActivityFrameData:IsInPreviewState()
  return self._activityState == ActivityFrameEnum.eActivityState.PreviewState
end

function ActivityFrameData:IsInRuningState()
  return self._activityState == ActivityFrameEnum.eActivityState.OpenState
end

function ActivityFrameData:CanPreviewNoExchange()
  return self._activityState > ActivityFrameEnum.eActivityState.WaitState and self._activityState < ActivityFrameEnum.eActivityState.RewardState
end

function ActivityFrameData:GetActivityReddotNode()
  return self._reddot
end

function ActivityFrameData:IsActivityReadOnLogin()
  return self.__isReadOnLogin
end

function ActivityFrameData:SetActivityAsReadOnLogin()
  self.__isReadOnLogin = true
end

function ActivityFrameData:GetIsActivityUnlockForFrameCtrl()
  if self._forceOpen then
    return true
  end
  if self.condition == nil or #self.condition == 0 then
    return true
  end
  return CheckCondition.CheckLua(self.condition, self.conditionPara1, self.conditionPara2)
end

function ActivityFrameData:SetIsActivityUnlockForFrameCtrl()
  self._activityState = self._unlockTempActivityState
  self._unlockTempActivityState = nil
end

function ActivityFrameData:SetActivityStateForFrameCtrl(actState)
  if self._unlockTempActivityState ~= nil then
    self._unlockTempActivityState = actState
  else
    self._activityState = actState
  end
end

function ActivityFrameData:SetActivityReddotForFrameCtrl(reddotNode)
  self._reddot = reddotNode
end

function ActivityFrameData:IsHaveThisConditionForFrameCtrl(conditionId)
  return self.conditionKey ~= nil and self.conditionKey[conditionId] ~= nil
end

function ActivityFrameData:SetForceOpenForFrameCtrl(flag)
  self._forceOpen = flag
end

function ActivityFrameData:SetActivityData(data)
  self.__actBaseData = data
end

function ActivityFrameData:GetActivityData()
  return self.__actBaseData
end

function ActivityFrameData:ResetFinishTmForFrameCtrl(startTm, endTm)
  self.rewardEndTime = endTm
  self.endTime = endTm
  self.destoryTime = endTm
  self.bornTime = startTm
  self.startTime = startTm
  self.durationTm = -1
end

function ActivityFrameData:GetDurationTmForFrameCtrl()
  return self.durationTm
end

return ActivityFrameData
