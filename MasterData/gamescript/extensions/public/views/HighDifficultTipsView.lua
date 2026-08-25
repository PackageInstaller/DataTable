local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local HighDifficultTipsView, Super = NewClass("HighDifficultTipsView", BaseView)
HighDifficultTipsView.uiResCls = UI_High_Difficult_TipsResource

function HighDifficultTipsView:ctor(callback)
  Super.ctor(self)
  self.callback = callback
end

function HighDifficultTipsView:RegisterNotifications()
end

function HighDifficultTipsView:RegisterEvents()
end

function HighDifficultTipsView:OnEnterView()
  Super.OnEnterView(self)
  GyroscopeManager.Instance:DisableGyroscope()
  self.uiAnimationController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self.uiAnimationController:PlayState("UI_Story_Panel_Difficulty", function()
  end)
  local animClip = self.uiAnimationController:GetClip("UI_Story_Panel_Difficulty").clip
  local length = animClip.length
  self.timer = self:BindTimer(length, 0, nil, function()
    self:Close()
  end)
  self:SetText(self.ui.Text_Caption3_Title, LT.Text("StageHighDifficultTipsTitle"))
  self:SetText(self.ui.Text_Caption3_Info, LT.Text("StageHighDifficultTipsContent"))
  self:OnInitBtnMaskClick()
end

local OPEN_MASK_DELAY = 1.5

function HighDifficultTipsView:OnInitBtnMaskClick()
  self.ui.Btn_Mask:SetActive(false)
  self:BindTimer(OPEN_MASK_DELAY, 0, nil, function()
    if self.ui and self.ui.Btn_Mask then
      self.ui.Btn_Mask:SetActive(true)
    end
  end)
  self:AddButtonClickListener(self.ui.Btn_Mask, function()
    self.ui.Btn_Mask:SetActive(false)
    if self.timer then
      self:StopTimer(self.timer)
      self.timer = nil
    end
    if self.uiAnimationController then
      self.uiAnimationController:StopPlayableGraph()
      self.uiAnimationController:PlayState("UI_Story_Panel_Difficulty_Close", System.fn(self, self.Close))
    end
  end)
end

function HighDifficultTipsView:RefreshOnRendered()
end

function HighDifficultTipsView:OnEnterViewFinished()
end

function HighDifficultTipsView:OnExitView()
  if self.callback then
    self.callback()
  end
  Super.OnExitView(self)
end

return HighDifficultTipsView
