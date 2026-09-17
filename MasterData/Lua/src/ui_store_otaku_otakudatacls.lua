local this = {}
local dataCls = {}
local otakuFurnitureData = class("otakuFurnitureData")
dataCls.otakuFurnitureData = otakuFurnitureData

function otakuFurnitureData:ctor(guid)
  self.guid = guid
  self.id = 0
  self.surface = 0
  self.x = 0
  self.y = 0
  self.rotation = 0
end

this.dataCls = dataCls
return this
