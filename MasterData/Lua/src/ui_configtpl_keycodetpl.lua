local this = class("keyCodeTpl")

function this:init(config)
  self.data = config
  self.keyMap = {}
  for _, v in pairs(config) do
    local key = self:getKeyCode(v)
    self.keyMap[key] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplByKey(key)
  return self.keyMap[key]
end

function this:getId(tpl)
  return tpl.id
end

function this:getKeyName(tpl)
  return L_Config:provider(tpl.keyName)
end

function this:getKeyCode(tpl)
  return tpl.keyCode
end

function this:getNote(tpl)
  return L_Config:provider(tpl.note)
end

function this:getShortKey(tpl)
  return tpl.shortKey
end

function this:getCanBeUsed(tpl)
  return tpl.canBeUsed == 1
end

function this:getConfig()
  return self.data
end

return this
