local PvpFriendSelectGameModeView, Super = NewClass("PvpFriendSelectGameModeView", BaseView)
PvpFriendSelectGameModeView.uiResCls = UI_Social_Popup_MatchModeResource

function PvpFriendSelectGameModeView:ctor(playerUid)
  Super.ctor(self)
  self._playerUid = playerUid
end

function PvpFriendSelectGameModeView:OnBuildView()
end

function PvpFriendSelectGameModeView:OnEnterView()
end

function PvpFriendSelectGameModeView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_FriendlyMatch, System.fn(self, self._OnClickBtnFriendlyMatch))
  self:AddButtonClickListener(self.ui.Btn_RotationMode, System.fn(self, self._OnClickBtnRotationMode))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function PvpFriendSelectGameModeView:_OnClickBtnFriendlyMatch()
  PVPCollectionDataUtils.ReqServerData(function()
    PvpController.Instance:ReqInviteFriendGame(self._playerUid, PvpDefine.PvpType.PreBuilt, System.fn(self, self._OnInviteSuccessful))
  end)
end

function PvpFriendSelectGameModeView:_OnClickBtnRotationMode()
  PVPCollectionDataUtils.ReqServerData(function()
    PvpController.Instance:ReqInviteFriendGame(self._playerUid, PvpDefine.PvpType.Draft, System.fn(self, self._OnInviteSuccessful))
  end)
end

function PvpFriendSelectGameModeView:_OnInviteSuccessful(data)
  if type(data) ~= "table" or not data.cd then
    return
  end
  local colddown = math.ceil(data.cd) - TimeUtils.GetServerTime()
  if colddown > 0 then
    Alert.ShowWithParams(100015, {colddown})
  end
end

return PvpFriendSelectGameModeView
