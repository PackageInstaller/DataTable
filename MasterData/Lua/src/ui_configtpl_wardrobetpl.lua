local this = class("wardrobeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id] or {}
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

function this:getMouth(tpl)
  return tpl.mouth
end

return this
