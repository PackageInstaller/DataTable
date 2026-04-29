local SelectFarthestFormPlayerStage = {
  All = 0,
  Start = 1,
  Middle = 2,
  End = 3,
  FarthestMonsterCenter = 4,
  StartMonsterCenter = 5,
  EndMonsterCenter = 6
}
_enum("SelectFarthestFormPlayerStage", SelectFarthestFormPlayerStage)
require("scope_base")
_class("SkillScopeCalculator_SelectFarthestFormPlayer", SkillScopeCalculator_Base)
SkillScopeCalculator_SelectFarthestFormPlayer = SkillScopeCalculator_SelectFarthestFormPlayer

function SkillScopeCalculator_SelectFarthestFormPlayer:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if not scopeParam then
    Log.fatal("### scopeParam is nil. centerPos=", centerPos)
    return
  end
  local world = self._gridFilter._world
  local cfgService = world:GetService("Config")
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local boardServiceLogic = world:GetService("BoardLogic")
  local ai = scopeParam.ai
  local stage = scopeParam.stage
  local saveTable = scopeParam.saveTable
  local targetGroupEntities = {}
  local monsterGroup = world:GetGroup(world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local monsterID = e:MonsterID():GetMonsterID()
    local monsterAIIDList = monsterConfigData:GetMonsterAIID(monsterID)
    if monsterAIIDList[1][1] == ai and not e:HasDeadMark() and not e:HasDeadMark() then
      table.insert(targetGroupEntities, e)
    end
  end
  if #targetGroupEntities == 0 then
    return
  end
  local monsterPosList = {}
  for i, entity in ipairs(targetGroupEntities) do
    local bodyAreaList = entity:BodyArea():GetArea()
    local gridPos = entity:GridLocation():GetGridPos()
    for _, bodyArea in ipairs(bodyAreaList) do
      local workPos = gridPos + bodyArea
      table.insert(monsterPosList, workPos)
    end
  end
  local teamLeader = world:Player():GetCurrentTeamEntity()
  local teamPos = teamLeader:GridLocation().Position
  local sortedByDis = HelperProxy:SortPosByCenterPosDistance(teamPos, monsterPosList)
  local attackRange = {}
  for key, value in pairs(sortedByDis) do
    if value.x == teamPos.x or value.y == teamPos.y then
      table.insert(attackRange, value)
    end
  end
  if #attackRange == 0 then
    local playPos = sortedByDis[1]
    for key, value in pairs(sortedByDis) do
      if value.x == playPos.x or value.y == playPos.y then
        table.insert(attackRange, value)
      end
    end
  end
  local attackRange = HelperProxy:SortPosByCenterPosDistanceAnticlockwise(teamPos, attackRange)
  local targetPos
  if 0 < #attackRange then
    targetPos = attackRange[#attackRange]
  else
    targetPos = attackRange[#sortedByDis]
  end
  local maxX = boardServiceLogic:GetCurBoardMaxX()
  local maxY = boardServiceLogic:GetCurBoardMaxY()
  local yPosList = {}
  table.insert(yPosList, targetPos)
  for i = 1, maxY do
    local upPos = targetPos + Vector2.up * i
    local downPos = targetPos + Vector2.down * i
    if self._gridFilter:IsValidPiecePos(upPos) then
      table.insert(yPosList, upPos)
    end
    if self._gridFilter:IsValidPiecePos(downPos) then
      table.insert(yPosList, downPos)
    end
  end
  local xPosList = {}
  table.insert(xPosList, targetPos)
  for i = 1, maxX do
    local leftPos = targetPos + Vector2.left * i
    local rightPos = targetPos + Vector2.right * i
    if self._gridFilter:IsValidPiecePos(leftPos) then
      table.insert(xPosList, leftPos)
    end
    if self._gridFilter:IsValidPiecePos(rightPos) then
      table.insert(xPosList, rightPos)
    end
  end
  local targetPosList = {}
  targetPosList = #yPosList > #xPosList and yPosList or xPosList
  local disList = {}
  local neareestPos
  if table.intable(monsterPosList, targetPosList[1]) then
    table.insert(disList, targetPosList[1])
  end
  if table.intable(monsterPosList, targetPosList[#targetPosList]) then
    table.insert(disList, targetPosList[#targetPosList])
  end
  local attPosCountInRange = 0
  if #disList == 2 then
    local distanceSortList = HelperProxy:SortPosByCenterPosDistance(teamPos, disList)
    neareestPos = distanceSortList[1]
  else
    if not table.intable(monsterPosList, targetPosList[1]) then
      neareestPos = targetPosList[1]
    end
    if not table.intable(monsterPosList, targetPosList[#targetPosList]) then
      neareestPos = targetPosList[#targetPosList]
    end
  end
  targetPosList = HelperProxy:SortPosByCenterPosDistance(neareestPos, targetPosList)
  local resultScope = {}
  if stage == SelectFarthestFormPlayerStage.All then
    resultScope = targetPosList
  elseif stage == SelectFarthestFormPlayerStage.Start then
    local resultScopePos = targetPosList[1]
    if saveTable and saveTable == 1 then
      table.insert(resultScope, resultScopePos)
    else
      resultScope = resultScopePos
    end
  elseif stage == SelectFarthestFormPlayerStage.Middle then
    for i = 1, #targetPosList do
      if i ~= 1 and i ~= #targetPosList then
        table.insert(resultScope, targetPosList[i])
      end
    end
  elseif stage == SelectFarthestFormPlayerStage.End then
    local resultScopePos = targetPosList[#targetPosList]
    if saveTable and saveTable == 1 then
      table.insert(resultScope, resultScopePos)
    else
      resultScope = resultScopePos
    end
  elseif stage == SelectFarthestFormPlayerStage.FarthestMonsterCenter then
    resultScope = sortedByDis[#sortedByDis]
    resultScope = self:_GetMonsterBodyCenter(targetGroupEntities, resultScope)
  elseif stage == SelectFarthestFormPlayerStage.StartMonsterCenter then
    local resultScopePos = targetPosList[1]
    resultScopePos = self:_GetMonsterBodyCenter(targetGroupEntities, resultScopePos)
    if saveTable and saveTable == 1 then
      table.insert(resultScope, resultScopePos)
    else
      resultScope = resultScopePos
    end
  elseif stage == SelectFarthestFormPlayerStage.EndMonsterCenter then
    local resultScopePos = targetPosList[#targetPosList]
    resultScopePos = self:_GetMonsterBodyCenter(targetGroupEntities, resultScopePos)
    if saveTable and saveTable == 1 then
      table.insert(resultScope, resultScopePos)
    else
      resultScope = resultScopePos
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.SelectFarthestFormPlayer, centerPos, resultScope, resultScope)
  return result
end

function SkillScopeCalculator_SelectFarthestFormPlayer:_GetMonsterBodyCenter(targetGroupEntities, resultScope)
  for i, entity in ipairs(targetGroupEntities) do
    local bodyAreaList = entity:BodyArea():GetArea()
    local gridPos = entity:GridLocation():GetGridPos()
    for _, bodyArea in ipairs(bodyAreaList) do
      local workPos = gridPos + bodyArea
      if workPos.x == resultScope.x and workPos.y == resultScope.y then
        resultScope = gridPos
        break
      end
    end
  end
  return resultScope
end
