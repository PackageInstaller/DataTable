local this = class("petInterimTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getSkillList(tpl)
  return tpl.skillList
end

function this:getParam(tpl)
  return tpl.param
end

function this:getSignatureSkillList(tpl)
  return tpl.signatureSkillList
end

function this:getSpeed(tpl)
  return tpl.speed
end

function this:getId(tpl)
  return tpl.id
end

function this:getFPropertyskillList(tpl)
  return tpl.fPropertyskillList
end

function this:getDnaList(tpl)
  return tpl.dnaList
end

function this:getHomeTalent(tpl)
  return tpl.homeTalent
end

function this:getFixedSkillList(tpl)
  return tpl.fixedSkillList
end

function this:getPetLevel(tpl)
  return tpl.petLevel
end

function this:getPetGrade(tpl)
  return tpl.petGrade
end

function this:getName(tpl)
  return tpl.name
end

function this:getFeature(tpl)
  return tpl.feature
end

function this:getPetId(tpl)
  return tpl.petId
end

function this:getBreakskillList(tpl)
  return tpl.breakskillList
end

return this
