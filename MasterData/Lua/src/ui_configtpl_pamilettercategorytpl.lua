local this = class("pamiLetterCategoryTpl")

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
  return tpl.name
end

function this:getSystemId(tpl)
  return tpl.systemId
end

return this
