local ANIM_DURATION_TIME = 3.91
local TutorialPopTipView, Super = NewClass("TutorialPopTipView", BaseView)
TutorialPopTipView.uiResCls = UI_Common_Tips_CourseBubbleResource

function TutorialPopTipView:ctor(tidGroup)
  Super.ctor(self)
  self._tidGroup = tidGroup
  self._closeTimerId = nil
end

function TutorialPopTipView:OnBuildView()
end

function TutorialPopTipView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnTutorialPopTipDataChanged, self._RefreshUI, self)
end

function TutorialPopTipView:RegisterEvents()
  self:AddButtonClickListener(self.ui.uiNode, System.fn(self, self._OnClickTip))
end

function TutorialPopTipView:OnEnterView()
  Super.OnEnterView(self)
  TutorialPopTipModel.Instance:SetTidGroup(self._tidGroup)
  self:LocalNotify(NotifyId.OnTutorialPopTipDataChanged)
  self._closeTimerId = self:BindTimer(ANIM_DURATION_TIME, 0, nil, function()
    self:Close()
  end)
end

function TutorialPopTipView:OnExitView()
  if self._closeTimerId then
    self:StopTimer(self._closeTimerId)
    self._closeTimerId = nil
  end
  Super.OnExitView(self)
end

function TutorialPopTipView:_RefreshUI()
  local model = TutorialPopTipModel.Instance
  self:SetText(self.ui.Text_Name, model:GetTitle())
  self:SetImage(self.ui.Image_Icon, model:GetIcon())
end

function TutorialPopTipView:_OnClickTip()
  self:Close()
  TutorialDataUtils.OpenTutorialMainPanel(self._tidGroup)
end

return TutorialPopTipView
