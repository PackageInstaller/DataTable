local ActivitySubplotStageTaskPanel, Super = System.NewClass("ActivitySubplotStageTaskPanel", UIBasePanel)
ActivitySubplotStageTaskPanel.uiResCls = UI_Events_Stage_TipResource

function ActivitySubplotStageTaskPanel:ctor(taskTidList, taskDataList, activityEndTime, onGainPrize)
  Super.ctor(self)
  self.taskTidList = taskTidList
  self.taskDataList = taskDataList
  self.activityEndTime = activityEndTime
  self.onGainPrize = onGainPrize
end

function ActivitySubplotStageTaskPanel:OnBind(binder)
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, function()
    self:Close()
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
  if self.timerID then
    TimerManager.Instance:StopTimer(self.timerID)
    self.timerID = nil
  end
  local countdown = self.activityEndTime - TimeUtils.GetServerTime()
  self:_SetCountdown(binder, countdown)
  self.timerID = TimerManager.Instance:CreateTimer(0.033, -1, function()
    if self.ui then
      countdown = math.max(countdown - 0.033, 0)
      self:_SetCountdown(binder, countdown)
    else
      TimerManager.Instance:StopTimer(self.timerID)
      self.timerID = nil
    end
  end)
  local taskTidOrder = {}
  for order, taskTid in ipairs(self.taskTidList) do
    taskTidOrder[taskTid] = order
  end
  local sortedTaskDataList = {}
  for _, taskData in pairs(self.taskDataList) do
    if taskTidOrder[taskData.tid] then
      table.insert(sortedTaskDataList, taskData)
    end
  end
  local TaskCommonState = CommonDefine.TaskCommonState
  table.sort(sortedTaskDataList, function(a, b)
    if a.state == TaskCommonState.CanFinish and b.state ~= TaskCommonState.CanFinish then
      return true
    end
    if a.state ~= TaskCommonState.CanFinish and b.state == TaskCommonState.CanFinish then
      return false
    end
    if a.state == TaskCommonState.Running and b.state ~= TaskCommonState.Running then
      return true
    end
    if a.state ~= TaskCommonState.Running and b.state == TaskCommonState.Running then
      return false
    end
    return taskTidOrder[a.tid] < taskTidOrder[b.tid]
  end)
  binder:BindToCircularListView(self.ui.ScrollView, function()
    return sortedTaskDataList
  end, function(itemBinder, obj, index)
    itemBinder:BindComponent(ActivitySubplotStageTaskItem(obj, sortedTaskDataList[index], self.onGainPrize))
  end)
end

function ActivitySubplotStageTaskPanel:_SetCountdown(binder, countdown)
  local desc = ""
  if countdown > 0 then
    desc = TimeUtils.ActivityCountDownFormat(countdown)
  else
    desc = LT.Text("ActivityTimeExpired")
  end
  binder:SetText(self.ui.Text_Time, desc)
end

function ActivitySubplotStageTaskPanel:DestroyUI()
  Super.DestroyUI(self)
  if self.timerID then
    TimerManager.Instance:StopTimer(self.timerID)
    self.timerID = nil
  end
end

return ActivitySubplotStageTaskPanel
