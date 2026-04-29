_class("UIMainLobbyExtraCampEntryItem", UICustomWidget)
UIMainLobbyExtraCampEntryItem = UIMainLobbyExtraCampEntryItem

function UIMainLobbyExtraCampEntryItem:OnShow()
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
end

function UIMainLobbyExtraCampEntryItem:OnHide()
end

function UIMainLobbyExtraCampEntryItem:SetData(campObj)
  local sampleInfo = campObj.m_sample_info
  local campid = sampleInfo.id
  local cfg = Cfg.cfg_main_lobby_side_entrys[campid]
  local prefabName = cfg.PrefabName
  local clsName = cfg.ClsName
  if prefabName and clsName ~= "UIMainLobbyExtraBP" then
    self._pool:ClearWidgets()
    self._pool.dynamicInfoOfEngine:SetObjectName(prefabName)
    self._item = self._pool:SpawnObject(clsName)
    self._item:SetData(sampleInfo)
  else
    Log.error("###[UIMainLobbyExtraCampEntryItem] prefab name and cls name is nil ! id --> ", campid)
  end
end
