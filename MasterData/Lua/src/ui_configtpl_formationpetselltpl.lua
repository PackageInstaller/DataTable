local this = class("formationPetSellTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id] or nil
end

function this:getTypeName(tpl)
  return L_Config:provider(tpl.typeName)
end

return this
