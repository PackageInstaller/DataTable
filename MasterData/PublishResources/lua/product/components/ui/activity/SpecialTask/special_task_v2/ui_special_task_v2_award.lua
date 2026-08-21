_class("UISpecialTaskV2Award", UICustomWidget)
UISpecialTaskV2Award = UISpecialTaskV2Award

function UISpecialTaskV2Award:OnShow(uiParams)
  self:_GetComponents()
end

function UISpecialTaskV2Award:_GetComponents()
  self._bg = self:GetUIComponent("Image", "bg")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "ImgIcon")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self._CountBg = self:GetUIComponent("Image", "CountBg")
end

function UISpecialTaskV2Award:SetData(roleAsset, callback, lock)
  self.roleAsset = roleAsset
  self._callback = callback
  self._lock = lock
  local cfg = Cfg.cfg_item[roleAsset[1]]
  local icon = cfg.Icon
  local count = roleAsset[2]
  self._imgIcon:LoadImage(icon)
  self._txtCount:SetText(self:FormatCount(count))
end

function UISpecialTaskV2Award:ImgIconOnClick(go)
  if not self._lock and self._callback then
    self._callback(self.roleAsset[1], go.transform.position)
  end
end

function UISpecialTaskV2Award:FormatCount(count)
  if count < 1000 then
    return count
  end
  return math.floor(count / 1000) .. "k"
end
