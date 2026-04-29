require("scope_base")
_class("SkillScopeCalculator_SelectPieceTypeAndExclude", SkillScopeCalculator_Base)
SkillScopeCalculator_SelectPieceTypeAndExclude = SkillScopeCalculator_SelectPieceTypeAndExclude

function SkillScopeCalculator_SelectPieceTypeAndExclude:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local world = self._gridFilter._world
  if not world then
    Log.exception(self._className, "这个范围只能在局内展示")
    return
  end
  local pieceType = scopeParam.pieceType or {}
  local excludeChainPath = scopeParam.excludeChainPath or 0
  local nearest = scopeParam.nearest or 0
  local random = scopeParam.random or 0
  local maxCount = scopeParam.count or 0
  local excludeTrapID = scopeParam.excludeTrapID or {}
  local excludePosList = {}
  if excludeChainPath == 1 then
    local teamEntity = self._gridFilter._world:Player():GetCurrentTeamEntity()
    local logicChainPathCmpt = teamEntity:LogicChainPath()
    local chainPath = logicChainPathCmpt:GetLogicChainPath()
    table.appendArray(excludePosList, chainPath)
  end
  if excludeTrapID and 0 < table.count(excludeTrapID) then
    local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
    local trapEntities = trapGroup:GetEntities()
    for _, trap in ipairs(trapEntities) do
      local trapEntity = trap
      if not trapEntity:HasDeadMark() then
        local trapCmpt = trapEntity:Trap()
        if table.intable(excludeTrapID, trapCmpt:GetTrapID()) then
          table.insert(excludePosList, trapEntity:GetGridPosition())
        end
      end
    end
  end
  local boardServiceLogic = world:GetService("BoardLogic")
  local pieceRange = boardServiceLogic:GetGridPosByPieceType(pieceType)
  local wholeRange = {}
  for _, pos in ipairs(pieceRange) do
    if not table.intable(excludePosList, pos) then
      table.insert(wholeRange, pos)
    end
  end
  if nearest == 1 then
    HelperProxy:SortPosByCenterPosDistance(centerPos, wholeRange)
    if maxCount and 0 < maxCount then
      local resultRange = {}
      local findGridCount = 0
      for _, grid in ipairs(wholeRange) do
        if maxCount > table.count(resultRange) then
          table.insert(resultRange, grid)
        else
          break
        end
      end
      wholeRange = resultRange
    end
  end
  if random == 1 and #wholeRange ~= 0 then
    local resultRange = {}
    while maxCount > #resultRange do
      local randomIndex = self._gridFilter:_GetRandomNumber(1, #wholeRange)
      local pos = wholeRange[randomIndex]
      table.insert(resultRange, pos)
    end
    wholeRange = resultRange
  end
  return SkillScopeResult:New(SkillScopeType.SelectPieceTypeAndExclude, centerPos, wholeRange, wholeRange)
end
