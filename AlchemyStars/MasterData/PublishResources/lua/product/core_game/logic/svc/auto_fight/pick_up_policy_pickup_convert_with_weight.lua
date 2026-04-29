require("pick_up_policy_base")
local directions = {
  Vector2.New(0, 1),
  Vector2.New(0, -1),
  Vector2.New(1, 0),
  Vector2.New(-1, 0),
  Vector2.New(1, 1),
  Vector2.New(-1, -1),
  Vector2.New(1, -1),
  Vector2.New(-1, 1)
}
_class("PickUpPolicy_PickUpConvertWithWeight", PickUpPolicy_Base)
PickUpPolicy_PickUpConvertWithWeight = PickUpPolicy_PickUpConvertWithWeight

function PickUpPolicy_PickUpConvertWithWeight:CalcAutoFightPickUpPolicy(calcParam)
  local policyParam = calcParam.policyParam
  local activeSkillID = calcParam.activeSkillID
  local pickUpNum = self:_GetPickUpNumByConfig(activeSkillID)
  local pickupResults = {}
  for i = 1, pickUpNum do
    Log.info(self._className, "calculation #", i)
    local pickUpPos = self:_CalcSinglePickResult(calcParam, pickupResults)
    Log.info(self._className, "calculation #", i, "result=", tostring(pickUpPos))
    if pickUpPos then
      table.insert(pickupResults, pickUpPos)
    end
    YIELD(calcParam.TT)
  end
  return pickupResults, pickupResults, {}
end

function PickUpPolicy_PickUpConvertWithWeight:_CalcSinglePickResult(calcParam, overwritePosList)
  local autoFightSvc = self._world:GetService("AutoFight")
  self._boardPosPieces = autoFightSvc:_CalcBoardPosPieceType()
  overwritePosList = overwritePosList or {}
  Log.info("   -", self._className, "overwritePosList: ")
  for _, v2 in ipairs(overwritePosList) do
    Log.info("       +", self._className, tostring(v2))
    self._boardPosPieces[Vector2.Pos2Index(v2)] = calcParam.policyParam.targetPieceType
  end
  local weightedGrids = self:_CalcWeightGrids(calcParam)
  table.sort(weightedGrids, function(a, b)
    if a.weight ~= b.weight then
      return a.weight > b.weight
    elseif a.distance ~= b.distance then
      return a.distance > b.distance
    end
    return a.sortIndex < b.sortIndex
  end)
  YIELD(calcParam.TT)
  local policyParam = calcParam.policyParam
  local eTeam = calcParam.petEntity:Pet():GetOwnerTeamEntity()
  local playerLinkableGroups, allGroups = self:_GetAllLinkableGroups(calcParam.TT, policyParam, eTeam)
  local candidatesGridDic = {}
  for _, group in ipairs(playerLinkableGroups) do
    for index, _ in pairs(group.surroundingGridIndexDic) do
      local v2 = Vector2.Index2Pos(index)
      if self:_IsSuitableCandidate(v2, policyParam) then
        candidatesGridDic[index] = true
      end
    end
  end
  local candidatesAroundPlayer = self:_CalcCandidatesAroundPlayer(calcParam)
  for _, info in ipairs(candidatesAroundPlayer) do
    candidatesGridDic[Vector2.Pos2Index(info.pos)] = true
  end
  local weightedCandidates = {}
  for _, info in ipairs(weightedGrids) do
    local posIndex = Vector2.Pos2Index(info.pos)
    if candidatesGridDic[posIndex] then
      table.insert(weightedCandidates, info)
    end
  end
  YIELD(calcParam.TT)
  local teamPos = eTeam:GetGridPosition()
  if 0 < #weightedCandidates then
    table.sort(weightedCandidates, function(a, b)
      if a.weight ~= b.weight then
        return a.weight > b.weight
      end
      if a.distance ~= b.distance then
        return a.distance > b.distance
      end
      return a.sortIndex < b.sortIndex
    end)
    Log.info(self._className, "winner weighted candidate: ", tostring(weightedCandidates[1].pos))
    return weightedCandidates[1].pos
  else
    local surroundingGridsGroupByIndex = {}
    for _, group in ipairs(allGroups) do
      for index, _ in pairs(group.surroundingGridIndexDic) do
        candidatesGridDic[index] = true
        if not surroundingGridsGroupByIndex[index] then
          surroundingGridsGroupByIndex[index] = {}
        end
        if not table.icontains(surroundingGridsGroupByIndex[index], group) then
          table.insert(surroundingGridsGroupByIndex[index], group)
        end
      end
    end
    local candidates = {}
    for gridIndex, groups in pairs(surroundingGridsGroupByIndex) do
      local v2 = Vector2.Index2Pos(gridIndex)
      if self:_IsSuitableCandidate(v2, policyParam) and not table.Vector2Include(overwritePosList, v2) then
        local g = PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup:New(eTeam, policyParam.targetPieceType)
        g:PosJoin(v2)
        local convertCount = 1
        for _, group in ipairs(groups) do
          if not group.isPlayerLinkable then
            convertCount = convertCount + #group.grids
            Log.info("       -", self._className, "surrounding pos: ", gridIndex, "add linking group: ", tostring(group))
          end
          g:MergeGroup(group)
        end
        Log.info("       -", self._className, "surrounding pos: ", gridIndex, "final group: ", tostring(g))
        if g.isPlayerLinkable then
          Log.info("           +", self._className, "...can get player to linkable area")
          table.insert(candidates, {
            pos = v2,
            weight = convertCount,
            sortIndex = #candidates,
            group = g
          })
        end
        YIELD(calcParam.TT)
      else
        Log.info("       -", self._className, "skipping surrounding pos: ", gridIndex, "because it's invalid or selected as result before. ")
      end
    end
    if #candidates == 0 then
      return
    end
    table.sort(candidates, function(a, b)
      if a.weight ~= b.weight then
        return a.weight > b.weight
      end
      return a.sortIndex < b.sortIndex
    end)
    Log.info(self._className, "winner surrounding candidate: ", tostring(candidates[1].pos))
    return candidates[1].pos
  end
