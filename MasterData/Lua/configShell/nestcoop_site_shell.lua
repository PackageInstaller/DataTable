local this = class("nestcoop_site_shell", G_BaseConfig)
local core = G_Tables.TDNestcoopSiteTable.GetInstance()

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
  area_id = 1,
  worldmapScene = 2,
  worldmapId = 3,
  refreshWeight = 4,
  poolID = 5,
  isVisible = 6,
  defaultTime = 7,
  timePassAvailable = 8,
  mapId = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getArea_id(offset)
  return core:GetInt(offset, this.indexMap.area_id)
end

function this:_getWorldmapscene(offset)
  return core:GetInt(offset, this.indexMap.worldmapScene)
end

function this:_getWorldmapid(offset)
  return core:GetInt(offset, this.indexMap.worldmapId)
end

function this:_getRefreshweight(offset)
  return core:GetInt(offset, this.indexMap.refreshWeight)
end

function this:_getPoolid(offset)
  return core:GetInt(offset, this.indexMap.poolID)
end

function this:_getIsvisible(offset)
  return core:GetInt(offset, this.indexMap.isVisible)
end

function this:_getDefaulttime(offset)
  return core:GetInt(offset, this.indexMap.defaultTime)
end

function this:_getTimepassavailable(offset)
  return core:GetInt(offset, this.indexMap.timePassAvailable)
end

function this:_getMapid(offset)
  return core:GetInt(offset, this.indexMap.mapId)
end

this.keyToMethodsMap = {
  id = this._getId,
  area_id = this._getArea_id,
  worldmapScene = this._getWorldmapscene,
  worldmapId = this._getWorldmapid,
  refreshWeight = this._getRefreshweight,
  poolID = this._getPoolid,
  isVisible = this._getIsvisible,
  defaultTime = this._getDefaulttime,
  timePassAvailable = this._getTimepassavailable,
  mapId = this._getMapid
}
return this
