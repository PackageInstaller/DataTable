local UITrainingStateAttriItem = class("UITrainingStateAttriItem", UIBaseNode)
local base = UIBaseNode

function UITrainingStateAttriItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UITrainingStateAttriItem:SetAttriIndex(index, ...)
  self.ui.tex_AttriName:SetIndex(index, ...)
end

function UITrainingStateAttriItem:OnDelete()
  base.OnDelete(self)
end

return UITrainingStateAttriItem
