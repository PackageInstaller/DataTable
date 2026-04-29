require("skill_effect_param_base")
_class("SkillEffectParam_RandAttack", SkillEffectParamBase)
SkillEffectParam_RandAttack = SkillEffectParam_RandAttack

function SkillEffectParam_RandAttack:Constructor(t)
  self.m_nMinTimes = t.minTimes
  self.m_nMaxTimes = t.maxTimes
  self.m_nAddTimes = t.addTimes
  self.m_nPercent = t.percent
  self.m_nFormulaID = t.formulaID
end

function SkillEffectParam_RandAttack:GetEffectType()
  return SkillEffectType.RandAttack
end

function SkillEffectParam_RandAttack:GetMinTimes()
  return self.m_nMinTimes
end

function SkillEffectParam_RandAttack:GetMaxTimes()
  return self.m_nMaxTimes
end

function SkillEffectParam_RandAttack:GetAddTimes()
  return self.m_nAddTimes
end

function SkillEffectParam_RandAttack:GetPercent()
  return self.m_nPercent
end

function SkillEffectParam_RandAttack:GetFormulaID()
  return self.m_nFormulaID
end
