local UIAnimationController = CS.Z1Client.UIAnimationController
local MainShopMonthCardRewardPanel, Super = System.NewClass("MainShopMonthCardRewardPanel", UIBasePanel)
MainShopMonthCardRewardPanel.uiResCls = UI_Recharge_Panel_Month_TipsResource

function MainShopMonthCardRewardPanel:ctor(expiredTimestamp, closeCallback)
  Super.ctor(self)
  self.expiredTimestamp = expiredTimestamp
  self.closeCallback = closeCallback
end

function MainShopMonthCardRewardPanel:OnBind(binder)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.uiAnimController:PlayMultiState("UI_Recharge_Panel_Month_Tips_Open,UI_Recharge_Panel_Month_Tips_Loop", function()
    self:_LoopAnimation()
  end, 1, false)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:_StopLoopAnimation()
    self.uiAnimController:PlayMultiState("UI_Recharge_Panel_Month_Tips_Receive", function()
      self:Close()
    end, 1, false)
  end)
  self.monthCardCountdown = self.expiredTimestamp - TimeUtils.GetServerTime()
  self:_SetMonthCardCountdown(binder, self.monthCardCountdown)
  self.timerID = TimerManager.Instance:CreateTimer(0.033, -1, function()
    self.monthCardCountdown = self.monthCardCountdown - 0.033
    self:_SetMonthCardCountdown(binder, self.monthCardCountdown)
  end)
end

function MainShopMonthCardRewardPanel:_LoopAnimation()
  if self.stopLoopAnimation then
    return
  end
  self.uiAnimController:PlayMultiState("UI_Recharge_Panel_Month_Tips_Loop", function()
    self:_LoopAnimation()
  end, 1, false)
end

function MainShopMonthCardRewardPanel:_StopLoopAnimation()
  self.stopLoopAnimation = true
end

function MainShopMonthCardRewardPanel:_SetMonthCardCountdown(binder, countdown)
  local remainingDays = 0
  if countdown > 0 then
    remainingDays = TimeUtils.SecsToDays(countdown)
  end
  local code = DT.ColorConfig.MonthCard.Light
  local str = string.format("<color=%s>%s</color>", code, remainingDays)
  binder:SetText(self.ui.Text_Effecting, LT.Textf("MonthCardLeftDaysText", str))
end

function MainShopMonthCardRewardPanel:Close()
  Super.Close(self)
  if self.closeCallback then
    self.closeCallback()
  end
  PopupQueManager.Instance:SetBusy(false)
end

function MainShopMonthCardRewardPanel:DestroyUI()
  Super.DestroyUI(self)
  if self.timerID then
    TimerManager.Instance:StopTimer(self.timerID)
    self.timerID = nil
  end
end

return MainShopMonthCardRewardPanel
