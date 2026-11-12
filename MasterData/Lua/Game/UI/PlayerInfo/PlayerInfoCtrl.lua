local PlayerInfoCtrl = class("PlayerInfoCtrl", BaseCtrl)
PlayerInfoCtrl._mapNodeConfig = {
  txtUID = {sComponentName = "TMP_Text"}
}
PlayerInfoCtrl._mapEventConfig = {
  FinishCacheAccInfo = "GetPlayerInfo",
  [EventId.ClosePanel] = "OnEvent_UpdatePanel"
}

function PlayerInfoCtrl:GetPlayerInfo()
  local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
  if clientPublishRegion == CS.ClientPublishRegion.CN or clientPublishRegion == CS.ClientPublishRegion.Other then
    NovaAPI.SetTMPText(self._mapNode.txtUID, "UID:" .. PlayerData.Base:GetPlayerId())
  else
    NovaAPI.SetTMPText(self._mapNode.txtUID, "")
  end
end

function PlayerInfoCtrl:OnEvent_UpdatePanel(panelId)
  if panelId == PanelId.SettingsPreview then
    self.gameObject:SetActive(false)
    self.gameObject:SetActive(true)
  end
end

return PlayerInfoCtrl
