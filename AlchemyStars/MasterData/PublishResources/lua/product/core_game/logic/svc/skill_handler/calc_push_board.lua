_class("SkillEffectCalc_PushBoard", Object)
SkillEffectCalc_PushBoard = SkillEffectCalc_PushBoard

function SkillEffectCalc_PushBoard:Constructor(world)
  self._world = world
  self._boardEntity = self._world:GetBoardEntity()
end

function SkillEffectCalc_PushBoard:DoSkillEffectCalculator(skillEffectCalcParam)
  local pushStep = self:_CalculatePushStep(skillEffectCalcParam)
  if pushStep == 0 then
    return
  end
  local skillEffectParam = skillEffectCalcParam:GetSkillEffectParam()
  local direction = skillEffectParam:GetDir()
  local sortRange = self:SortGridByPushDir(direction)
  self._fourAreaFixPos = Vector2(0, 0)
  self._nineAreaFixPos = Vector2(0, 0)
  if direction == Vector2(0, 1) then
    self._fourAreaFixPos = Vector2(1, 1)
    self._nineAreaFixPos = Vector2(1, 1)
  elseif direction == Vector2(0, -1) then
    self._fourAreaFixPos = Vector2(1, 0)
    self._nineAreaFixPos = Vector2(1, -1)
  elseif direction == Vector2(1, 0) then
    self._fourAreaFixPos = Vector2(1, 1)
    self._nineAreaFixPos = Vector2(1, 1)
  elseif direction == Vector2(-1, 0) then
    self._fourAreaFixPos = Vector2(0, 1)
    self._nineAreaFixPos = Vector2(-1, 1)
  end
  local results = {}
  for i = 1, pushStep do
    local result = SkillEffectPushBoardResult:New()
    for index, posList in pairs(sortRange) do
      local isLast = index == table.count(sortRange)
      self:PushBoardOneStep(result, posList, direction, isLast)
    end
    results[i] = result
  end
  return results
end

