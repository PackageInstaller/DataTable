local UINMlstShetBandListEmptyHeroItem = {}
local base = UIBaseNode
local UINMlstShetBandListEmptyHeroItem = class("UINMlstShetBandListEmptyHeroItem", base)

function UINMlstShetBandListEmptyHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINMlstShetBandListEmptyHeroItem:InitMlstShetBandListEmptyHeroItem(num)
  self.ui.tex_Num.text = tostring(num)
end

function UINMlstShetBandListEmptyHeroItem:OnDelete()
  base.OnDelete(self)
end

return UINMlstShetBandListEmptyHeroItem
