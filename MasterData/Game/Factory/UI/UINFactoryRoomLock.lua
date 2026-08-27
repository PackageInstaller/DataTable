local UINFactoryRoomLock = class("UINFactoryRoomLock", UIBaseNode)
local base = UIBaseNode
local OFFSET = Vector3.New(0, 1, 0)

function UINFactoryRoomLock:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFactoryRoomLock:InitLock(roomEntity)
  self.roomEntity = roomEntity
  if roomEntity.unlcokDes ~= nil then
    self.ui.tex_Condition.gameObject:SetActive(true)
    self.ui.tex_Condition:SetIndex(0, roomEntity.unlcokDes)
  else
    self.ui.tex_Condition.gameObject:SetActive(false)
  end
  self:Set2RoomPos()
end

function UINFactoryRoomLock:Set2RoomPos()
  local UIPos = UIManager:World2UIPosition(self.roomEntity.transform.position + OFFSET)
  self.transform.localPosition = Vector2.New(UIPos.x, UIPos.y)
end

function UINFactoryRoomLock:OnDelete()
  base.OnDelete(self)
end

return UINFactoryRoomLock
