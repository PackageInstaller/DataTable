_class("SkillMakePhantomParam", SkillEffectParamBase)
SkillMakePhantomParam = SkillMakePhantomParam

function SkillMakePhantomParam:Constructor(t)
  self._atkPercent = t.atk
  self._targetID = t.targetID
  self._hpPercent = t.hp or 1
end

function SkillMakePhantomParam:GetEffectType()
  return SkillEffectType.MakePhantom
end

function SkillMakePhantomParam:GetHPPercent()
  return self._hpPercent
end

function SkillMakePhantomParam:GetTargetID()
  return self._targetID
end
