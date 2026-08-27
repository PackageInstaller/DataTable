local base = UIBaseNode
local UINActCommonMonsterCardLeftNode_DesItem = class("UINActCommonMonsterCardLeftNode_DesItem", base)

function UINActCommonMonsterCardLeftNode_DesItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActCommonMonsterCardLeftNode_DesItem:Set_ACMCLNID_Des(des)
  self.ui.Tex_Des.text = des
end

function UINActCommonMonsterCardLeftNode_DesItem:OnDelete()
  base.OnDelete(self)
end

return UINActCommonMonsterCardLeftNode_DesItem
