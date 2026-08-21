require("skill_effect_result_base")
_class("SkillEffectResult_Switch2GridTrap", SkillEffectResultBase)
SkillEffectResult_Switch2GridTrap = SkillEffectResult_Switch2GridTrap

function SkillEffectResult_Switch2GridTrap:Constructor(data, scopeRange)
  self._data = data
  self._scopeRange = scopeRange
end

function SkillEffectResult_Switch2GridTrap:GetData()
  return self._data
end

function SkillEffectResult_Switch2GridTrap:GetScopeRange()
  return self._scopeRange
end

function SkillEffectResult_Switch2GridTrap:GetEffectType()
  return SkillEffectType.Switch2GridTrap
end
