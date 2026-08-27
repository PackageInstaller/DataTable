local UINStOUnlockConditionItem = class("UINStOUnlockConditionItem", UIBaseNode)
local base = UIBaseNode

function UINStOUnlockConditionItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINStOUnlockConditionItem:InitStOUnlockConditionItem(ok, conditionStr)
  self.ui.img_Root:SetIndex(ok and 1 or 0)
  self.ui.tex_Condition.text = conditionStr
end

function UINStOUnlockConditionItem:OnDelete()
  base.OnDelete(self)
end

return UINStOUnlockConditionItem
