_class("UIN1SpecialTaskAwardItem", UICustomWidget)
UIN1SpecialTaskAwardItem = UIN1SpecialTaskAwardItem

function UIN1SpecialTaskAwardItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIN1SpecialTaskAwardItem:_GetComponents()
  self._bg = self:GetUIComponent("Image", "bg")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "ImgIcon")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
end

function UIN1SpecialTaskAwardItem:SetData(roleAsset, callback, lock)
  self.roleAsset = roleAsset
  self._callback = callback
  self._lock = lock
  local cfg = Cfg.cfg_item[roleAsset[1]]
  local icon = cfg.Icon
  local count = roleAsset[2]
  self._imgIcon:LoadImage(icon)
  self._txtCount:SetText(self:FormatCount(count))
end

function UIN1SpecialTaskAwardItem:ImgIconOnClick(go)
  if not self._lock and self._callback then
    self._callback(self.roleAsset[1], go.transform.position)
  end
end

function UIN1SpecialTaskAwardItem:FormatCount(count)
  if count < 1000 then
    return count
  end
  return math.floor(count / 1000) .. "k"
end
