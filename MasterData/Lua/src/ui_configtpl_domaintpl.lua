local this = class("domainTpl")

function this:init(config)
  self.data = config
  self.domainData = {}
  for i, v in pairs(config) do
    if not self.domainData[v.areaId] then
      self.domainData[v.areaId] = {}
    end
    self.domainData[v.areaId][v.domainId] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDomainId(tpl)
  return tpl.domainId
end

function this:getDomainIcon(tpl)
  local domainIcon = L_Config:getPathByHash(tpl.domainIcon)
  return domainIcon
end

function this:getCoordinate(tpl)
  return tpl.coordinate
end

function this:getAreaId(tpl)
  return tpl.areaId
end

function this:getDomainName(tpl)
  return L_Config:provider(tpl.domainName)
end

function this:getWorldAreaId(tpl)
  return tpl.worldAreaId
end

function this:getSceneId(tpl)
  return tpl.sceneId
end

function this:getAllTpl()
  return self.data
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getTplByWorldAreaId(id)
  for k, v in pairs(self.data) do
    if v.worldAreaId == id then
      return v
    end
  end
end

function this:getTplDicByAreaId(areaId)
  return self.domainData[areaId] or {}
end

return this
