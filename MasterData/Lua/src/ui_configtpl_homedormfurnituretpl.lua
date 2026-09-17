local this = class("homeDormFurnitureTpl")

function this:init(config)
  self.data = config
  self.heroIDs = {}
  self.herofurnitureMap = {}
  for key, value in pairs(self.data) do
    if table.containsValue(self.heroIDs, value.heroId) == false then
      table.insert(self.heroIDs, value.heroId)
    end
    if self.herofurnitureMap[value.heroId] == nil then
      self.herofurnitureMap[value.heroId] = {}
    end
    table.insert(self.herofurnitureMap[value.heroId], key)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getHeroIDs()
  return self.heroIDs
end

function this:getHerofurnitureMap()
  return self.herofurnitureMap
end

function this:getFurnitureInteract(id)
  return self.data[id].type
end

function this:getFurnitureName(id)
  return L_Config:provider(self.data[id].name)
end

function this:getFurnitureFavor(id)
  return self.data[id].value
end

return this
