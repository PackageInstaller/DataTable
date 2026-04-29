require("pick_up_policy_base")
_class("PickUpPolicy_PetKangNa", PickUpPolicy_Base)
PickUpPolicy_PetKangNa = PickUpPolicy_PetKangNa

function PickUpPolicy_PetKangNa:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local env = self:_GetPickUpPolicyEnv()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local scopeParamList = skillConfigData._pickUpValidScopeList
  local casterPos = petEntity:GridLocation().Position
  local casterPosIndex = self:_Pos2Index(casterPos)
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  local results = {}
  if 0 < #scopeParamList then
    local totalScopeParam = scopeParamList[1]
    if totalScopeParam:GetScopeType() == SkillScopeType.ScopeByPickNum then
      local subScopeParamList = totalScopeParam:GetScopeParamData()
      if subScopeParamList then
        local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
        local invalidGridDict = {}
        for _, invalidPos in ipairs(invalidGridList) do
          invalidGridDict[self:_Pos2Index(invalidPos)] = true
        end
        local secondSubParam = subScopeParamList[2]
        local secondValidScopeParam = SkillPreviewScopeParam:New({
          TargetType = secondSubParam.targetType,
          ScopeType = secondSubParam.scopeType,
          ScopeCenterType = secondSubParam.scopeCenterType,
          TargetTypeParam = secondSubParam.targetTypeParam
        })
        secondValidScopeParam:SetScopeParamData(secondSubParam.scopeParam)
        local secondValidGirdList = utilScopeSvc:BuildScopeGridListMultiPick({secondValidScopeParam}, petEntity, {casterPos})
        local secondValidPosIdxList = {}
        local secondValidPosList = {}
        for _, validPos in ipairs(secondValidGirdList) do
          local validPosIdx = self:_Pos2Index(validPos)
          if not invalidGridDict[validPosIdx] then
            secondValidPosIdxList[validPosIdx] = true
            secondValidPosList[#secondValidPosList + 1] = validPos
          end
        end
        local firstPickPos = casterPos
        local caledAngleInThisPos = {}
        for _, secondPos in ipairs(secondValidPosList) do
          if secondPos ~= firstPickPos then
            local caledDir = secondPos - firstPickPos
            local angle = Vector2.Angle(Vector2.up, caledDir)
            if 0 > caledDir.x then
              angle = 360 - angle
            end
            local tmpVal = angle * 10
            local f = math.floor(tmpVal)
            if f == tmpVal then
              tmpVal = f
            else
              tmpVal = math.floor(tmpVal + 0.5)
            end
            angle = tmpVal / 10
            if not table.icontains(caledAngleInThisPos, angle) then
              table.insert(caledAngleInThisPos, angle)
              local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, {firstPickPos, secondPos})
              if 0 < #target_ids then
                table.insert(results, {
                  {firstPickPos, secondPos},
                  target_ids,
                  scope_result:GetAttackRange()
                })
              end
            end
          end
        end
      end
    end
  end
  if 0 < #results then
    table.sort(results, function(a, b)
      return #a[2] > #b[2]
    end)
    pickPosList = results[1][1]
    table.appendArray(targetIdList, results[1][2])
    table.appendArray(attackPosList, results[1][3])
  end
  return pickPosList, attackPosList, targetIdList
end
