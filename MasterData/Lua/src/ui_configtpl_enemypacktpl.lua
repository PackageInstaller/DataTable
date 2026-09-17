local this = class("enemyPackTpl")

function this:init(config)
  self.data = config
end

function this:getAllTpl()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return tpl.name
end

function this:getLevelPolicy(tpl)
  return tpl.levelPolicy
end

function this:getLevelParameter(tpl)
  return tpl.levelParameter
end

function this:getEnemyIdByPackId(lvPackId)
  local tpl = self:getTplById(lvPackId)
  return self:getEnemyId(tpl)
end

function this:getEnemyId(tpl)
  return tpl.enemyId
end

function this:getDropId(tpl)
  return tpl.dropId
end

function this:getSlotTag(tpl)
  return tpl.slotTag
end

function this:getId(tpl)
  return tpl.id
end

return this
