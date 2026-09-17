local this = class("pet_dnadrop_shell", G_BaseConfig)
local core = G_Tables.TDPetDnadropTable.GetInstance()

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
  petId = 1,
  rarity = 2,
  mod = 3,
  weight = 4,
  dnaPoolId = 5,
  _note = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPetid(offset)
  return core:GetInt(offset, this.indexMap.petId)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getMod(offset)
  return core:GetInt(offset, this.indexMap.mod)
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

function this:_getDnapoolid(offset)
  return core:GetInt(offset, this.indexMap.dnaPoolId)
end

function this:_get_note(offset)
  return core:GetVString(offset, this.indexMap._note).value
end

this.keyToMethodsMap = {
  id = this._getId,
  petId = this._getPetid,
  rarity = this._getRarity,
  mod = this._getMod,
  weight = this._getWeight,
  dnaPoolId = this._getDnapoolid,
  _note = this._get_note
}
return this
