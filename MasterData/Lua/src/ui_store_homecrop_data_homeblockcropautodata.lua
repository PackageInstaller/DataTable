local this = class("homeBlockCropAutoData")

function this:ctor(blockId)
  self.block_id = blockId
  self.plant_pet = 0
  self.water_pet = 0
  self.harvest_pet = 0
  self.seeds = {}
  self.crops = {}
end

function this:populate(data)
  printf("populate星语树洞", data)
  self.plant_pet = data.plant_pet
  self.water_pet = data.water_pet
  self.harvest_pet = data.harvest_pet
  self.seeds = data.seeds or {}
  table.sort(self.seeds, function(a, b)
    return a.guid < b.guid
  end)
  self.crops = data.crops or {}
end

function this:getWorkPet(workType)
  if workType == L_HomeConst.homeLaborType.WATER then
    return self.water_pet
  elseif workType == L_HomeConst.homeLaborType.PLANT then
    return self.plant_pet
  elseif workType == L_HomeConst.homeLaborType.HARVEST then
    return self.harvest_pet
  end
end

return this
