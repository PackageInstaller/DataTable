require("skill_effect_result_base")
_class("SkillEffectAlphaThrowTrapResult", SkillEffectResultBase)
SkillEffectAlphaThrowTrapResult = SkillEffectAlphaThrowTrapResult

function SkillEffectAlphaThrowTrapResult:Constructor(trapEntityIDs, trapMountID, monsterMountID, damageRes)
  self._trapEntityIDs = trapEntityIDs
  self._trapMountID = trapMountID
  self._monsterMountID = monsterMountID
  self._damageResult = damageRes
end

function SkillEffectAlphaThrowTrapResult:GetEffectType()
  return SkillEffectType.AlphaThrowTrap
end

function SkillEffectAlphaThrowTrapResult:GetTrapEntityIDs()
  return self._trapEntityIDs
end

function SkillEffectAlphaThrowTrapResult:GetTrapMountID()
  return self._trapMountID
end

function SkillEffectAlphaThrowTrapResult:GetMonsterMountID()
  return self._monsterMountID
end

function SkillEffectAlphaThrowTrapResult:GetDamageResult()
  return self._damageResult
end
