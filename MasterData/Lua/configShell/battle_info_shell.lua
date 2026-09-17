local this = class("battle_info_shell", G_BaseConfig)
local core = G_Tables.TDBattleInfoTable.GetInstance()

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
  attrVal = 0,
  attrID = 1,
  isRatio = 2,
  name = 3,
  attrGroup = 4,
  infoDesc = 5,
  icon = 6,
  iconRogue = 7,
  showType = 8,
  sort = 9,
  showTypeOutside = 10,
  showTypeLvUp = 11,
  petShowType = 12,
  petSort = 13,
  attrDefault = 14,
  isCalRatio = 15,
  useMininumValue = 16,
  minimumValue = 17,
  useMaximumValue = 18,
  maximumValue = 19,
  pixelEffect = 20,
  pixelEffectFrame = 21,
  elementType = 22,
  isObsolete = 23
}

function this:_getAttrval(offset)
  return core:GetInt(offset, this.indexMap.attrVal)
end

function this:_getAttrid(offset)
  return core:GetVString(offset, this.indexMap.attrID).value
end

function this:_getIsratio(offset)
  return core:GetInt(offset, this.indexMap.isRatio)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("battle_info", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getAttrgroup(offset)
  local str = core:GetVString(offset, this.indexMap.attrGroup).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getInfodesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("battle_info", core:GetVString(offset, this.indexMap.infoDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "infoDesc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIconrogue(offset)
  local str = core:GetVString(offset, this.indexMap.iconRogue).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getShowtype(offset)
  return core:GetInt(offset, this.indexMap.showType)
end

function this:_getSort(offset)
  return core:GetInt(offset, this.indexMap.sort)
end

function this:_getShowtypeoutside(offset)
  return core:GetInt(offset, this.indexMap.showTypeOutside)
end

function this:_getShowtypelvup(offset)
  return core:GetInt(offset, this.indexMap.showTypeLvUp)
end

function this:_getPetshowtype(offset)
  return core:GetInt(offset, this.indexMap.petShowType)
end

function this:_getPetsort(offset)
  return core:GetInt(offset, this.indexMap.petSort)
end

function this:_getAttrdefault(offset)
  return core:GetInt(offset, this.indexMap.attrDefault)
end

function this:_getIscalratio(offset)
  return core:GetInt(offset, this.indexMap.isCalRatio)
end

function this:_getUsemininumvalue(offset)
  return core:GetBool(offset, this.indexMap.useMininumValue)
end

function this:_getMinimumvalue(offset)
  return core:GetInt(offset, this.indexMap.minimumValue)
end

function this:_getUsemaximumvalue(offset)
  return core:GetBool(offset, this.indexMap.useMaximumValue)
end

function this:_getMaximumvalue(offset)
  return core:GetInt(offset, this.indexMap.maximumValue)
end

function this:_getPixeleffect(offset)
  local str = core:GetVString(offset, this.indexMap.pixelEffect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getPixeleffectframe(offset)
  local str = core:GetVString(offset, this.indexMap.pixelEffectFrame).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getElementtype(offset)
  return core:GetInt(offset, this.indexMap.elementType)
end

function this:_getIsobsolete(offset)
  return core:GetBool(offset, this.indexMap.isObsolete)
end

this.keyToMethodsMap = {
  attrVal = this._getAttrval,
  attrID = this._getAttrid,
  isRatio = this._getIsratio,
  name = this._getName,
  attrGroup = this._getAttrgroup,
  infoDesc = this._getInfodesc,
  icon = this._getIcon,
  iconRogue = this._getIconrogue,
  showType = this._getShowtype,
  sort = this._getSort,
  showTypeOutside = this._getShowtypeoutside,
  showTypeLvUp = this._getShowtypelvup,
  petShowType = this._getPetshowtype,
  petSort = this._getPetsort,
  attrDefault = this._getAttrdefault,
  isCalRatio = this._getIscalratio,
  useMininumValue = this._getUsemininumvalue,
  minimumValue = this._getMinimumvalue,
  useMaximumValue = this._getUsemaximumvalue,
  maximumValue = this._getMaximumvalue,
  pixelEffect = this._getPixeleffect,
  pixelEffectFrame = this._getPixeleffectframe,
  elementType = this._getElementtype,
  isObsolete = this._getIsobsolete
}
return this
