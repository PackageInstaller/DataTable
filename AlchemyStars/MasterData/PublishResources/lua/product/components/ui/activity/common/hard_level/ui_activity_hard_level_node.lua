_class("UIActivityNHardLevelNode", UICustomWidget)
UIActivityNHardLevelNode = UIActivityNHardLevelNode

function UIActivityNHardLevelNode:OnShow(uiParams)
  self:InitWidget()
  self:OnInit()
end

function UIActivityNHardLevelNode:InitWidget()
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self.name = self:GetUIComponent("UILocalizationText", "Name")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._lock = self:GetGameObject("Lock")
  self._complete = self:GetGameObject("Complete")
  self._go = self:GetGameObject()
  self._lockTips = self:GetUIComponent("UILocalizationText", "LockTips")
  self._lockTips1 = self:GetUIComponent("UILocalizationText", "LockTips1")
end

function UIActivityNHardLevelNode:SetData(lineCfg, isOpen, hasPass, cb, idx)
  self._go:SetActive(true)
  self._isOpen = isOpen
  self._hasPass = hasPass
  self._missionID = lineCfg.CampaignMissionId
  self._onClick = cb
  self._idx = idx
  self._rectTransform.anchorMax = Vector2(0.5, 0.5)
  self._rectTransform.anchorMin = Vector2(0.5, 0.5)
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
  local clientCfg = Cfg.cfg_component_line_mission_client[self._missionID]
  if lineCfg.NeedMissionId and lineCfg.NeedMissionId ~= 0 then
    local needMissionCfg = Cfg.cfg_campaign_mission[lineCfg.NeedMissionId]
    self._needMissionName = StringTable.Get(needMissionCfg.Name)
  end
  if self._lockTips then
    self._lockTips:SetText(StringTable.Get(self:GetLockTipsString(), self._needMissionName))
  end
  if self._lockTips1 then
    self._lockTips1:SetText(StringTable.Get(self:GetLockTipsString(), self._needMissionName))
  end
  if isOpen then
    if self._hasPass then
      self:OnLevelComplete(clientCfg)
    else
      self:OnLevelOpen(clientCfg)
    end
  else
    self:OnLevelLock(clientCfg)
  end
  self:PlayAnimation()
end

function UIActivityNHardLevelNode:BtnOnClick(go)
  if not self._isOpen then
    ToastManager.ShowToast(StringTable.Get(self:GetLockTipsString(), self._needMissionName))
    return
  end
  self._onClick(self._missionID, self._isStoryNode, self._rectTransform.position)
end

function UIActivityNHardLevelNode:SetVisible(status)
  self._go:SetActive(status)
end

function UIActivityNHardLevelNode:OnInit()
end

function UIActivityNHardLevelNode:GetLockTipsString()
  return ""
end

function UIActivityNHardLevelNode:PlayAnimation()
end

function UIActivityNHardLevelNode:OnLevelOpen(clientCfg)
  self._lock:SetActive(false)
  self._complete:SetActive(false)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.Icon)
  end
end

function UIActivityNHardLevelNode:OnLevelLock(clientCfg)
  self._lock:SetActive(true)
  self._complete:SetActive(false)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.CloseIcon)
  end
end

function UIActivityNHardLevelNode:OnLevelComplete(clientCfg)
  self._lock:SetActive(false)
  self._complete:SetActive(true)
  if clientCfg then
    self._iconLoader:LoadImage(clientCfg.CompleteIcon)
  end
end
