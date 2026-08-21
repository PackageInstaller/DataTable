require("skill_phase_param_base")
_class("SkillPhaseOnHitParam", SkillPhaseParamBase)
SkillPhaseOnHitParam = SkillPhaseOnHitParam

function SkillPhaseOnHitParam:Constructor(t)
  self._castEffectID = t.castEffectID
  self._castAnimation = t.castAnimation
  self._hitPointDelay = t.hitPointDelay
  self._hitAnimation = t.onHitAnimation
  self._hitEffectID = t.hitEffectID
end

function SkillPhaseOnHitParam:GetPhaseType()
  return SkillViewPhaseType.OnHit
end

function SkillPhaseOnHitParam:GetSkillScopeRows()
  return self._rows
end

function SkillPhaseOnHitParam:GetSkillScopeColumns()
  return self._columns
end
