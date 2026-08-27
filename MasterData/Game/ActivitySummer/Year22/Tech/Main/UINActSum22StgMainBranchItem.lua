local base = UIBaseNode
local UINActSum22StgMainBranchItem = class("UINActSum22StgMainBranchItem", base)

function UINActSum22StgMainBranchItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActSum22StgMainBranchItem:InitActSum22StgMainBranchItem()
end

function UINActSum22StgMainBranchItem:OnDelete()
  base.OnDelete(self)
end

return UINActSum22StgMainBranchItem
