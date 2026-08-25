local Vector3 = CS.UnityEngine.Vector3
local PvpReplayAnglePanel, Super = System.NewClass("PvpReplayAnglePanel", UIBasePanel)
PvpReplayAnglePanel.uiResCls = UI_Pvp_Popup_PlaybackAngleResource

function PvpReplayAnglePanel:ctor(data)
  Super.ctor(self)
  self.recordData = data
  self.playerUid = data.selfUid
  self.selectedUid = nil
end

function PvpReplayAnglePanel:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(SocialPlayerPvpDetailModel, self.recordData)
  local statsData = table.deepclone(self.recordData.statsData)
  if statsData and statsData[self.playerUid] and statsData[self.playerUid].awakerList then
    local awakerList = statsData[self.playerUid].awakerList
    local reversed = {}
    for i = 1, #awakerList do
      reversed[i] = awakerList[#awakerList - i + 1]
    end
    statsData[self.playerUid].awakerList = reversed
  end
  self.model:SetTeamSettleDataGroup(statsData)
  binder:BindToText(self.ui.Text_BattleType, function()
    do return self.GetPVPGameplayType end
    return self.GetPVPGameplayType, self
  end)
  self.binder:BindToText(self.ui.Text_Time, function()
    do return PvPSeasonDataUtils.GetPvpBattleTimeDesc end
    return PvPSeasonDataUtils.GetPvpBattleTimeDesc, self.recordData.timestamp
  end)
  self.binder:SetActive(self.ui.Text_BattleType, not string.isempty(self:GetPVPGameplayType()))
  self.binder:SetActive(self.ui.Btn_Confirm, true)
  self.binder:SetActive(self.ui.Btn_Copy, true)
  self.binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.OnPlayRecord))
  self.binder:BindButtonClick(self.ui.Btn_Copy, System.fn(self, self.OnBtnCopy))
  self.binder:BindEvent(EventMgr.Instance.BattleReplayTargetUid, System.fn(self, self.OnSelectedUid))
  self:_OnBindBgComp()
  self._waitCollectionData = true
  PVPCollectionDataUtils.ReqServerData(System.fn(self, self._OnBindTeamInfo), System.fn(self, self._OnBindTeamInfo))
end

function PvpReplayAnglePanel:OnUnbind()
  self._waitCollectionData = false
  Super.OnUnbind(self)
end

function PvpReplayAnglePanel:_OnBindTeamInfo()
  if not self._waitCollectionData then
    return
  end
  self._waitCollectionData = false
  self:SetPlayerInfo()
  self:SetEnemyInfo()
  EventMgr.Instance.BattleReplayTargetUid:Dispatch(self.playerUid)
end

function PvpReplayAnglePanel:_OnBindBgComp()
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.PopupTipsType.L,
    clickFunc = System.fn(self, self.Close)
  }
  self.binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_L, commonPopupConfirmTipsData))
end

function PvpReplayAnglePanel:GetPVPGameplayType()
  local PVPGameplayType = self.recordData.PVPGameplayType
  if PVPGameplayType == CommonDefine.PVPGameplayType.Match then
    do return LT.Text end
    return LT.Text, "PvpMatchBattle"
  end
  if PVPGameplayType == CommonDefine.PVPGameplayType.Friend then
    do return LT.Text end
    return LT.Text, "PvpFriendBattle"
  end
  return ""
end

function PvpReplayAnglePanel:GetPvpRecordData(playerUid)
  local statsData = self.recordData.statsData
  if statsData and statsData[playerUid] then
    return statsData[playerUid]
  end
  return {}
end

function PvpReplayAnglePanel:SetPlayerInfo()
  local roleId = self.playerUid
  local recordData = table.deepclone(self:GetPvpRecordData(roleId))
  recordData.uid = roleId
  local isWin = self:IsWin(roleId)
  if not recordData.awakerList then
    return
  end
  self.binder:BindComponent(PvpReplayAngleItem(self.ui.PvpData_My, self.model, recordData, isWin, false))
end

function PvpReplayAnglePanel:SetEnemyInfo()
  local roleId = self.recordData.opponentUid
  local recordData = table.clone(self:GetPvpRecordData(roleId))
  recordData.uid = roleId
  if not recordData.awakerList then
    return
  end
  local isWin = self:IsWin(roleId)
  self.binder:BindComponent(PvpReplayAngleItem(self.ui.PvpData_Enemy, self.model, recordData, isWin, true))
end

function PvpReplayAnglePanel:IsWin(uid)
  return self.recordData.winnerId == uid
end

function PvpReplayAnglePanel:OnBtnCopy()
  print("------------------on btn copy", self.selectedUid)
  UIManager.Instance:Reopen(Urls.PvpCopyTeamBtnView, self.ui.Btn_Copy, self.recordData, self.selectedUid, Vector3(0, 50))
end

function PvpReplayAnglePanel:OnSelectedUid(uid)
  self.selectedUid = uid
end

function PvpReplayAnglePanel:OnPlayRecord()
  if self.recordData.battleUuid then
    local isOpendPlayerPanel = UIManager.Instance:GetWindow(Urls.SocialPlayerInfoPanel)
    PVPBattleReplayUtils.PlayPVPReplay(self.recordData.battleUuid, self.selectedUid, function()
      if isOpendPlayerPanel then
        SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, nil, CommonDefine.PlayerPanelType.PVP)
      end
    end)
  end
end

return PvpReplayAnglePanel
