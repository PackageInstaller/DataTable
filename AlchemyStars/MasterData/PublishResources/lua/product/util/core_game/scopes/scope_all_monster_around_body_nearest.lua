require("scope_base")
_class("SkillScopeCalculator_AllMonsterAroundBodyNearest", SkillScopeCalculator_Base)
SkillScopeCalculator_AllMonsterAroundBodyNearest = SkillScopeCalculator_AllMonsterAroundBodyNearest

function SkillScopeCalculator_AllMonsterAroundBodyNearest:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local invalidGridList = scopeParam[1] or {}
  local cross_area = {}
  local monsterList, monsterPosList = self._gridFilter:SelectAllMonster(casterEntity)
  local cehckPosList = {}
  table.insert(cehckPosList, Vector2(0, 1))
  table.insert(cehckPosList, Vector2(1, 0))
  table.insert(cehckPosList, Vector2(0, -1))
  table.insert(cehckPosList, Vector2(-1, 0))
  cross_area = self:_OnCheckAroundBody(monsterList, monsterPosList, centerPos, cehckPosList, invalidGridList)
  if 0 < table.count(cross_area) then
    local result = SkillScopeResult:New(SkillScopeType.AllMonsterAroundBodyNearest, centerPos, cross_area, cross_area)
    return result
  end
  cehckPosList = {}
  table.insert(cehckPosList, Vector2(1, 1))
  table.insert(cehckPosList, Vector2(1, -1))
  table.insert(cehckPosList, Vector2(-1, -1))
  table.insert(cehckPosList, Vector2(-1, 1))
  cross_area = self:_OnCheckAroundBody(monsterList, monsterPosList, centerPos, cehckPosList, invalidGridList)
  if table.count(cross_area) == 0 then
    cross_area = {centerPos}
  end
  local result = SkillScopeResult:New(SkillScopeType.AllMonsterAroundBodyNearest, centerPos, cross_area, cross_area)
  return result
end

function SkillScopeCalculator_AllMonsterAroundBodyNearest:_OnCheckAroundBody(monsterList, monsterPosList, centerPos, cehckPosList, invalidGridList)
  local cross_area = {}
  local gridPosList = {}
  local world = self._gridFilter._world
  local skillScopeTargetSelector = world:GetSkillScopeTargetSelector()
  local boardServiceLogic = world:GetService("BoardLogic")
  for _, entity in ipairs(monsterList) do
    if skillScopeTargetSelector:SelectConditionFilter(entity) then
      local bodyAreaList = entity:BodyArea():GetArea()
      local gridPos = entity:GridLocation():GetGridPos()
      for _, bodyArea in ipairs(bodyAreaList) do
        for _, offsetPos in ipairs(cehckPosList) do
          local workPos = gridPos + bodyArea + offsetPos
          if not table.intable(gridPosList, workPos) and self._gridFilter:IsValidPiecePos(workPos) and not table.intable(invalidGridList, workPos) and not boardServiceLogic:IsPosBlock(workPos, BlockFlag.MonsterLand) then
            table.insert(gridPosList, workPos)
          end
        end
      end
    end
  end
  if table.count(gridPosList) == 0 then
    return cross_area
  end
  local nearestDisPos = gridPosList[1]
  local nearestDisPosList = {
    gridPosList[1]
  }
  for _, pos in ipairs(gridPosList) do
    local curPosDis = Vector2.Distance(pos, centerPos)
    local nearestDis = Vector2.Distance(nearestDisPos, centerPos)
    if curPosDis < nearestDis then
      table.clear(nearestDisPosList)
      table.insert(nearestDisPosList, pos)
      nearestDisPos = pos
    elseif curPosDis == nearestDis then
      table.insert(nearestDisPosList, pos)
    end
  end
  for _, pos in ipairs(monsterPosList) do
    for _, offsetPos in ipairs(cehckPosList) do
      local workPos = pos + offsetPos
      if table.intable(nearestDisPosList, workPos) then
        cross_area = {workPos}
        break
      end
    end
    if table.count(cross_area) > 0 then
      break
    end
  end
  return cross_area
end
