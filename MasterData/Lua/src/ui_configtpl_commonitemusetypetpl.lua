local this = class("commonItemUseTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDesc(tpl)
  return tpl.desc
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getIsMulUseType(tpl)
  return tpl.useType == 1
end

return this
