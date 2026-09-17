local this = class("world_battle_zone_shell", G_BaseConfig)
local core = G_Tables.TDWorldBattleZoneTable.GetInstance()

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
  sceneId = 1,
  sceneAreaId = 2,
  battleId = 3,
  centerPos = 4,
  boxRadius = 5,
  boxHeight = 6,
  hideRadius = 7,
  bgm = 8,
  zoneType = 9,
  areaLevelCollectId = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSceneid(offset)
  return core:GetInt(offset, this.indexMap.sceneId)
end

function this:_getSceneareaid(offset)
  return core:GetInt(offset, this.indexMap.sceneAreaId)
end

function this:_getBattleid(offset)
  return core:GetInt(offset, this.indexMap.battleId)
end

function this:_getCenterpos(offset)
  local str = core:GetVString(offset, this.indexMap.centerPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBoxradius(offset)
  return core:GetInt(offset, this.indexMap.boxRadius)
end

function this:_getBoxheight(offset)
  return core:GetInt(offset, this.indexMap.boxHeight)
end

function this:_getHideradius(offset)
  return core:GetInt(offset, this.indexMap.hideRadius)
end

function this:_getBgm(offset)
  return core:GetVString(offset, this.indexMap.bgm).value
end

function this:_getZonetype(offset)
  return core:GetInt(offset, this.indexMap.zoneType)
end

function this:_getArealevelcollectid(offset)
  return core:GetInt(offset, this.indexMap.areaLevelCollectId)
end

this.keyToMethodsMap = {
  id = this._getId,
  sceneId = this._getSceneid,
  sceneAreaId = this._getSceneareaid,
  battleId = this._getBattleid,
  centerPos = this._getCenterpos,
  boxRadius = this._getBoxradius,
  boxHeight = this._getBoxheight,
  hideRadius = this._getHideradius,
  bgm = this._getBgm,
  zoneType = this._getZonetype,
  areaLevelCollectId = this._getArealevelcollectid
}
return this
