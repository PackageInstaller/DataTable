local this = class("fish_pond_shell", G_BaseConfig)
local core = G_Tables.TDFishPondTable.GetInstance()

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
  fishPondName = 1,
  description = 2,
  fishGroup = 3,
  fishGroupTime = 4,
  cameraDistance = 5,
  cameraAngle = 6,
  cameraHeight = 7,
  mapId = 8,
  worldMapObject = 9,
  interactiveObject = 10,
  fishSalvaging = 11,
  fishEncounter = 12,
  fishSalvagingWeight = 13,
  fishEncounterWeight = 14
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFishpondname(offset)
  local langStr = G_TableMgrIns:GetLangStr("fish_pond", core:GetVString(offset, this.indexMap.fishPondName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "fishPondName")
end

function this:_getDescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("fish_pond", core:GetVString(offset, this.indexMap.description))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "description")
end

function this:_getFishgroup(offset)
  return core:GetInt(offset, this.indexMap.fishGroup)
end

function this:_getFishgrouptime(offset)
  return core:GetInt(offset, this.indexMap.fishGroupTime)
end

function this:_getCameradistance(offset)
  return core:GetInt(offset, this.indexMap.cameraDistance)
end

function this:_getCameraangle(offset)
  return core:GetInt(offset, this.indexMap.cameraAngle)
end

function this:_getCameraheight(offset)
  return core:GetInt(offset, this.indexMap.cameraHeight)
end

function this:_getMapid(offset)
  return core:GetInt(offset, this.indexMap.mapId)
end

function this:_getWorldmapobject(offset)
  return core:GetInt(offset, this.indexMap.worldMapObject)
end

function this:_getInteractiveobject(offset)
  return core:GetInt(offset, this.indexMap.interactiveObject)
end

function this:_getFishsalvaging(offset)
  return core:GetInt(offset, this.indexMap.fishSalvaging)
end

function this:_getFishencounter(offset)
  return core:GetInt(offset, this.indexMap.fishEncounter)
end

function this:_getFishsalvagingweight(offset)
  return core:GetInt(offset, this.indexMap.fishSalvagingWeight)
end

function this:_getFishencounterweight(offset)
  return core:GetInt(offset, this.indexMap.fishEncounterWeight)
end

this.keyToMethodsMap = {
  id = this._getId,
  fishPondName = this._getFishpondname,
  description = this._getDescription,
  fishGroup = this._getFishgroup,
  fishGroupTime = this._getFishgrouptime,
  cameraDistance = this._getCameradistance,
  cameraAngle = this._getCameraangle,
  cameraHeight = this._getCameraheight,
  mapId = this._getMapid,
  worldMapObject = this._getWorldmapobject,
  interactiveObject = this._getInteractiveobject,
  fishSalvaging = this._getFishsalvaging,
  fishEncounter = this._getFishencounter,
  fishSalvagingWeight = this._getFishsalvagingweight,
  fishEncounterWeight = this._getFishencounterweight
}
return this
