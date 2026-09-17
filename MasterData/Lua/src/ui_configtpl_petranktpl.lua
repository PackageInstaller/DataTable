local this = class("petRankTpl")

function this:init(config)
  self.data = {}
  self.previousPetData = {}
  for i, v in pairs(config) do
    if self.data[v.petId] == nil then
      self.data[v.petId] = v
    end
    if v.nextPetId ~= 0 then
      self.previousPetData[v.nextPetId] = v
    end
  end
end

function this:getPreviousRankTpl(petId)
  return self.previousPetData[petId]
end

function this:getTplById(petId)
  local group = self.data[petId]
  return group
end

function this:getchildren(petId)
  return self.data[petId]
end

function this:getEvoPerform(tpl)
  return L_Config:getPathByHash(tpl.evoPerform)
end

function this:getPetGroup(tpl)
  return tpl.petGroup
end

function this:getNextPetId(tpl)
  return tpl.nextPetId
end

function this:getLoopFrame(tpl)
  return tpl.loopFrame
end

function this:getPet1Scale(tpl)
  return tpl.pet1Scale
end

function this:getPet1Rotation(tpl)
  return tpl.pet1Rotation
end

function this:getPet2Scale(tpl)
  return tpl.pet2Scale
end

function this:getPet2Rotation(tpl)
  return tpl.pet2Rotation
end

function this:getEvolutionPre(tpl)
  return tpl.evolutionPre
end

function this:getEvolutionAfterStart(tpl)
  return tpl.evolutionAfterStart
end

function this:getEvolutionColor(tpl)
  return tpl.color1
end

function this:getRankBreakthroughItem(tpl)
  return tpl.rankBreakthroughItem
end

return this
