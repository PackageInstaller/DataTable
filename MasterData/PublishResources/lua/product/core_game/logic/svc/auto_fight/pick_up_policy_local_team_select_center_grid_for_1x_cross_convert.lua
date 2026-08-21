_class("PickUpPolicy_LocalTeamSelectCenterGridFor1xCrossConvert", PickUpPolicy_Base)
PickUpPolicy_LocalTeamSelectCenterGridFor1xCrossConvert = PickUpPolicy_LocalTeamSelectCenterGridFor1xCrossConvert

function PickUpPolicy_LocalTeamSelectCenterGridFor1xCrossConvert:CalcAutoFightPickUpPolicy(calcParam)
  local eLocalTeam = self._world:Player():GetLocalTeamEntity()
  local teamPos = eLocalTeam:GetGridPosition()
  local monsterGlobalEntityGroup = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    monsterGlobalEntityGroup = {
      self._world:Player():GetRemoteTeamEntity()
    }
  end
  local policyParam = calcParam.policyParam
  local targetPieceType = policyParam.targetPieceType
  local targetCount = policyParam.targetCount
  local validPickUpGridList, validPosIndexBoolDict = self:_GetValidPickUpGridList(eLocalTeam, calcParam.activeSkillID)
  local yieldIndicator = 1
  local singleGridSelectInfo = {}
  for _, e in ipairs(monsterGlobalEntityGroup) do
    if yieldIndicator % 5 == 0 then
      YIELD(calcParam.TT)
    end
    local gridPos = e:GetGridPosition()
    local bodyArea = e:BodyArea():GetArea()
    if #bodyArea <= 1 then
      local gridPosIndex = Vector2.Pos2Index(gridPos)
      if validPosIndexBoolDict[gridPosIndex] then
        local info = self:_TryGetSelectInfo(gridPos, teamPos, targetPieceType)
        if info then
          info.sortIndex = #singleGridSelectInfo
          table.insert(singleGridSelectInfo, info)
        end
      end
    end
    yieldIndicator = yieldIndicator + 1
  end
  if 0 < #singleGridSelectInfo then
    local singleGridMonsterInfo = self:_TryGetBestCandidate(singleGridSelectInfo)
    if singleGridMonsterInfo then
      return {
        singleGridMonsterInfo.selectPos
      }, singleGridMonsterInfo.convertGrids, {}
    end
  end
  if not validPosIndexBoolDict[Vector2.Pos2Index(teamPos)] then
    return {}, {}, {}
  end
  local teamPosInfo = self:_TryGetSelectInfo(teamPos, teamPos, targetPieceType)
  if not teamPosInfo or targetCount <= #teamPosInfo.dontConvertGrids then
    return {}, {}, {}
  end
  return {teamPos}, teamPosInfo.convertGrids, {}
end

function PickUpPolicy_LocalTeamSelectCenterGridFor1xCrossConvert:_GetValidPickUpGridList(petEntity, skillID)
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

function PickUpPolicy_LocalTeamSelectCenterGridFor1xCrossConvert:_TryGetSelectInfo(gridPos, teamPos, targetPieceType)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = SkillScopeCalculator:New(utilScopeSvc)
  local crossCalc = SkillScopeCalculator_Cross:New(scopeCalc)
  local gridPosIndex = Vector2.Pos2Index(gridPos)
  local crossScope = crossCalc:CalcRange(SkillScopeType.Cross, 1, gridPos, {
    Vector2.zero
  })
  local convertGrids = {}
  local dontConvertGrids = {}
  for _, grid in ipairs(crossScope:GetAttackRange() or {}) do
    if self:_CanGridConvert(grid, targetPieceType) and not table.Vector2Include(convertGrids, grid) then
      table.insert(convertGrids, grid)
    elseif not table.Vector2Include(dontConvertGrids, grid) then
      table.insert(dontConvertGrids, grid)
    end
  end
  if 0 < #convertGrids then
    return {
      selectPos = gridPos,
      convertGrids = convertGrids,
      distance = Vector2.Distance(gridPos, teamPos),
      dontConvertGrids = dontConvertGrids
    }
  end
end

function PickUpPolicy_LocalTeamSelectCenterGridFor1xCrossConvert:_CanGridConvert(v2, targetPieceType)
  local utilData = self._world:GetService("UtilData")
  if not utilData:IsValidPiecePos(v2) then
    return false
  end
  if utilData:IsPosBlock(v2, BlockFlag.ChangeElement) then
    return false
  end
  local pieceType = utilData:GetPieceType(v2)
  if pieceType == targetPieceType or pieceType == PieceType.Any then
    return false
  end
  return true
end

function PickUpPolicy_LocalTeamSelectCenterGridFor1xCrossConvert:_TryGetBestCandidate(candidates)
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
  local winner
  if #bestCandidate == 1 then
    winner = bestCandidate[1]
  elseif 1 < #bestCandidate then
    local index = math.random(1, #bestCandidate)
    winner = bestCandidate[index]
  end
  return winner
end
