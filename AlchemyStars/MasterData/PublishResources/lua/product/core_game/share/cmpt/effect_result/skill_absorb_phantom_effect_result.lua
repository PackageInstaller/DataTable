require("skill_effect_result_base")
_class("SkillAbsorbPhantomEffectResult", SkillEffectResultBase)
SkillAbsorbPhantomEffectResult = SkillAbsorbPhantomEffectResult

function SkillAbsorbPhantomEffectResult:Constructor(target, hp)
  self._targetEntityID = target
  self._recoverHP = hp
end

function SkillAbsorbPhantomEffectResult:GetEffectType()
  return SkillEffectType.AbsorbPhantom
end

function SkillAbsorbPhantomEffectResult:GetTargetEntityID()
  return self._targetEntityID
end

function SkillAbsorbPhantomEffectResult:GetRecoverHP()
  return self._recoverHP
end

function SkillAbsorbPhantomEffectResult:SetRecoverHP(hp)
  self._recoverHP = hp
end

function SkillAbsorbPhantomEffectResult:SetDamageInfo(damageInfo)
  self._damageInfo = damageInfo
end

function SkillAbsorbPhantomEffectResult:GetDamageInfo()
  return self._damageInfo
end
