local UINWATechConditionItem = class("UINWATechConditionItem", UIBaseNode)
local base = UIBaseNode

function UINWATechConditionItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWATechConditionItem:InitStOConditonItem(text, isComplete)
  self.ui.tex_Condition.text = text
  if isComplete then
    self.ui.img_Root:SetIndex(1)
  else
    self.ui.img_Root:SetIndex(0)
  end
end

function UINWATechConditionItem:OnDelete()
  base.OnDelete(self)
end

return UINWATechConditionItem
