local this = class("game_events_partygame_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsPartygameTable.GetInstance()

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
  partytype = 1,
  dungeonid = 2,
  name = 3,
  description = 4,
  skilllist = 5,
  matchmemberlimit = 6,
  gameparam = 7,
  performancepara = 8,
  openperiod = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPartytype(offset)
  return core:GetInt(offset, this.indexMap.partytype)
end

function this:_getDungeonid(offset)
  local str = core:GetVString(offset, this.indexMap.dungeonid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_partygame", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_partygame", core:GetVString(offset, this.indexMap.description))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "description")
end

function this:_getSkilllist(offset)
  local str = core:GetVString(offset, this.indexMap.skilllist).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMatchmemberlimit(offset)
  local str = core:GetVString(offset, this.indexMap.matchmemberlimit).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getGameparam(offset)
  local str = core:GetVString(offset, this.indexMap.gameparam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPerformancepara(offset)
  return core:GetVString(offset, this.indexMap.performancepara).value
end

function this:_getOpenperiod(offset)
  local str = core:GetVString(offset, this.indexMap.openperiod).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  partytype = this._getPartytype,
  dungeonid = this._getDungeonid,
  name = this._getName,
  description = this._getDescription,
  skilllist = this._getSkilllist,
  matchmemberlimit = this._getMatchmemberlimit,
  gameparam = this._getGameparam,
  performancepara = this._getPerformancepara,
  openperiod = this._getOpenperiod
}
return this
