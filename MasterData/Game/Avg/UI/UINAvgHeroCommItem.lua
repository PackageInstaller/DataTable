local UINAvgHeroCommItem = class("UINAvgHeroCommItem", UIBaseNode)
local base = UIBaseNode

function UINAvgHeroCommItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINAvgHeroCommItem:InitAvgHeroCommItem(localPos, heroTransform)
  self.transform:SetParent(heroTransform.parent, true)
  self.transform.localPosition = localPos
  heroTransform:SetParent(self.ui.mask)
end

function UINAvgHeroCommItem:OnDelete()
  base.OnDelete(self)
end

return UINAvgHeroCommItem
