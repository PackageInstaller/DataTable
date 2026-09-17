local this = class("journeyGroupTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getNameByTpl(tpl)
  return L_Config:provider(tpl.name)
end

function this:getNameById(id)
  for k, v in pairs(self.data) do
    if v.id == id then
      return L_Config:provider(v.name)
    end
  end
  return ""
end

function this:getIcon(tpl)
  return tpl.unlockIcon
end

function this:getIconById(tpl)
  return tpl.unlockIcon
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

return this
