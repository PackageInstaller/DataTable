local UINChipGiftRewardItem = class("UINChipGiftRewardItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINChipGiftRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemIcon = UINBaseItemWithCount.New()
  self.itemIcon:Init(self.ui.uINBaseItemWithCount)
  self.itemIcon:SetNotNeedAnyJump(true)
end

function UINChipGiftRewardItem:InitChipGiftReward(itemId, itemCount)
  local itemCfg = ConfigData.item[itemId]
  self.itemIcon:InitItemWithCount(itemCfg, itemCount)
  self.ui.tex_itemName.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(itemCfg.describe)
end

return UINChipGiftRewardItem
