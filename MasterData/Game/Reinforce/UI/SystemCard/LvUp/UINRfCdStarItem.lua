local base = UIBaseNode
local UINRfCdStarItem = class("UINRfCdStarItem", base)

function UINRfCdStarItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINRfCdStarItem:InitRfCdStarItem(isCurStar)
  self.ui.img.color = self.ui.color[isCurStar and 1 or 2]
end

function UINRfCdStarItem:OnDelete()
  base.OnDelete(self)
end

return UINRfCdStarItem
