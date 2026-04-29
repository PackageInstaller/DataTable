local TargetSelectFilterAttackType = {
  NormalAttack = 1,
  SingleSkillAttack = 2,
  GridSkillAttack = 3
}
_enum("TargetSelectFilterAttackType", TargetSelectFilterAttackType)
_class("SkillScopeTargetData", Object)
SkillScopeTargetData = SkillScopeTargetData

function SkillScopeTargetData:Constructor(pos, entity)
  self.m_pos = pos
  self.m_entity = entity
  self.m_nID = entity:GetID()
end

_class("SkillScopeTargetSelector", Object)
SkillScopeTargetSelector = SkillScopeTargetSelector

function SkillScopeTargetSelector:Constructor(world)
  self._world = world
  self._selectFuncDic = {}
  self._selectFuncDic[SkillTargetType.Self] = self._SelectSelf
  self._selectFuncDic[SkillTargetType.Pet] = self._SelectPet
  self._selectFuncDic[SkillTargetType.Monster] = self._SelectMonster
  self._selectFuncDic[SkillTargetType.AllMover] = self._SelectAllMover
  self._selectFuncDic[SkillTargetType.Board] = self._SelectBoard
  self._selectFuncDic[SkillTargetType.NearestMonster] = self._SelectNearestMonster
  self._selectFuncDic[SkillTargetType.PetAndTrap] = self._SelectPetAndTrap
  self._selectFuncDic[SkillTargetType.Team] = self._SelecTeam
  self._selectFuncDic[SkillTargetType.PetTeam] = self._SelectPetTeam
  self._selectFuncDic[SkillTargetType.MonsterTrap] = self._SelectMonsterTrap
  self._selectFuncDic[SkillTargetType.AllMoverExcept] = self._SelectAllMoverExceptBuff
  self._selectFuncDic[SkillTargetType.PetMonsterTrap] = self._SelectPetMonsterTrap
  self._selectFuncDic[SkillTargetType.NearestPetMonsterTrap] = self._SelectNearestPetMonsterTrap
  self._selectFuncDic[SkillTargetType.OneOfProtectTrapAndPet] = self._SelectOneOfProtectTrapAndPet
  self._selectFuncDic[SkillTargetType.PetMonsterTrapExceptSelfFlyMultiBodyArea] = self._SelectPetMonsterTrapGridExceptConveyorFlyMultiBodyArea
  self._selectFuncDic[SkillTargetType.OwnedPhantom] = self._SelectOwnedPhantom
  self._selectFuncDic[SkillTargetType.NearestMonsterTrap] = self._SelectNearestMonsterTrap
  self._selectFuncDic[SkillTargetType.TrapWithHP] = self._SelectTrapWithHP
  self._selectFuncDic[SkillTargetType.SpecificMonster] = self._SelectSpecificMonster
  self._selectFuncDic[SkillTargetType.MonsterGroup] = self._SelectMonsterGroup
  self._selectFuncDic[SkillTargetType.PetAndTrapBomb] = self._SelectPetAndTrapBomb
  self._selectFuncDic[SkillTargetType.HighestHPPercentMonster] = self._SelectHighestHPPercentMonster
  self._selectFuncDic[SkillTargetType.SpecificPet] = self._SelectSpecificPet
  self._selectFuncDic[SkillTargetType.SpecificPrimaryElementPet] = self._SelectSpecificPrimaryElementPet
  self._selectFuncDic[SkillTargetType.HighestHPMonster] = self._SelectHighestHPMonster
  self._selectFuncDic[SkillTargetType.LowestHPPercentMonster] = self._SelectLowestHPPercentMonster
  self._selectFuncDic[SkillTargetType.LowestHPPercentMonsterParam] = self._SelectLowestHPPercentMonsterParam
  self._selectFuncDic[SkillTargetType.RandomNMonster] = self._SelectRandomNMonster
  self._selectFuncDic[SkillTargetType.Captain] = self._SelecCaptain
  self._selectFuncDic[SkillTargetType.FarestMonster] = self._SelectFarestMonster
  self._selectFuncDic[SkillTargetType.Trap] = self._SelectTrap
  self._selectFuncDic[SkillTargetType.DeadMonsterWithBuff] = self._SelectDeadMonsterWithBuff
  self._selectFuncDic[SkillTargetType.MonsterHaveBuffANoBuffB] = self._SelectMonsterHaveBuffANoBuffB
  self._selectFuncDic[SkillTargetType.NearestMonsterNoID] = self._SelectNearestMonsterNoID
  self._selectFuncDic[SkillTargetType.NearestMonstersIsScope] = self._SelectNearestMonstersIsScope
  self._selectFuncDic[SkillTargetType.SpecificTrap] = self._SelectSpecificTrap
  self._selectFuncDic[SkillTargetType.SpecificTrapAndFarthestHitBackPlayer] = self._SelectSpecificTrapAndFarthestHitBackPlayer
  self._selectFuncDic[SkillTargetType.MonsterTrapDeadOrAlive] = self._SelectMonsterTrapDeadOrAlive
  self._selectFuncDic[SkillTargetType.AlignmentTargetEnemyTeam] = self._SelectAlignmentTargetEnemyTeam
  self._selectFuncDic[SkillTargetType.AlignmentTargetFriendTeam] = self._SelectAlignmentTargetFriendTeam
  self._selectFuncDic[SkillTargetType.AlignmentTargetFriendPet] = self._SelectAlignmentTargetFriendPet
  self._selectFuncDic[SkillTargetType.AlignmentTargetEnemyPet] = self._SelectAlignmentTargetEnemyPet
  self._selectFuncDic[SkillTargetType.AlignmentTargetEnemyTeamHaveBuffANoBuffB] = self._SelectAlignmentTargetEnemyTeamHaveBuffANoBuffB
  self._selectFuncDic[SkillTargetType.GridCanPurifyTrap] = self._SelectGridCanPurifyTrap
  self._selectFuncDic[SkillTargetType.AntiAITriggerEntity] = self._SelectAntiAITriggerEntity
  self._selectFuncDic[SkillTargetType.MaxDamageDealerPetToCaster] = self._SelectMaxDamageDealerPetToCaster
  self._selectFuncDic[SkillTargetType.MonsterTrapAndTrapSuperEntityIsCaster] = self._SelectMonsterTrapAndTrapSuperEntityIsCaster
  self._selectFuncDic[SkillTargetType.MonsterOrEnemyPets] = self._SelectMonsterOrEnemyPets
  self._selectFuncDic[SkillTargetType.NearestMonsterOneByOne] = self._SelectNearestMonsterOneByOne
  self._selectFuncDic[SkillTargetType.LastActiveSkillCasterPet] = self._SelectLastActiveSkillCasterPet
  self._selectFuncDic[SkillTargetType.EntityWithBuff] = self._SelectEntityWithBuff
  self._selectFuncDic[SkillTargetType.MonsterOnSpecificTrap] = self._SelectMonsterOnSpecificTrap
  self._selectFuncDic[SkillTargetType.CaptainInRange] = self._SelectCaptainInRange
  self._selectFuncDic[SkillTargetType.N15ChessMonsterMoveTarget] = self._SelectN15ChessMonsterMoveTarget
  self._selectFuncDic[SkillTargetType.N15ChessMonsterAttackTargets] = self._SelectN15ChessMonsterAttackTargets
  self._selectFuncDic[SkillTargetType.NearestChessPet] = self._SelectNearestChessPet
  self._selectFuncDic[SkillTargetType.ChessPet] = self._SelectChessPet
  self._selectFuncDic[SkillTargetType.MonsterAndChessPet] = self._SelectMonsterAndChessPet
  self._selectFuncDic[SkillTargetType.LessHPChessPet] = self._SelectLessHPChess
  self._selectFuncDic[SkillTargetType.MonsterOrTeam] = self._SelectMonsterOrTeam
  self._selectFuncDic[SkillTargetType.EntityWithBuffOrNearestMonster] = self._SelectEntityWithBuffOrNearestMonster
  self._selectFuncDic[SkillTargetType.TrapSummonEntityIsCaster] = self._SelectTrapSummonEntityIsCaster
  self._selectFuncDic[SkillTargetType.NearestAndFarestMonsterInScope] = self._SelectNearestAndFarestMonsterInScope
  self._selectFuncDic[SkillTargetType.TrapPosByID] = self._SelectTrapPosByID
  self._selectFuncDic[SkillTargetType.NearestMonsterSortByBodyArea] = self._SelectNearestMonsterSortByBodyArea
  self._selectFuncDic[SkillTargetType.CasterSummoner] = self._SelectCasterSummoner
  self._selectFuncDic[SkillTargetType.MostVisibleBuffMonster] = self._SelectMostVisibleBuffMonster
  self._selectFuncDic[SkillTargetType.NearestPetMonsterTrapAndFilter] = self._SelectNearestPetMonsterTrapAndFilter
  self._selectFuncDic[SkillTargetType.MySpecificTrapOrAnyMonster] = self._SelectMySpecificTrapOrAnyMonster
  self._selectFuncDic[SkillTargetType.SelfInAttackRange] = self._SelectSelfInAttackRange
  self._selectFuncDic[SkillTargetType.MonsterNotBoss] = self._SelectMonsterNotBoss
  self._selectFuncDic[SkillTargetType.LastChainSkillRandomNMonster] = self._SelectLastChainSkillRandomNMonster
  self._selectFuncDic[SkillTargetType.BuffLayerMostAndHighestHP] = self._SelectBuffLayerMostAndHighestHP
  self._selectFuncDic[SkillTargetType.MonsterAroundDamageTarget] = self._SelectMonsterAroundDamageTarget
  self._selectFuncDic[SkillTargetType.WorldBossMonster] = self._SelectWorldBossMonster
  self._selectFuncDic[SkillTargetType.SingleGridMonsterLowestHPPercent] = self._SelectSingleGridMonsterLowestHPPercent
  self._selectFuncDic[SkillTargetType.SelectMonsterCamp] = self._SelectMonsterCamp
  self._selectFuncDic[SkillTargetType.PetIgnoreProtectedTrap] = self._SelectPetIgnoreProtectedTrap
  self._selectFuncDic[SkillTargetType.MonsterTrapCanRepeat] = self._SelectMonsterTrapCanRepeat
  self._selectFuncDic[SkillTargetType.PickUpPetOrTrap] = self._SelectPickUpPetOrTrap
  self._selectFuncDic[SkillTargetType.FarestMonsterAndNoBuff] = self._SelectFarestMonsterAndNoBuff
  self._selectFuncDic[SkillTargetType.MonsterWithTeamHPPercentDiffMax] = self._SelectMonsterWithTeamHPPercentDiffMax
end

function SkillScopeTargetSelector:DoSelectSkillTarget(casterEntity, targetType, skillScopeResult, skillID, targetTypeParam)
  local world = casterEntity:GetOwnerWorld()
  targetType = world:ReplaceSkillTarget(targetType)
  local selectFunc = self._selectFuncDic[targetType]
  if selectFunc ~= nil then
    if skillID then
      local configService = world:GetService("Config")
      local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
      local utilData = self._world:GetService("UtilData")
      skillConfigData = utilData:ProcessAutoBeadSkillConfig(skillConfigData, casterEntity)
      local skillTargetTypeParam = skillConfigData:GetSkillTargetTypeParam()
      targetTypeParam = targetTypeParam or skillTargetTypeParam
    end
    local targetEntityIDArray = selectFunc(self, casterEntity, skillScopeResult, skillID, targetTypeParam)
    return targetEntityIDArray
  else
    Log.fatal("SkillScopeTargetSelector no skill target selector:", targetType)
  end
  return {}
