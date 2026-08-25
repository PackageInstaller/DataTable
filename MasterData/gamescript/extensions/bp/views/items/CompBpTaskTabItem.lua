local TaskServerIndex = CommonDefine.TaskServerIndex
local CompBpTaskTabItem, Super = NewViewComponent("CompBpTaskTabItem")

function CompBpTaskTabItem:ctor(uiNode, view, taskServerIdx)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Passport_Task_ChooseResource(uiNode)
  self.taskServerIdx = taskServerIdx
  self.taskTabName2KeyMap = {
    [TaskServerIndex.Daily] = "BPTaskSubTabDaily",
    [TaskServerIndex.Weekly] = "BPTaskSubTabMonthly",
    [TaskServerIndex.Period] = "BPTaskSubTabPeriod"
  }
end

function CompBpTaskTabItem:OnEnterComponent()
  self:_InitUIElements()
  self:_RefreshUIState()
end

function CompBpTaskTabItem:_InitUIElements()
  self:SetText(self.ui.Text_Name, LT.Text(self.taskTabName2KeyMap[self.taskServerIdx]))
  self:_RefreshCountDown()
  self.countDownTimer = self:BindTimer(1, -1, function()
    self:_RefreshCountDown()
  end)
  self:SetActive(self.ui.Text_Time, BpTaskModel.Instance:GetTaskGroupCountDown(self.taskServerIdx) ~= "")
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self.OnClickBtn))
end

function CompBpTaskTabItem:_RefreshCountDown()
  self:SetText(self.ui.Text_Time, BpTaskModel.Instance:GetTaskGroupCountDown(self.taskServerIdx))
end

function CompBpTaskTabItem:_RefreshUIState()
  self:SetActive(self.ui.Image_Select, self.taskServerIdx == BpTaskModel.Instance.curSelectTab)
  self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, nil, function()
    do return RedPointDataUtils.IsShowTaskReceiveRedDot end
    return RedPointDataUtils.IsShowTaskReceiveRedDot, {
      self.taskServerIdx
    }, self.taskServerIdx
  end)
  if BattlePassDataUtils.IsDoubleEx() then
    self:SetActive(self.ui.Group_Tag_Double, true)
    self:SetText(self.ui.Text_C_Double, LT.Text("DoubleExperience_01"))
  else
    self:SetActive(self.ui.Group_Tag_Double, false)
  end
end

function CompBpTaskTabItem:OnClickBtn()
  BpTaskModel.Instance:SetCurSelectTab(self.taskServerIdx)
end

function CompBpTaskTabItem:OnExitComponent()
  if self.countDownTimer then
    self:StopTimer(self.countDownTimer)
    self.countDownTimer = nil
  end
  Super.OnExitComponent(self)
end

return CompBpTaskTabItem
