local this = class("colorFormulaTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getEye(tpl)
  return tpl.eye
end

function this:getName(tpl)
  return tpl.name
end

function this:getIconColor(tpl)
end

function this:getNameById(id)
end

function this:getColorsById(id)
end

return this
