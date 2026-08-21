require("pick_up_policy_base")
_class("PickUpPolicy_PetPrima", PickUpPolicy_Base)
PickUpPolicy_PetPrima = PickUpPolicy_PetPrima

function PickUpPolicy_PetPrima:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local curBodyArea = petEntity:BodyArea():GetArea()
  local pickPosList = {}
  local targetIDs = {}
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local platformScopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.FullScreen, 1, casterPos, curBodyArea)
  local tarSelector = self._world:GetSkillScopeTargetSelector()
  local targetArrray = tarSelector:DoSelectSkillTarget(petEntity, SkillTargetType.NearestMonster, platformScopeResult)
  if #targetArrray < 1 then
    return pickPosList, pickPosList, targetIDs
  end
  local targetID = targetArrray[1]
  local targetEntity = self._world:GetEntityByID(targetID)
  table.insert(targetIDs, targetID)
  local targetBodyAreaOutSidePosList = self:GetPosListAroundBodyArea(targetEntity, 1)
  local targetBodyAreaPosList = targetEntity:BodyArea():GetArea()
  local targetPos = targetEntity:GridLocation().Position
  local utilDataSvc = self._world:GetService("UtilData")
  local dirs = {
    Vector2(0, 1),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(-1, 0)
  }
  for _, bodyArea in pairs(targetBodyAreaPosList) do
    local bodyAreaPos = targetPos + bodyArea
    for _, dir in pairs(dirs) do
      local firstPos = bodyAreaPos + dir
      if utilDataSvc:IsValidPiecePos(firstPos) and not table.icontains(targetBodyAreaPosList, firstPos) then
        table.insert(pickPosList, firstPos)
        table.insert(pickPosList, bodyAreaPos)
        break
      end
    end
    if 0 < table.count(pickPosList) then
      break
    end
  end
  return pickPosList, pickPosList, targetIDs
end
