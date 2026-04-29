_class("UIHomelandMinimapIconFindTreasureNPC", UIHomelandMinimapIconBase)
UIHomelandMinimapIconFindTreasureNPC = UIHomelandMinimapIconFindTreasureNPC

function UIHomelandMinimapIconFindTreasureNPC:OnShow(uiParams)
  self._rawImageLoader = self:GetUIComponent("RawImageLoader", "RawImage")
  self._selectGO = self:GetGameObject("Selected")
  self._eventBubble = self:GetGameObject("EventBubble")
  self._treasureBubble = self:GetGameObject("TreasureBubble")
  self._headBGGo = self:GetGameObject("HeadBG")
end

function UIHomelandMinimapIconFindTreasureNPC:OnInitDone()
  self._rawImageLoader:LoadImage(HomelandFindTreasureConst.GetNPCMinimapIcon())
  self._eventBubble:SetActive(false)
  self._treasureBubble:SetActive(false)
end

function UIHomelandMinimapIconFindTreasureNPC:OnHide()
end

function UIHomelandMinimapIconFindTreasureNPC:OnSelected()
  self._selectGO:SetActive(true)
end

function UIHomelandMinimapIconFindTreasureNPC:OnUnSelected()
  self._selectGO:SetActive(false)
end

function UIHomelandMinimapIconFindTreasureNPC:GetShowIconOffset()
  return Vector2(0, -30)
end

function UIHomelandMinimapIconFindTreasureNPC:GetIconMultiSelectPositionOffset()
  return Vector2(0, 30)
end

function UIHomelandMinimapIconFindTreasureNPC:GetShowName()
  return StringTable.Get(HomelandFindTreasureConst.GetNPCName())
end

function UIHomelandMinimapIconFindTreasureNPC:GetMutilSelectedPosition()
  return self._headBGGo.transform.position
end

function UIHomelandMinimapIconFindTreasureNPC:GetAnimationName(animType)
  if not self._animationNames then
    self._animationNames = {}
    self._animationNames[MinimapIconAnimationType.IN] = "UIHomelandMinimapPetIcon_in"
    self._animationNames[MinimapIconAnimationType.OUT] = "UIHomelandMinimapPetIcon_out"
    self._animationNames[MinimapIconAnimationType.SELECT] = "UIHomelandMinimapPetIcon_Selected_in"
    self._animationNames[MinimapIconAnimationType.UNSELECT] = "UIHomelandMinimapPetIcon_Selected_out"
    self._animationNames[MinimapIconAnimationType.EXPANSION] = "UIHomelandMinimapPetIcon_blue"
  end
  return self._animationNames[animType]
end
