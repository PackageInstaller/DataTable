local this = class("worldEntityTipsTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getScanDuration(tpl)
  return tpl.scanDuration
end

function this:getDescription(tpl)
  return tpl.description
end

function this:getId(tpl)
  return tpl.id
end

function this:getResourcePath(tpl)
  return L_Config:getPathByHash(tpl.resourcePath)
end

return this
