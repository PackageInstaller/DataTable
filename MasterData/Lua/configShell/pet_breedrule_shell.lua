local this = class("pet_breedrule_shell", G_BaseConfig)
local core = G_Tables.TDPetBreedruleTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, ruleDesc = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRuledesc(offset)
  return core:GetVString(offset, this.indexMap.ruleDesc).value
end

this.keyToMethodsMap = {
  id = this._getId,
  ruleDesc = this._getRuledesc
}
return this
