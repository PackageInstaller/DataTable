_class("PickUpPolicy_Base", Object)
PickUpPolicy_Base = PickUpPolicy_Base

function PickUpPolicy_Base:Constructor(world)
  self._world = world
end

function PickUpPolicy_Base:CalcAutoFightPickUpPolicy(calcParam)
  Log.exception("not implement pick up policy calculator")
  return
end

function PickUpPolicy_Base:_GetPickUpPolicyEnv()
  local autoFightSvc = self._world:GetService("AutoFight")
  return autoFightSvc:GetAutoFightEnvironment()
end

function PickUpPolicy_Base:_Pos2Index(pos)
  return pos.x * 100 + pos.y
end

function PickUpPolicy_Base:_Index2Pos(index)
  local env = self:_GetPickUpPolicyEnv()
  local pos = env.Index2Pos[index]
  return pos
end

function PickUpPolicy_Base:_PosIndexAddOffset(posIdx, offset)
  return posIdx + offset[1] * 100 + offset[2]
end

function PickUpPolicy_Base:_GetPickUpNumByConfig(skillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  return tonumber(skillConfigData._pickUpParam[1])
end

function PickUpPolicy_Base:_CalcPickUpValidGridList(petEntity, skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local validGirdList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
  local utilData = self._world:GetService("UtilData")
  local extraBoardPosRange = utilData:GetExtraBoardPosList()
  for _, extraPos in ipairs(extraBoardPosRange) do
    table.insert(invalidGridList, extraPos)
  end
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
  return validPosIdxList, validPosList
end

function PickUpPolicy_Base:_CalcSkillScopeResult_PickUpPolicy(petEntity, skillConfigData, scopeType, scopeParam, centerType, targetType, centerPos)
  local playerBodyArea = petEntity:BodyArea():GetArea()
  local casterDir = petEntity:GridLocation():GetGridDir()
  local casterPos = petEntity:GridLocation().Position
  centerPos = centerPos or casterPos
  if IsRandomSkillScopeType(scopeType) then
    scopeType = SkillScopeType.FullScreen
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local result = scopeCalculator:ComputeScopeRange(scopeType, scopeParam, centerPos, playerBodyArea, casterDir, targetType, casterPos, petEntity)
  local filterPassParam = SkillScopeFilterPassParam:New({
    casterPos = casterPos,
    casterBodyAreaArray = playerBodyArea,
    world = self._world
  })
  local scopeFilterDevice = SkillScopeFilterDevice:New()
  scopeFilterDevice:DoFilter(result, skillConfigData:GetScopeFilterParam(), filterPassParam)
  return result
end

function PickUpPolicy_Base:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, centerPos)
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local scopeType = skillConfigData:GetSkillScopeType()
  local scopeParam = skillConfigData:GetSkillScopeParam()
  local centerType = skillConfigData:GetSkillScopeCenterType()
  local targetType = skillConfigData:GetSkillTargetType()
  local skillScopeAndTarget = skillConfigData:GetAutoFightSkillScopeTypeAndTargetType()
  if skillScopeAndTarget and (skillScopeAndTarget.useType == AutoFightScopeUseType.Replace or skillScopeAndTarget.useType == AutoFightScopeUseType.ReplaceTargetAndTrapCount) then
    scopeType = skillScopeAndTarget.scopeType
    scopeParam = skillScopeAndTarget.scopeParam
    centerType = skillScopeAndTarget.centerType
    targetType = skillScopeAndTarget.targetType
  end
  if targetType == SkillTargetType.Board then
    targetType = SkillTargetType.Monster
  end
  local result = self:_CalcSkillScopeResult_PickUpPolicy(petEntity, skillConfigData, scopeType, scopeParam, centerType, targetType, centerPos)
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local targetIds = targetSelector:DoSelectSkillTarget(petEntity, targetType, result, activeSkillID)
  for i = #targetIds, 1, -1 do
    local targetID = targetIds[i]
    local targetEntity = self._world:GetEntityByID(targetID)
    if targetEntity and targetEntity:HasBuff() and not buffLogicSvc:CheckCanBeMagicAttack(petEntity, targetEntity) then
      table.remove(targetIds, i)
    end
  end
  if skillScopeAndTarget and skillScopeAndTarget.useType == AutoFightScopeUseType.ReplaceTargetAndTrapCount then
    local trapID = skillScopeAndTarget.trapID
    local count = skillScopeAndTarget.trapCount
    local trapSvc = self._world:GetService("TrapLogic")
    local trapPosList = trapSvc:FindTrapPosByTrapID(trapID)
    if count > #trapPosList then
      targetIds = {}
    end
  end
  return result, targetIds
end

function PickUpPolicy_Base:_IsCrossDir(dirType)
  if dirType == HitBackDirectionType.Down or dirType == HitBackDirectionType.Up or dirType == HitBackDirectionType.Left or dirType == HitBackDirectionType.Right then
    return true
  end
  return false
end

function PickUpPolicy_Base:_IsXDir(dirType)
  if dirType == HitBackDirectionType.RightUp or dirType == HitBackDirectionType.RightDown or dirType == HitBackDirectionType.LeftUp or dirType == HitBackDirectionType.LeftDown then
    return true
  end
  return false
end

local function GetTwoSideOffset(centerPos, dir)
  local ret = {}
  if dir.x ~= 0 then
    table.insert(ret, Vector2(centerPos.x, centerPos.y + 1))
    table.insert(ret, Vector2(centerPos.x, centerPos.y - 1))
  elseif dir.y ~= 0 then
    table.insert(ret, Vector2(centerPos.x + 1, centerPos.y))
    table.insert(ret, Vector2(centerPos.x - 1, centerPos.y))
  end
  return ret
end

function PickUpPolicy_Base:_CalcValidResultByPickUpType_PickUpPolicy(petEntity, activeSkillID, validPosList)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local pickUpType = skillConfigData:GetSkillPickType()
  local validResults = {}
  if pickUpType == SkillPickUpType.ColorInstruction then
    validResults = self:_CalcPickUpColor(petEntity, activeSkillID, validPosList)
  elseif pickUpType == SkillPickUpType.Instruction then
    validResults = self:_CalcPickUpPosAndRange(petEntity, activeSkillID, validPosList)
  elseif pickUpType == SkillPickUpType.DirectionInstruction then
    validResults = self:_CalcPickUpDirection(petEntity, activeSkillID, validPosList)
  elseif pickUpType == SkillPickUpType.PickDirOrSelf then
    validResults = self:_CalcPickUpDirection(petEntity, activeSkillID, validPosList, true)
  elseif pickUpType == SkillPickUpType.PickAndTeleportInst then
    validResults = self:_CalcPickUpPosAndTeleport(petEntity, activeSkillID, validPosList)
  elseif pickUpType == SkillPickUpType.PickAndDirectionInstruction then
    validResults = self:_CalcPickUpPosAndDirection(petEntity, activeSkillID, validPosList)
  elseif pickUpType == SkillPickUpType.PickOnePosAndRotate then
    validResults = self:_CalcPickUpPosAndRotate(petEntity, activeSkillID, validPosList, pickUpNum)
  elseif pickUpType == SkillPickUpType.LineAndDirectionInstruction then
    validResults = self:_CalcPickUpLineAndDirection(petEntity, activeSkillID, validPosList, pickUpNum)
  elseif pickUpType == SkillPickUpType.PickSwitchInstruction then
    validResults = self:_CalcPickUpSwitch(petEntity, activeSkillID, validPosList)
  elseif pickUpType == SkillPickUpType.PickDiffPowerInstruction then
    validResults = self:_CalcPickUpPosAndRange(petEntity, activeSkillID, validPosList)
  elseif pickUpType == SkillPickUpType.Hati then
    validResults = self:_CalcPickUpPosAndRangeHati(petEntity, activeSkillID, validPosList)
  end
  return validResults
end

function PickUpPolicy_Base:_CalcPickUpColor(petEntity, activeSkillID, validGirdList)
  local env = self:_GetPickUpPolicyEnv()
  local results = {}
  local selectedColor = {}
  for _, pos in ipairs(validGirdList) do
    local posIdx = self:_Pos2Index(pos)
    local color = env.BoardPosPieces[posIdx]
    if not selectedColor[color] then
      selectedColor[color] = true
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
  return results
end

function PickUpPolicy_Base:_CalcPickUpPosAndRange(petEntity, activeSkillID, validGirdList)
  local env = self:_GetPickUpPolicyEnv()
  local results = {}
  table.shuffle(validGirdList)
  for _, pos in ipairs(validGirdList) do
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
  return results
end

function PickUpPolicy_Base:_CalcPickUpPosAndRangeHati(petEntity, activeSkillID, validGirdList)
  local env = self:_GetPickUpPolicyEnv()
  local results = {}
  table.shuffle(validGirdList)
  for _, pos in ipairs(validGirdList) do
    if self:_HatiCheckOk(pos, petEntity) then
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
  end
  return results
end

function PickUpPolicy_Base:_HatiCheckOk(pickPos, petEntity)
  local utilDataSvc = self._world:GetService("UtilData")
  local entity = utilDataSvc:GetMonsterAtPos(pickPos)
  if entity then
    local block = BlockFlag.LinkLine
    local ringCount = 1
    local skillRangePos = self:GetPosListAroundBodyArea(entity, ringCount)
    local bHasValidPos = false
    for _, pos in ipairs(skillRangePos) do
      local bPosBlock = utilDataSvc:IsPosBlock(pos, block)
      if not bPosBlock then
        bHasValidPos = true
        break
      end
    end
    if bHasValidPos then
      return true
    end
  end
  return false
end

function PickUpPolicy_Base:_CalcPickUpPosAndTeleport(petEntity, activeSkillID, validGirdList)
  local env = self:_GetPickUpPolicyEnv()
  local results = {}
  table.shuffle(validGirdList)
  local playerPosIdx = self:_Pos2Index(env.PlayerPos)
  local firstPickUpPos = validGirdList[1]
  if not firstPickUpPos then
    return results
  end
  local secondPos
  local battleSvc = self._world:GetService("Battle")
  local connect = env.ConnectMap[playerPosIdx]
  for i = 1, 8 do
    local posIdx = connect[i]
    if posIdx then
      local pos = self:_Index2Pos(posIdx)
      if pos then
        local targetEntityList = battleSvc:FindMonsterEntityInPos(pos)
        if #targetEntityList == 0 and firstPickUpPos ~= pos then
          secondPos = self:_Index2Pos(posIdx)
          break
        end
      end
    end
  end
  if secondPos then
    table.insert(results, {
      firstPickUpPos,
      {1},
      {firstPickUpPos},
      secondPos
    })
  end
  return results
end

function PickUpPolicy_Base:_CalcPickUpDirection(petEntity, activeSkillID, validGirdList, needSetPickDir)
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
      local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, pos)
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

