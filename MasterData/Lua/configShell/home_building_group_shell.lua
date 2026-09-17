local this = class("home_building_group_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuildingGroupTable.GetInstance()

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
  groupId = 0,
  type = 1,
  icon = 2,
  unlockCondi = 3,
  homeLimit_1 = 4,
  name = 5,
  isUpgradable = 6,
  seriesId = 7,
  isStorable = 8,
  interactPriority = 9,
  startButtonWord = 10,
  produceTypeTitle = 11,
  interactIconInterface = 12,
  interactIconQuickClaim = 13,
  homeBuffType = 14
}

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getUnlockcondi(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondi).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getHomelimit_1(offset)
  local str = core:GetVString(offset, this.indexMap.homeLimit_1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_building_group", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIsupgradable(offset)
  return core:GetBool(offset, this.indexMap.isUpgradable)
end

function this:_getSeriesid(offset)
  return core:GetInt(offset, this.indexMap.seriesId)
end

function this:_getIsstorable(offset)
  return core:GetBool(offset, this.indexMap.isStorable)
end

function this:_getInteractpriority(offset)
  return core:GetInt(offset, this.indexMap.interactPriority)
end

function this:_getStartbuttonword(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_building_group", core:GetVString(offset, this.indexMap.startButtonWord))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "startButtonWord")
end

function this:_getProducetypetitle(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_building_group", core:GetVString(offset, this.indexMap.produceTypeTitle))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "produceTypeTitle")
end

function this:_getInteracticoninterface(offset)
  local str = core:GetVString(offset, this.indexMap.interactIconInterface).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getInteracticonquickclaim(offset)
  local str = core:GetVString(offset, this.indexMap.interactIconQuickClaim).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getHomebufftype(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_building_group", core:GetVString(offset, this.indexMap.homeBuffType))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "homeBuffType")
end

this.keyToMethodsMap = {
  groupId = this._getGroupid,
  type = this._getType,
  icon = this._getIcon,
  unlockCondi = this._getUnlockcondi,
  homeLimit_1 = this._getHomelimit_1,
  name = this._getName,
  isUpgradable = this._getIsupgradable,
  seriesId = this._getSeriesid,
  isStorable = this._getIsstorable,
  interactPriority = this._getInteractpriority,
  startButtonWord = this._getStartbuttonword,
  produceTypeTitle = this._getProducetypetitle,
  interactIconInterface = this._getInteracticoninterface,
  interactIconQuickClaim = this._getInteracticonquickclaim,
  homeBuffType = this._getHomebufftype
}
return this
