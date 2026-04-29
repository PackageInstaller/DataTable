_class("SkillEffectTeleportAndSummonTrapResult", SkillEffectResultBase)
SkillEffectTeleportAndSummonTrapResult = SkillEffectTeleportAndSummonTrapResult

function SkillEffectTeleportAndSummonTrapResult:Constructor(trapPosList, teleportPos)
  self._trapPosList = trapPosList
  self._teleportPos = teleportPos
  self._trapEntityIDList = {}
end

function SkillEffectTeleportAndSummonTrapResult:GetTrapPosList()
  return self._trapPosList
end

function SkillEffectTeleportAndSummonTrapResult:GetTeleportPos()
  return self._teleportPos
end

function SkillEffectTeleportAndSummonTrapResult:GetEffectType()
  return SkillEffectType.TeleportAndSummonTrap
end

function SkillEffectTeleportAndSummonTrapResult:GetTrapEntityIDList()
  return self._trapEntityIDList
end

function SkillEffectTeleportAndSummonTrapResult:AddTrapEntityID(entity)
  table.insert(self._trapEntityIDList, entity)
end
