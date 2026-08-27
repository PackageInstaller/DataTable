local UINDmRoomResHolder = class("UINDmRoomResHolder", UIBaseNode)
local base = UIBaseNode

function UINDmRoomResHolder:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINDmRoomResHolder:InitDmRoomResHolder()
end

function UINDmRoomResHolder:RefreshDmRoomResHolderPos(position)
  local anchorPos = UIManager:World2UIPosition(position)
  self.transform.anchoredPosition = anchorPos
end

function UINDmRoomResHolder:OnDelete()
  base.OnDelete(self)
end

return UINDmRoomResHolder
