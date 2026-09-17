local this = class("petHomeSizeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getSizeType(tpl)
  return tpl.sizeType
end

function this:getSizeName(tpl)
  return L_Config:provider(tpl.sizeName)
end

function this:getIcon(tpl)
  return tpl.icon
end

return this
