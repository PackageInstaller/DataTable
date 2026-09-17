local this = class("charKiboTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getUnlockDesc(tpl)
  return L_Config:provider(tpl.unlockDesc)
end

return this
