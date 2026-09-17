local this = class("world_filter_shell", G_BaseConfig)
local core = G_Tables.TDWorldFilterTable.GetInstance()

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
  icon = 2,
  showType = 3,
  unlockShow = 4,
  resizingShow = 5,
  sort = 6,
  radarShow = 7,
  screeningShow = 8,
  screeningIcon = 9,
  ifDynamic = 10,
  radarDisplayDistance = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_filter", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getShowtype(offset)
  return core:GetInt(offset, this.indexMap.showType)
end

function this:_getUnlockshow(offset)
  return core:GetInt(offset, this.indexMap.unlockShow)
end

function this:_getResizingshow(offset)
  local str = core:GetVString(offset, this.indexMap.resizingShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSort(offset)
  return core:GetInt(offset, this.indexMap.sort)
end

function this:_getRadarshow(offset)
  return core:GetInt(offset, this.indexMap.radarShow)
end

function this:_getScreeningshow(offset)
  return core:GetInt(offset, this.indexMap.screeningShow)
end

function this:_getScreeningicon(offset)
  local str = core:GetVString(offset, this.indexMap.screeningIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIfdynamic(offset)
  return core:GetInt(offset, this.indexMap.ifDynamic)
end

function this:_getRadardisplaydistance(offset)
  return core:GetFloat(offset, this.indexMap.radarDisplayDistance)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  icon = this._getIcon,
  showType = this._getShowtype,
  unlockShow = this._getUnlockshow,
  resizingShow = this._getResizingshow,
  sort = this._getSort,
  radarShow = this._getRadarshow,
  screeningShow = this._getScreeningshow,
  screeningIcon = this._getScreeningicon,
  ifDynamic = this._getIfdynamic,
  radarDisplayDistance = this._getRadardisplaydistance
}
return this
