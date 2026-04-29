_class("L2RFeatureAttackResult", Object)
L2RFeatureAttackResult = L2RFeatureAttackResult

function L2RFeatureAttackResult:Constructor(eid, res)
  self._entityID = eid
  self._skillResult = res
  self._skillID = nil
end

function L2RFeatureAttackResult:GetEntityID()
  return self._entityID
end

function L2RFeatureAttackResult:GetSkillResult()
  return self._skillResult
end

function L2RFeatureAttackResult:SetL2RFeatureAttackResult_SkillID(skillID)
  self._skillID = skillID
end

function L2RFeatureAttackResult:GetL2RFeatureAttackResult_SkillID()
  return self._skillID
end
