require("auto_fight_service")

function AutoFightService:_BuildMoveEnv(teamEntity)
  self._env = {}
  local env = self._env
  local levelCfg = self._configService:GetLevelConfigData()
  env.UnlockPos = {}
  env.DimensionDoorPos = {}
  env.PrismPos = {}
  env.PrismEntityIDs = {}
  env.LockGridPos = {}
  env.MonsterPos = {}
  env.BossPos = {}
  env.MonsterDict = {}
  env.ChainSkillAttackOffset = {}
  env.ChainSkillAttackCount = {}
  env.LevelPolicy, env.LevelPolicyParam = levelCfg:GetAutoFightLevelPolicy()
  env.TeamEntity = teamEntity
  env.PlayerPos = teamEntity:GridLocation().Position
  env.Benumb = teamEntity:BuffComponent():HasFlag(BuffFlags.Benumb)
  env.Index2Pos = self:_CalcPosIndex()
  env.BoardPosCanAttack = {}
  env.BoardPosPieces = self:_CalcBoardPosPieceType()
  env.BoardPosCanMove = self:_CalcBoardPosCanMove()
  env.BoardPosEvalue = self:_CalcBoardPosEvalue()
  env.TrapPosEvalue = self:_CalcTrapPosEvalue()
  env.ElementBuffPos = self:_CalcMonsterElementBuffPos()
  env.PieceTypeMovePets = self:_CalcPieceMovePets()
  env.MapByPosition = self:_CalcMapByPosition()
  env.ConnectMap = self:_CalcConnectMap()
  env.HighConnectRateCutLen = self:_CalcHighConnectRateCutLen()
  env.ChainPaths = {}
  env.MVP = nil
  env.ThinkStartTime = 0
  self:_CalcMonsterPos()
end

function AutoFightService:_CalcPieceMovePets()
  local t = {}
  t[PieceType.Blue] = self:_CalcMoveEntities(PieceType.Blue)
  t[PieceType.Red] = self:_CalcMoveEntities(PieceType.Red)
  t[PieceType.Green] = self:_CalcMoveEntities(PieceType.Green)
  t[PieceType.Yellow] = self:_CalcMoveEntities(PieceType.Yellow)
  t[PieceType.Any] = self:_CalcMoveEntities(PieceType.Any)
  t[PieceType.None] = self:_CalcMoveEntities(PieceType.None)
  return t
end

function AutoFightService:_PosIndexAddOffset(posIdx, offset)
  return posIdx + offset[1] * 100 + offset[2]
end

function AutoFightService:_DiffPosIndex21(posIdx1, posIdx2)
  return {
    posIdx2 // 100 - posIdx1 // 100,
    posIdx2 % 100 - posIdx1 % 100
  }
end

