local this = class("exploreLevelTpl")

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

function this:getInstructions(tpl)
  return tpl.instructions
end

function this:getExploreLevel(tpl)
  return tpl.ExploreLevel
end

function this:getId(tpl)
  return tpl.id
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getLv(tpl)
  return tpl.lv
end

function this:getExp(tpl)
  return tpl.exp
end

function this:getRegionId(tpl)
  return tpl.regionid
end

function this:getLffly(tpl)
  return tpl.ifFly
end

function this:getExploreRewardTplByMapId(mapId, level)
  local data = self.mapData[mapId]
  if table.isEmpty(data) then
    return {}
  end
  if not math.isEmpty(level) then
    for i, v in pairs(data) do
      if self:getLv(v) == level then
        return v
      end
    end
    return {}
  else
    return data
  end
end

return this
