_class("UIHomelandShopCoin", UICustomWidget)
UIHomelandShopCoin = UIHomelandShopCoin

function UIHomelandShopCoin:OnShow(uiParams)
  self._isOpen = true
end

function UIHomelandShopCoin:OnHide()
  self._isOpen = false
end

function UIHomelandShopCoin:SetData()
  local url = UIHomelandShopHelper.GetCoinItemIconName()
  UIWidgetHelper.SetRawImage(self, "_coinIcon", url)
  local count = UIHomelandShopHelper.GetCoinItemCount(true)
  UIWidgetHelper.SetLocalizationText(self, "_coinNum", count)
end

function UIHomelandShopCoin:AddCoinBtnOnClick(go)
end

function UIHomelandShopCoin:CoinIconOnClick(go)
  local id = UIHomelandShopHelper.GetCoinItemId()
  self:ShowDialog("UIItemTipsHomeland", id, go)
end
