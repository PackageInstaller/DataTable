local UINHeroTag = class("UINHeroTag", UIBaseNode)
local base = UIBaseNode

function UINHeroTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHeroTag:InitTag(index)
  self.ui.tex_Tag:SetIndex(index, "")
end

function UINHeroTag:OnDelete()
  base.OnDelete(self)
end

return UINHeroTag
