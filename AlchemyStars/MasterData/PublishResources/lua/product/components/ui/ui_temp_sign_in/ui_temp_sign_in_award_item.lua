_class("UITempSignInAwardItem", UICustomWidget)
UITempSignInAwardItem = UITempSignInAwardItem

function UITempSignInAwardItem:OnShow(uiParams)
end

function UITempSignInAwardItem:SetData(index, data, callback)
  self._itemid = data.assetid
  UIWidgetHelper.SetItemIcon(self, data.assetid, "Icon")
  UIWidgetHelper.SetLocalizationText(self, "CountText", data.count)
  self:GetGameObject("CountArea"):SetActive(data.count ~= 0)
  self._callback = callback
end

function UITempSignInAwardItem:IconOnClick(go)
  if self._callback then
    self._callback(self._itemid, go.transform.position)
  end
end
