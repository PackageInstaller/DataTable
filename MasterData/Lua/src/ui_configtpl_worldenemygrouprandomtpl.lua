local this = class("worldEnemyGroupRandomTpl")

function this:init(config)
  self.data = config
end

function this:getAllTpl()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getEnemyGroupRandom(tpl)
  return tpl.enemyGroupRandom
end

function this:getCommonCondition(tpl)
  return tpl.commonCondition
end

function this:getConditionCompleteEnemyGroup(tpl)
  return tpl.conditionCompleteEnemyGroup
end

return this
