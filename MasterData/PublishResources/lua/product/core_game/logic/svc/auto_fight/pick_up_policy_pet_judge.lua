require("pick_up_policy_base")
_class("PickUpPolicy_PetJudge", PickUpPolicy_Base)
PickUpPolicy_PetJudge = PickUpPolicy_PetJudge

function PickUpPolicy_PetJudge:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicyPetJudge(petEntity, activeSkillID, validPosList, validPosIdxList)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_PetJudge:_CalPickPosPolicyPetJudge(petEntity, activeSkillID, validPosList, validPosIdxList)
  local env = self:_GetPickUpPolicyEnv()
  local petEntityID = petEntity:GetID()
  local petTraps = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() and e:HasSummoner() then
      local summonEntity = e:GetSummonerEntity()
      if summonEntity and summonEntity:HasSuperEntity() then
        summonEntity = summonEntity:GetSuperEntity()
      end
      if summonEntity then
        local summonEntityID = summonEntity:GetID()
        if petEntityID == summonEntityID then
          table.insert(petTraps, e)
        end
      end
    end
  end
  local pickPos, pickScopeRange
  if #petTraps == 0 then
    local ringNum = 2
    local posList = self:GetPosListAroundBodyArea(petEntity, ringNum)
    table.shuffle(posList)
    for _, pos in ipairs(posList) do
      local posIdx = self:_Pos2Index(pos)
      if validPosIdxList[posIdx] then
        pickPos = pos
        break
      end
    end
    if pickPos then
      local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, pickPos)
      pickScopeRange = scope_result:GetAttackRange()
    end
  else
    table.shuffle(validPosList)
    local results = {}
    for _, pos in ipairs(validPosList) do
      local posIdx = self:_Pos2Index(pos)
      if env.BoardPosPieces[posIdx] then
        local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, pos)
        if 0 < #target_ids then
          table.insert(results, {
            pos,
            target_ids,
            scope_result:GetAttackRange()
          })
        end
      end
    end
    if 0 < #results then
      table.sort(results, function(a, b)
        return #a[2] > #b[2]
      end)
      local tarResult = results[1]
      pickPos = tarResult[1]
      pickScopeRange = tarResult[3]
    end
  end
  if pickPos then
    return {pickPos}, pickScopeRange, {petEntityID}
  else
    return {}, {}, {}
  end
end
