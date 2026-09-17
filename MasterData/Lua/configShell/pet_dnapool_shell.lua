local this = class("pet_dnapool_shell", G_BaseConfig)
local core = G_Tables.TDPetDnapoolTable.GetInstance()

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
  dnaGroup = 1,
  dna = 2,
  talentDnaType = 3,
  weight = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDnagroup(offset)
  return core:GetInt(offset, this.indexMap.dnaGroup)
end

function this:_getDna(offset)
  return core:GetInt(offset, this.indexMap.dna)
end

function this:_getTalentdnatype(offset)
  return core:GetInt(offset, this.indexMap.talentDnaType)
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

this.keyToMethodsMap = {
  id = this._getId,
  dnaGroup = this._getDnagroup,
  dna = this._getDna,
  talentDnaType = this._getTalentdnatype,
  weight = this._getWeight
}
return this
