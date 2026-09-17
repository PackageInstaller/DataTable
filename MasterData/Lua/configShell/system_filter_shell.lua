local this = class("system_filter_shell", G_BaseConfig)
local core = G_Tables.TDSystemFilterTable.GetInstance()

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
  filterComponents = 1,
  filterConfig = 2,
  sortComponents = 3,
  isReverseOpen = 4,
  sortType = 5,
  sortPicks = 6,
  sortPicksLimit = 7,
  solidSortKey = 8,
  subSortKey = 9,
  groupName = 10
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFiltercomponents(offset)
  return core:GetInt(offset, this.indexMap.filterComponents)
end

function this:_getFilterconfig(offset)
  local str = core:GetVString(offset, this.indexMap.filterConfig).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSortcomponents(offset)
  return core:GetInt(offset, this.indexMap.sortComponents)
end

function this:_getIsreverseopen(offset)
  return core:GetInt(offset, this.indexMap.isReverseOpen)
end

function this:_getSorttype(offset)
  local str = core:GetVString(offset, this.indexMap.sortType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSortpicks(offset)
  local str = core:GetVString(offset, this.indexMap.sortPicks).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSortpickslimit(offset)
  return core:GetInt(offset, this.indexMap.sortPicksLimit)
end

function this:_getSolidsortkey(offset)
  local str = core:GetVString(offset, this.indexMap.solidSortKey).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSubsortkey(offset)
  local str = core:GetVString(offset, this.indexMap.subSortKey).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getGroupname(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("system_filter", core:GetVString(offset, this.indexMap.groupName))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "system_filter")
end

this.keyToMethodsMap = {
  id = this._getId,
  filterComponents = this._getFiltercomponents,
  filterConfig = this._getFilterconfig,
  sortComponents = this._getSortcomponents,
  isReverseOpen = this._getIsreverseopen,
  sortType = this._getSorttype,
  sortPicks = this._getSortpicks,
  sortPicksLimit = this._getSortpickslimit,
  solidSortKey = this._getSolidsortkey,
  subSortKey = this._getSubsortkey,
  groupName = this._getGroupname
}
return this
