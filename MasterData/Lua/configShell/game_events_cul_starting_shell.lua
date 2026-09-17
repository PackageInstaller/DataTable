local this = class("game_events_cul_starting_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulStartingTable.GetInstance()

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
  startingId = 0,
  systemId = 1,
  unlockTime = 2,
  condition = 3,
  startingName = 4,
  unlockDesc = 5,
  startingPic = 6,
  initialCharacter = 7,
  exCharAmonut = 8,
  effect = 9,
  startingDesc = 10,
  lockCharacter = 11
}

function this:_getStartingid(offset)
  return core:GetInt(offset, this.indexMap.startingId)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getUnlocktime(offset)
  return core:GetInt(offset, this.indexMap.unlockTime)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getStartingname(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_starting", core:GetVString(offset, this.indexMap.startingName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "startingName")
end

function this:_getUnlockdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_starting", core:GetVString(offset, this.indexMap.unlockDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockDesc")
end

function this:_getStartingpic(offset)
  local str = core:GetVString(offset, this.indexMap.startingPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 0)
end

function this:_getInitialcharacter(offset)
  local str = core:GetVString(offset, this.indexMap.initialCharacter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getExcharamonut(offset)
  return core:GetInt(offset, this.indexMap.exCharAmonut)
end

function this:_getEffect(offset)
  local str = core:GetVString(offset, this.indexMap.effect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getStartingdesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("game_events_cul_starting", core:GetVString(offset, this.indexMap.startingDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "game_events_cul_starting")
end

function this:_getLockcharacter(offset)
  local str = core:GetVString(offset, this.indexMap.lockCharacter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  startingId = this._getStartingid,
  systemId = this._getSystemid,
  unlockTime = this._getUnlocktime,
  condition = this._getCondition,
  startingName = this._getStartingname,
  unlockDesc = this._getUnlockdesc,
  startingPic = this._getStartingpic,
  initialCharacter = this._getInitialcharacter,
  exCharAmonut = this._getExcharamonut,
  effect = this._getEffect,
  startingDesc = this._getStartingdesc,
  lockCharacter = this._getLockcharacter
}
return this
