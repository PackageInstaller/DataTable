local PvpPasswordWaitingView, Super = NewClass("PvpPasswordWaitingView", BaseView)
PvpPasswordWaitingView.uiResCls = UI_Pvp_Popup_PasswordMatchResource

function PvpPasswordWaitingView:ctor()
  Super.ctor(self)
  local roomData = PvpPasswordModel.Instance:GetRoomData()
  self._pvpType = roomData.pvpType
  self._password = roomData.password
end

function PvpPasswordWaitingView:OnBuildView()
end

function PvpPasswordWaitingView:OnEnterView()
  self:SetText(self.ui.Text_Password, self._password)
  if self._pvpType == PvpDefine.PvpType.PreBuilt then
    self:SetText(self.ui.Text_Mode, "PasswordBattle1")
  else
    self:SetText(self.ui.Text_Mode, "PasswordBattle2")
  end
  self:StartCloseRoomTimer()
end

function PvpPasswordWaitingView:OnEnterViewFinished()
end

function PvpPasswordWaitingView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._OnBtnCancel))
  self:AddButtonClickListener(self.ui.Btn_Copy, System.fn(self, self._OnBtnCopy))
  self:BindEvent(EventMgr.Instance.PvpRoomClose, System.fn(self, self.OnPvpRoomClose))
end

function PvpPasswordWaitingView:StartCloseRoomTimer()
  local leftTime = PvpPasswordModel.Instance:GetRoomLeftTime()
  if PvpPasswordModel.Instance:IsRoomClosed() then
    self:Close()
    return
  end
  if not leftTime then
    self:SetText(self.ui.Text_Time, "")
    self:BindTimer(0.5, 0, nil, System.fn(self, self.StartCloseRoomTimer))
  else
    self:SetText(self.ui.Text_Time, leftTime .. "s")
    if leftTime > 0 then
      self:BindTimer(0.5, 0, nil, System.fn(self, self.StartCloseRoomTimer))
    else
      Alert.ShowStr("WaitngTimeout")
      self:_OnBtnCancel()
      self:Close()
    end
  end
end

function PvpPasswordWaitingView:OnPvpRoomClose()
  self:Close()
  local pvpRoomData = PvpPasswordModel.Instance:GetRoomData()
  if not pvpRoomData then
    return
  end
  local isRoomOwner = pvpRoomData.invitePlayer == PlayerDataUtils.GetPlayerUid()
  if not isRoomOwner then
  end
end

function PvpPasswordWaitingView:_OnBtnCancel()
  PvpPasswordController.Instance:ReqCancelMatching()
end

function PvpPasswordWaitingView:_OnBtnCopy()
  StrUtils.CopyToClipboard(self._password)
  Alert.ShowStr("Password_CopiedTips")
end

return PvpPasswordWaitingView