function PickUpPolicy_Base:_CalcPickUpPosAndDirection(petEntity, activeSkillID, validGirdList)
  local env = self:_GetPickUpPolicyEnv()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local results = {}
  local casterPos = petEntity:GetGridPosition()
  table.shuffle(validGirdList)
  for _, firstPickUpPos in ipairs(validGirdList) do
    local directionGridList = {}
    table.insert(directionGridList, Vector2(firstPickUpPos.x + 0, firstPickUpPos.y + 1))
    table.insert(directionGridList, Vector2(firstPickUpPos.x + 1, firstPickUpPos.y + 0))
    table.insert(directionGridList, Vector2(firstPickUpPos.x + 0, firstPickUpPos.y - 1))
    table.insert(directionGridList, Vector2(firstPickUpPos.x - 1, firstPickUpPos.y + 0))
    for _, secondPos in ipairs(directionGridList) do
      local posIdx = self:_Pos2Index(secondPos)
      if env.BoardPosPieces[posIdx] then
        local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, {firstPickUpPos, secondPos})
        if 0 < #target_ids then
          table.insert(results, {
            firstPickUpPos,
            target_ids,
            scope_result:GetAttackRange(),
            secondPos
          })
        end
      end
    end
  end
  return results
end

function PickUpPolicy_Base:_CalcPickUpLineAndDirection(petEntity, activeSkillID, validGirdList)
  local env = self:_GetPickUpPolicyEnv()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local results = {}
  local casterPos = petEntity:GetGridPosition()
  table.shuffle(validGirdList)
  for _, firstPickUpPos in ipairs(validGirdList) do
    local directionGridList = {}
    local mainDir = firstPickUpPos - casterPos
    local sidePos = GetTwoSideOffset(firstPickUpPos, mainDir)
    for _, sideGrid in ipairs(sidePos) do
      table.insert(directionGridList, sideGrid)
    end
    for _, secondPos in ipairs(directionGridList) do
      local posIdx = self:_Pos2Index(secondPos)
      if env.BoardPosPieces[posIdx] then
        local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, {firstPickUpPos, secondPos})
        if 0 < #target_ids then
          table.insert(results, {
            firstPickUpPos,
            target_ids,
            scope_result:GetAttackRange(),
            secondPos
          })
        end
      end
    end
  end
  return results
