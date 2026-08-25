local FriendMatchPopTipPanel, Super = System.NewClass("FriendMatchPopTipPanel", UIBasePanel)
FriendMatchPopTipPanel.uiResCls = UI_Social_Tips_InviteBubbleResource

function FriendMatchPopTipPanel:ctor(playerName)
  Super.ctor(self)
  self.playerName = playerName
end

function FriendMatchPopTipPanel:OnBind(binder)
  self.binder = binder
  local res = UI_Socia_Invite_BubbleItemResource(self.ui.UI_Socia_Invite_BubbleItem1)
  binder:SetText(res.Text_Name, LT.Textf("FriendGameCount", FriendMatchMgr.Instance:GetAvailInviteCount()))
  binder:BindZ1Button(res.Button, System.fn(self, self.OnBtnClick))
  local closeTime
  binder:BindTimer(1, -1, function()
    local availCount = FriendMatchMgr.Instance:GetAvailInviteCount()
    if availCount > 0 then
      closeTime = nil
      binder:SetText(res.Text_Name, LT.Textf("FriendGameCount", availCount))
    else
      closeTime = closeTime or TimerManager.totalTime + 2
      binder:SetText(res.Text_Name, LT.Text("FriendGameNull"))
    end
    if closeTime and TimerManager.totalTime > closeTime then
      self:Close()
    end
  end)
end

function FriendMatchPopTipPanel:OnUnbind()
  Super.OnUnbind(self)
end

function FriendMatchPopTipPanel:OnBtnClick()
  local availCount = FriendMatchMgr.Instance:GetAvailInviteCount()
  if availCount <= 0 then
    Logger.Warn("没有邀请信息")
    return
  end
  FriendMatchMgr.Instance:OpenMatchListPanel()
  PVPBattleReplayUtils.CloseReplay()
end

return FriendMatchPopTipPanel
