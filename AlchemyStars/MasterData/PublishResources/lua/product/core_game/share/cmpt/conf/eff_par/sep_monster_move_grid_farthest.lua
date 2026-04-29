require("skill_damage_effect_param")
_class("SkillEffectParam_MonsterMoveGridFarthest", SkillEffectParamBase)
SkillEffectParam_MonsterMoveGridFarthest = SkillEffectParam_MonsterMoveGridFarthest

function SkillEffectParam_MonsterMoveGridFarthest:Constructor(t)
  self._preferElement = t.preferElement
end

function SkillEffectParam_MonsterMoveGridFarthest:GetEffectType()
  return SkillEffectType.MonsterMoveGridFarthest
end

function SkillEffectParam_MonsterMoveGridFarthest:GetPreferElement()
  return self._preferElement
end