end

function PickUpPolicy_Base:_CalcPickUpPosAndRotate(petEntity, activeSkillID, validGirdList, dirCount)
  local env = self:_GetPickUpPolicyEnv()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local results = {}
  local casterPos = petEntity:GetGridPosition()
  table.shuffle(validGirdList)
  petEntity:AddPreviewPickUpComponent()
  local pickUpCmpt = petEntity:PreviewPickUpComponent()
  local dirs = {1, 2}
  if dirCount == 4 then
    dirs[3] = 3
    dirs[4] = 4
  end
  for _, dir in ipairs(dirs) do
    pickUpCmpt:SetReflectDir(dir)
    for _, pickUpPos in ipairs(validGirdList) do
      local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, pickUpPos)
      if 0 < #target_ids then
        table.insert(results, {
          pickUpPos,
          target_ids,
          scope_result:GetAttackRange(),
          dir
        })
        return results
      end
    end
  end
  return results
end

function PickUpPolicy_Base:_CalcPickUpSwitch(petEntity, activeSkillID, validGridList)
  local env = self:_GetPickUpPolicyEnv()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local results = {}
  local casterPos = petEntity:GetGridPosition()
  local pickDirPos = {}
  if validGridList then
    for _, gridPos in ipairs(validGridList) do
      local hitBackDirType = scopeCalculator:GetDirection(gridPos, casterPos)
      local pickDirType = PickDirTypeForScope.NONE
      if hitBackDirType then
        if self:_IsCrossDir(hitBackDirType) then
          pickDirType = PickDirTypeForScope.CROSS
          pickDirPos[pickDirType] = {hitBackDirType, gridPos}
        elseif self:_IsXDir(hitBackDirType) then
          pickDirType = PickDirTypeForScope.XSHAPE
          pickDirPos[pickDirType] = {hitBackDirType, gridPos}
        else
          pickDirType = PickDirTypeForScope.NONE
        end
      end
    end
  end
  petEntity:AddPreviewPickUpComponent()
  local pickUpCmpt = petEntity:PreviewPickUpComponent()
  local dirs = {2, 3}
  for dirType, record in pairs(pickDirPos) do
    pickUpCmpt:AddDirection(record[1], record[2])
    local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, casterPos)
    if 0 < #target_ids then
      table.insert(results, {
        record[2],
        target_ids,
        scope_result:GetAttackRange()
      })
    end
  end
  return results
