_class("UIActivityN27NHardLevelNode", UICustomWidget)
UIActivityN27NHardLevelNode = UIActivityN27NHardLevelNode

function UIActivityN27NHardLevelNode:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityN27NHardLevelNode:InitWidget()
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._lock = self:GetGameObject("Lock")
  self._complete = self:GetGameObject("Complete")
  self._go = self:GetGameObject()
  self._lockTips = self:GetUIComponent("UILocalizationText", "LockTips")
end

function UIActivityN27NHardLevelNode:SetData(lineCfg, isOpen, hasPass, cb)
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
  self._needMissionName = ""
  self.name:SetText(StringTable.Get(missionCfg.Name))
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  local clientCfg = Cfg.cfg_n27_component_line_mission_client[self._missionID]
  if isOpen then
    self._lock:SetActive(false)
    self._complete:SetActive(hasPass)
    if clientCfg then
      if hasPass then
        self._iconLoader:LoadImage(clientCfg.CompleteIcon)
      else
        self._iconLoader:LoadImage(clientCfg.Icon)
      end
    end
  else
    if lineCfg.NeedMissionId and lineCfg.NeedMissionId ~= 0 then
      local needMissionCfg = Cfg.cfg_campaign_mission[lineCfg.NeedMissionId]
      self._needMissionName = StringTable.Get(needMissionCfg.Name)
    end
    self._lockTips:SetText(StringTable.Get("str_n27_hard_level_lock_tips", self._needMissionName))
    self._lock:SetActive(true)
    self._complete:SetActive(false)
    if clientCfg then
      self._iconLoader:LoadImage(clientCfg.CloseIcon)
    end
  end
end

function UIActivityN27NHardLevelNode:BtnOnClick(go)
  if not self._isOpen then
    ToastManager.ShowToast(StringTable.Get("str_n27_hard_level_lock_tips", self._needMissionName))
    return
  end
  self._onClick(self._missionID, self._isStoryNode, self._rectTransform.position)
end

function UIActivityN27NHardLevelNode:SetVisible(status)
  self._go:SetActive(status)
end
