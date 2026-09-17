local this = class("pet_labor_accessory_score_shell", G_BaseConfig)
local core = G_Tables.TDPetLaborAccessoryScoreTable.GetInstance()

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
  rarity_0 = 2,
  rarity_1 = 3,
  rarity_2 = 4,
  rarity_3 = 5,
  rarity_4 = 6,
  rarity_all = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLaborscore(offset)
  local str = core:GetVString(offset, this.indexMap.laborScore).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRarity_0(offset)
  return core:GetInt(offset, this.indexMap.rarity_0)
end

function this:_getRarity_1(offset)
  return core:GetInt(offset, this.indexMap.rarity_1)
end

function this:_getRarity_2(offset)
  return core:GetInt(offset, this.indexMap.rarity_2)
end

function this:_getRarity_3(offset)
  return core:GetInt(offset, this.indexMap.rarity_3)
end

function this:_getRarity_4(offset)
  return core:GetInt(offset, this.indexMap.rarity_4)
end

function this:_getRarity_all(offset)
  local str = core:GetVString(offset, this.indexMap.rarity_all).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  laborScore = this._getLaborscore,
  rarity_0 = this._getRarity_0,
  rarity_1 = this._getRarity_1,
  rarity_2 = this._getRarity_2,
  rarity_3 = this._getRarity_3,
  rarity_4 = this._getRarity_4,
  rarity_all = this._getRarity_all
}
return this
