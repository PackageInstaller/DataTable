_class("UIN24SpecialTaskAwardItem", UICustomWidget)
UIN24SpecialTaskAwardItem = UIN24SpecialTaskAwardItem

function UIN24SpecialTaskAwardItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIN24SpecialTaskAwardItem:_GetComponents()
  self._bg = self:GetUIComponent("Image", "bg")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "ImgIcon")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
end

function UIN24SpecialTaskAwardItem:SetData(roleAsset, callback, lock)
  self.roleAsset = roleAsset
  self._callback = callback
  self._lock = lock
  local cfg = Cfg.cfg_item[self.roleAsset.assetid]
  local icon = cfg.Icon
  local count = roleAsset.count
  self._imgIcon:LoadImage(icon)
  self._txtCount:SetText(self:FormatCount(count))
end

function UIN24SpecialTaskAwardItem:ImgIconOnClick(go)
  if not self._lock then
    self._callback(self.roleAsset.assetid, go.transform.position)
  end
end

function UIN24SpecialTaskAwardItem:FormatCount(count)
  if count < 1000 then
    return count
  end
  return math.floor(count / 1000) .. "k"
end
