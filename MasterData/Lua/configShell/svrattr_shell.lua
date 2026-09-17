local this = class("svrattr_shell", G_BaseConfig)
local core = G_Tables.TDSvrattrTable.GetInstance()

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
  AttrId = 0,
  type = 1,
  AttrVal = 2,
  Max = 3
}

function this:_getAttrid(offset)
  return core:GetVString(offset, this.indexMap.AttrId).value
end

function this:_getType(offset)
  return core:GetVString(offset, this.indexMap.type).value
end

function this:_getAttrval(offset)
  return core:GetInt(offset, this.indexMap.AttrVal)
end

function this:_getMax(offset)
  return core:GetInt(offset, this.indexMap.Max)
end

this.keyToMethodsMap = {
  AttrId = this._getAttrid,
  type = this._getType,
  AttrVal = this._getAttrval,
  Max = this._getMax
}
return this
