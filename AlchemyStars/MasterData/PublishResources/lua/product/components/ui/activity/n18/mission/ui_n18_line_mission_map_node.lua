_class("UIN18LineMissionMapNode", UICustomWidget)
UIN18LineMissionMapNode = UIN18LineMissionMapNode

function UIN18LineMissionMapNode:Constructor()
end

function UIN18LineMissionMapNode:OnShow(uiParams)
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

function UIN18LineMissionMapNode:SetFontMat(lable, resname)
  local res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  table.insert(self._matRes, res)
  if not res then
    return
  end
  local obj = res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIN18LineMissionMapNode:InitWidget()
  self.bg = self:GetUIComponent("Image", "bg")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.name2 = self:GetUIComponent("UILocalizationText", "name_boss")
  self.star = self:GetGameObject("star")
  self.mask = self:GetUIComponent("Image", "mask")
  self.lock = self:GetUIComponent("Image", "lock")
  self.star1 = self:GetUIComponent("Image", "Star1")
  self.star2 = self:GetUIComponent("Image", "Star2")
  self.star3 = self:GetUIComponent("Image", "Star3")
  self._circleOutline = self:GetUIComponent("H3D.UGUI.CircleOutline", "name")
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._stars = {
    self.star1,
    self.star2,
    self.star3
  }
  self._buttonBg = {
    type1 = {
      "bg1",
      "bg2",
      "bg3"
    }
  }
  self._atlas = self:GetAsset("UIN18.spriteatlas", LoadType.SpriteAtlas)
  self._anim = self:GetGameObject():GetComponent("Animation")
  self._bgGo = self:GetGameObject("bg")
  self._btnGo = self:GetGameObject("btn")
  self._maskGo = self:GetGameObject("mask")
end

function UIN18LineMissionMapNode:SetData(lineCfg, passInfo, cb, type, cfg, condition)
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
  self.name.gameObject:SetActive(true)
  local hardParam = lineCfg.CustomParams[1][1]
  local typeCfg
  typeCfg = cfg[missionCfg.Type]
  local bg
  local mask = typeCfg[hardParam].press
  local lock = typeCfg[hardParam].lock
  local textColor
  if passInfo then
    textColor = typeCfg[hardParam].textColor
    local module = self:GetModule(MissionModule)
    local stars = module:ParseStarInfo(passInfo.star or typeCfg[hardParam].normalStar)
    bg = typeCfg[hardParam].normal
    for i = 1, 3 do
      local pass = i <= stars
      local url = pass and typeCfg[hardParam].passStar or typeCfg[hardParam].normalStar
      self._stars[i].sprite = self._atlas:GetSprite(url)
      self._stars[i].gameObject:SetActive(not string.isnullorempty(url))
    end
    self.star:SetActive(missionCfg.Type ~= DiscoveryStageType.Plot)
  else
    textColor = typeCfg[hardParam].textColor
    bg = typeCfg[hardParam].normal
    local stars = 0
    for i = 1, 3 do
      local pass = i <= stars
      local url = pass and typeCfg[hardParam].passStar or typeCfg[hardParam].normalStar
      self._stars[i].sprite = self._atlas:GetSprite(url)
      self._stars[i].gameObject:SetActive(not string.isnullorempty(url))
    end
    self.star:SetActive(missionCfg.Type ~= DiscoveryStageType.Plot)
  end
  self:ConditionShow(condition)
  self:_SetRed(false)
  self.bg.sprite = self._atlas:GetSprite(bg)
  self.mask.sprite = self._atlas:GetSprite(mask)
  self.lock.sprite = self._atlas:GetSprite(lock)
  self._isStoryNode = missionCfg.Type == DiscoveryStageType.Plot
  if 0 <= lineCfg.MapPosY then
    self._anim:Play("uieff_UIXH1MissionNode_belowin")
  else
    self._anim:Play("uieff_UIXH1MissionNode_topin")
  end
end

function UIN18LineMissionMapNode:_SetRed(isShow)
  local redObj = self:GetGameObject("red")
  redObj:SetActive(isShow)
end

function UIN18LineMissionMapNode:ConditionShow(condition)
  self.lock.gameObject:SetActive(not condition)
end

function UIN18LineMissionMapNode:btnOnClick(go)
  self._onClick(self._missionID, self._isStoryNode, self._rectTransform.position)
end
