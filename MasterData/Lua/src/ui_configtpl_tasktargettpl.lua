local this = class("taskTargetTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getParam(tpl)
  return tpl.param
end

function this:getStepId(tpl)
  return tpl.stepId
end

function this:getId(tpl)
  return tpl.id
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getBtnDesc(tpl)
  return tpl.btnDesc
end

function this:getShortLockText(tpl)
  return L_Config:provider(tpl.shortLockText)
end

return this
