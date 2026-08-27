local UINFactoryHeroListCardAccItem = class("UINFactoryHeroListCardAccItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UINFactoryHeroListCardAccItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFactoryHeroListCardAccItem:SetValue(index, speed, accRate)
  self.ui.tex_Name:SetIndex(index)
  local value = GetPreciseDecimalStr(speed * accRate * 3600, 1)
  self.ui.tex_Timer:SetIndex(0, tostring(value))
end

function UINFactoryHeroListCardAccItem:OnDelete()
  base.OnDelete(self)
end

return UINFactoryHeroListCardAccItem
