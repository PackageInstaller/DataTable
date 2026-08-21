_class("SkillEffectCalc_RobotBomb", SkillEffectCalc_Base)
SkillEffectCalc_RobotBomb = SkillEffectCalc_RobotBomb

function SkillEffectCalc_RobotBomb:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._utilScopeSvc = self._world:GetService("UtilScopeCalc")
  self._utilCalcSvc = self._world:GetService("UtilCalc")
end

function SkillEffectCalc_RobotBomb:DoSkillEffectCalculator(skillEffectCalcParam, notPreview)
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local skillRange = skillEffectCalcParam:GetSkillRange()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local results = {}
  local robotParam = param:GetRobotBombParam()
  if robotParam then
    if robotParam.trapID then
      local trapLogicSvc = self._world:GetService("TrapLogic")
      local entityIDs = trapLogicSvc:FindTrapByTrapID(robotParam.trapID)
      if entityIDs[1] then
        local trapEntity = self._world:GetEntityByID(entityIDs[1])
        if trapEntity then
          local pos = trapEntity:GetGridPosition()
          local result = self:_CalcSingleRobotBomb(skillEffectCalcParam, casterEntity, pos, robotParam, trapEntity, notPreview)
          if result then
            table.insert(results, result)
          end
        end
      end
    else
      local pos = skillEffectCalcParam:GetCenterPos()
      pos = pos or casterEntity:GetGridPosition()
      local result = self:_CalcSingleRobotBomb(skillEffectCalcParam, casterEntity, pos, robotParam, nil, notPreview)
      if result then
        table.insert(results, result)
      end
    end
  end
  return results
end

