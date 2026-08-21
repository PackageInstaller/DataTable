_class("UIActivityShopSmallItemBox", UICustomWidget)
UIActivityShopSmallItemBox = UIActivityShopSmallItemBox

function UIActivityShopSmallItemBox:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityShopSmallItemBox:InitWidget()
  self._smallItemGen = self:GetGameObject("SmallItemGen")
  self._smallItemsPool = self:GetUIComponent("UISelectObjectPath", "SmallItemGen")
end

function UIActivityShopSmallItemBox:SetData()
end

function UIActivityShopSmallItemBox:InitData(data)
  local itemList = self._smallItemsPool:SpawnObjects("UIActivityShopItemSmall", #data)
  for index, value in ipairs(itemList) do
    value:InitData(data[index])
  end
end
