local this = class("tipsTpl")

function this:init(config)
  self.data = config
  self.sceneDic = {}
  self.defaultTpl = nil
  for _, tpl in pairs(config) do
    local list = self:getSceneIdList(tpl)
    if table.isEmpty(list) then
      self.defaultTpl = tpl
    else
      for _, sceneId in pairs(list) do
        self.sceneDic[sceneId] = tpl
      end
    end
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDefaultTpl()
  return self.defaultTpl
end

function this:getTplBySceneId(id)
  return self.sceneDic[id]
end

function this:getTplBySceneIdOrDefault(id)
  return self:getTplBySceneId(id) or self:getDefaultTpl()
end

function this:getSceneIdList(tpl)
  return tpl.sceneId
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getId(tpl)
  return tpl.id
end

return this
