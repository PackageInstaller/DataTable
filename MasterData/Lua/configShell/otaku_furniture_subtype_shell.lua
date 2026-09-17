local this = class("otaku_furniture_subtype_shell", G_BaseConfig)
local core = G_Tables.TDOtakuFurnitureSubtypeTable.GetInstance()

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
  subTypeId = 0,
  typeId = 1,
  name = 2,
  icon = 3
}

function this:_getSubtypeid(offset)
  return core:GetInt(offset, this.indexMap.subTypeId)
end

function this:_getTypeid(offset)
  return core:GetInt(offset, this.indexMap.typeId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("otaku_furniture_subtype", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  subTypeId = this._getSubtypeid,
  typeId = this._getTypeid,
  name = this._getName,
  icon = this._getIcon
}
return this
