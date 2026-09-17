local this = class("dungeon_random_shell", G_BaseConfig)
local core = G_Tables.TDDungeonRandomTable.GetInstance()

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
  dungeonRandomName = 1,
  mainDungeon = 2,
  position = 3,
  victoryCondition = 4,
  failCondition = 5,
  challenge = 6,
  pathGroup = 7,
  pathTemplate = 8,
  pathPrefab = 9,
  bossRoomDir = 10,
  bossRoomPrefabIndex = 11,
  bossRoomPrefab = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDungeonrandomname(offset)
  return core:GetVString(offset, this.indexMap.dungeonRandomName).value
end

function this:_getMaindungeon(offset)
  return core:GetInt(offset, this.indexMap.mainDungeon)
end

function this:_getPosition(offset)
  local str = core:GetVString(offset, this.indexMap.position).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getVictorycondition(offset)
  local str = core:GetVString(offset, this.indexMap.victoryCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getFailcondition(offset)
  local str = core:GetVString(offset, this.indexMap.failCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getChallenge(offset)
  local str = core:GetVString(offset, this.indexMap.challenge).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getPathgroup(offset)
  local str = core:GetVString(offset, this.indexMap.pathGroup).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPathtemplate(offset)
  local str = core:GetVString(offset, this.indexMap.pathTemplate).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPathprefab(offset)
  local str = core:GetVString(offset, this.indexMap.pathPrefab).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getBossroomdir(offset)
  return core:GetInt(offset, this.indexMap.bossRoomDir)
end

function this:_getBossroomprefabindex(offset)
  return core:GetInt(offset, this.indexMap.bossRoomPrefabIndex)
end

function this:_getBossroomprefab(offset)
  return core:GetVString(offset, this.indexMap.bossRoomPrefab).value
end

this.keyToMethodsMap = {
  id = this._getId,
  dungeonRandomName = this._getDungeonrandomname,
  mainDungeon = this._getMaindungeon,
  position = this._getPosition,
  victoryCondition = this._getVictorycondition,
  failCondition = this._getFailcondition,
  challenge = this._getChallenge,
  pathGroup = this._getPathgroup,
  pathTemplate = this._getPathtemplate,
  pathPrefab = this._getPathprefab,
  bossRoomDir = this._getBossroomdir,
  bossRoomPrefabIndex = this._getBossroomprefabindex,
  bossRoomPrefab = this._getBossroomprefab
}
return this
