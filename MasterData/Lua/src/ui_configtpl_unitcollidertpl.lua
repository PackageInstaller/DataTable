local this = class("unitColliderTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getColliderList(tpl)
  return tpl.colliderList
end

function this:getColliderBindList(tpl)
  return tpl.colliderBindList
end

function this:getHeight(tpl)
  local list = tpl.colliderList
  if list[1][1] == 1 then
    return list[1][3]
  else
    return list[1][3]
  end
end

return this
