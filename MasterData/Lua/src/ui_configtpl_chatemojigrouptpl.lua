local this = class("chatEmojiGroupTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getNameById(id)
  local tpl = self:getTplById(id)
  return self:getName(tpl)
end

return this
