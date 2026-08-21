require("scope_base")
_class("SkillScopeCalculator_CrossEdges", SkillScopeCalculator_Base)
SkillScopeCalculator_CrossEdges = SkillScopeCalculator_CrossEdges

function SkillScopeCalculator_CrossEdges:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local params = scopeParam
  local world = self._gridFilter._world
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local boardServiceLogic = world:GetService("BoardLogic")
  local maxX = boardServiceLogic:GetCurBoardMaxX()
  local maxY = boardServiceLogic:GetCurBoardMaxY()
  local sourcePos = {}
  local upPos = Vector2(casterPos.x, casterPos.y)
  for i = 1, maxY do
    local tmp = Vector2(casterPos.x, casterPos.y + i)
    if self:CheckPosValid(tmp, sourcePos) then
      upPos = tmp
    end
  end
  table.insert(sourcePos, upPos)
  local downPos = Vector2(casterPos.x, casterPos.y)
  for i = 1, maxY do
    local tmp = Vector2(casterPos.x, casterPos.y - i)
    if self:CheckPosValid(tmp, sourcePos) then
      downPos = tmp
    end
  end
  table.insert(sourcePos, downPos)
  local leftPos = Vector2(casterPos.x, casterPos.y)
  for i = 1, maxX do
    local tmp = Vector2(casterPos.x - i, casterPos.y)
    if self:CheckPosValid(tmp, sourcePos) then
      leftPos = tmp
    end
  end
  table.insert(sourcePos, leftPos)
  local rightPos = Vector2(casterPos.x, casterPos.y)
  for i = 1, maxX do
    local tmp = Vector2(casterPos.x + i, casterPos.y)
    if self:CheckPosValid(tmp, sourcePos) then
      rightPos = tmp
    end
  end
  table.insert(sourcePos, rightPos)
  local ret = {}
  for i, pos in ipairs(sourcePos) do
    if pos == casterPos then
      pos = self:FindPos(casterPos, pos, ret)
    end
    if playerPos == pos then
      pos = self:FindPos(casterPos, playerPos, ret, 1, i)
    end
    if not self:CheckPosValid(pos, ret) then
      pos = self:FindPos(casterPos, pos, ret)
    end
    table.insert(ret, pos)
  end
  local result = SkillScopeResult:New(SkillScopeType.CrossEdges, centerPos, ret, ret)
  return result
end

function SkillScopeCalculator_CrossEdges:CheckPosValid(pos, ret)
  if not self._gridFilter:IsPosBlock(pos, BlockFlag.SummonTrap) and not table.Vector2Include(ret, pos) then
    return true
  end
  return false
end

function SkillScopeCalculator_CrossEdges:FindPos(casterPos, sourcePos, retList, ringBegin, index)
  local function sortF(a, b)
    local da = Vector2.Distance(a, casterPos)
    
    local db = Vector2.Distance(b, casterPos)
    return da < db
  end
  
  if not ringBegin then
    local rList = {}
    table.insert(rList, Vector2(sourcePos.x, sourcePos.y - 1))
    table.insert(rList, Vector2(sourcePos.x, sourcePos.y + 1))
    table.insert(rList, Vector2(sourcePos.x - 1, sourcePos.y))
    table.insert(rList, Vector2(sourcePos.x + 1, sourcePos.y))
    table.sort(rList, sortF)
    for i, pos in ipairs(rList) do
      if self:CheckPosValid(pos, retList) and pos ~= casterPos then
        return pos
      end
    end
    ringBegin = 2
  end
  for i = ringBegin, 10 do
    local ringList = ComputeScopeRange.ComputeRange_SquareRing(sourcePos, 1, i)
    table.sort(ringList, sortF)
    for _, pos in ipairs(ringList) do
      if self:CheckPosValid(pos, retList) and pos ~= casterPos then
        return pos
      end
    end
  end
end
