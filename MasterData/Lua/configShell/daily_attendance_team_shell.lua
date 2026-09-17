local this = class("daily_attendance_team_shell", G_BaseConfig)
local core = G_Tables.TDDailyAttendanceTeamTable.GetInstance()

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
  teamId = 1,
  day = 2,
  reward = 3,
  important = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTeamid(offset)
  return core:GetInt(offset, this.indexMap.teamId)
end

function this:_getDay(offset)
  return core:GetInt(offset, this.indexMap.day)
end

function this:_getReward(offset)
  local str = core:GetVString(offset, this.indexMap.reward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getImportant(offset)
  return core:GetInt(offset, this.indexMap.important)
end

this.keyToMethodsMap = {
  id = this._getId,
  teamId = this._getTeamid,
  day = this._getDay,
  reward = this._getReward,
  important = this._getImportant
}
return this
