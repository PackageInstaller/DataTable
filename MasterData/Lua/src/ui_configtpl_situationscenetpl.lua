local this = class("situationSceneTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getUnlock(tpl)
  return tpl.unlock
end

function this:getSceneResource(tpl)
  return tpl.SceneResource
end

function this:getScenesName(tpl)
  return L_Config:provider(tpl.scenesName)
end

function this:getSceneIcon(tpl)
  return tpl.SceneIcon
end

function this:getId(tpl)
  return tpl.id
end

return this
