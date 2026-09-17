local this = class("products_collection_type_shell", G_BaseConfig)
local core = G_Tables.TDProductsCollectionTypeTable.GetInstance()

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
  typeName = 1,
  isShowInOutput = 2,
  nameInOutput = 3,
  icon = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTypename(offset)
  local langStr = G_TableMgrIns:GetLangStr("products_collection_type", core:GetVString(offset, this.indexMap.typeName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "typeName")
end

function this:_getIsshowinoutput(offset)
  return core:GetBool(offset, this.indexMap.isShowInOutput)
end

function this:_getNameinoutput(offset)
  local langStr = G_TableMgrIns:GetLangStr("products_collection_type", core:GetVString(offset, this.indexMap.nameInOutput))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "nameInOutput")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  typeName = this._getTypename,
  isShowInOutput = this._getIsshowinoutput,
  nameInOutput = this._getNameinoutput,
  icon = this._getIcon
}
return this
