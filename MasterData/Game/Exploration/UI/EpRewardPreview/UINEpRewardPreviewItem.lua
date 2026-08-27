local UINEpRewardPreviewItem = class("UINEpRewardPreviewItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINEpRewardPreviewItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItemWithCount.New()
  self.baseItem:Init(self.ui.baseItemWithCount)
end

function UINEpRewardPreviewItem:InitEpRewardPreviewItem(index, previewData)
  self.index = index
  local itemCfg = previewData.itemCfg
  local itemNum = previewData.itemNum
  self.baseItem:InitItemWithCount(itemCfg, itemNum)
  if previewData.moneyIcon ~= nil then
    self.ui.img_Money.sprite = previewData.moneyIcon
  end
  self.ui.tex_Money.text = previewData.priceStr
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.img_QuailtyColor.color = ItemQualityColor[itemCfg.quality]
end

function UINEpRewardPreviewItem:OnDelete()
  self.baseItem:Delete()
  self.baseItem = nil
  base.OnDelete(self)
end

return UINEpRewardPreviewItem
