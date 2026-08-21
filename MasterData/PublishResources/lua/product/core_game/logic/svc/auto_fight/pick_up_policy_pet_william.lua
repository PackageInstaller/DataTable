require("pick_up_policy_base")
_class("PickUpPolicy_PetWilliam", PickUpPolicy_Base)
PickUpPolicy_PetWilliam = PickUpPolicy_PetWilliam

function PickUpPolicy_PetWilliam:CalcAutoFightPickUpPolicy(calcParam)
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
  local retScopeResult = {}
  local retTargetIds = {}
  if 0 < #scopeParamList then
    local totalScopeParam = scopeParamList[1]
    if totalScopeParam:GetScopeType() == SkillScopeType.ScopeByPickNum then
      local subScopeParamList = totalScopeParam:GetScopeParamData()
      if subScopeParamList then
        local subParam = subScopeParamList[1]
        local validScopeParam = SkillPreviewScopeParam:New({
          TargetType = subParam.targetType,
          ScopeType = subParam.scopeType,
          ScopeCenterType = subParam.scopeCenterType,
          TargetTypeParam = subParam.targetTypeParam,
          OnlyCanMove = true
        })
        validScopeParam:SetScopeParamData(subParam.scopeParam)
        local validGirdList = utilScopeSvc:BuildScopeGridList({validScopeParam}, petEntity)
        local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
        local invalidGridDict = {}
        for _, invalidPos in ipairs(invalidGridList) do
          invalidGridDict[self:_Pos2Index(invalidPos)] = true
        end
        local validPosIdxList = {}
        local validPosList = {}
        for _, validPos in ipairs(validGirdList) do
          local validPosIdx = self:_Pos2Index(validPos)
          if not invalidGridDict[validPosIdx] then
            validPosIdxList[validPosIdx] = true
            validPosList[#validPosList + 1] = validPos
          end
        end
        local firstPickPos
        for _, off in ipairs(ringMax) do
          local posIdx = self:_PosIndexAddOffset(casterPosIndex, off)
          if validPosIdxList[posIdx] then
            local pos = self:_Index2Pos(posIdx)
            local color = env.BoardPosPieces[posIdx]
            if color and color ~= PieceType.Blue then
              firstPickPos = pos
              break
            end
          end
        end
        if firstPickPos then
          subParam = subScopeParamList[2]
          local validScopeParam = SkillPreviewScopeParam:New({
            TargetType = subParam.targetType,
            ScopeType = subParam.scopeType,
            ScopeCenterType = subParam.scopeCenterType,
            TargetTypeParam = subParam.targetTypeParam,
            OnlyCanMove = true
          })
          validScopeParam:SetScopeParamData(subParam.scopeParam)
          validGirdList = utilScopeSvc:BuildScopeGridListMultiPick({validScopeParam}, petEntity, {firstPickPos})
          local validPosIdxList = {}
          local validPosList = {}
          for _, validPos in ipairs(validGirdList) do
            local validPosIdx = self:_Pos2Index(validPos)
            if not invalidGridDict[validPosIdx] then
              validPosIdxList[validPosIdx] = true
              validPosList[#validPosList + 1] = validPos
            end
          end
          HelperProxy:SortPosByCenterPosDistanceFar(firstPickPos, validPosList)
          local secondPickPos
          for _, pos in ipairs(validPosList) do
            if firstPickPos ~= pos then
              secondPickPos = secondPickPos or pos
              local posIdx = self:_Pos2Index(pos)
              local color = env.BoardPosPieces[posIdx]
              if color and color ~= PieceType.Blue then
                secondPickPos = pos
                break
              end
            end
          end
          if secondPickPos then
            table.insert(pickPosList, firstPickPos)
            table.insert(pickPosList, secondPickPos)
            retScopeResult, retTargetIds = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, pickPosList)
          end
        end
      end
    end
  end
  local attackPosList = {}
  if retScopeResult.GetAttackRange then
    attackPosList = retScopeResult:GetAttackRange()
  end
  return pickPosList, attackPosList, retTargetIds
end
