require("skill_damage_effect_param")
_class("SkillEffectParamMonsterMoveFrontAttack", SkillEffectParamBase)
SkillEffectParamMonsterMoveFrontAttack = SkillEffectParamMonsterMoveFrontAttack

function SkillEffectParamMonsterMoveFrontAttack:Constructor(t)
  self._skillID = t.skillID
  self._moveStep = t.moveStep
  if t.AIMove ~= nil then
    self._isAIMove = t.AIMove
  else
    self._isAIMove = true
  end
end

function SkillEffectParamMonsterMoveFrontAttack:GetEffectType()
  return SkillEffectType.MonsterMoveFrontAttack
end

function SkillEffectParamMonsterMoveFrontAttack:GetCheckSkillID()
  return self._skillID
end

function SkillEffectParamMonsterMoveFrontAttack:GetMoveStep()
  return self._moveStep
end

function SkillEffectParamMonsterMoveFrontAttack:IsAIMove()
  return self._isAIMove
end
