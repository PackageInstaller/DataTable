_class("UIPerfectPuzzleRewardItem", UICustomWidget)
UIPerfectPuzzleRewardItem = UIPerfectPuzzleRewardItem

function UIPerfectPuzzleRewardItem:OnShow(uiParams)
  self:InitWidget()
end

function UIPerfectPuzzleRewardItem:InitWidget()
  self.item = self:GetUIComponent("UISelectObjectPath", "Item")
end

function UIPerfectPuzzleRewardItem:SetData(cfgData, tipsCallback)
  self._roleAsset = cfgData
  self.tipsCallback = tipsCallback
  local cfg_item = Cfg.cfg_item[self._roleAsset.assetid]
  if cfg_item == nil then
    Log.fatal("[quest] error --> cfg_item is nil ! id --> " .. self._roleAsset.assetid)
    return
  end
  self.uiItem = self.item:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base, UIItemScale.Level3)
  local icon = cfg_item.Icon
  local quality = cfg_item.Color
  local text1 = self._roleAsset.count
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    itemId = self._roleAsset.assetid
  })
end

function UIPerfectPuzzleRewardItem:TipsBtnOnClick(go)
  if self.tipsCallback then
    self.tipsCallback(self._roleAsset.assetid, Vector3(0.5, go.transform.position.y - 0.3, 0))
  end
end
