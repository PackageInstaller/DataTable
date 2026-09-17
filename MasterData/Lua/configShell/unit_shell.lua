local this = class("unit_shell", G_BaseConfig)
local core = G_Tables.TDUnitTable.GetInstance()

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
  model = 1,
  animatorConfig = 2,
  animatorTimelinePreload = 3,
  characterControl = 4,
  animBakeConfig = 5,
  avatarTexture = 6,
  fsmconfig = 7,
  moveSpeedAcceleration = 8,
  rotationAngularVelocity = 9,
  moveDirAngularVelocity = 10,
  modelSpeed = 11,
  speedRunSpeed = 12,
  walkSpeed = 13,
  spStopStartFrame = 14,
  effectScale = 15,
  starlinkEffectScale = 16,
  worldEffectScale = 17,
  floatingTextRange = 18,
  colliderId = 19,
  kibocollider = 20,
  colliderParm = 21,
  yLock = 22,
  fallowCamShift = 23,
  swimmingFollowCamShift = 24,
  focusCamShift = 25,
  focusMountCamShift = 26,
  CatchfollowCamShift = 27,
  photoPose = 28,
  photoExpr = 29,
  modelScale = 30,
  homePetModelScale = 31,
  petModelScale = 32,
  skillBodyTag = 33,
  bloodBarNode = 34,
  bloodBarPos = 35,
  bloodBarType = 36,
  resonanceRotate = 37,
  petIcon = 38,
  looaAtCamera = 39,
  unlockBossCamera = 40,
  unlockBossCameraPriority = 41,
  looaAtTime = 42,
  lookAtIkDistance = 43,
  lookAtIkAngle = 44,
  lookAtIkPoint = 45,
  beHitPoint = 46,
  deadEffect = 47,
  corpseTime = 48,
  animId = 49,
  swimEffect = 50,
  intowaterBubbleEffectTime = 51,
  intowaterEffectTime = 52,
  intowaterEffectSpeed = 53,
  personalEffect = 54,
  specialParm = 55,
  knockDataIndex = 56,
  beHitSpace = 57,
  damageEffectZOffect = 58,
  fondleAniParam = 59,
  monsterCamera = 60,
  monsterCameraDistance = 61,
  disableMove = 62,
  kiboArenaBodyType = 63
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getModel(offset)
  local str = core:GetVString(offset, this.indexMap.model).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getAnimatorconfig(offset)
  local str = core:GetVString(offset, this.indexMap.animatorConfig).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 12)
end

function this:_getAnimatortimelinepreload(offset)
  return core:GetVString(offset, this.indexMap.animatorTimelinePreload).value
end

function this:_getCharactercontrol(offset)
  local str = core:GetVString(offset, this.indexMap.characterControl).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getAnimbakeconfig(offset)
  local str = core:GetVString(offset, this.indexMap.animBakeConfig).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getAvatartexture(offset)
  local str = core:GetVString(offset, this.indexMap.avatarTexture).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 6)
end

function this:_getFsmconfig(offset)
  local str = core:GetVString(offset, this.indexMap.fsmconfig).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 4)
end

function this:_getMovespeedacceleration(offset)
  return core:GetFloat(offset, this.indexMap.moveSpeedAcceleration)
end

function this:_getRotationangularvelocity(offset)
  return core:GetInt(offset, this.indexMap.rotationAngularVelocity)
end

function this:_getMovedirangularvelocity(offset)
  return core:GetInt(offset, this.indexMap.moveDirAngularVelocity)
end

function this:_getModelspeed(offset)
  return core:GetFloat(offset, this.indexMap.modelSpeed)
end

function this:_getSpeedrunspeed(offset)
  return core:GetFloat(offset, this.indexMap.speedRunSpeed)
end

function this:_getWalkspeed(offset)
  return core:GetFloat(offset, this.indexMap.walkSpeed)
end

function this:_getSpstopstartframe(offset)
  return core:GetInt(offset, this.indexMap.spStopStartFrame)
end

function this:_getEffectscale(offset)
  return core:GetInt(offset, this.indexMap.effectScale)
end

function this:_getStarlinkeffectscale(offset)
  return core:GetInt(offset, this.indexMap.starlinkEffectScale)
end

function this:_getWorldeffectscale(offset)
  return core:GetInt(offset, this.indexMap.worldEffectScale)
