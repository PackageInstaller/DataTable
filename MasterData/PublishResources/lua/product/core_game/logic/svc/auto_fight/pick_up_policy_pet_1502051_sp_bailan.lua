require("pick_up_policy_base")
_class("PickUpPolicy_Pet1502051SPBaiLan", PickUpPolicy_Base)
PickUpPolicy_Pet1502051SPBaiLan = PickUpPolicy_Pet1502051SPBaiLan

function PickUpPolicy_Pet1502051SPBaiLan:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local monsterGlobalEntityGroup = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    monsterGlobalEntityGroup = {
      petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    }
  end
  local singleGridSelectInfo = {}
  local multiGridSelectInfo = {}
  local eTeam = petEntity:Pet():GetOwnerTeamEntity()
  local teamPos = eTeam:GetGridPosition()
  local validPickUpGridList, validPosIndexBoolDict = self:_GetValidPickUpGridList(petEntity, calcParam.activeSkillID)
  for _, e in ipairs(monsterGlobalEntityGroup) do
    local gridPos = e:GetGridPosition()
    local bodyArea = e:BodyArea():GetArea()
    if #bodyArea <= 1 then
      local gridPosIndex = Vector2.Pos2Index(gridPos)
      if validPosIndexBoolDict[gridPosIndex] then
        local info = self:_TryGetSelectInfo(gridPos, teamPos)
        if info then
          info.sortIndex = #singleGridSelectInfo
          table.insert(singleGridSelectInfo, info)
        end
      end
    else
      for _, body in ipairs(bodyArea) do
        local v2 = gridPos + body
        local gridPosIndex = Vector2.Pos2Index(v2)
        if validPosIndexBoolDict[gridPosIndex] then
          local info = self:_TryGetSelectInfo(v2, teamPos)
          if info then
            info.sortIndex = #multiGridSelectInfo
            table.insert(multiGridSelectInfo, info)
          end
        end
      end
    end
  end
  local finalInfo
  if 0 < #singleGridSelectInfo then
    finalInfo = self:_TryGetBestCandidate(singleGridSelectInfo)
  end
  if not finalInfo and 0 < #multiGridSelectInfo then
    finalInfo = self:_TryGetBestCandidate(multiGridSelectInfo)
  end
  if not finalInfo then
    local list3Ring = ComputeScopeRange.ComputeRange_SquareRing(teamPos, 1, 3, false)
    local candidates = {}
    for _, v2 in ipairs(list3Ring) do
      local info = self:_TryGetSelectInfo(v2, teamPos)
      if info then
        table.insert(candidates, info)
      end
    end
    if 0 < #candidates then
      finalInfo = self:_TryGetBestCandidate(candidates)
    end
  end
  if not finalInfo then
    return {}, {}, {}
  end
  return {
    finalInfo.selectPos
  }, finalInfo.convertGrids, {}
end

function PickUpPolicy_Pet1502051SPBaiLan:_CanGridConvert(v2)
  local utilData = self._world:GetService("UtilData")
  if not utilData:IsValidPiecePos(v2) then
    return false
  end
  if utilData:IsPosBlock(v2, BlockFlag.ChangeElement) then
    return false
  end
  if utilData:GetMonsterAtPos(v2) then
    return false
  end
  local pieceType = utilData:GetPieceType(v2)
  if pieceType == PieceType.Blue or pieceType == PieceType.Any then
    return false
  end
  return true
end

function PickUpPolicy_Pet1502051SPBaiLan:_GetValidPickUpGridList(petEntity, skillID)
  local cfgsvc = self._world:GetService("Config")
  local skillConfigData = cfgsvc:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local validGirdList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
  local invalidGridDict = {}
  for _, invalidPos in ipairs(invalidGridList) do
    invalidGridDict[Vector2.Pos2Index(invalidPos)] = true
  end
  local validPosIdxList = {}
  local validPosList = {}
  for _, validPos in ipairs(validGirdList) do
    local validPosIdx = Vector2.Pos2Index(validPos)
    if not invalidGridDict[validPosIdx] then
      validPosIdxList[validPosIdx] = true
      table.insert(validPosList, validPos)
    end
  end
  return validPosList, validPosIdxList
end

function PickUpPolicy_Pet1502051SPBaiLan:_TryGetSelectInfo(gridPos, teamPos)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = SkillScopeCalculator:New(utilScopeSvc)
  local crossCalc = SkillScopeCalculator_Cross:New(scopeCalc)
  local gridPosIndex = Vector2.Pos2Index(gridPos)
  local crossScope = crossCalc:CalcRange(SkillScopeType.Cross, 1, gridPos, {
    Vector2.zero
  })
  local convertGrids = {}
  for _, grid in ipairs(crossScope:GetAttackRange() or {}) do
    if self:_CanGridConvert(grid) and not table.Vector2Include(convertGrids, grid) then
      table.insert(convertGrids, grid)
    end
  end
  if 0 < #convertGrids then
    return {
      selectPos = gridPos,
      convertGrids = convertGrids,
      distance = Vector2.Distance(gridPos, teamPos)
    }
  end
end

function PickUpPolicy_Pet1502051SPBaiLan:_TryGetBestCandidate(candidates)
  local bestCandidate = {}
  local maxConvertCount = #candidates[1].convertGrids
  local minDistance = candidates[1].distance
  for i = 2, #candidates do
    local info = candidates[i]
    if maxConvertCount < #info.convertGrids then
      maxConvertCount = #info.convertGrids
      bestCandidate = {info}
    elseif #info.convertGrids == maxConvertCount and minDistance > info.distance then
      minDistance = info.distance
      bestCandidate = {info}
    end
  end
  local finalPos
  if #bestCandidate == 1 then
    finalPos = bestCandidate[1]
  elseif 1 < #bestCandidate then
    local index = math.random(1, #bestCandidate)
    finalPos = bestCandidate[index]
  end
  return finalPos
end
