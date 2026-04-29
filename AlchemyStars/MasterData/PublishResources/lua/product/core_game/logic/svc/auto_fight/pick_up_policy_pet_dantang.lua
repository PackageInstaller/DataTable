require("pick_up_policy_base")
_class("PickUpPolicy_PetDanTang", PickUpPolicy_Base)
PickUpPolicy_PetDanTang = PickUpPolicy_PetDanTang

function PickUpPolicy_PetDanTang:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local monsterList, monsterPosList = utilScopeSvc:SelectAllMonster()
  for i, pos in ipairs(monsterPosList) do
    table.removev(validPosList, pos)
  end
  local t = {}
  for _, pos in ipairs(validPosList) do
    local posIdx = self:_Pos2Index(pos)
    local env = self:_GetPickUpPolicyEnv()
    local color = env.BoardPosPieces[posIdx]
    if color and color ~= PieceType.Red then
      t[#t + 1] = pos
    end
  end
  validPosList = t
  if table.count(validPosList) <= 2 then
    for _, pos in ipairs(validPosList) do
      table.insert(pickPosList, pos)
    end
    return pickPosList, attackPosList, targetIdList
  end
  local firstPickUpPos
  local utilScope = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScope:GetSkillScopeCalc()
  for i = 1, 9 do
    local curPos = petEntity:GetGridPosition()
    local curBodyArea = petEntity:BodyArea():GetArea()
    local scopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.SquareRing, {1}, curPos, curBodyArea)
    for _, pos in ipairs(scopeResult:GetAttackRange()) do
      if table.icontains(validPosList, pos) then
        firstPickUpPos = pos
        break
      end
    end
    if firstPickUpPos then
      break
    end
  end
  firstPickUpPos = firstPickUpPos or validPosList[1]
  local hasCalcPosList = {}
  table.insert(hasCalcPosList, firstPickUpPos)
  local results = {}
  for i, e in ipairs(monsterList) do
    local curPos = e:GetGridPosition()
    local curBodyArea = e:BodyArea():GetArea()
    local scopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.SquareRing, {1}, curPos, curBodyArea)
    for _, pos in ipairs(scopeResult:GetAttackRange()) do
      if table.icontains(validPosList, pos) and not table.icontains(hasCalcPosList, pos) then
        local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, {firstPickUpPos, pos})
        if 0 < #target_ids then
          table.insert(results, {
            pos,
            target_ids,
            scope_result:GetAttackRange()
          })
        end
        table.insert(hasCalcPosList, pos)
      end
    end
  end
  if 0 < #results then
    table.sort(results, function(a, b)
      return #a[2] > #b[2]
    end)
    pickPosList = {
      firstPickUpPos,
      results[1][1]
    }
    table.appendArray(targetIdList, results[1][2])
    table.appendArray(attackPosList, results[1][3])
  end
  return pickPosList, attackPosList, targetIdList
end