end

function this:_getFloatingtextrange(offset)
  return core:GetFloat(offset, this.indexMap.floatingTextRange)
end

function this:_getColliderid(offset)
  return core:GetInt(offset, this.indexMap.colliderId)
end

function this:_getKibocollider(offset)
  local str = core:GetVString(offset, this.indexMap.kibocollider).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getColliderparm(offset)
  return core:GetFloat(offset, this.indexMap.colliderParm)
end

function this:_getYlock(offset)
  return core:GetInt(offset, this.indexMap.yLock)
end

function this:_getFallowcamshift(offset)
  return core:GetFloat(offset, this.indexMap.fallowCamShift)
end

function this:_getSwimmingfollowcamshift(offset)
  return core:GetFloat(offset, this.indexMap.swimmingFollowCamShift)
end

function this:_getFocuscamshift(offset)
  return core:GetFloat(offset, this.indexMap.focusCamShift)
end

function this:_getFocusmountcamshift(offset)
  return core:GetFloat(offset, this.indexMap.focusMountCamShift)
end

function this:_getCatchfollowcamshift(offset)
  return core:GetFloat(offset, this.indexMap.CatchfollowCamShift)
end

function this:_getPhotopose(offset)
  local str = core:GetVString(offset, this.indexMap.photoPose).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPhotoexpr(offset)
  local str = core:GetVString(offset, this.indexMap.photoExpr).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getModelscale(offset)
  local str = core:GetVString(offset, this.indexMap.modelScale).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHomepetmodelscale(offset)
  local str = core:GetVString(offset, this.indexMap.homePetModelScale).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetmodelscale(offset)
  local str = core:GetVString(offset, this.indexMap.petModelScale).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSkillbodytag(offset)
  return core:GetInt(offset, this.indexMap.skillBodyTag)
end

function this:_getBloodbarnode(offset)
  return core:GetVString(offset, this.indexMap.bloodBarNode).value
end

