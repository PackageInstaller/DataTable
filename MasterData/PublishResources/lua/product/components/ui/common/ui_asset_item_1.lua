_class("UIAssetItem1", UICustomWidget)
UIAssetItem1 = UIAssetItem1

function UIAssetItem1:OnShow(uiParams)
  self:InitWidget()
end

function UIAssetItem1:InitWidget()
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Stage, UIItemScale.Level3)
  self.uiItem:SetClickCallBack(function(go)
    self:clickAreaOnClick(go)
  end)
end

function UIAssetItem1:SetData(itemID, text, onClick, count)
  local cfg = Cfg.cfg_item[itemID]
  self.onClick = onClick
  self._id = itemID
  local icon = cfg.Icon
  local quality = cfg.Color
  local awardText = text
  self.uiItem:SetData({
    icon = icon,
    text1 = count,
    quality = quality,
    awardText = awardText,
    itemId = itemID
  })
end

function UIAssetItem1:clickAreaOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self.onClick then
    self.onClick(self._id, go.transform.position)
  end
end
