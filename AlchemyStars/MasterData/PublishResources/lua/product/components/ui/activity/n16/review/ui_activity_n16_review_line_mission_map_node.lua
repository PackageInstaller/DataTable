_class("UIActivityN16ReviewLineMissionMapNode", UICustomWidget)
UIActivityN16ReviewLineMissionMapNode = UIActivityN16ReviewLineMissionMapNode

function UIActivityN16ReviewLineMissionMapNode:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityN16ReviewLineMissionMapNode:InitWidget()
  self.bg = self:GetUIComponent("RawImageLoader", "bg")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.name2 = self:GetUIComponent("UILocalizationText", "name_boss")
  self.star = self:GetGameObject("star")
  self.mask = self:GetUIComponent("Image", "mask")
  self.lock = self:GetUIComponent("Image", "lock")
  self.star1 = self:GetUIComponent("Image", "Star1")
  self.star2 = self:GetUIComponent("Image", "Star2")
  self.star3 = self:GetUIComponent("Image", "Star3")
  self.jinji = self:GetGameObject("jinji")
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._stars = {
    self.star1,
    self.star2,
    self.star3
  }
  self._atlas = self:GetAsset("UIN16.spriteatlas", LoadType.SpriteAtlas)
  self._anim = self:GetGameObject():GetComponent("Animation")
  self._redImgObj = self:GetGameObject("redImg")
end

function UIActivityN16ReviewLineMissionMapNode:SetData(lineCfg, passInfo, cb)
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
  self.name2:SetText(StringTable.Get(missionCfg.Name))
  self.name.gameObject:SetActive(missionCfg.Type ~= DiscoveryStageType.FightBoss)
  self.name2.gameObject:SetActive(missionCfg.Type == DiscoveryStageType.FightBoss)
  self.jinji.gameObject:SetActive(missionCfg.Type == DiscoveryStageType.FightBoss)
  local hardParam = 1
  local typeCfg
  if lineCfg.WayPointType == 4 then
    typeCfg = UIActivityN16ReviewLineMissionController.NodeCfg[UIActivityN16ReviewLineMissionController.SLeval]
  else
    typeCfg = UIActivityN16ReviewLineMissionController.NodeCfg[missionCfg.Type]
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
  self:_SetRed(false)
  if missionCfg.Type == DiscoveryStageType.Plot then
    self._redImgObj:SetActive(false)
  end
  self.bg:LoadImage(bg)
  self.mask.sprite = self._atlas:GetSprite(mask)
  self.lock.sprite = self._atlas:GetSprite(lock)
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  if 0 <= lineCfg.MapPosY then
    self._anim:Play("uieffanim_N16_lineMissMap_top")
  else
    self._anim:Play("uieffanim_N16_lineMissMap_down")
  end
end

function UIActivityN16ReviewLineMissionMapNode:_SetRed(isShow)
  local redObj = self:GetGameObject("red")
  redObj:SetActive(isShow)
end

function UIActivityN16ReviewLineMissionMapNode:BtnOnClick(go)
  self._onClick(self._missionID, self._isStoryNode, self._rectTransform.position)
end
