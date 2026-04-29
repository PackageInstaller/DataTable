_class("UIActivityNewYearLuckBagAwardItem", UICustomWidget)
UIActivityNewYearLuckBagAwardItem = UIActivityNewYearLuckBagAwardItem

function UIActivityNewYearLuckBagAwardItem:OnShow()
  self._assetParent = self:GetUIComponent("UISelectObjectPath", "Asset")
end

function UIActivityNewYearLuckBagAwardItem:SetData(tb, clickCallback)
  self._tb = tb
  self._clickCallback = clickCallback
  self._asset = self._assetParent:SpawnObject("UIAsset")
  self._asset:SetData(tb.assetid)
  self._asset:SetItemData({
    showBG = true,
    icon = tb.icon,
    text = tb.count,
    quality = tb.quality
  })
end

function UIActivityNewYearLuckBagAwardItem:EmptyBtnOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._tb.assetid, go.transform.position)
  end
end
