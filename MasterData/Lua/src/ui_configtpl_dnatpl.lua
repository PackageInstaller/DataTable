local this = class("dnaTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getInitCondition(tpl)
  return tpl.initCondition
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getType(tpl)
  return tpl.type
end

function this:getIcon(tpl)
  local icon = tpl.icon
  return icon
end

function this:getIconRainbow(tpl)
  local icon = tpl.iconRainbow
  return icon
end

function this:getId(tpl)
  return tpl.id
end

function this:getLength(tpl)
  return tpl.mod
end

function this:getSkill(tpl)
  return tpl.skill
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getGradeScore(tpl)
  return tpl.gradeScore
end

function this:getType(tpl)
  return tpl.type
end

function this:getIconFrame(tpl)
  local icon = L_Config:getPathByHash(tpl.iconFrame)
  return icon
end

function this:getIconEffect(tpl)
  local icon = L_Config:getPathByHash(tpl.iconEffect)
  return icon
end

function this:getIconCodition(tpl)
  local icon = L_Config:getPathByHash(tpl.iconCondition)
  return icon
end

function this:getIsRarity(tpl)
  return tpl.isRarity
end

function this:getDnaType(tpl)
  return tpl.type
end

function this:getNestCoopTag(tpl)
  return tpl.nestCoopTag
end

function this:getTalentDnaType(tpl)
  return tpl.talentDnaType
end

return this
