_class("SkillEffectCalc_SpliceBoard", Object)
SkillEffectCalc_SpliceBoard = SkillEffectCalc_SpliceBoard

function SkillEffectCalc_SpliceBoard:Constructor(world)
  self._world = world
end

function SkillEffectCalc_SpliceBoard:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local distance = skillEffectParam:GetDistance()
  local directionParam = skillEffectParam:GetDirection()
  local direction = Vector2(directionParam[1], directionParam[2])
  local notifyTrapList = skillEffectParam:GetNotifyTrapList()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local battleStatCmpt = self._world:BattleStat()
  local round = battleStatCmpt:GetLevelTotalRoundCount()
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local boardSpliceComponent = boardEntity:BoardSplice()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local utilDataSvc = self._world:GetService("UtilData")
  local utilScope = self._world:GetService("UtilScopeCalc")
  local boardGridPos = utilDataSvc:GetCloneBoardGridPos()
  local boardSpliceGridPos = utilDataSvc:GetCloneBoardSpliceGridPos()
  local result = SkillEffectResultSpliceBoard:New()
  if 0 < distance then
    local function filter(e)
      if (e:HasTeam() or e:HasMonsterID() or e:HasTrapID()) and not e:HasDeadMark() then
        return true
      end
      return false
    end
    
    local pieceTable = {}
    for _, pos in ipairs(boardSpliceGridPos) do
      if table.icontains(boardGridPos, pos) then
        table.removev(boardGridPos, pos)
      end
    end
    table.sort(boardGridPos, function(a, b)
      if direction.x == 1 then
        return a.x > b.x
      elseif direction.x == -1 then
        return a.x < b.x
      elseif direction.y == 1 then
        return a.y > b.y
      elseif direction.y == -1 then
        return a.y < b.y
      end
    end)
    for _, pos in ipairs(boardGridPos) do
      local entityList = boardComponent:GetPieceEntities(pos, filter)
      local posNew = pos + Vector2(direction.x * distance, direction.y * distance)
      for i, e in ipairs(entityList) do
        result:AddMoveEntity(e:GetID(), pos, posNew)
      end
      local isPieceEffect = boardComponent:IsSpecialPieceEffect(pos)
      local pieceEffectType = boardComponent:GetBoardPieceEffectType(pos)
      if isPieceEffect then
        result:AddSpliceBoardPrism(pos, posNew, pieceEffectType)
      end
      local isAddGrid = not utilDataSvc:IsValidPiecePos(posNew)
      local isRemoveGrid = false
      if direction.x ~= 0 then
        local data = utilScope:GetMinMaxGridXByGridY(pos.y)
        if data then
          local min = data.min
          local max = data.max
          if 0 < direction.x then
            isRemoveGrid = pos.x < min + 2
          else
            isRemoveGrid = pos.x > max - 2
          end
        end
      elseif direction.y ~= 0 then
        local data = utilScope:GetMinMaxGridYByGridX(pos.x)
        if data then
          local min = data.min
          local max = data.max
          if 0 < direction.y then
            isRemoveGrid = pos.y < min + 2
          else
            isRemoveGrid = pos.y > max - 2
          end
        end
      end
      local pieceType = boardComponent:GetPieceType(pos)
      if not pieceTable[posNew.x] then
        pieceTable[posNew.x] = {}
      end
      pieceTable[posNew.x][posNew.y] = {
        x = posNew.x,
        y = posNew.y,
        color = pieceType
      }
      result:AddConvertColor(pos, posNew, pieceType, isAddGrid, isRemoveGrid)
    end
    result:SetPieceTable(pieceTable)
  end
  result:SetMoveParam(distance, direction)
  local maxX = boardServiceLogic:GetCurBoardMaxX()
  local maxY = boardServiceLogic:GetCurBoardMaxY()
  local boardLineCount = 7
  local boardSpliceGridPosList = utilDataSvc:GetCloneBoardSpliceGridPos()
  local isAddGridPosList = {}
  local isRemoveGridPosList = {}
  for _, pos in ipairs(boardSpliceGridPosList) do
    local pieceType = boardSpliceComponent:GetPieceType(pos)
    local isPieceEffect = boardSpliceComponent:IsSpecialPieceEffect(pos)
    local pieceEffectType = boardSpliceComponent:GetBoardPieceEffectType(pos)
    local isAddGrid = false
    local isRemoveGrid = false
    if direction == Vector2(0, 0) then
      if pos.x <= boardLineCount + 1 and pos.y > 3 then
        isAddGrid = true
      end
    elseif direction == Vector2(1, 0) then
      if pos.x >= maxX - 2 and pos.y > 3 then
        isAddGrid = true
      end
      if pos.x <= 3 and pos.y > 3 then
        isRemoveGrid = true
      end
    elseif direction == Vector2(0, -1) then
      if pos.x > 3 and pos.y <= 3 then
        isAddGrid = true
      end
      if pos.x > 3 and pos.y >= maxY - 2 then
        isRemoveGrid = true
      end
    elseif direction == Vector2(-1, 0) then
      if pos.x <= 3 and pos.y < maxY - 2 then
        isAddGrid = true
      end
      if pos.x >= maxX - 2 and pos.y < maxY - 2 then
        isRemoveGrid = true
      end
    elseif direction == Vector2(0, 1) then
      if pos.x < maxX - 2 and pos.y >= maxY - 2 then
        isAddGrid = true
      end
      if pos.x < maxX - 2 and pos.y <= 3 then
        isRemoveGrid = true
      end
    end
    if isAddGrid then
      table.insert(isAddGridPosList, pos)
    end
    if isRemoveGrid then
      table.insert(isRemoveGridPosList, pos)
      pieceType = boardComponent:GetPieceType(pos)
      isPieceEffect = boardComponent:IsSpecialPieceEffect(pos)
      pieceEffectType = boardComponent:GetBoardPieceEffectType(pos)
    end
    if isAddGrid or isRemoveGrid then
      result:AddSpliceBoardGrid(pos, isAddGrid, isRemoveGrid, pieceType, isPieceEffect, pieceEffectType)
    end
    if distance == 0 and isAddGrid == false and isRemoveGrid == false then
      result:AddSpliceBoardOnlyPlayDark(pos)
    end
  end
  local destroyTrapList = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() then
      local pos = e:GetGridPosition()
      local trapCmp = e:Trap()
      local trapID = trapCmp:GetTrapID()
      if table.icontains(notifyTrapList, trapID) then
        if table.icontains(isRemoveGridPosList, pos) then
          result:SetNotifyStartTrapEntityID(e:GetID())
        end
        if table.icontains(isAddGridPosList, pos) then
          result:SetNotifyEndTrapEntityID(e:GetID())
        end
      end
      if table.icontains(isRemoveGridPosList, pos) and trapCmp:GetCanStayBoardSplice() ~= 1 then
        table.insert(destroyTrapList, e:GetID())
      end
    end
  end
  result:SetDestroyTrapList(destroyTrapList)
  return result
end
