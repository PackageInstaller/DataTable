local this = class("skillsubLogicTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getAttackCheckAngleR(tpl)
  return tpl.attackCheckAngleR
end

function this:getkiBoVersusCoolDown(tpl)
  return tpl.kiBoVersusCoolDown
end

function this:getCoolDown(tpl)
  return tpl.coolDown
end

function this:getSprintMin(tpl)
  return tpl.sprintMin
end

function this:getAttackCheckAngleL(tpl)
  return tpl.attackCheckAngleL
end

function this:getAiTokenResetCD(tpl)
  return tpl.aiTokenResetCD
end

function this:getSelfCD(tpl)
  return tpl.selfCD
end

function this:getSkillTag(tpl)
  return tpl.skillTag
end

function this:getConditionValue(tpl)
  return tpl.conditionValue
end

function this:getCastPriority(tpl)
  return tpl.castPriority
end

function this:getUseDirection(tpl)
  return tpl.useDirection
end

function this:getLockAlertRange(tpl)
  return tpl.lockAlertRange
end

function this:getPriority(tpl)
  return tpl.priority
end

function this:getPublicCDGroup(tpl)
  return tpl.publicCDGroup
end

function this:getRndCoolDownDefaultMax(tpl)
  return tpl.rndCoolDownDefaultMax
end

function this:getTargetType(tpl)
  return tpl.targetType
end

function this:getRndCoolDownMax(tpl)
  return tpl.rndCoolDownMax
end

function this:getCoolDownCountDefault(tpl)
  return tpl.coolDownCountDefault
end

function this:getIndicator(tpl)
  return tpl.indicator
end

function this:getSelfCDGroup(tpl)
  return tpl.selfCDGroup
end

function this:getAttackCheckMinDirection(tpl)
  return tpl.attackCheckMinDirection
end

function this:getSpCost(tpl)
  return tpl.spCost
end

function this:getCastPriorityWeight(tpl)
  return tpl.castPriorityWeight
end

function this:getLockRange(tpl)
  return tpl.lockRange
end

function this:getConditionType(tpl)
  return tpl.conditionType
end

function this:getCoolDownCount(tpl)
  return tpl.coolDownCount
end

function this:getAiToken(tpl)
  return tpl.aiToken
end

function this:getDirectionType(tpl)
  return tpl.directionType
end

function this:getSkillLogicType(tpl)
  return tpl.skillLogicType
end

function this:getSkillId(tpl)
  return tpl.skillId
end

function this:getGCD(tpl)
  return tpl.GCD
end

function this:getPublicCD(tpl)
  return tpl.publicCD
end

function this:getSprintMax(tpl)
  return tpl.sprintMax
end

function this:getAiTokenType(tpl)
  return tpl.aiTokenType
end

function this:getCoolDownDefault(tpl)
  return tpl.coolDownDefault
end

function this:getAttackCheckMaxDirection(tpl)
  return tpl.attackCheckMaxDirection
end

function this:getIndicatorValue(tpl)
  return tpl.indicatorValue
end

function this:getLockAngle(tpl)
  return tpl.lockAngle
end

function this:getAllowSprint(tpl)
  return tpl.allowSprint
end

function this:getPetSkillLogicTag(tpl)
  return tpl.petSkillLogicTag
end

return this
