require("skill_damage_effect_param")
_class("SkillEffectMonsterMoveGridParam", SkillEffectParamBase)
SkillEffectMonsterMoveGridParam = SkillEffectMonsterMoveGridParam

function SkillEffectMonsterMoveGridParam:Constructor(t)
  self._enableAnyPiece = t.enableAnyPiece or 0
end

function SkillEffectMonsterMoveGridParam:IsEnableAnyPiece()
  return self._enableAnyPiece == 1
end

function SkillEffectMonsterMoveGridParam:GetEffectType()
  return SkillEffectType.MonsterMoveGrid
end
