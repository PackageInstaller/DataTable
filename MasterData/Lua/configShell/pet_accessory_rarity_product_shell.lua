local this = class("pet_accessory_rarity_product_shell", G_BaseConfig)
local core = G_Tables.TDPetAccessoryRarityProductTable.GetInstance()

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
  laborScore = 1,
  rarity_all = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLaborscore(offset)
  local str = core:GetVString(offset, this.indexMap.laborScore).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRarity_all(offset)
  local str = core:GetVString(offset, this.indexMap.rarity_all).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  laborScore = this._getLaborscore,
  rarity_all = this._getRarity_all
}
return this