function this:_getBloodbarpos(offset)
  local str = core:GetVString(offset, this.indexMap.bloodBarPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBloodbartype(offset)
  return core:GetInt(offset, this.indexMap.bloodBarType)
end

function this:_getResonancerotate(offset)
  return core:GetFloat(offset, this.indexMap.resonanceRotate)
end

function this:_getPeticon(offset)
  local str = core:GetVString(offset, this.indexMap.petIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getLooaatcamera(offset)
  local str = core:GetVString(offset, this.indexMap.looaAtCamera).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getUnlockbosscamera(offset)
  local str = core:GetVString(offset, this.indexMap.unlockBossCamera).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getUnlockbosscamerapriority(offset)
  return core:GetInt(offset, this.indexMap.unlockBossCameraPriority)
end

function this:_getLooaattime(offset)
  return core:GetInt(offset, this.indexMap.looaAtTime)
end

function this:_getLookatikdistance(offset)
  return core:GetFloat(offset, this.indexMap.lookAtIkDistance)
end

function this:_getLookatikangle(offset)
  local str = core:GetVString(offset, this.indexMap.lookAtIkAngle).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getLookatikpoint(offset)
  return core:GetVString(offset, this.indexMap.lookAtIkPoint).value
end

function this:_getBehitpoint(offset)
  local str = core:GetVString(offset, this.indexMap.beHitPoint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getDeadeffect(offset)
  local str = core:GetVString(offset, this.indexMap.deadEffect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getCorpsetime(offset)
  return core:GetFloat(offset, this.indexMap.corpseTime)
end

function this:_getAnimid(offset)
  return core:GetInt(offset, this.indexMap.animId)
end

function this:_getSwimeffect(offset)
  local str = core:GetVString(offset, this.indexMap.swimEffect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getIntowaterbubbleeffecttime(offset)
  return core:GetInt(offset, this.indexMap.intowaterBubbleEffectTime)
end

function this:_getIntowatereffecttime(offset)
  return core:GetInt(offset, this.indexMap.intowaterEffectTime)
end

function this:_getIntowatereffectspeed(offset)
  return core:GetFloat(offset, this.indexMap.intowaterEffectSpeed)
end

function this:_getPersonaleffect(offset)
  local str = core:GetVString(offset, this.indexMap.personalEffect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "string")
end

function this:_getSpecialparm(offset)
  local str = core:GetVString(offset, this.indexMap.specialParm).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getKnockdataindex(offset)
  return core:GetInt(offset, this.indexMap.knockDataIndex)
end

function this:_getBehitspace(offset)
  return core:GetFloat(offset, this.indexMap.beHitSpace)
end

function this:_getDamageeffectzoffect(offset)
  return core:GetFloat(offset, this.indexMap.damageEffectZOffect)
end

function this:_getFondleaniparam(offset)
  local str = core:GetVString(offset, this.indexMap.fondleAniParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getMonstercamera(offset)
  local str = core:GetVString(offset, this.indexMap.monsterCamera).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getMonstercameradistance(offset)
  local str = core:GetVString(offset, this.indexMap.monsterCameraDistance).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDisablemove(offset)
  return core:GetInt(offset, this.indexMap.disableMove)
end

function this:_getKiboarenabodytype(offset)
  return core:GetInt(offset, this.indexMap.kiboArenaBodyType)
end

this.keyToMethodsMap = {
  id = this._getId,
  model = this._getModel,
  animatorConfig = this._getAnimatorconfig,
  animatorTimelinePreload = this._getAnimatortimelinepreload,
  characterControl = this._getCharactercontrol,
  animBakeConfig = this._getAnimbakeconfig,
  avatarTexture = this._getAvatartexture,
  fsmconfig = this._getFsmconfig,
  moveSpeedAcceleration = this._getMovespeedacceleration,
  rotationAngularVelocity = this._getRotationangularvelocity,
  moveDirAngularVelocity = this._getMovedirangularvelocity,
  modelSpeed = this._getModelspeed,
  speedRunSpeed = this._getSpeedrunspeed,
  walkSpeed = this._getWalkspeed,
  spStopStartFrame = this._getSpstopstartframe,
  effectScale = this._getEffectscale,
  starlinkEffectScale = this._getStarlinkeffectscale,
  worldEffectScale = this._getWorldeffectscale,
  floatingTextRange = this._getFloatingtextrange,
  colliderId = this._getColliderid,
  kibocollider = this._getKibocollider,
  colliderParm = this._getColliderparm,
  yLock = this._getYlock,
  fallowCamShift = this._getFallowcamshift,
  swimmingFollowCamShift = this._getSwimmingfollowcamshift,
  focusCamShift = this._getFocuscamshift,
  focusMountCamShift = this._getFocusmountcamshift,
  CatchfollowCamShift = this._getCatchfollowcamshift,
  photoPose = this._getPhotopose,
  photoExpr = this._getPhotoexpr,
  modelScale = this._getModelscale,
  homePetModelScale = this._getHomepetmodelscale,
  petModelScale = this._getPetmodelscale,
  skillBodyTag = this._getSkillbodytag,
  bloodBarNode = this._getBloodbarnode,
  bloodBarPos = this._getBloodbarpos,
  bloodBarType = this._getBloodbartype,
  resonanceRotate = this._getResonancerotate,
  petIcon = this._getPeticon,
  looaAtCamera = this._getLooaatcamera,
  unlockBossCamera = this._getUnlockbosscamera,
  unlockBossCameraPriority = this._getUnlockbosscamerapriority,
  looaAtTime = this._getLooaattime,
  lookAtIkDistance = this._getLookatikdistance,
  lookAtIkAngle = this._getLookatikangle,
  lookAtIkPoint = this._getLookatikpoint,
  beHitPoint = this._getBehitpoint,
  deadEffect = this._getDeadeffect,
  corpseTime = this._getCorpsetime,
  animId = this._getAnimid,
  swimEffect = this._getSwimeffect,
  intowaterBubbleEffectTime = this._getIntowaterbubbleeffecttime,
  intowaterEffectTime = this._getIntowatereffecttime,
  intowaterEffectSpeed = this._getIntowatereffectspeed,
  personalEffect = this._getPersonaleffect,
  specialParm = this._getSpecialparm,
  knockDataIndex = this._getKnockdataindex,
  beHitSpace = this._getBehitspace,
  damageEffectZOffect = this._getDamageeffectzoffect,
  fondleAniParam = this._getFondleaniparam,
  monsterCamera = this._getMonstercamera,
  monsterCameraDistance = this._getMonstercameradistance,
  disableMove = this._getDisablemove,
  kiboArenaBodyType = this._getKiboarenabodytype
}
return this
