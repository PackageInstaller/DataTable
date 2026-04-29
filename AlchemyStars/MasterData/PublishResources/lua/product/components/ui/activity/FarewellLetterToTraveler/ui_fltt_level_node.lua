_class("UIFLTTLevelNode", UICustomWidget)
UIFLTTLevelNode = UIFLTTLevelNode

function UIFLTTLevelNode:OnShow(uiParams)
  self:InitWidget()
end

function UIFLTTLevelNode:InitWidget()
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIFLTTLevelNode:SetData(lineCfg, passInfo, cb)
  self._missionID = lineCfg.CampaignMissionId
  self._onClick = cb
  self._rectTransform.anchorMax = Vector2(0, 0.5)
  self._rectTransform.anchorMin = Vector2(0, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
  end
  self.name:SetText(StringTable.Get(missionCfg.Name))
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  if 0 <= lineCfg.MapPosY then
    self._anim:Play("uieff_N26LineController_MapNode_up")
  else
    self._anim:Play("uieff_N26LineController_MapNode_down")
  end
end

function UIFLTTLevelNode:BtnOnClick(go)
  self._onClick(self._missionID, self._isStoryNode, self._rectTransform.position)
end
