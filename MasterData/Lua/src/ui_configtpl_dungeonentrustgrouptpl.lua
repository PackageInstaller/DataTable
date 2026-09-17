local this = class("dungeonEntrustGroupTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getBanner(tpl)
  return tpl.pic
end

function this:getUnlockCondition(tpl)
  return tpl.unlock
end

return this
