local PvpPasswordCreateView, _ = NewClass("PvpPasswordCreateView", BaseView)
PvpPasswordCreateView.uiResCls = UI_Social_Popup_MatchModeResource

function PvpPasswordCreateView:OnBuildView()
end

function PvpPasswordCreateView:OnEnterView()
end

function PvpPasswordCreateView:OnEnterViewFinished()
end

function PvpPasswordCreateView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_FriendlyMatch, System.fn(self, self._OnBtnFriendlyMatch))
  self:AddButtonClickListener(self.ui.Btn_RotationMode, System.fn(self, self._OnBtnRotationMode))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function PvpPasswordCreateView:_OnBtnFriendlyMatch()
  PvpPasswordController.Instance:ReqCreatePVPRoom(PvpDefine.PvpType.PreBuilt)
end

function PvpPasswordCreateView:_OnBtnRotationMode()
  PvpPasswordController.Instance:ReqCreatePVPRoom(PvpDefine.PvpType.Draft)
end

return PvpPasswordCreateView
