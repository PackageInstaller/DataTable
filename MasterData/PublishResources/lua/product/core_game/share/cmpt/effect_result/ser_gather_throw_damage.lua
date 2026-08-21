require("skill_effect_result_base")
_class("SkillEffectGatherThrowDamageResult", SkillEffectResultBase)
SkillEffectGatherThrowDamageResult = SkillEffectGatherThrowDamageResult

function SkillEffectGatherThrowDamageResult:Constructor(targetID, monterIDS, teleportResultArray, damageResultArray, teleportKillMonster)
  self._targetID = targetID
  self._monsterIDS = monterIDS
  self._teleportResultArray = teleportResultArray
  self._damageResultArray = damageResultArray
  self._teleportKillMonster = teleportKillMonster
end

function SkillEffectGatherThrowDamageResult:GetTargetID()
  return self._targetID
end

function SkillEffectGatherThrowDamageResult:GetMonsterIDArray()
  return self._monsterIDS
end

function SkillEffectGatherThrowDamageResult:GetTeleportResultArray()
  return self._teleportResultArray
end

function SkillEffectGatherThrowDamageResult:GetDamageResultArray()
  return self._damageResultArray
end

function SkillEffectGatherThrowDamageResult:GetTeleportKillMonster()
  return self._teleportKillMonster
end

function SkillEffectGatherThrowDamageResult:GetEffectType()
  return SkillEffectType.GatherThrowDamage
end
