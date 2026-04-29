_class("UIN21LineMissionMapNode", UICustomWidget)
UIN21LineMissionMapNode = UIN21LineMissionMapNode

function UIN21LineMissionMapNode:OnShow(uiParams)
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self.atlas = self:GetAsset("UIN21.spriteatlas", LoadType.SpriteAtlas)
end

function UIN21LineMissionMapNode:Destroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UIN21LineMissionMapNode:SetData(lineCfg, passInfo, cb)
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
  if param and next(param) and param[1] == 2 and missionType == DiscoveryStageType.FightNormal then
    missionType = 4
  end
  self:_SetState(missionType)
  self:_SetName_TMP(missionCfg.Type, StringTable.Get(missionCfg.Name))
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  self.missionType = missionCfg.Type
  self:_SetStar(passInfo)
  local id = lineCfg.MapPosY >= 0 and "uieff_UIXH1MissionNode_belowin" or "uieff_UIXH1MissionNode_topin"
  UIWidgetHelper.SetAnimationPlay(self, "anim", id)
end

function UIN21LineMissionMapNode:_SetRectTransform(lineCfg)
  self._rectTransform.anchorMax = Vector2(0, 0.5)
  self._rectTransform.anchorMin = Vector2(0, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = Vector2(lineCfg.MapPosX, lineCfg.MapPosY)
end

function UIN21LineMissionMapNode:_SetName(state, text)
  local tb = {
    "name_normal",
    "name_boss",
    "name_plot"
  }
  UIWidgetHelper.SetLocalizationText(self, tb[state], text)
end

function UIN21LineMissionMapNode:_SetName_TMP(state, text)
  local nameTex_boss = self:GetUIComponent("UILocalizationText", "name_boss")
  local nameTex_norm = self:GetUIComponent("UILocalizationText", "name_normal")
  local nameTex_plot = self:GetUIComponent("UILocalizationText", "name_plot")
  local texGo_boss = nameTex_boss.gameObject
  local texGo_norm = nameTex_norm.gameObject
  local texGo_plot = nameTex_plot.gameObject
  texGo_boss:SetActive(state == DiscoveryStageType.FightBoss)
  texGo_norm:SetActive(state == DiscoveryStageType.FightNormal)
  texGo_plot:SetActive(state == DiscoveryStageType.Plot)
  if state == DiscoveryStageType.Plot then
    nameTex_plot:SetText(text)
  elseif state == DiscoveryStageType.FightNormal then
    nameTex_norm:SetText(text)
  else
    nameTex_boss:SetText(text)
  end
end

function UIN21LineMissionMapNode:_SetState(state)
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

function UIN21LineMissionMapNode:_SetStar(passInfo)
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
  local starBgTb = {
    self:GetUIComponent("Image", "StarBg1"),
    self:GetUIComponent("Image", "StarBg2"),
    self:GetUIComponent("Image", "StarBg3")
  }
  local sprite
  if self.missionType == DiscoveryStageType.FightNormal then
    sprite = self.atlas:GetSprite("n21_xxg_di1")
  else
    sprite = self.atlas:GetSprite("n21_xxg_di2")
  end
  for i = 1, 3 do
    local img = starBgTb[i]
    img.sprite = sprite
  end
end

function UIN21LineMissionMapNode:BtnOnClick(go)
  self._callback(self._missionID, self._isStoryNode, self._rectTransform.position)
end
