local this = class("game_activity_integral_shell", G_BaseConfig)
local core = G_Tables.TDGameActivityIntegralTable.GetInstance()

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
  _note = 2,
  currencyid = 3,
  daynum = 4,
  intelgralmax = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity_integral", core:GetVString(offset, this.indexMap.name))
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
  name = this._getName,
  _note = this._get_note,
  currencyid = this._getCurrencyid,
  daynum = this._getDaynum,
  intelgralmax = this._getIntelgralmax
}
return this
