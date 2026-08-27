local base = UIBaseNode
local UINFairyQkLvStarItem = class("UINFairyQkLvStarItem", base)

function UINFairyQkLvStarItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFairyQkLvStarItem:InitFairyQkLvStarItem(colorIdx)
  self.ui.img.color = self.ui.colorList[colorIdx]
end

function UINFairyQkLvStarItem:OnDelete()
  base.OnDelete(self)
end

return UINFairyQkLvStarItem
