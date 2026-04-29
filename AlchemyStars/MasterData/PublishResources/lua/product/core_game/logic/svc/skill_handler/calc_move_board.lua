_class("SkillEffectCalc_MoveBoard", Object)
SkillEffectCalc_MoveBoard = SkillEffectCalc_MoveBoard

function SkillEffectCalc_MoveBoard:Constructor(world)
  self._world = world
end

function SkillEffectCalc_MoveBoard:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  self._skillEffectParam = skillEffectParam
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local times = skillEffectParam:GetTimes()
  local direction = skillEffectParam:GetDirection()
  local destroyOutTrap = skillEffectParam:GetDestroyOutTrap()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local board = self._world:GetBoardEntity():Board()
  local arr = board:GetBlockFlagArray()
  local skillRange = {}
  for x, col in pairs(arr) do
    for y, block in pairs(col) do
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
  if direction == Vector2(0, 1) or direction == Vector2(1, 0) then
    skillRange = self:_SmallToLargeSort(skillRange)
  elseif direction == Vector2(0, -1) or direction == Vector2(-1, 0) then
    skillRange = self:_OnReinsert(skillRange)
  end
  self._fourAreaFixPos = Vector2(0, 0)
  if direction == Vector2(0, 1) then
    self._fourAreaFixPos = Vector2(1, 1)
  elseif direction == Vector2(0, -1) then
    self._fourAreaFixPos = Vector2(1, 0)
  elseif direction == Vector2(1, 0) then
    self._fourAreaFixPos = Vector2(1, 1)
  elseif direction == Vector2(-1, 0) then
    self._fourAreaFixPos = Vector2(0, 1)
  end
  local results = {}
  for i = 1, times do
    local result = SkillEffectResultMoveBoard:New()
    for index, posList in pairs(skillRange) do
      local isLast = index == table.count(skillRange)
      self:_MoveBoardOneStepNew(result, posList, direction, destroyOutTrap, casterEntity, isLast)
    end
    results[#results + 1] = result
  end
  return results
end

function SkillEffectCalc_MoveBoard:_SmallToLargeSort(posDic)
  local function sortDicFunc(dic)
    local newDic = {}
    
    local keyList = {}
    for k, _ in pairs(dic) do
      table.insert(keyList, k)
    end
    table.sort(keyList, function(a, b)
      return b < a
    end)
    for i = 1, #keyList do
      newDic[#newDic + 1] = dic[keyList[i]]
    end
    return newDic
  end
  
  posDic = sortDicFunc(posDic)
  return posDic
end

function SkillEffectCalc_MoveBoard:_OnReinsert(posDic)
  local function sortDicFunc(dic)
    local newDic = {}
    
    local keyList = {}
    for k, _ in pairs(dic) do
      table.insert(keyList, k)
    end
    for i = 1, #keyList do
      newDic[#newDic + 1] = dic[keyList[i]]
    end
    return newDic
  end
  
  posDic = sortDicFunc(posDic)
  return posDic
end

function SkillEffectCalc_MoveBoard:_MoveBoardOneStepNew(result, posList, direction, destroyOutTrap, casterEntity, isLast)
  local sRandom = self._world:GetService("RandomLogic")
  local sTrigger = self._world:GetService("Trigger")
  local utilData = self._world:GetService("UtilData")
  local boardCmpt = self._world:GetBoardEntity():Board()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local toTriggerTraps = {}
  local toDeadTraps = {}
  for i, pos in ipairs(posList) do
    local curPos = pos
    local targetPos = pos + direction
    local nextPos = pos - direction
    local pieceType = boardCmpt:GetPieceType(pos)
    local nextPieceType = boardCmpt:GetPieceType(nextPos)
    local targetPieceType = utilData:IsValidPiecePos(targetPos)
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
          elseif gridPos ~= pos then
            moreAreaCanMove = false
          end
        end
      end
      local blockFlag = BlockFlag.None
      if e:HasBlockFlag() then
        blockFlag = e:BlockFlag():GetBlockFlag()
      end
      if blockFlag & BlockFlag.MoveBoard ~= 0 then
        moreAreaCanMove = false
      end
      return e ~= e:HasBlockFlag() and moreAreaCanMove
    end
    
    local es = boardCmpt:GetPieceEntities(pos, filter)
    if targetPieceType then
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
            result:AddMoveBoardEntity(e:GetID(), curPos - self._fourAreaFixPos, targetPos - self._fourAreaFixPos)
            e:SetGridPosition(targetPos - self._fourAreaFixPos)
            boardServiceLogic:UpdateEntityBlockFlag(e, curPos - self._fourAreaFixPos, targetPos - self._fourAreaFixPos)
          else
            result:AddMoveBoardEntity(e:GetID(), curPos, targetPos)
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
            local blockEntitys = boardCmpt:GetPieceEntities(targetPos, function(e)
              return (e:HasTeam() or e:HasMonsterID()) and not e:HasDeadMark()
            end)
            if 0 < #es then
              targetEntity = es[1]
            end
            if targetEntity then
              toTriggerTraps[#toTriggerTraps + 1] = {e, targetEntity}
            end
          end
          sTrigger:Notify(NTTransportEachMoveEnd:New(e, curPos, targetPos))
        else
        end
      end
      local teamEntity = self._world:Player():GetCurrentTeamEntity()
      local teamPos = teamEntity:GetGridPosition()
      if teamPos == curPos then
        pieceType = sRandom:LogicRand(1, 4)
      end
      if teamPos == targetPos then
        pieceType = PieceType.None
      end
      result:AddConvertColor(targetPos, targetPieceType, pieceType)
      boardServiceLogic:SetPieceTypeLogic(pieceType, targetPos)
      if isPieceEffect then
        if teamPos == targetPos then
          result:AddMoveBoardPrism(curPos, nil, prismEntityID, nil)
        else
          result:AddMoveBoardPrism(curPos, targetPos, prismEntityID, pieceEffectType)
        end
      end
    else
      result:AddMoveBoardPiece(curPos, targetPos)
      if isPieceEffect then
        result:AddMoveBoardPrism(curPos, nil, prismEntityID, nil)
      end
      for i, entity in ipairs(es) do
        if entity:HasTrapID() and destroyOutTrap == 1 then
          result:AddMoveBoardEntity(entity:GetID(), curPos, targetPos)
          entity:SetGridPosition(targetPos)
          boardServiceLogic:RemoveEntityBlockFlag(entity, curPos)
          table.insert(toDeadTraps, entity)
        else
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
    for i, pos in ipairs(posList) do
      local curPieceType = boardCmpt:GetPieceType(pos)
      local envIndexZeroPos = pos - direction
      local pieceFillTable = boardServiceLogic:SupplyPieceList({pos})
      local newPieceType = pieceFillTable[1].color
      if newPieceType ~= curPieceType then
        result:AddConvertColor(pos, curPieceType, newPieceType)
        boardServiceLogic:SetPieceTypeLogic(newPieceType, pos)
      end
      result:AddMoveBoardPiece(envIndexZeroPos, pos)
      result:AddMoveBoardPieceCutIn(envIndexZeroPos, pos, newPieceType)
      local convertInfoArray = {}
      local convertInfo = NTGridConvert_ConvertInfo:New(envIndexZeroPos, PieceType.None, newPieceType)
      table.insert(convertInfoArray, convertInfo)
      if 0 < #convertInfoArray then
        local nt = NTGridConvert:New(casterEntity, convertInfoArray)
        sTrigger:Notify(nt)
        nt:SetSkillType(self._skillEffectParam:GetSkillType())
      end
    end
  end
  for i, v in ipairs(toTriggerTraps) do
    self:_TriggerTraps(result, v[1], v[2])
  end
  for i, entity in ipairs(toDeadTraps) do
    self:_DestroyTrap(result, entity)
  end
end

function SkillEffectCalc_MoveBoard:_TriggerTraps(result, trapEntity, triggerEntity)
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

function SkillEffectCalc_MoveBoard:_DestroyTrap(result, trapEntity)
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local trapCmpt = trapEntity:Trap()
  trapEntity:Attributes():Modify("HP", 0)
  local disableDieSkill = true
  trapServiceLogic:AddTrapDeadMark(trapEntity, disableDieSkill)
  result:AddTrapDestroyList(trapEntity:GetID())
end

function SkillEffectCalc_MoveBoard:_GetNeighboringEnv(envList, env)
  local total = #envList
  local envIdx = env.index
  local idx = envIdx - 1
  local neighboringEnv = envList[idx]
  return neighboringEnv
end
