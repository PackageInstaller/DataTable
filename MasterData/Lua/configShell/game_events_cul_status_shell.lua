local this = class("game_events_cul_status_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulStatusTable.GetInstance()

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
  statusID = 0,
  activityid = 1,
  statusName = 2,
  statusDesc = 3,
  isNegative = 4,
  effect = 5,
  duration = 6,
  charge = 7,
  showtype = 8
}

function this:_getStatusid(offset)
  return core:GetInt(offset, this.indexMap.statusID)
end

function this:_getActivityid(offset)
  return core:GetInt(offset, this.indexMap.activityid)
end

function this:_getStatusname(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_status", core:GetVString(offset, this.indexMap.statusName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "statusName")
end

function this:_getStatusdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_cul_status", core:GetVString(offset, this.indexMap.statusDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "statusDesc")
end

function this:_getIsnegative(offset)
  return core:GetInt(offset, this.indexMap.isNegative)
end

function this:_getEffect(offset)
  local str = core:GetVString(offset, this.indexMap.effect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDuration(offset)
  return core:GetInt(offset, this.indexMap.duration)
end

function this:_getCharge(offset)
  return core:GetInt(offset, this.indexMap.charge)
end

function this:_getShowtype(offset)
  return core:GetVString(offset, this.indexMap.showtype).value
end

this.keyToMethodsMap = {
  statusID = this._getStatusid,
  activityid = this._getActivityid,
  statusName = this._getStatusname,
  statusDesc = this._getStatusdesc,
  isNegative = this._getIsnegative,
  effect = this._getEffect,
  duration = this._getDuration,
  charge = this._getCharge,
  showtype = this._getShowtype
}
return this
