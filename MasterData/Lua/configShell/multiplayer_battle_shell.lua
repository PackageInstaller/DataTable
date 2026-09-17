local this = class("multiplayer_battle_shell", G_BaseConfig)
local core = G_Tables.TDMultiplayerBattleTable.GetInstance()

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
  typeId = 1,
  typeName = 2,
  difficultyId = 3,
  difficultyName = 4,
  battleId = 5,
  monsterList = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTypeid(offset)
  return core:GetInt(offset, this.indexMap.typeId)
end

function this:_getTypename(offset)
  local langStr = G_TableMgrIns:GetLangStr("multiplayer_battle", core:GetVString(offset, this.indexMap.typeName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "typeName")
end

function this:_getDifficultyid(offset)
  return core:GetInt(offset, this.indexMap.difficultyId)
end

function this:_getDifficultyname(offset)
  local langStr = G_TableMgrIns:GetLangStr("multiplayer_battle", core:GetVString(offset, this.indexMap.difficultyName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "difficultyName")
end

function this:_getBattleid(offset)
  return core:GetInt(offset, this.indexMap.battleId)
end

function this:_getMonsterlist(offset)
  local str = core:GetVString(offset, this.indexMap.monsterList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  typeId = this._getTypeid,
  typeName = this._getTypename,
  difficultyId = this._getDifficultyid,
  difficultyName = this._getDifficultyname,
  battleId = this._getBattleid,
  monsterList = this._getMonsterlist
}
return this
