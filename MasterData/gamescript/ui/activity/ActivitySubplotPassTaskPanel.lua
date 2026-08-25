local ActivitySubplotPassTaskPanel, Super = System.NewClass("ActivitySubplotPassTaskPanel", UIBasePanel)
ActivitySubplotPassTaskPanel.uiResCls = UI_Main_Daily_TipsResource

function ActivitySubplotPassTaskPanel:ctor(taskData, activityEndTime, onClickConfirm)
  Super.ctor(self)
  self.taskData = taskData
  self.activityEndTime = activityEndTime
  self.onClickConfirm = onClickConfirm
end

function ActivitySubplotPassTaskPanel:OnBind(binder)
  local cfg = DT.Task[self.taskData.tid]
  self.ui.Group_Task:SetActive(false)
  self.ui.Group_Activity:SetActive(true)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
  binder:SetText(self.ui.Text_Task_Name, LT.Text(cfg.Name))
  if self.timerID then
    TimerManager.Instance:StopTimer(self.timerID)
    self.timerID = nil
  end
  local countdown = self.activityEndTime - TimeUtils.GetServerTime()
  self.timerID = TimerManager.Instance:CreateTimer(0.033, -1, function()
    if self.ui then
      countdown = math.max(countdown - 0.033, 0)
      local d, h = TimeUtils.SecToDayHour(countdown)
      binder:SetText(self.ui.Text_Flushed, LT.Textf("BattlePassLeftTimeMore", d, h))
    else
      TimerManager.Instance:StopTimer(self.timerID)
      self.timerID = nil
    end
  end)
  binder:SetText(self.ui.Text_Activity, LT.Text(cfg.Desc))
  binder:SetText(self.ui.Text_Bracket_Left_1, "(")
  binder:SetText(self.ui.Text_Bracket_Right_1, ")")
  binder:SetText(self.ui.Text_Progress_1, self.taskData.count .. "/")
  binder:SetText(self.ui.Text_Foundation_1, TaskDataUtils.GetTaskProgressLimit(self.taskData.tid))
  local itemGO = {
    self.ui.Activity_WuPin_Type_1,
    self.ui.Activity_WuPin_Type_2,
    self.ui.Activity_WuPin_Type_3
  }
  for idx, go in ipairs(itemGO) do
    local itemIdx = idx * 2 - 1
    local itemTid = cfg.CompleteAward[itemIdx]
    if itemTid then
      local itemCnt = cfg.CompleteAward[itemIdx + 1]
      binder:BindComponent(CommonIconItemType2(go, {
        itemTid = itemTid,
        itemCount = itemCnt,
        isGot = self.taskData.state == CommonDefine.TaskCommonState.Finish
      }))
      go:SetActive(true)
    else
      go:SetActive(false)
    end
  end
  self.ui.Image_Line_3:SetActive(false)
  self.ui.Image_Line_5:SetActive(true)
  self.ui.Btn_Confirm:SetActive(self.taskData.state ~= CommonDefine.TaskCommonState.Finish)
  binder:BindZ1Button(self.ui.Btn_Confirm, function()
    self.onClickConfirm()
  end, nil, function()
    do return LT.Text end
    return LT.Text, "GoTo"
  end)
end

function ActivitySubplotPassTaskPanel:DestroyUI()
  Super.DestroyUI(self)
  if self.timerID then
    TimerManager.Instance:StopTimer(self.timerID)
    self.timerID = nil
  end
end

return ActivitySubplotPassTaskPanel
