local this = class("home_technology_exp_rule_shell", G_BaseConfig)
local core = G_Tables.TDHomeTechnologyExpRuleTable.GetInstance()

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
  rule = 1,
  lvmin = 2,
  lvmax = 3,
  value = 4,
  _note = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRule(offset)
  return core:GetInt(offset, this.indexMap.rule)
end

function this:_getLvmin(offset)
  return core:GetInt(offset, this.indexMap.lvmin)
end

function this:_getLvmax(offset)
  return core:GetInt(offset, this.indexMap.lvmax)
end

function this:_getValue(offset)
  return core:GetInt(offset, this.indexMap.value)
end

function this:_get_note(offset)
  return core:GetVString(offset, this.indexMap._note).value
end

this.keyToMethodsMap = {
  id = this._getId,
  rule = this._getRule,
  lvmin = this._getLvmin,
  lvmax = this._getLvmax,
  value = this._getValue,
  _note = this._get_note
}
return this
