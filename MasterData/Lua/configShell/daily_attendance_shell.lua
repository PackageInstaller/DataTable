local this = class("daily_attendance_shell", G_BaseConfig)
local core = G_Tables.TDDailyAttendanceTable.GetInstance()

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
  reward = 3
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
  return core:GetInt(offset, this.indexMap.reward)
end

this.keyToMethodsMap = {
  id = this._getId,
  teamId = this._getTeamid,
  day = this._getDay,
  reward = this._getReward
}
return this
