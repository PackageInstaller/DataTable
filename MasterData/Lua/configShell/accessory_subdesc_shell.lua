local this = class("accessory_subdesc_shell", G_BaseConfig)
local core = G_Tables.TDAccessorySubdescTable.GetInstance()

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
  attrVal = 0,
  attrID = 1,
  isRatio = 2,
  name = 3,
  attrGroup = 4
}

function this:_getAttrval(offset)
  return core:GetInt(offset, this.indexMap.attrVal)
end

function this:_getAttrid(offset)
  return core:GetVString(offset, this.indexMap.attrID).value
end

function this:_getIsratio(offset)
  return core:GetInt(offset, this.indexMap.isRatio)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("accessory_subdesc", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getAttrgroup(offset)
  local str = core:GetVString(offset, this.indexMap.attrGroup).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  attrVal = this._getAttrval,
  attrID = this._getAttrid,
  isRatio = this._getIsratio,
  name = this._getName,
  attrGroup = this._getAttrgroup
}
return this
