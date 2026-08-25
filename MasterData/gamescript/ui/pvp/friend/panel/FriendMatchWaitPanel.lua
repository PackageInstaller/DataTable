local FriendMatchWaitPanel, Super = System.NewClass("FriendMatchWaitPanel", UIBasePanel)
FriendMatchWaitPanel.uiResCls = UI_Social_Popup_MatchResource

function FriendMatchWaitPanel:ctor(inviteData, playerName)
  Super.ctor(self)
  self.inviteData = inviteData
  self.playerName = playerName
end

function FriendMatchWaitPanel:OnBind(binder)
  self.binder = binder
  binder:LoadAllLangFont(self.ui.Text_PlayerName)
  binder:SetText(self.ui.Text_PlayerName, self.playerName)
  binder:SetText(self.ui.Text_Info, LT.Text("FriendGameWaitAccept"))
  binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.OnBtnCancel))
  local curTime = TimeUtils.GetServerTime()
  local dura = DT.GetConstant("FriendlyMatchInvitationCountdown", 60)
  local endTime = self.inviteData.ts + dura
  local countDown = math.floor(endTime - curTime)
  if countDown <= 0 then
    self:Close()
    return
  end
  self.countTimer = TimerManager.Instance:CreateCountDown(countDown, function(leftSecond)
    binder:SetText(self.ui.Text_Time, leftSecond .. " s")
    if leftSecond <= 0 then
      Alert.Show(100010)
      self:Close()
    end
  end)
  binder:onDestroy(function()
    TimerManager.Instance:StopTimer(self.countTimer)
  end)
  binder:BindEvent(EventMgr.Instance.FriendMatchCancel, System.fn(self, self.OnMatchCancel))
end

function FriendMatchWaitPanel:OnBtnCancel()
  self._reqCanceled = true
  Alert.Show(100011)
  self:Close()
  FriendMatchMgr.Instance:CancelMyInvite()
end

function FriendMatchWaitPanel:OnMatchCancel(friendUid, reason)
  if self._reqCanceled then
    return
  end
  print("--------------------friend match wait panel on cancel", friendUid, self.inviteData.friendRelateUid)
  if self.inviteData.friendRelateUid == friendUid then
    FriendMatchMgr.Instance:ShowInviteCloseTips(reason)
    self:Close()
  end
end

return FriendMatchWaitPanel
