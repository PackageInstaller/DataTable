local PvPFriendGameTeamPanel, Super = System.NewClass("PvPFriendGameTeamPanel", PvPTeamBuildMainPanel)
PvPFriendGameTeamPanel.uiResCls = UI_Pvp_Team_MainResource

function PvPFriendGameTeamPanel:ctor(friendUid)
  Super.ctor(self)
  self.friendUid = friendUid
  self.isReqCancelOnUnbind = true
end

function PvPFriendGameTeamPanel:OnBindBottomBtn()
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
      self.closeWithoutAnim = true
      UIManager.Instance:Reopen(Urls.FriendMatchWaitFormation, self.friendUid)
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
  binder:BindEvent(EventMgr.Instance.FriendMatchCancel, System.fn(self, self.OnMatchCancel))
end

function PvPFriendGameTeamPanel:OnUnbind()
  Super.OnUnbind(self)
  if self.isReqCancelOnUnbind then
    FriendMatchMgr.Instance:CancelFriendGame(self.friendUid)
    Alert.Show(100011)
  end
end

function PvPFriendGameTeamPanel:OnMatchCancel(friendUid, reason)
  if self.friendUid == friendUid then
    self.isReqCancelOnUnbind = false
    FriendMatchMgr.Instance:ShowInviteCloseTips(reason)
    self:Close()
  end
end

return PvPFriendGameTeamPanel
