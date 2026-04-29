require("skill_effect_param_base")
_class("SkillEffectParamControlMonsterTeleportAndAttack", SkillEffectParamBase)
SkillEffectParamControlMonsterTeleportAndAttack = SkillEffectParamControlMonsterTeleportAndAttack

function SkillEffectParamControlMonsterTeleportAndAttack:Constructor(t)
  self._percent = t.percent
  self._formulaID = t.formulaID
  self._moveDis = t.moveDis
  self._monsterClassID = t.monsterClassID
  self._attackScopeType = t.attackScopeType
  self._attackScopeParam = t.attackScopeParam
end

function SkillEffectParamControlMonsterTeleportAndAttack:GetEffectType()
  return SkillEffectType.ControlMonsterTeleportAndAttack
end

function SkillEffectParamControlMonsterTeleportAndAttack:GetDamageFormulaID()
  return self._formulaID
end

function SkillEffectParamControlMonsterTeleportAndAttack:GetDamagePercent()
  return self._percent
end

function SkillEffectParamControlMonsterTeleportAndAttack:GetMoveDis()
  return self._moveDis
end

function SkillEffectParamControlMonsterTeleportAndAttack:GetMonsterClassID()
  return self._monsterClassID
end

function SkillEffectParamControlMonsterTeleportAndAttack:GetAttackScopeType()
  return self._attackScopeType
end

function SkillEffectParamControlMonsterTeleportAndAttack:GetAttackScopeParam()
  return self._attackScopeParam
end
