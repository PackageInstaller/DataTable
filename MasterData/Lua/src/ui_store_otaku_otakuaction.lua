local this = {}

function this:putFurniture(fid, surfaceId, x, y, r)
  local guid = #self.data.furnitureDatas + 1
  local furniture = self.dataCls.otakuFurnitureData.new(guid)
  furniture.id = fid
  furniture.surface = surfaceId
  furniture.x = x
  furniture.y = y
  furniture.rotation = r
  self.data.furnitureDatas[guid] = furniture
  self:call(self.event.furnitureUpdate)
end

return this
