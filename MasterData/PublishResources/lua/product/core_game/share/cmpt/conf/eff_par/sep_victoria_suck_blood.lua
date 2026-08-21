_class("SkillEffectParam_VictoriaSuckBlood", SkillEffectParamBase)
SkillEffectParam_VictoriaSuckBlood = SkillEffectParam_VictoriaSuckBlood

function SkillEffectParam_VictoriaSuckBlood:Constructor(t)
  self.percent = t.percent
  self.formulaID = t.formulaID
  self.formulaID2 = t.formulaID2
end

function SkillEffectParam_VictoriaSuckBlood:GetEffectType()
  return SkillEffectType.VictoriaSuckBlood
end

function SkillEffectParam_VictoriaSuckBlood:GetDamagePercent()
  return self.percent
end

function SkillEffectParam_VictoriaSuckBlood:GetDamageFormulaID()
  return self.formulaID
end

function SkillEffectParam_VictoriaSuckBlood:GetDamageFormulaID2()
  return self.formulaID2
end
