_class("L2RActiveAttackResult", Object)
L2RActiveAttackResult = L2RActiveAttackResult

function L2RActiveAttackResult:Constructor(eid, res)
  self._entityID = eid
  self._skillResult = res
  self._skillID = nil
end

function L2RActiveAttackResult:GetEntityID()
  return self._entityID
end

function L2RActiveAttackResult:GetSkillResult()
  return self._skillResult
end

function L2RActiveAttackResult:SetL2RActiveAttackResult_SkillID(skillID)
  self._skillID = skillID
end

function L2RActiveAttackResult:GetL2RActiveAttackResult_SkillID()
  return self._skillID
end
