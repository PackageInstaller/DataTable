_class("UIHomelandMinimapIconShop", UIHomelandMinimapIconBase)
UIHomelandMinimapIconShop = UIHomelandMinimapIconShop

function UIHomelandMinimapIconShop:OnShow(uiParams)
  self:AttachEvent(GameEventType.HomelandShopUpdate, self._Refresh)
  self:AttachEvent(GameEventType.ItemCountChanged, self._Refresh)
end

function UIHomelandMinimapIconShop:OnHide()
  self:DetachEvent(GameEventType.HomelandShopUpdate, self._Refresh)
  self:DetachEvent(GameEventType.ItemCountChanged, self._Refresh)
end

function UIHomelandMinimapIconShop:OnInitDone()
  self._selectGO = self:GetGameObject("Selected")
  self:_Refresh()
end

function UIHomelandMinimapIconShop:OnSelected()
  self._selectGO:SetActive(true)
end

function UIHomelandMinimapIconShop:OnUnSelected()
  self._selectGO:SetActive(false)
end

function UIHomelandMinimapIconShop:GetShowName()
  local building = self:GetIconData():GetParam()
  local skinID = building:SkinID()
  local cfgSkin = Cfg.cfg_item_architecture_skin[skinID]
  return StringTable.Get(cfgSkin.SkinName)
end

function UIHomelandMinimapIconShop:_Refresh()
  local show = UIHomelandShopHelper.CheckOrderSubmit()
  self:GetGameObject("getable"):SetActive(show)
end

function UIHomelandMinimapIconShop:GetAnimationName(animType)
  if not self._animationNames then
    self._animationNames = {}
    self._animationNames[MinimapIconAnimationType.IN] = "UIHomelandMinimapIconShop_in"
    self._animationNames[MinimapIconAnimationType.OUT] = "UIHomelandMinimapIconShop_out"
    self._animationNames[MinimapIconAnimationType.SELECT] = "UIHomelandMinimapIconShop_Selected_in"
    self._animationNames[MinimapIconAnimationType.UNSELECT] = "UIHomelandMinimapIconShop_Selected_out"
    self._animationNames[MinimapIconAnimationType.EXPANSION] = "UIHomelandMinimapIconShop_expansion"
  end
  return self._animationNames[animType]
end
