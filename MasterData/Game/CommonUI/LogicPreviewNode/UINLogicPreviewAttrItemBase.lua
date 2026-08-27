local UINLogicPreviewAttrItemBase = class("UINLogicPreviewAttrItemBase", UIBaseNode)
local base = UIBaseNode

function UINLogicPreviewAttrItemBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLogicPreviewAttrItemBase:InitAttrItem(str, white, customColor)
  self.ui.tex_Attri.text = str
  if customColor == nil then
    self.ui.tex_Attri.color = white and Color.white or self.ui.normalColor
  else
    self.ui.tex_Attri.color = customColor
  end
end

function UINLogicPreviewAttrItemBase:OnDelete()
  base.OnDelete(self)
end

return UINLogicPreviewAttrItemBase
