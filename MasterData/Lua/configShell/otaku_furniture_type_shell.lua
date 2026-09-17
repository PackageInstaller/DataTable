local this = class("otaku_furniture_type_shell", G_BaseConfig)
local core = G_Tables.TDOtakuFurnitureTypeTable.GetInstance()

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
  bigTypeId = 0,
  name = 1,
  icon = 2
}

function this:_getBigtypeid(offset)
  return core:GetInt(offset, this.indexMap.bigTypeId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("otaku_furniture_type", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  bigTypeId = this._getBigtypeid,
  name = this._getName,
  icon = this._getIcon
}
return this
