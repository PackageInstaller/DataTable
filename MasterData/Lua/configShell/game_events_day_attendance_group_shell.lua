local this = class("game_events_day_attendance_group_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsDayAttendanceGroupTable.GetInstance()

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
  background = 2,
  hero = 3,
  desc = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_day_attendance_group", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getBackground(offset)
  return core:GetVString(offset, this.indexMap.background).value
end

function this:_getHero(offset)
  return core:GetInt(offset, this.indexMap.hero)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_events_day_attendance_group", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  background = this._getBackground,
  hero = this._getHero,
  desc = this._getDesc
}
return this
