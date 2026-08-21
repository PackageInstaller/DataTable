_class("UtilCalcServiceShare", BaseService)
UtilCalcServiceShare = UtilCalcServiceShare

function UtilCalcServiceShare:Constructor(world)
  self._world = world
end

BoardQuadrant = {
  Center = 0,
  RightTop = 1,
  RightBottom = 2,
  LeftBottom = 3,
  LeftTop = 4
}
_enum("BoardQuadrant", BoardQuadrant)

function UtilCalcServiceShare:GetPosQuadrant(center, pos)
  if center == pos then
    return BoardQuadrant.Center
  end
  local relative = pos - center
  if relative.x >= 0 and 0 <= relative.y then
    return BoardQuadrant.RightTop
  elseif relative.x >= 0 and 0 >= relative.y then
    return BoardQuadrant.RightBottom
  elseif relative.x <= 0 and 0 >= relative.y then
    return BoardQuadrant.LeftBottom
  elseif relative.x <= 0 and 0 <= relative.y then
    return BoardQuadrant.LeftTop
  end
end

function UtilCalcServiceShare:DivideGridsByQuadrant(grids, center)
  center = center or Vector2.New(0, 0)
  local rightTop = {}
  local rightBottom = {}
  local leftBottom = {}
  local leftTop = {}
  for i = 1, #grids do
    local absGridPos = grids[i]
    local gridPos = absGridPos - center
    if gridPos.x == 0 and gridPos.y == 0 then
    else
      local quadrant = self:GetPosQuadrant(center, grids[i])
      if quadrant == BoardQuadrant.RightTop then
        table.insert(rightTop, absGridPos)
      elseif quadrant == BoardQuadrant.RightBottom then
        table.insert(rightBottom, absGridPos)
      elseif quadrant == BoardQuadrant.LeftBottom then
        table.insert(leftBottom, absGridPos)
      elseif quadrant == BoardQuadrant.LeftTop then
        table.insert(leftTop, absGridPos)
      end
    end
  end
  return rightTop, rightBottom, leftBottom, leftTop
end

function UtilCalcServiceShare:GetGridRingNum(grid, center, bodyArea)
  local nearest = grid
  local relative = nearest - center
  return math.max(math.abs(relative.x), math.abs(relative.y))
end

function UtilCalcServiceShare:GetGridRingNumWithBodyArea(grid, center, bodyArea)
  local nearest = grid
  local nearestRelative = Vector2(0, 0)
  local distance = Vector2.Distance(grid, center)
  local minDis = distance
  for _, v2Relative in ipairs(bodyArea) do
    local v2 = grid + v2Relative
    local curDis = Vector2.Distance(v2, center)
    if minDis > curDis then
      minDis = curDis
      nearest = v2
      nearestRelative = v2Relative
    end
  end
  local relative = nearest - center
  return math.max(math.abs(relative.x), math.abs(relative.y)), nearest, nearestRelative
end

function UtilCalcServiceShare:GetGridsByRing(gridList, center, ringNum)
  local resultArray = {}
  for i = 1, #gridList do
    local gridPos = gridList[i]
    local gridRing = self:GetGridRingNum(gridPos, center)
    if ringNum >= gridRing then
      table.insert(resultArray, gridPos)
    end
  end
  return resultArray
end

function UtilCalcServiceShare:GetFirstObstacleInPath(path, additionalObstaclePosArray, isAbyssAllow, isPlayerPosAllow, blockFlag, entity)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local playerEntity = self._world:Player():GetCurrentTeamEntity()
  local playerPos = playerEntity:GetGridPosition()
  local boardComponent = self._world:GetBoardEntity():Board()
  local utilData = self._world:GetService("UtilData")
  local areaArray = {}
  if entity and entity:HasBodyArea() then
    areaArray = entity:BodyArea():GetArea()
  end
  for i = 1, #path do
    local pathPos = path[i]
    local targetPosList = {}
    if 0 < #areaArray then
      for _, p in ipairs(areaArray) do
        table.insert(targetPosList, Vector2(pathPos.x + p.x, pathPos.y + p.y))
      end
    else
      table.insert(targetPosList, Vector2(pathPos.x, pathPos.y))
    end
    for _, gridPos in ipairs(targetPosList) do
      if not utilData:IsValidPiecePos(gridPos) then
        return gridPos, i
      end
      if blockFlag and utilData:IsPosBlock(gridPos, blockFlag) then
        local blockData = utilData:FindBlockByPos(gridPos)
        local trapBlockVal = 0
        for entityID, blockVal in pairs(blockData.m_listBlock) do
          local blockEntity = self._world:GetEntityByID(entityID)
          if not blockEntity then
            Log.error("not find block entity !!! entityID=", entityID)
          elseif (not entity:HasMonsterID() or not blockEntity:HasMonsterID()) and (not (entity:HasPetPstID() or entity:HasTeam()) or not blockEntity:HasPetPstID() and not blockEntity:HasTeam()) then
            trapBlockVal = trapBlockVal | blockVal
          end
        end
        if trapBlockVal & blockFlag ~= 0 then
          return gridPos, i
        end
      end
      if not isAbyssAllow and boardComponent:GetPieceType(gridPos) == PieceType.None and utilData:IsPosBlock(gridPos, BlockFlag.LinkLine) then
        return gridPos, i
      end
      if not isPlayerPosAllow and gridPos == playerPos then
        return gridPos, i
      end
      if additionalObstaclePosArray and table.icontains(additionalObstaclePosArray, gridPos) then
        return gridPos, i
      end
    end
  end
end

function UtilCalcServiceShare:FindPieceElementByTypeCountAndCenter(centerPos, pieceTypeList, maxCount, bound, boundInNum, excludeTrap, excludePosList, canPlayerMove)
  if type(pieceTypeList) ~= "table" then
    pieceTypeList = {pieceTypeList}
  end
  local boardService = self._world:GetService("BoardLogic")
  local boardEntity = self._world:GetBoardEntity()
  local board = boardEntity:Board()
  local pieceList = {}
  
  local function IsTrapOnPos(pos)
    local sUtilData = self._world:GetService("UtilData")
    local traps = sUtilData:GetTrapsAtPos(pos)
    for _, trap in ipairs(traps) do
      if table.icontains(excludeTrap, trap:Trap():GetTrapID()) then
        return true
      end
    end
    return false
  end
  
  local function IsExcludePos(pos)
    if table.icontains(excludePosList, pos) then
      return true
    end
    return false
  end
  
  local sUtilData = self._world:GetService("UtilData")
  
  local function canPlayerMoveFunc(pos)
    if not canPlayerMove then
      return true
    end
    return not sUtilData:IsPosBlock(pos, BlockFlag.LinkLine)
  end
  
  if bound then
    for x = bound.xMin, bound.xMax do
      for y = bound.yMin, bound.yMax do
        if boundInNum == 0 then
          if board.Pieces[x] and board.Pieces[x][y] and table.icontains(pieceTypeList, board.Pieces[x][y]) then
            table.insert(pieceList, Vector2(x, y))
          end
        elseif x >= centerPos.x - boundInNum and x <= centerPos.x + boundInNum and y >= centerPos.y - boundInNum and y <= centerPos.y + boundInNum then
        elseif board.Pieces[x] and board.Pieces[x][y] and table.icontains(pieceTypeList, board.Pieces[x][y]) then
          table.insert(pieceList, Vector2(x, y))
        end
      end
    end
  else
    local area = boardService.PlayerArea
    for x = area.minX, area.maxX do
      for y = area.minY, area.maxY do
        local pos = Vector2(x, y)
        if board.Pieces[x] and board.Pieces[x][y] and table.icontains(pieceTypeList, board.Pieces[x][y]) and not IsTrapOnPos(pos) and not IsExcludePos(pos) and canPlayerMoveFunc(pos) then
          table.insert(pieceList, pos)
        end
      end
    end
  end
  HelperProxy:SortPosByCenterPosDistance(centerPos, pieceList)
  for i = maxCount + 1, #pieceList do
    pieceList[i] = nil
  end
  return pieceList
end

function UtilCalcServiceShare:FindPieceElementByTypeAndArea(areaGridList, pieceTypeList, excludeTrap)
  if type(pieceTypeList) ~= "table" then
    pieceTypeList = {pieceTypeList}
  end
  
  local function IsTrapOnPos(pos)
    local sUtilData = self._world:GetService("UtilData")
    local traps = sUtilData:GetTrapsAtPos(pos)
    for _, trap in ipairs(traps) do
      if table.icontains(excludeTrap, trap:Trap():GetTrapID()) then
        return true
      end
    end
    return false
  end
  
  local boardService = self._world:GetService("BoardLogic")
  local boardEntity = self._world:GetBoardEntity()
  local board = boardEntity:Board()
  local pieceList = {}
  if areaGridList then
    for _, gridPos in ipairs(areaGridList) do
      if board.Pieces[gridPos.x] and board.Pieces[gridPos.x][gridPos.y] and table.icontains(pieceTypeList, board.Pieces[gridPos.x][gridPos.y]) and not IsTrapOnPos(gridPos) then
        table.insert(pieceList, gridPos)
      end
    end
  end
  return pieceList
end

function UtilCalcServiceShare:GetFrontPieces(e)
  local gridLocation = e:GridLocation()
  local center = gridLocation:Center()
  local direction = gridLocation.Direction
  local area = e:BodyArea():GetArea()
  if #area == 1 then
    return center + direction
  else
    local arr = {}
    local pos = center + direction * 1.5
    if direction.x < 0 then
      table.insert(arr, pos + Vector2(0, -0.5))
      table.insert(arr, pos + Vector2(0, 0.5))
    elseif direction.x > 0 then
      table.insert(arr, pos + Vector2(0, 0.5))
      table.insert(arr, pos + Vector2(0, -0.5))
    end
    if 0 > direction.y then
      table.insert(arr, pos + Vector2(0.5, 0))
      table.insert(arr, pos + Vector2(-0.5, 0))
    elseif 0 < direction.y then
      table.insert(arr, pos + Vector2(-0.5, 0))
      table.insert(arr, pos + Vector2(0.5, 0))
    end
    return arr
  end
end

function UtilCalcServiceShare:_CalCanUseHitBackDir(defenderEntity, distance)
  local defenderPos = defenderEntity:GridLocation().Position
  for i = 0, 5 do
    local targetPos = defenderPos + Vector2(0, distance + i)
    if self:CanHitBackToPos(defenderEntity, targetPos) then
      return Vector2(0, 1), distance + i
    end
    targetPos = defenderPos + Vector2(distance + i, 0)
    if self:CanHitBackToPos(defenderEntity, targetPos) then
      return Vector2(1, 0), distance + i
    end
    targetPos = defenderPos + Vector2(0, -distance - i)
    if self:CanHitBackToPos(defenderEntity, targetPos) then
      return Vector2(0, -1), distance + i
    end
    targetPos = defenderPos + Vector2(-distance - i, 0)
    if self:CanHitBackToPos(defenderEntity, targetPos) then
      return Vector2(-1, 0), distance + i
    end
  end
  return Vector2(0, 0), 0
end

