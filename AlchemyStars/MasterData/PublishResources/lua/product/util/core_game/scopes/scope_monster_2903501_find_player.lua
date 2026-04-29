require("scope_base")
_class("SkillScopeCalculator_Monster2903501FindPlayer", SkillScopeCalculator_Base)
SkillScopeCalculator_Monster2903501FindPlayer = SkillScopeCalculator_Monster2903501FindPlayer

function SkillScopeCalculator_Monster2903501FindPlayer:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local boardServiceLogic = self._gridFilter._world:GetService("BoardLogic")
  local boardEntity = self._gridFilter._world:GetBoardEntity()
  local utilScopeSvc = self._gridFilter._world:GetService("UtilScopeCalc")
  self._boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  self._boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  local dirTypeList = {
    DirectionType.Up,
    DirectionType.Down,
    DirectionType.Left,
    DirectionType.Right
  }
  local attackRange = {}
  for i, dirType in ipairs(dirTypeList) do
    local range = utilScopeSvc:Monster2903501FindPlayer(dirType, casterPos, bodyArea)
    table.Vector2Append(attackRange, range, attackRange)
  end
  local result = SkillScopeResult:New(SkillScopeType.Monster2903501FindPlayerType, casterPos, attackRange, attackRange)
  return result
end

function SkillScopeCalculator_Monster2903501FindPlayer:Calc(dirType, casterPos, bodyArea)
  local maxLen, edgeLen
  local retRange = {}
  local off = 1
  if dirType == DirectionType.Up or dirType == DirectionType.Down then
    maxLen = self._boardMaxY
    edgeLen = self._boardMaxX
    if dirType == DirectionType.Down then
      off = -1
    end
  elseif dirType == DirectionType.Left or dirType == DirectionType.Right then
    maxLen = self._boardMaxX
    edgeLen = self._boardMaxY
    if dirType == DirectionType.Left then
      off = -1
    end
  end
  local bodyAreaOffSet = {}
  for _, v in ipairs(bodyArea) do
    local offset = Vector2(v.x + casterPos.x, v.y + casterPos.y)
    table.insert(bodyAreaOffSet, offset)
  end
  local j = 0
  for i = 2, maxLen, 2 do
    for _, v in ipairs(bodyAreaOffSet) do
      local newPos
      if dirType == DirectionType.Up or dirType == DirectionType.Down then
        newPos = Vector2(v.x, v.y + i * off)
      elseif dirType == DirectionType.Left or dirType == DirectionType.Right then
        newPos = Vector2(v.x + i * off, v.y)
      end
      if self._gridFilter:IsValidPiecePos(newPos) and not table.Vector2Include(retRange, newPos) then
        table.insert(retRange, newPos)
      end
    end
    for o = -1 * j, j do
      for _, v in ipairs(bodyAreaOffSet) do
        local newPos
        if dirType == DirectionType.Up or dirType == DirectionType.Down then
          newPos = Vector2(v.x + o, v.y + i * off)
        elseif dirType == DirectionType.Left or dirType == DirectionType.Right then
          newPos = Vector2(v.x + i * off, v.y + o)
        end
        if self._gridFilter:IsValidPiecePos(newPos) and not table.Vector2Include(retRange, newPos) then
          table.insert(retRange, newPos)
        end
      end
    end
    j = j + 1
  end
  return retRange
end
