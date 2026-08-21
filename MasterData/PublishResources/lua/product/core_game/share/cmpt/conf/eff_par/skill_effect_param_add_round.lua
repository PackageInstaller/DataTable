_class("SkillEffectParamAddRound", SkillEffectParamBase)
SkillEffectParamAddRound = SkillEffectParamAddRound

function SkillEffectParamAddRound:Constructor(t)
  self._addRoundCount = t.addRoundCount
end

function SkillEffectParamAddRound:GetEffectType()
  return SkillEffectType.AddRoundCount
end

function SkillEffectParamAddRound:GetAddRoundCount()
  return self._addRoundCount
end
