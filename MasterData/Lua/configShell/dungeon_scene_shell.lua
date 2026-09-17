local this = class("dungeon_scene_shell", G_BaseConfig)
local core = G_Tables.TDDungeonSceneTable.GetInstance()

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
  mapId = 1,
  victoryCondition = 2,
  blueprintId = 3,
  serverBlueprintId = 4,
  param = 5,
  stringParam = 6,
  listIntParam = 7,
  intParam = 8,
  boolParam = 9,
  collisionType = 10,
  trailGroup = 11,
  extraTrialGroup = 12,
  challengeGroup = 13,
  extraParam = 14
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getMapid(offset)
  return core:GetInt(offset, this.indexMap.mapId)
end

function this:_getVictorycondition(offset)
  return core:GetVString(offset, this.indexMap.victoryCondition).value
end

function this:_getBlueprintid(offset)
  return core:GetInt(offset, this.indexMap.blueprintId)
end

function this:_getServerblueprintid(offset)
  return core:GetInt(offset, this.indexMap.serverBlueprintId)
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getStringparam(offset)
  local str = core:GetVString(offset, this.indexMap.stringParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "string")
end

function this:_getListintparam(offset)
  local str = core:GetVString(offset, this.indexMap.listIntParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIntparam(offset)
  local str = core:GetVString(offset, this.indexMap.intParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getBoolparam(offset)
  local str = core:GetVString(offset, this.indexMap.boolParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "bool")
end

function this:_getCollisiontype(offset)
  return core:GetInt(offset, this.indexMap.collisionType)
end

function this:_getTrailgroup(offset)
  local str = core:GetVString(offset, this.indexMap.trailGroup).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getExtratrialgroup(offset)
  local str = core:GetVString(offset, this.indexMap.extraTrialGroup).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getChallengegroup(offset)
  return core:GetInt(offset, this.indexMap.challengeGroup)
end

function this:_getExtraparam(offset)
  local str = core:GetVString(offset, this.indexMap.extraParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "string")
end

this.keyToMethodsMap = {
  id = this._getId,
  mapId = this._getMapid,
  victoryCondition = this._getVictorycondition,
  blueprintId = this._getBlueprintid,
  serverBlueprintId = this._getServerblueprintid,
  param = this._getParam,
  stringParam = this._getStringparam,
  listIntParam = this._getListintparam,
  intParam = this._getIntparam,
  boolParam = this._getBoolparam,
  collisionType = this._getCollisiontype,
  trailGroup = this._getTrailgroup,
  extraTrialGroup = this._getExtratrialgroup,
  challengeGroup = this._getChallengegroup,
  extraParam = this._getExtraparam
}
return this
