local this = class("battle_shell", G_BaseConfig)
local core = G_Tables.TDBattleTable.GetInstance()

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
  name = 1,
  battleType = 2,
  noEscape = 3,
  canRiding = 4,
  mapDataPath = 5,
  worldId = 6,
  battleZoneId = 7,
  difficultyID = 8,
  levelId = 9,
  bgm = 10,
  opening = 11,
  ending = 12,
  birthPosition = 13,
  birthRotation = 14,
  isDefaultWin = 15,
  battleFsm = 16
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("battle", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getBattletype(offset)
  return core:GetInt(offset, this.indexMap.battleType)
end

function this:_getNoescape(offset)
  return core:GetInt(offset, this.indexMap.noEscape)
end

function this:_getCanriding(offset)
  return core:GetInt(offset, this.indexMap.canRiding)
end

function this:_getMapdatapath(offset)
  return core:GetVString(offset, this.indexMap.mapDataPath).value
end

function this:_getWorldid(offset)
  return core:GetInt(offset, this.indexMap.worldId)
end

function this:_getBattlezoneid(offset)
  return core:GetInt(offset, this.indexMap.battleZoneId)
end

function this:_getDifficultyid(offset)
  return core:GetInt(offset, this.indexMap.difficultyID)
end

function this:_getLevelid(offset)
  return core:GetInt(offset, this.indexMap.levelId)
end

function this:_getBgm(offset)
  return core:GetVString(offset, this.indexMap.bgm).value
end

function this:_getOpening(offset)
  local str = core:GetVString(offset, this.indexMap.opening).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getEnding(offset)
  return core:GetVString(offset, this.indexMap.ending).value
end

function this:_getBirthposition(offset)
  local str = core:GetVString(offset, this.indexMap.birthPosition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBirthrotation(offset)
  local str = core:GetVString(offset, this.indexMap.birthRotation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIsdefaultwin(offset)
  return core:GetInt(offset, this.indexMap.isDefaultWin)
end

function this:_getBattlefsm(offset)
  return core:GetVString(offset, this.indexMap.battleFsm).value
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  battleType = this._getBattletype,
  noEscape = this._getNoescape,
  canRiding = this._getCanriding,
  mapDataPath = this._getMapdatapath,
  worldId = this._getWorldid,
  battleZoneId = this._getBattlezoneid,
  difficultyID = this._getDifficultyid,
  levelId = this._getLevelid,
  bgm = this._getBgm,
  opening = this._getOpening,
  ending = this._getEnding,
  birthPosition = this._getBirthposition,
  birthRotation = this._getBirthrotation,
  isDefaultWin = this._getIsdefaultwin,
  battleFsm = this._getBattlefsm
}
return this
