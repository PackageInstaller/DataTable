require("skill_damage_effect_param")
_class("SkillEffectParam_MarkGridInScope", SkillEffectParamBase)
SkillEffectParam_MarkGridInScope = SkillEffectParam_MarkGridInScope

function SkillEffectParam_MarkGridInScope:Constructor(t)
  self._isClear = t.clear
  self._max = t.max
  self._series = t.series or 1
end

function SkillEffectParam_MarkGridInScope:GetEffectType()
  return SkillEffectType.MarkGridInScope
end

function SkillEffectParam_MarkGridInScope:IsClear()
  return self._isClear
end

function SkillEffectParam_MarkGridInScope:GetMaxCount()
  return self._max
end
