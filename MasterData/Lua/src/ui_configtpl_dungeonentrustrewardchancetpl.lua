local this = class("dungeonEntrustRewardChanceTpl")

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

function this:getNameById(id)
  if id and self.data and self.data[id] then
    return L_Config:provider(self.data[id].name)
  end
  return nil
end

return this
