_class("UIOpenGiftGetMatItem", UICustomWidget)
UIOpenGiftGetMatItem = UIOpenGiftGetMatItem
local maxNumCount = 5

function UIOpenGiftGetMatItem:OnShow(uiParams)
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._index = -1
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self.uiItem:SetClickCallBack(function(go)
    self:itemOnClick(go)
  end)
end

function UIOpenGiftGetMatItem:SetData(index, itemid, itemcount, clickCallback)
  self._index = index
  local itemCount = itemcount
  self._itemId = itemid
  local cfg = Cfg.cfg_item[self._itemId]
  if not cfg then
    Log.error("###[UIOpenGiftGetMatItem] cfg is nil ! id --> ", self._itemId)
  end
  local text2 = StringTable.Get(cfg.Name)
  local quality = cfg.Color
  local icon = cfg.Icon
  local text1 = self:FormatItemCount(itemCount)
  local des = cfg.Des
  self._clickCallback = clickCallback
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    text2 = text2,
    itemId = self._itemId,
    des = des
  })
end

function UIOpenGiftGetMatItem:itemOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._clickCallback then
    self._rect:DOPunchScale(Vector3(0.1, 0.1, 0.1), 0.2)
    self._clickCallback(self._itemId, go.transform.position)
  end
end

function UIOpenGiftGetMatItem:FormatItemCount(count)
  local tex = HelperProxy:GetInstance():FormatItemCount(count)
  return tex
end
