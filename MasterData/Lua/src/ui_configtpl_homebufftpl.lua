local this = class("homeBuffTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getAlgorithmType(tpl)
  return tpl.algorithmType
end

function this:getType(tpl)
  return tpl.type
end

function this:getId(tpl)
  return tpl.id
end

function this:getBuffDescription(tpl)
  return L_Config:provider(tpl.buffDescription)
end

function this:getBuffName(tpl)
  return tpl.buffName
end

return this
