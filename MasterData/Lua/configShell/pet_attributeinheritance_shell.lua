local this = class("pet_attributeinheritance_shell", G_BaseConfig)
local core = G_Tables.TDPetAttributeinheritanceTable.GetInstance()

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
  name = 1,
  attrVal = 2,
  attrId = 3,
  adjustment = 4,
  petAttrVal = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_attributeinheritance", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getAttrval(offset)
  return core:GetInt(offset, this.indexMap.attrVal)
end

function this:_getAttrid(offset)
  return core:GetVString(offset, this.indexMap.attrId).value
end

function this:_getAdjustment(offset)
  return core:GetInt(offset, this.indexMap.adjustment)
end

function this:_getPetattrval(offset)
  return core:GetInt(offset, this.indexMap.petAttrVal)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  attrVal = this._getAttrval,
  attrId = this._getAttrid,
  adjustment = this._getAdjustment,
  petAttrVal = this._getPetattrval
}
return this
