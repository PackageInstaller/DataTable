require("scope_base")
_class("SkillScopeCalculator_FarthestBoardRowOrColumn", SkillScopeCalculator_Base)
SkillScopeCalculator_FarthestBoardRowOrColumn = SkillScopeCalculator_FarthestBoardRowOrColumn

function SkillScopeCalculator_FarthestBoardRowOrColumn:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local scopeStageType = scopeParam[1] or FarthestBoardRowOrColumnStageType.Start
  local calcBlock = scopeParam[2] or 0
  local world = self._gridFilter._world
  local teamLeader = world:Player():GetLocalTeamEntity()
  local teamPos = teamLeader:GetGridPosition()
  local boardServiceLogic = world:GetService("BoardLogic")
  local maxLen = boardServiceLogic:GetCurBoardMaxLen()
  local utilDataSvc = world:GetService("UtilData")
  local dirExtendList = {}
  table.insert(dirExtendList, Vector2(0, 1))
  table.insert(dirExtendList, Vector2(-1, 0))
  table.insert(dirExtendList, Vector2(0, -1))
  table.insert(dirExtendList, Vector2(1, 0))
  local disBoardList = {}
  for _, dir in ipairs(dirExtendList) do
    local dis = 0
    local gridPosList = {}
    for i = 1, maxLen do
      local nextPos = Vector2(teamPos.x + i * dir.x, teamPos.y + i * dir.y)
      if not self._gridFilter:IsValidPiecePos(nextPos) or utilDataSvc:IsExtraBoardPos(nextPos) then
        break
      end
      local add = true
      local isBlocked = boardServiceLogic:IsPosBlock(nextPos, BlockFlag.MonsterLand)
      if calcBlock == 1 and nextPos ~= centerPos and isBlocked then
        add = false
      end
      if add then
        dis = i
        table.insert(gridPosList, nextPos)
      end
    end
    table.insert(disBoardList, {
      dis = dis,
      dir = dir,
      gridPosList = gridPosList
    })
  end
  local farestDisData = disBoardList[1]
  local resultDisList = {
    disBoardList[1]
  }
  for _, data in ipairs(disBoardList) do
    if data.dis > farestDisData.dis then
      table.clear(resultDisList)
      table.insert(resultDisList, data)
      farestDisData = data
    elseif data.dis == farestDisData.dis then
      table.insert(resultDisList, data)
    end
  end
  local farestDir = farestDisData.dir
  local cross_area = {}
  if scopeStageType == FarthestBoardRowOrColumnStageType.Start then
    local targetPos = Vector2(teamPos.x + farestDisData.dis * farestDir.x, teamPos.y + farestDisData.dis * farestDir.y)
    cross_area = {targetPos}
  elseif scopeStageType == FarthestBoardRowOrColumnStageType.BeforePlayer then
    local targetPos = teamPos + farestDir
    cross_area = {targetPos}
  elseif scopeStageType == FarthestBoardRowOrColumnStageType.End then
    local oppositeDir = Vector2(-farestDir.x, -farestDir.y)
    for _, data in ipairs(disBoardList) do
      if oppositeDir == data.dir then
        local targetPos = Vector2(teamPos.x + data.dis * data.dir.x, teamPos.y + data.dis * data.dir.y)
        cross_area = {targetPos}
        break
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.FarthestBoardRowOrColumn, centerPos, cross_area, cross_area)
  return result
end

local FarthestBoardRowOrColumnStageType = {
  Start = 1,
  BeforePlayer = 2,
  End = 3,
  Max = 9
}
_enum("FarthestBoardRowOrColumnStageType", FarthestBoardRowOrColumnStageType)
