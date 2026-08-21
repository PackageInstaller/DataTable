_class("UIHomelandShopTabSellItem", UICustomWidget)
UIHomelandShopTabSellItem = UIHomelandShopTabSellItem

function UIHomelandShopTabSellItem:OnShow(uiParams)
end

function UIHomelandShopTabSellItem:OnHide(stamp)
end

function UIHomelandShopTabSellItem:SetData(roleAsset, funcClick, notShowTips, showNew, newState)
  local obj = UIWidgetHelper.SpawnObject(self, "_item", "UIItemHomeland")
  obj:Flush(roleAsset, funcClick, notShowTips, showNew, newState)
end

function UIHomelandShopTabSellItem:SetSelected(isOn)
  self:GetGameObject("_selectBg"):SetActive(isOn)
end
