local base = UIBaseNode
local UINActBlackHoleFairyItem = class("UINActBlackHoleFairyItem", base)
local UINFairyHeadItem = require("Game.Fairy.UI.Common.UINFairyHeadItem")

function UINActBlackHoleFairyItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.fairyItem = UINFairyHeadItem.New()
  self.fairyItem:Init(self.ui.fairyHeadItem)
end

function UINActBlackHoleFairyItem:InitActBlackHoleFairyItem(fairyData, resloader)
  self.fairyItem:InitFairyHeadItem(fairyData, resloader)
end

function UINActBlackHoleFairyItem:OnDelete()
  self.fairyItem:Delete()
end

return UINActBlackHoleFairyItem
