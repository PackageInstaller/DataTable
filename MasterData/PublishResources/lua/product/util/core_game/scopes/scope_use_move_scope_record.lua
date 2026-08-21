require("scope_base")
_class("SkillScopeCalculator_UseMoveScopeRecord", SkillScopeCalculator_Base)
SkillScopeCalculator_UseMoveScopeRecord = SkillScopeCalculator_UseMoveScopeRecord

function SkillScopeCalculator_UseMoveScopeRecord:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local attackRange = {}
  local wholeRange = {}
  local hostEntity = casterEntity
  if casterEntity and casterEntity:HasSuperEntity() then
    hostEntity = casterEntity:SuperEntityComponent():GetSuperEntity()
  end
  if hostEntity then
    local moveScopeRecordCmpt = hostEntity:MoveScopeRecord()
    if moveScopeRecordCmpt then
      attackRange = moveScopeRecordCmpt:GetMoveScope()
      wholeRange = moveScopeRecordCmpt:GetMoveScope()
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.UseMoveScopeRecord, casterPos, attackRange, wholeRange)
  return result
end
