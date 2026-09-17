local this = class("groupsTpl")

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

function this:getIcon(tpl, index)
  local hash = tpl.icon[index]
  if math.isEmpty(hash) or string.isEmpty(hash) then
    return ""
  end
  return L_Config:getPathByHash(hash)
end

function this:getReputationTabIcon(tpl)
  return tpl.reputationTabIcon
end

return this
