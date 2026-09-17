local this = class("game_event_integral_shell", G_BaseConfig)
local core = G_Tables.TDGameEventIntegralTable.GetInstance()

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
  eventid = 1,
  name = 2,
  _note = 3,
  currencyid = 4,
  daynum = 5,
  intelgralmax = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getEventid(offset)
  return core:GetInt(offset, this.indexMap.eventid)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_event_integral", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_get_note(offset)
  return core:GetVString(offset, this.indexMap._note).value
end

function this:_getCurrencyid(offset)
  return core:GetInt(offset, this.indexMap.currencyid)
end

function this:_getDaynum(offset)
  return core:GetInt(offset, this.indexMap.daynum)
end

function this:_getIntelgralmax(offset)
  return core:GetInt(offset, this.indexMap.intelgralmax)
end

this.keyToMethodsMap = {
  id = this._getId,
  eventid = this._getEventid,
  name = this._getName,
  _note = this._get_note,
  currencyid = this._getCurrencyid,
  daynum = this._getDaynum,
  intelgralmax = this._getIntelgralmax
}
return this
