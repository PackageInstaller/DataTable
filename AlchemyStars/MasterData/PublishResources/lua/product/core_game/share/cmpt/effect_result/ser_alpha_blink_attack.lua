require("skill_effect_result_base")
_class("SkillEffectAlphaBlinkAttackResult", SkillEffectResultBase)
SkillEffectAlphaBlinkAttackResult = SkillEffectAlphaBlinkAttackResult

function SkillEffectAlphaBlinkAttackResult:Constructor(oldPos, attackPos, attackDir, teleportPos, height, trapID, summonPosList)
  self._attackPos = attackPos
  self._attackDir = attackDir
  self._teleportPos = teleportPos
  self._height = height
  self._trapID = trapID
  self._summonPosList = summonPosList
  self._oldPos = oldPos
end

function SkillEffectAlphaBlinkAttackResult:GetEffectType()
  return SkillEffectType.AlphaBlinkAttack
end

function SkillEffectAlphaBlinkAttackResult:GetAttackPos()
  return self._attackPos
end

function SkillEffectAlphaBlinkAttackResult:GetAttackDir()
  return self._attackDir
end

function SkillEffectAlphaBlinkAttackResult:GetOldPos()
  return self._oldPos
end

function SkillEffectAlphaBlinkAttackResult:GetTeleportPos()
  return self._teleportPos
end

function SkillEffectAlphaBlinkAttackResult:GetHeight()
  return self._height
end

function SkillEffectAlphaBlinkAttackResult:GetTrapID()
  return self._trapID
end

function SkillEffectAlphaBlinkAttackResult:GetSummonPosList()
  return self._summonPosList
end

function SkillEffectAlphaBlinkAttackResult:SetTrapIDList(trapIDList)
  self._trapIDList = trapIDList
end

function SkillEffectAlphaBlinkAttackResult:GetTrapIDList()
  return self._trapIDList
end
