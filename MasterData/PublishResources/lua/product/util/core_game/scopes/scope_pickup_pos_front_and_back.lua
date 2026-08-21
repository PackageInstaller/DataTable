require("scope_base")
_class("SkillScopeCalculator_PickupPosFrontAndBack", SkillScopeCalculator_Base)
SkillScopeCalculator_PickupPosFrontAndBack = SkillScopeCalculator_PickupPosFrontAndBack

function SkillScopeCalculator_PickupPosFrontAndBack:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
  local pickUpCenterPos
  if activeSkillPickUpComponent then
    pickUpCenterPos = activeSkillPickUpComponent:GetFirstValidPickUpGridPos()
  else
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    if previewPickUpComponent then
      pickUpCenterPos = previewPickUpComponent:GetFirstValidPickUpGridPos()
    end
  end
  local dir = self:_GetSimplifiedV2Direction(pickUpCenterPos - casterPos)
  local attackRange = {}
  local wholeArea = {}
  local posForward = pickUpCenterPos + dir
  self:_InsertTargetGrid(attackRange, posForward, wholeArea)
  local posBackward = pickUpCenterPos - dir
  self:_InsertTargetGrid(attackRange, posBackward, wholeArea)
  local result = SkillScopeResult:New(SkillScopeType.TeleportTargetPosFrontAndBack, casterPos, attackRange, wholeArea)
  return result
end

function SkillScopeCalculator_PickupPosFrontAndBack:_GetSimplifiedV2Direction(v2)
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
