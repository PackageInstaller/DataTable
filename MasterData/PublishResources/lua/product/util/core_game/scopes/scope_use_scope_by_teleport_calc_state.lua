require("scope_base")
_class("SkillScopeCalculator_UseScopeByTeleportCalcState", SkillScopeCalculator_Base)
SkillScopeCalculator_UseScopeByTeleportCalcState = SkillScopeCalculator_UseScopeByTeleportCalcState

function SkillScopeCalculator_UseScopeByTeleportCalcState:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local resultContainer = casterEntity:SkillContext():GetResultContainer()
  local teleportResult = resultContainer:GetEffectResultByArray(SkillEffectType.Teleport)
  if not teleportResult then
    Log.warn(self._className, "施法者没有执行过瞬移")
    return SkillScopeResult:New(SkillScopeType.UseScopeByTeleportCalcState, casterEntity, {}, {})
  end
  if not teleportResult:GetPosNew() then
    Log.warn(self._className, "瞬移无效-无落点")
    return SkillScopeResult:New(SkillScopeType.UseScopeByTeleportCalcState, casterEntity, {}, {})
  end
  local posCalcState = teleportResult:GetTeleportPosCalcState()
  if not posCalcState then
    Log.warn(self._className, "瞬移结果 没有计算阶段")
    return SkillScopeResult:New(SkillScopeType.UseScopeByTeleportCalcState, casterEntity, {}, {})
  end
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  local attackRange = {}
  local wholeArea = {}
  local posNew = teleportResult:GetPosNew()
  local posOld = teleportResult:GetPosOld()
  local centerPos = {posOld, posNew}
  if posCalcState == 1 then
    local curScopeParam = scopeParam[posCalcState]
    if curScopeParam then
      local scope = curScopeParam
      local subScopeType = scope.scopeType
      if subScopeType then
        local subScopeParam = scope.scopeParam
        local subScopeCenterPosIndex = scope.centerPosIndex
        local transCenterPos = centerPos
        if subScopeCenterPosIndex then
          if subScopeCenterPosIndex == 0 then
            transCenterPos = centerPos
          else
            transCenterPos = centerPos[subScopeCenterPosIndex]
          end
        end
        local result = calc:ComputeScopeRange(subScopeType, subScopeParam, transCenterPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
        attackRange = result:GetAttackRange()
        wholeArea = result:GetWholeGridRange()
      end
    end
  else
    local curScopeParam = scopeParam.default
    if curScopeParam then
      local scope = curScopeParam
      local subScopeType = scope.scopeType
      if subScopeType then
        local subScopeParam = scope.scopeParam
        local subScopeCenterPosIndex = scope.centerPosIndex
        local transCenterPos = centerPos
        if subScopeCenterPosIndex then
          if subScopeCenterPosIndex == 0 then
            transCenterPos = centerPos
          else
            transCenterPos = centerPos[subScopeCenterPosIndex]
          end
        end
        local result = calc:ComputeScopeRange(subScopeType, subScopeParam, transCenterPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
        attackRange = result:GetAttackRange()
        wholeArea = result:GetWholeGridRange()
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.UseScopeByTeleportCalcState, casterPos, attackRange, wholeArea)
  return result
end
