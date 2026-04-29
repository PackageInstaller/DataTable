_class("UIXH1ShopSmallItemBox", UICustomWidget)
UIXH1ShopSmallItemBox = UIXH1ShopSmallItemBox

function UIXH1ShopSmallItemBox:OnShow(uiParams)
  self:InitWidget()
end

function UIXH1ShopSmallItemBox:InitWidget()
  self._smallItemGen = self:GetGameObject("SmallItemGen")
  self._smallItemsPool = self:GetUIComponent("UISelectObjectPath", "SmallItemGen")
end

function UIXH1ShopSmallItemBox:SetData()
end

function UIXH1ShopSmallItemBox:InitData(data)
  local itemList = self._smallItemsPool:SpawnObjects("UIXH1ShopItemSmall", #data)
  for index, value in ipairs(itemList) do
    value:InitData(data[index])
  end
end
