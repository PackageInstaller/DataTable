local this = class("trialPetTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTrialPetDna(tpl)
  return tpl.trialPetDna
end

function this:getTrialPethobby(tpl)
  return tpl.trialPethobby
end

function this:getId(tpl)
  return tpl.id
end

function this:getTrialPetLevel(tpl)
  return tpl.trialPetLevel
end

function this:getTrialPet(tpl)
  return tpl.trialPet
end

function this:getTrialPetLearning(tpl)
  return tpl.trialPetLearning
end

function this:getTrialPetName(tpl)
  return tpl.name
end

return this
