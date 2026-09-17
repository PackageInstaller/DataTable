local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    furnitureDatas = {}
  }
end

function this:getFurnitureData(guid)
  return self.data.furnitureDatas[guid]
end

function this:getFurnitureDatas()
  return self.data.furnitureDatas
end

return this
