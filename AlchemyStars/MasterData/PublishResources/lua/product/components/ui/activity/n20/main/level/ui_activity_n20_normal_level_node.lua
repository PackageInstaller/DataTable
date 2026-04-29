_class("UIActivityN20NormalLevelNode", UICustomWidget)
UIActivityN20NormalLevelNode = UIActivityN20NormalLevelNode

function UIActivityN20NormalLevelNode:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityN20NormalLevelNode:InitWidget()
  self.bg = self:GetUIComponent("Image", "bg")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.shadowLabel = self:GetUIComponent("UILocalizationText", "Shadow")
  self._circleOutline = self:GetUIComponent("H3D.UGUI.CircleOutline", "Shadow")
  self.star = self:GetGameObject("star")
  self.star1 = self:GetUIComponent("Image", "Star1")
  self.star2 = self:GetUIComponent("Image", "Star2")
  self.star3 = self:GetUIComponent("Image", "Star3")
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._stars = {
    self.star1,
    self.star2,
    self.star3
  }
  self._atlas = self:GetAsset("UIN20.spriteatlas", LoadType.SpriteAtlas)
  self._anim = self:GetGameObject():GetComponent("Animation")
end

function UIActivityN20NormalLevelNode:SetData(lineCfg, passInfo, cb)
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
  self.shadowLabel:SetText(StringTable.Get(missionCfg.Name))
  local hardParam = 1
  local typeCfg
  if lineCfg.WayPointType == 4 then
    typeCfg = UIActivityN20NormalLevel.NodeCfg[UIActivityN20NormalLevel.SLeval]
  else
    typeCfg = UIActivityN20NormalLevel.NodeCfg[missionCfg.Type]
  end
  local bg, textColor, shadowColor
  if passInfo then
    textColor = typeCfg[hardParam].textColor
    shadowColor = typeCfg[hardParam].textShadow
    local module = self:GetModule(MissionModule)
    local stars = module:ParseStarInfo(passInfo.star)
    bg = typeCfg[hardParam].normal
    for i = 1, 3 do
      local pass = i <= stars
      if pass then
        self._stars[i].sprite = self._atlas:GetSprite(typeCfg[hardParam].passStar)
      else
        self._stars[i].sprite = self._atlas:GetSprite(typeCfg[hardParam].normalStar)
      end
    end
    self.star:SetActive(missionCfg.Type ~= DiscoveryStageType.Plot)
  else
    textColor = typeCfg[hardParam].textColor
    shadowColor = typeCfg[hardParam].textShadow
    bg = typeCfg[hardParam].normal
    local stars = 0
    for i = 1, 3 do
      local pass = i <= stars
      if pass then
        self._stars[i].sprite = self._atlas:GetSprite(typeCfg[hardParam].passStar)
      else
        self._stars[i].sprite = self._atlas:GetSprite(typeCfg[hardParam].normalStar)
      end
    end
    self.star:SetActive(missionCfg.Type ~= DiscoveryStageType.Plot)
  end
  self.bg.sprite = self._atlas:GetSprite(bg)
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  if 0 <= lineCfg.MapPosY then
    self._anim:Play("uieff_UIXH1MissionNode_belowin")
  else
    self._anim:Play("uieff_UIXH1MissionNode_topin")
  end
end

function UIActivityN20NormalLevelNode:btnOnClick(go)
  self._onClick(self._missionID, self._isStoryNode, self._rectTransform.position)
end
