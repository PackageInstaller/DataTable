require("scope_base")
_class("SkillScopeCalculator_PickupAngleFreeLine", SkillScopeCalculator_Base)
SkillScopeCalculator_PickupAngleFreeLine = SkillScopeCalculator_PickupAngleFreeLine

function SkillScopeCalculator_PickupAngleFreeLine:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  self._world = self._gridFilter._world
  local bNoExtend = scopeParam.noExtend == 1
  local widthThreshold = BattleConst.ScopeAngleFreeLineThreshold
  if scopeParam.widthThreshold then
    widthThreshold = scopeParam.widthThreshold * 0.8
  end
  local initIndex = scopeParam.init
  local destIndex = scopeParam.dest
  local pickupInitPos = centerPos[initIndex]
  local pickupDestPos = centerPos[destIndex]
  local bOnlyUseCenterPos = scopeParam.useCenterPos == 1
  if not bOnlyUseCenterPos then
    local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
    if activeSkillPickUpComponent then
      local all = activeSkillPickUpComponent:GetAllValidPickUpGridPos()
      pickupInitPos = all[initIndex]
      pickupDestPos = all[destIndex]
    else
      local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
      if previewPickUpComponent then
        local all = previewPickUpComponent:GetAllValidPickUpGridPos()
        pickupInitPos = all[initIndex]
        pickupDestPos = all[destIndex]
      end
    end
  end
  if not pickupInitPos then
    return SkillScopeResult:New(SkillScopeType.PickupAngleFreeLine, centerPos, {}, {})
  elseif not pickupDestPos then
    local a = {}
    local w = {}
    self:_InsertTargetGrid(a, pickupInitPos, w)
    return SkillScopeResult:New(SkillScopeType.PickupAngleFreeLine, centerPos, a, w)
  end
  local utilScope = self._world:GetService("UtilScopeCalc")
  local attackRange = {}
  local wholeRange = {}
  utilScope:P2PAngleFreeLineRange(pickupInitPos, pickupDestPos, attackRange, wholeRange, bNoExtend, widthThreshold)
  return SkillScopeResult:New(SkillScopeType.PickupAngleFreeLine, centerPos, attackRange, wholeRange)
end
