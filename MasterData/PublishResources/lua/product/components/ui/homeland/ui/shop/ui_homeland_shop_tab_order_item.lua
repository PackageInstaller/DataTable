_class("UIHomelandShopTabOrderItem", UICustomWidget)
UIHomelandShopTabOrderItem = UIHomelandShopTabOrderItem

function UIHomelandShopTabOrderItem:OnShow(uiParams)
end

function UIHomelandShopTabOrderItem:OnHide(stamp)
end

function UIHomelandShopTabOrderItem:SetData(roleAsset, color1, color2)
  self._roleAsset = roleAsset
  local itemId = roleAsset.assetid
  local requireCount = roleAsset.count
  UIWidgetHelper.SetItemIcon(self, itemId, "_icon")
  UIWidgetHelper.SetItemIconColor(self, itemId, "_iconColor", "UIHomelandBuildInfo.spriteatlas", "N17_produce_bg_item_")
  local count = UIHomelandShopHelper.GetItemCount_ForSale(itemId)
  local notEnough = requireCount > count
  self:GetGameObject("_redBg"):SetActive(notEnough)
  local c1 = notEnough and color1 or color2
  local c2 = color2
  local text = UIActivityHelper.GetColorText(c1, count, c2, "/" .. requireCount)
  UIWidgetHelper.SetLocalizationText(self, "_text", text)
end

function UIHomelandShopTabOrderItem:BtnOnClick(go)
  self:ShowDialog("UIItemTipsHomeland", self._roleAsset.assetid, go)
end
