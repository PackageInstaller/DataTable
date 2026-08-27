local UINFairyLotteryNormalItem = class("UINFairyLotteryNormalItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINFairyLotteryNormalItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__item = UINBaseItemWithCount.New()
  self.__item:Init(self.ui.uINBaseItemWithCount)
end

function UINFairyLotteryNormalItem:InitFLNormalItem(itemId, itemNum)
  local itemCfg = ConfigData.item[itemId]
  self.__item:InitItemWithCount(itemCfg, itemNum)
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(itemCfg.name)
end

function UINFairyLotteryNormalItem:OnDelete()
end

return UINFairyLotteryNormalItem
