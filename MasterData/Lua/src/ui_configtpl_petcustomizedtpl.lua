local this = class("petCustomizedTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getPetId(tpl)
  return tpl.petId
end

function this:getName(tpl)
  return L_Config:provider(tpl._name)
end

function this:getColorParam(tpl)
  return tpl.colorParam
end

function this:getLightParam(tpl)
  return tpl.lightParam
end

function this:getSkillCountType(tpl)
  return tpl.skillCountType
end

function this:getSkillCount(tpl)
  return tpl.skillCount
end

function this:getDnaType(tpl)
  return tpl.dnaType
end

function this:getDna(tpl)
  return tpl.dna
end

function this:getSkillType(tpl)
  return tpl.skillType
end

function this:getBreakSkillList(tpl)
  return tpl.breakSkillList
end

function this:getSignatureSkillList(tpl)
  return tpl.signatureSkillList
end

function this:getSkillList(tpl)
  return tpl.skillList
end

return this
