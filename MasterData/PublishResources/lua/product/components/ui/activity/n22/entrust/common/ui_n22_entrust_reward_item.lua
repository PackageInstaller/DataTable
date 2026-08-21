_class("UIN22EntrustRewardItem", UICustomWidget)
UIN22EntrustRewardItem = UIN22EntrustRewardItem

function UIN22EntrustRewardItem:SetData(roleAsset, received, callback)
  self._roleAsset = roleAsset
  self._callback = callback
  local itemId = self._roleAsset.assetid
  local count = self._roleAsset.count
  UIWidgetHelper.SetItemIcon(self, itemId, "_icon")
  UIWidgetHelper.SetLocalizationText(self, "_text", count)
  self:_SetReceived(received)
end

function UIN22EntrustRewardItem:_SetReceived(show)
  local obj = self:GetGameObject("state_Taken")
  obj:SetActive(show)
end

function UIN22EntrustRewardItem:BtnOnClick(go)
  if self._callback then
    self._callback(self._roleAsset.assetid, go.transform.position)
  end
end
