require("pick_up_policy_base")
_class("PickUpPolicy_PetShe", PickUpPolicy_Base)
PickUpPolicy_PetShe = PickUpPolicy_PetShe

function PickUpPolicy_PetShe:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local pickPosList, atkPosList, targetIds = self:_CalPickPosPolicyPetShe(petEntity, casterPos, validPosIdxList)
  return pickPosList, atkPosList, targetIds
end

function PickUpPolicy_PetShe:_CalPickPosPolicyPetShe(petEntity, casterPos, validPosIdxList)
  local env = self:_GetPickUpPolicyEnv()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local casterPosIndex = self:_Pos2Index(casterPos)
  local excludePieceType = {
    PieceType.Blue
  }
  local firstPickPos
  local extraExcludePosIndexList = {}
  table.insert(extraExcludePosIndexList, casterPosIndex)
  local blackFistEnemyPos
  if self._world:MatchType() == MatchType.MT_BlackFist and petEntity:HasPet() then
    local enemy = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    blackFistEnemyPos = enemy:GetGridPosition()
  end
  local targetEntityList = {}
  local nearestEnemy
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local teamEntity = petEntity:Pet():GetOwnerTeamEntity()
    local enemyTeam = teamEntity:Team():GetEnemyTeamEntity()
    table.insert(targetEntityList, enemyTeam)
    nearestEnemy = enemyTeam
    local enemyPos = enemyTeam:GetGridPosition()
    local posIndex = self:_Pos2Index(enemyPos)
    table.insert(extraExcludePosIndexList, posIndex)
  else
    local utilScope = self._world:GetService("UtilScopeCalc")
    local monsterList, monsterPosList = utilScope:SelectNearestMonsterOnPos(casterPos, 1)
    if monsterList and 0 < #monsterList then
      table.insert(targetEntityList, monsterList[1])
      nearestEnemy = monsterList[1]
      local enemyPos = nearestEnemy:GetGridPosition()
      local bodyAreaCmpt = nearestEnemy:BodyArea()
      if bodyAreaCmpt then
        local enemyBodyArea = bodyAreaCmpt:GetArea()
        for index, off in ipairs(enemyBodyArea) do
          local bodyPos = enemyPos + off
          local posIndex = self:_Pos2Index(bodyPos)
          table.insert(extraExcludePosIndexList, posIndex)
        end
      end
    end
  end
  if not nearestEnemy then
    return {}, {}, {}
  end
  local canPickPosList = {}
  local nearestEnemyPos = nearestEnemy:GetGridPosition()
  local nearestEnemyPosIndex = self:_Pos2Index(nearestEnemyPos)
  local squareRing1PosList = {}
  local squareRing2PosList = {}
  local ring1 = self:GetPosListAroundBodyArea(nearestEnemy, 1)
  table.appendArray(squareRing1PosList, ring1)
  table.removev(squareRing1PosList, casterPos)
  local ring2 = self:GetPosListAroundBodyArea(nearestEnemy, 2)
  table.appendArray(squareRing2PosList, ring2)
  table.removev(squareRing2PosList, casterPos)
  local squareRingListTab = {}
  table.insert(squareRingListTab, squareRing1PosList)
  table.insert(squareRingListTab, squareRing2PosList)
  local pickPos = self:_CalcMatchPickPos(casterPos, squareRingListTab, excludePieceType)
  if pickPos then
    firstPickPos = pickPos
    return {firstPickPos}, {firstPickPos}, {}
  end
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(casterPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      local color = env.BoardPosPieces[posIdx]
      if color and not table.icontains(excludePieceType, color) and not table.icontains(extraExcludePosIndexList, posIdx) then
        table.insert(canPickPosList, pos)
      end
    end
  end
  local sortedPickPosList = HelperProxy:SortPosByCenterPosDistance(casterPos, canPickPosList)
  if sortedPickPosList and 0 < #sortedPickPosList then
    firstPickPos = sortedPickPosList[1]
  end
  if firstPickPos then
    return {firstPickPos}, {firstPickPos}, {}
  else
    return {}, {}, {}
  end
end

function PickUpPolicy_PetShe:_CalcMatchPickPos(casterPos, posListTab, excludePieceType)
  local boardService = self._world:GetService("BoardLogic")
  for _, posList in ipairs(posListTab) do
    posList = table.unique(posList)
    HelperProxy:SortPosByCenterPosDistance(casterPos, posList)
    local trapSvc = self._world:GetService("TrapLogic")
    for _, pickPos in pairs(posList) do
      local pieceType = boardService:GetPieceType(pickPos)
      if not table.icontains(excludePieceType, pieceType) then
        return pickPos
      end
    end
  end
  return nil
end
