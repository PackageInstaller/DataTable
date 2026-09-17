local this = class("food_type_shell", G_BaseConfig)
local core = G_Tables.TDFoodTypeTable.GetInstance()

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
  typeIcon = 2,
  titleIcon = 3,
  buttonIcon = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTypename(offset)
  local langStr = G_TableMgrIns:GetLangStr("food_type", core:GetVString(offset, this.indexMap.typeName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "typeName")
end

function this:_getTypeicon(offset)
  local str = core:GetVString(offset, this.indexMap.typeIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTitleicon(offset)
  local str = core:GetVString(offset, this.indexMap.titleIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getButtonicon(offset)
  local str = core:GetVString(offset, this.indexMap.buttonIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  typeName = this._getTypename,
  typeIcon = this._getTypeicon,
  titleIcon = this._getTitleicon,
  buttonIcon = this._getButtonicon
}
return this