end

function PickUpPolicy_PickUpConvertWithWeight:_IsSuitableCandidate(v2, policyParam)
  local targetPieceType = policyParam.targetPieceType
  local utilData = self._world:GetService("UtilData")
  if not utilData:IsValidPiecePos(v2) then
    return false
  end
  local pieceType = self._boardPosPieces[Vector2.Pos2Index(v2)]
  if pieceType == targetPieceType or pieceType == PieceType.Any then
    return false
  end
  if utilData:IsPosBlock(v2, BlockFlag.LinkLine) then
    return false
  end
  if utilData:IsPosBlock(v2, BlockFlag.ChangeElement) then
    return false
  end
  return true
end

local function monsterWeight(e)
  local weight = BattleConst.NormalMonsterAroundGridWeightWhenConverting
  if e:HasBoss() then
    weight = BattleConst.BossAroundGridWeightWhenConverting
  elseif e:HasMonsterID() and e:MonsterID():IsEliteMonster() then
    weight = BattleConst.EliteMonsterAroundGridWeightWhenConverting
  end
  return weight
end

function PickUpPolicy_PickUpConvertWithWeight:_CalcWeightGrids(calcParam)
  local policyParam = calcParam.policyParam
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = SkillScopeCalculator:New(utilScopeSvc)
  local crossCalc = SkillScopeCalculator_Cross:New(scopeCalc)
  local eTeam = calcParam.petEntity:Pet():GetOwnerTeamEntity()
  local teamPos = eTeam:GetGridPosition()
  local posIndexCheck = {}
  local weightedGrids = {}
  local utilData = self._world:GetService("UtilData")
  local monsterGlobalEntityGroup = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    monsterGlobalEntityGroup = {
      calcParam.petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    }
  end
  for _, e in ipairs(monsterGlobalEntityGroup) do
    if not e:HasDeadMark() then
      local weight = monsterWeight(e)
      Log.info(self._className, "weight calculation on entity ", e:GetID(), "basic weight: ", weight)
      local crossScope = crossCalc:CalcRange(SkillScopeType.Cross, 1, e:GetGridPosition(), e:BodyArea():GetArea())
      local attackRange = crossScope:GetAttackRange()
      for _, rangePos in ipairs(attackRange) do
        local posIndex = Vector2.Pos2Index(rangePos)
        Log.info("   -", self._className, "pos in range: ", posIndex)
        if self:_IsSuitableCandidate(rangePos, policyParam) then
          local dis = math.max(math.abs(rangePos.x - teamPos.x), math.abs(rangePos.y - teamPos.y))
          local additionalWeight = 0
          for _, dir in ipairs(directions) do
            local v2 = rangePos + dir
            local index = Vector2.Pos2Index(v2)
            local isSpecificPieceType = self._boardPosPieces[index] == policyParam.targetPieceType or self._boardPosPieces[index] == PieceType.Any
            if v2 ~= teamPos and not utilData:GetMonsterAtPos(v2) and isSpecificPieceType then
              Log.info("       +", self._className, " additional weight for specific type of piece around: ", index)
              additionalWeight = additionalWeight + 1
            end
          end
          Log.info("   -", self._className, "final weight: ", weight + additionalWeight, " sortIndex: ", #weightedGrids + 9990000)
          if not posIndexCheck[posIndex] then
            local candidate = {
              pos = rangePos,
              weight = weight + additionalWeight,
              sortIndex = #weightedGrids + 9990000,
              distance = dis
            }
            table.insert(weightedGrids, candidate)
            posIndexCheck[posIndex] = candidate
          else
            posIndexCheck[posIndex].weight = posIndexCheck[posIndex].weight + weight + additionalWeight
          end
        end
      end
    end
  end
  return weightedGrids
end

function PickUpPolicy_PickUpConvertWithWeight:_CalcCandidatesAroundPlayer(calcParam)
  local policyParam = calcParam.policyParam
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = SkillScopeCalculator:New(utilScopeSvc)
  local candidates = {}
  local posIndexCheck = {}
  local eTeam = calcParam.petEntity:Pet():GetOwnerTeamEntity()
  local teamPos = eTeam:GetGridPosition()
  local aroundBodyAreaCalc = SkillScopeCalculator_AroundBodyArea:New(scopeCalc)
  local aroundTeamScope = aroundBodyAreaCalc:CalcRange(SkillScopeType.AroundBodyArea, {}, teamPos, eTeam:BodyArea():GetArea())
  local aroundAttackRange = aroundTeamScope:GetAttackRange()
  for _, rangePos in ipairs(aroundAttackRange) do
    local posIndex = Vector2.Pos2Index(rangePos)
    if not posIndexCheck[posIndex] and self:_IsSuitableCandidate(rangePos, policyParam) then
      Log.info(self._className, " second class candidate: ", posIndex)
      table.insert(candidates, {
        pos = rangePos,
        weight = 0,
        sortIndex = #candidates
      })
      posIndexCheck[posIndex] = true
    end
  end
  return candidates
end

_class("PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup", Object)
PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup = PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup

function PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup:Constructor(eTeam, desirePieceType)
  self.grids = {}
  self.posIndexDic = {}
  self.isPlayerLinkable = false
  self._desirePieceType = desirePieceType
  self._eTeam = eTeam
  self._world = eTeam:GetOwnerWorld()
  self.surroundingGridIndexDic = {}
end

function PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup:PosJoin(v2)
  if table.Vector2Include(self.grids, v2) then
    return
  end
  table.insert(self.grids, v2)
  local posIndex = Vector2.Pos2Index(v2)
  self.posIndexDic[posIndex] = true
  if not self.isPlayerLinkable and self:_IsPosLinkable(v2) then
    self:SetLinkableByPlayer(true)
  end
end

function PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup:MergeGroup(group)
  table.appendArray(self.grids, group.grids)
  for _, index in pairs(group.posIndexDic) do
    self.posIndexDic[index] = true
  end
  if group.isPlayerLinkable then
    self:SetLinkableByPlayer(true)
  end
end

function PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup:SetLinkableByPlayer(b)
  self.isPlayerLinkable = b
end

function PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup:_IsPosLinkable(v2)
  local v2TeamPos = self._eTeam:GetGridPosition()
  for _, dir in ipairs(directions) do
    if v2 + dir == v2TeamPos then
      return true
    end
  end
  return false
end

local function eq(a, b)
  for _, index in pairs(a.posIndexDic) do
    if not b.posIndexDic[index] then
      return false
    end
  end
  return true
end

PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup.__eq = eq

function PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup:SetSurroundingGridsCache(dic)
  self.surroundingGridIndexDic = dic
end

function PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup:SetPlayerLinkable(b)
  self.isPlayerLinkable = b
end

local function strify(group)
  local t = {"grids: "}
  for _, grid in ipairs(group.grids) do
    table.insert(t, Vector2.Pos2Index(grid))
    table.insert(t, " ")
  end
  table.insert(t, ", isPlayerLinkable: ")
  table.insert(t, tostring(group.isPlayerLinkable))
  return table.concat(t)
end

PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup.__tostring = strify

function PickUpPolicy_PickUpConvertWithWeight:_GetAllLinkableGroups(TT, policyParam, eTeam)
  local utilData = self._world:GetService("UtilData")
  local teamPos = eTeam:GetGridPosition()
  local teamPosIndex = Vector2.Pos2Index(teamPos)
  local posIndexOfSpecificPieceType = {}
  for posIndex, pieceType in pairs(self._boardPosPieces) do
    local v2 = Vector2.Index2Pos(posIndex)
    local isSpecificPieceType = pieceType == policyParam.targetPieceType or pieceType == PieceType.Any
    local isValidPos = utilData:IsValidPiecePos(v2)
    local isNotLinkLineBlocked = not utilData:IsPosBlock(v2, BlockFlag.LinkLine)
    if teamPosIndex ~= posIndex and isSpecificPieceType and isValidPos and isNotLinkLineBlocked then
      table.insert(posIndexOfSpecificPieceType, posIndex)
    end
  end
  local groupDic = {}
  for dataIndex, posIndex in ipairs(posIndexOfSpecificPieceType) do
    if dataIndex % 20 == 0 then
      YIELD(TT)
    end
    local current = Vector2.Index2Pos(posIndex)
    local group = groupDic[posIndex]
    Log.info(self._className, "Calculating group for pos ", posIndex, "group: ", tostring(group))
    for _, dir in ipairs(directions) do
      local aroundPos = current + dir
      local vindex = Vector2.Pos2Index(aroundPos)
      local isSpecificPieceType = self._boardPosPieces[vindex] == policyParam.targetPieceType or self._boardPosPieces[vindex] == PieceType.Any
      local isValidPos = utilData:IsValidPiecePos(aroundPos)
      local isNotLinkLineBlocked = not utilData:IsPosBlock(aroundPos, BlockFlag.LinkLine)
      local isNotPlayerPos = vindex ~= teamPosIndex
      Log.info("   -", self._className, "around pos: ", vindex, "isSpecificPieceType: ", tostring(isSpecificPieceType), "isValidPos: ", tostring(isValidPos), "isNotLinkLineBlocked: ", tostring(isNotLinkLineBlocked), " isNotPlayerPos: ", tostring(isNotPlayerPos))
      if isSpecificPieceType and isValidPos and isNotLinkLineBlocked and isNotPlayerPos then
        if groupDic[vindex] then
          Log.info("       +", self._className, "found group: ", tostring(groupDic[vindex]))
          if group and group == groupDic[vindex] then
            Log.info("       +", self._className, "...same group with calculating pos. ")
          elseif not group then
            Log.info("       +", self._className, "calculating pos has no group, joining to found one")
            groupDic[vindex]:PosJoin(current)
            group = groupDic[vindex]
          else
            Log.info("       +", self._className, "both calculating pos and around pos has group")
            Log.info("       +", self._className, "calculating pos: ", tostring(group))
            Log.info("       +", self._className, "around pos: ", tostring(groupDic[vindex]))
            group:MergeGroup(groupDic[vindex])
            for _, index in pairs(group) do
              groupDic[index] = group
            end
            Log.info("       +", self._className, "...merged group: ", tostring(group))
          end
        else
          if not group then
            Log.info("       +", self._className, "has no group, creating new group for them. ")
            group = PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup:New(eTeam, policyParam.targetPieceType)
            group:PosJoin(current)
            groupDic[posIndex] = group
          end
          group:PosJoin(aroundPos)
          groupDic[vindex] = group
          Log.info("       +", self._className, "joining group of calculating pos. ")
        end
      end
    end
    if not group then
      group = PickUpPolicy_PickUpConvertWithWeight_LinkLineGroup:New(eTeam, policyParam.targetPieceType)
      group:PosJoin(current)
      groupDic[posIndex] = group
    end
  end
  local teamGridPos = eTeam:GetGridPosition()
  local teamGridIndex = Vector2.Pos2Index(teamGridPos)
  local playerLinkableFromPosGroup = {}
  local allGroups = {}
  for _, group in pairs(groupDic) do
    local dic = {}
    for _, grid in ipairs(group.grids) do
      for _, dir in ipairs(directions) do
        local v2 = grid + dir
        local vindex = Vector2.Pos2Index(v2)
        local isValidPos = utilData:IsValidPiecePos(v2)
        local isNotLinkLineBlocked = not utilData:IsPosBlock(v2, BlockFlag.LinkLine)
        if isValidPos and isNotLinkLineBlocked then
          local posIndex = Vector2.Pos2Index(v2)
          dic[posIndex] = true
        end
      end
    end
    group:SetSurroundingGridsCache(dic)
    if dic[teamGridIndex] then
      group:SetPlayerLinkable(true)
      if not table.icontains(playerLinkableFromPosGroup, group) then
        table.insert(playerLinkableFromPosGroup, group)
      end
    end
    if not table.icontains(allGroups, group) then
      table.insert(allGroups, group)
    end
  end
  Log.info(self._className, "all groups: ")
  for _, g in ipairs(allGroups) do
    Log.info("   -", self._className, tostring(g))
  end
  return playerLinkableFromPosGroup, allGroups
end
