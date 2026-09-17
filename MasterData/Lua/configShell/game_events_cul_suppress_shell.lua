local this = class("game_events_cul_suppress_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulSuppressTable.GetInstance()

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
  levelDifference = 1,
  difficulty = 2,
  desc = 3,
  buffid = 4,
  battleInfoId = 5,
  battleInfoValue = 6,
  battleInfoPercentValue = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLeveldifference(offset)
  return core:GetInt(offset, this.indexMap.levelDifference)
end

function this:_getDifficulty(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_suppress", core:GetVString(offset, this.indexMap.difficulty))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "difficulty")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_suppress", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getBuffid(offset)
  return core:GetInt(offset, this.indexMap.buffid)
end

function this:_getBattleinfoid(offset)
  local str = core:GetVString(offset, this.indexMap.battleInfoId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBattleinfovalue(offset)
  local str = core:GetVString(offset, this.indexMap.battleInfoValue).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBattleinfopercentvalue(offset)
  local str = core:GetVString(offset, this.indexMap.battleInfoPercentValue).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  levelDifference = this._getLeveldifference,
  difficulty = this._getDifficulty,
  desc = this._getDesc,
  buffid = this._getBuffid,
  battleInfoId = this._getBattleinfoid,
  battleInfoValue = this._getBattleinfovalue,
  battleInfoPercentValue = this._getBattleinfopercentvalue
}
return this
