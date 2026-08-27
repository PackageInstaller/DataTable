local UINAthEmptyAffix = class("UINAthEmptyAffix", UIBaseNode)
local base = UIBaseNode

function UINAthEmptyAffix:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINAthEmptyAffix:InitAthEmptyAffix(parent, ratio)
  self.transform:SetParent(parent)
  if ratio == nil then
    self.ui.img_Buttom:SetIndex(0)
  else
    self.ui.img_Buttom:SetIndex(1)
    self.ui.tex_Rate:SetIndex(0, GetPreciseDecimalStr(ratio * 100, 1))
  end
  self.ui.tex_Rate.gameObject:SetActive(ratio ~= nil)
end

function UINAthEmptyAffix:OnDelete()
  base.OnDelete(self)
end

return UINAthEmptyAffix
