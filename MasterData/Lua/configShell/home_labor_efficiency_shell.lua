local this = class("home_labor_efficiency_shell", G_BaseConfig)
local core = G_Tables.TDHomeLaborEfficiencyTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {
  id = 0,
  TimeReduct = 1,
  SeedRecycle = 2,
  SeedHarvest = 3,
  WaterTimeReduct = 4,
  AccessoryTimeReduct = 5,
  GatherTimeReduct = 6,
  EggTimeReduct = 7,
  PastureTimeReduct = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTimereduct(offset)
  return core:GetInt(offset, this.indexMap.TimeReduct)
end

function this:_getSeedrecycle(offset)
  return core:GetInt(offset, this.indexMap.SeedRecycle)
end

function this:_getSeedharvest(offset)
  return core:GetInt(offset, this.indexMap.SeedHarvest)
end

function this:_getWatertimereduct(offset)
  return core:GetInt(offset, this.indexMap.WaterTimeReduct)
end

function this:_getAccessorytimereduct(offset)
  return core:GetInt(offset, this.indexMap.AccessoryTimeReduct)
end

function this:_getGathertimereduct(offset)
  return core:GetInt(offset, this.indexMap.GatherTimeReduct)
end

function this:_getEggtimereduct(offset)
  return core:GetInt(offset, this.indexMap.EggTimeReduct)
end

function this:_getPasturetimereduct(offset)
  return core:GetInt(offset, this.indexMap.PastureTimeReduct)
end

this.keyToMethodsMap = {
  id = this._getId,
  TimeReduct = this._getTimereduct,
  SeedRecycle = this._getSeedrecycle,
  SeedHarvest = this._getSeedharvest,
  WaterTimeReduct = this._getWatertimereduct,
  AccessoryTimeReduct = this._getAccessorytimereduct,
  GatherTimeReduct = this._getGathertimereduct,
  EggTimeReduct = this._getEggtimereduct,
  PastureTimeReduct = this._getPasturetimereduct
}
return this
