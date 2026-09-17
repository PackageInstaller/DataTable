local this = class("seven_day_target_group_shell", G_BaseConfig)
local core = G_Tables.TDSevenDayTargetGroupTable.GetInstance()

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
  day = 1,
  group = 2,
  event_id = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDay(offset)
  return core:GetInt(offset, this.indexMap.day)
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getEvent_id(offset)
  return core:GetInt(offset, this.indexMap.event_id)
end

this.keyToMethodsMap = {
  id = this._getId,
  day = this._getDay,
  group = this._getGroup,
  event_id = this._getEvent_id
}
return this