end

function SkillScopeTargetSelector:SelectConditionFilter(targetEntity, isNormalAttack)
  local canBeSelected = true
  if targetEntity:HasOutsideRegion() then
    return false
  end
  if targetEntity:HasOffBoardMonster() then
    return false
  end
  local buffComponent = targetEntity:BuffComponent()
  if buffComponent then
    canBeSelected = not buffComponent:HasBuffEffect(BuffEffectType.NotBeSelectedAsSkillTarget)
  end
  if isNormalAttack and targetEntity:HasRide() then
    local rideCmpt = targetEntity:Ride()
    canBeSelected = rideCmpt:GetRiderID() ~= targetEntity:GetID()
  end
  return canBeSelected
end

function SkillScopeTargetSelector:_SelecTeam(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamEntityID = teamEntity:GetID()
  local targetIDArray = {}
  targetIDArray[#targetIDArray + 1] = teamEntityID
  return targetIDArray
end

function SkillScopeTargetSelector:_SelecCaptain(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if casterEntity:HasPet() then
    teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  end
  local teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
  local targetIDArray = {}
  targetIDArray[#targetIDArray + 1] = teamLeaderEntityID
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectSelf(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local casterEntityID = casterEntity:GetID()
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local superEntity = casterEntity:SuperEntityComponent():GetSuperEntity()
    casterEntityID = superEntity:GetID()
  end
  local targetIDArray = {}
  targetIDArray[#targetIDArray + 1] = casterEntityID
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectSelfInAttackRange(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local casterEntityID = casterEntity:GetID()
  local casterPos = casterEntity:GetGridPosition()
  local targetIDArray = {}
  local attackRange = skillScopeResult:GetAttackRange()
  for _, pos in ipairs(attackRange) do
    if pos == casterPos then
      targetIDArray[#targetIDArray + 1] = casterEntityID
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local utilSvc = self._world:GetService("UtilData")
  if casterEntity and casterEntity:HasTrap() then
    local isDimensionDoor = casterEntity:Trap():IsDimensionDoor()
    if isDimensionDoor then
      return self:_SelectPetOnly(casterEntity, skillScopeResult, skillID, targetTypeParam)
    end
  end
  if utilSvc:GetProtectedTrap() and utilSvc:EntityAITargetTypeIsNormal(casterEntity) then
    return self:_SelectTrapAndAoeSelectPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  else
    return self:_SelectPetOnly(casterEntity, skillScopeResult, skillID, targetTypeParam)
  end
end

function SkillScopeTargetSelector:_SelectTrapAndAoeSelectPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local listTrapMap = self:_SelectTrap(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local trapTargetEntity
  for trapId, trapEntity in pairs(listTrapMap) do
    local trapCmpt = trapEntity:Trap()
    if trapCmpt:GetTrapType() == TrapType.Protected then
      trapTargetEntity = trapEntity
    end
  end
  if trapTargetEntity then
    table.insert(targetIDArray, trapTargetEntity:GetID())
    local configService = self._world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
    local skillType = SkillType.SKillTypeEnd
    if skillConfigData then
      skillType = skillConfigData:GetSkillType()
    end
    local petIDArray = {}
    if skillType == SkillType.Normal then
      local dir = self:_GetSkillDir(casterEntity, trapTargetEntity, skillScopeResult)
      petIDArray = self:_SelectPetOnlyWithDir(casterEntity, skillScopeResult, skillID, dir)
    else
      petIDArray = self:_SelectPetOnly(casterEntity, skillScopeResult, skillID, targetTypeParam)
    end
    for _, petId in ipairs(petIDArray) do
      table.insert(targetIDArray, petId)
    end
  else
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_GetSkillDir(casterEntity, trapTargetEntity, skillScopeResult)
  local utilSvc = self._world:GetService("UtilData")
  local listTarget = {}
  local attackRange = skillScopeResult:GetAttackRange()
  local curDir
  for _, skillRangePos in ipairs(attackRange) do
    local listTrap = utilSvc:GetTrapsAtPos(skillRangePos)
    for i = 1, #listTrap do
      local targetEntityID = listTrap[i]:GetID()
      if targetEntityID then
        local selectTrapFilter = self:_SelectTrapFilter(casterEntity, targetEntityID, true)
        if selectTrapFilter then
          for j, bodyArea in ipairs(casterEntity:BodyArea():GetArea()) do
            local curMonsterBodyPos = casterEntity:GridLocation().Position + bodyArea
            local dir = GameHelper.ComputeLogicDir(skillRangePos - curMonsterBodyPos)
            if dir.x == 0 or dir.y == 0 then
              curDir = dir
              break
            end
          end
        end
      end
      if curDir then
        break
      end
    end
    if curDir then
      break
    end
  end
  return curDir
end

function SkillScopeTargetSelector:_SelectPetOnlyWithDir(casterEntity, skillScopeResult, skillID, dir)
  local targetIDArray = {}
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GridLocation().Position
  local attackRange = skillScopeResult:GetAttackRange()
  for i = 1, #attackRange do
    if playerPos == attackRange[i] then
      local curDir
      for j, bodyArea in ipairs(casterEntity:BodyArea():GetArea()) do
        local curMonsterBodyPos = casterEntity:GridLocation().Position + bodyArea
        local dir = GameHelper.ComputeLogicDir(playerPos - curMonsterBodyPos)
        if dir.x == 0 or dir.y == 0 then
          curDir = dir
          break
        end
      end
      if curDir == dir then
        targetIDArray[#targetIDArray + 1] = teamEntity:GetID()
      end
      break
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectPetOnly(casterEntity, skillScopeResult, skillID)
  local targetIDArray = {}
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GridLocation().Position
  local attackRange = skillScopeResult:GetAttackRange()
  for i = 1, #attackRange do
    if playerPos == attackRange[i] then
      targetIDArray[#targetIDArray + 1] = teamEntity:GetID()
      break
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectOneOfProtectTrapAndPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local utilSvc = self._world:GetService("UtilData")
  local protectTrapEntity = utilSvc:GetProtectedTrap()
  if protectTrapEntity and utilSvc:EntityAITargetTypeIsNormal(casterEntity) then
    return {
      protectTrapEntity:GetID()
    }
  else
    return self:_SelectPetOnly(casterEntity, skillScopeResult, skillID, targetTypeParam)
  end
end

function SkillScopeTargetSelector:_SelectMonster(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local attackRange = skillScopeResult:GetAttackRange()
  for _, skillRangePos in ipairs(attackRange) do
    local targetIDInSkillRangeList = self:_CalcMonsterInSkillRange(skillRangePos)
    for _, v in ipairs(targetIDInSkillRangeList) do
      if 0 < v then
        targetIDArray[#targetIDArray + 1] = v
      end
    end
  end
  if targetTypeParam and type(targetTypeParam) == "table" and 0 < table.count(targetTypeParam) then
    local targetCount = targetTypeParam[1] or 1
    if targetCount == 0 then
      targetCount = 999
    end
    local newTargetIDArray = {}
    for i = 1, table.count(targetIDArray) do
      if i <= targetCount then
        table.insert(newTargetIDArray, targetIDArray[i])
      end
    end
    targetIDArray = newTargetIDArray
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectAllMover(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local pets = self:_SelectPet(casterEntity, skillScopeResult, skillID)
  for _, v in ipairs(pets) do
    table.insert(targetIDArray, v)
  end
  local monsters = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  for _, v in ipairs(monsters) do
    table.insert(targetIDArray, v)
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectNearestMonster(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local casterPos = casterEntity:GridLocation().Position
  local allMonsters = {}
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local selectTargetData = utilScopeSvc:SortMonstersByPos(casterPos)
  for _, element in ipairs(selectTargetData) do
    local monsterEntity = element.monster_e
    allMonsters[#allMonsters + 1] = monsterEntity:GetID()
  end
  local selectedMonsterIds = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  local isFind = false
  if selectedMonsterIds then
    for i = 1, #allMonsters do
      local monsterId = allMonsters[i]
      for _, v in ipairs(selectedMonsterIds) do
        if v == monsterId then
          targetIDArray[#targetIDArray + 1] = monsterId
          isFind = true
          break
        end
      end
      if isFind then
        break
      end
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectFarestMonster(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local casterPos = casterEntity:GridLocation().Position
  local allMonsters = {}
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local selectTargetData = utilScopeSvc:SortMonstersByPos(casterPos)
  local selectHpZero = 1
  if targetTypeParam and type(targetTypeParam) == "table" then
    selectHpZero = targetTypeParam[1] or 1
  end
  for _, element in ipairs(selectTargetData) do
    local monsterEntity = element.monster_e
    allMonsters[#allMonsters + 1] = monsterEntity:GetID()
  end
  local allMonstersFar = {}
  for i = #allMonsters, 1, -1 do
    allMonstersFar[#allMonstersFar + 1] = allMonsters[i]
  end
  local selectedMonsterIds = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  local isFind = false
  if selectedMonsterIds then
    for i = 1, #allMonstersFar do
      local monsterId = allMonstersFar[i]
      for _, v in ipairs(selectedMonsterIds) do
        if v == monsterId then
          local e = self._world:GetEntityByID(v)
          local percent = self:_GetHPPercent(e)
          local hpIsSatisfied = true
          if selectHpZero == 0 and percent == 0 then
            hpIsSatisfied = false
          end
          if hpIsSatisfied then
            targetIDArray[#targetIDArray + 1] = monsterId
            isFind = true
            break
          end
        end
      end
      if isFind then
        break
      end
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_CalcMonsterInSkillRange(skillRangePos, withDead)
  local targetIDList = {}
  if skillRangePos._className == nil then
    for _, v in ipairs(skillRangePos) do
      local checkPos = v
      local targetEntityIDs = self:_FindTargetEntityInPos(checkPos, withDead)
      if 0 < #targetEntityIDs then
        table.appendArray(targetIDList, targetEntityIDs)
      end
    end
  else
    local targetEntityIDs = self:_FindTargetEntityInPos(skillRangePos, withDead)
    if 0 < #targetEntityIDs then
      table.appendArray(targetIDList, targetEntityIDs)
    end
  end
  return targetIDList
end

function SkillScopeTargetSelector:_FindTargetEntityInPos(checkPos, withDead)
  local targetEntityID = {}
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if (withDead or not e:HasDeadMark()) and self:SelectConditionFilter(e) then
      local monsterEntityID = e:GetID()
      local monster_grid_location_cmpt = e:GridLocation()
      local monster_body_area_cmpt = e:BodyArea()
      local monster_body_area = monster_body_area_cmpt:GetArea()
      for i, bodyArea in ipairs(monster_body_area) do
        local curMonsterBodyPos = monster_grid_location_cmpt.Position + bodyArea
        if curMonsterBodyPos == checkPos then
          if e:HasRide() and e:Ride():GetRiderID() == monsterEntityID then
            table.insert(targetEntityID, 1, monsterEntityID)
            break
          end
          table.insert(targetEntityID, monsterEntityID)
          break
        end
      end
      if not table.intable(targetEntityID, monsterEntityID) and monster_grid_location_cmpt:GetGridPos() == checkPos then
        table.insert(targetEntityID, monsterEntityID)
      end
    end
  end
  return targetEntityID
end

function SkillScopeTargetSelector:_SelectBoard(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local boardEntity = self._world:GetBoardEntity()
  local targetIDArray = {}
  targetIDArray[#targetIDArray + 1] = boardEntity:GetID()
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectPetTeam(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local targetIDArray = {}
  local pets = teamEntity:Team():GetTeamPetEntities()
  for _, e in ipairs(pets) do
    if not targetTypeParam then
      targetIDArray[#targetIDArray + 1] = e:GetID()
    elseif self:_CheckPetElement(e, targetTypeParam) then
      targetIDArray[#targetIDArray + 1] = e:GetID()
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_CheckPetElement(e, elements)
  if elements == 0 or 0 >= table.count(elements) then
    return true
  end
  if 1 == nCount and 0 == elements[1] then
    return true
  end
  local elementCmpt = e:Element()
  local primaryType = elementCmpt:GetPrimaryType()
  for _, pieceType in ipairs(elements) do
    if CanMatchPieceType(primaryType, pieceType) then
      return true
    end
  end
  return false
end

function SkillScopeTargetSelector:_FindTargetEntityInPosByFilter(checkPos, filter)
  local targetEntityID = -1
  local g = self._world:GetGroup(filter)
  for _, e in ipairs(g:GetEntities()) do
    local entityID = e:GetID()
    local cGridLocation = e:GridLocation()
    local cBodyArea = e:BodyArea()
    local area = cBodyArea:GetArea()
    for i, bodyArea in ipairs(area) do
      local curMonsterBodyPos = cGridLocation.Position + bodyArea
      if curMonsterBodyPos == checkPos then
        targetEntityID = entityID
        break
      end
    end
  end
  return targetEntityID
end

function SkillScopeTargetSelector:_SelectTrap(casterEntity, skillScopeResult, skillID, targetTypeParam, isAttack)
  local utilSvc = self._world:GetService("UtilData")
  local listTarget = {}
  local attackRange = skillScopeResult:GetAttackRange()
  for _, skillRangePos in ipairs(attackRange) do
    local listTrap = utilSvc:GetTrapsAtPos(skillRangePos)
    for i = 1, #listTrap do
      local targetEntityID = listTrap[i]:GetID()
      if targetEntityID then
        local selectTrapFilter = self:_SelectTrapFilter(casterEntity, targetEntityID, isAttack)
        if selectTrapFilter then
          listTarget[targetEntityID] = listTrap[i]
        end
      end
    end
  end
  return listTarget
end

function SkillScopeTargetSelector:_SelectTrapWithHP(casterEntity, skillScopeResult, skillID)
  local mapTrap = self:_SelectTrapByHit(casterEntity, skillScopeResult, skillID)
  local targetIDArray = {}
  for key, value in pairs(mapTrap) do
    table.insert(targetIDArray, key)
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectTrapByHit(casterEntity, skillScopeResult, skillID)
  local listTarget = {}
  local listTargetByRange = self:_SelectEntityByTypeAndRange(self._world.BW_WEMatchers.Trap, skillScopeResult:GetAttackRange())
  for key, value in ipairs(listTargetByRange) do
    local entityTrap = value.m_entity
    local id = entityTrap:GetID()
    if 0 < id and self:_SelectTrapFilter(casterEntity, id, true) then
      listTarget[id] = entityTrap
    end
  end
  return listTarget
end

function SkillScopeTargetSelector:_SelectTrapByHitCanRepeat(casterEntity, skillScopeResult, skillID)
  local listTarget = {}
  local listTargetByRange = self:_SelectEntityByTypeAndRange(self._world.BW_WEMatchers.Trap, skillScopeResult:GetAttackRange())
  for key, value in ipairs(listTargetByRange) do
    local entityTrap = value.m_entity
    local id = entityTrap:GetID()
    if 0 < id and self:_SelectTrapFilter(casterEntity, id, true) then
      table.insert(listTarget, entityTrap)
    end
  end
  return listTarget
end

function SkillScopeTargetSelector:_SelectTrapFilter(casterEntity, trapEntityID, isAttack, isDeadOrAlive)
  if isAttack == nil then
    isAttack = true
  end
  local trapEntity = self._world:GetEntityByID(trapEntityID)
  local trapCmpt = trapEntity:Trap()
  if isDeadOrAlive or trapEntity:HasDeadMark() then
    return false
  end
  if trapEntity:Trap():GetTrapType() == TrapType.BombByHitBack then
    return true
  end
  if trapEntity:Attributes():GetAttribute("CanBeAttacked") == 0 and isAttack then
    return false
  end
  if casterEntity:HasPetPstID() and trapCmpt:GetTrapType() == TrapType.Protected then
    return false
  end
  return true
end

function SkillScopeTargetSelector:_SelectMonsterTrap(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local monsters = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  for _, v in ipairs(monsters) do
    table.insert(targetIDArray, v)
  end
  local mapTrap = self:_SelectTrapByHit(casterEntity, skillScopeResult, skillID, targetTypeParam)
  for key, value in pairs(mapTrap) do
    if value:Trap():GetTrapType() ~= TrapType.Protected then
      table.insert(targetIDArray, key)
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectMonsterTrapCanRepeat(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local monsters = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  for _, v in ipairs(monsters) do
    table.insert(targetIDArray, v)
  end
  local listTrap = self:_SelectTrapByHitCanRepeat(casterEntity, skillScopeResult, skillID, targetTypeParam)
  for index, value in ipairs(listTrap) do
    if value:Trap():GetTrapType() ~= TrapType.Protected then
      local entityID = value:GetID()
      table.insert(targetIDArray, entityID)
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectAllMoverExceptBuff(casterEntity, skillScopeResult, skillID, filterBuffEffect)
  local targetIDArray = {}
  local pets = self:_SelectPet(casterEntity, skillScopeResult, skillID, filterBuffEffect)
  local validatePets = self:_FilterByBuffEffect(pets, filterBuffEffect)
  for _, v in ipairs(validatePets) do
    table.insert(targetIDArray, v)
  end
  local monsters = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  local validateMonsters = self:_FilterByBuffEffect(monsters, filterBuffEffect)
  for _, v in ipairs(validateMonsters) do
    table.insert(targetIDArray, v)
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_FilterByBuffEffect(movers, filterBuffEffect)
  local targetIDArray = {}
  for _, v in ipairs(movers) do
    local buffCpt = self._world:GetEntityByID(v):BuffComponent()
    local validate = true
    if buffCpt then
      for _, value in ipairs(filterBuffEffect) do
        if buffCpt:HasBuffEffect(value) then
          validate = false
          break
        end
      end
    end
    if validate then
      table.insert(targetIDArray, v)
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectPetMonsterTrap(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local arr = {}
  local pets = self:_SelectPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  if pets then
    for i, v in ipairs(pets) do
      table.insert(arr, v)
    end
  end
  local monsterTrap = self:_SelectMonsterTrap(casterEntity, skillScopeResult, skillID, targetTypeParam)
  if monsterTrap then
    for i, v in ipairs(monsterTrap) do
      table.insert(arr, v)
    end
  end
  return arr
end

function SkillScopeTargetSelector:_SelectPetAndTrap(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local arr = {}
  local pets = self:_SelectPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  table.appendArray(arr, pets)
  local mapTrap = self:_SelectTrapByHit(casterEntity, skillScopeResult, skillID, targetTypeParam)
  if mapTrap then
    for key, value in pairs(mapTrap) do
      table.insert(arr, key)
    end
  end
  return arr
end

function SkillScopeTargetSelector:_SelectNearestPetMonsterTrap(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targets = self:_SelectPetMonsterTrap(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local nearestIds, nearestMagnitude = {}, 999
  local center = casterEntity:GridLocation():Center()
  if targets then
    for i, id in ipairs(targets) do
      local e = self._world:GetEntityByID(id)
      local pos = e:GridLocation().Position
      local bodyArea = e:BodyArea():GetArea()
      for j, grid in ipairs(bodyArea) do
        local absPos = pos + grid
        local magnitude = Vector2.Magnitude(absPos - center)
        if nearestMagnitude > magnitude then
          nearestMagnitude = magnitude
          nearestIds = {id}
        elseif nearestMagnitude == magnitude then
          table.insert(nearestIds, id)
        end
      end
    end
  end
  return nearestIds
end

function SkillScopeTargetSelector:_SelectNearestPetMonsterTrapAndFilter(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targets = self:_SelectPetMonsterTrap(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local nearestIds, nearestMagnitude = {}, 999
  local center = casterEntity:GridLocation():Center()
  if table.count(targets) > 1 then
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    if table.intable(targets, teamEntity:GetID()) then
      local logicChainPathCmpt = teamEntity:LogicChainPath()
      local chainAcrossMonster = logicChainPathCmpt:GetChainAcrossMonster()
      if chainAcrossMonster then
        table.removev(targets, teamEntity:GetID())
      end
    end
  end
  if targets then
    for i, id in ipairs(targets) do
      local e = self._world:GetEntityByID(id)
      local pos = e:GridLocation().Position
      local bodyArea = e:BodyArea():GetArea()
      for j, grid in ipairs(bodyArea) do
        local absPos = pos + grid
        local magnitude = Vector2.Magnitude(absPos - center)
        if nearestMagnitude > magnitude then
          nearestMagnitude = magnitude
          nearestIds = {id}
        elseif nearestMagnitude == magnitude then
          table.insert(nearestIds, id)
        end
      end
    end
  end
  return nearestIds
end

function SkillScopeTargetSelector:_SelectNearestMonsterTrap(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targets = self:_SelectMonsterTrap(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local nearestIds, nearestMagnitude = {}, 999
  local center = casterEntity:GridLocation():Center()
  if targets then
    for i, id in ipairs(targets) do
      local e = self._world:GetEntityByID(id)
      local pos = e:GridLocation().Position
      local bodyArea = e:BodyArea():GetArea()
      for j, grid in ipairs(bodyArea) do
        local absPos = pos + grid
        local magnitude = Vector2.Magnitude(absPos - center)
        if nearestMagnitude > magnitude then
          nearestMagnitude = magnitude
          nearestIds = {id}
        elseif nearestMagnitude == magnitude then
          table.insert(nearestIds, id)
        end
      end
    end
  end
  return nearestIds
end

function SkillScopeTargetSelector:_SelectPetMonsterTrapGridExceptConveyorFlyMultiBodyArea(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local arr = {}
  local pets = self:_SelectPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  if pets then
    for i, v in ipairs(pets) do
      table.insert(arr, v)
    end
  end
  local monsters = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  local cfgService = self._world:GetService("Config")
  local monsterConfigData = cfgService:GetMonsterConfigData()
  if monsters then
    for i, v in ipairs(monsters) do
      local e = self._world:GetEntityByID(v)
      local bodyArea = e:BodyArea():GetArea()
      local monsterID = e:MonsterID():GetMonsterID()
      local monsterRaceType = monsterConfigData:GetMonsterRaceType(monsterID)
      if table.count(bodyArea) == 1 and monsterRaceType ~= MonsterRaceType.Fly then
        table.insert(arr, v)
      end
    end
  end
  local listTrapMap = self:_SelectTrap(casterEntity, skillScopeResult, skillID, targetTypeParam, false)
  if listTrapMap then
    for id, trapEntity in pairs(listTrapMap) do
      local cTrap = trapEntity:Trap()
      if id ~= casterEntity:GetID() then
        table.insert(arr, id)
      end
    end
  end
  return arr
end

function SkillScopeTargetSelector:_SelectOwnedPhantom(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDs = {}
  local phantoms = self._world:GetGroup(self._world.BW_WEMatchers.Phantom)
  if phantoms and #phantoms:GetEntities() > 0 then
    local entitys = phantoms:GetEntities()
    for _, entity in ipairs(entitys) do
      if entity:PhantomComponent():GetOwnerEntityID() == casterEntity:GetID() and not entity:HasDeadMark() then
        targetIDs[#targetIDs + 1] = entity:GetID()
      end
    end
  else
    Log.fatal("场上没有幻象")
  end
  return targetIDs
end

function SkillScopeTargetSelector:_IsEntityInRange(entityWork, attackRange)
  local posBase = entityWork:GetGridPosition()
  local listBodyArea = entityWork:BodyArea():GetArea()
  local posList = table.create(#listBodyArea, 0)
  for key, value in pairs(listBodyArea) do
    local posWork = posBase + value
    if attackRange._className == nil then
      if table.icontains(attackRange, posWork) then
        table.insert(posList, posWork)
      end
    elseif attackRange == posWork then
      table.insert(posList, posWork)
    end
  end
  return 0 < table.count(posList), posList
end

function SkillScopeTargetSelector:_SelectEntityByTypeAndRange(nEntityGroupType, attackRange, isNormalAttack)
  local group = self._world:GetGroup(nEntityGroupType)
  local entityList = group:GetEntities()
  local listTarget = {}
  for _, skillRangePos in ipairs(attackRange) do
    for key, value in ipairs(entityList) do
      if not value:HasDeadMark() and self:SelectConditionFilter(value, isNormalAttack) then
        local bIsInRange, listPos = self:_IsEntityInRange(value, skillRangePos)
        if bIsInRange then
          for i = 1, #listPos do
            local targetData = SkillScopeTargetData:New(listPos[i], value)
            table.insert(listTarget, targetData)
          end
        end
      end
    end
  end
  return listTarget
end

function SkillScopeTargetSelector:_SelectSpecificMonster(casterEntity, skillScopeResult, skillID, listSpecificMonsterID)
  local listTargetByRange = self:_SelectEntityByTypeAndRange(self._world.BW_WEMatchers.MonsterID, skillScopeResult:GetAttackRange())
  local cfgService = self._world:GetService("Config")
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local listReturn = {}
  for key, value in ipairs(listTargetByRange) do
    local entityWork = value.m_entity
    local nMonsterID = entityWork:MonsterID():GetMonsterID()
    local nMonsterClassID = monsterConfigData:GetMonsterClassID(nMonsterID)
    if table.icontains(listSpecificMonsterID, nMonsterClassID) then
      local nEntityID = entityWork:GetID()
      if not table.icontains(listReturn, nEntityID) then
        table.insert(listReturn, nEntityID)
      end
    end
  end
  return listReturn
end

function SkillScopeTargetSelector:_SelectMonsterGroup(casterEntity, skillScopeResult, skillID, nIncludeSelf)
  local listTargetByRange = self:_SelectEntityByTypeAndRange(self._world.BW_WEMatchers.MonsterID, skillScopeResult:GetAttackRange())
  local listReturn = {}
  local cmptCasterMonster = casterEntity:MonsterID()
  if cmptCasterMonster then
    local nSelfGroupID = cmptCasterMonster:GetMonsterGroupID()
    for key, value in ipairs(listTargetByRange) do
      local entityWork = value.m_entity
      local nMonsterGroupID = entityWork:MonsterID():GetMonsterGroupID()
      local bFind = false
      if nSelfGroupID == nMonsterGroupID then
        bFind = true
        if not nIncludeSelf and entityWork == casterEntity then
          bFind = false
        end
      end
      if bFind then
        local nEntityID = entityWork:GetID()
        if not table.icontains(listReturn, nEntityID) then
          table.insert(listReturn, nEntityID)
        end
      end
    end
  end
  return listReturn
end

function SkillScopeTargetSelector:_SelectPetAndTrapBomb(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local arr = {}
  local pets = self:_SelectPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  table.appendArray(arr, pets)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local posPlayer = teamEntity:GetGridPosition()
  local posSelf = casterEntity:GetGridPosition()
  local mapTrap = self:_SelectTrapByHit(casterEntity, skillScopeResult, skillID, targetTypeParam)
  if mapTrap then
    for key, entityBomb in pairs(mapTrap) do
      if GameHelper.IsPointOneLine(posSelf, entityBomb:GetGridPosition(), posPlayer) then
        table.insert(arr, key)
      end
    end
  end
  return arr
end

function SkillScopeTargetSelector:_SelectHighestHPPercentMonster(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDlist = {}
  local monsters = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  if not monsters then
    return targetIDlist
  end
  local count = table.count(monsters)
  if count == 0 then
    return targetIDlist
  end
  local fstId = monsters[1]
  if count == 1 then
    table.insert(targetIDlist, fstId)
    return targetIDlist
  end
  local highestHPPercent = 0
  local highestHPPercentId = 0
  for i = 1, count do
    local id = monsters[i]
    local e = self._world:GetEntityByID(id)
    local percent = self:_GetHPPercent(e)
    if highestHPPercent < percent then
      highestHPPercent = percent
      highestHPPercentId = id
    end
  end
  if 0 < highestHPPercentId then
    table.insert(targetIDlist, highestHPPercentId)
  end
  return targetIDlist
end

function SkillScopeTargetSelector:_SelectSpecificPet(casterEntity, skillScopeResult, skillID, tSpecificPetID)
  local tPetEntityID = {}
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local publicPetEntities = teamEntity:Team():GetTeamPetEntities()
  for _, entity in ipairs(publicPetEntities) do
    local cPetPst = entity:PetPstID()
    local templateID = cPetPst:GetTemplateID()
    if table.icontains(tSpecificPetID, templateID) then
      table.insert(tPetEntityID, entity:GetID())
    end
  end
  return tPetEntityID
end

function SkillScopeTargetSelector:_SelectSpecificPrimaryElementPet(casterEntity, skillScopeResult, skillID, tElement)
  local dicElement = {}
  for _, nElement in ipairs(tElement) do
    dicElement[nElement] = true
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local publicPetEntities = teamEntity:Team():GetTeamPetEntities()
  local tPetEntityID = {}
  for _, entity in ipairs(publicPetEntities) do
    local cElement = entity:Element()
    local nMainElement = cElement:GetPrimaryType()
    if dicElement[nMainElement] then
      table.insert(tPetEntityID, entity:GetID())
    end
  end
  return tPetEntityID
end

function SkillScopeTargetSelector:_SelectHighestHPMonster(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDlist = {}
  local monsters = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  if not monsters then
    return targetIDlist
  end
  local count = table.count(monsters)
  if count == 0 then
    return targetIDlist
  end
  local fstId = monsters[1]
  if count == 1 then
    table.insert(targetIDlist, fstId)
    return targetIDlist
  end
  local targetIDCount = 1
  if targetTypeParam and type(targetTypeParam) == "table" then
    targetIDCount = targetTypeParam[1] or 1
  end
  if targetIDCount == 1 then
    local highestHP = 0
    local highestHPId = 0
    for i = 1, count do
      local id = monsters[i]
      local e = self._world:GetEntityByID(id)
      local hp = e:Attributes():GetCurrentHP()
      if highestHP < hp then
        highestHP = hp
        highestHPId = id
      end
    end
    if 0 < highestHPId then
      table.insert(targetIDlist, highestHPId)
    end
  else
    local findID = {}
    local hpDataList = {}
    for i = 1, count do
      local id = monsters[i]
      if not findID[id] then
        findID[id] = 1
        local e = self._world:GetEntityByID(id)
        local hp = e:Attributes():GetCurrentHP()
        local hpData = {hp = hp, id = id}
        table.insert(hpDataList, hpData)
      end
    end
    table.sort(hpDataList, function(a, b)
      return a.hp > b.hp
    end)
    for i = 1, targetIDCount do
      if hpDataList[i] then
        table.insert(targetIDlist, hpDataList[i].id)
      end
    end
  end
  return targetIDlist
end

function SkillScopeTargetSelector:_GetHPPercent(e)
  local hp = e:Attributes():GetCurrentHP()
  local maxHP = e:Attributes():CalcMaxHp()
  local percent = hp / maxHP
  return percent
end

function SkillScopeTargetSelector:_SelectLowestHPPercentMonster(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDlist = {}
  local monsters = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  local count = table.count(monsters)
  if not monsters or count == 0 then
    return targetIDlist, 1
  end
  if count == 1 then
    local fstId = monsters[1]
    local e = self._world:GetEntityByID(fstId)
    local percent = self:_GetHPPercent(e)
    table.insert(targetIDlist, fstId)
    return targetIDlist, percent
  end
  local hpPercent = 999
  local hpPercentId = 0
  local selectHpZero = 1
  if targetTypeParam and type(targetTypeParam) == "table" then
    selectHpZero = targetTypeParam[1] or 1
  end
  local targetIDCount = 1
  if targetTypeParam and type(targetTypeParam) == "table" then
    targetIDCount = targetTypeParam[2] or 1
  end
  if targetIDCount == 1 then
    for i = 1, count do
      local id = monsters[i]
      local e = self._world:GetEntityByID(id)
      local percent = self:_GetHPPercent(e)
      local hpIsSatisfied = true
      if selectHpZero == 0 and percent == 0 then
        hpIsSatisfied = false
      end
      if hpIsSatisfied and hpPercent >= percent then
        hpPercent = percent
        hpPercentId = id
      end
    end
    if hpPercentId == 0 then
      local utilScopeSvc = self._world:GetService("UtilScopeCalc")
      local idx = utilScopeSvc:_GetRandomNumber(1, count)
      local id = monsters[idx]
      local e = self._world:GetEntityByID(id)
      local percent = self:_GetHPPercent(e)
      hpPercent = percent
      hpPercentId = id
    end
    if 0 < hpPercentId then
      table.insert(targetIDlist, hpPercentId)
    end
  else
    local findID = {}
    local hpDataList = {}
    for i = 1, count do
      local id = monsters[i]
      if not findID[id] then
        findID[id] = 1
        local e = self._world:GetEntityByID(id)
        local percent = self:_GetHPPercent(e)
        local hpIsSatisfied = true
        if selectHpZero == 0 and percent == 0 then
          hpIsSatisfied = false
        end
        if hpIsSatisfied then
          local hpData = {percent = percent, id = id}
          table.insert(hpDataList, hpData)
        end
      end
    end
    table.sort(hpDataList, function(a, b)
      return a.percent < b.percent
    end)
    for i = 1, targetIDCount do
      if hpDataList[i] then
        table.insert(targetIDlist, hpDataList[i].id)
        hpPercent = hpDataList[i].percent
      end
    end
  end
  return targetIDlist, hpPercent
end

function SkillScopeTargetSelector:_SelectLowestHPPercentMonsterParam(casterEntity, skillScopeResult, skillID, param)
  local ids, percent = self:_SelectLowestHPPercentMonster(casterEntity, skillScopeResult, skillID, param)
  local percentParam = 0
  if param then
    percentParam = param[1]
  end
  if percent < percentParam then
    return ids
  end
  return {}
end

function SkillScopeTargetSelector:_SelectRandomNMonster(casterEntity, skillScopeResult, skillID, param)
  local monsterIdList = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  monsterIdList = table.unique(monsterIdList)
  local ids = {}
  if monsterIdList and table.count(monsterIdList) > 0 then
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local count = param[1]
    if count and 0 < count then
      for i = 1, count do
        if #monsterIdList == 0 then
          break
        end
        local rate = param[1 + i]
        local needCal = false
        if 1 <= rate then
          needCal = true
        else
          local randomNum = utilScopeSvc:_GetRandomNumber()
          needCal = rate > randomNum
        end
        if needCal then
          local idx = utilScopeSvc:_GetRandomNumber(1, table.count(monsterIdList))
          table.insert(ids, monsterIdList[idx])
          table.remove(monsterIdList, idx)
        end
      end
    end
  end
  return ids
end

function SkillScopeTargetSelector:_SelectDeadMonster(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local attackRange = skillScopeResult:GetAttackRange()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  for _, skillRangePos in ipairs(attackRange) do
    local isHasMonster, monsterID = utilScopeSvc:IsPosHasMonster(skillRangePos)
    if isHasMonster then
      local monsterEntity = self._world:GetEntityByID(monsterID)
      local curHp = monsterEntity:Attributes():GetCurrentHP()
      if curHp and curHp <= 0 then
        targetIDArray[#targetIDArray + 1] = monsterID
      end
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectDeadMonsterWithBuff(casterEntity, skillScopeResult, skillID, filterBuffEffect)
  local monsterIdList = self:_SelectDeadMonster(casterEntity, skillScopeResult, skillID, filterBuffEffect)
  monsterIdList = table.unique(monsterIdList)
  local validateMonsters = self:_FilterMustHaveBuffEffect(monsterIdList, filterBuffEffect)
  local retTargetID = {}
  return validateMonsters
end

function SkillScopeTargetSelector:_FilterMustHaveBuffEffect(movers, filterBuffEffect)
  local targetIDArray = {}
  for _, v in ipairs(movers) do
    local buffCpt = self._world:GetEntityByID(v):BuffComponent()
    local validate = true
    if buffCpt then
      for _, value in ipairs(filterBuffEffect) do
        if not buffCpt:HasBuffEffect(value) then
          validate = false
          break
        end
      end
    end
    if validate then
      table.insert(targetIDArray, v)
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectMonsterHaveBuffANoBuffB(casterEntity, skillScopeResult, skillID, filterBuffEffect)
  local monsterIdList = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  monsterIdList = table.unique(monsterIdList)
  local validateMonsters = self:_FilterMustHaveBuffEffect(monsterIdList, {
    filterBuffEffect[1]
  })
  validateMonsters = self:_FilterByBuffEffect(validateMonsters, {
    filterBuffEffect[2]
  })
  return validateMonsters
end

function SkillScopeTargetSelector:_SelectNearestMonsterNoID(casterEntity, skillScopeResult, skillID, monsterIDList)
  local ownPos = skillScopeResult:GetCenterPos()
  local utilScopeCalc = self._world:GetService("UtilScopeCalc")
  local targetIDArray = {}
  local selectedMonsterIds = self:_SelectMonster(casterEntity, skillScopeResult, skillID, nil)
  if selectedMonsterIds then
    local monsterList = utilScopeCalc:SortMonstersListByPos(ownPos, selectedMonsterIds)
    for _, element in ipairs(monsterList) do
      local monsterEntity = element.monster_e
      if not table.icontains(monsterIDList, monsterEntity:MonsterID():GetMonsterClassID()) and not monsterEntity:HasDeadMark() then
        targetIDArray[#targetIDArray + 1] = monsterEntity:GetID()
        break
      end
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectNearestMonstersIsScope(casterEntity, skillScopeResult, skillID, param)
  local nMonsterCount = param[1]
  local ownPos = skillScopeResult:GetCenterPos()
  if #ownPos ~= 0 then
    if EDITOR then
      Log.exception("CenterPosIsTable SkillID:", skillID)
    else
      Log.fatal("CenterPosIsTable SkillID:", skillID)
    end
  end
  local utilScopeCalc = self._world:GetService("UtilScopeCalc")
  local selectedMonsterIds = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  selectedMonsterIds = table.unique(selectedMonsterIds)
  local sortMonsterList = utilScopeCalc:SortMonstersListByPos(ownPos, selectedMonsterIds)
  local targetIDArray = {}
  for i, id in ipairs(sortMonsterList) do
    if i > nMonsterCount then
      break
    end
    table.insert(targetIDArray, id.monster_e:GetID())
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectSpecificTrap(casterEntity, skillScopeResult, skillID, param)
  if type(param) == "number" then
    param = {param}
  end
  local utilDatSvc = self._world:GetService("UtilData")
  local trapEntityList = self:_SelectTrap(casterEntity, skillScopeResult, skillID, nil, false)
  local resultList = {}
  for _, entity in pairs(trapEntityList) do
    if entity:Trap() and table.intable(param, entity:Trap():GetTrapID()) and utilDatSvc:IsTrapPosCanMoveMonster(entity, casterEntity) then
      table.insert(resultList, entity:GetID())
      break
    end
  end
  return resultList
end

function SkillScopeTargetSelector:_SelectSpecificTrapAndFarthestHitBackPlayer(casterEntity, skillScopeResult, skillID, param)
  if type(param) == "number" then
    param = {param}
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local trapEntityList = self:_SelectTrap(casterEntity, skillScopeResult, skillID, nil, false)
  local tempEntityList = {}
  local resultList = {}
  for _, entity in pairs(trapEntityList) do
    if entity:Trap() and table.intable(param, entity:Trap():GetTrapID()) then
      table.insert(tempEntityList, entity)
    end
  end
  if 1 < #tempEntityList then
    local utilCalcSvc = self._world:GetService("UtilCalc")
    local posList = {}
    for _, entity in ipairs(tempEntityList) do
      local attackerPos = entity:GetGridPosition()
      table.insert(posList, attackerPos)
    end
    local pos = utilCalcSvc:GetHitBackPlayerFarthestPos(posList, casterEntity, HitBackDirectionType.EightDir, teamEntity)
    for _, entity in ipairs(tempEntityList) do
      local attackerPos = entity:GetGridPosition()
      if attackerPos.x == pos.x and attackerPos.y == pos.y then
        resultList[1] = entity:GetID()
        break
      end
    end
  elseif #tempEntityList == 1 then
    resultList[1] = tempEntityList[1]:GetID()
  end
  return resultList
end

function SkillScopeTargetSelector:_SelectMonsterDeadOrAlive(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local attackRange = skillScopeResult:GetAttackRange()
  for _, skillRangePos in ipairs(attackRange) do
    local targetIDInSkillRangeList = self:_CalcMonsterInSkillRange(skillRangePos, true)
    for _, v in ipairs(targetIDInSkillRangeList) do
      if 0 < v then
        targetIDArray[#targetIDArray + 1] = v
      end
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectTrapByHitDeadOrAlive(casterEntity, skillScopeResult, skillID)
  local listTarget = {}
  local listTargetByRange = self:_SelectEntityByTypeAndRange(self._world.BW_WEMatchers.Trap, skillScopeResult:GetAttackRange())
  for key, value in ipairs(listTargetByRange) do
    local entityTrap = value.m_entity
    local id = entityTrap:GetID()
    if 0 < id and self:_SelectTrapFilter(casterEntity, id, true, true) then
      listTarget[id] = entityTrap
    end
  end
  return listTarget
end

function SkillScopeTargetSelector:_SelectMonsterTrapDeadOrAlive(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local monsters = self:_SelectMonsterDeadOrAlive(casterEntity, skillScopeResult, skillID, targetTypeParam)
  for _, v in ipairs(monsters) do
    table.insert(targetIDArray, v)
  end
  local mapTrap = self:_SelectTrapByHitDeadOrAlive(casterEntity, skillScopeResult, skillID, targetTypeParam)
  for key, value in pairs(mapTrap) do
    if value:Trap():GetTrapType() ~= TrapType.Protected then
      table.insert(targetIDArray, key)
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectAlignmentTargetEnemyTeam(casterEntity, skillScopeResult, skillID)
  local team1 = self._world:Player():GetLocalTeamEntity()
  local team2 = self._world:Player():GetRemoteTeamEntity()
  local teams = {team1, team2}
  local match = MatchAlignmentType
  local casterAlignment = casterEntity:Alignment():GetAlignmentType()
  local attackRange = skillScopeResult:GetAttackRange()
  local range = {}
  for i, v in ipairs(attackRange) do
    if v._className == "Vector2" then
      range[#range + 1] = v
    else
      table.appendArray(range, v)
    end
  end
  local es = {}
  for i, e in ipairs(teams) do
    local targetAlignment = e:Alignment():GetAlignmentType()
    local targetType = match(casterAlignment, targetAlignment)
    if targetType == AlignmentTargetType.Enemy and not e:HasTeamDeadMark() and table.icontains(range, e:GetGridPosition()) then
      es[#es + 1] = e:GetID()
    end
  end
  local mapTrap = self:_SelectTrapByHit(casterEntity, skillScopeResult, skillID)
  for key, value in pairs(mapTrap) do
    if value:Trap():GetTrapType() ~= TrapType.Protected then
      es[#es + 1] = key
    end
  end
  return es
end

function SkillScopeTargetSelector:_SelectAlignmentTargetFriendTeam(casterEntity, skillScopeResult, skillID)
  local team1 = self._world:Player():GetLocalTeamEntity()
  local team2 = self._world:Player():GetRemoteTeamEntity()
  local teams = {team1, team2}
  local match = MatchAlignmentType
  local casterAlignment = casterEntity:Alignment():GetAlignmentType()
  local es = {}
  for i, e in ipairs(teams) do
    local targetAlignment = e:Alignment():GetAlignmentType()
    local targetType = match(casterAlignment, targetAlignment)
    if targetType == AlignmentTargetType.Friend then
      es[#es + 1] = e:GetID()
    end
  end
  return es
end

function SkillScopeTargetSelector:_SelectAlignmentTargetFriendPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local team1 = self._world:Player():GetLocalTeamEntity()
  local team2 = self._world:Player():GetRemoteTeamEntity()
  local teams = {team1, team2}
  local match = MatchAlignmentType
  local casterAlignment = casterEntity:Alignment():GetAlignmentType()
  local attackRange = skillScopeResult:GetAttackRange()
  local targetPieceType = targetTypeParam
  local range = {}
  for i, v in ipairs(attackRange) do
    if v._className == "Vector2" then
      range[#range + 1] = v
    else
      table.appendArray(range, v)
    end
  end
  local es = {}
  for i, eTeam in ipairs(teams) do
    local targetAlignment = eTeam:Alignment():GetAlignmentType()
    local targetType = match(casterAlignment, targetAlignment)
    if targetType == AlignmentTargetType.Friend then
      if table.icontains(range, eTeam:GetGridPosition()) then
        for i, e in ipairs(eTeam:Team():GetTeamPetEntities()) do
          if not targetPieceType or self:_CheckPetElement(e, targetPieceType) then
            es[#es + 1] = e:GetID()
          end
        end
      end
      break
    end
  end
  return es
end

function SkillScopeTargetSelector:_SelectAlignmentTargetEnemyPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local team1 = self._world:Player():GetLocalTeamEntity()
  local team2 = self._world:Player():GetRemoteTeamEntity()
  local teams = {team1, team2}
  local match = MatchAlignmentType
  local casterAlignment = casterEntity:Alignment():GetAlignmentType()
  local targetPieceType = targetTypeParam
  local attackRange = skillScopeResult:GetAttackRange()
  local range = {}
  for i, v in ipairs(attackRange) do
    if v._className == "Vector2" then
      range[#range + 1] = v
    else
      table.appendArray(range, v)
    end
  end
  local es = {}
  for i, eTeam in ipairs(teams) do
    local targetAlignment = eTeam:Alignment():GetAlignmentType()
    local targetType = match(casterAlignment, targetAlignment)
    if targetType == AlignmentTargetType.Enemy then
      if not eTeam:HasTeamDeadMark() and table.icontains(range, eTeam:GetGridPosition()) then
        for i, e in ipairs(eTeam:Team():GetTeamPetEntities()) do
          if not targetPieceType or self:_CheckPetElement(e, targetPieceType) then
            es[#es + 1] = e:GetID()
          end
        end
      end
      break
    end
  end
  return es
end

function SkillScopeTargetSelector:_SelectAlignmentTargetEnemyTeamHaveBuffANoBuffB(casterEntity, skillScopeResult, skillID, filterBuffEffect)
  local team1 = self._world:Player():GetLocalTeamEntity()
  local team2 = self._world:Player():GetRemoteTeamEntity()
  local teams = {team1, team2}
  local match = MatchAlignmentType
  local casterAlignment = casterEntity:Alignment():GetAlignmentType()
  local attackRange = skillScopeResult:GetAttackRange()
  local range = {}
  for i, v in ipairs(attackRange) do
    if v._className == "Vector2" then
      range[#range + 1] = v
    else
      table.appendArray(range, v)
    end
  end
  local es = {}
  for i, e in ipairs(teams) do
    local targetAlignment = e:Alignment():GetAlignmentType()
    local targetType = match(casterAlignment, targetAlignment)
    if targetType == AlignmentTargetType.Enemy and not e:HasTeamDeadMark() and table.icontains(range, e:GetGridPosition()) then
      es[#es + 1] = e:GetID()
    end
  end
  es = self:_FilterMustHaveBuffEffect(es, {
    filterBuffEffect[1]
  })
  es = self:_FilterByBuffEffect(es, {
    filterBuffEffect[2]
  })
  return es
end

function SkillScopeTargetSelector:_SelectEntityWithBuff(casterEntity, skillScopeResult, skillID, filterBuffEffect)
  filterBuffEffect = filterBuffEffect or {}
  local targetBuffEffect = filterBuffEffect[1] or 0
  local filterRange = filterBuffEffect[2]
  local team1 = self._world:Player():GetLocalTeamEntity()
  local es = {team1}
  local team2 = self._world:Player():GetRemoteTeamEntity()
  if team2 then
    es[#es + 1] = team2
  end
  local monsters = self._world:GetGroupEntities(self._world.BW_WEMatchers.AliveMonster)
  table.appendArray(es, monsters)
  local attackRange = skillScopeResult:GetAttackRange()
  local range = {}
  for i, v in ipairs(attackRange) do
    if v._className == "Vector2" then
      range[#range + 1] = v
    else
      table.appendArray(range, v)
    end
  end
  local ret = {}
  for i, e in ipairs(es) do
    if filterRange then
      local inRange = self:_IsEntityInRange(e, attackRange)
      if inRange and e:BuffComponent():HasBuffEffect(targetBuffEffect) then
        ret[#ret + 1] = e:GetID()
      end
    elseif e:BuffComponent():HasBuffEffect(targetBuffEffect) then
      ret[#ret + 1] = e:GetID()
    end
  end
  return ret
end

function SkillScopeTargetSelector:_SelectGridCanPurifyTrap(casterEntity, skillScopeResult, skillID, effectParam)
  local es = {}
  local tv2Candidate = {}
  for _, v2GridPos in ipairs(skillScopeResult:GetAttackRange()) do
    table.insert(tv2Candidate, v2GridPos)
  end
  if #tv2Candidate == 0 then
    return es
  end
  local udsvc = self._world:GetService("UtilData")
  for _, v2 in ipairs(tv2Candidate) do
    local array = udsvc:GetTrapsAtPos(v2)
    for _, eTrap in ipairs(array) do
      local cTrap = eTrap:Trap()
      if not eTrap:HasDeadMark() and cTrap:CanBePurified() then
        table.insert(es, eTrap:GetID())
      end
    end
  end
  return es
end

function SkillScopeTargetSelector:_SelectAntiAITriggerEntity(casterEntity, skillScopeResult, skillID, effectParam)
  local cBattleStat = casterEntity:GetOwnerWorld():BattleStat()
  local e = casterEntity:GetOwnerWorld():GetEntityByID(cBattleStat:GetLastAntiTriggerEntityID())
  if e then
    return {
      e:GetID()
    }
  end
  return {}
end

function SkillScopeTargetSelector:_SelectMaxDamageDealerPetToCaster(casterEntity, skillScopeResult, skillID, effectParam)
  local cDamageStatistics = casterEntity:DamageStatisticsComponent()
  if not cDamageStatistics then
    return {}
  end
  local es = {}
  local array = cDamageStatistics:GetDamageSourceArray()
  for i = #array, 1, -1 do
    local e = self._world:GetEntityByID(array[i].entityID)
    if e:HasPetPstID() then
      if e:HasBuffFlag(BuffFlags.SealedCurse) then
        Log.info("MaxDamageDealerPetToCaster: skip already cursed target: ", e:GetID())
      else
        table.insert(es, e:GetID())
        Log.info("MaxDamageDealerPetToCaster: curse target: ", e:GetID())
        break
      end
    end
  end
  return es
end

function SkillScopeTargetSelector:_SelectMonsterTrapAndTrapSuperEntityIsCaster(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local es = self:_SelectAlignmentTargetEnemyTeam(casterEntity, skillScopeResult, skillID)
    table.appendArray(targetIDArray, es)
  else
    local monsterTrapID = self:_SelectMonsterTrap(casterEntity, skillScopeResult, skillID, targetTypeParam)
    table.appendArray(targetIDArray, monsterTrapID)
  end
  local trapEntityList = self:_SelectTrap(casterEntity, skillScopeResult, skillID, nil, false)
  for _, entity in pairs(trapEntityList) do
    if entity:HasSummoner() then
      local superEntityID = entity:Summoner():GetSummonerEntityID()
      if superEntityID == casterEntity:GetID() and not table.intable(targetIDArray, entity:GetID()) then
        table.insert(targetIDArray, entity:GetID())
      end
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectMonsterOrEnemyPets(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local ret = self:_SelectMonster(casterEntity, skillScopeResult, skillID, targetTypeParam)
  return ret
end

function SkillScopeTargetSelector:_SelectNearestMonsterOneByOne(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local targetIDArray = self:_SelectAlignmentTargetEnemyTeam(casterEntity, skillScopeResult, skillID)
    return targetIDArray
  end
  local targetIDCount = targetTypeParam[1]
  local monsters = self:_SelectMonster(casterEntity, skillScopeResult, skillID, nil)
  if table.count(monsters) == 0 then
    return targetIDArray
  end
  local selectCenterPos = skillScopeResult:GetCenterPos()
  local utilScopeCalc = self._world:GetService("UtilScopeCalc")
  local calcCount = 0
  while table.count(monsters) > 0 do
    local monsterList = utilScopeCalc:SortMonstersListByPos(selectCenterPos, monsters)
    for _, element in ipairs(monsterList) do
      local monsterEntity = element.monster_e
      if not table.icontains(targetIDArray, monsterEntity:GetID()) and not monsterEntity:HasDeadMark() then
        targetIDArray[#targetIDArray + 1] = monsterEntity:GetID()
        selectCenterPos = monsterEntity:GetGridPosition()
        while table.intable(monsters, monsterEntity:GetID()) do
          table.removev(monsters, monsterEntity:GetID())
        end
        break
      end
    end
    if targetIDCount <= table.count(targetIDArray) then
      break
    end
    calcCount = calcCount + 1
    if 10 < calcCount then
      break
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectLastActiveSkillCasterPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local cBattleStat = casterEntity:GetOwnerWorld():BattleStat()
  local e = casterEntity:GetOwnerWorld():GetEntityByID(cBattleStat:GetLastActiveSkillCasterID())
  if e then
    return {
      e:GetID()
    }
  end
  return {}
end

function SkillScopeTargetSelector:_SelectMonsterOnSpecificTrap(casterEntity, skillScopeResult, skillID, param)
  if type(param) == "number" then
    param = {param}
  end
  local utilDatSvc = self._world:GetService("UtilData")
  local trapEntityList = self:_SelectTrap(casterEntity, skillScopeResult, skillID, nil, false)
  local resultList = {}
  local trapPosList = {}
  for _, entity in pairs(trapEntityList) do
    if entity:Trap() and not entity:HasDeadMark() and table.intable(param, entity:Trap():GetTrapID()) then
      local trapPos = entity:GetGridPosition()
      table.insert(trapPosList, trapPos)
    end
  end
  local monsters = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  if monsters then
    for i, v in ipairs(monsters) do
      local e = self._world:GetEntityByID(v)
      local bodyArea = e:BodyArea():GetArea()
      local pos = e:GridLocation().Position
      for j, grid in ipairs(bodyArea) do
        local workPos = pos + grid
        if table.intable(trapPosList, workPos) and not table.intable(resultList, v) then
          table.insert(resultList, v)
        end
      end
    end
  end
  return resultList
end

function SkillScopeTargetSelector:_SelectCaptainInRange(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if casterEntity:HasPet() then
    teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  end
  local teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
  local targetIDArray = {}
  local teamLeaderGridPos = teamEntity:GetGridPosition()
  local attackRange = skillScopeResult:GetAttackRange()
  if table.icontains(attackRange, teamLeaderGridPos) then
    targetIDArray[#targetIDArray + 1] = teamLeaderEntityID
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectN15ChessMonsterMoveTarget(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local utilScopeCalc = self._world:GetService("UtilScopeCalc")
  local casterPos = casterEntity:GetGridPosition()
  local entityIDList = utilScopeCalc:GetSortChessPetByMonsterPos(casterPos)
  if 1 <= #entityIDList then
    return {
      entityIDList[1]
    }
  else
    return {}
  end
end

function SkillScopeTargetSelector:_SelectN15ChessMonsterAttackTargets(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local utilScopeCalc = self._world:GetService("UtilScopeCalc")
  local attackRange = skillScopeResult:GetAttackRange()
  local entityIDList = utilScopeCalc:ChessMonsterSelectTarget(attackRange, targetTypeParam[1])
  return entityIDList
end

function SkillScopeTargetSelector:_SelectNearestChessPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local casterPos = casterEntity:GridLocation().Position
  local AllChessPet = {}
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local chessPetGroup = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
  local chessPetIDList = {}
  for _, e in ipairs(chessPetGroup:GetEntities()) do
    table.insert(chessPetIDList, e:GetID())
  end
  local selectTargetData = utilScopeSvc:SortMonstersListByPos(casterPos, chessPetIDList)
  if selectTargetData ~= nil and 0 < #selectTargetData then
    local firstData = selectTargetData[1]
    local entity = firstData.monster_e
    targetIDArray[#targetIDArray + 1] = entity:GetID()
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectChessPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local attackRange = skillScopeResult:GetAttackRange()
  for _, skillRangePos in ipairs(attackRange) do
    local targetIDInSkillRangeList = self:_CalcChessPetInSkillRange(skillRangePos)
    for _, v in ipairs(targetIDInSkillRangeList) do
      if 0 < v then
        targetIDArray[#targetIDArray + 1] = v
      end
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_CalcChessPetInSkillRange(skillRangePos, withDead)
  local targetIDList = {}
  local targetEntityID = -1
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if (withDead or not e:HasDeadMark()) and self:SelectConditionFilter(e) then
      local monsterEntityID = e:GetID()
      local monster_grid_location_cmpt = e:GridLocation()
      local monster_body_area_cmpt = e:BodyArea()
      local monster_body_area = monster_body_area_cmpt:GetArea()
      for i, bodyArea in ipairs(monster_body_area) do
        local curMonsterBodyPos = monster_grid_location_cmpt.Position + bodyArea
        if curMonsterBodyPos == skillRangePos then
          targetEntityID = monsterEntityID
          break
        end
      end
    end
  end
  if 0 < targetEntityID then
    targetIDList[#targetIDList + 1] = targetEntityID
  end
  return targetIDList
end

function SkillScopeTargetSelector:_SelectMonsterAndChessPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local monsters = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  for _, v in ipairs(monsters) do
    table.insert(targetIDArray, v)
  end
  local chessPets = self:_SelectChessPet(casterEntity, skillScopeResult, skillID, targetTypeParam)
  for _, v in ipairs(chessPets) do
    table.insert(targetIDArray, v)
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectLessHPChess(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetEntityID
  local hp = 1000
  local attackRange = skillScopeResult:GetAttackRange()
  for _, skillRangePos in ipairs(attackRange) do
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
    for _, e in ipairs(monsterGroup:GetEntities()) do
      if not e:HasDeadMark() and self:SelectConditionFilter(e) then
        local monsterEntityID = e:GetID()
        local monster_grid_location_cmpt = e:GridLocation()
        local monster_body_area_cmpt = e:BodyArea()
        local monster_body_area = monster_body_area_cmpt:GetArea()
        local curHp = e:Attributes():GetCurrentHP()
        for i, bodyArea in ipairs(monster_body_area) do
          local curMonsterBodyPos = monster_grid_location_cmpt.Position + bodyArea
          if curMonsterBodyPos == skillRangePos and hp > curHp then
            targetEntityID = monsterEntityID
            hp = curHp
            break
          end
        end
      end
    end
  end
  return {targetEntityID}
end

function SkillScopeTargetSelector:_SelectMonsterOrTeam(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local monsters = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  if 0 < #monsters then
    return monsters
  else
    return self:_SelecTeam(casterEntity, skillScopeResult, skillID, targetTypeParam)
  end
end

function SkillScopeTargetSelector:_SelectEntityWithBuffOrNearestMonster(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local buffTargets = self:_SelectEntityWithBuff(casterEntity, skillScopeResult, skillID, targetTypeParam)
  if 0 < #buffTargets then
    return buffTargets
  else
    return self:_SelectNearestMonsterWithScopeCenter(casterEntity, skillScopeResult, skillID, targetTypeParam)
  end
end

function SkillScopeTargetSelector:_SelectNearestMonsterWithScopeCenter(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local casterPos = skillScopeResult:GetCenterPos()
  local allMonsters = {}
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local selectTargetData = utilScopeSvc:SortMonstersByPos(casterPos, true)
  for _, element in ipairs(selectTargetData) do
    local monsterEntity = element.monster_e
    allMonsters[#allMonsters + 1] = monsterEntity:GetID()
  end
  local selectedMonsterIds = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  local isFind = false
  if selectedMonsterIds then
    for i = 1, #allMonsters do
      local monsterId = allMonsters[i]
      for _, v in ipairs(selectedMonsterIds) do
        if v == monsterId then
          targetIDArray[#targetIDArray + 1] = monsterId
          isFind = true
          break
        end
      end
      if isFind then
        break
      end
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectTrapSummonEntityIsCaster(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local trapEntityList = self:_SelectTrap(casterEntity, skillScopeResult, skillID, nil, false)
  for _, entity in pairs(trapEntityList) do
    if entity:HasSummoner() then
      local summonEntityID = entity:Summoner():GetSummonerEntityID()
      local summonEntity = entity:GetSummonerEntity()
      if summonEntity and summonEntity:HasSuperEntity() and summonEntity:GetSuperEntity() then
        summonEntityID = summonEntity:GetSuperEntity():GetID()
      end
      if summonEntityID == casterEntity:GetID() and not table.intable(targetIDArray, entity:GetID()) then
        table.insert(targetIDArray, entity:GetID())
      end
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectNearestAndFarestMonsterInScope(casterEntity, skillScopeResult, skillID, param)
  local nMonsterCount = param[1]
  local ownPos = skillScopeResult:GetCenterPos()
  if #ownPos ~= 0 then
    if EDITOR then
      Log.exception("CenterPosIsTable SkillID:", skillID)
    else
      Log.fatal("CenterPosIsTable SkillID:", skillID)
    end
  end
  local utilScopeCalc = self._world:GetService("UtilScopeCalc")
  local selectedMonsterIds = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  selectedMonsterIds = table.unique(selectedMonsterIds)
  local sortMonsterList = utilScopeCalc:SortMonstersListByPos(ownPos, selectedMonsterIds)
  local targetIDArray = {}
  for i, id in ipairs(sortMonsterList) do
    if i > nMonsterCount then
      break
    end
    table.insert(targetIDArray, id.monster_e:GetID())
  end
  local findFarestCount = 1
  local monsterListCount = #sortMonsterList
  for i = monsterListCount, 1, -1 do
    if nMonsterCount < findFarestCount then
      break
    end
    table.insert(targetIDArray, sortMonsterList[i].monster_e:GetID())
    findFarestCount = findFarestCount + 1
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectTrapPosByID(casterEntity, skillScopeResult, skillID, param)
  if type(param) == "number" then
    param = {param}
  end
  local utilDatSvc = self._world:GetService("UtilData")
  local trapEntityList = self:_SelectTrap(casterEntity, skillScopeResult, skillID, nil, false)
  local resultList = {}
  for _, entity in pairs(trapEntityList) do
    if entity:Trap() and table.intable(param, entity:Trap():GetTrapID()) then
      table.insert(resultList, entity:GetID())
    end
  end
  return resultList
end

function SkillScopeTargetSelector:_SelectNearestMonsterSortByBodyArea(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local nMonsterCount = targetTypeParam[1] or 1
  local casterPos = skillScopeResult:GetCenterPos()
  casterPos = casterPos or casterEntity:GridLocation().Position
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local selectedMonsterIds = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
  selectedMonsterIds = table.unique(selectedMonsterIds)
  local sortMonsterList = utilScopeSvc:SortMonstersListByBodyAreaAndPos(casterPos, selectedMonsterIds, true)
  local targetIDArray = {}
  for i, id in ipairs(sortMonsterList) do
    if i > nMonsterCount then
      break
    end
    table.insert(targetIDArray, id.monster_e:GetID())
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectCasterSummoner(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local useEntity = casterEntity
  local casterEntityID = casterEntity:GetID()
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local superEntity = casterEntity:SuperEntityComponent():GetSuperEntity()
    if superEntity then
      casterEntityID = superEntity:GetID()
      useEntity = superEntity
    end
  end
  local ownerID
  if useEntity:HasSummoner() then
    local ownerEntity = useEntity:GetSummonerEntity()
    if ownerEntity then
      ownerID = ownerEntity:GetID()
    end
  end
  local targetIDArray = {}
  if ownerID then
    targetIDArray[#targetIDArray + 1] = ownerID
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectMostVisibleBuffMonster(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local selectHpZero = 1
  if targetTypeParam and type(targetTypeParam) == "table" then
    selectHpZero = targetTypeParam[1] or 1
  end
  local maxVal = 0
  local maxTarget = {}
  local globalMonsterGroup = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(globalMonsterGroup) do
    if not e:HasDeadMark() and self:SelectConditionFilter(e) then
      local cBuff = e:BuffComponent()
      local buffArray = cBuff:GetBuffArray()
      local count = 0
      for _, instance in ipairs(buffArray) do
        local buffID = instance:BuffID()
        local cfgBuff = Cfg.cfg_buff[buffID]
        if cfgBuff.ShowBuffIcon then
          count = count + 1
        end
      end
      local isHPValid = true
      if selectHpZero == 0 then
        local percent = self:_GetHPPercent(e)
        isHPValid = 0 < percent
      end
      if isHPValid then
        if maxVal == count then
          table.insert(maxTarget, e:GetID())
        elseif maxVal < count then
          maxTarget = {}
          maxVal = count
          table.insert(maxTarget, e:GetID())
        end
      end
    end
  end
  if #maxTarget == 0 then
    return {}
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local idx = utilScopeSvc:_GetRandomNumber(1, #maxTarget)
  return {
    maxTarget[idx]
  }
end

function SkillScopeTargetSelector:_SelectMySpecificTrapOrAnyMonster(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local arr = {}
  local specificTrapIds = {}
  if targetTypeParam and type(targetTypeParam) == "table" then
    specificTrapIds = targetTypeParam
  end
  local listTrapMap = self:_SelectTrap(casterEntity, skillScopeResult, skillID, targetTypeParam, false)
  if listTrapMap then
    for id, trapEntity in pairs(listTrapMap) do
      local cTrap = trapEntity:Trap()
      local trapId = cTrap:GetTrapID()
      if trapEntity:HasSummoner() then
        local summonerEntityID = trapEntity:Summoner():GetSummonerEntityID()
        if summonerEntityID == casterEntity:GetID() and table.icontains(specificTrapIds, trapId) then
          table.insert(arr, id)
        end
      end
    end
  end
  if 0 < #arr then
    return arr
  end
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local es = self:_SelectAlignmentTargetEnemyTeam(casterEntity, skillScopeResult, skillID)
    table.appendArray(arr, es)
  else
    local monsters = self:_SelectMonster(casterEntity, skillScopeResult, skillID)
    table.appendArray(arr, monsters)
  end
  return arr
end

function SkillScopeTargetSelector:_SelectMonsterNotBoss(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local targetIDArray = {}
  local attackRange = skillScopeResult:GetAttackRange()
  for _, skillRangePos in ipairs(attackRange) do
    local targetIDInSkillRangeList = self:_CalcMonsterInSkillRange(skillRangePos)
    for _, v in ipairs(targetIDInSkillRangeList) do
      if 0 < v then
        local monsterEntity = self._world:GetEntityByID(v)
        if not monsterEntity:HasBoss() then
          targetIDArray[#targetIDArray + 1] = v
        end
      end
    end
  end
  if targetTypeParam and type(targetTypeParam) == "table" and 0 < table.count(targetTypeParam) then
    local targetCount = targetTypeParam[1] or 1
    if targetCount == 0 then
      targetCount = 999
    end
    local newTargetIDArray = {}
    for i = 1, table.count(targetIDArray) do
      if i <= targetCount then
        table.insert(newTargetIDArray, targetIDArray[i])
      end
    end
    targetIDArray = newTargetIDArray
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectLastChainSkillRandomNMonster(casterEntity, skillScopeResult, skillID, param)
  if casterEntity:HasSuperEntity() then
    casterEntity = casterEntity:GetSuperEntity()
  end
  local monsterIdList = {}
  local petAttackDataCmpt = casterEntity:SkillPetAttackData()
  local multiStageChainAttackDataList = petAttackDataCmpt:GetMultiStageChainAttackDataList()
  if multiStageChainAttackDataList then
    for _, chainAttackDataList in ipairs(multiStageChainAttackDataList) do
      for k, skillChainAttackData in pairs(chainAttackDataList) do
        local attdata = skillChainAttackData
        local damageResultArray = attdata:GetEffectResultByArrayAll(SkillEffectType.Damage)
        if damageResultArray then
          for k, res in ipairs(damageResultArray) do
            local targetEntityID = res:GetTargetID()
            if 0 < targetEntityID and not table.intable(monsterIdList, targetEntityID) then
              table.insert(monsterIdList, targetEntityID)
            end
          end
        end
      end
    end
  end
  local ids = {}
  if monsterIdList and 0 < table.count(monsterIdList) then
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local count = param[1]
    if count and 0 < count then
      for i = 1, count do
        if #monsterIdList == 0 then
          break
        end
        local rate = param[1 + i]
        local needCal = false
        if 1 <= rate then
          needCal = true
        else
          local randomNum = utilScopeSvc:_GetRandomNumber()
          needCal = rate > randomNum
        end
        if needCal then
          local idx = utilScopeSvc:_GetRandomNumber(1, table.count(monsterIdList))
          table.insert(ids, monsterIdList[idx])
          table.remove(monsterIdList, idx)
        end
      end
    end
  end
  return ids
end

function SkillScopeTargetSelector:_SelectBuffLayerMostAndHighestHP(casterEntity, skillScopeResult, skillID, param)
  local targetIDArray = {}
  local targetBuffEffect = param[1] or 0
  local es = {}
  local monsters = self._world:GetGroupEntities(self._world.BW_WEMatchers.AliveMonster)
  for _, monster in ipairs(monsters) do
    local buffComponent = monster:BuffComponent()
    if buffComponent and buffComponent:HasBuffEffect(targetBuffEffect) then
      table.insert(es, monster)
    end
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  if 0 < table.count(es) then
    local buffLogicService = self._world:GetService("BuffLogic")
    table.sort(es, function(a, b)
      local buffLayerA = buffLogicService:GetBuffLayer(a, targetBuffEffect)
      local buffLayerB = buffLogicService:GetBuffLayer(b, targetBuffEffect)
      if buffLayerA == buffLayerB then
        local hpA = a:Attributes():GetCurrentHP()
        local hpB = b:Attributes():GetCurrentHP()
        return hpA > hpB
      end
      return buffLayerA > buffLayerB
    end)
    local mostBuffLayer = 0
    local mostHP = 0
    local randomEntityList = {}
    for i, e in ipairs(es) do
      local curBuffLayer = buffLogicService:GetBuffLayer(e, targetBuffEffect)
      local curHP = e:Attributes():GetCurrentHP()
      if i == 1 then
        if curBuffLayer == 0 then
          break
        end
        mostBuffLayer = curBuffLayer
        mostHP = curHP
      elseif mostBuffLayer == curBuffLayer and mostHP == curHP then
        table.insert(randomEntityList, e)
      end
    end
    if 0 < table.count(randomEntityList) then
      table.insert(randomEntityList, es[1])
      local idx = utilScopeSvc:_GetRandomNumber(1, table.count(randomEntityList))
      local monster = randomEntityList[idx]
      table.insert(targetIDArray, monster:GetID())
    else
      table.insert(targetIDArray, es[1]:GetID())
    end
  end
  if table.count(es) == 0 and 0 < table.count(monsters) then
    targetIDArray = self:_SelectNearestMonster(casterEntity, skillScopeResult, skillID, param)
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectMonsterAroundDamageTarget(casterEntity, skillScopeResult, skillID, param)
  local targetIDArray = {}
  local selectCount = param[1] or -1
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local preDamageStageIndex = 1
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, preDamageStageIndex)
  if not damageResultArray or table.count(damageResultArray) == 0 then
    return targetIDArray
  end
  local randomService = self._world:GetService("RandomLogic")
  for _, v in ipairs(damageResultArray) do
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local defenderEntity = self._world:GetEntityByID(targetEntityID)
    if defenderEntity then
      local monsterIDListAroundDefender = {}
      local defenderBodyArea = defenderEntity:BodyArea():GetArea()
      local bodyAreaCount = #defenderBodyArea
      local onlyMaxRing = true
      local ringCount = 1
      local defenderPos = defenderEntity:GetGridPosition()
      local defenderRingPosList = ComputeScopeRange.ComputeRange_SquareRing(defenderPos, bodyAreaCount, ringCount, onlyMaxRing)
      for index, ringPos in ipairs(defenderRingPosList) do
        local withDead = false
        local targetEntityIDs = self:_FindTargetEntityInPos(ringPos, withDead)
        if 0 < #targetEntityIDs then
          for idIndex, targetEntityID in ipairs(targetEntityIDs) do
            if not table.icontains(monsterIDListAroundDefender, targetEntityID) then
              table.insert(monsterIDListAroundDefender, targetEntityID)
            end
          end
        end
      end
      if 0 < #monsterIDListAroundDefender then
        if selectCount == -1 or selectCount >= #monsterIDListAroundDefender then
          table.appendArray(targetIDArray, monsterIDListAroundDefender)
        else
          monsterIDListAroundDefender = randomService:Shuffle(monsterIDListAroundDefender)
          for monsterIndex, monsterID in ipairs(monsterIDListAroundDefender) do
            if selectCount >= monsterIndex then
              table.insert(targetIDArray, monsterID)
            else
              break
            end
          end
        end
      end
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectWorldBossMonster(casterEntity, skillScopeResult)
  local targetIDArray = {}
  local listTargetByRange = self:_SelectEntityByTypeAndRange(self._world.BW_WEMatchers.MonsterID, skillScopeResult:GetAttackRange())
  for key, value in ipairs(listTargetByRange) do
    local monsterEntity = value.m_entity
    local monsterIdCmpt = monsterEntity:MonsterID()
    if monsterIdCmpt then
      local isWorldBoss = monsterIdCmpt:IsWorldBoss()
      if isWorldBoss then
        local id = monsterEntity:GetID()
        table.insert(targetIDArray, id)
      end
    end
  end
  return targetIDArray
end

function SkillScopeTargetSelector:_SelectSingleGridMonsterLowestHPPercent(casterEntity, skillScopeResult)
  local listTargetByRange = self:_SelectEntityByTypeAndRange(self._world.BW_WEMatchers.MonsterID, skillScopeResult:GetAttackRange())
  local lowestHPPercent = 1
  local lowestHPEntity
  for key, value in ipairs(listTargetByRange) do
    local monsterEntity = value.m_entity
    if not monsterEntity:HasDeadMark() and monsterEntity:GetID() ~= casterEntity:GetID() then
      local bodyArea = monsterEntity:BodyArea():GetArea()
      if #bodyArea == 1 then
        local cAttribute = monsterEntity:Attributes()
        local maxHP = cAttribute:CalcMaxHp()
        local currentHP = cAttribute:GetCurrentHP()
        local percent = currentHP / maxHP
        if lowestHPPercent > percent then
          lowestHPPercent = percent
          lowestHPEntity = monsterEntity
        end
      end
    end
  end
  local ret = {}
  if lowestHPEntity then
    ret[1] = lowestHPEntity:GetID()
  end
  return ret
end

function SkillScopeTargetSelector:_SelectMonsterCamp(casterEntity, skillScopeResult, skillID, param)
  local listTargetByRange = self:_SelectEntityByTypeAndRange(self._world.BW_WEMatchers.MonsterID, skillScopeResult:GetAttackRange())
  local ret = {}
  for key, value in ipairs(listTargetByRange) do
    local monsterEntity = value.m_entity
    if not monsterEntity:HasDeadMark() then
      local monsterIDCmpt = monsterEntity:MonsterID()
      local campType = monsterIDCmpt:GetCampType()
      if table.icontains(param, campType) then
        table.insert(ret, monsterEntity:GetID())
      end
    end
  end
  return ret
end

function SkillScopeTargetSelector:_SelectPetIgnoreProtectedTrap(casterEntity, skillScopeResult, skillID, targetTypeParam)
  return self:_SelectPetOnly(casterEntity, skillScopeResult, skillID, targetTypeParam)
end

function SkillScopeTargetSelector:_SelectPickUpPetOrTrap(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
  local pickGridPos = activeSkillPickUpComponent:GetAllValidPickUpGridPos()
  local pickPetPstID = activeSkillPickUpComponent:GetPickUpPetPstID()
  local ret = {}
  local id
  if pickGridPos and #pickGridPos ~= 0 then
    local listTargetByRange = self:_SelectEntityByTypeAndRange(self._world.BW_WEMatchers.Trap, pickGridPos)
    for _, value in ipairs(listTargetByRange) do
      local entityTrap = value.m_entity
      local trapComponent = entityTrap:Trap()
      if table.icontains(targetTypeParam, trapComponent:GetTrapID()) then
        id = entityTrap:GetID()
        break
      end
    end
  else
    local utilDataSvc = self._world:GetService("UtilData")
    id = utilDataSvc:GetEntityIDByPstID(pickPetPstID)
  end
  table.insert(ret, id)
  return ret
end

function SkillScopeTargetSelector:_SelectFarestMonsterAndNoBuff(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local listTargetByRange = self:_SelectEntityByTypeAndRange(self._world.BW_WEMatchers.MonsterID, skillScopeResult:GetAttackRange())
  local ret = {}
  local disLen = 0
  local ownerPos = casterEntity:GetGridPosition()
  local selectMonster
  for key, value in ipairs(listTargetByRange) do
    local monsterEntity = value.m_entity
    if not monsterEntity:HasDeadMark() then
      local conform = false
      local buffCmpt = monsterEntity:BuffComponent()
      for _, buffEffectID in ipairs(targetTypeParam) do
        if not buffCmpt:HasBuffEffect(buffEffectID) then
          conform = true
        end
      end
      if conform then
        local monsterPos = monsterEntity:GetGridPosition()
        local distance = Vector2.Distance(monsterPos, ownerPos)
        if disLen < distance then
          disLen = distance
          selectMonster = monsterEntity
        end
      end
    end
  end
  if selectMonster then
    return {
      selectMonster:GetID()
    }
  else
    return {}
  end
end

function SkillScopeTargetSelector:_SelectMonsterWithTeamHPPercentDiffMax(casterEntity, skillScopeResult, skillID, targetTypeParam)
  local isNormalAttack = false
  if targetTypeParam and #targetTypeParam ~= 0 and targetTypeParam[1] == 1 then
    isNormalAttack = true
  end
  local listTargetByRange = self:_SelectEntityByTypeAndRange(self._world.BW_WEMatchers.MonsterID, skillScopeResult:GetAttackRange(), isNormalAttack)
  local hpPerDiffMax = -1
  local selectMonster
  local battleSvc = self._world:GetService("Battle")
  local casterHP, casterMaxHP = battleSvc:GetCasterHP(casterEntity)
  local casterHPPer = casterHP / casterMaxHP
  for key, value in ipairs(listTargetByRange) do
    local monsterEntity = value.m_entity
    local targetHP, targetMaxHP = battleSvc:GetCasterHP(monsterEntity)
    local hpPercent = targetHP / targetMaxHP
    if not monsterEntity:HasDeadMark() and 0 < targetHP then
      if monsterEntity:MonsterID():IsWorldBoss() then
        return {
          monsterEntity:GetID()
        }
      end
      local hpPerDiff = math.abs(hpPercent - casterHPPer)
      if hpPerDiffMax < hpPerDiff then
        hpPerDiffMax = hpPerDiff
        selectMonster = monsterEntity
      end
    end
  end
  if selectMonster then
    return {
      selectMonster:GetID()
    }
  else
    if 0 < #listTargetByRange then
      local entity = listTargetByRange[#listTargetByRange].m_entity
      return {
        entity:GetID()
      }
    end
    return {}
  end
end
