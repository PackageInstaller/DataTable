local this = class("game_events_novice_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsNoviceTable.GetInstance()

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
  systemId = 1,
  taskId = 2,
  unlockCondition = 3,
  unlockTime = 4,
  TaskOrder = 5,
  lockDesc = 6,
  lockParam = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getTaskid(offset)
  return core:GetInt(offset, this.indexMap.taskId)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getUnlocktime(offset)
  return core:GetInt(offset, this.indexMap.unlockTime)
end

function this:_getTaskorder(offset)
  return core:GetInt(offset, this.indexMap.TaskOrder)
end

function this:_getLockdesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("game_events_novice", core:GetVString(offset, this.indexMap.lockDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "game_events_novice")
end

function this:_getLockparam(offset)
  local str = core:GetVString(offset, this.indexMap.lockParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  systemId = this._getSystemid,
  taskId = this._getTaskid,
  unlockCondition = this._getUnlockcondition,
  unlockTime = this._getUnlocktime,
  TaskOrder = this._getTaskorder,
  lockDesc = this._getLockdesc,
  lockParam = this._getLockparam
}
return this
