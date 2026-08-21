_class("UICommonLineMissionMapNode", UICustomWidget)
UICommonLineMissionMapNode = UICommonLineMissionMapNode

function UICommonLineMissionMapNode:OnShow(uiParams)
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self.atlas = self:GetAsset("UIN22.spriteatlas", LoadType.SpriteAtlas)
  self._topInAnim = "uieff_UIN23LineController_MapNode_up"
  self._belowInAnim = "uieff_UIN23LineController_MapNode_down"
end

function UICommonLineMissionMapNode:Destroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UICommonLineMissionMapNode:SetData(lineCfg, passInfo, cb)
  self._missionID = lineCfg.CampaignMissionId
  self._callback = cb
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    Log.exception("cfg_campaign_mission中找不到配置:", self._missionID)
  end
  self:_SetRectTransform(lineCfg)
  local missionType = missionCfg.Type
  local cfg_c_line_mission = Cfg.cfg_component_line_mission({
    CampaignMissionId = self._missionID
  })[1]
  local param = cfg_c_line_mission.CustomParams and cfg_c_line_mission.CustomParams[1]
  if not (param and next(param)) or param[1] ~= 2 or missionType == DiscoveryStageType.FightNormal then
  end
  self:_SetState(missionType)
  self:_SetName_TMP(missionCfg.Type, StringTable.Get(missionCfg.Name))
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  self.missionType = missionCfg.Type
  self:_SetStar(passInfo)
  if self._isStoryNode and passInfo then
    self:GetUIComponent("Image", "bg_plot").sprite = self.atlas:GetSprite("n22_xxg_spot3")
  end
  local id = lineCfg.MapPosY >= 0 and self._topInAnim or self._belowInAnim
  UIWidgetHelper.SetAnimationPlay(self, "anim", id)
end

function UICommonLineMissionMapNode:_SetRectTransform(lineCfg)
  self._rectTransform.anchorMax = Vector2(0, 0.5)
  self._rectTransform.anchorMin = Vector2(0, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
end

function UICommonLineMissionMapNode:_SetName(state, text)
  local tb = {
    "name_normal",
    "name_boss",
    "name_plot"
  }
  UIWidgetHelper.SetLocalizationText(self, tb[state], text)
end

function UICommonLineMissionMapNode:_SetName_TMP(state, text)
  local nameTex_boss = self:GetUIComponent("UILocalizationText", "name_boss")
  local nameTex_norm = self:GetUIComponent("UILocalizationText", "name_normal")
  local nameTex_plot = self:GetUIComponent("UILocalizationText", "name_plot")
  if state == DiscoveryStageType.Plot then
    nameTex_plot:SetText(text)
  elseif state == DiscoveryStageType.FightNormal then
    nameTex_norm:SetText(text)
  else
    nameTex_boss:SetText(text)
  end
end

function UICommonLineMissionMapNode:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "bg_normal",
      "name_normal",
      "star"
    },
    {
      "bg_boss",
      "name_boss",
      "star"
    },
    {"bg_plot", "name_plot"},
    {
      "bg_normal2",
      "name_normal",
      "star"
    }
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UICommonLineMissionMapNode:_SetStar(passInfo)
  local missionModule = self:GetModule(MissionModule)
  local stars = passInfo and missionModule:ParseStarInfo(passInfo.star) or 0
  local tb = {
    self:GetGameObject("Star1"),
    self:GetGameObject("Star2"),
    self:GetGameObject("Star3")
  }
  for i = 1, 3 do
    local pass = stars >= i
    tb[i]:SetActive(pass)
  end
  local passMask = self:GetGameObject("Pass")
  if passMask then
    passMask:SetActive(passInfo ~= nil and self.missionType == DiscoveryStageType.Plot)
  end
end

function UICommonLineMissionMapNode:BtnOnClick(go)
  self._callback(self._missionID, self._isStoryNode, self._rectTransform.position)
end
