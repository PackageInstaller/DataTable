local this = class("currency_shell", G_BaseConfig)
local core = G_Tables.TDCurrencyTable.GetInstance()

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
  name = 1,
  desc = 2,
  specialDesc = 3,
  icon = 4,
  iconSmall = 5,
  dropPrefab = 6,
  quality = 7,
  way = 8,
  wayDesc = 9,
  wayMaterialFill = 10,
  showNum = 11,
  maxNum = 12,
  holdLimit = 13
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("currency", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("currency", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getSpecialdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("currency", core:GetVString(offset, this.indexMap.specialDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "specialDesc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIconsmall(offset)
  local str = core:GetVString(offset, this.indexMap.iconSmall).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDropprefab(offset)
  return core:GetVString(offset, this.indexMap.dropPrefab).value
end

function this:_getQuality(offset)
  return core:GetInt(offset, this.indexMap.quality)
end

function this:_getWay(offset)
  local str = core:GetVString(offset, this.indexMap.way).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWaydesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("currency", core:GetVString(offset, this.indexMap.wayDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "currency")
end

function this:_getWaymaterialfill(offset)
  return core:GetInt(offset, this.indexMap.wayMaterialFill)
end

function this:_getShownum(offset)
  return core:GetInt(offset, this.indexMap.showNum)
end

function this:_getMaxnum(offset)
  return core:GetInt(offset, this.indexMap.maxNum)
end

function this:_getHoldlimit(offset)
  return core:GetInt(offset, this.indexMap.holdLimit)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  desc = this._getDesc,
  specialDesc = this._getSpecialdesc,
  icon = this._getIcon,
  iconSmall = this._getIconsmall,
  dropPrefab = this._getDropprefab,
  quality = this._getQuality,
  way = this._getWay,
  wayDesc = this._getWaydesc,
  wayMaterialFill = this._getWaymaterialfill,
  showNum = this._getShownum,
  maxNum = this._getMaxnum,
  holdLimit = this._getHoldlimit
}
return this
