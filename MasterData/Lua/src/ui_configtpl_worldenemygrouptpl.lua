local this = class("worldEnemyGroupTpl")

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

function this:getName(tpl)
  return tpl.name
end

function this:getEnemyList(tpl)
  return tpl.enemyList
end

return this
