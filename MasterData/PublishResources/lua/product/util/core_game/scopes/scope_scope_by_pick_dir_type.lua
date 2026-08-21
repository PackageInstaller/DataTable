local PickDirTypeForScope = {
  NONE = 1,
  CROSS = 2,
  XSHAPE = 3
}
_enum("PickDirTypeForScope", PickDirTypeForScope)
require("scope_base")
_class("SkillScopeCalculator_ScopeByPickDirType", SkillScopeCalculator_Base)
SkillScopeCalculator_ScopeByPickDirType = SkillScopeCalculator_ScopeByPickDirType

function SkillScopeCalculator_ScopeByPickDirType:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local pickDir
  local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
  if activeSkillPickUpComponent then
    pickDir = activeSkillPickUpComponent:GetLastPickUpDirection()
  else
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    if previewPickUpComponent then
      pickDir = previewPickUpComponent:GetLastPickUpDirection()
    end
  end
  local pickDirType = PickDirTypeForScope.NONE
  if pickDir and pickDir ~= 0 then
    if self:_IsCrossDir(pickDir) then
      pickDirType = PickDirTypeForScope.CROSS
    elseif self:_IsXDir(pickDir) then
      pickDirType = PickDirTypeForScope.XSHAPE
    else
      pickDirType = PickDirTypeForScope.NONE
    end
  else
    pickDirType = scopeParam.defaultDirType
  end
  local bodyAreaArray = bodyArea
  local param = scopeParam
  local world = self._gridFilter._world
  local attackRangeList = {}
  local wholeRangeList = {}
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  local curScopeParam = scopeParam[pickDirType]
  if curScopeParam then
    local scope = curScopeParam
    local _scopeType = scope.scopeType
    if _scopeType then
      local _scope_param = scope.scopeParam
      local transCenterPos = centerPos
      local result = calc:ComputeScopeRange(_scopeType, _scope_param, transCenterPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
      attackRangeList = result:GetAttackRange()
      wholeRangeList = result:GetWholeGridRange()
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.ScopeByPickDirType, centerPos, attackRangeList, wholeRangeList)
  return result
end

function SkillScopeCalculator_ScopeByPickDirType:_IsCrossDir(dirType)
  if dirType == HitBackDirectionType.Down or dirType == HitBackDirectionType.Up or dirType == HitBackDirectionType.Left or dirType == HitBackDirectionType.Right then
    return true
  end
  return false
end

function SkillScopeCalculator_ScopeByPickDirType:_IsXDir(dirType)
  if dirType == HitBackDirectionType.RightUp or dirType == HitBackDirectionType.RightDown or dirType == HitBackDirectionType.LeftUp or dirType == HitBackDirectionType.LeftDown then
    return true
  end
  return false
end
