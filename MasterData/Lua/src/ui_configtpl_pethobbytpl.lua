local this = class("petHobbyTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getHobby(tpl)
  return tpl.hobby
end

function this:getBaseAttribute(tpl)
  local baseAttribute = {}
  for i, v in pairs(tpl.baseAttribute) do
    baseAttribute[i] = v / 100
  end
  return baseAttribute
end

return this