function SkillEffectCalc_RobotBomb:_CalcSingleRobotBomb(skillEffectCalcParam, casterEntity, center, robotBombParam, trapEntity, notPreview)
  local utilDataSvc = self._world:GetService("UtilData")
  local singleResult = SkillEffectResultRobotBomb:New()
  local nearestMonster
  local monsters = self._utilScopeSvc:SortMonstersByPos(center, true)
  if monsters then
    for _, value in ipairs(monsters) do
      local monsterEntity = value.monster_e
      if not monsterEntity:HasDeadMark() then
        nearestMonster = monsterEntity
        break
      end
    end
  end
  if self._world:MatchType() == MatchType.MT_BlackFist then
    nearestMonster = self._world:Player():GetCurrentEnemyTeamEntity()
  end
  if nearestMonster then
    local skillConfigData = self._world:GetService("Config"):GetSkillConfigData(skillEffectCalcParam:GetSkillID(), casterEntity)
    local scopeType = skillConfigData:GetSkillScopeType()
    local scopeParam = skillConfigData:GetSkillScopeParam()
    local scopeCalculator = self._utilScopeSvc:GetSkillScopeCalc()
    local scopeResult = scopeCalculator:ComputeScopeRange(scopeType, scopeParam, center)
    local attackRange = scopeResult:GetAttackRange()
    local tartgetPos = nearestMonster:GetGridPosition()
    local bodyArea = nearestMonster:BodyArea():GetArea()
    local bodyAreaPosList = {}
    for _, body in ipairs(bodyArea) do
      local bodyPos = nearestMonster:GetGridPosition() + body
      table.insert(bodyAreaPosList, bodyPos)
    end
    table.sort(bodyAreaPosList, function(a, b)
      local disA = Vector2.Distance(center, a)
      local disB = Vector2.Distance(center, b)
      return disA < disB
    end)
    tartgetPos = bodyAreaPosList[1]
    local realPath = self:_OnCalcShortestPath(center, tartgetPos, {})
    for _, _position in ipairs(realPath) do
      if self:_InRange(_position, attackRange) then
        table.insert(singleResult.path, _position)
      end
    end
    if robotBombParam.recordCount > 0 then
      local board = self._world:GetBoardEntity():Board()
      for i = 1, robotBombParam.recordCount do
        local position = singleResult.path[i]
        if position then
          local pieceType = board:GetPieceType(position)
          Log.debug("SkillEffectCalc_RobotBomb:_CalcSingleRobotBomb ", position.x, position.y, robotBombParam.recordCount, pieceType)
          table.insert(singleResult.pieceTypes, pieceType)
        end
      end
    end
    local destination = singleResult.path[#singleResult.path]
    if destination then
      local scopeCalculator = self._utilScopeSvc:GetSkillScopeCalc()
      local scopeResult = scopeCalculator:ComputeScopeRange(robotBombParam.scopeType, robotBombParam.scopeParam, destination, casterEntity:BodyArea():GetArea())
      singleResult.explosionRange = scopeResult:GetAttackRange()
    end
    local monsters = self:GetMonstersInRange(singleResult.explosionRange)
    if not notPreview then
      for _, explosionPos in ipairs(singleResult.explosionRange) do
        local monster = utilDataSvc:GetMonsterAtPos(explosionPos)
        if self._world:MatchType() == MatchType.MT_BlackFist then
          local enemyTeamEntity = self._world:Player():GetCurrentEnemyTeamEntity()
          if enemyTeamEntity:GetGridPosition() == explosionPos then
            monster = enemyTeamEntity
          end
        end
        if monster then
          local damageResult = self:CalcDamageResult(skillEffectCalcParam, monster, explosionPos)
          if damageResult then
            table.insert(singleResult.damageResult, damageResult)
          end
        end
      end
    end
    if trapEntity then
      singleResult.trapEntityID = trapEntity:GetID()
    end
  end
  return singleResult
end

function SkillEffectCalc_RobotBomb:_InRange(position, range)
  local inRange = false
  for _, _position in ipairs(range) do
    if _position.x == position.x and _position.y == position.y then
      inRange = true
      break
    end
  end
  return inRange
end

function SkillEffectCalc_RobotBomb:GetMonstersInRange(range)
  local utilDataSvc = self._world:GetService("UtilData")
  local monsters = {}
  local ids = {}
  if range then
    for _, position in ipairs(range) do
      local monster = utilDataSvc:GetMonsterAtPos(position)
      if monster and not ids[monster:GetID()] then
        ids[monster:GetID()] = true
        table.insert(monsters, monster)
      end
    end
  end
  return monsters
end

function SkillEffectCalc_RobotBomb:CalcDamageResult(skillEffectCalcParam, monster, explosionPos)
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local damageResult
  local nTotalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(casterEntity, casterEntity:GetGridPosition(), monster, explosionPos, skillEffectCalcParam:GetSkillID(), skillEffectCalcParam:GetSkillEffectParam(), SkillEffectType.RobotBomb, 1)
  damageResult = self._skillEffectService:NewSkillDamageEffectResult(explosionPos, monster:GetID(), nTotalDamage, listDamageInfo)
  return damageResult
end

function SkillEffectCalc_RobotBomb:_OnCalcShortestPath(posStart, posEnd, chessPetPosList, lastMovePath)
  local dirs = {
    Vector2(0, 1),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(-1, 0)
  }
  local movePath = {posStart}
  local walkLastPos = posStart
  for i = 1, 9 do
    local sortPosList = {}
    for _, dir in ipairs(dirs) do
      local targetPos = walkLastPos + dir
      if not lastMovePath or lastMovePath and not table.intable(lastMovePath, targetPos) then
        table.insert(sortPosList, targetPos)
      end
    end
    local curMovePos = self:_OnCompareNearestPos(sortPosList, posEnd)
    table.insert(movePath, curMovePos)
    walkLastPos = movePath[#movePath]
    if walkLastPos == posEnd or walkLastPos == nil then
      break
    end
  end
  return movePath
end

function SkillEffectCalc_RobotBomb:_OnCompareNearestPos(posList, targetPos)
  local nearestPos = posList[1]
  for _, pos in ipairs(posList) do
    local dis1 = Vector2.Distance(nearestPos, targetPos)
    local dis2 = Vector2.Distance(pos, targetPos)
    if dis1 > dis2 then
      nearestPos = pos
    end
  end
  return nearestPos
end

function SkillEffectCalc_RobotBomb:_OnRangeOffset(range, newCenter)
  local count = #range
  local centerIndex = math.ceil(count / 2)
  local rangeCenter = range[centerIndex]
  local resultRange = {}
  for _, position in ipairs(range) do
    local x = position.x + (newCenter.x - rangeCenter.x)
    local y = position.y + (newCenter.y - rangeCenter.y)
    table.insert(resultRange, Vector2(x, y))
  end
  return resultRange
end
