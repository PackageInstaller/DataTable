local DynEpMapColType = class("DynEpMapColType")

function DynEpMapColType:ctor(mapData, x, trackType, maxRoomCount)
  self.x = x
  self.trackType = trackType
  self.maxRoomCount = maxRoomCount
  self.isMaxWidthCol = mapData.width == maxRoomCount
end

return DynEpMapColType
