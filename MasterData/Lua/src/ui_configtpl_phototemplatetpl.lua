local this = class("photoTemplateTpl")

function this:init(config)
  self.data = config
end

function this:getConfig()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getShow(tpl)
  return tpl.show == 1
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getIconStr(tpl)
  return tpl.icon
end

function this:getFullStr(tpl)
  return tpl.fullStr
end

return this
