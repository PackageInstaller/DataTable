local this = class("skillsub_logic_shell", G_BaseConfig)
local core = G_Tables.TDSkillsubLogicTable.GetInstance()

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
  skillId = 0,
  skillLogicType = 1,
  skillTag = 2,
  petSkillLogicTag = 3,
  skillValidityCondition = 4,
  cleanupElementsOnSkillEnd = 5,
  kiBoAttackSp = 6,
  kiBoInitialSp = 7,
  kiBoSpMax = 8,
  kiBoCoolDownDefault = 9,
  kiBoVersusCoolDown = 10,
  coolDown = 11,
  mountCoolDown = 12,
  rndCoolDownMax = 13,
  coolDownHint = 14,
  coolDownCount = 15,
  coolDownDefault = 16,
  rndCoolDownDefaultMax = 17,
  coolDownCountDefault = 18,
  spCost = 19,
  startSkillListShape = 20,
  startSkillListParameter = 21,
  startSkillListOffset = 22,
  targetType = 23,
  battleLockPriority = 24,
  worldLockPriority = 25,
  lockCondition = 26,
  lockRange = 27,
  lockRangeAngle = 28,
  lockAlertRange = 29,
  lockAngle = 30,
  lockTargetSortType = 31,
  worldLockRange = 32,
  worldLockRangeAngle = 33,
  worldLockAngle = 34,
  allowSprint = 35,
  sprintMin = 36,
  sprintMax = 37,
  directionType = 38,
  indicator = 39,
  indicatorValue = 40,
  conditionType = 41,
  conditionValue = 42,
  inputTriggerType = 43,
  holdTriggerTime = 44,
  priority = 45,
  castPriority = 46,
  castPriorityWeight = 47,
  attackCheckMinDirection = 48,
  attackCheckMaxDirection = 49,
  attackCheckAngleL = 50,
  attackCheckAngleR = 51,
  useDirection = 52,
  selfCDGroup = 53,
  selfCD = 54,
  publicCDGroup = 55,
  publicCD = 56,
  GCD = 57,
  aiToken = 58,
  aiTokenResetCD = 59,
  aiTokenType = 60,
  petWorkPos = 61,
  emotionIndex = 62,
  streamLoadPriority = 63,
  kiboNestCoopScale = 64,
  NestCoopIgnoreEntity = 65,
  lockAlertRangeY = 66
}

function this:_getSkillid(offset)
  return core:GetInt(offset, this.indexMap.skillId)
end

function this:_getSkilllogictype(offset)
  return core:GetInt(offset, this.indexMap.skillLogicType)
end

