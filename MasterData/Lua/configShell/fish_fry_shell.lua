local this = class("fish_fry_shell", G_BaseConfig)
local core = G_Tables.TDFishFryTable.GetInstance()

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
  fryName = 1,
  product = 2,
  time = 3,
  icon = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFryname(offset)
  local langStr = G_TableMgrIns:GetLangStr("fish_fry", core:GetVString(offset, this.indexMap.fryName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "fryName")
end

function this:_getProduct(offset)
  return core:GetInt(offset, this.indexMap.product)
end

function this:_getTime(offset)
  return core:GetInt(offset, this.indexMap.time)
end

function this:_getIcon(offset)
  return core:GetInt(offset, this.indexMap.icon)
end

this.keyToMethodsMap = {
  id = this._getId,
  fryName = this._getFryname,
  product = this._getProduct,
  time = this._getTime,
  icon = this._getIcon
}
return this
