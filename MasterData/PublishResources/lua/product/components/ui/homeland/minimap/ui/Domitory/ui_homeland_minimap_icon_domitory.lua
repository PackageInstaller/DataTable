_class("UIHomelandMinimapIconDomitory", UIHomelandMinimapIconBase)
UIHomelandMinimapIconDomitory = UIHomelandMinimapIconDomitory

function UIHomelandMinimapIconDomitory:OnShow(uiParams)
  self._selectGO = self:GetGameObject("Selected")
end

function UIHomelandMinimapIconDomitory:OnInitDone()
end

function UIHomelandMinimapIconDomitory:OnSelected()
  self._selectGO:SetActive(true)
end

function UIHomelandMinimapIconDomitory:OnUnSelected()
  self._selectGO:SetActive(false)
end

function UIHomelandMinimapIconDomitory:GetShowName()
  local building = self:GetIconData():GetParam()
  local cfg = Cfg.cfg_item_architecture[building:GetBuildId()]
  return StringTable.Get(cfg.Name)
end

function UIHomelandMinimapIconDomitory:GetAnimationName(animType)
  if not self._animationNames then
    self._animationNames = {}
    self._animationNames[MinimapIconAnimationType.IN] = "UIHomelandMinimapIconDomitory_in"
    self._animationNames[MinimapIconAnimationType.OUT] = "UIHomelandMinimapIconDomitory_out"
    self._animationNames[MinimapIconAnimationType.SELECT] = "UIHomelandMinimapIconDomitory_Selected_in"
    self._animationNames[MinimapIconAnimationType.UNSELECT] = "UIHomelandMinimapIconDomitory_Selected_out"
    self._animationNames[MinimapIconAnimationType.EXPANSION] = "UIHomelandMinimapIconDomitory_expansion"
  end
  return self._animationNames[animType]
end
