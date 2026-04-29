require("skill_effect_param_base")
_class("SkillEffectParamSetMonsterOffBoard", SkillEffectParamBase)
SkillEffectParamSetMonsterOffBoard = SkillEffectParamSetMonsterOffBoard

function SkillEffectParamSetMonsterOffBoard:Constructor(t)
  self._bSetOff = t.setOff and t.setOff == 1 or false
end

function SkillEffectParamSetMonsterOffBoard:GetEffectType()
  return SkillEffectType.SetMonsterOffBoard
end

function SkillEffectParamSetMonsterOffBoard:GetIsSetOff()
  return self._bSetOff
end
