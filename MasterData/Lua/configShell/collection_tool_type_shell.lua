local this = class("collection_tool_type_shell", G_BaseConfig)
local core = G_Tables.TDCollectionToolTypeTable.GetInstance()

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
  type = 0,
  name = 1,
  icon = 2,
  typeIcon = 3,
  typegroup = 4,
  action = 5
}

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("collection_tool_type", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTypeicon(offset)
  local str = core:GetVString(offset, this.indexMap.typeIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTypegroup(offset)
  local str = core:GetVString(offset, this.indexMap.typegroup).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getAction(offset)
  return core:GetInt(offset, this.indexMap.action)
end

this.keyToMethodsMap = {
  type = this._getType,
  name = this._getName,
  icon = this._getIcon,
  typeIcon = this._getTypeicon,
  typegroup = this._getTypegroup,
  action = this._getAction
}
return this
