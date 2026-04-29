_class("UISignInActBoxItem", UICustomWidget)
UISignInActBoxItem = UISignInActBoxItem

function UISignInActBoxItem:OnShow(uiParams)
end

function UISignInActBoxItem:SetData(index, data, callback, showName, hideNumber)
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._itemid = data.assetid
  self._itemCount = data.count
  self._callback = callback
  self._showName = showName
  self._hideNumber = hideNumber
  self:_OnValue()
end

function UISignInActBoxItem:_OnValue()
  local cfg = Cfg.cfg_item[self._itemid]
  if cfg == nil then
    Log.fatal("[quest] error --> cfg_item is nil ! id --> " .. self._itemid)
  end
  local icon = cfg.Icon
  self._icon:LoadImage(icon)
end

function UISignInActBoxItem:BgOnClick(go)
  if self._callback then
    self._callback(self._itemid, go.transform.position)
  end
end
