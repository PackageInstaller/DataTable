local EpRoomEntity = class("EpRoomEntity")

function EpRoomEntity:ctor()
end

function EpRoomEntity:InitEpRoom(uiRoom, roomData, visibleEvent)
  self.uiRoom = uiRoom
  self.roomData = roomData
  self.__visibleEvent = visibleEvent
end

function EpRoomEntity:InitEpRoomInterface(roomInterface)
  self.roomInterface = roomInterface
end

function EpRoomEntity:UpdateRoomVisible()
  local visible = self.roomData:GetVisible()
  self:ShowRoom(visible)
  if visible and self.__visibleEvent ~= nil then
    self.__visibleEvent(self)
  end
end

function EpRoomEntity:ShowRoom(show)
  if show then
    self.uiRoom:Show()
  else
    self.uiRoom:Hide()
  end
  if self.roomInterface ~= nil then
    if show then
      self.roomInterface:Show()
    else
      self.roomInterface:Hide()
    end
  end
end

function EpRoomEntity:GetUIRoom()
  return self.uiRoom
end

function EpRoomEntity:ChangeRoomEntityUIState(roomTypeState)
  self:GetUIRoom():ChangeUIState(roomTypeState)
end

function EpRoomEntity:GetRoomData()
  return self.roomData
end

function EpRoomEntity:GetRoomEntityLocalPos()
  return self.uiRoom.transform.localPosition
end

function EpRoomEntity:GetRoomEntityPos()
  return self.uiRoom.transform.position
end

function EpRoomEntity:GetRoomInterface()
  return self.roomInterface
end

function EpRoomEntity:OnDelete()
  if self.uiRoom ~= nil then
    self.uiRoom:Delete()
  end
end

return EpRoomEntity
