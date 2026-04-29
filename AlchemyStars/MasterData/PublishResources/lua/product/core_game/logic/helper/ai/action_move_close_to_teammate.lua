require("action_move_base")
_class("ActionMoveCloseToTeammate", ActionMoveBase)
ActionMoveCloseToTeammate = ActionMoveCloseToTeammate
_class("ActionMoveCloseToTeammate_SortedPosElement", Object)
ActionMoveCloseToTeammate_SortedPosElement = ActionMoveCloseToTeammate_SortedPosElement

function ActionMoveCloseToTeammate_SortedPosElement:Constructor(teammateCount, centerPos, distance, pieceIndex)
  self._teammateCount = teammateCount
  self._centerPos = centerPos
  self._distance = distance
  self._pieceIndex = pieceIndex
end

function ActionMoveCloseToTeammate_SortedPosElement:GetTeammateCount()
  return self._teammateCount
end

function ActionMoveCloseToTeammate_SortedPosElement:GetCenterPos()
  return self._centerPos
end

function ActionMoveCloseToTeammate_SortedPosElement:GetDistance()
  return self._distance
end

function ActionMoveCloseToTeammate_SortedPosElement:GetPieceIndex()
  return self._pieceIndex
end

function ActionMoveCloseToTeammate_SortedPosElement.ComparerByTeammateCount(a, b)
  local teammateCountA = a:GetTeammateCount()
  local teammateCountB = b:GetTeammateCount()
  if teammateCountA > teammateCountB then
    return 1
  elseif teammateCountA < teammateCountB then
    return -1
  else
    local distanceA = a:GetDistance()
    local distanceB = b:GetDistance()
    if distanceA < distanceB then
      return 1
    elseif distanceA > distanceB then
      return -1
    else
      local indexA = a:GetPieceIndex()
      local indexB = b:GetPieceIndex()
      return indexB - indexA
    end
  end
end

function ActionMoveCloseToTeammate:FindNewTargetPos()
  local targetType = SkillTargetType.Monster
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = utilScopeSvc:GetSkillScopeCalc()
  local nSkillID = self:GetLogicData(1)
  local svcCfg = self._world:GetService("Config")
  local cfgSkill = svcCfg:GetSkillConfigData(nSkillID)
  local testBlockFlag = BlockFlag.MonsterLand
  if self.m_entityOwn:HasMonsterID() then
    local cMonsterID = self.m_entityOwn:MonsterID()
    testBlockFlag = cMonsterID:GetMonsterBlockData()
  end
  local casterGridPos = self.m_entityOwn:GetGridPosition()
  local casterDir = self.m_entityOwn:GetGridDirection()
  local bodyAreaArray = self.m_entityOwn:BodyArea():GetArea()
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local utilData = self._world:GetService("UtilData")
  local sortedArray = SortedArray:New(Algorithm.COMPARE_CUSTOM, ActionMoveCloseToTeammate_SortedPosElement.ComparerByTeammateCount)
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  local boardPosList = boardCmpt:CloneBoardPosList()
  for index, gridPos in ipairs(boardPosList) do
    local isPosGoodToGo = true
    for _, relativeBodyPos in ipairs(bodyAreaArray) do
      if isPosGoodToGo == false then
        break
      end
      local absBodyPos = gridPos + relativeBodyPos
      if not utilData:IsValidPiecePos(absBodyPos) then
        isPosGoodToGo = false
        break
      end
      local isBlockMoveWithTrapWall = utilData:IsBlockMoveWithTrapWall(casterGridPos, absBodyPos, self.m_entityOwn)
      if isBlockMoveWithTrapWall then
        isPosGoodToGo = false
        break
      end
      local pieceBlock = utilData:FindBlockByPos(absBodyPos)
      if pieceBlock then
        for entityID, blockData in pairs(pieceBlock.m_listBlock) do
          if entityID ~= self.m_entityOwn:GetID() and blockData & testBlockFlag ~= 0 then
            isPosGoodToGo = false
            break
          end
        end
      else
        isPosGoodToGo = false
      end
    end
    if isPosGoodToGo then
      local scopeResult = scopeCalc:CalcSkillScope(cfgSkill, gridPos, casterDir, bodyAreaArray)
      local targetArray = targetSelector:DoSelectSkillTarget(self.m_entityOwn, targetType, scopeResult, nSkillID) or {}
      local tids = {}
      for _, targetID in ipairs(targetArray) do
        if targetID ~= self.m_entityOwn:GetID() and not table.icontains(tids, targetID) then
          table.insert(tids, targetID)
        end
      end
      local targetCount = #tids
      local distance = Vector2.Distance(gridPos, casterGridPos)
      local element = ActionMoveCloseToTeammate_SortedPosElement:New(targetCount, gridPos, distance, index)
      sortedArray:Insert(element)
    end
  end
  local first = sortedArray:GetAt(1)
  local second = sortedArray:GetAt(2)
  if first:GetDistance() == 0 and first:GetTeammateCount() == 0 then
    first = second
  end
  local mobility = self.m_entityOwn:AI():GetMobilityValid()
  local elementInMobility
  for i = 1, sortedArray:Size() do
    local element = sortedArray:GetAt(i)
    local targetPos = first:GetCenterPos()
    local curPosToTargetDis = Vector2.Distance(casterGridPos, targetPos)
    local workPosToTargetDis = Vector2.Distance(element:GetCenterPos(), targetPos)
    if element:GetDistance() == 1 and curPosToTargetDis >= workPosToTargetDis then
      elementInMobility = element
      break
    end
  end
  if elementInMobility == nil then
    return casterGridPos
  end
  return elementInMobility:GetCenterPos()
end

function ActionMoveCloseToTeammate:FindNewWalkPos(posWalkList, posTarget, posSelf)
  return posTarget
end
