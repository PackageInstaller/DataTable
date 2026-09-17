local this = class("dungeonCrisisCrusadeDiffTagTpl")

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
  return L_Config:provider(tpl._name)
end

function this:getDifficulty(tpl)
  return tpl.difficulty
end

function this:getIconPath(tpl)
  return tpl.pic
end

function this:getLockIconPath(tpl)
  return tpl.selectpic
end

function this:getRecLevelText(tpl)
  return L_Config:provider(tpl.recommendlv)
end

function this:getUnlockLevel(tpl)
  return tpl.level
end

function this:getData()
  return self.data
end

return this
