local this = class("photoSpaceCaseTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getCaseName(tpl)
  return L_Config:provider(tpl.caseName)
end

function this:getDefaultParam(tpl)
  return tpl.defaultParam
end

function this:getUnlock(tpl)
  return tpl.unlock
end

return this
