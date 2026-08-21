_class("DataSkillRoutineResult", Object)
DataSkillRoutineResult = DataSkillRoutineResult

function DataSkillRoutineResult:Constructor(eid, res, key)
  self._entityId = eid
  self._result = res
  self._key = key
end

function DataSkillRoutineResult:GetResult()
  return self._result
end

function DataSkillRoutineResult:GetEntityID()
  return self._entityId
end

function DataSkillRoutineResult:GetKey()
  return self._key
end