function this:_getSkilltag(offset)
  local str = core:GetVString(offset, this.indexMap.skillTag).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetskilllogictag(offset)
  local str = core:GetVString(offset, this.indexMap.petSkillLogicTag).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSkillvaliditycondition(offset)
  local str = core:GetVString(offset, this.indexMap.skillValidityCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCleanupelementsonskillend(offset)
  local str = core:GetVString(offset, this.indexMap.cleanupElementsOnSkillEnd).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getKiboattacksp(offset)
  return core:GetFloat(offset, this.indexMap.kiBoAttackSp)
end

function this:_getKiboinitialsp(offset)
  return core:GetInt(offset, this.indexMap.kiBoInitialSp)
end

function this:_getKibospmax(offset)
  return core:GetInt(offset, this.indexMap.kiBoSpMax)
end

function this:_getKibocooldowndefault(offset)
  return core:GetInt(offset, this.indexMap.kiBoCoolDownDefault)
end

function this:_getKiboversuscooldown(offset)
  return core:GetInt(offset, this.indexMap.kiBoVersusCoolDown)
end

function this:_getCooldown(offset)
  return core:GetInt(offset, this.indexMap.coolDown)
end

function this:_getMountcooldown(offset)
  return core:GetInt(offset, this.indexMap.mountCoolDown)
end

function this:_getRndcooldownmax(offset)
  return core:GetInt(offset, this.indexMap.rndCoolDownMax)
end

function this:_getCooldownhint(offset)
  return core:GetInt(offset, this.indexMap.coolDownHint)
end

function this:_getCooldowncount(offset)
  return core:GetInt(offset, this.indexMap.coolDownCount)
end

function this:_getCooldowndefault(offset)
  return core:GetInt(offset, this.indexMap.coolDownDefault)
end

function this:_getRndcooldowndefaultmax(offset)
  return core:GetInt(offset, this.indexMap.rndCoolDownDefaultMax)
end

function this:_getCooldowncountdefault(offset)
  return core:GetInt(offset, this.indexMap.coolDownCountDefault)
end

function this:_getSpcost(offset)
  return core:GetInt(offset, this.indexMap.spCost)
end

function this:_getStartskilllistshape(offset)
  return core:GetInt(offset, this.indexMap.startSkillListShape)
end

function this:_getStartskilllistparameter(offset)
  local str = core:GetVString(offset, this.indexMap.startSkillListParameter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getStartskilllistoffset(offset)
  local str = core:GetVString(offset, this.indexMap.startSkillListOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTargettype(offset)
  return core:GetInt(offset, this.indexMap.targetType)
end

function this:_getBattlelockpriority(offset)
  local str = core:GetVString(offset, this.indexMap.battleLockPriority).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWorldlockpriority(offset)
  local str = core:GetVString(offset, this.indexMap.worldLockPriority).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getLockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.lockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getLockrange(offset)
  return core:GetFloat(offset, this.indexMap.lockRange)
end

function this:_getLockrangeangle(offset)
  return core:GetFloat(offset, this.indexMap.lockRangeAngle)
end

function this:_getLockalertrange(offset)
  return core:GetFloat(offset, this.indexMap.lockAlertRange)
end

function this:_getLockangle(offset)
  return core:GetFloat(offset, this.indexMap.lockAngle)
end

function this:_getLocktargetsorttype(offset)
  local str = core:GetVString(offset, this.indexMap.lockTargetSortType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWorldlockrange(offset)
  return core:GetFloat(offset, this.indexMap.worldLockRange)
end

function this:_getWorldlockrangeangle(offset)
  return core:GetFloat(offset, this.indexMap.worldLockRangeAngle)
end

function this:_getWorldlockangle(offset)
  return core:GetFloat(offset, this.indexMap.worldLockAngle)
end

function this:_getAllowsprint(offset)
  return core:GetInt(offset, this.indexMap.allowSprint)
end

function this:_getSprintmin(offset)
  return core:GetFloat(offset, this.indexMap.sprintMin)
end

function this:_getSprintmax(offset)
  return core:GetFloat(offset, this.indexMap.sprintMax)
end

function this:_getDirectiontype(offset)
  return core:GetInt(offset, this.indexMap.directionType)
end

function this:_getIndicator(offset)
  return core:GetInt(offset, this.indexMap.indicator)
end

function this:_getIndicatorvalue(offset)
  local str = core:GetVString(offset, this.indexMap.indicatorValue).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getConditiontype(offset)
  return core:GetInt(offset, this.indexMap.conditionType)
end

function this:_getConditionvalue(offset)
  local str = core:GetVString(offset, this.indexMap.conditionValue).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getInputtriggertype(offset)
  return core:GetInt(offset, this.indexMap.inputTriggerType)
end

function this:_getHoldtriggertime(offset)
  return core:GetInt(offset, this.indexMap.holdTriggerTime)
end

function this:_getPriority(offset)
  return core:GetInt(offset, this.indexMap.priority)
end

function this:_getCastpriority(offset)
  return core:GetInt(offset, this.indexMap.castPriority)
end

function this:_getCastpriorityweight(offset)
  return core:GetInt(offset, this.indexMap.castPriorityWeight)
end

function this:_getAttackcheckmindirection(offset)
  return core:GetFloat(offset, this.indexMap.attackCheckMinDirection)
end

function this:_getAttackcheckmaxdirection(offset)
  return core:GetFloat(offset, this.indexMap.attackCheckMaxDirection)
end

function this:_getAttackcheckanglel(offset)
  return core:GetFloat(offset, this.indexMap.attackCheckAngleL)
end

function this:_getAttackcheckangler(offset)
  return core:GetFloat(offset, this.indexMap.attackCheckAngleR)
end

function this:_getUsedirection(offset)
  return core:GetFloat(offset, this.indexMap.useDirection)
end

function this:_getSelfcdgroup(offset)
  return core:GetInt(offset, this.indexMap.selfCDGroup)
end

function this:_getSelfcd(offset)
  return core:GetInt(offset, this.indexMap.selfCD)
end

function this:_getPubliccdgroup(offset)
  return core:GetInt(offset, this.indexMap.publicCDGroup)
end

function this:_getPubliccd(offset)
  return core:GetInt(offset, this.indexMap.publicCD)
end

function this:_getGcd(offset)
  return core:GetInt(offset, this.indexMap.GCD)
end

function this:_getAitoken(offset)
  return core:GetInt(offset, this.indexMap.aiToken)
end

function this:_getAitokenresetcd(offset)
  return core:GetInt(offset, this.indexMap.aiTokenResetCD)
end

function this:_getAitokentype(offset)
  return core:GetInt(offset, this.indexMap.aiTokenType)
end

function this:_getPetworkpos(offset)
  local str = core:GetVString(offset, this.indexMap.petWorkPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getEmotionindex(offset)
  return core:GetInt(offset, this.indexMap.emotionIndex)
end

function this:_getStreamloadpriority(offset)
  return core:GetInt(offset, this.indexMap.streamLoadPriority)
end

function this:_getKibonestcoopscale(offset)
  return core:GetFloat(offset, this.indexMap.kiboNestCoopScale)
end

function this:_getNestcoopignoreentity(offset)
  local str = core:GetVString(offset, this.indexMap.NestCoopIgnoreEntity).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getLockalertrangey(offset)
  local str = core:GetVString(offset, this.indexMap.lockAlertRangeY).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  skillId = this._getSkillid,
  skillLogicType = this._getSkilllogictype,
  skillTag = this._getSkilltag,
  petSkillLogicTag = this._getPetskilllogictag,
  skillValidityCondition = this._getSkillvaliditycondition,
  cleanupElementsOnSkillEnd = this._getCleanupelementsonskillend,
  kiBoAttackSp = this._getKiboattacksp,
  kiBoInitialSp = this._getKiboinitialsp,
  kiBoSpMax = this._getKibospmax,
  kiBoCoolDownDefault = this._getKibocooldowndefault,
  kiBoVersusCoolDown = this._getKiboversuscooldown,
  coolDown = this._getCooldown,
  mountCoolDown = this._getMountcooldown,
  rndCoolDownMax = this._getRndcooldownmax,
  coolDownHint = this._getCooldownhint,
  coolDownCount = this._getCooldowncount,
  coolDownDefault = this._getCooldowndefault,
  rndCoolDownDefaultMax = this._getRndcooldowndefaultmax,
  coolDownCountDefault = this._getCooldowncountdefault,
  spCost = this._getSpcost,
  startSkillListShape = this._getStartskilllistshape,
  startSkillListParameter = this._getStartskilllistparameter,
  startSkillListOffset = this._getStartskilllistoffset,
  targetType = this._getTargettype,
  battleLockPriority = this._getBattlelockpriority,
  worldLockPriority = this._getWorldlockpriority,
  lockCondition = this._getLockcondition,
  lockRange = this._getLockrange,
  lockRangeAngle = this._getLockrangeangle,
  lockAlertRange = this._getLockalertrange,
  lockAngle = this._getLockangle,
  lockTargetSortType = this._getLocktargetsorttype,
  worldLockRange = this._getWorldlockrange,
  worldLockRangeAngle = this._getWorldlockrangeangle,
  worldLockAngle = this._getWorldlockangle,
  allowSprint = this._getAllowsprint,
  sprintMin = this._getSprintmin,
  sprintMax = this._getSprintmax,
  directionType = this._getDirectiontype,
  indicator = this._getIndicator,
  indicatorValue = this._getIndicatorvalue,
  conditionType = this._getConditiontype,
  conditionValue = this._getConditionvalue,
  inputTriggerType = this._getInputtriggertype,
  holdTriggerTime = this._getHoldtriggertime,
  priority = this._getPriority,
  castPriority = this._getCastpriority,
  castPriorityWeight = this._getCastpriorityweight,
  attackCheckMinDirection = this._getAttackcheckmindirection,
  attackCheckMaxDirection = this._getAttackcheckmaxdirection,
  attackCheckAngleL = this._getAttackcheckanglel,
  attackCheckAngleR = this._getAttackcheckangler,
  useDirection = this._getUsedirection,
  selfCDGroup = this._getSelfcdgroup,
  selfCD = this._getSelfcd,
  publicCDGroup = this._getPubliccdgroup,
  publicCD = this._getPubliccd,
  GCD = this._getGcd,
  aiToken = this._getAitoken,
  aiTokenResetCD = this._getAitokenresetcd,
  aiTokenType = this._getAitokentype,
  petWorkPos = this._getPetworkpos,
  emotionIndex = this._getEmotionindex,
  streamLoadPriority = this._getStreamloadpriority,
  kiboNestCoopScale = this._getKibonestcoopscale,
  NestCoopIgnoreEntity = this._getNestcoopignoreentity,
  lockAlertRangeY = this._getLockalertrangey
}
return this
