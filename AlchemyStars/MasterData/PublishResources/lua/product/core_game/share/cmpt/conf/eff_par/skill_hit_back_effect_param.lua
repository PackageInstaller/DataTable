require("skill_effect_param_base")
_class("SkillHitBackEffectParam", SkillEffectParamBase)
SkillHitBackEffectParam = SkillHitBackEffectParam
HitBackType = {PushAway = 1, PullBack = 2}
_enum("HitBackType", HitBackType)
HitBackCalcType = {
  Instant = 1,
  Delay = 2,
  PlayStage = 3
}
_enum("HitBackCalcType", HitBackCalcType)
HitBackDirectionBackupPlan = {AlwaysUp = 1}
_enum("HitBackDirectionBackupPlan", HitBackDirectionBackupPlan)
HitBackInteractnWithBoardType = {
  None = 0,
  OutBoardEdge = 1,
  Other = 2
}
_enum("HitBackInteractnWithBoardType", HitBackInteractnWithBoardType)

function SkillHitBackEffectParam:Constructor(t)
  self._enableByPickNum = t.enableByPickNum
  self._distance = t.distance
  self._type = t.type
  self._dirType = t.dir
  self._calcType = t.calcType or HitBackCalcType.Instant
  self._excludeCasterPos = t.excludeCasterPos
  self._ignorePlayerBlock = t.ignorePlayerBlock or false
  self._checkBuffEffect = t.checkBuffEffect
  self._forceUseCasterPos = t.forceUseCasterPos or false
  self._extraParam = t.extraParam
  self._notCalcBomb = t.notCalcBomb
  self._ignorePathBlock = t.ignorePathBlock or false
  self._backupDirectionPlan = t.backupDirectionPlan
  self._interactType = t.interactType or HitBackInteractnWithBoardType.None
  self._casterPosAsBlock = t.casterPosAsBlock or false
  self._usePickPosIndex = t.usePickPosIndex
end

function SkillHitBackEffectParam:GetEffectType()
  return SkillEffectType.HitBack
end

function SkillHitBackEffectParam:GetDistance()
  return self._distance
end

function SkillHitBackEffectParam:GetDirType()
  return self._dirType
end

function SkillHitBackEffectParam:ExcludeCasterPos()
  return self._excludeCasterPos
end

function SkillHitBackEffectParam:GetType()
  return self._type
end

function SkillHitBackEffectParam:GetCalcType()
  return self._calcType
end

function SkillHitBackEffectParam:GetIgnorePlayerBlock()
  return self._ignorePlayerBlock
end

function SkillHitBackEffectParam:GetCheckBuffEffect()
  return self._checkBuffEffect
end

function SkillHitBackEffectParam:GetExtraParam()
  return self._extraParam
end

function SkillHitBackEffectParam:GetForceUseCasterPos()
  return self._forceUseCasterPos
end

function SkillHitBackEffectParam:GetEnableByPickNum()
  return self._enableByPickNum
end

function SkillHitBackEffectParam:GetNotCalcBomb()
  return self._notCalcBomb
end

function SkillHitBackEffectParam:GetIgnorePathBlock()
  return self._ignorePathBlock
end

function SkillHitBackEffectParam:GetBackupDirectionPlan()
  return self._backupDirectionPlan
end

function SkillHitBackEffectParam:GetInteractType()
  return self._interactType
end

function SkillHitBackEffectParam:IsCasterPosAsBlock()
  return self._casterPosAsBlock
end

function SkillHitBackEffectParam:GetUsePickPosIndex()
  return self._usePickPosIndex
end
