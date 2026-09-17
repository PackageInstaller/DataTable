local this = class("productsCollectionTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDropType(tpl)
  return tpl.dropType
end

function this:getDropShow(tpl)
  return tpl.dropShow
end

function this:getDropUnlockLevel(tpl)
  return tpl.dropUnlockLevelShow
end

return this
