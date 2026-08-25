local PvpPasswordWaitFormation, Super = System.NewClass("PvpPasswordWaitFormation", UIBasePanel)
PvpPasswordWaitFormation.uiResCls = UI_Social_Popup_MatchResource

function PvpPasswordWaitFormation:ctor(friendUid)
  Super.ctor(self)
  self.friendUid = friendUid
end

function PvpPasswordWaitFormation:OnBind(binder)
  self.binder = binder
  FriendMatchMgr.Instance:QueryFriendData(self.friendUid, function(friendInfo)
    if not self.ui or IsNil(self.ui.uiNode) then
      return
    end
    binder:SetText(self.ui.Text_PlayerName, friendInfo.name)
  end)
  binder:SetText(self.ui.Text_Info, LT.Text("FriendGameWaitFormation"))
  binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.OnBtnCancel))
  local waitSecond = 0
  self.countTimer = self.binder:BindTimer(1, -1, function()
    waitSecond = waitSecond + 1
    binder:SetText(self.ui.Text_Time, waitSecond .. " s")
  end)
  binder:SetText(self.ui.Text_Time, waitSecond .. " s")
  binder:SetText(self.ui.Text_Title, LT.PanelText("UI_Pvp_Panel_Main_1_Text_C_Password"))
  binder:BindEvent(EventMgr.Instance.PvpRoomClose, System.fn(self, self.Close))
end

function PvpPasswordWaitFormation:OnBtnCancel()
  Alert.Show("PVP_PasswordBattle_QuitTips", nil, function()
    PvpPasswordController.Instance:ReqCancelMatching()
  end)
end

return PvpPasswordWaitFormation
