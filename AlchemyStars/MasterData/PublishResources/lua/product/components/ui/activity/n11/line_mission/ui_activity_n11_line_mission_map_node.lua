_class("UIActivityN11LineMissionMapNode", UICustomWidget)
UIActivityN11LineMissionMapNode = UIActivityN11LineMissionMapNode

function UIActivityN11LineMissionMapNode:OnShow(uiParams)
  self:InitWidget()
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGo), UIEvent.Press, function(go)
    self._bgGo:SetActive(false)
    self._maskGo:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGo), UIEvent.Release, function(go)
    self._bgGo:SetActive(true)
    self._maskGo:SetActive(false)
  end)
end

function UIActivityN11LineMissionMapNode:InitWidget()
  self.bg = self:GetUIComponent("Image", "bg")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.name2 = self:GetUIComponent("UILocalizationText", "name_boss")
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
  self._atlas = self:GetAsset("N11.spriteatlas", LoadType.SpriteAtlas)
  self._anim = self:GetGameObject():GetComponent("Animation")
  self._bgGo = self:GetGameObject("bg")
  self._btnGo = self:GetGameObject("btn")
  self._maskGo = self:GetGameObject("mask")
end

function UIActivityN11LineMissionMapNode:SetData(lineCfg, passInfo, cb)
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
  local hardParam = 1
  local typeCfg
  if lineCfg.WayPointType == 4 then
    typeCfg = UIActivityN11LineMissionController.NodeCfg[UIActivityN11LineMissionController.SLeval]
  else
    typeCfg = UIActivityN11LineMissionController.NodeCfg[missionCfg.Type]
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
  self.bg.sprite = self._atlas:GetSprite(bg)
  self.mask.sprite = self._atlas:GetSprite(mask)
  self.lock.sprite = self._atlas:GetSprite(lock)
  local nametext = missionCfg.Type == DiscoveryStageType.FightBoss and self.name2 or self.name
  nametext.color = textColor
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  if 0 <= lineCfg.MapPosY then
    self._anim:Play("uieff_UIXH1MissionNode_belowin")
  else
    self._anim:Play("uieff_UIXH1MissionNode_topin")
  end
end

function UIActivityN11LineMissionMapNode:_SetRed(isShow)
  local redObj = self:GetGameObject("red")
  redObj:SetActive(isShow)
end

function UIActivityN11LineMissionMapNode:btnOnClick(go)
  self._onClick(self._missionID, self._isStoryNode, self._rectTransform.position)
end
