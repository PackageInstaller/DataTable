local this = class("kibo_duel_map_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelMapTable.GetInstance()

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
  art = 1,
  prefabID = 2,
  mapMode = 3,
  worldAreaId = 4,
  name = 5,
  mapPic = 6,
  npcPos = 7,
  worldBorthPos = 8,
  worldBorthPos2 = 9,
  SummonPos1 = 10,
  SummonPos2 = 11,
  nestBorthPos1 = 12,
  nestBorthPos2 = 13,
  nestBorthPos3 = 14,
  worldBossBorthPos = 15,
  kiboTower = 16,
  neutralArea = 17,
  duelArea = 18,
  collisionID = 19,
  duelPosGroup = 20,
  MovePointBlue = 21,
  MovePointRed = 22,
  MovePointWidth = 23,
  DuelStartStoryID = 24,
  KiboEnterStoryID = 25,
  DuelEndStoryID = 26,
  cameraOrbitalLowRadius = 27,
  cameraOrbitalHighRadius = 28,
  CameraLowLookAtOffset = 29,
  CameraHighLookAtOffset = 30,
  cameraOriginHeight = 31,
  cameraOriginRotate = 32,
  cameraOriginScale = 33,
  cameraBestHeight = 34,
  cameraBestRotate = 35,
  cameraBestScale = 36,
  cameraMaxHeight = 37,
  cameraMinHeight = 38,
  cameraMaxHeightAngle = 39,
  cameraMinHeightAngle = 40,
  cameraAngleY = 41,
  cameraAnglePlane = 42,
  cameraScaleSpeed = 43,
  cameraFov = 44,
  cameraProtectDisX = 45,
  cameraProtectDisZ = 46,
  cameraMovement = 47
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getArt(offset)
  return core:GetInt(offset, this.indexMap.art)
end

function this:_getPrefabid(offset)
  return core:GetInt(offset, this.indexMap.prefabID)
end

function this:_getMapmode(offset)
  return core:GetInt(offset, this.indexMap.mapMode)
end

function this:_getWorldareaid(offset)
  return core:GetInt(offset, this.indexMap.worldAreaId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_map", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getMappic(offset)
  local str = core:GetVString(offset, this.indexMap.mapPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getNpcpos(offset)
  local str = core:GetVString(offset, this.indexMap.npcPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWorldborthpos(offset)
  return core:GetInt(offset, this.indexMap.worldBorthPos)
end

function this:_getWorldborthpos2(offset)
  return core:GetInt(offset, this.indexMap.worldBorthPos2)
end

function this:_getSummonpos1(offset)
  local str = core:GetVString(offset, this.indexMap.SummonPos1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSummonpos2(offset)
  local str = core:GetVString(offset, this.indexMap.SummonPos2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNestborthpos1(offset)
  local str = core:GetVString(offset, this.indexMap.nestBorthPos1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNestborthpos2(offset)
  local str = core:GetVString(offset, this.indexMap.nestBorthPos2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNestborthpos3(offset)
  local str = core:GetVString(offset, this.indexMap.nestBorthPos3).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWorldbossborthpos(offset)
  local str = core:GetVString(offset, this.indexMap.worldBossBorthPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getKibotower(offset)
  local str = core:GetVString(offset, this.indexMap.kiboTower).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getNeutralarea(offset)
  return core:GetInt(offset, this.indexMap.neutralArea)
end

function this:_getDuelarea(offset)
  local str = core:GetVString(offset, this.indexMap.duelArea).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getCollisionid(offset)
  return core:GetInt(offset, this.indexMap.collisionID)
end

function this:_getDuelposgroup(offset)
  local str = core:GetVString(offset, this.indexMap.duelPosGroup).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getMovepointblue(offset)
  local str = core:GetVString(offset, this.indexMap.MovePointBlue).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMovepointred(offset)
  local str = core:GetVString(offset, this.indexMap.MovePointRed).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMovepointwidth(offset)
  return core:GetInt(offset, this.indexMap.MovePointWidth)
end

function this:_getDuelstartstoryid(offset)
  return core:GetInt(offset, this.indexMap.DuelStartStoryID)
end

function this:_getKiboenterstoryid(offset)
  return core:GetInt(offset, this.indexMap.KiboEnterStoryID)
end

function this:_getDuelendstoryid(offset)
  return core:GetInt(offset, this.indexMap.DuelEndStoryID)
end

function this:_getCameraorbitallowradius(offset)
  return core:GetFloat(offset, this.indexMap.cameraOrbitalLowRadius)
end

function this:_getCameraorbitalhighradius(offset)
  return core:GetFloat(offset, this.indexMap.cameraOrbitalHighRadius)
end

function this:_getCameralowlookatoffset(offset)
  return core:GetFloat(offset, this.indexMap.CameraLowLookAtOffset)
end

function this:_getCamerahighlookatoffset(offset)
  return core:GetFloat(offset, this.indexMap.CameraHighLookAtOffset)
end

function this:_getCameraoriginheight(offset)
  return core:GetFloat(offset, this.indexMap.cameraOriginHeight)
end

function this:_getCameraoriginrotate(offset)
  return core:GetFloat(offset, this.indexMap.cameraOriginRotate)
end

function this:_getCameraoriginscale(offset)
  return core:GetFloat(offset, this.indexMap.cameraOriginScale)
end

function this:_getCamerabestheight(offset)
  return core:GetFloat(offset, this.indexMap.cameraBestHeight)
end

function this:_getCamerabestrotate(offset)
  return core:GetFloat(offset, this.indexMap.cameraBestRotate)
end

function this:_getCamerabestscale(offset)
  return core:GetFloat(offset, this.indexMap.cameraBestScale)
end

function this:_getCameramaxheight(offset)
  return core:GetFloat(offset, this.indexMap.cameraMaxHeight)
end

function this:_getCameraminheight(offset)
  return core:GetFloat(offset, this.indexMap.cameraMinHeight)
end

function this:_getCameramaxheightangle(offset)
  return core:GetFloat(offset, this.indexMap.cameraMaxHeightAngle)
end

function this:_getCameraminheightangle(offset)
  return core:GetFloat(offset, this.indexMap.cameraMinHeightAngle)
end

function this:_getCameraangley(offset)
  return core:GetFloat(offset, this.indexMap.cameraAngleY)
end

function this:_getCameraangleplane(offset)
  return core:GetFloat(offset, this.indexMap.cameraAnglePlane)
end

function this:_getCamerascalespeed(offset)
  return core:GetFloat(offset, this.indexMap.cameraScaleSpeed)
end

function this:_getCamerafov(offset)
  return core:GetFloat(offset, this.indexMap.cameraFov)
end

function this:_getCameraprotectdisx(offset)
  return core:GetFloat(offset, this.indexMap.cameraProtectDisX)
end

function this:_getCameraprotectdisz(offset)
  return core:GetFloat(offset, this.indexMap.cameraProtectDisZ)
end

function this:_getCameramovement(offset)
  local str = core:GetVString(offset, this.indexMap.cameraMovement).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  art = this._getArt,
  prefabID = this._getPrefabid,
  mapMode = this._getMapmode,
  worldAreaId = this._getWorldareaid,
  name = this._getName,
  mapPic = this._getMappic,
  npcPos = this._getNpcpos,
  worldBorthPos = this._getWorldborthpos,
  worldBorthPos2 = this._getWorldborthpos2,
  SummonPos1 = this._getSummonpos1,
  SummonPos2 = this._getSummonpos2,
  nestBorthPos1 = this._getNestborthpos1,
  nestBorthPos2 = this._getNestborthpos2,
  nestBorthPos3 = this._getNestborthpos3,
  worldBossBorthPos = this._getWorldbossborthpos,
  kiboTower = this._getKibotower,
  neutralArea = this._getNeutralarea,
  duelArea = this._getDuelarea,
  collisionID = this._getCollisionid,
  duelPosGroup = this._getDuelposgroup,
  MovePointBlue = this._getMovepointblue,
  MovePointRed = this._getMovepointred,
  MovePointWidth = this._getMovepointwidth,
  DuelStartStoryID = this._getDuelstartstoryid,
  KiboEnterStoryID = this._getKiboenterstoryid,
  DuelEndStoryID = this._getDuelendstoryid,
  cameraOrbitalLowRadius = this._getCameraorbitallowradius,
  cameraOrbitalHighRadius = this._getCameraorbitalhighradius,
  CameraLowLookAtOffset = this._getCameralowlookatoffset,
  CameraHighLookAtOffset = this._getCamerahighlookatoffset,
  cameraOriginHeight = this._getCameraoriginheight,
  cameraOriginRotate = this._getCameraoriginrotate,
  cameraOriginScale = this._getCameraoriginscale,
  cameraBestHeight = this._getCamerabestheight,
  cameraBestRotate = this._getCamerabestrotate,
  cameraBestScale = this._getCamerabestscale,
  cameraMaxHeight = this._getCameramaxheight,
  cameraMinHeight = this._getCameraminheight,
  cameraMaxHeightAngle = this._getCameramaxheightangle,
  cameraMinHeightAngle = this._getCameraminheightangle,
  cameraAngleY = this._getCameraangley,
  cameraAnglePlane = this._getCameraangleplane,
  cameraScaleSpeed = this._getCamerascalespeed,
  cameraFov = this._getCamerafov,
  cameraProtectDisX = this._getCameraprotectdisx,
  cameraProtectDisZ = this._getCameraprotectdisz,
  cameraMovement = this._getCameramovement
}
return this
