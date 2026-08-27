local UINActSum21ExcgResultItem = class("UINActSum21ExcgResultItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINActSum21ExcgResultItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItemWithCount.New()
  self.baseItem:Init(self.ui.uINBaseItemWithCount)
  self.baseItem:SetNotNeedAnyJump(false)
end

function UINActSum21ExcgResultItem:InitActSum21ExcgResultItem(itemId, itemNum, groupNum)
  local itemCfg = ConfigData.item[itemId]
  self.baseItem:InitItemWithCount(itemCfg, itemNum, nil, nil, nil, true)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.tex_Count:SetIndex(0, tostring(groupNum))
end

function UINActSum21ExcgResultItem:OnDelete()
  self.baseItem:Delete()
  base.OnDelete(self)
end

return UINActSum21ExcgResultItem
