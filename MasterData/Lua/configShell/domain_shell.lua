local this = class("domain_shell", G_BaseConfig)
local core = G_Tables.TDDomainTable.GetInstance()

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
  domainId = 0,
  domainName = 1,
  areaId = 2,
  worldAreaId = 3,
  focusPoint = 4,
  sceneId = 5,
  unlockCondition = 6,
  coordinate = 7,
  teleportation = 8,
  domainDesc = 9,
  domainIcon = 10,
  domainMap = 11,
  domainMapPoint = 12
}

function this:_getDomainid(offset)
  return core:GetInt(offset, this.indexMap.domainId)
end

function this:_getDomainname(offset)
  local langStr = G_TableMgrIns:GetLangStr("domain", core:GetVString(offset, this.indexMap.domainName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "domainName")
end

function this:_getAreaid(offset)
  return core:GetInt(offset, this.indexMap.areaId)
end

function this:_getWorldareaid(offset)
  return core:GetInt(offset, this.indexMap.worldAreaId)
end

function this:_getFocuspoint(offset)
  local str = core:GetVString(offset, this.indexMap.focusPoint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSceneid(offset)
  return core:GetInt(offset, this.indexMap.sceneId)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getCoordinate(offset)
  local str = core:GetVString(offset, this.indexMap.coordinate).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTeleportation(offset)
  local str = core:GetVString(offset, this.indexMap.teleportation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDomaindesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("domain", core:GetVString(offset, this.indexMap.domainDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "domainDesc")
end

function this:_getDomainicon(offset)
  local str = core:GetVString(offset, this.indexMap.domainIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDomainmap(offset)
  local str = core:GetVString(offset, this.indexMap.domainMap).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDomainmappoint(offset)
  local str = core:GetVString(offset, this.indexMap.domainMapPoint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  domainId = this._getDomainid,
  domainName = this._getDomainname,
  areaId = this._getAreaid,
  worldAreaId = this._getWorldareaid,
  focusPoint = this._getFocuspoint,
  sceneId = this._getSceneid,
  unlockCondition = this._getUnlockcondition,
  coordinate = this._getCoordinate,
  teleportation = this._getTeleportation,
  domainDesc = this._getDomaindesc,
  domainIcon = this._getDomainicon,
  domainMap = this._getDomainmap,
  domainMapPoint = this._getDomainmappoint
}
return this
