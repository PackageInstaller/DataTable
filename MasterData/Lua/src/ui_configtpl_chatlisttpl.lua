local this = class("chatListTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

return this