end

function PickUpPolicy_Base:_CalcPickUpPosAndRange(petEntity, activeSkillID, validGirdList)
  local env = self:_GetPickUpPolicyEnv()
  local results = {}
  table.shuffle(validGirdList)
  for _, pos in ipairs(validGirdList) do
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
  return results
end

function PickUpPolicy_Base:GetPosListAroundBodyArea(entity, ringCount)
  local v2SelfGridPos = entity:GetGridPosition()
  local bodyArea = entity:BodyArea():GetArea()
  local v2SelfDir = entity:GetGridDirection()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = SkillScopeCalculator:New(utilScopeSvc)
  local scopeResult = scopeCalc:ComputeScopeRange(SkillScopeType.AroundBodyArea, {0, ringCount}, v2SelfGridPos, bodyArea, v2SelfDir, SkillTargetType.Monster, v2SelfGridPos)
  return scopeResult:GetAttackRange()
end

function PickUpPolicy_Base:_IsPosInExtraBoard(pos, extraBoardPosRange)
  local autoFightSvc = self._world:GetService("AutoFight")
  return autoFightSvc:_IsPosInExtraBoard(pos, extraBoardPosRange)
end

function PickUpPolicy_Base:_IsPosCanPick(pos, checkBadGrid, checkExtraBoard, utilSvc, extraBoardPosRange)
  local autoFightSvc = self._world:GetService("AutoFight")
  return autoFightSvc:_IsPosCanPick(pos, checkBadGrid, checkExtraBoard, utilSvc, extraBoardPosRange)
end