function AutoFightService:_PosIndexDistance(posIdx1, posIdx2)
  return (posIdx1 // 100 - posIdx2 // 100) ^ 2 + (posIdx1 % 100 - posIdx2 % 100) ^ 2
end

function AutoFightService:_Pos2Index(pos)
  return pos.x * 100 + pos.y
end

function AutoFightService:_Index2Pos(index)
  local pos = self._env.Index2Pos[index]
  return pos
end

function AutoFightService:_Offset2Index(i, j)
  local t = {
    [1] = {
      6,
      7,
      8
    },
    [2] = {
      5,
      0,
      1
    },
    [3] = {
      4,
      3,
      2
    }
  }
  return t[i + 2][j + 2]
end

function AutoFightService:_CalcPosIndex()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  local boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  local posIndex = {}
  for x = 1, boardMaxX do
    for y = 1, boardMaxY do
      local pos = Vector2(x, y)
      local posIdx = self:_Pos2Index(pos)
      posIndex[posIdx] = pos
    end
  end
  return posIndex
end

function AutoFightService:_CalcBoardPosPieceType()
  local posColor = {}
  local pieces = self._world:GetBoardEntity():Board().Pieces
  for x, row in pairs(pieces) do
    for y, color in pairs(row) do
      local posIdx = x * 100 + y
      posColor[posIdx] = color
    end
  end
  local playerPosIdx = self:_Pos2Index(self._env.PlayerPos)
  posColor[playerPosIdx] = PieceType.Any
  return posColor
end

function AutoFightService:_CalcBoardPosCanMove()
  local posCanMove = {}
  local utilData = self._world:GetService("UtilData")
  local board = self._world:GetBoardEntity():Board()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  local boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  for x = 1, boardMaxX do
    for y = 1, boardMaxY do
      local posIdx = x * 100 + y
      local pos = self._env.Index2Pos[posIdx]
      if not utilData:IsPosBlockLinkLineForChain(pos) then
        if self._env.BoardPosPieces[posIdx] ~= PieceType.None then
          posCanMove[posIdx] = true
        end
        if board:IsPrismPiece(pos) then
          local eid = board:GetPrismEntityIDAtPos(pos)
          table.insert(self._env.PrismPos, posIdx)
          self._env.PrismEntityIDs[posIdx] = eid
        end
        
        local function filter(e)
          return e:Trap() and e:Trap():IsLockedGrid()
        end
        
        local es = board:GetPieceEntities(pos, filter)
        if 0 < #es then
          self._env.LockGridPos[posIdx] = 1
        end
      end
    end
  end
  return posCanMove
end

function AutoFightService:_CalcMonsterPos()
  local posCanMove = self._env.BoardPosCanMove
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local enemies = monsterGroup:GetEntities()
  if self._world:MatchType() == MatchType.MT_BlackFist then
    enemies[#enemies + 1] = self._env.TeamEntity:Team():GetEnemyTeamEntity()
  end
  for i, e in ipairs(enemies) do
    local center = e:GridLocation().Position
    local bodyArea = e:BodyArea():GetArea()
    for _, area in ipairs(bodyArea) do
      local posIdx = self:_Pos2Index(center + area)
      if e:HasBoss() then
        table.insert(self._env.BossPos, posIdx)
      else
        table.insert(self._env.MonsterPos, posIdx)
      end
      self._env.MonsterDict[posIdx] = e
    end
  end
end

function AutoFightService:_CalcMonsterElementBuffPos()
  local elementPos = {}
  local posCanMove = self._env.BoardPosCanMove
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local sFormula = self._world:GetService("Formula")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for i, e in ipairs(monsterGroup:GetEntities()) do
    if e:Attributes():GetAttribute("ElementReinforce") then
      local elementType = e:Element():GetPrimaryType()
      local flag1 = sFormula:GetRestrainFlag(PieceType.Blue, elementType)
      local flag2 = sFormula:GetRestrainFlag(PieceType.Red, elementType)
      local flag3 = sFormula:GetRestrainFlag(PieceType.Green, elementType)
      local flag4 = sFormula:GetRestrainFlag(PieceType.Yellow, elementType)
      local center = e:GridLocation().Position
      local area = e:BodyArea():GetArea()
      for _, v in ipairs(area) do
        local mpos = center + v
        local mposIdx = self:_Pos2Index(mpos)
        for _, off in ipairs(Offset4) do
          local posIdx = self:_PosIndexAddOffset(mposIdx, off)
          if posCanMove[posIdx] then
            elementPos[posIdx] = {
              [PieceType.Blue] = BattleConst.AutoFightElementBuffFlagAddPosValue[flag1],
              [PieceType.Red] = BattleConst.AutoFightElementBuffFlagAddPosValue[flag2],
              [PieceType.Green] = BattleConst.AutoFightElementBuffFlagAddPosValue[flag3],
              [PieceType.Yellow] = BattleConst.AutoFightElementBuffFlagAddPosValue[flag4]
            }
          end
        end
      end
    end
  end
  return elementPos
end

function AutoFightService:_CalcBoardPosEvalue()
  local posCanMove = self._env.BoardPosCanMove
  local posCanAttack = self._env.BoardPosCanAttack
  local configService = self._configService
  local trapCfg = configService:GetTrapConfigData()
  local posEValues = {}
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  local boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  for x = 1, boardMaxX do
    for y = 1, boardMaxY do
      local posIdx = x * 100 + y
      if posCanMove[posIdx] then
        posEValues[posIdx] = BattleConst.AutoFightNoAttackPosValue
      end
    end
  end
  local posVal = 0
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local enemies = monsterGroup:GetEntities()
  if self._world:MatchType() == MatchType.MT_BlackFist then
    enemies[#enemies + 1] = self._env.TeamEntity:Team():GetEnemyTeamEntity()
  end
  for i, e in ipairs(enemies) do
    if not e:BuffComponent():HasBuffEffect(BuffEffectType.AttackImmuned) then
      if self._env.LevelPolicy == LevelPosPolicy.KillMonster and e:HasMonsterID() and table.icontains(self._env.LevelPolicyParam.monsterIds, e:MonsterID():GetMonsterID()) then
        posVal = self._env.LevelPolicyParam.addValue
      end
      local center = e:GridLocation().Position
      local area = e:BodyArea():GetArea()
      for _, v in ipairs(area) do
        local mpos = center + v
        local mposIdx = self:_Pos2Index(mpos)
        for _, off in ipairs(Offset4) do
          local posIdx = self:_PosIndexAddOffset(mposIdx, off)
          if posCanMove[posIdx] then
            posEValues[posIdx] = posEValues[posIdx] + posVal
            posCanAttack[posIdx] = true
          end
        end
      end
    end
  end
  local group = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(group:GetEntities()) do
    local trapID = e:Trap():GetTrapID()
    local trapType = e:Trap():GetTrapType()
    local center = e:GridLocation().Position
    local area = e:BodyArea():GetArea()
    if self._env.LevelPolicy == LevelPosPolicy.ProtectTrap and trapType == TrapType.Protected then
      local posVal = self._env.LevelPolicyParam.addValue
      local surroundArea = self:_CalcSurroundPos(center, area, Ring2)
      local monsterSurroundArea = {}
      for _, e in ipairs(monsterGroup:GetEntities()) do
        local monsterGridPos = e:GridLocation().Position
        local areaArray = e:BodyArea():GetArea()
        for i = 1, #areaArray do
          local pos = areaArray[i] + monsterGridPos
          local posIdx = self:_Pos2Index(pos)
          if surroundArea[posIdx] == 1 then
            local monsterSurround = self:_CalcSurroundPos(monsterGridPos, areaArray, Offset8)
            table.append(monsterSurroundArea, monsterSurround)
            break
          end
        end
      end
      for posIdx, _ in pairs(monsterSurroundArea) do
        if posCanMove[posIdx] then
          posEValues[posIdx] = posEValues[posIdx] + posVal
        end
      end
    end
  end
  return posEValues
end

function AutoFightService:_CalcTrapPosEvalue()
  local posCanMove = self._env.BoardPosCanMove
  local configService = self._configService
  local trapCfg = configService:GetTrapConfigData()
  local teamEntityID = self._env.TeamEntity:GetID()
  local posEValues = {}
  local group = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(group:GetEntities()) do
    local cTrap = e:Trap()
    local trapID = cTrap:GetTrapID()
    local trapType = cTrap:GetTrapType()
    local posVal = trapCfg:GetTrapData(trapID).AutoFightAddPathValue or 0
    local center = e:GridLocation().Position
    local area = e:BodyArea():GetArea()
    local trapPosIdx = self:_Pos2Index(center)
    local isExitTrap = cTrap:IsExit() and trapType == TrapType.GroudTrigger
    if isExitTrap then
      self._env.ExitPos = center
      self._env.BoardPosPieces[trapPosIdx] = PieceType.Any
    end
    if trapID == 9990001 and cTrap:GetCurrentTriggerCount() == 0 then
      table.insert(self._env.UnlockPos, trapPosIdx)
      self._env.BoardPosPieces[trapPosIdx] = PieceType.Any
    end
    if cTrap:IsDimensionDoor() then
      self._env.DimensionDoorPos[trapPosIdx] = true
    end
    if posVal ~= 0 then
      local triggerTrap = self:_FindTriggeredTrap(e)
      if triggerTrap then
        local result, targetIds = self:_CalcSkillScopeResultAndTargets(triggerTrap.trapEntity, triggerTrap.skillId)
        if #targetIds == 0 then
          posVal = 0
        elseif table.icontains(targetIds, teamEntityID) then
          posVal = -posVal
        end
      end
      for _, v in ipairs(area) do
        local pos = center + v
        local posIdx = self:_Pos2Index(pos)
        if posCanMove[posIdx] then
          posEValues[posIdx] = (posEValues[posIdx] or 0) + posVal
        end
      end
    end
  end
  return posEValues
end

function AutoFightService:_FindTriggeredTrap(eTrap)
  local cTrap = eTrap:Trap()
  local maxTriggerCount = cTrap:GetTriggerMaxCount()
  if 0 < maxTriggerCount and maxTriggerCount <= cTrap:GetCurrentTriggerCount() then
    return
  end
  local traps = self._utilSvc:GetGroupTrap(eTrap)
  if traps and 0 < table.count(traps) then
    for _, e in ipairs(traps) do
      local cTriggeredTrap = e:Trap()
      local skillId = cTriggeredTrap:GetTriggerSkillID()
      if skillId then
        return {trapEntity = e, skillId = skillId}
      end
    end
  end
end

function AutoFightService:_CalcSurroundPos(center, area, ring)
  local surroundArea = {}
  for _, v in ipairs(area) do
    local pos = center + v
    local posIdx = self:_Pos2Index(pos)
    for _, off in ipairs(ring) do
      local sIdx = self:_PosIndexAddOffset(posIdx, off)
      surroundArea[sIdx] = 1
    end
  end
  return surroundArea
end

function AutoFightService:_DoPrismChange(prismPosIdx, prevPosIdx)
  local prismPos = self:_Index2Pos(prismPosIdx)
  local prevPos = self:_Index2Pos(prevPosIdx)
  local dir = prismPos - prevPos
  local prismPieceType = self._env.BoardPosPieces[prismPosIdx]
  local utilData = self._world:GetService("UtilData")
  local utilScope = self._world:GetService("UtilScopeCalc")
  local tTargetPieces = {}
  local prismEntityID = self._env.PrismEntityIDs[prismPosIdx]
  local scopeType, scopeParam = utilData:GetPrismCustomScopeConfig(prismEntityID)
  if scopeType then
    local calc = SkillScopeCalculator:New(utilScope)
    local result = calc:ComputeScopeRange(scopeType, scopeParam, prismPos, {
      Vector2.zero
    })
    local range = result:GetAttackRange() or {}
    for _, v2 in ipairs(range) do
      local tarPosIdx = self:_Pos2Index(v2)
      if tarPosIdx and self._env.ConnectMap[tarPosIdx] and not self._env.LockGridPos[tarPosIdx] then
        table.insert(tTargetPieces, {pos = v2, pieceType = prismPieceType})
      end
    end
  else
    for i = 1, BattleConst.PrismEffectPieceCount do
      local targetPos = prismPos + dir * i
      local tarPosIdx = self:_Pos2Index(targetPos)
      if tarPosIdx and self._env.ConnectMap[tarPosIdx] and not self._env.LockGridPos[tarPosIdx] then
        table.insert(tTargetPieces, {pos = targetPos, pieceType = prismPieceType})
      end
    end
  end
  for _, data in ipairs(tTargetPieces) do
    local posIndex = Vector2.Pos2Index(data.pos)
    self._env.BoardPosPieces[posIndex] = data.pieceType
    self:_DoRemoveMapPosIdx(posIndex)
    self:_DoAddMapPosIdx(posIndex, data.pieceType)
  end
end

function AutoFightService:_UndoPrismChange(prismPosIdx, prevPosIdx)
  local pieces = self._world:GetBoardEntity():Board().Pieces
  local prismPos = self:_Index2Pos(prismPosIdx)
  local prevPos = self:_Index2Pos(prevPosIdx)
  local dir = prismPos - prevPos
  local prismPieceType = self._env.BoardPosPieces[prismPosIdx]
  local utilData = self._world:GetService("UtilData")
  local utilScope = self._world:GetService("UtilScopeCalc")
  local tTargetPieces = {}
  local prismEntityID = self._env.PrismEntityIDs[prismPosIdx]
  local scopeType, scopeParam = utilData:GetPrismCustomScopeConfig(prismEntityID)
  if scopeType then
    local calc = SkillScopeCalculator:New(utilScope)
    local result = calc:ComputeScopeRange(scopeType, scopeParam, prismPos, {
      Vector2.zero
    })
    local range = result:GetAttackRange() or {}
    for _, v2 in ipairs(range) do
      local tarPosIdx = self:_Pos2Index(v2)
      if tarPosIdx and self._env.ConnectMap[tarPosIdx] and not self._env.LockGridPos[tarPosIdx] then
        local originalPieceType = pieces[v2.x][v2.y]
        table.insert(tTargetPieces, {pos = v2, pieceType = originalPieceType})
      end
    end
  else
    for i = 1, BattleConst.PrismEffectPieceCount do
      local targetPos = prismPos + dir * i
      local tarPosIdx = self:_Pos2Index(targetPos)
      if tarPosIdx and self._env.ConnectMap[tarPosIdx] and not self._env.LockGridPos[tarPosIdx] then
        local originalPieceType = pieces[targetPos.x][targetPos.y]
        table.insert(tTargetPieces, {pos = targetPos, pieceType = originalPieceType})
      end
    end
  end
  for _, data in ipairs(tTargetPieces) do
    local posIndex = Vector2.Pos2Index(data.pos)
    self._env.BoardPosPieces[posIndex] = data.pieceType
    self:_DoRemoveMapPosIdx(posIndex)
    self:_DoAddMapPosIdx(posIndex, data.pieceType)
  end
end

function AutoFightService:_DoRemoveMapPosIdx(posIdx)
  local connectMap = self._env.ConnectMap
  local ct = connectMap[posIdx]
  if ct == nil then
    return
  end
  for i = 1, 8 do
    local roundPosIdx = ct[i]
    if roundPosIdx then
      local oppDir = self:_CalcOppositeDir(i)
      connectMap[roundPosIdx][oppDir] = nil
    end
  end
  connectMap[posIdx] = nil
end

function AutoFightService:_DoAddMapPosIdx(posIndex, pieceType)
  local ct = {}
  self._env.ConnectMap[posIndex] = ct
  for _, offset in ipairs(Offset8) do
    local i, j = offset[1], offset[2]
    local surroundIndex = self:_PosIndexAddOffset(posIndex, offset)
    if self._env.BoardPosCanMove[surroundIndex] then
      local surroundPiece = self._env.BoardPosPieces[surroundIndex]
      if self:CanMatchPieceType(surroundPiece, pieceType) then
        local surround_ct = self._env.ConnectMap[surroundIndex]
        if surround_ct == nil then
          surround_ct = {}
          self._env.ConnectMap[surroundIndex] = surround_ct
        end
        local dir = self:_Offset2Index(i, j)
        ct[dir] = surroundIndex
        local oppDir = self:_CalcOppositeDir(dir)
        surround_ct[oppDir] = posIndex
      end
    end
  end
end

function AutoFightService:_CalcOppositeDir(dir)
  local r = (dir + 4) % 8
  if r == 0 then
    r = 8
  end
  return r
end

function AutoFightService:_CalcConnectMap()
  local connectMap = {}
  local playerPos = self._env.PlayerPos
  local playerPosIndex = self:_Pos2Index(playerPos)
  local isFirstStep = true
  self:_Search8(playerPosIndex, PieceType.Any, connectMap, isFirstStep)
  return connectMap
end

function AutoFightService:_Search8(posIndex, pieceType, connectMap, isFirstStep)
  if connectMap[posIndex] then
    return
  end
  local utilData = self._world:GetService("UtilData")
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local ct = {}
  connectMap[posIndex] = ct
  for _, offset in ipairs(Offset8) do
    local i, j = offset[1], offset[2]
    local surroundIndex = self:_PosIndexAddOffset(posIndex, offset)
    if self._env.BoardPosCanMove[surroundIndex] then
      local isBlockMoveWithTrapWall = utilData:IsPosBlockMoveForTrapWallPosIndex(posIndex, surroundIndex)
      if isBlockMoveWithTrapWall == false then
        local surroundPiece = self._env.BoardPosPieces[surroundIndex]
        if isFirstStep then
          local mapForFirstChainPath = utilData:GetMapForFirstChainPath()
          if mapForFirstChainPath then
            surroundPiece = mapForFirstChainPath
          end
        end
        if self:CanMatchPieceType(surroundPiece, pieceType) then
          if surroundPiece == PieceType.Any then
            surroundPiece = pieceType
          end
          ct[self:_Offset2Index(i, j)] = surroundIndex
          self:_Search8(surroundIndex, surroundPiece, connectMap)
        elseif table.count(self._env.MapByPosition) > 0 then
          local gridPieceTypeMapList = boardServiceLogic:GetPieceTypeMapListByPosIndex(surroundIndex)
          if table.intable(gridPieceTypeMapList, PieceType.Any) or table.intable(gridPieceTypeMapList, pieceType) then
            surroundPiece = pieceType
            ct[self:_Offset2Index(i, j)] = surroundIndex
            self:_Search8(surroundIndex, surroundPiece, connectMap)
          end
        end
      end
    end
  end
end

function AutoFightService:_CalcHighConnectRateCutLen()
  local connectMap = self._env.ConnectMap
  local playerPos = self._env.PlayerPos
  local playerPosIndex = self:_Pos2Index(playerPos)
  local touchIdx = {}
  local totalConnect = 0
  local totalPosNum = 0
  local search
  
  function search(posIndex)
    touchIdx[posIndex] = true
    totalPosNum = totalPosNum + 1
    local ct = connectMap[posIndex]
    for i = 1, 8 do
      local nextIdx = ct[i]
      if nextIdx then
        totalConnect = totalConnect + 1
        if not touchIdx[nextIdx] then
          search(nextIdx)
        end
      end
    end
  end
  
  search(playerPosIndex)
  local rate = totalConnect / totalPosNum
  local cutlen = 0
  local idx = BattleConst.AutoFightMoveEnhanced and 2 or 1
  if totalPosNum > BattleConst.AutoFightPathLengthCutPosNum and rate > BattleConst.AutoFightPathLengthCutConnectRate[idx] then
    cutlen = BattleConst.AutoFightPathLengthCut
  end
  Log.debug("[AutoFight] _CalcHighConnectRateCutLen() totalPosNum=", totalPosNum, " ConnectRate=", rate)
  return cutlen
end

function AutoFightService:_CalcMapByPosition()
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local mapByPosition = boardComponent:GetMapByPosition()
  return mapByPosition
end

function AutoFightService:GetAutoFightEnvironment()
  return self._env
end
