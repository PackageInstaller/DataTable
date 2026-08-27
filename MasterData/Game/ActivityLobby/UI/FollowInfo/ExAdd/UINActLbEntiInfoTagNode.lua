local UINActLbEntiInfoTagNode = class("UINActLbEntiInfoTagNode", UIBaseNode)
local base = UIBaseNode

function UINActLbEntiInfoTagNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActLbEntiInfoTagNode:InitActLbEntiInfoTagNode(index)
  self.ui.bottom:SetIndex(index - 1)
  self.ui.img_Icon:SetIndex(index - 1)
  self.ui.tex_TagName:SetIndex(index - 1)
end

function UINActLbEntiInfoTagNode:OnDelete()
end

return UINActLbEntiInfoTagNode
