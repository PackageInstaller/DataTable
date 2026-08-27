local UINBattleResultExtraItem = class("UINBattleResultExtraItem", UIBaseNode)
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINBattleResultExtraItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItemWithCount.New()
  self.baseItem:Init(self.ui.uINBaseItem)
end

function UINBattleResultExtraItem:InitBattleExtraReward(itemCfg, num)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.baseItem:InitItemWithCount(itemCfg, num)
end

function UINBattleResultExtraItem:OnDelete()
end

return UINBattleResultExtraItem