function UtilCalcServiceShare:_CalSelectSquareRingFarest(defenderEntity, casterEntity)
  local defenderPos = defenderEntity:GridLocation().Position
  local casterPos = casterEntity:GridLocation().Position
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Teleport)
  if resultArray and table.count(resultArray) > 0 then
    casterPos = resultArray[1]:GetPosOld()
  end
  local bodyArea = defenderEntity:BodyArea():GetArea()
  local attackRange = ComputeScopeRange.ComputeRange_SquareRing(defenderPos, #bodyArea, 1)
  if table.count(attackRange) > 0 then
    table.sort(attackRange, function(a, b)
      local disA = Vector2.Distance(casterPos, a)
      local disB = Vector2.Distance(casterPos, b)
      return disA > disB
    end)
    for _, pos in ipairs(attackRange) do
      if self:CanHitBackToPos(defenderEntity, pos) then
        local dir = pos - defenderPos
        return dir
      end
    end
  end
  return Vector2(0, 0)
end

function UtilCalcServiceShare:CanHitBackToPos(defenderEntity, pos)
  local defenderLocation = defenderEntity:GridLocation()
  local bodyArea = defenderEntity:BodyArea():GetArea()
  local targetPosList = {}
  for _, p in ipairs(bodyArea) do
    table.insert(targetPosList, Vector2(pos.x + p.x, pos.y + p.y))
  end
  local useCheckBlockFlag = BlockFlag.HitBack
  if defenderEntity:HasMonsterID() then
    local raceType = defenderEntity:MonsterID():GetMonsterRaceType()
    if MonsterRaceType.Fly == raceType then
      useCheckBlockFlag = BlockFlag.HitBackFly
    end
  end
  local utilData = self._world:GetService("UtilData")
  for _, p in ipairs(targetPosList) do
    if utilData:IsPosBlock(p, useCheckBlockFlag) or utilData:IsPosBlockWithEntityRace(p, useCheckBlockFlag, defenderEntity) then
      return false
    end
  end
  return true
end

function UtilCalcServiceShare:_CalcHitBack2SpecifyXCoordinate(defenderEntity, xCoordinate)
  local defenderLocation = defenderEntity:GetGridPosition()
  local newPos = Vector2(xCoordinate, defenderLocation.y)
  if not self:CanHitBackToPos(defenderEntity, newPos) then
    newPos = defenderLocation:Clone()
  end
  local dir = Vector2.Normalize(newPos - defenderLocation)
  local distance = math.abs(defenderLocation.x - xCoordinate)
  return dir, distance
end

function UtilCalcServiceShare:_CalcHitBackDir(dirType, attackerPos, defenderPos, attackerBodyArea, defenderBodyArea)
  local dir
  if dirType == HitBackDirectionType.Up then
    dir = Vector2.up
  elseif dirType == HitBackDirectionType.Right then
    dir = Vector2.right
  elseif dirType == HitBackDirectionType.Down then
    dir = Vector2.down
  elseif dirType == HitBackDirectionType.Left then
    dir = Vector2.left
  elseif dirType == HitBackDirectionType.UpDown then
    if attackerPos.y > defenderPos.y then
      dir = Vector2.down
    else
      dir = Vector2.up
    end
  elseif dirType == HitBackDirectionType.LeftRight then
    if attackerPos.x > defenderPos.x then
      dir = Vector2.left
    else
      dir = Vector2.right
    end
  elseif dirType == HitBackDirectionType.EightDir then
    if attackerBodyArea:GetAreaCount() == 1 then
      local posDir = defenderPos - attackerPos
      local victimAreaCount = defenderBodyArea:GetAreaCount()
      if victimAreaCount == 1 then
        dir = Vector2(lmathext.sign(posDir.x), lmathext.sign(posDir.y))
      else
        dir = self:_CalcMultiAreaVictimHitbackDir(attackerPos, defenderPos, attackerBodyArea, defenderBodyArea)
      end
    else
      local bodyArea = attackerBodyArea:GetArea()
      local x, y = defenderPos.x - (attackerPos.x + bodyArea[1].x), defenderPos.y - (attackerPos.y + bodyArea[1].y)
      for i = 1, #bodyArea do
        if defenderPos.x == attackerPos.x + bodyArea[i].x then
          x = 0
        end
        if defenderPos.y == attackerPos.y + bodyArea[i].y then
          y = 0
        end
      end
      dir = Vector2(lmathext.sign(x), lmathext.sign(y))
    end
  elseif dirType == HitBackDirectionType.RightUp then
    dir = Vector2(1, 1)
  elseif dirType == HitBackDirectionType.RightDown then
    dir = Vector2(1, -1)
  elseif dirType == HitBackDirectionType.LeftUp then
    dir = Vector2(-1, 1)
  elseif dirType == HitBackDirectionType.LeftDown then
    dir = Vector2(-1, -1)
  elseif dirType == HitBackDirectionType.AntiEightDir then
    if attackerBodyArea:GetAreaCount() == 1 then
      local posDir = defenderPos - attackerPos
      local victimAreaCount = defenderBodyArea:GetAreaCount()
      if victimAreaCount == 1 then
        dir = Vector2(lmathext.sign(posDir.x), lmathext.sign(posDir.y))
      else
        dir = self:_CalcMultiAreaVictimHitbackDir(attackerPos, defenderPos, attackerBodyArea, defenderBodyArea)
      end
    else
      local bodyArea = attackerBodyArea:GetArea()
      local x, y = defenderPos.x - (attackerPos.x + bodyArea[1].x), defenderPos.y - (attackerPos.y + bodyArea[1].y)
      for i = 1, #bodyArea do
        if defenderPos.x == attackerPos.x + bodyArea[i].x then
          x = 0
        end
        if defenderPos.y == attackerPos.y + bodyArea[i].y then
          y = 0
        end
      end
      dir = Vector2(lmathext.sign(x), lmathext.sign(y))
    end
  end
  return dir
end

function UtilCalcServiceShare:_CalcMultiAreaVictimHitbackDir(attackerPos, defenderPos, attackerBodyArea, defenderBodyArea)
  local targetDirArray = {
    Vector2(0, 1),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(-1, 0)
  }
  for _, targetDir in ipairs(targetDirArray) do
    local isMatch = self:_IsMultiAreaVictimInDir(attackerPos, defenderPos, defenderBodyArea, targetDir)
    if isMatch == true then
      return targetDir
    end
  end
  targetDirArray = {
    Vector2(1, 1),
    Vector2(1, -1),
    Vector2(-1, -1),
    Vector2(-1, 1)
  }
  for _, targetDir in ipairs(targetDirArray) do
    local isMatch = self:_IsMultiAreaVictimInDir(attackerPos, defenderPos, defenderBodyArea, targetDir)
    if isMatch == true then
      return targetDir
    end
  end
  return nil
end

function UtilCalcServiceShare:_IsMultiAreaVictimInDir(attackerPos, defenderPos, defenderBodyArea, targetDir)
  local area = defenderBodyArea:GetArea()
  for _, v in ipairs(area) do
    local curAreaGridPos = defenderPos + v
    local curAreaGridDir = curAreaGridPos - attackerPos
    if curAreaGridDir.x > 0 then
      curAreaGridDir.x = 1
    elseif curAreaGridDir.x < 0 then
      curAreaGridDir.x = -1
    end
    if 0 < curAreaGridDir.y then
      curAreaGridDir.y = 1
    elseif 0 > curAreaGridDir.y then
      curAreaGridDir.y = -1
    end
    if curAreaGridDir == targetDir then
      return true
    end
  end
  return false
end

function UtilCalcServiceShare:GetChainDamageRateAtIndex(chainPath, index)
  local utilSvc = self._world:GetService("UtilData")
  local chainRate = 0
  local superGrid = 0
  local poorGrid = 0
  for i = 2, math.min(index, #chainPath) do
    chainRate = chainRate + 1
    local traps = utilSvc:GetTrapsAtPos(chainPath[i])
    for ii = 1, #traps do
      if not traps[ii]:HasDeadMark() then
        local e = traps[ii]
        local trapComponent = traps[ii]:Trap()
        if trapComponent:IsBrokenGrid() then
          chainRate = chainRate - 1
        end
        if trapComponent:IsSuperGrid() and not e:HasDeadMark() then
          superGrid = superGrid + 1
        end
        if trapComponent:IsPoorGrid() and not e:HasDeadMark() then
          poorGrid = poorGrid + 1
        end
      end
    end
  end
  local affixService = self._world:GetService("Affix")
  if affixService:HasAddChainPathNum() then
    chainRate = affixService:ProcessAddChainPathNum(chainRate)
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local buffCmpt = teamEntity:BuffComponent()
  local fixChainRate = buffCmpt:GetBuffValue("ChainRate")
  if fixChainRate then
    chainRate = math.floor(chainRate * fixChainRate)
  end
  return chainRate, superGrid, poorGrid
end

function UtilCalcServiceShare:DamageInfoSplitMultiStage(damageInfo, stageCount, random, randomPercent)
  local damageInfoNewList = {}
  local damageStageValueList = {}
  local damageType = damageInfo:GetDamageType()
  local attackerEntityId = damageInfo:GetAttackerEntityID()
  local targetEntityId = damageInfo:GetTargetEntityID()
  local isHpShieldGuard = damageInfo:IsHPShieldGuard()
  local hpShield = damageInfo:GetHPShield()
  local singlePet = damageInfo:GetSinglePet()
  local showPosition = damageInfo:GetShowPosition()
  local elementType = damageInfo:GetElementType()
  local showType = damageInfo:GetShowType()
  local damageValue = damageInfo:GetDamageValue()
  local changeHP = damageInfo:GetDamageValue()
  local mazeDamageList = damageInfo:GetMazeDamageList()
  local dropAssetList = damageInfo:GetDropAssetList()
  local isTriggerHPLock = damageInfo:IsTriggerHPLock()
  local isTriggerSecKill = damageInfo:IsTriggerSecKill()
  local beHitRefreshBuff = damageInfo:GetBeHitRefreshBuff()
  local playBuffResult = damageInfo:GetPlayBuffResult()
  local comboCount = damageInfo:GetComboCount()
  local shieldLayer = damageInfo:GetShieldLayer()
  local changeHPEach = math.floor(changeHP / stageCount)
  local changeHPList = {}
  local changeHPremain = changeHP
  for i = 1, stageCount - 1 do
    local changeHpNew = changeHPEach
    if random == 1 then
      local randomHp = math.floor(changeHPEach * math.random(-randomPercent, randomPercent) / 100)
      changeHpNew = changeHpNew + randomHp
    end
    if changeHPremain < changeHpNew then
      changeHpNew = changeHPremain
    end
    changeHPremain = changeHPremain - changeHpNew
    table.insert(changeHPList, changeHpNew)
    local showDamage = math.abs(changeHP - changeHPremain)
    if showDamage < 1 then
      showDamage = 1
    end
    table.insert(damageStageValueList, showDamage)
  end
  table.insert(changeHPList, changeHPremain)
  table.insert(damageStageValueList, damageInfo:GetDamageValue())
  damageInfoNewList = {}
  table.insert(damageInfoNewList, damageInfo)
  return damageInfoNewList, damageStageValueList
end

function UtilCalcServiceShare:GetHitBackPlayerFarthestPos(casterPosList, casterEntity, hitBackType, teamEntity)
  if table.count(casterPosList) == 1 then
    return casterPosList[1]
  end
  local skillEffectService = self._world:GetService("SkillEffectCalc")
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local sortHitBackDistanceList = {}
  local playerPos = teamEntity:GetGridPosition()
  local bodyAreaCmpt = casterEntity:BodyArea()
  local defenderBodyAreaCmpt = teamEntity:BodyArea()
  local boardSvc = self._world:GetService("BoardLogic")
  local maxLen = boardSvc:GetCurBoardMaxLen()
  local casterPos = casterEntity:GetGridPosition()
  local bodyArea, blockFlag = boardSvc:RemoveEntityBlockFlag(casterEntity, casterPos)
  for i, attackerPos in ipairs(casterPosList) do
    local dir = utilCalcSvc:_CalcHitBackDir(hitBackType, attackerPos, playerPos, bodyAreaCmpt, defenderBodyAreaCmpt)
    local targetPos = skillEffectService:CalHitbackPosByEntityDir(playerPos, defenderBodyAreaCmpt, dir, maxLen, {}, nil, teamEntity)
    table.insert(sortHitBackDistanceList, {
      dis = Vector2.Distance(targetPos, attackerPos),
      pos = attackerPos
    })
  end
  boardSvc:SetEntityBlockFlag(casterEntity, casterPos, blockFlag)
  boardSvc:RemoveEntityBlockFlag(casterEntity, casterPos)
  table.sort(sortHitBackDistanceList, function(a, b)
    return a.dis > b.dis
  end)
  return sortHitBackDistanceList[1].pos
end

function UtilCalcServiceShare:CalcBattleResult(matchType, victory)
  local battleService = self._world:GetService("Battle")
  return battleService:CalcBattleResultLogic(matchType, victory)
end

function UtilCalcServiceShare:GetDirAndGetDistance(dirType, distance, i)
  if dirType == HitBackDirectionType.Up then
    return Vector2(0, 1), Vector2(0, distance + i)
  end
  if dirType == HitBackDirectionType.LeftUp then
    return Vector2(-1, 1), Vector2(-distance - i, distance + i)
  end
  if dirType == HitBackDirectionType.RightUp then
    return Vector2(1, 1), Vector2(distance + i, distance + i)
  end
  if dirType == HitBackDirectionType.Left then
    return Vector2(-1, 0), Vector2(-distance - i, 0)
  end
  if dirType == HitBackDirectionType.Right then
    return Vector2(1, 0), Vector2(distance + i, 0)
  end
  if dirType == HitBackDirectionType.LeftDown then
    return Vector2(-1, -1), Vector2(-distance - i, -distance - i)
  end
  if dirType == HitBackDirectionType.RightDown then
    return Vector2(1, -1), Vector2(distance + i, -distance - i)
  end
  if dirType == HitBackDirectionType.Down then
    return Vector2(0, -1), Vector2(0, -distance - i)
  end
end

function UtilCalcServiceShare:_VectorDirToHitBackEnum(dirVector)
  if dirVector == Vector2(0, 1) then
    return HitBackDirectionType.Up
  end
  if dirVector == Vector2(0, -1) then
    return HitBackDirectionType.Down
  end
  if dirVector == Vector2(-1, 0) then
    return HitBackDirectionType.Left
  end
  if dirVector == Vector2(1, 0) then
    return HitBackDirectionType.Right
  end
  if dirVector == Vector2(1, 1) then
    return HitBackDirectionType.RightUp
  end
  if dirVector == Vector2(-1, 1) then
    return HitBackDirectionType.LeftUp
  end
  if dirVector == Vector2(-1, -1) then
    return HitBackDirectionType.LeftDown
  end
  if dirVector == Vector2(1, -1) then
    return HitBackDirectionType.RightDown
  end
  return HitBackDirectionType.None
end

function UtilCalcServiceShare:_CalCanUseHitBackDir8(attackDir, defenderEntity, distance)
  local List = {}
  List[HitBackDirectionType.Up] = {
    HitBackDirectionType.Up,
    HitBackDirectionType.LeftUp,
    HitBackDirectionType.RightUp,
    HitBackDirectionType.Left,
    HitBackDirectionType.Right,
    HitBackDirectionType.LeftDown,
    HitBackDirectionType.RightDown,
    HitBackDirectionType.Down
  }
  List[HitBackDirectionType.Down] = {
    HitBackDirectionType.Down,
    HitBackDirectionType.RightDown,
    HitBackDirectionType.LeftDown,
    HitBackDirectionType.Right,
    HitBackDirectionType.Left,
    HitBackDirectionType.RightUp,
    HitBackDirectionType.LeftUp,
    HitBackDirectionType.Up
  }
  List[HitBackDirectionType.Left] = {
    HitBackDirectionType.Left,
    HitBackDirectionType.LeftDown,
    HitBackDirectionType.LeftUp,
    HitBackDirectionType.Down,
    HitBackDirectionType.Up,
    HitBackDirectionType.RightDown,
    HitBackDirectionType.RightUp,
    HitBackDirectionType.Right
  }
  List[HitBackDirectionType.Right] = {
    HitBackDirectionType.Right,
    HitBackDirectionType.RightUp,
    HitBackDirectionType.RightDown,
    HitBackDirectionType.Up,
    HitBackDirectionType.Down,
    HitBackDirectionType.LeftUp,
    HitBackDirectionType.LeftDown,
    HitBackDirectionType.Left
  }
  local defenderPos = defenderEntity:GridLocation().Position
  local dirEnum = self:_VectorDirToHitBackEnum(attackDir)
  if not List[dirEnum] then
    return Vector2(0, 0), 0
  end
  for i = 0, 5 do
    for index, v in ipairs(List[dirEnum]) do
      local dir, add = self:GetDirAndGetDistance(v, distance, i)
      local targetPos = defenderPos + add
      if self:CanHitBackToPos(defenderEntity, targetPos) then
        Log.debug("Attack Dir:", tostring(attackDir), "HitBack Dir:", tostring(dir), " Index:", index)
        return dir, distance + i
      end
    end
  end
  return Vector2(0, 0), 0
end

function UtilCalcServiceShare:CalSelectCanUseDirAndDis(attackDir, defenderEntity, distance)
  local tempDir = HitBackDirectionTypeHelper.NormalizeDirType(attackDir)
  if tempDir == Vector2.zero then
    Log.error("Attack Dir:", tostring(attackDir), " Normalize Dir:", tostring(tempDir), " Invalid")
    tempDir = Vector2.down
  end
  local List = {}
  List[HitBackDirectionType.Up] = {
    HitBackDirectionType.Up,
    HitBackDirectionType.LeftUp,
    HitBackDirectionType.RightUp,
    HitBackDirectionType.Left,
    HitBackDirectionType.Right,
    HitBackDirectionType.LeftDown,
    HitBackDirectionType.RightDown,
    HitBackDirectionType.Down
  }
  List[HitBackDirectionType.Down] = {
    HitBackDirectionType.Down,
    HitBackDirectionType.RightDown,
    HitBackDirectionType.LeftDown,
    HitBackDirectionType.Right,
    HitBackDirectionType.Left,
    HitBackDirectionType.RightUp,
    HitBackDirectionType.LeftUp,
    HitBackDirectionType.Up
  }
  List[HitBackDirectionType.Left] = {
    HitBackDirectionType.Left,
    HitBackDirectionType.LeftDown,
    HitBackDirectionType.LeftUp,
    HitBackDirectionType.Down,
    HitBackDirectionType.Up,
    HitBackDirectionType.RightDown,
    HitBackDirectionType.RightUp,
    HitBackDirectionType.Right
  }
  List[HitBackDirectionType.Right] = {
    HitBackDirectionType.Right,
    HitBackDirectionType.RightUp,
    HitBackDirectionType.RightDown,
    HitBackDirectionType.Up,
    HitBackDirectionType.Down,
    HitBackDirectionType.LeftUp,
    HitBackDirectionType.LeftDown,
    HitBackDirectionType.Left
  }
  List[HitBackDirectionType.LeftUp] = {
    HitBackDirectionType.LeftUp,
    HitBackDirectionType.Left,
    HitBackDirectionType.Up,
    HitBackDirectionType.LeftDown,
    HitBackDirectionType.RightUp,
    HitBackDirectionType.Down,
    HitBackDirectionType.Right,
    HitBackDirectionType.RightDown
  }
  List[HitBackDirectionType.RightUp] = {
    HitBackDirectionType.RightUp,
    HitBackDirectionType.Up,
    HitBackDirectionType.Right,
    HitBackDirectionType.LeftUp,
    HitBackDirectionType.RightDown,
    HitBackDirectionType.Left,
    HitBackDirectionType.Down,
    HitBackDirectionType.LeftDown
  }
  List[HitBackDirectionType.LeftDown] = {
    HitBackDirectionType.LeftDown,
    HitBackDirectionType.Down,
    HitBackDirectionType.Left,
    HitBackDirectionType.RightDown,
    HitBackDirectionType.LeftUp,
    HitBackDirectionType.Right,
    HitBackDirectionType.Up,
    HitBackDirectionType.RightUp
  }
  List[HitBackDirectionType.RightDown] = {
    HitBackDirectionType.RightDown,
    HitBackDirectionType.Right,
    HitBackDirectionType.Down,
    HitBackDirectionType.RightUp,
    HitBackDirectionType.LeftDown,
    HitBackDirectionType.Up,
    HitBackDirectionType.Left,
    HitBackDirectionType.leftup
  }
  local defenderPos = defenderEntity:GridLocation().Position
  local dirEnum = self:_VectorDirToHitBackEnum(tempDir)
  if not List[dirEnum] then
    Log.exception("Attack Dir:", tostring(tempDir), " Invalid")
    return Vector2(0, 0), 0
  end
  for i = 0, 9 do
    for index, v in ipairs(List[dirEnum]) do
      local dir, add = self:GetDirAndGetDistance(v, distance, i)
      local targetPos = defenderPos + add
      if self:CanHitBackToPos(defenderEntity, targetPos) then
        Log.debug("Attack Dir:", tostring(tempDir), "HitBack Dir:", tostring(dir), " Index:", index)
        return dir, distance + i
      end
    end
  end
  return Vector2(0, 0), 0
end

function UtilCalcServiceShare:_CalcHitBackScorpion(casterEntity, defenderEntity, distance)
  local casterPosition = casterEntity:GridLocation().Position
  local center = casterEntity:GridLocation():Center()
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local defenderPosition = defenderEntity:GridLocation().Position
  local direction = defenderPosition - center
  for _, offset in ipairs(casterBodyArea) do
    local bodyPosition = offset + casterPosition
    if defenderPosition.x == bodyPosition.x or defenderPosition.y == bodyPosition.y then
      direction = defenderPosition - bodyPosition
      break
    end
  end
  direction = HitBackDirectionTypeHelper.NormalizeDirType(direction)
  local hitBackPosition = defenderPosition
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  local boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  local boardLength = boardServiceLogic:GetCurBoardMaxLen()
  local distance = 0
  for i = 1, boardLength do
    hitBackPosition = hitBackPosition + direction
    if self:CanHitBackToPos(defenderEntity, hitBackPosition) and hitBackPosition.x > 1 and boardMaxX > hitBackPosition.x and hitBackPosition.y > 1 and boardMaxY > hitBackPosition.y then
      distance = distance + 1
    else
      do break end
      goto lbl_78
      break
    end
    ::lbl_78::
  end
  return direction, distance
end

function UtilCalcServiceShare:CalCoffinMusumeHitbackDirAndDis(attackerPos, attackDir, defenderEntity, distance)
  return attackDir, distance
end

function UtilCalcServiceShare:CalcHitBackFront3Dir(attackerPos, attackerDir, defender, distance, casterEntity)
  local hitBackDirList
  if attackerDir == Vector2.up then
    hitBackDirList = {
      Vector2.up,
      Vector2.left,
      Vector2.right
    }
  elseif attackerDir == Vector2.left then
    hitBackDirList = {
      Vector2.up,
      Vector2.left,
      Vector2.down
    }
  elseif attackerDir == Vector2.down then
    hitBackDirList = {
      Vector2.down,
      Vector2.left,
      Vector2.right
    }
  elseif attackerDir == Vector2.right then
    hitBackDirList = {
      Vector2.up,
      Vector2.down,
      Vector2.right
    }
  end
  local utilScope = self._world:GetService("UtilScopeCalc")
  local defenderPos = defender:GetGridPosition()
  for i, dir in ipairs(hitBackDirList) do
    local hitbackPos = defenderPos + dir
    if not utilScope:IsPosBlock(hitbackPos, BlockFlag.HitBack) then
      Log.fatal("Return Dir:", dir, "hitbackPos:", hitbackPos)
      return dir
    end
  end
  Log.fatal("Return Dir Nil")
end

function UtilCalcServiceShare:CalcHitBackAttackFront2Edge(attackerPos, attackerBodyArea, defenderPos)
  local posMain = defenderPos
  local endPos = attackerPos
  local bodyArea = attackerBodyArea:GetArea()
  local posList = {}
  for _, v in ipairs(bodyArea) do
    table.insert(posList, endPos + v)
  end
  local preDashDir = {
    Vector2(0, -1),
    Vector2(-1, 0),
    Vector2(0, 1),
    Vector2(1, 0)
  }
  for _, pos in ipairs(posList) do
    local mountDir = Vector2.Normalize(posMain - pos)
    for i, v in ipairs(preDashDir) do
      if v.x == mountDir.x and v.y == mountDir.y then
        return v
      end
    end
  end
  Log.fatal("未确定朝向！！！！！！！！")
  return preDashDir[1]
end

function UtilCalcServiceShare:CalEightDirAndCasterAround(casterEntity, defenderEntity, distance)
  local casterPos = casterEntity:GridLocation().Position
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local defenderPos = defenderEntity:GridLocation().Position
  local bodyArea = defenderEntity:BodyArea():GetArea()
  local attackRange = ComputeScopeRange.ComputeRange_SquareRing(defenderPos, #bodyArea, 1)
  if table.count(attackRange) > 0 then
    table.sort(attackRange, function(a, b)
      local disA = Vector2.Distance(defenderPos, a)
      local disB = Vector2.Distance(defenderPos, b)
      return disA < disB
    end)
    for _, pos in ipairs(attackRange) do
      if self:CanHitBackToPos(defenderEntity, pos) then
        local dir = pos - defenderPos
        return dir, distance
      end
    end
  end
  local attackRange = ComputeScopeRange.ComputeRange_SquareRing(casterPos, #casterBodyArea, 1)
  if table.count(attackRange) > 0 then
    table.sort(attackRange, function(a, b)
      local disA = Vector2.Distance(defenderPos, a)
      local disB = Vector2.Distance(defenderPos, b)
      return disA < disB
    end)
    for _, pos in ipairs(attackRange) do
      if self:CanHitBackToPos(defenderEntity, pos) then
        local dir = pos - defenderPos
        local newDistance = Vector2.Distance(defenderPos, pos)
        return dir, newDistance
      end
    end
  end
  return Vector2(0, 0), 0
end

local crossDirs = {
  Vector2.left,
  Vector2.right,
  Vector2.up,
  Vector2.down
}
local rotateCrossDirs = {
  Vector2.New(1, 1),
  Vector2.New(1, -1),
  Vector2.New(-1, 1),
  Vector2(-1, -1)
}

function UtilCalcServiceShare:CalButterflyHitBackDirAndDistance(casterEntity, defenderEntity)
  local defenderEntityPos = defenderEntity:GetGridPosition()
  local utilData = self._world:GetService("UtilData")
  for _, dir in ipairs(crossDirs) do
    local v2 = defenderEntityPos + dir
    if utilData:IsValidPiecePos(v2) and not utilData:IsPosBlock(v2, BlockFlag.LinkLine) then
      return dir, 1
    end
  end
  for _, dir in ipairs(rotateCrossDirs) do
    local v2 = defenderEntityPos + dir
    if utilData:IsValidPiecePos(v2) and not utilData:IsPosBlock(v2, BlockFlag.LinkLine) then
      return dir, 1
    end
  end
  local maxEdge = math.max(utilData:GetCurBoardMaxX(), utilData:GetCurBoardMaxY())
  for i = 2, maxEdge do
    for _, dir in ipairs(crossDirs) do
      local v2 = defenderEntityPos + dir * i
      if utilData:IsValidPiecePos(v2) and not utilData:IsPosBlock(v2, BlockFlag.LinkLine) then
        return dir, i
      end
    end
    for _, dir in ipairs(rotateCrossDirs) do
      local v2 = defenderEntityPos + dir * i
      if utilData:IsValidPiecePos(v2) and not utilData:IsPosBlock(v2, BlockFlag.LinkLine) then
        return dir, i
      end
    end
  end
  return Vector2.zero, 0
end

function UtilCalcServiceShare:GetMonsterMove2PlayerNearestPath(monsterEntity, enableAnyPiece)
  local teamEntity = monsterEntity:AI():GetTargetTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local board = self._world:GetBoardEntity():Board()
  local boardSvc = self._world:GetService("BoardLogic")
  local monsterPos = monsterEntity:GetGridPosition()
  local retPath = {}
  local retPieceType
  local utilDataSvc = self._world:GetService("UtilData")
  for x = -1, 1 do
    for y = -1, 1 do
      local startPos = Vector2(monsterPos.x + x, monsterPos.y + y)
      if (startPos.x ~= monsterPos.x or startPos.y ~= monsterPos.y) and utilDataSvc:IsValidPiecePos(startPos) and not boardSvc:IsPosBlock(startPos, BlockFlag.LinkLine) then
        local pieceType = board:GetPieceType(startPos)
        if enableAnyPiece or pieceType ~= PieceType.Any then
          local function getPosValidAroundFunc(pos, type)
            return self:GetPosValidAround(pos, type, enableAnyPiece)
          end
          
          local path = self:CalcPos2PosShortestPath(startPos, playerPos, pieceType, getPosValidAroundFunc, getPosValidAroundFunc)
          if path and 0 < #path then
            if #retPath == 0 then
              retPath = path
              retPieceType = pieceType
            end
            if #path < #retPath then
              retPath = path
              retPieceType = pieceType
            end
          end
        end
      end
    end
  end
  return retPath, retPieceType
end

function UtilCalcServiceShare:CalcH(pos, targetPos)
  local ret = Vector2.Distance(pos, targetPos)
  return math.floor(ret * 10)
end

_class("AStarInfo", Object)
AStarInfo = AStarInfo

function AStarInfo:Constructor(myPos, value, prePos)
  self._prePos = prePos
  self._myPos = myPos
  self._value = value
end

function AStarInfo:GetPrePoint()
  return self._prePos
end

function AStarInfo:GetMyPos()
  return self._myPos
end

function AStarInfo.Sort(info1, info2)
  if info1._value < info2._value then
    return 1
  elseif info1._value > info2._value then
    return -1
  elseif info1._value == info2._value then
    local pos1 = Vector2.Pos2Index(info1:GetMyPos())
    local pos2 = Vector2.Pos2Index(info2:GetMyPos())
    if pos1 < pos2 then
      return 1
    elseif pos1 < pos2 then
      return -1
    else
      return 0
    end
  end
  return 0
end

function UtilCalcServiceShare:GetPosValidAround(pos, pieceType, enableAnyPiece)
  local utilDataSvc = self._world:GetService("UtilData")
  local board = self._world:GetBoardEntity():Board()
  local boardSvc = self._world:GetService("BoardLogic")
  local aroundList = ComputeScopeRange.ComputeRange_SquareRing(pos, 1, 1)
  local ret = {}
  for i, aroundPos in ipairs(aroundList) do
    local posPieceType = board:GetPieceType(aroundPos)
    if utilDataSvc:IsValidPiecePos(aroundPos) and not boardSvc:IsPosBlock(aroundPos, BlockFlag.LinkLine) then
      if enableAnyPiece then
        if posPieceType ~= pieceType and posPieceType ~= PieceType.Any then
          goto lbl_56
        end
      else
      end
      if posPieceType == pieceType then
        table.insert(ret, aroundPos)
      end
    end
    ::lbl_56::
  end
  return ret
end

function UtilCalcServiceShare:IsInOpenList(pos, startList)
  for i, info in ipairs(startList.elements) do
    if info:GetMyPos() == pos then
      return true
    end
  end
  return false
end

function UtilCalcServiceShare:PosInList(aStarInfo, pos2, pieceType, openList, closeList, GetPosValidAroundFunc)
  local pos1 = aStarInfo:GetMyPos()
  local pos1Around = GetPosValidAroundFunc(pos1, pieceType)
  for i, pos in ipairs(pos1Around) do
    local canInsert = true
    for i, info in ipairs(closeList) do
      local myPos = info:GetMyPos()
      if myPos.x == pos.x and myPos.y == pos.y then
        canInsert = false
        break
      end
    end
    if canInsert and not self:IsInOpenList(pos, openList) then
      local info = AStarInfo:New(pos, self:CalcH(pos, pos2), aStarInfo)
      openList:Insert(info)
    end
  end
end

function UtilCalcServiceShare:GetPath(endPos)
  local tmp = endPos
  local ret = {}
  while tmp do
    local pos = tmp:GetMyPos()
    table.insert(ret, 1, pos)
    tmp = tmp:GetPrePoint()
  end
  return ret
end

function UtilCalcServiceShare:CalcPos2PosShortestPath(pos1, pos2, pieceType, GetFinalPosValidAroundFunc, GetPosValidAroundFunc)
  local openList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AStarInfo.Sort)
  local closeList = {}
  local find = false
  local startInfo = AStarInfo:New(pos1, self:CalcH(pos1, pos2), nil)
  local endInfo
  openList:Insert(startInfo)
  local finalPosList = GetFinalPosValidAroundFunc(pos2, pieceType)
  if #finalPosList == 0 then
    return {}
  end
  while not openList:Empty() do
    for i, info in ipairs(openList.elements) do
      if table.Vector2Include(finalPosList, info:GetMyPos()) then
        find = true
        endInfo = info
        break
      end
    end
    if find then
      break
    end
    local info = openList:GetFirstElement()
    openList:Remove(info)
    table.insert(closeList, info)
    self:PosInList(info, pos2, pieceType, openList, closeList, GetPosValidAroundFunc)
  end
  local retList = self:GetPath(endInfo)
  return retList
end

function UtilCalcServiceShare:_CalcNearestPosOutOfRange(skillRange, defender)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMaxLen = boardServiceLogic:GetCurBoardMaxLen()
  local defenderPos = defender:GridLocation().Position
  for i = 0, boardMaxLen do
    for x = -1, 1 do
      for y = 1, -1, -1 do
        local pos = Vector2(defenderPos.x + x * i, defenderPos.y + y * i)
        if not table.Vector2Include(skillRange, pos) and self:CanHitBackToPos(defender, pos) then
          local dir = pos - defenderPos
          dir = Vector2(dir.x / i, dir.y / i)
          return dir, i
        end
      end
    end
  end
  Log.exception("Not Find Dir And Distance")
end

function UtilCalcServiceShare:GetGridPathByVectorLerp(posBegin, posEnd)
  local beginX = posBegin.x
  local endX = posEnd.x
  local beginY = posBegin.y
  local endY = posEnd.y
  local vFirst = Vector2.New(posBegin.x, posBegin.y)
  local vLast = Vector2.New(posEnd.x, posEnd.y)
  local vDirection = vLast - vFirst
  local lerpXToY = math.abs(vDirection.x) >= math.abs(vDirection.y)
  local independentVar = 0
  local maxIndependentVar = 0
  local step = 1
  if lerpXToY then
    if beginX < endX then
      independentVar = beginX + 0.5
      maxIndependentVar = endX - 0.5
      step = 1
    else
      independentVar = beginX - 0.5
      maxIndependentVar = endX + 0.5
      step = -1
    end
  elseif beginY < endY then
    independentVar = beginY + 0.5
    maxIndependentVar = endY - 0.5
    step = 1
  else
    independentVar = beginY - 0.5
    maxIndependentVar = endY + 0.5
    step = -1
  end
  local mathService = self._world:GetService("Math")
  local intersections = {}
  for idv = independentVar, maxIndependentVar, step do
    if lerpXToY then
      table.insert(intersections, {
        x = idv,
        y = mathService:LerpGetY(vFirst, vLast, idv)
      })
    else
      table.insert(intersections, {
        x = mathService:LerpGetX(vFirst, vLast, idv),
        y = idv
      })
    end
  end
  local path = {vFirst}
  for index = 1, #intersections - 1 do
    local intersection1 = intersections[index]
    local intersection2 = intersections[index + 1]
    local points = self:_GetPassedGridPositionByIntersections(intersection1, intersection2)
    for _, pos in ipairs(points) do
      if not table.icontains(path, pos) then
        table.insert(path, pos)
      end
    end
  end
  table.insert(path, vLast)
  local snappedPath = self:_SnapContinuousPath(path)
  local t = {}
  for _, v2 in ipairs(snappedPath) do
    if not table.icontains(t, v2) then
      table.insert(t, v2)
    end
  end
  return t
end

function UtilCalcServiceShare:_GetPassedGridPositionByIntersections(intersection1, intersection2)
  local x1 = intersection1.x
  local y1 = intersection1.y
  local x2 = intersection2.x
  local y2 = intersection2.y
  local grid1 = Vector2.zero
  local grid2 = Vector2.zero
  if 0 < x2 - x1 then
    grid1.x = math.floor(x1 + 0.5)
    grid2.x = math.floor(x2 + 0.5)
  else
    grid1.x = math.ceil(x1 - 0.5)
    grid2.x = math.ceil(x2 - 0.5)
  end
  if 0 < y2 - y1 then
    grid1.y = math.floor(y1 + 0.5)
    grid2.y = math.floor(y2 + 0.5)
  else
    grid1.y = math.ceil(y1 - 0.5)
    grid2.y = math.ceil(y2 - 0.5)
  end
  local blocks = {}
  if grid1 == grid2 then
    table.insert(blocks, grid1)
  else
    table.insert(blocks, grid1)
    table.insert(blocks, grid2)
  end
  return blocks
end

local function GetLogicDirection(dir)
  local ret = Vector2.zero
  if dir.x > 0 then
    ret.x = 1
  elseif dir.x < 0 then
    ret.x = -1
  end
  if 0 < dir.y then
    ret.y = 1
  elseif 0 > dir.y then
    ret.y = -1
  end
  return ret
end

function UtilCalcServiceShare:_SnapContinuousPath(path)
  local finalPath = {}
  for index, pos in ipairs(path) do
    if index ~= 1 then
      local lastPos = finalPath[#finalPath]
      local distance = Vector2.Distance(lastPos, pos)
      if distance <= 1 then
        table.insert(finalPath, pos)
      else
        local dir = GetLogicDirection(lastPos - pos)
        while dir ~= Vector2.zero do
          if dir.x ~= 0 and dir.y ~= 0 then
            table.insert(finalPath, Vector2.New(pos.x, lastPos.y))
          else
            table.insert(finalPath, lastPos - dir)
          end
          lastPos = finalPath[#finalPath]
          dir = GetLogicDirection(lastPos - pos)
        end
      end
    else
      table.insert(finalPath, pos)
    end
  end
  return finalPath
end

function UtilCalcServiceShare:SaveSyncLog()
  local syncSvc = self._world:GetService("SyncLogic")
  syncSvc:DumpSyncLog()
  self._world:GetMatchLogger():SaveMatchLog()
  self._world:GetDetailMatchLogger():SaveDetailMatchLog()
end

function UtilCalcServiceShare:ChessMonsterMoveGetFinalPosValidAround(pos, pieceType)
  local utilDataSvc = self._world:GetService("UtilData")
  local board = self._world:GetBoardEntity():Board()
  local boardSvc = self._world:GetService("BoardLogic")
  local aroundList = {}
  local ret = {}
  table.insert(aroundList, Vector2(pos.x + 1, pos.y))
  table.insert(aroundList, Vector2(pos.x - 1, pos.y))
  table.insert(aroundList, Vector2(pos.x, pos.y + 1))
  table.insert(aroundList, Vector2(pos.x, pos.y - 1))
  for i, aroundPos in ipairs(aroundList) do
    if utilDataSvc:IsValidPiecePos(aroundPos) and (board:GetPieceType(aroundPos) == pieceType or board:GetPieceType(aroundPos) == PieceType.Any) and not boardSvc:IsPosBlock(aroundPos, BlockFlag.LinkLine) and not utilDataSvc:IsPosHasSpTrap(aroundPos, TrapType.BadGrid) then
      table.insert(ret, aroundPos)
    end
  end
  return ret
end

function UtilCalcServiceShare:ChessMonsterMoveGetPosValidAround(pos, pieceType)
  local utilDataSvc = self._world:GetService("UtilData")
  local board = self._world:GetBoardEntity():Board()
  local boardSvc = self._world:GetService("BoardLogic")
  local aroundList = ComputeScopeRange.ComputeRange_SquareRing(pos, 1, 1)
  local ret = {}
  for i, aroundPos in ipairs(aroundList) do
    if utilDataSvc:IsValidPiecePos(aroundPos) and (board:GetPieceType(aroundPos) == pieceType or board:GetPieceType(aroundPos) == PieceType.Any) and not boardSvc:IsPosBlock(aroundPos, BlockFlag.LinkLine) and not utilDataSvc:IsPosHasSpTrap(aroundPos, TrapType.BadGrid) then
      table.insert(ret, aroundPos)
    end
  end
  return ret
end

function UtilCalcServiceShare:GetMonster2TargetNearestPathByElement(casterEntity, targetID, element)
  local targetEntity = self._world:GetEntityByID(targetID)
  local targetCenterPos = targetEntity:GetGridPosition()
  local board = self._world:GetBoardEntity():Board()
  local boardSvc = self._world:GetService("BoardLogic")
  local casterPos = casterEntity:GetGridPosition()
  local bodyAreaCmpt = targetEntity:BodyArea()
  local monsterPosList = {}
  for i, area in ipairs(bodyAreaCmpt:GetArea()) do
    local pos = Vector2(targetCenterPos.x + area.x, targetCenterPos.y + area.y)
    table.insert(monsterPosList, pos)
  end
  local retPath = {}
  local retPieceType
  local utilDataSvc = self._world:GetService("UtilData")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local bTargetCanConnect = false
  for i, pos in ipairs(monsterPosList) do
    local ret = self:ChessMonsterMoveGetFinalPosValidAround(pos, type)
    if 0 < #ret then
      bTargetCanConnect = true
      break
    end
  end
  if bTargetCanConnect then
    local function getFinalValidPosFunc(pos, type)
      return self:ChessMonsterMoveGetFinalPosValidAround(pos, type)
    end
    
    local function getAroundValidPosFunc(pos, type)
      return self:ChessMonsterMoveGetPosValidAround(pos, type)
    end
    
    for i, targetPos in ipairs(monsterPosList) do
      for x = -1, 1 do
        for y = -1, 1 do
          local startPos = Vector2(casterPos.x + x, casterPos.y + y)
          if (startPos.x ~= casterPos.x or startPos.y ~= casterPos.y) and utilDataSvc:IsValidPiecePos(startPos) and not boardSvc:IsPosBlock(startPos, BlockFlag.LinkLine) and not utilDataSvc:IsPosHasSpTrap(startPos, TrapType.BadGrid) then
            local pieceType = board:GetPieceType(startPos)
            if pieceType == PieceType.Any or pieceType == element then
              local path = self:CalcPos2PosShortestPath(startPos, targetPos, pieceType, getFinalValidPosFunc, getAroundValidPosFunc)
              if path and 0 < #path then
                if #retPath == 0 then
                  retPath = path
                  retPieceType = pieceType
                end
                if #path < #retPath then
                  retPath = path
                  retPieceType = pieceType
                end
              end
            end
          end
        end
      end
    end
  end
  if #retPath == 0 then
    retPath = self:FindNearestGirdInChessLine(casterEntity, targetEntity, element)
  end
  return retPath
end

function UtilCalcServiceShare:FindNearestGirdInChessLine(chessEntity, targetEntity, element)
  local retPath = {}
  local allConnectPath = self:ChessMonsterFindAllPath(chessEntity, element)
  local targetPos = targetEntity:GetGridPosition()
  local startPos = chessEntity:GetGridPosition()
  local nearDis = 1000000
  local nearIndex, nearPos
  local start2TargetDis = Vector2.Distance(startPos, targetPos)
  for index, pos in pairs(allConnectPath) do
    local tDis = Vector2.Distance(pos, targetPos)
    if nearDis > tDis then
      nearDis = tDis
      nearIndex = index
      nearPos = pos
    elseif tDis == nearDis then
      local nearDis2Caster = Vector2.Distance(nearPos, startPos)
      local tDis2Caster = Vector2.Distance(pos, startPos)
      if nearDis2Caster > tDis2Caster then
        nearDis = tDis
        nearIndex = index
        nearPos = pos
      end
    end
  end
  if start2TargetDis <= nearDis then
    return {}
  end
  local path = {}
  if not self:IsPosAround(startPos, nearPos) then
    local function getFinalValidPosFunc(pos, type)
      return {pos}
    end
    
    local function getAroundValidPosFunc(pos, type)
      return self:ChessMonsterMoveGetPosValidAround(pos, type)
    end
    
    path = self:CalcPos2PosShortestPath(startPos, nearPos, element, getFinalValidPosFunc, getAroundValidPosFunc)
  end
  table.insert(path, nearPos)
  return path
end

function UtilCalcServiceShare:IsPosAround(pos1, pos2)
  if math.abs(pos1.x - pos2.x) <= 1 and 1 >= math.abs(pos1.y - pos2.y) then
    return true
  end
  return false
end

function UtilCalcServiceShare:ChessMonsterFindAllPath(chessEntity, element)
  local monsterPos = chessEntity:GetGridPosition()
  local retPath = {}
  local utilDataSvc = self._world:GetService("UtilData")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local board = self._world:GetBoardEntity():Board()
  local boardSvc = self._world:GetService("BoardLogic")
  for x = -1, 1 do
    for y = -1, 1 do
      local newPos = Vector2(monsterPos.x + x, monsterPos.y + y)
      if (newPos.x ~= monsterPos.x or newPos.y ~= monsterPos.y) and utilDataSvc:IsValidPiecePos(newPos) and not boardSvc:IsPosBlock(newPos, BlockFlag.LinkLine) and not utilDataSvc:IsPosHasSpTrap(newPos, TrapType.BadGrid) then
        local pieceType = board:GetPieceType(newPos)
        if pieceType == PieceType.Any or pieceType == element then
          local index = Vector2.Pos2Index(newPos)
          if not retPath[index] then
            retPath[index] = newPos
          end
          self:GetConnectPosList(newPos, element, retPath)
        end
      end
    end
  end
  return retPath
end

function UtilCalcServiceShare:GetConnectPosList(pos, element, list)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local newPosAroundPosList = utilScopeSvc:GetPosAroundSameTypePosList(pos, element)
  for _, newPos in ipairs(newPosAroundPosList) do
    local index = Vector2.Pos2Index(newPos)
    if not list[index] then
      list[index] = newPos
      self:GetConnectPosList(newPos, element, list)
    end
  end
end

function UtilCalcServiceShare:CheckChessMonsterCanMove(monsterEntity, element)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local utilDataSvc = self._world:GetService("UtilData")
  local boardSvc = self._world:GetService("BoardLogic")
  local aroundPosList = utilScopeSvc:GetTargetSquareRing(monsterEntity:GetID(), 1)
  local board = self._world:GetBoardEntity():Board()
  local ret = false
  for _, pos in ipairs(aroundPosList) do
    if utilDataSvc:IsValidPiecePos(pos) and not boardSvc:IsPosBlock(pos, BlockFlag.LinkLine) and not utilDataSvc:IsPosHasSpTrap(pos, TrapType.BadGrid) then
      local type = board:GetPieceType(pos)
      if type == element or type == PieceType.Any then
        ret = true
        break
      end
    end
  end
  return ret
end

function UtilCalcServiceShare:CalSyncMovePreviewPos(startPos, chainPath)
  local syncMoveSvcLogic = self._world:GetService("SyncMoveLogic")
  if syncMoveSvcLogic then
    return syncMoveSvcLogic:CalcSyncMovePreviewPos(startPos, chainPath)
  end
end

function UtilCalcServiceShare:MonsterFindAllPosCanLink(startPos)
  local monsterPos = startPos
  local retCanLink = {}
  local utilDataSvc = self._world:GetService("UtilData")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local board = self._world:GetBoardEntity():Board()
  local boardSvc = self._world:GetService("BoardLogic")
  for x = -1, 1 do
    for y = -1, 1 do
      local newPos = Vector2(monsterPos.x + x, monsterPos.y + y)
      if (newPos.x ~= monsterPos.x or newPos.y ~= monsterPos.y) and utilDataSvc:IsValidPiecePos(newPos) and not boardSvc:IsPosBlock(newPos, BlockFlag.MonsterLand) and not utilDataSvc:IsPosHasSpTrap(newPos, TrapType.BadGrid) then
        local pieceType = board:GetPieceType(newPos)
        local startElement
        if pieceType == PieceType.Any then
          for eleType = PieceType.Blue, PieceType.Yellow do
            startElement = eleType
            local index = Vector2.Pos2Index(newPos)
            if not retCanLink[index] then
              retCanLink[index] = newPos
            end
            self:MonsterGetConnectPosList(newPos, startElement, retCanLink)
          end
        elseif pieceType ~= PieceType.None then
          startElement = pieceType
          local index = Vector2.Pos2Index(newPos)
          if not retCanLink[index] then
            retCanLink[index] = newPos
          end
          self:MonsterGetConnectPosList(newPos, startElement, retCanLink)
        end
      end
    end
  end
  return retCanLink
end

function UtilCalcServiceShare:MonsterGetConnectPosList(pos, element, list)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local newPosAroundPosList = utilScopeSvc:MonsterGetPosAroundSameTypePosList(pos, element)
  for _, newPos in ipairs(newPosAroundPosList) do
    local index = Vector2.Pos2Index(newPos)
    if not list[index] then
      list[index] = newPos
      self:MonsterGetConnectPosList(newPos, element, list)
    end
  end
end

function UtilCalcServiceShare:GetMonster2PosByLink(casterPos, targetPos, pieceType)
  local board = self._world:GetBoardEntity():Board()
  local boardSvc = self._world:GetService("BoardLogic")
  local retPath = {}
  local retPieceType
  local utilDataSvc = self._world:GetService("UtilData")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local bTargetCanConnect = true
  if bTargetCanConnect then
    local function getFinalValidPosFunc(pos, type)
      local posList = {}
      
      table.insert(posList, pos)
      return posList
    end
    
    local function getAroundValidPosFunc(pos, type)
      return self:MonsterLinkMoveGetPosValidAround(pos, type)
    end
    
    local path = self:CalcPos2PosShortestPath(casterPos, targetPos, pieceType, getFinalValidPosFunc, getAroundValidPosFunc)
    if path and 0 < #path then
      if #retPath == 0 then
        retPath = path
        retPieceType = pieceType
      end
      if #path < #retPath then
        retPath = path
        retPieceType = pieceType
      end
    end
  end
  return retPath
end

function UtilCalcServiceShare:MonsterLinkMoveGetPosValidAround(pos, pieceType)
  local utilDataSvc = self._world:GetService("UtilData")
  local board = self._world:GetBoardEntity():Board()
  local boardSvc = self._world:GetService("BoardLogic")
  local aroundList = {}
  for x = -1, 1 do
    for y = -1, 1 do
      local newPos = Vector2(pos.x + x, pos.y + y)
      if (newPos.x ~= pos.x or newPos.y ~= pos.y) and utilDataSvc:IsValidPiecePos(newPos) and (board:GetPieceType(newPos) == pieceType or board:GetPieceType(newPos) == PieceType.Any) and not boardSvc:IsPosBlock(newPos, BlockFlag.MonsterLand) and not utilDataSvc:IsPosHasSpTrap(newPos, TrapType.BadGrid) then
        table.insert(aroundList, newPos)
      end
    end
  end
  return aroundList
end

function UtilCalcServiceShare:FindMonsterLongestGridPathByTrapID(casterEntity, maxLen, trapID)
  maxLen = maxLen or 1000
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local casterPos = casterEntity:GetGridPosition()
  local casterPosIndex = Vector2.Pos2Index(casterPos)
  local beginPosList = utilScopeSvc:GetMonsterAroundCanMovePosList(casterEntity, Offset4)
  self._boardCmpt = self._world:GetBoardEntity():Board()
  self._chainPath = {}
  self._connectMap = self:_BuildMonsterConnectMapNoPieceType(casterEntity)
  local trapSvcLogic = self._world:GetService("TrapLogic")
  self._trapPosList = trapSvcLogic:FindTrapPosByTrapID(trapID)
  self._chainPathTmp = {}
  self._chainPath = {}
  for i, beginPos in ipairs(beginPosList) do
    local posIndex = Vector2.Pos2Index(beginPos)
    local deep = 2
    self._chainPathTmp[posIndex] = {posIndex}
    self._chainPath[#self._chainPath + 1] = {
      trapCount = 0,
      trapDis = 0,
      chainPath = {posIndex}
    }
    self:_FindLongPathByDeep(posIndex, posIndex, deep, maxLen, casterPosIndex, trapID)
  end
  local count = #self._chainPath
  if count == 0 then
    return {}
  end
  for _, v in ipairs(self._chainPath) do
    local chainPath = v.chainPath
    local trapCount = 0
    for _, posIndex in ipairs(chainPath) do
      local pos = self._boardCmpt:GetCloneVector2PosByPosIndex(posIndex)
      if table.Vector2Include(self._trapPosList, pos) then
        trapCount = trapCount + 1
      end
    end
    v.trapCount = trapCount
    if v.trapCount == 0 then
      local beginPosIndex = chainPath[#chainPath]
      local beginPos = self._boardCmpt:GetCloneVector2PosByPosIndex(beginPosIndex)
      local dis = 100000
      for _, pos in ipairs(self._trapPosList) do
        local tDis = Vector2.Distance(beginPos, pos)
        if dis > tDis then
          dis = tDis
        end
      end
      v.trapDis = dis
    end
  end
  self._trapPosList = nil
  self._connectMap = nil
  self._boardCmpt = nil
  
  local function funcByTrapIDCount(a, b)
    return a.trapCount > b.trapCount
  end
  
  local function funcByTrapDis(a, b)
    return a.trapDis < b.trapDis
  end
  
  table.sort(self._chainPath, funcByTrapIDCount)
  if 0 < self._chainPath[1].trapCount then
    local path = self._chainPath[1].chainPath
    if maxLen > #path then
      Log.fatal("1111")
    end
    self._chainPath = nil
    self._chainPathTmp = nil
    return self:PosIndexList2VectorList(path)
  end
  table.sort(self._chainPath, funcByTrapDis)
  local path = self._chainPath[1].chainPath
  self._chainPath = nil
  self._chainPathTmp = nil
  return self:PosIndexList2VectorList(path)
end

function UtilCalcServiceShare:_CheckMinosMonsterMove(posIndex)
  local boardCmpt = self._world:GetBoardEntity():Board()
  boardCmpt:GetCloneVector2PosByPosIndex(posIndex)
end

function UtilCalcServiceShare:_FindLongPathByDeep(posIndex, beginPosIndex, deep, maxLen, casterPosIndex, trapID)
  local ct = self._connectMap[posIndex]
  if not ct then
    return false
  end
  if maxLen < deep then
    return false
  end
  for i = 1, 4 do
    local chainPath = self._chainPathTmp[beginPosIndex]
    local newPosIndex = ct[i]
    if newPosIndex and not table.icontains(chainPath, newPosIndex) then
      table.insert(chainPath, newPosIndex)
      if #chainPath == maxLen then
        local t = {}
        for i, v in ipairs(chainPath) do
          t[i] = v
        end
        self._chainPath[#self._chainPath + 1] = {
          trapCount = 0,
          trapDis = 0,
          chainPath = t
        }
      end
      self:_FindLongPathByDeep(newPosIndex, beginPosIndex, deep + 1, maxLen, casterPosIndex, trapID)
      chainPath = self._chainPathTmp[beginPosIndex]
      if deep <= #chainPath then
        self._chainPathTmp[beginPosIndex] = table.sub(chainPath, 1, deep - 1)
      end
    end
  end
end

function UtilCalcServiceShare:PosIndexList2VectorList(posIndexList)
  local boardCmpt = self._world:GetBoardEntity():Board()
  local ret = {}
  for i, posIndex in ipairs(posIndexList) do
    ret[i] = boardCmpt:GetCloneVector2PosByPosIndex(posIndex)
  end
  return ret
end

function UtilCalcServiceShare:IsOffsetPathValid(dir, offset, sourcePos, hasPath)
  local utilDataSvc = self._world:GetService("UtilData")
  local boardSvc = self._world:GetService("BoardLogic")
  local retPath = {}
  for i = 1, offset do
    local newPos = Vector2(sourcePos.x + dir[1] * i, sourcePos.y + dir[2] * i)
    if utilDataSvc:IsValidPiecePos(newPos) and not boardSvc:IsPosBlock(newPos, BlockFlag.MonsterLand) and not utilDataSvc:IsPosHasSpTrap(newPos, TrapType.BadGrid) and not table.Vector2Include(hasPath, newPos) then
      table.insert(retPath, newPos)
    else
      return false, retPath
    end
  end
  return true, retPath
end

function UtilCalcServiceShare:FindMinosMoveGridPath(casterEntity, runCountList)
  local beginPos = casterEntity:GetGridPosition()
  local retPosList = {beginPos}
  local dirList = table.clone(Offset8)
  local randomServiceLogic = self._world:GetService("RandomLogic")
  for i, v in ipairs(runCountList) do
    dirList = randomServiceLogic:Shuffle(dirList)
    for _, offset in ipairs(dirList) do
      local isValid, path = self:IsOffsetPathValid(offset, v, retPosList[#retPosList], retPosList)
      if isValid then
        table.appendArray(retPosList, path)
        break
      end
    end
  end
  table.remove(retPosList, 1)
  return retPosList
end

function UtilCalcServiceShare:FindMonsterLongestGridPath(casterEntity)
  self._connectMap = self:_BuildMonsterConnectMap(casterEntity)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local beginPosList = utilScopeSvc:GetMonsterAroundCanMovePosList(casterEntity)
  self._boardCmpt = self._world:GetBoardEntity():Board()
  self._chainPath = {}
  self._chainPathTmp = {}
  self._chainPathType = {}
  for i, beginPos in ipairs(beginPosList) do
    local posIndex = Vector2.Pos2Index(beginPos)
    local pieceType = self._boardCmpt:GetPieceTypeByIndex(posIndex)
    if not pieceType then
      Log.fatal("")
    end
    self._chainPath[posIndex] = {posIndex}
    self._chainPathTmp[posIndex] = {posIndex}
    local deep = 2
    local finalPieceType = self:_FindLongPath(posIndex, posIndex, pieceType, deep)
    self._chainPathType[posIndex] = finalPieceType
  end
  local retTmp = {}
  local pieceType
  for posIndex, chainPath in pairs(self._chainPath) do
    if #chainPath > #retTmp then
      retTmp = chainPath
      pieceType = self._chainPathType[posIndex]
    end
  end
  local ret = self:PosIndexList2VectorList(retTmp)
  local utilDataService = self._world:GetService("UtilData")
  if 3 < #ret then
    for i = 2, #ret - 1 do
      local pos1 = ret[i]
      local pos2 = ret[i + 1]
      local bForMonster = true
      local ret, msg = utilDataService:Is2PosCanConnect(pos1, pos2, pieceType, bForMonster)
      if not ret then
        Log.fatal("1")
      end
    end
  end
  self._chainPath = {}
  self._chainPathTmp = {}
  self._boardCmpt = nil
  self._connectMap = nil
  return ret
end

function UtilCalcServiceShare:_FindLongPath(posIndex, beginPosIndex, pieceType, deep)
  local ct = self._connectMap[posIndex]
  if not ct then
    return
  end
  if #self._chainPath[beginPosIndex] > 1 then
    local curPieceType = self._boardCmpt:GetPieceTypeByIndex(posIndex)
    if pieceType == PieceType.Any then
      pieceType = curPieceType
    end
  end
  if 30 < deep then
    return
  end
  for i = 1, 8 do
    local chainPath = self._chainPathTmp[beginPosIndex]
    local newPosIndex = ct[i]
    if newPosIndex then
      local posPieceType = self._boardCmpt:GetPieceTypeByIndex(newPosIndex)
      if not pieceType then
        Log.fatal("")
      end
      if CanMatchPieceType(posPieceType, pieceType) and not table.icontains(chainPath, newPosIndex) then
        if pieceType == PieceType.Any then
          pieceType = posPieceType
        end
        table.insert(chainPath, newPosIndex)
        if #chainPath > #self._chainPath[beginPosIndex] then
          self._chainPath[beginPosIndex] = {}
          for i, v in ipairs(chainPath) do
            self._chainPath[beginPosIndex][i] = v
          end
        end
        self:_FindLongPath(newPosIndex, beginPosIndex, pieceType, deep + 1)
        chainPath = self._chainPathTmp[beginPosIndex]
        if deep <= #chainPath then
          self._chainPathTmp[beginPosIndex] = table.sub(chainPath, 1, deep - 1)
        end
      end
    end
  end
  return pieceType
end

function UtilCalcServiceShare:_BuildMonsterConnectMapNoPieceType(entity)
  local connectMap = {}
  local pos = entity:GetGridPosition()
  local posIndex = Vector2.Pos2Index(pos)
  local blockFlag = BlockFlag.MonsterLand
  if entity:MonsterID():GetMonsterRaceType() == MonsterRaceType.Fly then
    blockFlag = BlockFlag.MonsterFly
  end
  local board = self._world:GetBoardEntity():Board()
  local blockCanMoveMap = board:GetBlockFlagCanMoveMap(blockFlag)
  for i, offset in ipairs(Offset4) do
    local newPosIndex = posIndex + offset[1] * 100 + offset[2]
    self:_ConnectMapNoPieceType(newPosIndex, connectMap, board, blockCanMoveMap, posIndex)
  end
  board:ClearBlockFlagCanMoveMap(blockFlag)
  return connectMap
end

function UtilCalcServiceShare:_ConnectMapNoPieceType(posIndex, connectMap, boardCmpt, blockCanMoveMap, beginPosIndex)
  if connectMap[posIndex] then
    return
  end
  local ct = {}
  connectMap[posIndex] = ct
  for index, offset in ipairs(Offset4) do
    local i, j = offset[1], offset[2]
    local surroundIndex = posIndex + offset[1] * 100 + offset[2]
    if blockCanMoveMap[surroundIndex] then
      ct[index] = surroundIndex
      self:_ConnectMapNoPieceType(surroundIndex, connectMap, boardCmpt, blockCanMoveMap)
    end
  end
end

function UtilCalcServiceShare:_BuildMonsterConnectMap(entity, needPieceType)
  local connectMap = {}
  local pos = entity:GetGridPosition()
  local posIndex = Vector2.Pos2Index(pos)
  local blockFlag = BlockFlag.MonsterLand
  if entity:MonsterID():GetMonsterRaceType() == MonsterRaceType.Fly then
    blockFlag = BlockFlag.MonsterFly
  end
  local board = self._world:GetBoardEntity():Board()
  local blockCanMoveMap = board:GetBlockFlagCanMoveMap(blockFlag)
  local ringPosList = ComputeScopeRange.ComputeRange_SquareRing(pos, 1, 1)
  for i, v in ipairs(ringPosList) do
    local pieceType = board:GetPieceType(v)
    local beginIndex = Vector2.Pos2Index(v)
    self:_ConnectMap(beginIndex, pieceType, connectMap, board, blockCanMoveMap, posIndex)
  end
  board:ClearBlockFlagCanMoveMap(blockFlag)
  return connectMap
end

function UtilCalcServiceShare:_Offset2Index(i, j)
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

function UtilCalcServiceShare:_ConnectMap(posIndex, pieceType, connectMap, boardCmpt, blockCanMoveMap, beginPosIndex)
  if connectMap[posIndex] then
    return
  end
  local ct = {}
  connectMap[posIndex] = ct
  for _, offset in ipairs(Offset8) do
    local i, j = offset[1], offset[2]
    local surroundIndex = posIndex + offset[1] * 100 + offset[2]
    if blockCanMoveMap[surroundIndex] then
      local surroundPiece = boardCmpt:GetPieceTypeByIndex(surroundIndex)
      if CanMatchPieceType(surroundPiece, pieceType) and surroundIndex ~= beginPosIndex then
        if surroundPiece == PieceType.Any then
          surroundPiece = pieceType
        end
        ct[self:_Offset2Index(i, j)] = surroundIndex
        self:_ConnectMap(surroundIndex, surroundPiece, connectMap, boardCmpt, blockCanMoveMap)
      end
    end
  end
end

function UtilCalcServiceShare:SnakeHeadCheckBlock(pos, ignoreBlockPos)
  if ignoreBlockPos and pos.x == ignoreBlockPos.x and pos.y == ignoreBlockPos.y then
    return true
  end
  local boardSvc = self._world:GetService("BoardLogic")
  return not boardSvc:IsPosBlock(pos, BlockFlag.MonsterLand)
end

function UtilCalcServiceShare:SnakeGetPosValidAroundByOffset(pos, ignoreBlockPos, offset)
  local utilDataSvc = self._world:GetService("UtilData")
  local board = self._world:GetBoardEntity():Board()
  local boardSvc = self._world:GetService("BoardLogic")
  local aroundList = ComputeScopeRange.ComputeRange_SquareRing(pos, 1, 1)
  local ret = {}
  for i, v in ipairs(offset) do
    local aroundPos = Vector2(pos.x + v[1], pos.y + v[2])
    if utilDataSvc:IsValidPiecePos(aroundPos) and self:SnakeHeadCheckBlock(aroundPos, ignoreBlockPos) then
      table.insert(ret, aroundPos)
    end
  end
  return ret
end

function UtilCalcServiceShare:SnakeHeadPosInList(aStarInfo, pos2, openList, closeList, ignoreBlockPos)
  local pos1 = aStarInfo:GetMyPos()
  local pos1Around = self:SnakeGetPosValidAroundByOffset(pos1, ignoreBlockPos, Offset4)
  for i, pos in ipairs(pos1Around) do
    local canInsert = true
    for i, info in ipairs(closeList) do
      local myPos = info:GetMyPos()
      if myPos.x == pos.x and myPos.y == pos.y then
        canInsert = false
        break
      end
    end
    if canInsert and not self:IsInOpenList(pos, openList) then
      local info = AStarInfo:New(pos, self:CalcH(pos, pos2), aStarInfo)
      openList:Insert(info)
    end
  end
end

function UtilCalcServiceShare:SnakeHeadCalcPos2PosShortestPath(pos1, pos2, ignoreBlockPos)
  local openList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AStarInfo.Sort)
  local closeList = {}
  local find = false
  local startInfo = AStarInfo:New(pos1, self:CalcH(pos1, pos2), nil)
  local endInfo
  openList:Insert(startInfo)
  local finalPosList = self:SnakeGetPosValidAroundByOffset(pos2, ignoreBlockPos, Offset8)
  if #finalPosList == 0 then
    return {}
  end
  while not openList:Empty() do
    for i, info in ipairs(openList.elements) do
      if table.Vector2Include(finalPosList, info:GetMyPos()) then
        find = true
        endInfo = info
        break
      end
    end
    if find then
      break
    end
    local info = openList:GetFirstElement()
    openList:Remove(info)
    table.insert(closeList, info)
    self:SnakeHeadPosInList(info, pos2, openList, closeList, ignoreBlockPos)
  end
  local retList = self:GetPath(endInfo)
  return retList
end

function UtilCalcServiceShare:SnakeFindPathMove2PlayerNearestPath(monsterEntity, ignoreBlockPos)
  local teamEntity = monsterEntity:AI():GetTargetTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local board = self._world:GetBoardEntity():Board()
  local boardSvc = self._world:GetService("BoardLogic")
  local monsterPos = monsterEntity:GetGridPosition()
  local monsterDir = monsterEntity:GetGridDirection()
  local underMonsterPos = monsterPos - monsterDir
  local retPath = {}
  local utilDataSvc = self._world:GetService("UtilData")
  for i, v in ipairs(Offset4) do
    local startPos = Vector2(monsterPos.x + v[1], monsterPos.y + v[2])
    if utilDataSvc:IsValidPiecePos(startPos) and self:SnakeHeadCheckBlock(startPos, ignoreBlockPos) then
      local path = self:SnakeHeadCalcPos2PosShortestPath(startPos, playerPos)
      if path and 0 < #path then
        if #retPath == 0 then
          retPath = path
        end
        if #path < #retPath then
          retPath = path
        end
      end
    end
  end
  return retPath
end

function UtilCalcServiceShare:FindPath_MonsterMoveGridByParam(casterEntity, targetEntity, pieceTypeList, moveType)
  local movePath = {}
  self._n25BChainPaths = {}
  self._n25BChainIndexPaths = {}
  self._n25MoveForward = false
  self._n25BConnectMap = {}
  self._HighConnectRateCutLen = 0
  self._maxlen = 0
  self._cutlen = 0
  self:_BuildConnectMapByPieceTypeList(casterEntity, pieceTypeList)
  self._HighConnectRateCutLen = self:_CalcHighConnectRateCutLen(casterEntity)
  self:_CalcAllMovePathByPieceTypeList(casterEntity, pieceTypeList)
  if moveType == MovePathType.Far then
    movePath = self:_FindPath_FarFromTarget(targetEntity)
  elseif moveType == MovePathType.NearCross or moveType == MovePathType.NearAround then
    movePath = self:_FindPath_NearToTarget(targetEntity, moveType)
  end
  if #movePath <= 1 then
    movePath = self:_MoveOneStep(casterEntity)
  end
  self._n25BChainPaths = {}
  self._n25BChainIndexPaths = {}
  self._n25MoveForward = false
  self._n25BConnectMap = {}
  self._HighConnectRateCutLen = 0
  self._maxlen = 0
  self._cutlen = 0
  return movePath
end

function UtilCalcServiceShare:_BuildConnectMapByPieceTypeList(entity, pieceTypeList)
  local boardCmpt = self._world:GetBoardEntity():Board()
  local pos = entity:GetGridPosition()
  local posIndex = Vector2.Pos2Index(pos)
  local blockFlag = BlockFlag.MonsterLand
  if entity:MonsterID():GetMonsterRaceType() == MonsterRaceType.Fly then
    blockFlag = BlockFlag.MonsterFly
  end
  local blockCanMoveMap = boardCmpt:GetBlockFlagCanMoveMap(blockFlag)
  self:_ConnectMapByPieceTypeList(posIndex, pieceTypeList, boardCmpt, blockCanMoveMap)
  boardCmpt:ClearBlockFlagCanMoveMap(blockFlag)
end

function UtilCalcServiceShare:_ConnectMapByPieceTypeList(posIndex, pieceTypeList, boardCmpt, blockCanMoveMap)
  if self._n25BConnectMap[posIndex] then
    return
  end
  local ct = {}
  self._n25BConnectMap[posIndex] = ct
  for _, offset in ipairs(Offset8) do
    local offsetVec = Vector2(offset[1], offset[2])
    local surroundIndex = posIndex + Vector2.Pos2Index(offsetVec)
    if blockCanMoveMap[surroundIndex] then
      local surroundPiece = boardCmpt:GetPieceTypeByIndex(surroundIndex)
      if CanMatchPieceTypeList(surroundPiece, pieceTypeList) then
        ct[self:_Offset2Index(offsetVec.x, offsetVec.y)] = surroundIndex
        self:_ConnectMapByPieceTypeList(surroundIndex, pieceTypeList, boardCmpt, blockCanMoveMap)
      end
    end
  end
end

function UtilCalcServiceShare:_CalcAllMovePathByPieceTypeList(casterEntity, pieceTypeList)
  local pos = casterEntity:GetGridPosition()
  local startPosIndex = Vector2.Pos2Index(pos)
  local chainPathIdx = {startPosIndex}
  local depth = 100
  self:_NextMoveByPieceTypeList(chainPathIdx, pieceTypeList, depth)
end

function UtilCalcServiceShare:_NextMoveByPieceTypeList(chainPathIdx, pieceTypeList, depth)
  if depth == 0 then
    return
  end
  local startPosIdx = chainPathIdx[#chainPathIdx]
  local ct = self._n25BConnectMap[startPosIdx]
  if not ct or table.count(ct) == 0 then
    return
  end
  for i = 1, 8 do
    if startPosIdx ~= chainPathIdx[#chainPathIdx] then
      return
    end
    local posIdx = ct[i]
    if posIdx and not table.icontains(chainPathIdx, posIdx) then
      chainPathIdx[#chainPathIdx + 1] = posIdx
      local s = table.concat(chainPathIdx, " ")
      Log.fatal("KZY: path+: ", s)
      self._n25MoveForward = true
      self:_NextMoveByPieceTypeList(chainPathIdx, pieceTypeList, depth - 1)
      if self._n25MoveForward and 1 < #chainPathIdx then
        self._n25MoveForward = false
        local chainPath = {}
        for n = 1, #chainPathIdx do
          chainPath[#chainPath + 1] = Vector2.Index2Pos(chainPathIdx[n])
        end
        if table.icontains(self._n25BChainIndexPaths, chainPathIdx) then
          return
        end
        self._n25BChainPaths[#self._n25BChainPaths + 1] = chainPath
        self._n25BChainIndexPaths[#self._n25BChainIndexPaths + 1] = table.cloneconf(chainPathIdx)
        local s = table.concat(chainPathIdx, " ")
        Log.fatal("KZY: find sucess: 第", #self._n25BChainIndexPaths, "条路径: ", s)
        self._maxlen = #chainPathIdx
        self._cutlen = self:_CalcChainPathComplexityLen(chainPathIdx)
      end
      if startPosIdx == chainPathIdx[#chainPathIdx - 1] then
        local len = #chainPathIdx
        chainPathIdx[len] = nil
        local s = table.concat(chainPathIdx, " ")
        Log.fatal("KZY: path-: ", s)
      end
      if self._maxlen - #chainPathIdx == 4 then
        for n = #chainPathIdx, self._cutlen, -1 do
          local len = #chainPathIdx
          chainPathIdx[len] = nil
          local s = table.concat(chainPathIdx, " ")
          Log.fatal("KZY: path-: ", s)
        end
      end
    end
  end
end

function UtilCalcServiceShare:_FindPath_FarFromTarget(targetEntity)
  local retPath = {}
  local disMax = 0
  local chainPathIndex = 0
  local chainPosIndex = 0
  local targetPos = targetEntity:GetGridPosition()
  for i, chainPath in ipairs(self._n25BChainPaths) do
    for j, chainPos in ipairs(chainPath) do
      local dis = Vector2.Distance(chainPos, targetPos)
      if disMax < dis then
        disMax = dis
        chainPathIndex = i
        chainPosIndex = j
      end
    end
  end
  if 0 < chainPathIndex and 0 < chainPosIndex then
    retPath = self._n25BChainPaths[chainPathIndex]
    retPath = table.sub(retPath, 1, chainPosIndex)
  end
  return retPath
end

function UtilCalcServiceShare:_FindPath_NearToTarget(targetEntity, moveType)
  local offsetList = Offset4
  if moveType == MovePathType.NearAround then
    offsetList = Offset8
  end
  local targetPos = targetEntity:GetGridPosition()
  local posIndex = Vector2.Pos2Index(targetPos)
  local highValuePosIdxList = self:_GetPosIndexListByOffset(posIndex, offsetList)
  local retPath = {}
  local unionCount = 0
  local retIndex = 0
  for i, chainPathIdx in ipairs(self._n25BChainIndexPaths) do
    local targetInPath = table.union(chainPathIdx, highValuePosIdxList)
    if unionCount < #targetInPath then
      unionCount = #targetInPath
      retIndex = i
      if unionCount == #highValuePosIdxList then
        break
      end
    end
  end
  local disMin = MAX_INT_32
  local chainPathIndex = 0
  local chainPosIndex = 0
  if 0 < retIndex then
    chainPathIndex = retIndex
    for j, chainPos in ipairs(self._n25BChainPaths[retIndex]) do
      local dis = Vector2.Distance(chainPos, targetPos)
      if disMin >= dis then
        disMin = dis
        chainPosIndex = j
      end
    end
  else
    for i, chainPath in ipairs(self._n25BChainPaths) do
      for j, chainPos in ipairs(chainPath) do
        local dis = Vector2.Distance(chainPos, targetPos)
        if disMin > dis then
          disMin = dis
          chainPathIndex = i
          chainPosIndex = j
        end
      end
    end
  end
  if 0 < chainPathIndex and 0 < chainPosIndex then
    retPath = self._n25BChainPaths[chainPathIndex]
    retPath = table.sub(retPath, 1, chainPosIndex)
  end
  return retPath
end

function UtilCalcServiceShare:_GetPosIndexListByOffset(posIndex, offsetList)
  local posIndexList = {}
  for _, offset in ipairs(offsetList) do
    local offsetVec = Vector2(offset[1], offset[2])
    local index = posIndex + Vector2.Pos2Index(offsetVec)
    table.insert(posIndexList, index)
  end
  return posIndexList
end

function UtilCalcServiceShare:_MoveOneStep(casterEntity)
  local pos = casterEntity:GetGridPosition()
  local chainPath = {pos}
  local boardCmpt = self._world:GetBoardEntity():Board()
  local blockFlag = BlockFlag.MonsterLand
  if casterEntity:MonsterID():GetMonsterRaceType() == MonsterRaceType.Fly then
    blockFlag = BlockFlag.MonsterFly
  end
  local randPosList = {}
  for _, offset in ipairs(Offset8) do
    local offsetVec = Vector2(offset[1], offset[2])
    local newPos = pos + offsetVec
    if not boardCmpt:IsPosBlock(newPos, blockFlag) then
      table.insert(randPosList, newPos)
    end
  end
  if 0 < #randPosList then
    local randomSvc = self._world:GetService("RandomLogic")
    local randIdx = randomSvc:LogicRand(1, #randPosList)
    chainPath[#chainPath + 1] = randPosList[randIdx]
  end
  return chainPath
end

function UtilCalcServiceShare:_CalcHighConnectRateCutLen(casterEntity)
  local connectMap = self._n25BConnectMap
  local playerPos = casterEntity:GetGridPosition()
  local playerPosIndex = Vector2.Pos2Index(playerPos)
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

function UtilCalcServiceShare:_CalcChainPathComplexityLen(chainPathIdx)
  if self._HighConnectRateCutLen > 0 then
    return self._HighConnectRateCutLen
  end
  local m = BattleConst.AutoFightMoveEnhanced and 2 or 1
  local cc = 1
  local len = #chainPathIdx
  for i, idx in ipairs(chainPathIdx) do
    cc = cc * table.count(self._n25BConnectMap[idx])
    if cc > BattleConst.AutoFightPathComplexity[m] then
      len = i - 1
      break
    end
  end
  return len
end

function UtilCalcServiceShare:FindPath_MonsterMoveGridByParam2(casterEntity, targetEntity, pieceTypeList, moveType)
  local targetCenterPos = targetEntity:GetGridPosition()
  local casterPos = casterEntity:GetGridPosition()
  local boardCmpt = self._world:GetBoardEntity():Board()
  local blockFlag = BlockFlag.MonsterLand
  if casterEntity:MonsterID():GetMonsterRaceType() == MonsterRaceType.Fly then
    blockFlag = BlockFlag.MonsterFly
  end
  self._n25BossBlockCanMoveMap = boardCmpt:GetBlockFlagCanMoveMap(blockFlag)
  local posCanLink = self:_MonsterFindAllPosCanLinkByPieceTypeList(casterPos, pieceTypeList)
  local movePath = {}
  local tarMovePos
  if moveType == MovePathType.Far then
    tarMovePos = self:_FindPos_FarFromTarget(targetCenterPos, posCanLink)
  elseif moveType == MovePathType.NearCross or moveType == MovePathType.NearAround then
    local offsetList = moveType == MovePathType.NearCross and Offset4 or Offset8
    tarMovePos = self:_FindPos_NearToTarget(targetCenterPos, posCanLink, offsetList)
  end
  if tarMovePos then
    movePath = self:_GetMonster2PosLinkPathByPieceTypeList(casterPos, tarMovePos, pieceTypeList)
  end
  if table.count(movePath) == 0 then
    local compareType = AiSortByDistance._ComparerByFar
    if moveType ~= MovePathType.Far then
      compareType = AiSortByDistance._ComparerByNear
    end
    local targetPos = self:_FindPos_AroundPosByCompare(casterPos, targetCenterPos, compareType)
    if targetPos and targetPos ~= casterPos then
      movePath = {casterPos, targetPos}
    end
  end
  boardCmpt:ClearBlockFlagCanMoveMap(blockFlag)
  self._n25BossBlockCanMoveMap = {}
  return movePath
end

function UtilCalcServiceShare:_FindPos_AroundPosByCompare(pos, targetCenterPos, compare)
  local validSkillRange = {pos}
  for _, offset in ipairs(Offset8) do
    local offsetVec = Vector2(offset[1], offset[2])
    local newPos = pos + offsetVec
    local newPosIndex = Vector2.Pos2Index(newPos)
    if self._n25BossBlockCanMoveMap[newPosIndex] then
      table.insert(validSkillRange, newPos)
    end
  end
  local targetPos = self:FindPosToTarget(targetCenterPos, validSkillRange, compare)
  return targetPos
end

function UtilCalcServiceShare:_FindPos_FarFromTarget(targetCenterPos, posCanLink)
  local skillRange = {}
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  local boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  for x = 1, boardMaxX do
    for y = 1, boardMaxY do
      local pos = Vector2(x, y)
      table.insert(skillRange, pos)
    end
  end
  local validSkillRange = self:FilterSkillRangePos(skillRange, posCanLink)
  local tarMovePos
  if 0 < #validSkillRange then
    tarMovePos = self:FindPosToTarget(targetCenterPos, validSkillRange, AiSortByDistance._ComparerByFar)
  else
    tarMovePos = self:FindPosToTarget(targetCenterPos, posCanLink, AiSortByDistance._ComparerByFar)
  end
  return tarMovePos
end

function UtilCalcServiceShare:_FindPos_NearToTarget(targetCenterPos, posCanLink, offsetList)
  local skillRange = {}
  for _, offset in ipairs(offsetList) do
    local offsetVec = Vector2(offset[1], offset[2])
    local newPos = targetCenterPos + offsetVec
    table.insert(skillRange, newPos)
  end
  local validSkillRange = self:FilterSkillRangePos(skillRange, posCanLink)
  local tarMovePos
  if 0 < #validSkillRange then
    tarMovePos = self:FindPosToTarget(targetCenterPos, validSkillRange, AiSortByDistance._ComparerByFar)
  else
    tarMovePos = self:FindPosToTarget(targetCenterPos, posCanLink, AiSortByDistance._ComparerByFar)
  end
  return tarMovePos
end

function UtilCalcServiceShare:FilterSkillRangePos(skillRange, posCanLink)
  local retRange = {}
  for _, pos in ipairs(skillRange) do
    local posIndex = Vector2.Pos2Index(pos)
    if posCanLink[posIndex] then
      table.insert(retRange, pos)
    end
  end
  return retRange
end

function UtilCalcServiceShare:_MonsterFindAllPosCanLinkByPieceTypeList(startPos, pieceTypeList)
  local monsterPos = startPos
  local retCanLink = {}
  local boardCmpt = self._world:GetBoardEntity():Board()
  for _, offset in ipairs(Offset8) do
    local offsetVec = Vector2(offset[1], offset[2])
    local newPos = monsterPos + offsetVec
    local newPosIndex = Vector2.Pos2Index(newPos)
    if self._n25BossBlockCanMoveMap[newPosIndex] then
      local surroundPiece = boardCmpt:GetPieceTypeByIndex(newPosIndex)
      if CanMatchPieceTypeList(surroundPiece, pieceTypeList) then
        if not retCanLink[newPosIndex] then
          retCanLink[newPosIndex] = newPos
        end
        self:_MonsterGetConnectPosListByPieceTypeList(newPos, pieceTypeList, retCanLink)
      end
    end
  end
  return retCanLink
end

function UtilCalcServiceShare:_MonsterGetConnectPosListByPieceTypeList(pos, pieceTypeList, list)
  local newPosAroundPosList = self:_GetPosValidAround(pos, pieceTypeList)
  for _, newPos in ipairs(newPosAroundPosList) do
    local index = Vector2.Pos2Index(newPos)
    if not list[index] then
      list[index] = newPos
      self:_MonsterGetConnectPosListByPieceTypeList(newPos, pieceTypeList, list)
    end
  end
end

function UtilCalcServiceShare:FindPosToTarget(targetCenterPos, validRange, compare)
  local posReturn
  local posList = SortedArray:New(Algorithm.COMPARE_CUSTOM, compare)
  posList:AllowDuplicate()
  posList:Clear()
  for index, validPos in ipairs(validRange) do
    self:InsertSortedArray(posList, targetCenterPos, validPos, index)
  end
  if posList and posList:Size() > 0 then
    local sortData = posList:GetAt(1)
    posReturn = sortData.data
  end
  return posReturn
end

function UtilCalcServiceShare:InsertSortedArray(sortedArray, centerPos, workPos, nIndex)
  local posData = AiSortByDistance:New(centerPos, workPos, nIndex)
  sortedArray:Insert(posData)
end

function UtilCalcServiceShare:_GetMonster2PosLinkPathByPieceTypeList(casterPos, targetPos, pieceTypeList)
  local retPath = {}
  local bTargetCanConnect = true
  if bTargetCanConnect then
    local function getFinalValidPosFunc(pos)
      local posList = {}
      
      table.insert(posList, pos)
      return posList
    end
    
    local function getAroundValidPosFunc(pos, pieceTypeList)
      return self:_GetPosValidAround(pos, pieceTypeList)
    end
    
    local path = self:CalcPos2PosShortestPath(casterPos, targetPos, pieceTypeList, getFinalValidPosFunc, getAroundValidPosFunc)
    if path and 0 < #path then
      if #retPath == 0 then
        retPath = path
      end
      if #path < #retPath then
        retPath = path
      end
    end
  end
  return retPath
end

function UtilCalcServiceShare:_GetPosValidAround(pos, pieceTypeList)
  local boardCmpt = self._world:GetBoardEntity():Board()
  local newPosAroundPosList = {}
  for _, offset in ipairs(Offset8) do
    local offsetVec = Vector2(offset[1], offset[2])
    local newPos = pos + offsetVec
    local newPosIndex = Vector2.Pos2Index(newPos)
    if self._n25BossBlockCanMoveMap[newPosIndex] then
      local surroundPiece = boardCmpt:GetPieceTypeByIndex(newPosIndex)
      if CanMatchPieceTypeList(surroundPiece, pieceTypeList) then
        table.insert(newPosAroundPosList, newPos)
      end
    end
  end
  return newPosAroundPosList
end

function UtilCalcServiceShare:CalcSkillTargetEffect(casterEntityID, skillID, skillEffectType)
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local casterPos = casterEntity:GetGridPosition()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local skillTargetType = skillConfigData:GetSkillTargetType()
  local skillEffectArray = skillConfigData:GetSkillEffect()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillEffectCalcService = self._world:GetService("SkillEffectCalc")
  local skillResultList = {}
  for _, skillEffect in ipairs(skillEffectArray) do
    if skillEffect:GetEffectType() == skillEffectType then
      local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, casterPos, casterEntity)
      local targetIDList = utilScopeSvc:SelectSkillTarget(casterEntity, skillTargetType, scopeResult)
      local skillEffectCalcParam = SkillEffectCalcParam:New(casterEntityID, targetIDList, skillEffect, skillID)
      local skillResult = skillEffectCalcService:CalcSkillEffectByType(skillEffectCalcParam)
      if skillResult then
        table.appendArray(skillResultList, skillResult)
      end
    end
  end
  return skillResultList
end

function UtilCalcServiceShare:GetDirNormalize(pos, targetPos)
  local vectors = {
    Vector2(-1, 0),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(0, 1)
  }
  local minIdx, minAngle = 1, 180
  local vec = targetPos - pos
  for i, v in ipairs(vectors) do
    local angle = Vector2.Angle(vec, v)
    if minAngle > angle then
      minAngle = angle
      minIdx = i
    end
  end
  return vectors[minIdx]
end

function UtilCalcServiceShare:GetCastSkillOnMovePosByNotify(notify)
  local retPos
  if notify:GetNotifyType() == NotifyType.PlayerEachMoveEnd then
    retPos = notify:GetPosNew()
  elseif notify:GetNotifyType() == NotifyType.TrapSkillStart then
    retPos = notify:GetNotifyPos()
  end
  return retPos
end

function UtilCalcServiceShare:GetCurrentChainPathIndex_ChenNiEquip(entity)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainPath = logicChainPathCmpt:GetLogicChainPath()
  local chainIndex = 0
  if self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    chainIndex = #chainPath
  else
    local entityPos = entity:GetGridPosition()
    for index, value in ipairs(chainPath) do
      if entityPos == value then
        chainIndex = index
      end
    end
  end
  return chainIndex
end

function UtilCalcServiceShare:GetCurrentChainRate_ChenNiEquip(entity)
  local chainIndex = self:GetCurrentChainPathIndex_ChenNiEquip(entity)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainRate = logicChainPathCmpt:GetChainRateAtIndex(chainIndex)
  return chainRate
end

function UtilCalcServiceShare:GetCurrentSupperGridNum_ChenNiEquip(entity)
  local chainIndex = self:GetCurrentChainPathIndex_ChenNiEquip(entity)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local superGridNum = logicChainPathCmpt:GetSuperGridCountAtPathIndex(chainIndex)
  return superGridNum
end

function UtilCalcServiceShare:GetCurrentPoorGridNum_ChenNiEquip(entity)
  local chainIndex = self:GetCurrentChainPathIndex_ChenNiEquip(entity)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local poorGridNum = logicChainPathCmpt:GetPoorGridCountAtPathIndex(chainIndex)
  return poorGridNum
end

function UtilCalcServiceShare:GetTeamPrimaryTypeCount(casterEntity)
  local teamEntity
  if casterEntity and casterEntity:HasPet() then
    teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  elseif casterEntity and casterEntity:HasTeam() then
    teamEntity = casterEntity
  else
    teamEntity = self._world:Player():GetCurrentTeamEntity()
  end
  local teamPetEntities = teamEntity:Team():GetTeamPetEntities()
  local primaryTypeList = {}
  for i, petEntity in ipairs(teamPetEntities) do
    local element = petEntity:Element():GetPrimaryType()
    if not table.intable(primaryTypeList, element) then
      table.insert(primaryTypeList, element)
    end
  end
  return #primaryTypeList
end

function UtilCalcServiceShare:IsPetCurRoundCastActiveSkill(petEntity)
  local activeSkillID = petEntity:SkillInfo():GetActiveSkillID()
  local petPstIDComponent = petEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  if not activeSkillID then
    local petData = self._world:GetPetData(petPstID)
    activeSkillID = petData:GetPetActiveSkill()
  end
  local battleStatComponent = self._world:BattleStat()
  local lastDoActiveSkillRound = battleStatComponent:GetLastDoActiveSkillRound(petPstID)
  local curRound = battleStatComponent:GetLevelTotalRoundCount()
  return lastDoActiveSkillRound == curRound
end

function UtilCalcServiceShare:_CalcHitBackDirBossCarrot(casterCenterPos, casterBodyArea, defenderPos, casterEntity, defenderEntity, clockWiseRate)
  local clockWisePos = self:_CalcNextClockWisePosInRing(casterCenterPos, casterBodyArea, defenderPos, casterEntity, defenderEntity)
  if clockWisePos == defenderPos then
    return Vector2(0, 0), 0
  else
    local clockWiseDir = clockWisePos - defenderPos
    local randomServiceLogic = self._world:GetService("RandomLogic")
    local r = randomServiceLogic:LogicRand()
    if clockWiseRate > r then
      return clockWiseDir, 1
    else
      local retDir = Vector2(clockWiseDir.y, -1 * clockWiseDir.x)
      return retDir, 1
    end
  end
end

function UtilCalcServiceShare:_CalcNextClockWisePosInRing(casterCenterPos, casterBodyArea, defenderPos, casterEntity, defenderEntity)
  local currentRingNum, nearestPos, useOffV2 = self:GetGridRingNumWithBodyArea(casterCenterPos, defenderPos, casterBodyArea)
  local onlyMax = true
  local ringRange = ComputeScopeRange.ComputeRange_SquareRing(casterCenterPos, #casterBodyArea, currentRingNum, onlyMax)
  if table.count(ringRange) > 0 then
    local sortList = {}
    for _, pos in ipairs(ringRange) do
      local radAngle, ringLen = self:CalcClockWiseRadAngle(Vector2.up, casterCenterPos, pos)
      local sortData = {_pos = pos, _rad = radAngle}
      table.insert(sortList, sortData)
    end
    table.sort(sortList, function(a, b)
      return a._rad > b._rad
    end)
    local defenderPosIndex = 0
    local maxIndex = #sortList
    for index, data in ipairs(sortList) do
      if data._pos == defenderPos then
        defenderPosIndex = index
        break
      end
    end
    if 0 < defenderPosIndex then
      local nextPosIndex = defenderPosIndex + 1
      if maxIndex < nextPosIndex then
        nextPosIndex = 1
      end
      local nextPos = sortList[nextPosIndex]._pos
      if defenderEntity then
        if self:CanHitBackToPos(defenderEntity, nextPos) then
          return nextPos
        end
      else
        return nextPos
      end
    end
  end
  return defenderPos
end

function UtilCalcServiceShare:CalcClockWiseRadAngle(refvec, origin, point)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local dirVec = point - origin
  local lenVector = utilCalcSvc:GetGridRingNum(point, origin)
  if lenVector == 0 then
    return -math.pi, 0
  end
  local normalized = dirVec.normalized
  local dotprod = normalized.x * refvec.x + normalized.y * refvec.y
  local diffprod = refvec.y * normalized.x - refvec.x * normalized.y
  local angle = math.atan(diffprod, dotprod)
  if angle < 0 then
    return 2 * math.pi + angle, lenVector
  end
  return angle, lenVector
end

function UtilCalcServiceShare:ChangeAlchemyPower(petEntity, newPower, needNT)
  local teamEntity = petEntity:Pet():GetOwnerTeamEntity()
  local petEntityList = teamEntity:Team():GetTeamPetEntities()
  local holdEntityActiveSkillID = petEntity:SkillInfo():GetActiveSkillID()
  local petPowerStateList = {}
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(holdEntityActiveSkillID, petEntity)
  local cfgExtraParam = skillConfigData:GetSkillTriggerExtraParam()
  local groupID = cfgExtraParam[SkillTriggerTypeExtraParam.SameAlchemyEnergyID]
  local blsvc = self._world:GetService("BuffLogic")
  local readyList = {}
  for i, pet in ipairs(petEntityList) do
    local activeSkillID = pet:SkillInfo():GetActiveSkillID()
    local tmpConfig = configService:GetSkillConfigData(activeSkillID, pet)
    local tmpCfgExtraParam = tmpConfig:GetSkillTriggerExtraParam()
    local tmpPower = tmpConfig:GetSkillTriggerParam()
    if tmpCfgExtraParam then
      local tmpGroupID = tmpCfgExtraParam[SkillTriggerTypeExtraParam.SameAlchemyEnergyID]
      if tmpGroupID == groupID then
        local petPstIDComponent = pet:PetPstID()
        local petPstID = petPstIDComponent:GetPstID()
        local requireNTPowerReady = false
        local ready = false
        local previouslyReady = newPower >= tmpPower
        if previouslyReady and not self:IsPetCurRoundCastActiveSkill(pet) then
          blsvc:ChangePetActiveSkillReady(pet, 1, activeSkillID)
          ready = true
          if needNT then
            local notify = NTPowerReady:New(pet)
            self._world:GetService("Trigger"):Notify(notify)
            requireNTPowerReady = true
          end
        else
          ready = false
          blsvc:ChangePetActiveSkillReady(pet, 0, activeSkillID)
        end
        local curAttributeCmpt = pet:Attributes()
        curAttributeCmpt:Modify("AlchemyPower", newPower)
        if not petPowerStateList[petPstID] then
          petPowerStateList[petPstID] = {}
        end
        petPowerStateList[petPstID].petEntityID = pet:GetID()
        petPowerStateList[petPstID].petPstID = petPstID
        petPowerStateList[petPstID].power = newPower
        petPowerStateList[petPstID].ready = ready
        petPowerStateList[petPstID].previouslyReady = previouslyReady
        petPowerStateList[petPstID].requireNTPowerReady = requireNTPowerReady
      end
    end
  end
  return petPowerStateList
end

function UtilCalcServiceShare:IsBlackFistRemoteEntity(entity)
  local remoteTeam = self._world:Player():GetRemoteTeamEntity()
  if remoteTeam then
    local teamMembers = remoteTeam:Team():GetTeamPetEntities()
    for i, e in ipairs(teamMembers) do
      if e:GetID() == entity:GetID() then
        return true
      end
    end
    return remoteTeam:GetID() == entity:GetID()
  end
  return false
end

function UtilCalcServiceShare:GetBuffLogicValue(entity, buffKey)
  if entity:BuffComponent() then
    return entity:BuffComponent():GetBuffValue(buffKey)
  end
end

function UtilCalcServiceShare:TurnTetrisDir()
  local featureSvcL = self._world:GetService("FeatureLogic")
  local dirType, dirIndex = featureSvcL:TurnTetrisDir()
  if dirType == HitBackDirectionType.Up then
    return Vector2.up, dirIndex
  elseif dirType == HitBackDirectionType.Left then
    return Vector2.left, dirIndex
  elseif dirType == HitBackDirectionType.Down then
    return Vector2.down, dirIndex
  elseif dirType == HitBackDirectionType.Right then
    return Vector2.right, dirIndex
  end
end

function UtilCalcServiceShare:FindMonsterByMoveGroupID(moveGroupID)
  local monsterEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  local retEntityList = {}
  for i, entity in ipairs(monsterEntities) do
    local monsterIDCmpt = entity:MonsterID()
    local curMoveGroupID = monsterIDCmpt:GetMoveGroupID()
    if curMoveGroupID and moveGroupID == curMoveGroupID then
      table.insert(retEntityList, entity)
    end
  end
  return retEntityList
end

function UtilCalcServiceShare:IsMonsterMoveGroupIDValid(moveGroupID)
  local monsterGroupList = self:FindMonsterByMoveGroupID(moveGroupID)
  return 1 < #monsterGroupList
end

function UtilCalcServiceShare:IsNeedShowMoveGroupLine(pos1, pos2)
  if pos1.x == pos2.x and math.abs(pos1.y - pos2.y) == 1 then
    return true
  end
  if pos1.y == pos2.y and math.abs(pos1.x - pos2.x) == 1 then
    return true
  end
  return false
end

function UtilCalcServiceShare:RemoveEntityBlockFlag(e, posOld)
  local sBoard = self._world:GetService("BoardLogic")
  return sBoard:RemoveEntityBlockFlag(e, posOld)
end

function UtilCalcServiceShare:SetEntityBlockFlag(e, pos, blockFlag)
  local sBoard = self._world:GetService("BoardLogic")
  return sBoard:SetEntityBlockFlag(e, pos, blockFlag)
end
