local UINFriendshipSortKindItem = class("UINFriendshipSortKindItem", UIBaseNode)
local base = UIBaseNode

function UINFriendshipSortKindItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_sortKindItem, self, self.onItemValueChange)
end

function UINFriendshipSortKindItem:InitSortItem(name, callBack)
  self.ui.tex_KindName.text = name
  self.callBack = callBack
end

function UINFriendshipSortKindItem:onItemValueChange(bool)
  if self.callBack ~= nil then
    self.callBack(bool)
  end
end

function UINFriendshipSortKindItem:OnDelete()
  base.OnDelete(self)
end

return UINFriendshipSortKindItem
