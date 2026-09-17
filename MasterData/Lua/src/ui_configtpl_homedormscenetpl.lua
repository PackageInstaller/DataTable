local this = class("homeDormSceneTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getSceneId(tpl)
  return tpl.sceneId
end

function this:getHeroId(tpl)
  return tpl.heroId
end

return this
