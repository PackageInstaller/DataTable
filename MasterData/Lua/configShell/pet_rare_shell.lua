local this = class("pet_rare_shell", G_BaseConfig)
local core = G_Tables.TDPetRareTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, rareType = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRaretype(offset)
  return core:GetInt(offset, this.indexMap.rareType)
end

this.keyToMethodsMap = {
  id = this._getId,
  rareType = this._getRaretype
}
return this