function SkillEffectCalc_PushBoard:_SortByFun(posDic, sortFun)
  local newDic = {}
  local keyList = {}
  for k, _ in pairs(posDic) do
    table.insert(keyList, k)
  end
  table.sort(keyList, sortFun)
  for i = 1, #keyList do
    newDic[#newDic + 1] = posDic[keyList[i]]
  end
  return newDic
end

function SkillEffectCalc_PushBoard:SortGridByPushDir(direction)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local board = self._boardEntity:Board()
  local boardBlockArray = board:ClonePieceTable()
  local skillRange = {}
  for x, col in pairs(boardBlockArray) do
    for y, _ in pairs(col) do
      local grid = Vector2(x, y)
      if not boardServiceLogic:IsPosBlock(grid, BlockFlag.SkillSkip) then
        if direction.x ~= 0 then
          if not skillRange[grid.x] then
            skillRange[grid.x] = {}
          end
          table.insert(skillRange[grid.x], grid)
        elseif direction.y ~= 0 then
          if not skillRange[grid.y] then
            skillRange[grid.y] = {}
          end
          table.insert(skillRange[grid.y], grid)
        end
      end
    end
  end
  
  local function sortFun(a, b)
    return b < a
  end
  
  if direction == Vector2(0, -1) or direction == Vector2(-1, 0) then
    function sortFun(a, b)
      return a < b
    end
  end
  return self:_SortByFun(skillRange, sortFun)
end

function SkillEffectCalc_PushBoard:PushBoardOneStep(result, posList, direction, isLast)
  local utilData = self._world:GetService("UtilData")
  local boardCmpt = self._boardEntity:Board()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local toTriggerTraps = {}
  local toDestroyTraps = {}
  for _, pos in ipairs(posList) do
    local curPos = pos
    local targetPos = pos + direction
    local pieceType = boardCmpt:GetPieceType(pos)
    local isValid = utilData:IsValidPiecePos(targetPos)
    local isPieceEffect = boardCmpt:IsSpecialPieceEffect(pos)
    local pieceEffectType = boardCmpt:GetBoardPieceEffectType(pos)
    local prismEntityID = isPieceEffect and boardCmpt:GetPrismEntityIDAtPos(pos) or nil
    
    local function filter(e)
      if e:HasDeadMark() then
        return false
      end
      local moreAreaCanMove = true
      local bodyArea = e:BodyArea()
      if bodyArea then
        local area = bodyArea:GetArea()
        if table.count(area) > 1 then
          local gridPos = e:GetGridPosition()
          if table.count(area) == 4 then
            if gridPos + self._fourAreaFixPos ~= pos then
              moreAreaCanMove = false
            end
          elseif table.count(area) == 9 then
            if gridPos + self._nineAreaFixPos ~= pos then
              moreAreaCanMove = false
            end
          elseif gridPos ~= pos then
            moreAreaCanMove = false
          end
        end
      end
      return moreAreaCanMove
    end
    
    local es = boardCmpt:GetPieceEntities(pos, filter)
    if isValid then
      result:AddMoveBoardPiece(curPos, targetPos)
      for i, e in ipairs(es) do
        local canMove = true
        local blockFlag = BlockFlag.MonsterLand
        local bodyArea = {}
        if e:HasBodyArea() then
          bodyArea = e:BodyArea():GetArea()
        end
        local gridPos = e:GetGridPosition()
        local targetPosList = {}
        local bodyAreaPosList = {}
        if table.count(bodyArea) > 1 then
          for _, area in ipairs(bodyArea) do
            local workPos = gridPos + area
            table.insert(bodyAreaPosList, workPos)
            local areaPos = workPos + direction
            table.insert(targetPosList, areaPos)
          end
        elseif gridPos then
          local areaPos = gridPos + direction
          targetPosList = {areaPos}
          bodyAreaPosList = {gridPos}
        end
        if #targetPosList == 0 then
          canMove = false
        end
        for _, pos in ipairs(targetPosList) do
          if not table.intable(bodyAreaPosList, pos) and (not utilData:IsValidPiecePos(pos) or boardServiceLogic:IsPosBlock(pos, blockFlag)) then
            canMove = false
            break
          end
        end
        if e:HasTrapID() and not canMove then
          local curBlockFlag = e:BlockFlag():GetBlockFlag()
          if curBlockFlag & BlockFlag.LinkLine == 0 then
            canMove = true
          end
        end
        if canMove then
          if table.count(bodyArea) == 4 then
            result:AddLogicMoveEntity(e:GetID(), curPos - self._fourAreaFixPos, targetPos - self._fourAreaFixPos)
            e:SetGridPosition(targetPos - self._fourAreaFixPos)
            boardServiceLogic:UpdateEntityBlockFlag(e, curPos - self._fourAreaFixPos, targetPos - self._fourAreaFixPos)
          elseif table.count(bodyArea) == 9 then
            result:AddLogicMoveEntity(e:GetID(), curPos - self._nineAreaFixPos, targetPos - self._nineAreaFixPos)
            e:SetGridPosition(targetPos - self._nineAreaFixPos)
            boardServiceLogic:UpdateEntityBlockFlag(e, curPos - self._nineAreaFixPos, targetPos - self._nineAreaFixPos)
          else
            result:AddLogicMoveEntity(e:GetID(), curPos, targetPos)
            e:SetGridPosition(targetPos)
            boardServiceLogic:UpdateEntityBlockFlag(e, curPos, targetPos)
          end
          if e:HasTeam() then
            local pets = e:Team():GetTeamPetEntities()
            for i, e in ipairs(pets) do
              e:SetGridPosition(targetPos)
            end
          elseif e:HasTrapID() then
            local targetEntity
            local blockEntities = boardCmpt:GetPieceEntities(targetPos, function(e)
              return (e:HasTeam() or e:HasMonsterID()) and not e:HasDeadMark()
            end)
            if 0 < #blockEntities then
              targetEntity = blockEntities[1]
            end
            if targetEntity then
              toTriggerTraps[#toTriggerTraps + 1] = {e, targetEntity}
            end
          end
        else
          local gridPos = e:GetGridPosition()
          result:AddRenderMoveEntity(e:GetID(), gridPos)
        end
      end
      local teamEntity = self._world:Player():GetCurrentTeamEntity()
      local teamPos = teamEntity:GetGridPosition()
      local utilDataSvc = self._world:GetService("UtilData")
      if utilDataSvc:CanChangePieceToGray() then
        if teamPos == curPos then
          local pieceFillTable = boardServiceLogic:SupplyPieceList({targetPos})
          pieceType = pieceFillTable[1].color
          result:AddConvertInfo(targetPos, pieceType)
        end
        if teamPos == targetPos then
          pieceType = PieceType.None
          result:AddConvertInfo(targetPos, pieceType)
        end
      end
      boardServiceLogic:SetPieceTypeLogic(pieceType, targetPos)
      if isPieceEffect then
        if teamPos == targetPos then
          result:AddMoveBoardPrism(curPos, nil, prismEntityID, nil)
        else
          result:AddMoveBoardPrism(curPos, targetPos, prismEntityID, pieceEffectType)
        end
      end
    else
      result:AddRemoveBoardPiece(curPos)
      if isPieceEffect then
        result:AddMoveBoardPrism(curPos, nil, prismEntityID, nil)
      end
      for i, entity in ipairs(es) do
        if entity:HasTrapID() then
          boardServiceLogic:RemoveEntityBlockFlag(entity, curPos)
          table.insert(toDestroyTraps, entity)
        else
          local gridPos = entity:GetGridPosition()
          result:AddRenderMoveEntity(entity:GetID(), gridPos)
        end
      end
    end
  end
  for i, v in ipairs(result:GetMoveBoardPrisms()) do
    local oldPos = v[1]
    boardCmpt:RemoveBoardPieceEffectType(oldPos)
    local newPos = v[2]
    local prismEntityID = v[3]
    local pieceEffectType = v[4]
    if newPos then
      boardCmpt:SetBoardPieceEffectType(newPos, pieceEffectType, prismEntityID)
    end
  end
  if isLast then
    local boardPushCmpt = self._boardEntity:BoardPush()
    local curIndex = boardPushCmpt:GetPushIndex() + 1
    boardPushCmpt:SetPushIndex(curIndex)
    local offsetVec2 = Vector2(0, curIndex)
    if direction.x ~= 0 then
      offsetVec2 = Vector2(curIndex, 0)
    end
    for i, pos in ipairs(posList) do
      local gridPos = pos + offsetVec2
      local newPieceType = boardPushCmpt:GetPieceType(gridPos)
      result:AddNewBoardPiece(pos, newPieceType, gridPos)
      boardServiceLogic:SetPieceTypeLogic(newPieceType, pos)
    end
  end
  for i, v in ipairs(toTriggerTraps) do
    self:_TriggerTraps(result, v[1], v[2])
  end
  for i, entity in ipairs(toDestroyTraps) do
    self:_DestroyTrap(result, entity)
  end
end

function SkillEffectCalc_PushBoard:_TriggerTraps(result, trapEntity, triggerEntity)
  if triggerEntity:HasTrapID() then
    return
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local triggerTraps, triggerResults = trapServiceLogic:CalcTrapTriggerSkill(trapEntity, triggerEntity)
  if triggerTraps then
    for i, trap in ipairs(triggerTraps) do
      local skillResult = triggerResults[i]
      result:AddTrapSkillResult(trap:GetID(), skillResult, triggerEntity:GetID())
    end
  end
end

function SkillEffectCalc_PushBoard:_DestroyTrap(result, trapEntity)
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapEntity:Attributes():Modify("HP", 0)
  local disableDieSkill = true
  trapServiceLogic:AddTrapDeadMark(trapEntity, disableDieSkill)
  result:AddTrapDestroyList(trapEntity:GetID())
end

function SkillEffectCalc_PushBoard:_CalculatePushStep(skillEffectCalcParam)
  local skillEffectParam = skillEffectCalcParam:GetSkillEffectParam()
  local targetIndex = skillEffectParam:GetTargetIndex()
  if not self._boardEntity:HasBoardPush() then
    return 0
  end
  local boardPushComponent = self._boardEntity:BoardPush()
  local curIndex = boardPushComponent:GetPushIndex()
  if targetIndex <= curIndex then
    return 0
  end
  local pushStep = skillEffectParam:GetPushStep()
  local pushDir = skillEffectParam:GetDir()
  local disFromBoardEdge = skillEffectParam:GetDisFromBoardEdge()
  if disFromBoardEdge then
    local casterID = skillEffectCalcParam:GetCasterEntityID()
    local caster = self._world:GetEntityByID(casterID)
    local casterPos = caster:GetGridPosition()
    local utilScope = self._world:GetService("UtilScopeCalc")
    local dataY = utilScope:GetMinMaxGridYByGridX(casterPos.x)
    local minY = dataY.min
    local maxY = dataY.max
    local dataX = utilScope:GetMinMaxGridYByGridX(casterPos.y)
    local minX = dataX.min
    local maxX = dataX.max
    local tempDis = 0
    if pushDir == Vector2(0, 1) then
      tempDis = math.abs(maxY - casterPos.y)
    elseif pushDir == Vector2(0, -1) then
      tempDis = math.abs(minY - casterPos.y)
    elseif pushDir == Vector2(1, 0) then
      tempDis = math.abs(maxX - casterPos.x)
    elseif pushDir == Vector2(-1, 0) then
      tempDis = math.abs(minX - casterPos.x)
    end
    if disFromBoardEdge >= tempDis then
      Log.error("[PushBoard] Distance between caster and board edge is ", tempDis, ", expect = ", disFromBoardEdge)
      return 0
    end
    if pushStep >= tempDis - disFromBoardEdge then
      pushStep = tempDis - disFromBoardEdge
    end
  end
  pushStep = math.min(pushStep, targetIndex - curIndex)
  return pushStep
end
