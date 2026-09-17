local this = class("game_events_cul_rest_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulRestTable.GetInstance()

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
  rest = 0,
  systemId = 1,
  type = 2,
  weight = 3,
  addStamina = 4,
  effect = 5
}

function this:_getRest(offset)
  return core:GetInt(offset, this.indexMap.rest)
end

function this:_getSystemid(offset)
  return core:GetInt(offset, this.indexMap.systemId)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

function this:_getAddstamina(offset)
  return core:GetInt(offset, this.indexMap.addStamina)
end

function this:_getEffect(offset)
  local str = core:GetVString(offset, this.indexMap.effect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  rest = this._getRest,
  systemId = this._getSystemid,
  type = this._getType,
  weight = this._getWeight,
  addStamina = this._getAddstamina,
  effect = this._getEffect
}
return this
