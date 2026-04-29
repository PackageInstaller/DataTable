_class("UIMainLobbyCampaignEnter", UICustomWidget)
UIMainLobbyCampaignEnter = UIMainLobbyCampaignEnter

function UIMainLobbyCampaignEnter:Flush(controller, latestCampObj)
  local oneBtnMode = true
  self._uiMainLobbyController = controller
  self._latestCampObj = latestCampObj
  local sampleInfo = self._latestCampObj:GetSampleInfo()
  local campConfig = Cfg.cfg_campaign[sampleInfo.id]
  if campConfig and campConfig.EntranceIcon and table.count(campConfig.EntranceIcon) >= 3 then
    local entryPrefab = campConfig.EntranceIcon[2]
    local entryClass = campConfig.EntranceIcon[3]
    if entryPrefab and entryClass then
      local obj = UIWidgetHelper.SpawnObject(self, "EntryLoader", entryClass, entryPrefab)
      if controller and obj.SetData_uiMainLobbyController then
        obj:SetData_uiMainLobbyController(self._uiMainLobbyController)
      end
      oneBtnMode = false
    end
  end
  return oneBtnMode
end
