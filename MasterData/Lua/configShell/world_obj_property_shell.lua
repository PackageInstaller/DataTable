local this = class("world_obj_property_shell", G_BaseConfig)
local core = G_Tables.TDWorldObjPropertyTable.GetInstance()

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
  walkAnim = 1,
  runAnim = 2,
  walkSpeed = 3,
  runSpeed = 4,
  patrolRadius = 5,
  patrolHeight = 6,
  patrolInterval = 7,
  patrolMotionType = 8,
  patrolSpeedRatio = 9,
  IsAggressive = 10,
  chaseRadius = 11,
  chaseHeight = 12,
  escapeRadius = 13,
  escapeInnerRadius = 14,
  strongAlertRadius = 15,
  strongAlertHeight = 16,
  strongAlertAngle = 17,
  weakAlertRadius = 18,
  weakAlertHeight = 19,
  weakAlertAngle = 20,
  strongAlertValueEdge = 21,
  weakAlertValueEdge = 22,
  alertValueKeepTime = 23,
  alertValueCoolTime = 24,
  weakAlertValueAdd = 25,
  strongAlertValueAdd = 26,
  backStartAlertValueDel = 27,
  commonAlertValueDel = 28,
  leaveBattleTime = 29,
  traceFailureRadius = 30,
  visionDistance = 31,
  warningDistance = 32,
  alertStateType = 33,
  characterState = 34
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getWalkanim(offset)
  return core:GetVString(offset, this.indexMap.walkAnim).value
end

function this:_getRunanim(offset)
  return core:GetVString(offset, this.indexMap.runAnim).value
end

function this:_getWalkspeed(offset)
  return core:GetFloat(offset, this.indexMap.walkSpeed)
end

function this:_getRunspeed(offset)
  return core:GetFloat(offset, this.indexMap.runSpeed)
end

function this:_getPatrolradius(offset)
  return core:GetFloat(offset, this.indexMap.patrolRadius)
end

function this:_getPatrolheight(offset)
  return core:GetFloat(offset, this.indexMap.patrolHeight)
end

function this:_getPatrolinterval(offset)
  return core:GetFloat(offset, this.indexMap.patrolInterval)
end

function this:_getPatrolmotiontype(offset)
  return core:GetInt(offset, this.indexMap.patrolMotionType)
end

function this:_getPatrolspeedratio(offset)
  return core:GetFloat(offset, this.indexMap.patrolSpeedRatio)
end

function this:_getIsaggressive(offset)
  return core:GetInt(offset, this.indexMap.IsAggressive)
end

function this:_getChaseradius(offset)
  return core:GetFloat(offset, this.indexMap.chaseRadius)
end

function this:_getChaseheight(offset)
  return core:GetFloat(offset, this.indexMap.chaseHeight)
end

function this:_getEscaperadius(offset)
  return core:GetFloat(offset, this.indexMap.escapeRadius)
end

function this:_getEscapeinnerradius(offset)
  return core:GetFloat(offset, this.indexMap.escapeInnerRadius)
end

function this:_getStrongalertradius(offset)
  return core:GetFloat(offset, this.indexMap.strongAlertRadius)
end

function this:_getStrongalertheight(offset)
  return core:GetFloat(offset, this.indexMap.strongAlertHeight)
end

function this:_getStrongalertangle(offset)
  return core:GetFloat(offset, this.indexMap.strongAlertAngle)
end

function this:_getWeakalertradius(offset)
  return core:GetFloat(offset, this.indexMap.weakAlertRadius)
end

function this:_getWeakalertheight(offset)
  return core:GetFloat(offset, this.indexMap.weakAlertHeight)
end

function this:_getWeakalertangle(offset)
  return core:GetFloat(offset, this.indexMap.weakAlertAngle)
end

function this:_getStrongalertvalueedge(offset)
  return core:GetFloat(offset, this.indexMap.strongAlertValueEdge)
end

function this:_getWeakalertvalueedge(offset)
  return core:GetFloat(offset, this.indexMap.weakAlertValueEdge)
end

function this:_getAlertvaluekeeptime(offset)
  return core:GetFloat(offset, this.indexMap.alertValueKeepTime)
end

function this:_getAlertvaluecooltime(offset)
  return core:GetFloat(offset, this.indexMap.alertValueCoolTime)
end

function this:_getWeakalertvalueadd(offset)
  return core:GetFloat(offset, this.indexMap.weakAlertValueAdd)
end

function this:_getStrongalertvalueadd(offset)
  return core:GetFloat(offset, this.indexMap.strongAlertValueAdd)
end

function this:_getBackstartalertvaluedel(offset)
  return core:GetFloat(offset, this.indexMap.backStartAlertValueDel)
end

function this:_getCommonalertvaluedel(offset)
  return core:GetFloat(offset, this.indexMap.commonAlertValueDel)
end

function this:_getLeavebattletime(offset)
  return core:GetFloat(offset, this.indexMap.leaveBattleTime)
end

function this:_getTracefailureradius(offset)
  return core:GetFloat(offset, this.indexMap.traceFailureRadius)
end

function this:_getVisiondistance(offset)
  return core:GetFloat(offset, this.indexMap.visionDistance)
end

function this:_getWarningdistance(offset)
  return core:GetFloat(offset, this.indexMap.warningDistance)
end

function this:_getAlertstatetype(offset)
  return core:GetInt(offset, this.indexMap.alertStateType)
end

function this:_getCharacterstate(offset)
  return core:GetInt(offset, this.indexMap.characterState)
end

this.keyToMethodsMap = {
  id = this._getId,
  walkAnim = this._getWalkanim,
  runAnim = this._getRunanim,
  walkSpeed = this._getWalkspeed,
  runSpeed = this._getRunspeed,
  patrolRadius = this._getPatrolradius,
  patrolHeight = this._getPatrolheight,
  patrolInterval = this._getPatrolinterval,
  patrolMotionType = this._getPatrolmotiontype,
  patrolSpeedRatio = this._getPatrolspeedratio,
  IsAggressive = this._getIsaggressive,
  chaseRadius = this._getChaseradius,
  chaseHeight = this._getChaseheight,
  escapeRadius = this._getEscaperadius,
  escapeInnerRadius = this._getEscapeinnerradius,
  strongAlertRadius = this._getStrongalertradius,
  strongAlertHeight = this._getStrongalertheight,
  strongAlertAngle = this._getStrongalertangle,
  weakAlertRadius = this._getWeakalertradius,
  weakAlertHeight = this._getWeakalertheight,
  weakAlertAngle = this._getWeakalertangle,
  strongAlertValueEdge = this._getStrongalertvalueedge,
  weakAlertValueEdge = this._getWeakalertvalueedge,
  alertValueKeepTime = this._getAlertvaluekeeptime,
  alertValueCoolTime = this._getAlertvaluecooltime,
  weakAlertValueAdd = this._getWeakalertvalueadd,
  strongAlertValueAdd = this._getStrongalertvalueadd,
  backStartAlertValueDel = this._getBackstartalertvaluedel,
  commonAlertValueDel = this._getCommonalertvaluedel,
  leaveBattleTime = this._getLeavebattletime,
  traceFailureRadius = this._getTracefailureradius,
  visionDistance = this._getVisiondistance,
  warningDistance = this._getWarningdistance,
  alertStateType = this._getAlertstatetype,
  characterState = this._getCharacterstate
}
return this
