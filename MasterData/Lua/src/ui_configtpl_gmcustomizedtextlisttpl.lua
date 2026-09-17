local this = class("gmCustomizedtextListTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getFunctionName(tpl)
  return L_Config:provider(tpl.functionName)
end

return this
