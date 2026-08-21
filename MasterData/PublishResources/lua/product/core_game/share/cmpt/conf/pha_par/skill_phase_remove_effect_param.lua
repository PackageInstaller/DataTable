require("skill_phase_param_base")
_class("SkillPhaseRemoveEffectParam", SkillPhaseParamBase)
SkillPhaseRemoveEffectParam = SkillPhaseRemoveEffectParam

function SkillPhaseRemoveEffectParam:Constructor(t)
  self._effectIDList = t.effectIDList
end

function SkillPhaseRemoveEffectParam:GetPhaseType()
  return SkillViewPhaseType.RemoveEffect
end

function SkillPhaseRemoveEffectParam:GetCacheTable()
  return {}
end

function SkillPhaseRemoveEffectParam:GetEffectIDList()
  return self._effectIDList
end
