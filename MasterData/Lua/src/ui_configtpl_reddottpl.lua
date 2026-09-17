local this = class("reddotTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getRedDotPath(tpl)
  return tpl.RedDot_Path
end

function this:getAttrVal(tpl)
  return tpl.AttrVal
end

function this:getAttrType(tpl)
  return tpl.AttrType
end

return this
