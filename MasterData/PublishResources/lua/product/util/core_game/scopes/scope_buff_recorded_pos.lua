require("scope_base")
_class("SkillScopeCalculator_BuffValueRecordedPos", SkillScopeCalculator_Base)
SkillScopeCalculator_BuffValueRecordedPos = SkillScopeCalculator_BuffValueRecordedPos

function SkillScopeCalculator_BuffValueRecordedPos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local scopeList = {}
  if casterEntity then
    local recordBuffCmpt
    if casterEntity:HasSuperEntity() then
      local superEntity = casterEntity:GetSuperEntity()
      if superEntity then
        recordBuffCmpt = superEntity:BuffComponent()
      end
    end
    recordBuffCmpt = recordBuffCmpt or casterEntity:BuffComponent()
    local key = scopeParam.buffKey or "buff_recorded_pos"
    if recordBuffCmpt then
      local keyX = key .. "_x"
      local keyY = key .. "_y"
      local posX = tonumber(recordBuffCmpt:GetBuffValue(keyX))
      local posY = tonumber(recordBuffCmpt:GetBuffValue(keyY))
      if posX and posY then
        local pos = Vector2(posX, posY)
        scopeList = {pos}
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.BuffValueRecordedPos, centerPos, scopeList, scopeList)
  return result
end
