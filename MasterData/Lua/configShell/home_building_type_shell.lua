local this = class("home_building_type_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuildingTypeTable.GetInstance()

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
  homeManageTab = 2,
  typeIcon = 3,
  labordesc = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTypename(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_building_type", core:GetVString(offset, this.indexMap.typeName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "typeName")
end

function this:_getHomemanagetab(offset)
  return core:GetInt(offset, this.indexMap.homeManageTab)
end

function this:_getTypeicon(offset)
  return core:GetVString(offset, this.indexMap.typeIcon).value
end

function this:_getLabordesc(offset)
  return core:GetVString(offset, this.indexMap.labordesc).value
end

this.keyToMethodsMap = {
  id = this._getId,
  typeName = this._getTypename,
  homeManageTab = this._getHomemanagetab,
  typeIcon = this._getTypeicon,
  labordesc = this._getLabordesc
}
return this
