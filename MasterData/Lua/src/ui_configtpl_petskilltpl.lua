local this = class("petSkillTpl")

function this:init(config)
  self.data = config
  self.petData = {}
  for _, v in pairs(config) do
    if not self.petData[v.petId] then
      self.petData[v.petId] = {}
    end
    self.petData[v.petId][v.skillLevel] = v
  end
end

function this:getPetLevels(configId)
  return self.petData[configId]
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getSkillReduce(tpl)
  return tpl.skillReduce
end

function this:getSkillAdd(tpl)
  return tpl.skillAdd
end

function this:getPetLevel(tpl)
  return tpl.petLevel
end

function this:getSkillLevel(tpl)
  return tpl.skillLevel
end

function this:getPetId(tpl)
  return tpl.petId
end

function this:getName(tpl)
  return tpl.name
end

return this
