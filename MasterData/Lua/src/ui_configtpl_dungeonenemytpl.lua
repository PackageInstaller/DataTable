local this = class("dungeonEnemyTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getAvatarTexture(tpl)
  local avatarTexture = L_Config:getPathByHash(tpl.avatarTexture)
  return avatarTexture
end

function this:getDescription(tpl)
  return L_Config:provider(tpl.description)
end

return this
