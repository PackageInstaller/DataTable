_class("SkillEffectCalc_TeleportTeamAroundAndSummonTrapLine", SkillEffectCalc_Base)
SkillEffectCalc_TeleportTeamAroundAndSummonTrapLine = SkillEffectCalc_TeleportTeamAroundAndSummonTrapLine

function SkillEffectCalc_TeleportTeamAroundAndSummonTrapLine:Constructor(world)
  self._world = world
end

function SkillEffectCalc_TeleportTeamAroundAndSummonTrapLine:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillParam = skillEffectCalcParam.skillEffectParam
  local squareRingStart = skillParam:GetSquareRingStart()
  local caster = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local casterBodyArea = caster:BodyArea():GetArea()
  local casterPos = caster:GetGridPosition()
  local casterDir = caster:GetGridDirection()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local playerBodyArea = teamEntity:BodyArea():GetArea()
  local posNew, dirNew, bodyAreaNew = self:_CalcPosAndDir(skillEffectCalcParam, squareRingStart)
  if not posNew then
    posNew = casterPos
    dirNew = casterDir
    bodyAreaNew = casterBodyArea
  end
  local skillEffectResultContainer = caster:SkillContext():GetResultContainer()
  local sSkillEffectCalc = self._world:GetService("SkillEffectCalc")
  local utilData = self._world:GetService("UtilData")
  local colorOld = utilData:FindPieceElement(casterPos)
  local stageIndex = skillEffectCalcParam.skillEffectParam:GetSkillEffectDamageStageIndex()
  local skillEffectResult_Teleport = SkillEffectResult_Teleport:New(skillEffectCalcParam.casterEntityID, casterPos, colorOld, posNew, dirNew, stageIndex)
  skillEffectResultContainer:AddEffectResult(skillEffectResult_Teleport)
  if dirNew ~= casterDir then
    local skillRotateEffectResult = SkillRotateEffectResult:New(caster:GetID(), casterDir, dirNew)
    skillEffectResultContainer:AddEffectResult(skillRotateEffectResult)
    local skillEffectResultChangeBodyArea = SkillEffectResultChangeBodyArea:New(caster:GetID(), bodyAreaNew)
    skillEffectResultContainer:AddEffectResult(skillEffectResultChangeBodyArea)
  end
  local trapID = skillParam:GetTrapID()
  if not trapID then
    return
  end
  local limitCount = skillParam:GetLimitCount()
  local summonPosList = {}
  local widthThreshold = 0.7
  summonPosList = self:_CalcSummonPosWithAngleFreeLine(caster, posNew, skillParam, widthThreshold)
  if limitCount > table.count(summonPosList) then
    widthThreshold = 1.414
    summonPosList = self:_CalcSummonPosWithAngleFreeLine(caster, posNew, skillParam, widthThreshold)
  end
  if limitCount > table.count(summonPosList) then
    for i = 1, BattleConst.DefaultMaxX do
      local ringCount = i
      local summonPosAroundTeam = {}
      summonPosAroundTeam = self:_CalcSummonPosAroundTeam(caster, posNew, skillParam, ringCount)
      for _, pos in ipairs(summonPosAroundTeam) do
        if not table.intable(summonPosList, pos) and utilData:IsValidPiecePos(pos) then
          table.insert(summonPosList, pos)
        end
        if limitCount <= table.count(summonPosList) then
          break
        end
      end
      if limitCount <= table.count(summonPosList) then
        break
      end
    end
  end
  if table.count(summonPosList) > 0 then
    table.sort(summonPosList, function(a, b)
      local disA = Vector2.Distance(posNew, a)
      local disB = Vector2.Distance(posNew, b)
      return disA > disB
    end)
  end
  for _, pos in ipairs(summonPosList) do
    local skillSummonTrapEffectResult = SkillSummonTrapEffectResult:New(trapID, pos)
    skillEffectResultContainer:AddEffectResult(skillSummonTrapEffectResult)
  end
end

