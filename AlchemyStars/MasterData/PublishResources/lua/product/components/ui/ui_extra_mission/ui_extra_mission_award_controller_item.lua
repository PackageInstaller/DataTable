_class("UIExtraMissionAwardControllerItem", UICustomWidget)
UIExtraMissionAwardControllerItem = UIExtraMissionAwardControllerItem
local maxNumCount = 5

function UIExtraMissionAwardControllerItem:OnShow(uiParams)
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._index = -1
  self._pstid = -1
  self._itemCount = 0
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self.uiItem:SetClickCallBack(function(go)
    self:itemOnClick(go)
  end)
end

function UIExtraMissionAwardControllerItem:SetData(itemInfo, index, clickCallback, nameColor)
  self._index = index
  self._templateData = itemInfo
  self._item_id = self._templateData.item_id
  local text2Color = nameColor
  local text2 = StringTable.Get(self._templateData.item_name)
  local quality = self._templateData.color
  self._itemCount = self._templateData.item_count
  local icon = self._templateData.icon
  local tex = self:FormatItemCount(self._itemCount)
  local text1 = tex
  local itemId = self._templateData.id
  self._clickCallback = clickCallback
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    text2 = text2,
    text2Color = text2Color,
    itemId = itemId
  })
end

function UIExtraMissionAwardControllerItem:itemOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if not self._templateData then
    return
  end
  if self._clickCallback then
    self._rect:DOPunchScale(Vector3(0.1, 0.1, 0.1), 0.2)
    self._clickCallback(self._item_id, go.transform.position)
  end
end

function UIExtraMissionAwardControllerItem:GetIndex()
  return self._index
end

function UIExtraMissionAwardControllerItem:FormatItemCount(count)
  local tex = HelperProxy:GetInstance():FormatItemCount(count)
  return tex
end
