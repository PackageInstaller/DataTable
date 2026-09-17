local this = class("fightProhibitTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getBlockTips(tpl)
  return L_Config:provider(tpl.words)
end

return this
