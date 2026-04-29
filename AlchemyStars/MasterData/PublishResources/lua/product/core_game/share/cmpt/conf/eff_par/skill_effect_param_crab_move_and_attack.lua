require("skill_effect_param_base")
_class("SkillEffectParamCrabMoveAndAttack", SkillEffectParamBase)
SkillEffectParamCrabMoveAndAttack = SkillEffectParamCrabMoveAndAttack

function SkillEffectParamCrabMoveAndAttack:Constructor(t)
  self._percent = t.percent
  self._formulaID = t.formulaID
  self._attackDis = t.attackDis
  self._moveDir = t.moveDir
  self._moveDis = t.moveDis
end

function SkillEffectParamCrabMoveAndAttack:GetEffectType()
  return SkillEffectType.CrabMoveAndAttack
end

function SkillEffectParamCrabMoveAndAttack:GetDamageFormulaID()
  return self._formulaID
end

function SkillEffectParamCrabMoveAndAttack:GetDamagePercent()
  return self._percent
end

function SkillEffectParamCrabMoveAndAttack:GetAttackDis()
  return self._attackDis
end

function SkillEffectParamCrabMoveAndAttack:GetMoveDir()
  return self._moveDir
end

function SkillEffectParamCrabMoveAndAttack:GetMoveDis()
  return self._moveDis
end
