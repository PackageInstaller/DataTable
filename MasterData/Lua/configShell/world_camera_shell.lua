local this = class("world_camera_shell", G_BaseConfig)
local core = G_Tables.TDWorldCameraTable.GetInstance()

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
  targetOffset = 1,
  lookAtOffset = 2,
  cameraDirType = 3,
  cameraDirOffset = 4,
  sight = 5,
  fov = 6,
  blendStyle = 7,
  enterBlendTime = 8,
  exitBlendTime = 9,
  waitTime = 10,
  shakeType = 11,
  shakeStartTime = 12,
  shakeTime = 13,
  shakeRange = 14,
  frequency = 15,
  positionShakeRange = 16,
  positionFrequency = 17,
  rotationShakeRange = 18,
  rotationFrequency = 19,
  offset = 20,
  blurStartTime = 21,
  blurTime = 22,
  focusDistance = 23,
  blurStrength = 24,
  cameraType = 25,
  cameraFreeParameters = 26,
  lookAtTargetMode = 27
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTargetoffset(offset)
  local str = core:GetVString(offset, this.indexMap.targetOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getLookatoffset(offset)
  local str = core:GetVString(offset, this.indexMap.lookAtOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getCameradirtype(offset)
  local str = core:GetVString(offset, this.indexMap.cameraDirType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCameradiroffset(offset)
  local str = core:GetVString(offset, this.indexMap.cameraDirOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSight(offset)
  local str = core:GetVString(offset, this.indexMap.sight).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getFov(offset)
  local str = core:GetVString(offset, this.indexMap.fov).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBlendstyle(offset)
  local str = core:GetVString(offset, this.indexMap.blendStyle).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEnterblendtime(offset)
  local str = core:GetVString(offset, this.indexMap.enterBlendTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getExitblendtime(offset)
  local str = core:GetVString(offset, this.indexMap.exitBlendTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWaittime(offset)
  local str = core:GetVString(offset, this.indexMap.waitTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getShaketype(offset)
  local str = core:GetVString(offset, this.indexMap.shakeType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getShakestarttime(offset)
  local str = core:GetVString(offset, this.indexMap.shakeStartTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getShaketime(offset)
  local str = core:GetVString(offset, this.indexMap.shakeTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getShakerange(offset)
  local str = core:GetVString(offset, this.indexMap.shakeRange).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getFrequency(offset)
  local str = core:GetVString(offset, this.indexMap.frequency).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPositionshakerange(offset)
  local str = core:GetVString(offset, this.indexMap.positionShakeRange).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPositionfrequency(offset)
  local str = core:GetVString(offset, this.indexMap.positionFrequency).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRotationshakerange(offset)
  local str = core:GetVString(offset, this.indexMap.rotationShakeRange).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRotationfrequency(offset)
  local str = core:GetVString(offset, this.indexMap.rotationFrequency).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getOffset(offset)
  local str = core:GetVString(offset, this.indexMap.offset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBlurstarttime(offset)
  local str = core:GetVString(offset, this.indexMap.blurStartTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBlurtime(offset)
  local str = core:GetVString(offset, this.indexMap.blurTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getFocusdistance(offset)
  local str = core:GetVString(offset, this.indexMap.focusDistance).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBlurstrength(offset)
  local str = core:GetVString(offset, this.indexMap.blurStrength).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCameratype(offset)
  local str = core:GetVString(offset, this.indexMap.cameraType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCamerafreeparameters(offset)
  local str = core:GetVString(offset, this.indexMap.cameraFreeParameters).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getLookattargetmode(offset)
  return core:GetInt(offset, this.indexMap.lookAtTargetMode)
end

this.keyToMethodsMap = {
  id = this._getId,
  targetOffset = this._getTargetoffset,
  lookAtOffset = this._getLookatoffset,
  cameraDirType = this._getCameradirtype,
  cameraDirOffset = this._getCameradiroffset,
  sight = this._getSight,
  fov = this._getFov,
  blendStyle = this._getBlendstyle,
  enterBlendTime = this._getEnterblendtime,
  exitBlendTime = this._getExitblendtime,
  waitTime = this._getWaittime,
  shakeType = this._getShaketype,
  shakeStartTime = this._getShakestarttime,
  shakeTime = this._getShaketime,
  shakeRange = this._getShakerange,
  frequency = this._getFrequency,
  positionShakeRange = this._getPositionshakerange,
  positionFrequency = this._getPositionfrequency,
  rotationShakeRange = this._getRotationshakerange,
  rotationFrequency = this._getRotationfrequency,
  offset = this._getOffset,
  blurStartTime = this._getBlurstarttime,
  blurTime = this._getBlurtime,
  focusDistance = this._getFocusdistance,
  blurStrength = this._getBlurstrength,
  cameraType = this._getCameratype,
  cameraFreeParameters = this._getCamerafreeparameters,
  lookAtTargetMode = this._getLookattargetmode
}
return this
