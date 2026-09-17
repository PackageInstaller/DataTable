local this = class("exploreTpl")

function this:init(config)
  self.data = config
  self.mapData = {}
  for i, v in pairs(config) do
    if self.mapData[self:getRegionId(v)] == nil then
      self.mapData[self:getRegionId(v)] = {}
    end
    table.insert(self.mapData[self:getRegionId(v)], v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getFillerPicture(tpl)
  return tpl.fillerpicture
end

function this:getFillerSpawner(tpl)
  return tpl.fillerspawner
end

function this:getFillerCount(tpl)
  return tpl.fillercount
end

function this:getFiller(tpl)
  return tpl.filler
end

function this:getId(tpl)
  return tpl.id
end

function this:getRegionId(tpl)
  return tpl.regionid
end

function this:getCondition(tpl)
  return tpl.condition
end

function this:getInstructions(tpl)
  return tpl.instructions
end

function this:getIntroducePicture(tpl)
  return tpl.introducepicture
end

function this:getCategory(tpl)
  return tpl.category
end

function this:getIntroduceText(tpl)
  return L_Config:provider(tpl.introducetext)
end

function this:getExploreExp(tpl)
  return tpl.exploreexp
end

function this:getExploreIcon(tpl)
  return tpl.ExploreIcon
end

function this:getExploreTexture(tpl)
  return tpl.ExploreTexture
end

function this:getExploreName(tpl)
  return L_Config:provider(tpl.exploreName)
end

function this:getExploreTplByMapId(mapId, type)
  if type then
    local data = self.mapData[mapId]
    if table.isEmpty(data) then
      return {}
    end
    local typeData = {}
    for i, v in pairs(data) do
      if self:getCategory(v) == type then
        table.insert(typeData, v)
      end
    end
    return typeData
  else
    return self.mapData[mapId] or {}
  end
end

function this:getMapIdGroupExploreTpl()
  return self.mapData
end

return this
