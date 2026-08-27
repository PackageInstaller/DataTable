local UINLtrPoolDetailTog = class("UINLtrPoolDetailTog", UIBaseNode)
local base = UIBaseNode

function UINLtrPoolDetailTog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLtrPoolDetailTog:ChangeLtrPoolDetailTogState(isOn)
  self.ui.tex_Name.color = isOn and Color.black or Color.gray
  self.ui.img_Buttom.enabled = isOn
end

function UINLtrPoolDetailTog:OnDelete()
  base.OnDelete(self)
end

return UINLtrPoolDetailTog
