local UINPeriodicDebuffTitle = class("UINPeriodicDebuffTitle", UIBaseNode)
local base = UIBaseNode

function UINPeriodicDebuffTitle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINPeriodicDebuffTitle:SetDebuffTitle(titleId)
  self.ui.tex_DebuffTitle.text = ConfigData:GetTipContent(titleId)
end

return UINPeriodicDebuffTitle