function SkillEffectCalc_TeleportTeamAroundAndSummonTrapLine:_CalcPosAndDir(skillEffectCalcParam, ringCount)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local playerBodyArea = teamEntity:BodyArea():GetArea()
  local caster = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local casterBodyArea = caster:BodyArea():GetArea()
  local casterPos = caster:GetGridPosition()
  local casterDir = caster:GetGridDirection()
  local utilDataSvc = self._world:GetService("UtilData")
  local casterBodyAreaPosList = {}
  for _, area in ipairs(casterBodyArea) do
    local workPos = area + casterPos
    table.insert(casterBodyAreaPosList, workPos)
  end
  local rangCoungMin = math.max(1, ringCount - 1)
  local attackRangeOne = {}
  local attackRangeTwo = {}
  if ringCount == 1 then
    attackRangeTwo = ComputeScopeRange.ComputeRange_SquareRing(playerPos, #playerBodyArea, ringCount)
    attackRangeOne = attackRangeTwo
  else
    local attackRangeMax = ComputeScopeRange.ComputeRange_SquareRing(playerPos, #playerBodyArea, 9)
    local attackRangeMin = ComputeScopeRange.ComputeRange_SquareRing(playerPos, #playerBodyArea, ringCount)
    for _, pos in ipairs(attackRangeMin) do
      table.removev(attackRangeMax, pos)
    end
    for _, pos in ipairs(attackRangeMin) do
      if utilDataSvc:IsValidPiecePos(pos) then
        table.insert(attackRangeTwo, pos)
      end
    end
  end
  local centerAndDirList = {}
  for _, pos in ipairs(attackRangeTwo) do
    local dirs = {
      Vector2(0, -1),
      Vector2(0, 1),
      Vector2(1, 0),
      Vector2(-1, 0)
    }
    if rangCoungMin == 1 then
      if pos.y >= playerPos.y then
        dirs = {
          Vector2(0, -1),
          Vector2(1, 0),
          Vector2(-1, 0)
        }
      elseif pos.y <= playerPos.y then
        dirs = {
          Vector2(0, 1),
          Vector2(1, 0),
          Vector2(-1, 0)
        }
      elseif pos.x >= playerPos.x then
        dirs = {
          Vector2(0, -1),
          Vector2(0, 1),
          Vector2(1, 0)
        }
      elseif pos.x <= playerPos.x then
        dirs = {
          Vector2(0, -1),
          Vector2(0, 1),
          Vector2(-1, 0)
        }
      end
    else
      local vectors = {
        Vector2(-1, 0),
        Vector2(1, 0),
        Vector2(0, -1),
        Vector2(0, 1)
      }
      if playerPos == utilDataSvc:GetBoardCenterPos() then
        if pos.y > playerPos.y then
          table.removev(dirs, Vector2(0, 1))
        end
        if pos.y < playerPos.y then
          table.removev(dirs, Vector2(0, -1))
        end
        if pos.x > playerPos.x then
          table.removev(dirs, Vector2(1, 0))
        end
        if pos.x < playerPos.x then
          table.removev(dirs, Vector2(-1, 0))
        end
      else
        local minIdx, minAngle = 1, 180
        local vec = playerPos - pos
        for i, v in ipairs(vectors) do
          local angle = Vector2.Angle(vec, v)
          if minAngle > angle then
            minAngle = angle
            minIdx = i
          end
        end
        local newDir = vectors[minIdx]
        dirs = {newDir}
      end
    end
    for i, dir in ipairs(dirs) do
      if table.count(casterBodyArea) == 6 then
        local newBodyArea = casterBodyArea
        if dir == Vector2(0, -1) then
          newBodyArea = {
            Vector2(0, 0),
            Vector2(1, 0),
            Vector2(-1, 0),
            Vector2(0, 1),
            Vector2(1, 1),
            Vector2(-1, 1)
          }
        elseif dir == Vector2(1, 0) then
          newBodyArea = {
            Vector2(0, 0),
            Vector2(0, 1),
            Vector2(0, -1),
            Vector2(-1, 0),
            Vector2(-1, 1),
            Vector2(-1, -1)
          }
        elseif dir == Vector2(-1, 0) then
          newBodyArea = {
            Vector2(0, 0),
            Vector2(0, 1),
            Vector2(0, -1),
            Vector2(1, 0),
            Vector2(1, 1),
            Vector2(1, -1)
          }
        elseif dir == Vector2(0, 1) then
          newBodyArea = {
            Vector2(0, 0),
            Vector2(-1, 0),
            Vector2(1, 0),
            Vector2(0, -1),
            Vector2(-1, -1),
            Vector2(1, -1)
          }
        end
        casterBodyArea = newBodyArea
      end
      local canMove = true
      local posInTargetAround = false
      for k, area in ipairs(casterBodyArea) do
        local workPos = area + pos
        if utilDataSvc:IsPosBlock(workPos, BlockFlag.MonsterLand) and not table.intable(casterBodyAreaPosList, workPos) then
          canMove = false
          break
        end
        if rangCoungMin ~= 1 or table.intable(attackRangeOne, workPos) then
          posInTargetAround = true
        end
      end
      if canMove and posInTargetAround then
        table.insert(centerAndDirList, {
          pos = pos,
          dir = dir,
          bodyArea = casterBodyArea
        })
      end
    end
  end
  local targetPos = casterPos
  local targetDir = casterDir
  local bodyAreaNew = casterBodyArea
  if 0 < table.count(centerAndDirList) then
    table.sort(centerAndDirList, function(a, b)
      local disA = Vector2.Distance(casterPos, a.pos)
      local disB = Vector2.Distance(casterPos, b.pos)
      return disA > disB
    end)
    targetDir = centerAndDirList[1].dir
    targetPos = centerAndDirList[1].pos
    bodyAreaNew = centerAndDirList[1].bodyArea
  else
  end
  if not targetPos and ringCount < BattleConst.DefaultMaxX then
    local newRingCount = ringCount + 1
    return self:_CalcPosAndDir(skillEffectCalcParam, newRingCount)
  end
  return targetPos, targetDir, bodyAreaNew
end

function SkillEffectCalc_TeleportTeamAroundAndSummonTrapLine:_CalcSummonPosWithAngleFreeLine(casterEntity, targetPos, skillParam, widthThreshold)
  local trapID = skillParam:GetTrapID()
  local limitCount = skillParam:GetLimitCount()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local utilData = self._world:GetService("UtilData")
  local trapServerLogic = self._world:GetService("TrapLogic")
  local tarpPosList = trapServerLogic:FindTrapPosByTrapID(trapID)
  local curPos = casterEntity:GetGridPosition()
  local curBodyArea = casterEntity:BodyArea():GetArea()
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeParam = {widthThreshold = widthThreshold, noExtend = 1}
  local scopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.AngleFreeLine, scopeParam, targetPos, curBodyArea, nil, nil, curPos)
  local attackRange = scopeResult:GetAttackRange()
  
  local function CmpDistancefunc(pos1, pos2)
    local dis1 = Vector2.Distance(curPos, pos1)
    local dis2 = Vector2.Distance(curPos, pos2)
    return dis1 > dis2
  end
  
  table.sort(attackRange, CmpDistancefunc)
  local supplementPosList = {}
  for k, pos in ipairs(attackRange) do
    local nextPos = attackRange[k + 1]
    if not nextPos then
      break
    end
    if math.abs(pos.x - nextPos.x) == 1 and math.abs(pos.y - nextPos.y) == 1 then
      local remainPosList = {}
      local intableCount = 0
      local diffX = nextPos.x - pos.x
      local diffY = nextPos.y - pos.y
      for i = pos.x, nextPos.x, diffX do
        for j = pos.y, nextPos.y, diffY do
          local workPos = Vector2(i, j)
          if table.intable(attackRange, workPos) then
            intableCount = intableCount + 1
          elseif workPos ~= pos and workPos ~= nextPos then
            local isValidGrid = utilData:IsValidPiecePos(workPos)
            if isValidGrid then
              table.insert(remainPosList, workPos)
            end
          end
        end
      end
      if 0 < table.count(remainPosList) and intableCount == 2 then
        table.insert(supplementPosList, remainPosList[1])
      end
    end
  end
  table.appendArray(attackRange, supplementPosList)
  local summonPosList = {}
  for _, pos in ipairs(attackRange) do
    if not table.intable(summonPosList, pos) and not table.intable(tarpPosList, pos) and pos ~= teamPos then
      table.insert(summonPosList, pos)
    end
  end
  return summonPosList
end

function SkillEffectCalc_TeleportTeamAroundAndSummonTrapLine:_CalcSummonPosAroundTeam(casterEntity, posNew, skillParam, ringCount)
  local trapID = skillParam:GetTrapID()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local playerBodyArea = teamEntity:BodyArea():GetArea()
  local attackRangeOutSide = ComputeScopeRange.ComputeRange_SquareRing(playerPos, #playerBodyArea, ringCount)
  if 1 < ringCount then
    local attackRangeInSide = ComputeScopeRange.ComputeRange_SquareRing(playerPos, #playerBodyArea, ringCount - 1)
    for _, pos in ipairs(attackRangeInSide) do
      table.removev(attackRangeOutSide, pos)
    end
  end
  local trapServerLogic = self._world:GetService("TrapLogic")
  local tarpPosList = trapServerLogic:FindTrapPosByTrapID(trapID)
  local summonPosList = {}
  for _, pos in ipairs(attackRangeOutSide) do
    if not table.intable(summonPosList, pos) and not table.intable(tarpPosList, pos) then
      table.insert(summonPosList, pos)
    end
  end
  if table.count(summonPosList) > 0 then
    table.sort(summonPosList, function(a, b)
      local disA = Vector2.Distance(posNew, a)
      local disB = Vector2.Distance(posNew, b)
      return disA < disB
    end)
  end
  return summonPosList
end
