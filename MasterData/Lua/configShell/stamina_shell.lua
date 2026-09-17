local this = class("stamina_shell", G_BaseConfig)
local core = G_Tables.TDStaminaTable.GetInstance()

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
  stamina = 1,
  price = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getStamina(offset)
  return core:GetInt(offset, this.indexMap.stamina)
end

function this:_getPrice(offset)
  local str = core:GetVString(offset, this.indexMap.price).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  stamina = this._getStamina,
  price = this._getPrice
}
return this
