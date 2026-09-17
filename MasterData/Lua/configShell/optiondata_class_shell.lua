local this = class("optiondata_class_shell", G_BaseConfig)
local core = G_Tables.TDOptionDataClassTable.GetInstance()

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
  optionclassName = 1,
  displayFilters = 2,
  englishDecorate = 3,
  icon = 4,
  datastorage = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getOptionclassname(offset)
  local langStr = G_TableMgrIns:GetLangStr("optionData_class", core:GetVString(offset, this.indexMap.optionclassName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "optionclassName")
end

function this:_getDisplayfilters(offset)
  return core:GetInt(offset, this.indexMap.displayFilters)
end

function this:_getEnglishdecorate(offset)
  return core:GetVString(offset, this.indexMap.englishDecorate).value
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDatastorage(offset)
  return core:GetInt(offset, this.indexMap.datastorage)
end

this.keyToMethodsMap = {
  id = this._getId,
  optionclassName = this._getOptionclassname,
  displayFilters = this._getDisplayfilters,
  englishDecorate = this._getEnglishdecorate,
  icon = this._getIcon,
  datastorage = this._getDatastorage
}
return this
