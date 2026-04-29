require("scope_base")
_class("SkillScopeCalculator_SelectPosDistanceFormPlayer", SkillScopeCalculator_Base)
SkillScopeCalculator_SelectPosDistanceFormPlayer = SkillScopeCalculator_SelectPosDistanceFormPlayer

function SkillScopeCalculator_SelectPosDistanceFormPlayer:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if not scopeParam then
    Log.fatal("### scopeParam is nil. centerPos=", centerPos)
    return
  end
  local world = self._gridFilter._world
  local posList = scopeParam.pos
  local count = scopeParam.count or 1
  local sortType = scopeParam.sortType
  local isTable = scopeParam.isTable or 0
  local limitDis = scopeParam.limitDis
  local ignoreBlock = scopeParam.ignoreBlock or 0
  local blockFlag = BlockFlag.MonsterLand
  if ignoreBlock == 1 then
    blockFlag = 0
  end
  local posScope = {}
  for i, v in ipairs(posList) do
    table.insert(posScope, Vector2(v[1], v[2]))
  end
  local teamLeader = world:Player():GetCurrentTeamEntity()
  local teamPos = teamLeader:GridLocation().Position
  local sortedByDis = {}
  if sortType == 1 then
    sortedByDis = HelperProxy:SortPosByCenterPosDistance(teamPos, posScope)
  elseif sortType == 2 then
    local tmpSortedByDis = HelperProxy:SortPosByCenterPosDistance(teamPos, posScope)
    for i = #tmpSortedByDis, 1, -1 do
      table.insert(sortedByDis, tmpSortedByDis[i])
    end
  end
  local resultScope = {}
  local boardServiceLogic = world:GetService("BoardLogic")
  for i, pos in ipairs(sortedByDis) do
    local isBlocked = boardServiceLogic:IsPosBlock(pos, blockFlag)
    if not isBlocked then
      if isTable and isTable == 1 then
        table.insert(resultScope, pos)
        if count <= table.count(resultScope) then
          break
        end
      else
        local curPosToTargetPosDis = Vector2.Distance(centerPos, pos)
        if limitDis == nil or limitDis >= curPosToTargetPosDis then
          resultScope = pos
          break
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.SelectPosDistanceFormPlayer, centerPos, resultScope, resultScope)
  return result
end
