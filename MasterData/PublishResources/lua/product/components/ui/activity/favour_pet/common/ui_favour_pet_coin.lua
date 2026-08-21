_class("UIFavourPetCoin", UICustomWidget)
UIFavourPetCoin = UIFavourPetCoin

function UIFavourPetCoin:SetData(component, tipsCallback)
  local itemId = component:GetVoteCostItemId()
  UIWidgetHelper.SetItemIcon(self, itemId, "_icon")
  UIWidgetHelper.SetItemCount(self, itemId, "_text")
  self._itemId = itemId
  self._tipsCallback = tipsCallback
end

function UIFavourPetCoin:BtnOnClick(go)
  if self._tipsCallback then
    self._tipsCallback(self._itemId, go.transform.position)
  end
end
