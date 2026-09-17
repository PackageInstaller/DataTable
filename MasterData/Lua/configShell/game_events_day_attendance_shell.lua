local this = class("game_events_day_attendance_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsDayAttendanceTable.GetInstance()

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
  eventId = 1,
  date = 2,
  reward = 3,
  special = 4,
  desc = 5,
  iconScale = 6,
  iconOffset = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getEventid(offset)
  return core:GetInt(offset, this.indexMap.eventId)
end

function this:_getDate(offset)
  return core:GetInt(offset, this.indexMap.date)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSpecial(offset)
  return core:GetInt(offset, this.indexMap.special)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_day_attendance", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getIconscale(offset)
  local str = core:GetVString(offset, this.indexMap.iconScale).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIconoffset(offset)
  local str = core:GetVString(offset, this.indexMap.iconOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  eventId = this._getEventid,
  date = this._getDate,
  reward = this._getReward,
  special = this._getSpecial,
  desc = this._getDesc,
  iconScale = this._getIconscale,
  iconOffset = this._getIconoffset
}
return this
