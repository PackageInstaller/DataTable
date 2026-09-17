local this = class("photographTextTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTextColor(tpl)
  return tpl.textColor
end

function this:getText(tpl)
  return tpl.text
end

function this:getId(tpl)
  return tpl.id
end

return this
