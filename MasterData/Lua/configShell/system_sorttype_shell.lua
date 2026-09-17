local this = class("system_sorttype_shell", G_BaseConfig)
local core = G_Tables.TDSystemSorttypeTable.GetInstance()

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
  sortTypeName = 1,
  sortPara = 2,
  isAscending = 3,
  optionIcon = 4,
  maskType = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSorttypename(offset)
  local langStr = G_TableMgrIns:GetLangStr("system_sorttype", core:GetVString(offset, this.indexMap.sortTypeName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "sortTypeName")
end

function this:_getSortpara(offset)
  local str = core:GetVString(offset, this.indexMap.sortPara).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIsascending(offset)
  return core:GetInt(offset, this.indexMap.isAscending)
end

function this:_getOptionicon(offset)
  local str = core:GetVString(offset, this.indexMap.optionIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getMasktype(offset)
  return core:GetInt(offset, this.indexMap.maskType)
end

this.keyToMethodsMap = {
  id = this._getId,
  sortTypeName = this._getSorttypename,
  sortPara = this._getSortpara,
  isAscending = this._getIsascending,
  optionIcon = this._getOptionicon,
  maskType = this._getMasktype
}
return this
