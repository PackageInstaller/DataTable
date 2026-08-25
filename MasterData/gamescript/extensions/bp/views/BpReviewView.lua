local BpReviewView, Super = NewClass("BpReviewView", BaseView)
BpReviewView.uiResCls = UI_Passport_InstructionsResource

function BpReviewView:ctor()
  Super.ctor(self)
end

function BpReviewView:RegisterNotifications()
end

function BpReviewView:RegisterEvents()
end

function BpReviewView:OnEnterView()
  Super.OnEnterView(self)
  self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, function()
    BpModel.Instance:SetCurPage(BpModel.Instance.lastPage)
  end)
  self:SetText(self.ui.Text_Time, BpModel.Instance:GetBpCountDown())
  self.countDownTimer = self:BindTimer(1, -1, function()
    self:SetText(self.ui.Text_Time, BpModel.Instance:GetBpCountDown())
  end)
end

function BpReviewView:RefreshOnRendered()
end

function BpReviewView:OnEnterViewFinished()
end

function BpReviewView:OnExitView()
  if self.countDownTimer then
    self:StopTimer(self.countDownTimer)
    self.countDownTimer = nil
  end
  Super.OnExitView(self)
end

return BpReviewView
