_class("UIActivityN5MissionNode", UICustomWidget)
UIActivityN5MissionNode = UIActivityN5MissionNode

function UIActivityN5MissionNode:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityN5MissionNode:InitWidget()
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
  self._atlas = self:GetAsset("UIN5.spriteatlas", LoadType.SpriteAtlas)
  self.shadow = self:GetUIComponent("Shadow", "name")
  self.root = self:GetGameObject()
  self._anim = self:GetUIComponent("Animation", "UIActivityN5MissionNode")
end

function UIActivityN5MissionNode:SetData(node, cb, fromMissionResult)
  self._nodeInfo = node
  self._onClick = cb
  self._canEnter = false
  self._rectTransform.anchoredPosition = self._nodeInfo.pos
  self.name:SetText(StringTable.Get(self._nodeInfo.name))
  local viewCfg
  local lineCfg = Cfg.cfg_component_line_mission({
    CampaignMissionId = self._nodeInfo.campaignMissionId
  })[1]
  if not lineCfg.CustomParams then
    AirError("N5普通关找不到自定义参数：", lineCfg.ID)
  end
  local hardParam = lineCfg.CustomParams[1][1]
  local typeCfg
  if self._nodeInfo.isSLevel then
    typeCfg = UIActivityN5SimpleLevel.NodeCfg[UIActivityN5SimpleLevel.SLeval]
  else
    typeCfg = UIActivityN5SimpleLevel.NodeCfg[self._nodeInfo.type]
  end
  local needPlayStarsAnim = false
  local bg
  local mask = typeCfg[hardParam].press
  local lock = typeCfg[hardParam].lock
  local textColor, shadowColor
  if self._nodeInfo.state == DiscoveryStageState.Nomal then
    textColor = typeCfg[hardParam].textColor
    shadowColor = typeCfg[hardParam].textShadow
    bg = typeCfg[hardParam].normal
    for i = 1, 3 do
      local pass = i <= self._nodeInfo.starCount
      if pass then
        self._stars[i].sprite = self._atlas:GetSprite(typeCfg[hardParam].passStar)
      else
        self._stars[i].sprite = self._atlas:GetSprite(typeCfg[hardParam].normalStar)
      end
    end
    local bShowStar = self._nodeInfo.type ~= DiscoveryStageType.Plot
    self.star:SetActive(bShowStar)
    if bShowStar and self._nodeInfo.starCount > 0 then
      needPlayStarsAnim = true
    end
    self.lock.gameObject:SetActive(false)
    self._canEnter = true
  elseif self._nodeInfo.state == DiscoveryStageState.CanPlay then
    textColor = typeCfg[hardParam].textColor
    shadowColor = typeCfg[hardParam].textShadow
    bg = typeCfg[hardParam].normal
    for i = 1, 3 do
      local pass = i <= self._nodeInfo.starCount
      if pass then
        self._stars[i].sprite = self._atlas:GetSprite(typeCfg[hardParam].passStar)
      else
        self._stars[i].sprite = self._atlas:GetSprite(typeCfg[hardParam].normalStar)
      end
    end
    local bShowStar = self._nodeInfo.type ~= DiscoveryStageType.Plot
    self.star:SetActive(bShowStar)
    if bShowStar and self._nodeInfo.starCount > 0 then
      needPlayStarsAnim = true
    end
    self.lock.gameObject:SetActive(false)
    self._canEnter = true
  elseif self._nodeInfo.state == nil then
    textColor = typeCfg[hardParam].textColor
    shadowColor = typeCfg[hardParam].textShadow
    bg = typeCfg[hardParam].normal
    self.lock.gameObject:SetActive(true)
    self.star:SetActive(false)
    self.root:SetActive(false)
  end
  self.bg.sprite = self._atlas:GetSprite(bg)
  self.mask.sprite = self._atlas:GetSprite(mask)
  self.lock.sprite = self._atlas:GetSprite(lock)
  self.name.color = textColor
  self.shadow.effectColor = shadowColor
  self._needScrollOnClick = self._nodeInfo.type ~= DiscoveryStageType.Plot
  if fromMissionResult and self._nodeInfo.campaignMissionId == fromMissionResult and needPlayStarsAnim then
    self.animTimer = GameGlobal.Timer():AddEvent(700, function()
      self._anim:Play("uieff_N5_Node_GetStars")
    end)
  end
end

function UIActivityN5MissionNode:btnOnClick(go)
  if self._canEnter then
    self._onClick(self._nodeInfo.campaignMissionId, self._needScrollOnClick, self._rectTransform)
  end
end

function UIActivityN5MissionNode:OnHide()
  if self.animTimer then
    GameGlobal.Timer():CancelEvent(self.animTimer)
    self.animTimer = nil
  end
end
