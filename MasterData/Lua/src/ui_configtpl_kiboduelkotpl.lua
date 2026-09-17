local this = class("kiboDuelKoTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

return this
