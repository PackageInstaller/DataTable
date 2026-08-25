local MainPanelDailyTaskComp, Super = System.NewComponent("MainPanelDailyTaskComp")

function MainPanelDailyTaskComp:ctor(mainPanelUI)
  Super.ctor(self)
  self.ui = mainPanelUI
  self._updateCount = Vue.ref(0)
end

function MainPanelDailyTaskComp:OnBind(binder)
  self.binder = binder
  GlobalDispatcher:AddListener(NotifyId.OnDailyChallengeDataChanged, self._OnChallengeDataChanged, self)
  self.dailyTaskModel = binder:createModel(DailyTaskModel)
  binder:BindButtonClick(self.ui.Btn_Daily, System.fn(self, self._OnBtnDailyClick))
  self.binder:BindToRaw(function(cbinder)
    cbinder:BindToText(self.ui.Text_Daily, System.fn(self, self._GetDailyTaskText))
    cbinder:BindToSliderValue(self.ui.Slider_ActivityProgress, System.fn(self, self._GetDailyTextProgressValue))
    cbinder:BindToVisible(self.ui.Image_liuguang, System.fn(self, self._IsShowRewardEffect))
    self:_RefreshDailyTaskRed()
  end, function()
    return self._updateCount.value
  end)
  self:BindLockState(binder)
  binder:BindToRaw(function()
    self._updateCount.value = self._updateCount.value + 1
  end, function()
    local taskTid = DataCenter.taskData.dailyTaskTid
    local taskData = TaskDataUtils.GetTaskData(taskTid)
    return taskData.state
  end)
end

function MainPanelDailyTaskComp:OnUnbind()
  Super.OnUnbind(self)
  GlobalDispatcher:RemoveListener(NotifyId.OnDailyChallengeDataChanged, self._OnChallengeDataChanged, self)
end

function MainPanelDailyTaskComp:BindLockState(binder)
  binder:BindToRaw(function(_, locked)
    self.ui.Group_Daily_Lock:SetActive(locked)
  end, function()
    local isInUnlockQueue = PlayerDataUtils.IsBtnInUnlockQueue("Btn_Daily")
    local isLocked = self:_IsDailyTaskLocked()
    if isInUnlockQueue then
      return true
    end
    return isLocked
  end)
end

function MainPanelDailyTaskComp:_OnBtnDailyClick()
  local isLocked = self:_IsDailyTaskLocked()
  if isLocked then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.DailyTask, 0)
    return
  end
  TaskDataUtils.OpenDailyTaskView()
end

function MainPanelDailyTaskComp:_OnChallengeDataChanged()
  self._updateCount.value = self._updateCount.value + 1
end

function MainPanelDailyTaskComp:_IsDailyTaskLocked()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.DailyTask, 0)
  return not unlocked
end

function MainPanelDailyTaskComp:_GetDailyTaskText()
  local info = self:_GetCurShowInfo()
  if not info then
    do return LT.Text end
    return LT.Text, "ActivityTaskTotalFinished"
  end
  if info.tid == DataCenter.taskData.dailyTaskTid then
    do return LT.Text end
    return LT.Text, "ActivityTaskDailyTitle"
  end
  do return LT.Text end
  return LT.Text, "ActivityTaskWeeklyTitle"
end

function MainPanelDailyTaskComp:_GetDailyTextProgress()
  local info = self:_GetCurShowInfo()
  if not info then
    return ""
  end
  if info.tid == DataCenter.taskData.dailyTaskTid then
    do return string.format, "%d/%d", info.count, TaskDataUtils.GetTaskProgressLimit(info.tid) end
    return string.format, "%d/%d", info.count, TaskDataUtils.GetTaskProgressLimit(info.tid)
  end
  if info.score then
    local weekWinNum = DailyChallengeController.Instance:GetWeekWinNum()
    do return string.format, "%d/%d", (math.min(weekWinNum, info.score)) end
    return string.format, "%d/%d", math.min(weekWinNum, info.score), info.score, info.score
  end
end

function MainPanelDailyTaskComp:_GetDailyTextProgressValue()
  local info = self:_GetCurShowInfo()
  if not info then
    return 100
  end
  if info.tid == DataCenter.taskData.dailyTaskTid then
    return info.count / TaskDataUtils.GetTaskProgressLimit(info.tid) * 100
  end
  if info.score then
    print("-------------_GetDailyTextProgressValue", DailyChallengeController.Instance:GetWeekWinNum(), info.score, DailyChallengeController.Instance:GetWeekWinNum() / info.score)
    return DailyChallengeController.Instance:GetWeekWinNum() / info.score * 100
  end
  return 100
end

function MainPanelDailyTaskComp:_GetDailyShowList()
  local dailyList = {}
  table.insert(dailyList, TaskDataUtils.GetTaskData(DataCenter.taskData.dailyTaskTid))
  local weekRewardInfos = DailyChallengeController.Instance:GetWeekRewardInfos()
  for _, weekRewardInfo in ipairs(weekRewardInfos or {}) do
    table.insert(dailyList, weekRewardInfo)
  end
  return dailyList
end

function MainPanelDailyTaskComp:_GetCurShowDailyIndex()
  local dailyList = self:_GetDailyShowList()
  local rewardIndex, doingIndex
  for index, info in ipairs(dailyList) do
    if info.tid then
      if info.state == CommonDefine.TaskState.Receive then
        if not rewardIndex then
          rewardIndex = index
        end
      elseif info.state ~= CommonDefine.TaskState.Done and not doingIndex then
        doingIndex = index
      end
    elseif info.score then
      if info.state == CommonDefine.RewardState.Available then
        if not rewardIndex then
          rewardIndex = index
        end
      elseif info.state ~= CommonDefine.RewardState.Received and not doingIndex then
        doingIndex = index
      end
    end
  end
  return rewardIndex, doingIndex
end

function MainPanelDailyTaskComp:_GetCurShowInfo()
  local dailyList = self:_GetDailyShowList()
  local rewardIndex, doingIndex = self:_GetCurShowDailyIndex()
  if not rewardIndex and not doingIndex then
    return nil
  end
  return dailyList[rewardIndex or doingIndex]
end

function MainPanelDailyTaskComp:_IsShowRewardEffect()
  local rewardIndex, _ = self:_GetCurShowDailyIndex()
  return nil ~= rewardIndex
end

function MainPanelDailyTaskComp:_RefreshDailyTaskRed()
  local dailyTaskRed = RedPointDataUtils.GetDailyTaskRedPoint()
  local weekTaskRed = RedPointDataUtils.GetWeekTaskRedPoint()
  local isUnlocked = not self:_IsDailyTaskLocked()
  if (dailyTaskRed or weekTaskRed) and isUnlocked then
    self.binder:SetActive(self.ui.Com_RedDot_Daily, true)
    self.binder:SetActive(self.ui.Image_liuguang, true)
  else
    self.binder:SetActive(self.ui.Com_RedDot_Daily, false)
    self.binder:SetActive(self.ui.Image_liuguang, false)
  end
end

return MainPanelDailyTaskComp
