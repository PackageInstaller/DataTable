require("pick_up_policy_base")
_class("PickUpPolicy_PetGiles", PickUpPolicy_Base)
PickUpPolicy_PetGiles = PickUpPolicy_PetGiles

function PickUpPolicy_PetGiles:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicy_PetGiles(petEntity, activeSkillID, casterPos)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_PetGiles:_CalPickPosPolicy_PetGiles(petEntity, activeSkillID, casterPos)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local minHp = 1
  local targetEntity
  for i, e in ipairs(group:GetEntities()) do
    if not e:HasDeadMark() then
      local hp = e:Attributes():GetCurrentHP()
      if not targetEntity or minHp > hp then
        minHp = hp
        targetEntity = e
      end
    end
  end
  if self._world:MatchType() == MatchType.MT_BlackFist then
    targetEntity = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
  end
  if not targetEntity then
    return {}, {}, {}
  end
  local retScopeResult = {}
  local retTargetIds = {}
  local pickPos
  local targetGridPos = targetEntity:GridLocation():GetGridPos()
  local bodyArea = targetEntity:BodyArea():GetArea()
  local dirs = {
    Vector2(0, 1),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(-1, 0)
  }
  for _, value in ipairs(bodyArea) do
    local workPos = targetGridPos + value
    for _, dir in ipairs(dirs) do
      local targetPos = workPos + dir
      if targetPos == casterPos then
        pickPos = targetPos
        break
      end
    end
    if pickPos then
      break
    end
  end
  local utilData = self._world:GetService("UtilData")
  local extraBoardPosRange = utilData:GetExtraBoardPosList()
  if not pickPos then
    local utilDataSvc = self._world:GetService("UtilData")
    for _, dir in ipairs(dirs) do
      local targetPos = targetGridPos + dir
      if utilDataSvc:IsValidPiecePos(targetPos) and not self:_IsPosInExtraBoard(targetPos, extraBoardPosRange) then
        pickPos = targetPos
        break
      end
    end
  end
  retScopeResult, retTargetIds = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, pickPos)
  return {pickPos}, retScopeResult:GetAttackRange(), retTargetIds
end
