local this = class("homeLaborEfficiencyTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTimeReduct(tpl)
  return tpl.TimeReduct
end

function this:getSeedRecycle(tpl)
  return tpl.SeedRecycle
end

function this:getSeedHarvest(tpl)
  return tpl.SeedHarvest
end

function this:getWaterTimeReduct(tpl)
  return tpl.WaterTimeReduct
end

function this:getAccessoryTimeReduct(tpl)
  return tpl.AccessoryTimeReduct
end

function this:getGatherTimeReduct(tpl)
  return tpl.GatherTimeReduct
end

function this:getEggTimeReduct(tpl)
  return tpl.EggTimeReduct
end

function this:getPastureTimeReduct(tpl)
  return tpl.PastureTimeReduct
end

return this
