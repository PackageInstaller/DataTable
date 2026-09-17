local this = class("game_events_kibo_duel_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsKiboDuelTable.GetInstance()

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
  groupId = 1,
  exId = 2,
  name = 3,
  desc = 4,
  kiboDuelId = 5,
  buffDesc = 6,
  level = 7,
  unlockTime = 8,
  buff = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getExid(offset)
  return core:GetInt(offset, this.indexMap.exId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_kibo_duel", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_kibo_duel", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getKiboduelid(offset)
  return core:GetInt(offset, this.indexMap.kiboDuelId)
end

function this:_getBuffdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_kibo_duel", core:GetVString(offset, this.indexMap.buffDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "buffDesc")
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getUnlocktime(offset)
  return core:GetInt(offset, this.indexMap.unlockTime)
end

function this:_getBuff(offset)
  local str = core:GetVString(offset, this.indexMap.buff).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  exId = this._getExid,
  name = this._getName,
  desc = this._getDesc,
  kiboDuelId = this._getKiboduelid,
  buffDesc = this._getBuffdesc,
  level = this._getLevel,
  unlockTime = this._getUnlocktime,
  buff = this._getBuff
}
return this
