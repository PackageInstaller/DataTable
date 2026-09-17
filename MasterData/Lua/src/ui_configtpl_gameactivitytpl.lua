local this = class("gameActivityTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTutorialName(tpl)
  return tpl.tutorialName
end

function this:getTutorialIcon(tpl)
  return tpl.tutorialIcon
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getAllData()
  return self.data
end

return this
