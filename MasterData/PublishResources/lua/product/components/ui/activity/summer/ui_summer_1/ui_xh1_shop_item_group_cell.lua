_class("UIXH1ShopItemGroupCell", UICustomWidget)
UIXH1ShopItemGroupCell = UIXH1ShopItemGroupCell

function UIXH1ShopItemGroupCell:OnShow(uiParams)
  self:InitWidget()
end

function UIXH1ShopItemGroupCell:InitWidget()
  self._smallBoxGen = self:GetUIComponent("UISelectObjectPath", "SmallBoxGen")
  self._bigItemGen = self:GetUIComponent("UISelectObjectPath", "BigItemGen")
  self._rootLayout = self:GetUIComponent("LayoutElement", "Root")
end

function UIXH1ShopItemGroupCell:SetData()
end

function UIXH1ShopItemGroupCell:InitData(data)
  local item
  if data.GetIsSpecial and data:GetIsSpecial() then
    item = self._bigItemGen:SpawnObject("UIXH1ShopItemBig")
    self._rootLayout.minWidth = 366
    self._rootLayout.preferredWidth = 366
  else
    item = self._smallBoxGen:SpawnObject("UIXH1ShopSmallItemBox")
    self._rootLayout.minWidth = 366
    self._rootLayout.preferredWidth = 366
  end
  if item then
    item:InitData(data)
  end
end
