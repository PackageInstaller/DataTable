local PvPPasswordTeamPanel, Super = System.NewClass("PvPPasswordTeamPanel", PvPTeamBuildMainPanel)
PvPPasswordTeamPanel.uiResCls = UI_Pvp_Team_MainResource

function PvPPasswordTeamPanel:ctor(friendUid)
  Super.ctor(self)
  self.friendUid = friendUid
  self.isReqCancelOnUnbind = true
end

function PvPPasswordTeamPanel:OnBind(binder)
  Super.OnBind(self, binder)
  binder:BindEvent(EventMgr.Instance.PvpRoomClose, System.fn(self, self.Close))
end

function PvPPasswordTeamPanel:OnBindClose()
  self.closeBtn = self.binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:OnBtnClose()
  end))
end

function PvPPasswordTeamPanel:OnBindBottomBtn()
  local binder, model = self.binder, self.model
  binder:BindZ1Button(self.ui.Btn_Quick_Build, function()
    PvPTeamBuildDataUtils.OpenPvPTeamMultiBuildPanel(model)
  end, function()
    return CommonDefine.BtnType.High
  end)
  binder:BindZ1Button(self.ui.Btn_Challenge, function()
    if not model:CheckCanChallenge() then
      Alert.ShowStr(LT.Text("PvPTeamBuildChallengeNotFullTips"))
      return
    end
    self.isReqCancelOnUnbind = false
    ProtoManager.Instance:ReqServer("PvpRequest", "OnChooseTeam", function()
      self:OpenWaitingPanel()
    end, function()
    end, self.model.curTeamIdx)
  end, function()
    if not model:CheckCanChallenge() then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "PvPChallengeBtnText"
  end)
  if PvpPasswordModel.Instance:GetSelfStatus() == PvpDefine.RoomPlayerStatus.SelectedTeam then
    self:OpenWaitingPanel()
  end
end

function PvPPasswordTeamPanel:OpenWaitingPanel()
  self.closeWithoutAnim = true
  UIManager.Instance:Reopen(Urls.PvpPasswordWaitFormation, self.friendUid)
end

function PvPPasswordTeamPanel:OnBtnClose()
  Alert.Show("PVP_PasswordBattle_QuitTips", nil, function()
    PvpPasswordController.Instance:ReqCancelMatching()
  end)
end

return PvPPasswordTeamPanel
