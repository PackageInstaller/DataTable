local this = class("unitPropertyTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getMorale(tpl)
  return tpl.morale
end

function this:getStrategyPreference(tpl)
  return tpl.strategyPreference
end

function this:getChaos(tpl)
  return tpl.chaos
end

function this:getBehaviorFormation(tpl)
  return tpl.behaviorFormation
end

function this:getIsStopPlayer(tpl)
  return tpl.isStopPlayer
end

function this:getId(tpl)
  return tpl.id
end

function this:getBattleWidth(tpl)
  return tpl.battleWidth
end

function this:getFormationId(tpl)
  return tpl.formationId
end

function this:getFormationTraceRange(tpl)
  return tpl.formationTraceRange
end

function this:getCounterAttackRange(tpl)
  return tpl.counterAttackRange
end

function this:getFormationGap(tpl)
  return tpl.formationGap
end

function this:getFormationWidth(tpl)
  return tpl.formationWidth
end

function this:getAttackRange(tpl)
  return tpl.attackRange
end

function this:getBehavior(tpl)
  return tpl.behavior
end

function this:getBaseAttributeId(tpl)
  return tpl.baseAttributeId
end

return this
