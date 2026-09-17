local this = class("pet_talent_upgrade_shell", G_BaseConfig)
local core = G_Tables.TDPetTalentUpgradeTable.GetInstance()

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
  attrId = 1,
  InterA = 2,
  InterB = 3,
  level = 4,
  nextExpVal = 5,
  nextAttrVal = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAttrid(offset)
  return core:GetInt(offset, this.indexMap.attrId)
end

function this:_getIntera(offset)
  return core:GetInt(offset, this.indexMap.InterA)
end

function this:_getInterb(offset)
  return core:GetInt(offset, this.indexMap.InterB)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getNextexpval(offset)
  return core:GetInt(offset, this.indexMap.nextExpVal)
end

function this:_getNextattrval(offset)
  return core:GetInt(offset, this.indexMap.nextAttrVal)
end

this.keyToMethodsMap = {
  id = this._getId,
  attrId = this._getAttrid,
  InterA = this._getIntera,
  InterB = this._getInterb,
  level = this._getLevel,
  nextExpVal = this._getNextexpval,
  nextAttrVal = this._getNextattrval
}
return this
