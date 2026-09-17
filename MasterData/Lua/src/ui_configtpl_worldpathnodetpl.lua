local this = class("worldPathNodeTpl")

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
  return tpl.name
end

function this:getPathNode(tpl)
  return tpl.pathNode
end

function this:getSceneId(tpl)
  return tpl.sceneId
end

return this
