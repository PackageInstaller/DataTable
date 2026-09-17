local this = class("homeFieldtypeTpl")

function this:init(config)
  self.data = config
  self.buildId2Tpl = {}
  for _, tpl in pairs(self.data) do
    local buildId = tpl.homeBuildingId
    self.buildId2Tpl[buildId] = tpl
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTypeName(tpl)
  return tpl.typeName
end

function this:getId(tpl)
  return tpl.id
end

function this:getWaterTime(tpl)
  return tpl.waterTime
end

function this:getWaterMax(tpl)
  return tpl.waterMax
end

function this:getTplByBuildId(buildId)
  return self.buildId2Tpl[buildId]
end

return this
