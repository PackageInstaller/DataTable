require("pick_up_policy_base")
_class("PickUpPolicy_PetSorkBekk", PickUpPolicy_Base)
PickUpPolicy_PetSorkBekk = PickUpPolicy_PetSorkBekk

function PickUpPolicy_PetSorkBekk:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  local configService = self._world:GetService("Config")
  local autoFightSvc = self._world:GetService("AutoFight")
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local validResults = self:_CalcResults(petEntity, activeSkillID, validPosList, true)
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  if 0 < #validResults then
    table.sort(validResults, function(a, b)
      return #a[2] > #b[2]
    end)
    for i = 1, pickUpNum do
      local t = validResults[i]
      if not t then
        break
      end
      pickPosList[i] = t[1]
      table.appendArray(targetIdList, t[2])
      table.appendArray(attackPosList, t[3])
    end
    return pickPosList, attackPosList, targetIdList
  end
  return pickPosList, attackPosList, targetIdList
end

function PickUpPolicy_PetSorkBekk:_CalcResults(petEntity, activeSkillID, validGirdList, needSetPickDir)
  local env = self:_GetPickUpPolicyEnv()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local results = {}
  local casterPos = petEntity:GetGridPosition()
  table.shuffle(validGirdList)
  local previewPickUpComponent
  if needSetPickDir then
    if not petEntity:HasPreviewPickUpComponent() then
      petEntity:AddPreviewPickUpComponent()
    end
    previewPickUpComponent = petEntity:PreviewPickUpComponent()
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local selectedDirection = {}
  for _, pos in ipairs(validGirdList) do
    local posIdx = self:_Pos2Index(pos)
    local direction = scopeCalculator:GetDirection(pos, casterPos)
    if table.icontains(selectedDirection, direction) then
    elseif env.BoardPosPieces[posIdx] then
      if previewPickUpComponent then
        previewPickUpComponent:AddDirection(direction, pos)
        previewPickUpComponent:AddGridPos(pos)
      end
      table.insert(selectedDirection, direction)
      local bombCenterPos = utilScopeSvc:AutoFightCalcBombPos(casterPos, pos)
      local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, bombCenterPos)
      if 0 < #target_ids then
        table.insert(results, {
          pos,
          target_ids,
          scope_result:GetAttackRange()
        })
      end
      if previewPickUpComponent then
        previewPickUpComponent:ClearGridPos()
        previewPickUpComponent:ClearDirection()
      end
    end
  end
  return results
end
