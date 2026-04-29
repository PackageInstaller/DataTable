_class("UIHomelandMinimapIconFish", UIHomelandMinimapIconBase)
UIHomelandMinimapIconFish = UIHomelandMinimapIconFish

function UIHomelandMinimapIconFish:OnShow(uiParams)
  self._fish = self:GetGameObject("Fish")
  self._goldFish = self:GetGameObject("GoldFish")
  self._goldPetFish = self:GetGameObject("GoldPetFish")
  self._box = self:GetGameObject("Box")
  self._selectGO = self:GetGameObject("select")
end

function UIHomelandMinimapIconFish:OnInitDone()
  local fishCfgID = self:GetIconData():GetParam()
  self.cfg = HomelandFishingConst.GetFishingPositionCfg(fishCfgID)
  self.fishingPointType = self.cfg.Type
  if self.fishingPointType == HomelandFishingPointType.Normal then
    self._fish:SetActive(true)
  elseif self.fishingPointType == HomelandFishingPointType.Gold then
    self._goldFish:SetActive(true)
  elseif self.fishingPointType == HomelandFishingPointType.Box then
    self._box:SetActive(true)
  elseif self.fishingPointType == HomelandFishingPointType.GoldPetFish then
    self._goldPetFish:SetActive(true)
  end
end

function UIHomelandMinimapIconFish:OnSelected()
  self._selectGO:SetActive(true)
end

function UIHomelandMinimapIconFish:OnUnSelected()
  self._selectGO:SetActive(false)
end

function UIHomelandMinimapIconFish:GetShowName()
  if self.fishingPointType == HomelandFishingPointType.Normal then
    return StringTable.Get("str_homeland_minimap_detail_title_fish")
  elseif self.fishingPointType == HomelandFishingPointType.Gold then
    return StringTable.Get("str_homeland_minimap_detail_title_goldfish")
  elseif self.fishingPointType == HomelandFishingPointType.GoldPetFish then
    return StringTable.Get("str_homeland_minimap_detail_title_goldpetfish")
  elseif self.fishingPointType == HomelandFishingPointType.Box then
    return StringTable.Get("str_homeland_minimap_detail_title_box")
  end
end

function UIHomelandMinimapIconFish:GetAnimationName(animType)
  if not self._animationNames then
    self._animationNames = {}
    self._animationNames[MinimapIconAnimationType.IN] = "UIHomelandMinimapFishIcon_in"
    self._animationNames[MinimapIconAnimationType.OUT] = "UIHomelandMinimapFishIcon_out"
    self._animationNames[MinimapIconAnimationType.SELECT] = "UIHomelandMinimapFishIcon_Selected_in"
    self._animationNames[MinimapIconAnimationType.UNSELECT] = "UIHomelandMinimapFishIcon_Selected_out"
    self._animationNames[MinimapIconAnimationType.EXPANSION] = "UIHomelandMinimapFishIcon_expansion"
  end
  return self._animationNames[animType]
end
