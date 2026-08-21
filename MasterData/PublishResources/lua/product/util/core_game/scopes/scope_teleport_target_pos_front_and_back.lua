require("scope_base")
_class("SkillScopeCalculator_TeleportTargetPosFrontAndBack", SkillScopeCalculator_Base)
SkillScopeCalculator_TeleportTargetPosFrontAndBack = SkillScopeCalculator_TeleportTargetPosFrontAndBack

function SkillScopeCalculator_TeleportTargetPosFrontAndBack:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local resultContainer = casterEntity:SkillContext():GetResultContainer()
  local teleportResult = resultContainer:GetEffectResultByArray(SkillEffectType.Teleport)
  if not teleportResult then
    Log.warn(self._className, "施法者没有执行过瞬移")
    return SkillScopeResult:New(SkillScopeType.TeleportTargetPosFrontAndBack, casterEntity, {}, {})
  end
  if not teleportResult:GetPosNew() or teleportResult:GetPosNew() == teleportResult:GetPosOld() then
    Log.warn(self._className, "瞬移无效-无落点或新旧位置相同")
    return SkillScopeResult:New(SkillScopeType.TeleportTargetPosFrontAndBack, casterEntity, {}, {})
  end
  local posNew = teleportResult:GetPosNew()
  local posOld = teleportResult:GetPosOld()
  local dir = self:_GetSimplifiedV2Direction(posNew - posOld)
  local attackRange = {}
  local wholeArea = {}
  local posForward = centerPos + dir
  self:_InsertTargetGrid(attackRange, posForward, wholeArea)
  local posBackward = centerPos - dir
  self:_InsertTargetGrid(attackRange, posBackward, wholeArea)
  local result = SkillScopeResult:New(SkillScopeType.TeleportTargetPosFrontAndBack, casterPos, attackRange, wholeArea)
  return result
end

function SkillScopeCalculator_TeleportTargetPosFrontAndBack:_GetSimplifiedV2Direction(v2)
  local v = v2:Clone()
  if v.x > 0 then
    v.x = 1
  elseif v.x < 0 then
    v.x = -1
  end
  if 0 < v.y then
    v.y = 1
  elseif 0 > v.y then
    v.y = -1
  end
  return v
end
