local this = class("chatQuickTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getWords(tpl)
  return L_Config:provider(tpl.words)
end

return this
