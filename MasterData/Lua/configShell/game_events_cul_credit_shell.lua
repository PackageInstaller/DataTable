local this = class("game_events_cul_credit_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulCreditTable.GetInstance()

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
  eventsid = 1,
  desc = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getEventsid(offset)
  return core:GetInt(offset, this.indexMap.eventsid)
end

function this:_getDesc(offset)
  return core:GetVString(offset, this.indexMap.desc).value
end

this.keyToMethodsMap = {
  id = this._getId,
  eventsid = this._getEventsid,
  desc = this._getDesc
}
return this
