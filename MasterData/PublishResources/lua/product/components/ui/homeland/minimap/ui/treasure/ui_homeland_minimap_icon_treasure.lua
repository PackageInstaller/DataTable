_class("UIHomelandMinimapIconTreasure", UIHomelandMinimapIconBase)
UIHomelandMinimapIconTreasure = UIHomelandMinimapIconTreasure

function UIHomelandMinimapIconTreasure:OnShow(uiParams)
  self._selectGO = self:GetGameObject("select")
end

function UIHomelandMinimapIconTreasure:OnInitDone()
  self._birthId = self:GetIconData():GetIndex()
  self.isFirst = self:GetIconData():GetParam()
  self.homeMD = GameGlobal.GetModule(HomelandModule)
  self.info = self.homeMD:GetTreasureBirthInfo(self._birthId)
  if self.isFirst == true then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnAddMinimapIconMark, HomelandMapIconType.Treasure, self._birthId)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnInitMinimapIconMark, HomelandMapIconType.Treasure, self._birthId)
  end
end

function UIHomelandMinimapIconTreasure:OnHide()
end

function UIHomelandMinimapIconTreasure:OnSelected()
  self._selectGO:SetActive(true)
end

function UIHomelandMinimapIconTreasure:OnUnSelected()
  self._selectGO:SetActive(false)
end

function UIHomelandMinimapIconTreasure:GetShowIconOffset()
  return Vector2(0, 0)
end

function UIHomelandMinimapIconTreasure:GetShowName()
  if self.info == nil then
    return ""
  end
  if self.info.content_view_id == TreasureViewType.TVT_NULL then
    return StringTable.Get("str_homeland_minimap_treasure_null_title")
  elseif self.info.content_view_id == TreasureViewType.TVT_SIGN then
    return StringTable.Get("str_homeland_minimap_treasure_sign_title")
  elseif self.info.content_view_id == TreasureViewType.TVT_ASSO then
  end
  return ""
end

function UIHomelandMinimapIconTreasure:GetAnimationName(animType)
  if not self._animationNames then
    self._animationNames = {}
    self._animationNames[MinimapIconAnimationType.IN] = "UIHomelandMinimapIconTreasure_in"
    self._animationNames[MinimapIconAnimationType.OUT] = "UIHomelandMinimapIconTreasure_out"
    self._animationNames[MinimapIconAnimationType.SELECT] = "UIHomelandMinimapIconTreasure_Selected_in"
    self._animationNames[MinimapIconAnimationType.UNSELECT] = "UIHomelandMinimapIconTreasure_Selected_out"
    self._animationNames[MinimapIconAnimationType.EXPANSION] = "UIHomelandMinimapIconTreasure_expansion"
  end
  return self._animationNames[animType]
end

function UIHomelandMinimapIconTreasure:IsMarkSelf(type, id)
  if type == HomelandMapIconType.Treasure and id == self._birthId then
    return true
  end
  return false
end
