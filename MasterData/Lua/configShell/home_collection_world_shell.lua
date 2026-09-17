local this = class("home_collection_world_shell", G_BaseConfig)
local core = G_Tables.TDHomeCollectionWorldTable.GetInstance()

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
  domainId = 1,
  type = 2,
  name = 3,
  worldMapObjectUnfixed = 4,
  worldMapObjectFixed = 5,
  groupId = 6,
  pixelIcon = 7,
  idleIcon = 8,
  workingIcon = 9,
  cameraDistance = 10,
  cameraVerticalAngle = 11,
  cameraHorizontalAngle = 12,
  objectOffset = 13,
  collectionType = 14,
  localName = 15,
  controlbenchShow = 16,
  buildSound = 17,
  elementalaltarEffect = 18,
  effectPos = 19,
  worldMapId = 20,
  customBuildingCover = 21
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDomainid(offset)
  return core:GetInt(offset, this.indexMap.domainId)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_collection_world", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getWorldmapobjectunfixed(offset)
  return core:GetInt(offset, this.indexMap.worldMapObjectUnfixed)
end

function this:_getWorldmapobjectfixed(offset)
  local str = core:GetVString(offset, this.indexMap.worldMapObjectFixed).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getPixelicon(offset)
  local str = core:GetVString(offset, this.indexMap.pixelIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIdleicon(offset)
  local str = core:GetVString(offset, this.indexMap.idleIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getWorkingicon(offset)
  local str = core:GetVString(offset, this.indexMap.workingIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getCameradistance(offset)
  return core:GetFloat(offset, this.indexMap.cameraDistance)
end

function this:_getCameraverticalangle(offset)
  return core:GetFloat(offset, this.indexMap.cameraVerticalAngle)
end

function this:_getCamerahorizontalangle(offset)
  return core:GetFloat(offset, this.indexMap.cameraHorizontalAngle)
end

function this:_getObjectoffset(offset)
  local str = core:GetVString(offset, this.indexMap.objectOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCollectiontype(offset)
  return core:GetInt(offset, this.indexMap.collectionType)
end

function this:_getLocalname(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_collection_world", core:GetVString(offset, this.indexMap.localName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "localName")
end

function this:_getControlbenchshow(offset)
  local str = core:GetVString(offset, this.indexMap.controlbenchShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBuildsound(offset)
  return core:GetVString(offset, this.indexMap.buildSound).value
end

function this:_getElementalaltareffect(offset)
  local str = core:GetVString(offset, this.indexMap.elementalaltarEffect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getEffectpos(offset)
  local str = core:GetVString(offset, this.indexMap.effectPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWorldmapid(offset)
  local str = core:GetVString(offset, this.indexMap.worldMapId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCustombuildingcover(offset)
  return core:GetVString(offset, this.indexMap.customBuildingCover).value
end

this.keyToMethodsMap = {
  id = this._getId,
  domainId = this._getDomainid,
  type = this._getType,
  name = this._getName,
  worldMapObjectUnfixed = this._getWorldmapobjectunfixed,
  worldMapObjectFixed = this._getWorldmapobjectfixed,
  groupId = this._getGroupid,
  pixelIcon = this._getPixelicon,
  idleIcon = this._getIdleicon,
  workingIcon = this._getWorkingicon,
  cameraDistance = this._getCameradistance,
  cameraVerticalAngle = this._getCameraverticalangle,
  cameraHorizontalAngle = this._getCamerahorizontalangle,
  objectOffset = this._getObjectoffset,
  collectionType = this._getCollectiontype,
  localName = this._getLocalname,
  controlbenchShow = this._getControlbenchshow,
  buildSound = this._getBuildsound,
  elementalaltarEffect = this._getElementalaltareffect,
  effectPos = this._getEffectpos,
  worldMapId = this._getWorldmapid,
  customBuildingCover = this._getCustombuildingcover
}
return this
