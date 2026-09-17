local this = class("world_area_shell", G_BaseConfig)
local core = G_Tables.TDWorldAreaTable.GetInstance()

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
  sceneId = 2,
  teleportation = 3,
  type = 4,
  areaPos = 5,
  enterFocusPoint = 6,
  enterScale = 7,
  areaMap = 8,
  mapSize = 9,
  mapOffset = 10,
  mapRotation = 11,
  sceneSize = 12,
  vertices = 13,
  height = 14,
  cellInfo = 15,
  areaLevelCollectId = 16,
  northAngle = 17,
  miniMapResolution = 18,
  mapMaskIcon = 19,
  miniMapInitScale = 20,
  mainArea = 21,
  exp = 22,
  areaBorderLine = 23,
  isMultiPlayerCity = 24,
  multiPlayerCityName = 25,
  markAreaShow = 26,
  worldfiltermarkid = 27
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_area", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getSceneid(offset)
  return core:GetInt(offset, this.indexMap.sceneId)
end

function this:_getTeleportation(offset)
  local str = core:GetVString(offset, this.indexMap.teleportation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getAreapos(offset)
  local str = core:GetVString(offset, this.indexMap.areaPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEnterfocuspoint(offset)
  local str = core:GetVString(offset, this.indexMap.enterFocusPoint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEnterscale(offset)
  return core:GetFloat(offset, this.indexMap.enterScale)
end

function this:_getAreamap(offset)
  return core:GetVString(offset, this.indexMap.areaMap).value
end

function this:_getMapsize(offset)
  local str = core:GetVString(offset, this.indexMap.mapSize).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMapoffset(offset)
  local str = core:GetVString(offset, this.indexMap.mapOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMaprotation(offset)
  return core:GetFloat(offset, this.indexMap.mapRotation)
end

function this:_getScenesize(offset)
  local str = core:GetVString(offset, this.indexMap.sceneSize).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getVertices(offset)
  local str = core:GetVString(offset, this.indexMap.vertices).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHeight(offset)
  return core:GetFloat(offset, this.indexMap.height)
end

function this:_getCellinfo(offset)
  local str = core:GetVString(offset, this.indexMap.cellInfo).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getArealevelcollectid(offset)
  return core:GetInt(offset, this.indexMap.areaLevelCollectId)
end

function this:_getNorthangle(offset)
  return core:GetInt(offset, this.indexMap.northAngle)
end

function this:_getMinimapresolution(offset)
  local str = core:GetVString(offset, this.indexMap.miniMapResolution).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMapmaskicon(offset)
  local str = core:GetVString(offset, this.indexMap.mapMaskIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getMinimapinitscale(offset)
  return core:GetFloat(offset, this.indexMap.miniMapInitScale)
end

function this:_getMainarea(offset)
  return core:GetInt(offset, this.indexMap.mainArea)
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

function this:_getAreaborderline(offset)
  return core:GetVString(offset, this.indexMap.areaBorderLine).value
end

function this:_getIsmultiplayercity(offset)
  return core:GetInt(offset, this.indexMap.isMultiPlayerCity)
end

function this:_getMultiplayercityname(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_area", core:GetVString(offset, this.indexMap.multiPlayerCityName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "multiPlayerCityName")
end

function this:_getMarkareashow(offset)
  return core:GetInt(offset, this.indexMap.markAreaShow)
end

function this:_getWorldfiltermarkid(offset)
  return core:GetInt(offset, this.indexMap.worldfiltermarkid)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  sceneId = this._getSceneid,
  teleportation = this._getTeleportation,
  type = this._getType,
  areaPos = this._getAreapos,
  enterFocusPoint = this._getEnterfocuspoint,
  enterScale = this._getEnterscale,
  areaMap = this._getAreamap,
  mapSize = this._getMapsize,
  mapOffset = this._getMapoffset,
  mapRotation = this._getMaprotation,
  sceneSize = this._getScenesize,
  vertices = this._getVertices,
  height = this._getHeight,
  cellInfo = this._getCellinfo,
  areaLevelCollectId = this._getArealevelcollectid,
  northAngle = this._getNorthangle,
  miniMapResolution = this._getMinimapresolution,
  mapMaskIcon = this._getMapmaskicon,
  miniMapInitScale = this._getMinimapinitscale,
  mainArea = this._getMainarea,
  exp = this._getExp,
  areaBorderLine = this._getAreaborderline,
  isMultiPlayerCity = this._getIsmultiplayercity,
  multiPlayerCityName = this._getMultiplayercityname,
  markAreaShow = this._getMarkareashow,
  worldfiltermarkid = this._getWorldfiltermarkid
}
return this
