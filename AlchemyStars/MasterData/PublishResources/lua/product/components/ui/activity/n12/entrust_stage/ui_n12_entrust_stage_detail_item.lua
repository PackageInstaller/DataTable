_class("UIN12EntrustStageDetailItem", UICustomWidget)
UIN12EntrustStageDetailItem = UIN12EntrustStageDetailItem

function UIN12EntrustStageDetailItem:SetData(roleAsset, received, callback, scale)
  self._scale = scale or UIItemScale.Level2
  self._roleAsset = roleAsset
  self._callback = callback
  local cfg_item = Cfg.cfg_item[self._roleAsset.assetid]
  if cfg_item == nil then
    Log.fatal("UIN12EntrustStageDetailItem:SetData() error --> cfg_item is nil ! id --> " .. self._roleAsset.assetid)
    return
  end
  self._cg = cfg_item.Icon
  self._colorEnum = cfg_item.Color
  self:_SetUIItem(received)
  self:_SetReceived(received)
end

function UIN12EntrustStageDetailItem:_SetUIItem(received)
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base, self._scale)
  self.uiItem:SetClickCallBack(function(go)
    self:BtnOnClick(go)
  end)
  local icon = self._cg
  local _iconGrey = received and 1 or 0
  local quality = self._colorEnum
  local text1 = self._roleAsset.count
  self.uiItem:SetData({
    icon = icon,
    iconGrey = _iconGrey,
    quality = quality,
    text1 = text1,
    itemId = self._roleAsset.assetid
  })
end

function UIN12EntrustStageDetailItem:_SetReceived(show)
  local obj = self:GetGameObject("state_Taken")
  obj:SetActive(show)
end

function UIN12EntrustStageDetailItem:BtnOnClick(go)
  if self._callback then
    self._callback(self._roleAsset.assetid, go.transform.position)
  end
end
