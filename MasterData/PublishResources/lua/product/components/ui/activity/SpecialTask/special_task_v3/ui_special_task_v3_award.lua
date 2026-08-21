_class("UISpecialTaskV3Award", UICustomWidget)
UISpecialTaskV3Award = UISpecialTaskV3Award

function UISpecialTaskV3Award:OnShow(uiParams)
  self:_GetComponents()
end

function UISpecialTaskV3Award:_GetComponents()
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIAsset")
end

function UISpecialTaskV3Award:SetData(roleAsset, callback, lock)
  self.roleAsset = roleAsset
  self._callback = callback
  self._lock = lock
  local itemCount = self:FormatCount(self.roleAsset[2])
  local itemId = self.roleAsset[1]
  local cfg = Cfg.cfg_item[roleAsset[1]]
  local icon = cfg.Icon
  local color = cfg.Color
  self.uiItem:SetData(itemId)
  self.uiItem:SetItemData({
    text = itemCount,
    icon = icon,
    quality = color
  })
end

function UISpecialTaskV3Award:BgOnClick(go)
  if not self._lock and self._callback then
    self._callback(self.roleAsset[1], go.transform.position)
  end
end

function UISpecialTaskV3Award:FormatCount(count)
  if count < 1000 then
    return count
  end
  return math.floor(count / 1000) .. "k"
end
