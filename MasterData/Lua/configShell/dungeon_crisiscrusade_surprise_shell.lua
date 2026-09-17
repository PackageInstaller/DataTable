local this = class("dungeon_crisiscrusade_surprise_shell", G_BaseConfig)
local core = G_Tables.TDDungeonCrisiscrusadeSurpriseTable.GetInstance()

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
  cdgroupid = 1,
  cdtime = 2,
  conditionID = 3,
  conditionID2 = 4,
  probability = 5,
  worldMapID = 6,
  zone_center = 7,
  zone_rang = 8,
  randomlevel = 9,
  duration = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCdgroupid(offset)
  return core:GetInt(offset, this.indexMap.cdgroupid)
end

function this:_getCdtime(offset)
  return core:GetInt(offset, this.indexMap.cdtime)
end

function this:_getConditionid(offset)
  local str = core:GetVString(offset, this.indexMap.conditionID).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getConditionid2(offset)
  local str = core:GetVString(offset, this.indexMap.conditionID2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getProbability(offset)
  return core:GetInt(offset, this.indexMap.probability)
end

function this:_getWorldmapid(offset)
  return core:GetInt(offset, this.indexMap.worldMapID)
end

function this:_getZone_center(offset)
  local str = core:GetVString(offset, this.indexMap.zone_center).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getZone_rang(offset)
  return core:GetFloat(offset, this.indexMap.zone_rang)
end

function this:_getRandomlevel(offset)
  local str = core:GetVString(offset, this.indexMap.randomlevel).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDuration(offset)
  return core:GetInt(offset, this.indexMap.duration)
end

this.keyToMethodsMap = {
  id = this._getId,
  cdgroupid = this._getCdgroupid,
  cdtime = this._getCdtime,
  conditionID = this._getConditionid,
  conditionID2 = this._getConditionid2,
  probability = this._getProbability,
  worldMapID = this._getWorldmapid,
  zone_center = this._getZone_center,
  zone_rang = this._getZone_rang,
  randomlevel = this._getRandomlevel,
  duration = this._getDuration
}
return this
