_class("UIActivityN20NHardLevelNode", UICustomWidget)
UIActivityN20NHardLevelNode = UIActivityN20NHardLevelNode

function UIActivityN20NHardLevelNode:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityN20NHardLevelNode:InitWidget()
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._lockLoader = self:GetUIComponent("RawImageLoader", "Lock")
  self._lock = self:GetGameObject("Lock")
  self._complete = self:GetGameObject("Complete")
  self._go = self:GetGameObject()
end

function UIActivityN20NHardLevelNode:SetData(lineCfg, isOpen, hasPass, cb)
  self._go:SetActive(true)
  self._isOpen = isOpen
  self._missionID = lineCfg.CampaignMissionId
  self._onClick = cb
  self._rectTransform.anchorMax = Vector2(0, 0.5)
  self._rectTransform.anchorMin = Vector2(0, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
    return
  end
  self.name:SetText(StringTable.Get(missionCfg.Name))
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  local cfg = Cfg.cfg_n20_component_line_mission_client[self._missionID]
  if not cfg then
    Log.exception("cfg_n20_component_line_mission_client 中找不到配置:", self._missionID)
    return
  end
  self._iconLoader:LoadImage(cfg.Icon)
  if isOpen then
    self._lock:SetActive(false)
    self._complete:SetActive(hasPass)
  else
    self._lock:SetActive(true)
    self._lockLoader:LoadImage(cfg.CloseIcon)
    self._complete:SetActive(false)
  end
end

function UIActivityN20NHardLevelNode:BtnOnClick(go)
  if not self._isOpen then
    ToastManager.ShowToast(StringTable.Get("str_n20_level_unopen_tips"))
    return
  end
  self._onClick(self._missionID, self._isStoryNode, self._rectTransform.position)
end

function UIActivityN20NHardLevelNode:SetVisible(status)
  self._go:SetActive(status)
end
