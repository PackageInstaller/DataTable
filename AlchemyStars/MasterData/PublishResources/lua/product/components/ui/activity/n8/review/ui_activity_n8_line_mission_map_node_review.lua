_class("UIActivityN8LineMissionMapNode_Review", UICustomWidget)
UIActivityN8LineMissionMapNode_Review = UIActivityN8LineMissionMapNode_Review

function UIActivityN8LineMissionMapNode_Review:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityN8LineMissionMapNode_Review:InitWidget()
  self.bg = self:GetUIComponent("Image", "bg")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.star = self:GetGameObject("star")
  self.mask = self:GetUIComponent("Image", "mask")
  self.lock = self:GetUIComponent("Image", "lock")
  self.star1 = self:GetUIComponent("Image", "Star1")
  self.star2 = self:GetUIComponent("Image", "Star2")
  self.star3 = self:GetUIComponent("Image", "Star3")
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._stars = {
    self.star1,
    self.star2,
    self.star3
  }
  self._atlas = self:GetAsset("UIN8.spriteatlas", LoadType.SpriteAtlas)
  self.shadow = self:GetUIComponent("Shadow", "name")
  self._anim = self:GetGameObject():GetComponent("Animation")
end

function UIActivityN8LineMissionMapNode_Review:SetData(lineCfg, passInfo, cb)
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
  local hardParam = 1
  local typeCfg
  if lineCfg.WayPointType == 4 then
    typeCfg = UIActivityN8LineMissionController_Review.NodeCfg[UIActivityN8LineMissionController_Review.SLeval]
  else
    typeCfg = UIActivityN8LineMissionController_Review.NodeCfg[missionCfg.Type]
  end
  local bg
  local mask = typeCfg[hardParam].press
  local lock = typeCfg[hardParam].lock
  local textColor, shadowColor
  if passInfo then
    textColor = typeCfg[hardParam].textColor
    shadowColor = typeCfg[hardParam].textShadow
    local module = self:GetModule(MissionModule)
    local stars = module:ParseStarInfo(passInfo.star)
    bg = typeCfg[hardParam].normal
    for i = 1, 3 do
      local pass = i <= stars
      local url = pass and typeCfg[hardParam].passStar or typeCfg[hardParam].normalStar
      self._stars[i].sprite = self._atlas:GetSprite(url)
      self._stars[i].gameObject:SetActive(not string.isnullorempty(url))
    end
    self.star:SetActive(missionCfg.Type ~= DiscoveryStageType.Plot)
    self.lock.gameObject:SetActive(false)
  else
    textColor = typeCfg[hardParam].textColor
    shadowColor = typeCfg[hardParam].textShadow
    bg = typeCfg[hardParam].normal
    local stars = 0
    for i = 1, 3 do
      local pass = i <= stars
      local url = pass and typeCfg[hardParam].passStar or typeCfg[hardParam].normalStar
      self._stars[i].sprite = self._atlas:GetSprite(url)
      self._stars[i].gameObject:SetActive(not string.isnullorempty(url))
    end
    self.star:SetActive(missionCfg.Type ~= DiscoveryStageType.Plot)
    self.lock.gameObject:SetActive(false)
  end
  self.bg.sprite = self._atlas:GetSprite(bg)
  self.mask.sprite = self._atlas:GetSprite(mask)
  self.lock.sprite = self._atlas:GetSprite(lock)
  self.name.color = textColor
  self.shadow.effectColor = shadowColor
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  self:_SetPoltIcon(self._isStoryNode)
  if 0 <= lineCfg.MapPosY then
    self._anim:Play("uieff_UIXH1MissionNode_belowin")
  else
    self._anim:Play("uieff_UIXH1MissionNode_topin")
  end
end

function UIActivityN8LineMissionMapNode_Review:_SetPoltIcon(isShow)
  local obj = self:GetGameObject("plotIcon")
  obj:SetActive(isShow)
end

function UIActivityN8LineMissionMapNode_Review:BtnOnClick(go)
  self._onClick(self._missionID, self._isStoryNode, self._rectTransform.position)
end
