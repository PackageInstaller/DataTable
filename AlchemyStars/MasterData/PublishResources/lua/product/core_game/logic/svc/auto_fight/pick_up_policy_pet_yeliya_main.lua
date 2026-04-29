require("pick_up_policy_base")
_class("PickUpPolicy_PetYeliyaMain", PickUpPolicy_Base)
PickUpPolicy_PetYeliyaMain = PickUpPolicy_PetYeliyaMain

function PickUpPolicy_PetYeliyaMain:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicy_PetYeliyaMain(petEntity, activeSkillID, casterPos)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_PetYeliyaMain:_CalPickPosPolicy_PetYeliyaMain(petEntity, activeSkillID, casterPos)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local scopeParamList = skillConfigData._pickUpValidScopeList
  local checkDamageSkillID = 30018411
  local policyParam = skillConfigData:GetAutoFightPickPosPolicyParam()
  if policyParam and policyParam.checkDamageSkillID then
    checkDamageSkillID = tonumber(policyParam.checkDamageSkillID)
  end
  local pickPosList = {}
  local retScopeResult = {}
  local retTargetIds = {}
  local tmpPickList = {}
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
          TargetTypeParam = subParam.targetTypeParam
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
        local firstPickPos, lastPickPos
        local lastPickSuperGrid = false
        local testPickPos
        testPickPos = self:_YeliyaFindValidPosWithSuperGrid(petEntity, casterPos, validPosIdxList, tmpPickList)
        if testPickPos then
          firstPickPos = testPickPos
          lastPickPos = testPickPos
          lastPickSuperGrid = true
          table.insert(tmpPickList, firstPickPos)
        else
          testPickPos = self:_YeliyaFindValidPosWithMaxTargetCount(petEntity, casterPos, validPosIdxList, tmpPickList, checkDamageSkillID)
          if testPickPos then
            firstPickPos = testPickPos
            lastPickPos = testPickPos
            lastPickSuperGrid = false
            table.insert(tmpPickList, firstPickPos)
          else
            return {}, {}, {}
          end
        end
        if firstPickPos then
          if not lastPickSuperGrid then
          else
            local subPickFinish = false
            local maxFindTimes = 30
            local findNextTimes = 0
            subParam = subScopeParamList[2]
            local validScopeParam = SkillPreviewScopeParam:New({
              TargetType = subParam.targetType,
              ScopeType = subParam.scopeType,
              ScopeCenterType = subParam.scopeCenterType,
              TargetTypeParam = subParam.targetTypeParam
            })
            validScopeParam:SetScopeParamData(subParam.scopeParam)
            while not subPickFinish do
              findNextTimes = findNextTimes + 1
              if maxFindTimes < findNextTimes then
                subPickFinish = true
                break
              end
              if lastPickSuperGrid then
                local subScopeResult = utilScopeSvc:CalcSKillPreviewScopeResult(validScopeParam, lastPickPos, petEntity)
                local validGirdList = subScopeResult:GetAttackRange()
                local validPosIdxList = {}
                local validPosList = {}
                for _, validPos in ipairs(validGirdList) do
                  local validPosIdx = self:_Pos2Index(validPos)
                  if not invalidGridDict[validPosIdx] then
                    validPosIdxList[validPosIdx] = true
                    validPosList[#validPosList + 1] = validPos
                  end
                end
                local nextPickPos
                testPickPos = self:_YeliyaFindValidPosWithSuperGrid(petEntity, lastPickPos, validPosIdxList, tmpPickList)
                if testPickPos then
                  nextPickPos = testPickPos
                  lastPickPos = testPickPos
                  lastPickSuperGrid = true
                  table.insert(tmpPickList, nextPickPos)
                else
                  testPickPos = self:_YeliyaFindValidPosWithMaxTargetCount(petEntity, lastPickPos, validPosIdxList, tmpPickList, checkDamageSkillID)
                  if testPickPos then
                    nextPickPos = testPickPos
                    lastPickPos = testPickPos
                    lastPickSuperGrid = false
                    table.insert(tmpPickList, nextPickPos)
                  else
                    testPickPos = self:_YeliyaFindValidPosNearToMonster(petEntity, lastPickPos, validPosIdxList, validPosList, tmpPickList)
                    if testPickPos then
                      nextPickPos = testPickPos
                      lastPickPos = testPickPos
                      lastPickSuperGrid = false
                      table.insert(tmpPickList, nextPickPos)
                    end
                  end
                  subPickFinish = true
                end
              end
            end
          end
          if tmpPickList and 0 < #tmpPickList then
            pickPosList = tmpPickList
          end
        end
      end
    end
  end
  return pickPosList, retScopeResult, retTargetIds
end

function PickUpPolicy_PetYeliyaMain:_YeliyaFindValidPosWithSuperGrid(petEntity, centerPos, validPosIdxList, alreadyPickList)
  local pickPos
  local utilDataSvc = self._world:GetService("UtilData")
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local centerPosIndex = self:_Pos2Index(centerPos)
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(centerPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      if not table.icontains(alreadyPickList, pos) then
        local isBlockedLinkLine = boardService:IsPosBlock(pos, BlockFlag.LinkLine)
        if not isBlockedLinkLine then
          local traps = utilDataSvc:GetTrapsAtPos(pos)
          if traps then
            for index, e in ipairs(traps) do
              if e:Trap():IsSuperGrid() then
                pickPos = pos
                break
              end
            end
          end
        end
      end
    end
  end
  return pickPos
end

function PickUpPolicy_PetYeliyaMain:_YeliyaFindValidPosWithMaxTargetCount(petEntity, centerPos, validPosIdxList, alreadyPickList, checkDamageSkillID)
  local pickPos
  checkDamageSkillID = 30018411
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local centerPosIndex = self:_Pos2Index(centerPos)
  local maxTargetCount = 0
  local maxTargetPos
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(centerPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      if not table.icontains(alreadyPickList, pos) then
        local isBlockedLinkLine = boardService:IsPosBlock(pos, BlockFlag.LinkLine)
        if not isBlockedLinkLine then
          local result, targetIds = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, checkDamageSkillID, pos)
          if targetIds then
            local targetCount = #targetIds
            if maxTargetCount < targetCount then
              maxTargetCount = targetCount
              maxTargetPos = pos
            end
          end
        end
      end
    end
  end
  if maxTargetPos then
    pickPos = maxTargetPos
  end
  return pickPos
end

function PickUpPolicy_PetYeliyaMain:_YeliyaFindValidPosNearToMonster(petEntity, centerPos, validPosIdxList, validPosList, alreadyPickList)
  local pickPos
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local boardService = self._world:GetService("BoardLogic")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local validEnemyList = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local enemyTeam = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    table.insert(validEnemyList, enemyTeam)
  else
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if not monsterEntity:HasDeadMark() then
        table.insert(validEnemyList, monsterEntity)
      end
    end
  end
  if validEnemyList and 0 < #validEnemyList then
    local enemyPosList = {}
    for index, enemyEntity in ipairs(validEnemyList) do
      local enemyPos = enemyEntity:GetGridPosition()
      local tv2BodyArea = enemyEntity:BodyArea():GetArea()
      for _, v2Relative in ipairs(tv2BodyArea) do
        local v2 = enemyPos + v2Relative
        table.insert(enemyPosList, v2)
      end
    end
    local sortedEnemyPosList = HelperProxy:SortPosByCenterPosDistance(centerPos, enemyPosList)
    if sortedEnemyPosList and 0 < #sortedEnemyPosList then
      local nearestPos = sortedEnemyPosList[1]
      local sortedValidPosList = HelperProxy:SortPosByCenterPosDistance(nearestPos, validPosList)
      if sortedValidPosList then
        for index, pos in ipairs(sortedValidPosList) do
          if not table.icontains(alreadyPickList, pos) then
            local isBlockedLinkLine = boardService:IsPosBlock(pos, BlockFlag.LinkLine)
            if not isBlockedLinkLine then
              pickPos = pos
              break
            end
          end
        end
      end
    end
  end
  return pickPos
end
