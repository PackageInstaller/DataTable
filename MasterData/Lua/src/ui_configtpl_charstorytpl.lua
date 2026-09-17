local this = class("charStoryTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getText(tpl)
  return L_Config:provider(tpl.text)
end

function this:getTitle(tpl)
  return L_Config:provider(tpl.title)
end

function this:getId(tpl)
  return tpl.id
end

function this:getUnlockConditionText(tpl, i)
  return L_Config:provider(tpl.unlockConditionText[i])
end

return this
