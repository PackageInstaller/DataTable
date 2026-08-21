_class("UILuckLandRewardItem", UICustomWidget)
UILuckLandRewardItem = UILuckLandRewardItem

function UILuckLandRewardItem:OnShow(uiParams)
  self:_InitWidget()
end

function UILuckLandRewardItem:_InitWidget()
  self._item = self:GetUIComponent("UISelectObjectPath", "Item")
end

function UILuckLandRewardItem:SetData(data, showTips)
  self._data = data
  self._showTips = showTips
  local cfgItem = Cfg.cfg_item[self._data.assetid]
  if cfgItem then
    local awardData = {}
    awardData.id = cfgItem.ID
    awardData.icon = cfgItem.Icon
    awardData.color = cfgItem.Color
    awardData.count = tostring(self._data.count)
    awardData.type = self._data.type
    self._itemWidget = self._item:SpawnObject("UIAwardItem")
    self._itemWidget:Flush(awardData)
  end
end

function UILuckLandRewardItem:TipsBtnOnClick(go)
  self._showTips(self._data.assetid, go.transform.position)
end
