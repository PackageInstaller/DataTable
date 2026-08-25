local PvpPasswordJoinView, Super = NewClass("PvpPasswordJoinView", BaseView)
PvpPasswordJoinView.uiResCls = UI_Pvp_Popup_PasswordCodeResource

function PvpPasswordJoinView:ctor()
  Super.ctor(self)
end

function PvpPasswordJoinView:OnBuildView()
  Super.OnBuildView(self)
end

function PvpPasswordJoinView:OnEnterView()
  Super.OnEnterView(self)
  self:SetCodeFromClipbord()
  self:RefreshJoinBtnState()
  SocialStateUtils.SetPlayerState(SocialDefine.OnlineState.PVPPwdMatching)
end

function PvpPasswordJoinView:OnExitView()
  Super.OnExitView(self)
end

function PvpPasswordJoinView:OnEnterViewFinished()
end

function PvpPasswordJoinView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._OnBtnCancel))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnBtnConfirm))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function PvpPasswordJoinView:RefreshJoinBtnState()
  self:BindTimer(0.1, -1, function()
    local pwd = self:GetPassword()
    if not pwd or #pwd < PvpDefine.RoomPwdLen then
      self:SetButtonState(self.ui.Btn_Confirm, CommonDefine.Z1ButtonState.Unclickable)
    else
      self:SetButtonState(self.ui.Btn_Confirm, CommonDefine.Z1ButtonState.High)
    end
  end)
end

function PvpPasswordJoinView:SetCodeFromClipbord()
  local str = StrUtils.PasteFromClipboard()
  if 6 == #str and tonumber(str) then
    self:SetInputText(self.ui.Input_Password, str)
  end
end

function PvpPasswordJoinView:GetPassword()
  do return self.GetInputText, self end
  return self.GetInputText, self, self.ui.Input_Password
end

function PvpPasswordJoinView:_OnBtnCancel()
  self:Close()
end

function PvpPasswordJoinView:_OnBtnConfirm()
  local pwd = self:GetPassword()
  if not pwd or #pwd < PvpDefine.RoomPwdLen then
    return
  end
  PvpPasswordController.Instance:ReqJoinRoom(tonumber(pwd), function()
    self:Close()
  end)
end

return PvpPasswordJoinView
