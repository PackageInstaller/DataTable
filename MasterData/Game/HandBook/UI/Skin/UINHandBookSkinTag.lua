local UINHandBookSkinTag = class("UINHandBookSkinTag", UIBaseNode)
local base = UIBaseNode

function UINHandBookSkinTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHandBookSkinTag:InitBookSkinTag(index)
  self.ui.tex_Tag:SetIndex(index - 1)
  self.ui.img_Tag.color = self.ui.color_tag[index]
end

return UINHandBookSkinTag
