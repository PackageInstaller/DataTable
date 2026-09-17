local this = class("accessoryInterimTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getConfigId(tpl)
  return tpl.accessoryid
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getMainAttrGroup(tpl)
  return tpl.mainAttr
end

function this:getAccessorySub(tpl)
  return tpl.accessorysub
end

return this
