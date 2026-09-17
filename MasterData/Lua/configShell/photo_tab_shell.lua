local this = class("photo_tab_shell", G_BaseConfig)
local core = G_Tables.TDPhotoTabTable.GetInstance()

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
  areaId = 0,
  sortID = 1,
  areaName = 2,
  icon = 3,
  unlockCondition = 4,
  coordinate = 5,
  mapExpand = 6,
  jumpCoordinate = 7,
  worldAreaId = 8,
  sceneId = 9,
  domainDesc = 10,
  isShowName = 11
}

function this:_getAreaid(offset)
  return core:GetInt(offset, this.indexMap.areaId)
end

function this:_getSortid(offset)
  return core:GetInt(offset, this.indexMap.sortID)
end

function this:_getAreaname(offset)
  local langStr = G_TableMgrIns:GetLangStr("photo_tab", core:GetVString(offset, this.indexMap.areaName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "areaName")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getCoordinate(offset)
  local str = core:GetVString(offset, this.indexMap.coordinate).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMapexpand(offset)
  return core:GetInt(offset, this.indexMap.mapExpand)
end

function this:_getJumpcoordinate(offset)
  local str = core:GetVString(offset, this.indexMap.jumpCoordinate).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWorldareaid(offset)
  return core:GetInt(offset, this.indexMap.worldAreaId)
end

function this:_getSceneid(offset)
  return core:GetInt(offset, this.indexMap.sceneId)
end

function this:_getDomaindesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("photo_tab", core:GetVString(offset, this.indexMap.domainDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "domainDesc")
end

function this:_getIsshowname(offset)
  return core:GetBool(offset, this.indexMap.isShowName)
end

this.keyToMethodsMap = {
  areaId = this._getAreaid,
  sortID = this._getSortid,
  areaName = this._getAreaname,
  icon = this._getIcon,
  unlockCondition = this._getUnlockcondition,
  coordinate = this._getCoordinate,
  mapExpand = this._getMapexpand,
  jumpCoordinate = this._getJumpcoordinate,
  worldAreaId = this._getWorldareaid,
  sceneId = this._getSceneid,
  domainDesc = this._getDomaindesc,
  isShowName = this._getIsshowname
}
return this
