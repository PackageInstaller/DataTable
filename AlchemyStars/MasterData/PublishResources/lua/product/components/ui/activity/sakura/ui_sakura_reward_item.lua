_class("UISakuraRewardItem", UICustomWidget)
UISakuraRewardItem = UISakuraRewardItem

function UISakuraRewardItem:OnShow(uiParams)
  self:InitWidget()
end

function UISakuraRewardItem:InitWidget()
  self._uiItem = self:GetUIComponent("UISelectObjectPath", "uiitem")
end

function UISakuraRewardItem:SetData(data, callback)
  self._item = self._uiItem:SpawnObject("UIItem")
  self._item:SetForm(UIItemForm.Base, UIItemScale.Level3)
  self._item:SetClickCallBack(function(go)
    self:ShowTips(go)
  end)
  self._itemid = data.id
  self._itemCount = data.count
  self._callback = callback
  self:_OnValue()
end

function UISakuraRewardItem:_OnValue()
  local cfg = Cfg.cfg_item[self._itemid]
  if cfg == nil then
    Log.fatal("cfg_item is nil." .. self._itemid)
  end
  local icon = cfg.Icon
  local quality = cfg.Color
  local text1 = self._itemCount
  self._item:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    itemId = self._itemid
  })
end

function UISakuraRewardItem:ShowTips(go)
  if self._callback then
    self._callback(self._itemid, go.transform.position)
  end
end
