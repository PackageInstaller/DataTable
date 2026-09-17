local this = class("system_filtertype_shell", G_BaseConfig)
local core = G_Tables.TDSystemFiltertypeTable.GetInstance()

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
  filterTypeName = 1,
  filterTable = 2,
  filterKey = 3,
  filterName = 4,
  filterContent = 5,
  iconDisplay = 6,
  maskType = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFiltertypename(offset)
  local langStr = G_TableMgrIns:GetLangStr("system_filtertype", core:GetVString(offset, this.indexMap.filterTypeName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "filterTypeName")
end

function this:_getFiltertable(offset)
  return core:GetVString(offset, this.indexMap.filterTable).value
end

function this:_getFilterkey(offset)
  return core:GetVString(offset, this.indexMap.filterKey).value
end

function this:_getFiltername(offset)
  return core:GetVString(offset, this.indexMap.filterName).value
end

function this:_getFiltercontent(offset)
  local str = core:GetVString(offset, this.indexMap.filterContent).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIcondisplay(offset)
  return core:GetVString(offset, this.indexMap.iconDisplay).value
end

function this:_getMasktype(offset)
  return core:GetInt(offset, this.indexMap.maskType)
end

this.keyToMethodsMap = {
  id = this._getId,
  filterTypeName = this._getFiltertypename,
  filterTable = this._getFiltertable,
  filterKey = this._getFilterkey,
  filterName = this._getFiltername,
  filterContent = this._getFiltercontent,
  iconDisplay = this._getIcondisplay,
  maskType = this._getMasktype
}
return this
