require("pick_up_policy_base")
_class("PickUpPolicy_PetYuSen", PickUpPolicy_Base)
PickUpPolicy_PetYuSen = PickUpPolicy_PetYuSen

function PickUpPolicy_PetYuSen:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local env = self:_GetPickUpPolicyEnv()
  local casterPos = petEntity:GridLocation().Position
  local configService = self._world:GetService("Config")
  local boardService = self._world:GetService("BoardLogic")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local utilSvc = self._world:GetService("UtilData")
  local trapID = 0
  local stpSummonTrap
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local skillEffectArray = skillConfigData:GetSkillEffect()
  for _, skillEffect in ipairs(skillEffectArray) do
    if skillEffect:GetEffectType() == SkillEffectType.SummonTrap then
      stpSummonTrap = skillEffect
      trapID = stpSummonTrap:GetTrapID()
      if type(trapID) == "table" then
        trapID = trapID[1]
      end
      break
    end
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
  local trapEntityList = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() and e:TrapID():GetTrapID() == trapID and e:HasSummoner() and e:Summoner():GetSummonerEntityID() == petEntity:GetID() then
      table.insert(trapEntityList, e)
    end
  end
  local pickupPosList = {}
  for _, targetEntity in pairs(targetEntityList) do
    local posList = self:GetPosListAroundBodyArea(targetEntity, 1)
    for _, trapEntity in pairs(trapEntityList) do
      local trapPos = trapEntity:GridLocation():GetGridPos()
      if table.icontains(posList, trapPos) then
        local boardCmpt = self._world:GetBoardEntity():Board()
        local es = boardCmpt:GetPieceEntities(trapPos, function(e)
          return e:HasTeam() or e:HasMonsterID()
        end)
        if #es == 0 and not boardService:IsPosBlock(trapPos, BlockFlag.LinkLine) then
          table.insert(pickupPosList, trapPos)
        end
      end
    end
  end
  local pickPosList = {}
  local targetIDs = {}
  table.insert(targetIDs, petEntity:GetID())
  if 0 < #pickupPosList then
    pickPosList = table.randomn(pickupPosList, 1)
    return pickPosList, pickPosList, targetIDs
  end
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local tarSelector = self._world:GetSkillScopeTargetSelector()
  local posList = utilSvc:GetCloneBoardGridPos()
  local skillScopeResult = SkillScopeResult:New(SkillScopeType.None, petEntity, posList, posList)
  local nearstTargetIDs = tarSelector:DoSelectSkillTarget(petEntity, SkillTargetType.NearestMonster, skillScopeResult)
  if #nearstTargetIDs < 1 then
    return pickPosList, pickPosList, targetIDs
  end
  local targetID = nearstTargetIDs[1]
  local targetEntity = self._world:GetEntityByID(targetID)
  local posList = self:GetPosListAroundBodyArea(targetEntity, 1)
  for _, pickPos in pairs(posList) do
    local trapSvc = self._world:GetService("TrapLogic")
    if stpSummonTrap:GetBlock() == 0 or trapSvc:CanSummonTrapOnPos(pickPos, trapID) then
      table.insert(pickupPosList, pickPos)
    end
  end
  HelperProxy:SortPosByCenterPosDistance(casterPos, pickupPosList)
  for i = 2, #pickupPosList do
    pickupPosList[i] = nil
  end
  return pickupPosList, pickupPosList, targetIDs
end
