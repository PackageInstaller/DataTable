local this = class("summonedTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getBackupSkillList(tpl)
  return tpl.backupSkillList
end

function this:getCounterAttackRange(tpl)
  return tpl.counterAttackRange
end

function this:getPassiveSkillList(tpl)
  return tpl.passiveSkillList
end

function this:getId(tpl)
  return tpl.id
end

function this:getBattleWidth(tpl)
  return tpl.battleWidth
end

function this:getIsStopPlayer(tpl)
  return tpl.isStopPlayer
end

function this:getAttackRange(tpl)
  return tpl.attackRange
end

function this:getFormationGap(tpl)
  return tpl.formationGap
end

function this:getFormationWidth(tpl)
  return tpl.formationWidth
end

function this:getUnitId(tpl)
  return tpl.unitId
end

function this:getBehaviorFormation(tpl)
  return tpl.behaviorFormation
end

function this:getMorale(tpl)
  return tpl.morale
end

function this:getAttackSkill(tpl)
  return tpl.attackSkill
end

function this:getStrategyPreference(tpl)
  return tpl.strategyPreference
end

function this:getFormationId(tpl)
  return tpl.formationId
end

function this:getSkillList(tpl)
  return tpl.skillList
end

function this:getSkillBytesPath(tpl)
  return tpl.skillBytesPath
end

function this:getChaos(tpl)
  return tpl.chaos
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getIsInstance(tpl)
  return tpl.isInstance
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getBaseAttributeId(tpl)
  return tpl.baseAttributeId
end

function this:getFormationTraceRange(tpl)
  return tpl.formationTraceRange
end

function this:getBehavior(tpl)
  return tpl.behavior
end

return this
