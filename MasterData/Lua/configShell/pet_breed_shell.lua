local this = class("pet_breed_shell", G_BaseConfig)
local core = G_Tables.TDPetBreedTable.GetInstance()

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
  weight = 2,
  result = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRule(offset)
  local str = core:GetVString(offset, this.indexMap.rule).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

function this:_getResult(offset)
  return core:GetInt(offset, this.indexMap.result)
end

this.keyToMethodsMap = {
  id = this._getId,
  rule = this._getRule,
  weight = this._getWeight,
  result = this._getResult
}
return this
