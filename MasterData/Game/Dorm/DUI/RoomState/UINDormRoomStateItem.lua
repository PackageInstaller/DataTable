local UINDormRoomStateItem = class("UINDormRoomStateItem", UIBaseNode)
local base = UIBaseNode

function UINDormRoomStateItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINDormRoomStateItem:InitDmRoomStateItem(anchorPos)
  self.transform.anchoredPosition = anchorPos
end

function UINDormRoomStateItem:OnDelete()
  base.OnDelete(self)
end

return UINDormRoomStateItem
