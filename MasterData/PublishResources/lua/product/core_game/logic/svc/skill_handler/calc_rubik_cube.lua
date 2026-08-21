_class("SkillEffectCalc_RubikCube", Object)
SkillEffectCalc_RubikCube = SkillEffectCalc_RubikCube

function SkillEffectCalc_RubikCube:Constructor(world)
  self._world = world
end

function SkillEffectCalc_RubikCube:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local battleCmpt = self._world:BattleStat()
  local curRound = battleCmpt:GetLevelTotalRoundCount()
  local result = SkillEffectResultRubikCube:New()
  self._centerPos = Vector2(4, 4)
  local dir = Vector2(-1, 0)
  local rotateAngle = 0
  local radian = 0
  local boardList = {}
  local rangeListX = {}
  local rangeListY = {}
  local posList = {}
  local aloneBoard
  if curRound % 2 == 0 then
    dir = Vector2(-1, 0)
    boardList = {
      1,
      4,
      3,
      2
    }
    rangeListX = {
      1,
      2,
      3,
      4,
      5,
      6,
      7
    }
    local priorityY = {
      5,
      6,
      7
    }
    if not table.intable(priorityY, teamPos.y) then
      rangeListY = {
        5,
        6,
        7
      }
      aloneBoard = 6
      rotateAngle = -90
    else
      rangeListY = {
        1,
        2,
        3
      }
      aloneBoard = 5
      rotateAngle = 90
    end
    result:SetRubikCubeTargetAngle(Vector3(0, 0, 90))
  else
    dir = Vector2(0, 1)
    boardList = {
      1,
      6,
      3,
      5
    }
    rangeListY = {
      1,
      2,
      3,
      4,
      5,
      6,
      7
    }
    local priorityX = {
      5,
      6,
      7
    }
    if not table.intable(priorityX, teamPos.x) then
      rangeListX = {
        5,
        6,
        7
      }
      aloneBoard = 2
      rotateAngle = -90
    else
      rangeListX = {
        1,
        2,
        3
      }
      aloneBoard = 4
      rotateAngle = 90
    end
    result:SetRubikCubeTargetAngle(Vector3(90, 0, 0))
  end
  result:SetAloneBoard(aloneBoard)
  radian = rotateAngle * math.pi / 180
  for i = 1, table.count(rangeListX) do
    local x = rangeListX[i]
    for j = 1, table.count(rangeListY) do
      local y = rangeListY[j]
      local posWork = Vector2(x, y)
      table.insert(posList, posWork)
    end
  end
  local aloneBoardPosList = {}
  for x = 1, 7 do
    for y = 1, 7 do
      local pos = Vector2(x, y)
      table.insert(aloneBoardPosList, pos)
    end
  end
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local boardMultiComponent = boardEntity:BoardMulti()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMultiServiceLogic = self._world:GetService("BoardMultiLogic")
  local utilData = self._world:GetService("UtilData")
  local rubikBoardList = {}
  for i, boardIndex in ipairs(boardList) do
    local rubikBoard = self:_CalcRubikBoard(boardList, i)
    table.insert(rubikBoardList, rubikBoard)
  end
  local rubikBoard = {}
  rubikBoard.fromBoard = aloneBoard
  rubikBoard.toBoard = aloneBoard
  table.insert(rubikBoardList, rubikBoard)
  
  local function filter(e)
    if (e:HasMonsterID() or e:HasTrapID()) and not e:HasDeadMark() then
      return true
    end
    local outsideRegion = e:OutsideRegion()
    if outsideRegion and outsideRegion:GetMonsterID() then
      return true
    end
    return false
  end
  
  local rubikList = {}
  local destroyTrap = {}
  for _, rubikBoard in ipairs(rubikBoardList) do
    local fromBoard = rubikBoard.fromBoard
    local toBoard = rubikBoard.toBoard
    local calcPosList = posList
    if fromBoard == toBoard then
      calcPosList = aloneBoardPosList
    end
    for _, pos in ipairs(calcPosList) do
      local oldPos = pos
      local newPos = pos
      if fromBoard == 6 and toBoard == 3 then
        newPos = self:_GetOppositeBoardPos(oldPos)
      elseif fromBoard == 3 and toBoard == 5 then
        oldPos = self:_GetOppositeBoardPos(newPos)
      end
      if fromBoard == toBoard then
        newPos = self:_GetAloneBoardAotatePos(oldPos, radian)
      end
      local oldPieceType = PieceType.None
      local newPieceType = PieceType.None
      local es = {}
      local isPieceEffect, prismEntityID, pieceEffectType
      if fromBoard == 1 then
        newPieceType = boardComponent:GetPieceType(oldPos)
        es = boardComponent:GetPieceEntities(oldPos, filter)
        isPieceEffect = boardComponent:IsSpecialPieceEffect(oldPos)
        pieceEffectType = boardComponent:GetBoardPieceEffectType(oldPos)
        prismEntityID = boardComponent:GetPrismEntityIDAtPos(oldPos)
      else
        newPieceType = boardMultiComponent:GetPieceType(oldPos, fromBoard)
        es = boardMultiComponent:GetPieceEntities(fromBoard, oldPos, filter)
        isPieceEffect = boardMultiComponent:IsSpecialPieceEffect(fromBoard, oldPos)
        pieceEffectType = boardMultiComponent:GetBoardPieceEffectType(fromBoard, oldPos)
      end
      if toBoard == 1 then
        oldPieceType = boardComponent:GetPieceType(newPos)
      else
        oldPieceType = boardMultiComponent:GetPieceType(newPos, toBoard)
      end
      if fromBoard == 1 then
        for _, e in ipairs(es) do
          local summonEntity = e:GetSummonerEntity()
          local summonIsPet = summonEntity and summonEntity:HasPet()
          local summonSuperEntity
          if summonEntity and summonEntity:GetSuperEntity() then
            summonSuperEntity = summonEntity:GetSuperEntity()
          end
          local summonSuperIsPet = summonEntity and summonSuperEntity and summonSuperEntity:HasPet()
          if e:HasTrapID() and (summonIsPet or summonSuperIsPet) then
            table.insert(destroyTrap, e)
          end
        end
      end
      local envIndex = #rubikList + 1
      rubikList[envIndex] = {
        index = envIndex,
        fromBoard = fromBoard,
        toBoard = toBoard,
        oldPos = oldPos,
        newPos = newPos,
        oldPieceType = oldPieceType,
        newPieceType = newPieceType,
        entityList = es,
        isPieceEffect = isPieceEffect,
        pieceEffectType = pieceEffectType,
        prismEntityID = prismEntityID
      }
    end
  end
  for _, rubikData in ipairs(rubikList) do
    local fromBoard = rubikData.fromBoard
    local oldPos = rubikData.oldPos
    local newPos = rubikData.newPos
    local entityList = rubikData.entityList
    local isPieceEffect = rubikData.isPieceEffect
    if fromBoard == 1 then
      if isPieceEffect then
        boardComponent:RemoveBoardPieceEffectType(oldPos)
      end
      for _, e in ipairs(entityList) do
        boardServiceLogic:RemoveEntityBlockFlag(e, oldPos)
      end
    else
      if isPieceEffect then
        boardMultiComponent:RemoveBoardPieceEffectType(fromBoard, oldPos)
      end
      for _, e in ipairs(entityList) do
        boardMultiServiceLogic:RemoveEntityBlockFlagMultiBoard(fromBoard, e, oldPos)
      end
    end
  end
  for _, rubikData in ipairs(rubikList) do
    local fromBoard = rubikData.fromBoard
    local toBoard = rubikData.toBoard
    local oldPos = rubikData.oldPos
    local newPos = rubikData.newPos
    local entityList = rubikData.entityList
    local isPieceEffect = rubikData.isPieceEffect
    local pieceEffectType = rubikData.pieceEffectType
    local prismEntityID = rubikData.prismEntityID
    local oldPieceType = rubikData.oldPieceType
    local newPieceType = rubikData.newPieceType
    result:AddRubikCubePiece(oldPos, newPos, fromBoard, toBoard)
    result:AddConvertColor(oldPos, newPos, oldPieceType, newPieceType, fromBoard, toBoard)
    if isPieceEffect then
      result:AddRubikCubePrism(oldPos, newPos, fromBoard, toBoard, pieceEffectType)
    end
    for _, e in ipairs(entityList) do
      result:AddRubikCubeEntity(e:GetID(), oldPos, newPos, fromBoard, toBoard)
    end
    if toBoard == 1 then
      boardServiceLogic:SetPieceTypeLogic(newPieceType, newPos)
      if isPieceEffect then
        boardComponent:SetBoardPieceEffectType(newPos, pieceEffectType, prismEntityID)
      end
    else
      boardMultiServiceLogic:SetPieceTypeLogic(toBoard, newPieceType, newPos)
      if isPieceEffect then
        boardMultiComponent:SetBoardPieceEffectType(toBoard, newPos, pieceEffectType, prismEntityID)
      end
    end
    for _, e in ipairs(entityList) do
      local e = e
      local outsideRegion = e:OutsideRegion()
      local blockFlag = boardServiceLogic:GetBlockFlag(e)
      local buffComponent = e:BuffComponent()
      if toBoard == 1 then
        boardServiceLogic:SetEntityBlockFlag(e, newPos, blockFlag)
        local monsterID = outsideRegion:GetMonsterID()
        if monsterID then
          e:ReplaceComponent(e:GetMonsterIDComponentEnum(), monsterID)
        end
        e:RemoveOutsideRegion()
        buffComponent:SetBuffValue("Freeze", nil)
      else
        boardMultiServiceLogic:SetEntityBlockFlagMultiBoard(toBoard, e, newPos, blockFlag)
        if not outsideRegion then
          e:AddOutsideRegion(toBoard)
          outsideRegion = e:OutsideRegion()
        end
        outsideRegion:SetBoardIndex(toBoard)
        buffComponent:SetBuffValue("Freeze", 1)
      end
      if newPos ~= oldPos then
        e:SetGridPosition(newPos)
      end
    end
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  for _, trapEntity in ipairs(destroyTrap) do
    local trapCmpt = trapEntity:Trap()
    trapEntity:Attributes():Modify("HP", 0)
    local disableDieSkill = true
    trapServiceLogic:AddTrapDeadMark(trapEntity, disableDieSkill)
    result:AddTrapDestroyList(trapEntity:GetID())
  end
  return result
end

function SkillEffectCalc_RubikCube:_CalcRubikBoard(boardList, i)
  local rubikBoard = {}
  rubikBoard.fromBoard = boardList[i]
  local toIndex = i + 1
  if toIndex > table.count(boardList) then
    toIndex = 1
  end
  rubikBoard.toBoard = boardList[toIndex]
  return rubikBoard
end

function SkillEffectCalc_RubikCube:_GetOppositeBoardPos(oldPos)
  local newPos = Vector2(8 - oldPos.x, 8 - oldPos.y)
  return newPos
end

function SkillEffectCalc_RubikCube:_GetAloneBoardAotatePos(oldPos, radian)
  local newX = (oldPos.x - self._centerPos.x) * math.cos(radian) - (oldPos.y - self._centerPos.y) * math.sin(radian) + self._centerPos.x
  local newY = (oldPos.y - self._centerPos.y) * math.cos(radian) + (oldPos.x - self._centerPos.x) * math.sin(radian) + self._centerPos.y
  return Vector2(math.floor(newX), math.floor(newY))
end
