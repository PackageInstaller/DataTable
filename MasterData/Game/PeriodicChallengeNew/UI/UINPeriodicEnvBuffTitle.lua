local UINPeriodicEnvBuffTitle = class("UINPeriodicEnvBuffTitle", UIBaseNode)
local base = UIBaseNode

function UINPeriodicEnvBuffTitle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.isPositive = nil
end

function UINPeriodicEnvBuffTitle:SetPositiveTitle()
  self.ui.img_EnvBuffTitle.color = self.ui.col_positive
  self.ui.tex_DebuffTitle:SetIndex(0)
  self.isPositive = true
end

function UINPeriodicEnvBuffTitle:SetNegativeTitle()
  self.ui.img_EnvBuffTitle.color = self.ui.col_negative
  self.ui.tex_DebuffTitle:SetIndex(1)
  self.isPositive = false
end

function UINPeriodicEnvBuffTitle:SetSelectNum(nowNum, maxNum)
  self.ui.tex_DebuffNum:SetIndex(0, tostring(nowNum), tostring(maxNum))
end

return UINPeriodicEnvBuffTitle
