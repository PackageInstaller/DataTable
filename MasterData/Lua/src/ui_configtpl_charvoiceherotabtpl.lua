local this = class("charVoiceHeroTabTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDetailsDelay(tpl)
  return tpl.detailsDelay
end

function this:getSkillVoice(tpl)
  return tpl.skillVoice
end

function this:getDataDelay(tpl)
  return tpl.dataDelay
end

function this:getDataVoice(tpl)
  return tpl.dataVoice
end

function this:getBreakDelay(tpl)
  return tpl.breakDelay
end

function this:getSoulEssenceDelay(tpl)
  return tpl.soulEssenceDelay
end

function this:getEquipDelay(tpl)
  return tpl.equipDelay
end

function this:getId(tpl)
  return tpl.id
end

function this:getSoulEssenceVoice(tpl)
  return tpl.soulEssenceVoice
end

function this:getDetailsVoice(tpl)
  return tpl.detailsVoice
end

function this:getEquipVoice(tpl)
  return tpl.equipVoice
end

function this:getName(tpl)
  return tpl.name
end

function this:getSkillDelay(tpl)
  return tpl.skillDelay
end

function this:getBreakVoice(tpl)
  return tpl.breakVoice
end

return this
