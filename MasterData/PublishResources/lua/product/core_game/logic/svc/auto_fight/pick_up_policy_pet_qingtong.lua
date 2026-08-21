require("pick_up_policy_base")
_class("PickUpPolicy_PetQingTong", PickUpPolicy_Base)
PickUpPolicy_PetQingTong = PickUpPolicy_PetQingTong

function PickUpPolicy_PetQingTong:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local pickPosList, atkPosList, targetIds = self:_CalPickPosPolicyPetQingTong(petEntity, activeSkillID, casterPos)
  if 0 < #pickPosList then
    local autoFightSvc = self._world:GetService("AutoFight")
    autoFightSvc:SetCastPetTrapSkillPetEntity(petEntity)
  end
  return pickPosList, atkPosList, targetIds
end

function PickUpPolicy_PetQingTong:_CalPickPosPolicyPetQingTong(petEntity, activeSkillID, casterPos)
  local env = self:_GetPickUpPolicyEnv()
  local configService = self._world:GetService("Config")
  local boardService = self._world:GetService("BoardLogic")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local utilSvc = self._world:GetService("UtilData")
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  local targetIDs = {}
  table.insert(targetIDs, petEntity:GetID())
  local trapID = 0
  local pieceType = 0
  local canPickTrap = false
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local pickPosPolicyParam = skillConfigData:GetAutoFightSkillScopeTypeAndTargetType()
  if pickPosPolicyParam and pickPosPolicyParam.useType == AutoFightScopeUseType.PickPosPolicy then
    trapID = pickPosPolicyParam.trapID
    pieceType = pickPosPolicyParam.pieceType
    canPickTrap = pickPosPolicyParam.canPickTrap
  end
  local targetEntityList = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local teamEntity = petEntity:Pet():GetOwnerTeamEntity()
    local enemyTeam = teamEntity:Team():GetEnemyTeamEntity()
    table.insert(targetEntityList, enemyTeam)
  else
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if not monsterEntity:HasDeadMark() then
        table.insert(targetEntityList, monsterEntity)
      end
    end
  end
  local targetPosList = {}
  local squareRing1PosList = {}
  local squareRing2PosList = {}
  for _, targetEntity in pairs(targetEntityList) do
    local targetPos = targetEntity:GridLocation():GetGridPos()
    local bodyArea = targetEntity:BodyArea():GetArea()
    for _, value in pairs(bodyArea) do
      local workPos = targetPos + value
      table.insert(targetPosList, workPos)
    end
    local ring1 = self:GetPosListAroundBodyArea(targetEntity, 1)
    table.appendArray(squareRing1PosList, ring1)
    local ring2 = self:GetPosListAroundBodyArea(targetEntity, 2)
    table.appendArray(squareRing2PosList, ring2)
  end
  local needSummon, trapPos, matchPieceType = self:_IsNeedSummonTrap(petEntity, trapID, pieceType, targetPosList)
  if canPickTrap and not needSummon and trapPos then
    table.insert(pickPosList, trapPos)
    return pickPosList, pickPosList, targetIDs
  end
  local squareRingListTab = {}
  table.insert(squareRingListTab, squareRing1PosList)
  table.insert(squareRingListTab, squareRing2PosList)
  local pickPos = self:_CalcMatchPickPos(casterPos, squareRingListTab, trapID, pieceType)
  if pickPos then
    table.insert(pickPosList, pickPos)
    return pickPosList, pickPosList, targetIDs
  end
  if canPickTrap and needSummon and trapPos and matchPieceType and self:_CanAttack(trapPos, targetPosList) then
    table.insert(pickPosList, trapPos)
    return pickPosList, pickPosList, targetIDs
  end
  pickPos = self:_CalcMatchPickPos(casterPos, squareRingListTab, trapID)
  if pickPos then
    table.insert(pickPosList, pickPos)
    return pickPosList, pickPosList, targetIDs
  end
  local vec2BoardMax = {}
  local boardRingMax = boardService:GetCurBoardRingMax()
  for _, boardPos in ipairs(boardRingMax) do
    local vec2Pos = Vector2(boardPos[1], boardPos[2])
    table.insert(vec2BoardMax, vec2Pos)
  end
  table.removev(vec2BoardMax, casterPos)
  HelperProxy:SortPosByCenterPosDistance(casterPos, vec2BoardMax)
  local trapSvc = self._world:GetService("TrapLogic")
  for _, pickPos in pairs(vec2BoardMax) do
    if trapSvc:CanSummonTrapOnPos(pickPos, trapID) then
      table.insert(pickPosList, pickPos)
      return pickPosList, pickPosList, targetIDs
    end
  end
  return pickPosList, pickPosList, targetIDs
end

function PickUpPolicy_PetQingTong:_IsNeedSummonTrap(petEntity, trapID, pieceType, targetPosList)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local boardService = self._world:GetService("BoardLogic")
  local trapEntityList = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() and e:TrapID():GetTrapID() == trapID and e:HasSummoner() then
      local summonEntityID = e:Summoner():GetSummonerEntityID()
      local summonEntity = e:GetSummonerEntity()
      if summonEntity and summonEntity:HasSuperEntity() and summonEntity:GetSuperEntity() then
        summonEntityID = summonEntity:GetSuperEntity():GetID()
      end
      if summonEntityID == petEntity:GetID() then
        table.insert(trapEntityList, e)
      end
    end
  end
  if #trapEntityList == 0 then
    return true, nil
  end
  local trapEntity = trapEntityList[1]
  local trapPos = trapEntity:GetGridPosition()
  if utilScopeSvc:IsPosHaveMonsterOrPet(trapPos) then
    return true, trapPos
  end
  if utilScopeSvc:IsPosBlock(trapPos, BlockFlag.LinkLine) then
    return true, trapPos
  end
  if pieceType == boardService:GetPieceType(trapPos) then
    return true, trapPos, true
  end
  if not self:_CanAttack(trapPos, targetPosList) then
    return true, trapPos
  end
  return false, trapPos
end

function PickUpPolicy_PetQingTong:_CalcMatchPickPos(casterPos, posListTab, trapID, pieceType)
  local boardService = self._world:GetService("BoardLogic")
  for _, posList in ipairs(posListTab) do
    posList = table.unique(posList)
    HelperProxy:SortPosByCenterPosDistance(casterPos, posList)
    local trapSvc = self._world:GetService("TrapLogic")
    for _, pickPos in pairs(posList) do
      if trapSvc:CanSummonTrapOnPos(pickPos, trapID) then
        if not pieceType then
          return pickPos
        end
        if pieceType and pieceType ~= boardService:GetPieceType(pickPos) then
          return pickPos
        end
      end
    end
  end
  return nil
end

function PickUpPolicy_PetQingTong:_CanAttack(trapPos, targetPosList)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.Rhombus, {2}, trapPos)
  local attackRange = scopeResult:GetAttackRange()
  local targetInRange = table.union(attackRange, targetPosList)
  if #targetInRange == 0 then
    return false
  end
  return true
end
