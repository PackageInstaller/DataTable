local this = class("homeLaborTrainConditionTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

return this
