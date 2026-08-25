local FriendMatchWaitFormation, Super = System.NewClass("FriendMatchWaitFormation", UIBasePanel)
FriendMatchWaitFormation.uiResCls = UI_Social_Popup_MatchResource

function FriendMatchWaitFormation:ctor(friendUid)
  Super.ctor(self)
  self.friendUid = friendUid
end

function FriendMatchWaitFormation:OnBind(binder)
  self.binder = binder
  local friendInfo = FriendMatchMgr.Instance:QueryFriendData(self.friendUid, function(friendInfo)
    binder:SetText(self.ui.Text_PlayerName, friendInfo.name)
  end)
  if friendInfo then
    binder:SetText(self.ui.Text_PlayerName, friendInfo.name)
  end
  binder:SetText(self.ui.Text_Info, LT.Text("FriendGameWaitFormation"))
  binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.OnBtnCancel))
  local waitSecond = 0
  self.countTimer = self.binder:BindTimer(1, -1, function()
    waitSecond = waitSecond + 1
    binder:SetText(self.ui.Text_Time, waitSecond .. " s")
  end)
  binder:SetText(self.ui.Text_Time, waitSecond .. " s")
  binder:BindEvent(EventMgr.Instance.FriendMatchCancel, System.fn(self, self.OnMatchCancel))
end

function FriendMatchWaitFormation:OnBtnCancel()
  UIManager.Instance:CloseByUrl(Urls.PvPFriendGameTeamPanel)
  FriendMatchMgr.Instance:CancelFriendGame(self.friendUid)
  Alert.Show(100011)
  self:Close()
end

function FriendMatchWaitFormation:OnMatchCancel(friendUid, reason)
  if self.friendUid == friendUid then
    self:Close()
  end
end

return FriendMatchWaitFormation
