local WorldStageTimeoutComp = System.NewComponent("WorldStageTimeoutComp")

function WorldStageTimeoutComp:ctor(stageComp)
  self.stageComp = stageComp
  self.timeout = nil
  self.isPause = false
  self.isStop = false
  self.groupType = nil
end

function WorldStageTimeoutComp:OnBind(binder)
  self.binder = binder
  self.binder:BindTimer(2, -1, System.fn(self, self.Update))
  self.binder:BindEvent(EventMgr.Instance.BattleStart, System.fn(self, self.OnBattleStart))
  self.binder:BindEvent(EventMgr.Instance.BattleEvent, System.fn(self, self.OnBattleEvent))
end

function WorldStageTimeoutComp:Update()
  if not self.timeout then
    return
  end
  if self.isPause then
    return
  end
  if self.isStop then
    return
  end
  if TimeUtils.GetServerTime() > self.timeout then
    self.isStop = true
    if WorldRecoveryManager.Instance:IsWaitingAbyssResetConfirm() then
      Logger.Info("[AbyssReset] WorldStageTimeoutComp: reset tips already showing, skip duplicate, stageGroupId=%s", tostring(self.stageGroupId))
    elseif self.groupType == cd.StageGroupType.AbyssChallenge then
      WorldRecoveryManager.Instance:ShowAbyssResetTipsByStageGroupId(self.stageGroupId)
    else
      Alert.Show(20158, nil, function()
        WorldStageManager.Instance:ReqExit(self.stageGroupId)
      end)
    end
  end
end

function WorldStageTimeoutComp:OnBattleStart()
  self.isPause = true
  self.binder:BindTimer(5, 0, nil, function()
    self.isPause = false
  end)
end

function WorldStageTimeoutComp:OnBattleEvent(eventType)
  if eventType == rc.BattleEvent.BattleBeginAnimDone then
    self.isPause = false
  end
end

function WorldStageTimeoutComp:CalTimeout(stageGroupId, createTime)
  if not stageGroupId or not createTime then
    return
  end
  self.stageGroupId = stageGroupId
  self.createTime = createTime
  local stageGroupCfg = DT.StageGroup[stageGroupId]
  local groupType = stageGroupCfg.Type
  self.groupType = groupType
  if groupType == cd.StageGroupType.WeekBoss then
    self.timeout = self:CalWeekBossTimeout(createTime)
  elseif groupType == cd.StageGroupType.AbyssChallenge then
    self.timeout = self:CalAbyssTimeout(createTime)
  end
  if not self.timeout then
    for cfgGroupType, actType in table.iteraDouble(DT.GetOriginalConstant("ActivityStageExpirationRemind") or {}) do
      if cfgGroupType == groupType then
        local timeout = ActivityManager.Instance:GetCurRoundActivityEndTime(createTime, actType)
        self.timeout = timeout
        break
      end
    end
  end
  if self.timeout then
    local date = TimeUtils.GetServerDate(self.timeout)
    print("------------------timeout date", date.year, date.month, date.day, date.hour)
  end
end

function WorldStageTimeoutComp:CalWeekBossTimeout(createTime)
  local date = TimeUtils.GetServerDate(createTime)
  local monday = 1
  local nineHour = 9
  local weekDay = date.wday - 1
  if 0 == weekDay then
    weekDay = 7
  end
  local leftDay = 0
  if weekDay == monday and nineHour > date.hour then
    leftDay = 0
  else
    leftDay = monday + 7 - weekDay
  end
  local timeoutDate = {
    year = date.year,
    month = date.month,
    day = date.day + leftDay,
    hour = nineHour,
    minute = 0,
    second = 0
  }
  do return TimeUtils.GetTimeFromServerDate end
  return TimeUtils.GetTimeFromServerDate, timeoutDate
end

function WorldStageTimeoutComp:CalAbyssTimeout(createTime)
  local type = ActivityDefine.ActivityType.Abyss
  local timeOut = ActivityManager.Instance:GetCurRoundActivityEndTime(createTime, type)
  return timeOut
end

return WorldStageTimeoutComp
