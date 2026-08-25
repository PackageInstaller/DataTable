local DailyTaskPanel, Super = System.NewClass("DailyTaskPanel", UIBasePanel)
DailyTaskPanel.uiResCls = UI_Main_Daily_TipsResource

function DailyTaskPanel:ctor(dailyTaskModel)
  Super.ctor(self)
  self.dailyTaskModel = dailyTaskModel
end

function DailyTaskPanel:OnBind(binder)
  if self.dailyTaskModel then
    self:_SetupUI(binder)
  else
    self.dailyTaskModel = binder:createModel(DailyTaskModel)
    self.dailyTaskModel:RequestTaskInfo(function()
      self:_SetupUI(binder)
    end)
    self.needUnlisteningEvent = true
  end
end

function DailyTaskPanel:_SetupUI(binder)
  local cfg = DT.Task[self.dailyTaskModel.taskTid]
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    if self.ui.Image_Description.activeSelf then
      self.ui.Image_Description:SetActive(false)
    else
      self:Close()
    end
  end)
  binder:SetText(self.ui.Text_Task_Name, LT.Text(cfg.Name))
  if self.timerID then
    TimerManager.Instance:StopTimer(self.timerID)
    self.timerID = nil
  end
  local countdown = self.dailyTaskModel.endTime - TimeUtils.GetServerTime()
  self.timerID = TimerManager.Instance:CreateTimer(0.033, -1, function()
    countdown = math.max(countdown - 0.033, 0)
    local h, m = TimeUtils.SecToHourMin(countdown)
    binder:SetText(self.ui.Text_Flushed, LT.Textf("Task_Dispatch_Hour", h, m))
  end)
  binder:SetText(self.ui.Text_Premise, LT.Text(cfg.Desc))
  binder:SetText(self.ui.Text_Bracket_Left, "(")
  binder:SetText(self.ui.Text_Bracket_Right, ")")
  binder:SetText(self.ui.Text_Progress, self.dailyTaskModel.currValue .. "/")
  binder:SetText(self.ui.Text_Foundation, self.dailyTaskModel.maxValue)
  binder:SetSliderMaxValue(self.ui.Slider_Buy, self.dailyTaskModel.maxValue)
  binder:SetSliderCurValue(self.ui.Slider_Buy, self.dailyTaskModel.currValue)
  local itemGO = {
    self.ui.WuPin_Type_1,
    self.ui.WuPin_Type_2,
    self.ui.WuPin_Type_3,
    self.ui.WuPin_Type_4
  }
  for idx, go in ipairs(itemGO) do
    local itemIdx = idx * 2 - 1
    local itemTid = cfg.CompleteAward[itemIdx]
    if itemTid then
      local itemCnt = cfg.CompleteAward[itemIdx + 1]
      binder:BindComponent(CommonIconItemType2(go, {
        itemTid = itemTid,
        itemCount = itemCnt,
        isGot = self.dailyTaskModel.taskState == CommonDefine.TaskCommonState.Finish
      }))
      go:SetActive(true)
    else
      go:SetActive(false)
    end
  end
  self.ui.Image_Line_3:SetActive(self.dailyTaskModel.taskState == CommonDefine.TaskCommonState.Finish)
  self.ui.Btn_Confirm:SetActive(self.dailyTaskModel.taskState ~= CommonDefine.TaskCommonState.Finish)
  self.ui.Image_Description:SetActive(false)
  binder:BindZ1Button(self.ui.Btn_Confirm, function()
    if self.dailyTaskModel.taskState ~= CommonDefine.TaskCommonState.CanFinish then
      self.ui.Image_Description:SetActive(true)
    else
      UIManager.Instance:CloseByUrl(Urls.DailyTaskOverItemTipPanel)
      self.dailyTaskModel:RequestGainTaskReward(true)
      self:Close()
    end
  end, nil, function()
    if self.dailyTaskModel.taskState ~= CommonDefine.TaskCommonState.CanFinish then
      do return LT.Text end
      return LT.Text, "GoTo"
    end
    do return LT.Text end
    return LT.Text, "CommonReceive"
  end)
  local navBtn = {
    self.ui.Image_Exchange_1,
    self.ui.Image_Exchange_2,
    self.ui.Image_Exchange_3
  }
  for idx, btn in ipairs(navBtn) do
    local itemGetsId = cfg.JumpTo[idx]
    if itemGetsId then
      binder:BindComponent(CommonApproachItem(btn, {
        itemGetsId = itemGetsId,
        clickCb = function()
          self.ui.Image_Description:SetActive(false)
        end
      }))
      btn:SetActive(true)
    else
      btn:SetActive(false)
    end
  end
end

function DailyTaskPanel:DestroyUI()
  Super.DestroyUI(self)
  if self.timerID then
    TimerManager.Instance:StopTimer(self.timerID)
    self.timerID = nil
  end
end

return DailyTaskPanel
