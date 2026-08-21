_class("ChainPathTargetSelector", Object)
ChainPathTargetSelector = ChainPathTargetSelector

function ChainPathTargetSelector:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._skillScopeTargetSelector = world:GetSkillScopeTargetSelector()
end

function ChainPathTargetSelector:DoSelectTeam(teamEntity, pieceType)
  self:_SelectRoundTeam(teamEntity, pieceType, SkillType.Normal)
end

function ChainPathTargetSelector:DoSelectTarget(teamEntity, pieceType)
  self:_SelectRoundTeam(teamEntity, pieceType, SkillType.Chain)
  local logicTeamCmpt = teamEntity:LogicRoundTeam()
  local petRoundTeam = logicTeamCmpt:GetPetRoundTeam()
  local utilData = self._world:GetService("UtilData")
  for _, petEntityID in ipairs(petRoundTeam) do
    local pet_entity = self._world:GetEntityByID(petEntityID)
    local petAttackDataCmpt = pet_entity:SkillPetAttackData()
    petAttackDataCmpt:ClearPetChainAttackData()
    local chainTimes = utilData:OnGetPetChainTimes(pet_entity)
    for chainTimeIndex = 1, chainTimes do
      local chainSkillStageInfoList = utilData:OnGetPetChainSkillConfigIDList(pet_entity, chainTimeIndex)
      local curChainTimeSkillStageCount = table.count(chainSkillStageInfoList)
      for index = 1, curChainTimeSkillStageCount do
        self:_CalcChainSkillAttackTarget(teamEntity, petEntityID, chainTimeIndex, index)
      end
    end
  end
end

function ChainPathTargetSelector:DoSelectNormalAttackTarget(teamEntity)
  local logicTeamCmpt = teamEntity:LogicRoundTeam()
  local petRoundTeam = logicTeamCmpt:GetPetRoundTeam()
  local utilData = self._world:GetService("UtilData")
  for _, petEntityID in ipairs(petRoundTeam) do
    local petCanNormalAttack = utilData:OnCheckPetCanCastNormalSkill(petEntityID)
    if petCanNormalAttack then
      self:_CalcPathNormalAttackTarget(teamEntity, petEntityID)
    end
  end
end

function ChainPathTargetSelector:_SelectRoundTeam(teamEntity, pieceType, skillType)
  local logicTeamCmpt = teamEntity:LogicRoundTeam()
  logicTeamCmpt:ClearLogicRoundTeam()
  local teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
  local battleStatCmpt = self._world:BattleStat()
  if battleStatCmpt:IsActiveSkillLinkLine() then
    teamLeaderEntityID = battleStatCmpt:GetActiveSkillLinkLineCasterEntityID()
  end
  local teamLeaderEntity = self._world:GetEntityByID(teamLeaderEntityID)
  logicTeamCmpt:AddPetToRoundTeam(teamLeaderEntityID)
  local skillEffectResultContainer = teamLeaderEntity:SkillContext():GetResultContainer()
  skillEffectResultContainer:SetFinalAttack(false)
  skillEffectResultContainer:SetNormalAttack(false)
  local playerElementCmpt = teamLeaderEntity:Element()
  local affixSvc = self._world:GetService("Affix")
  if affixSvc:IsTeamLeaderUseSecondaryType(teamEntity, pieceType) then
    self:SelectPetPrimarySecondaryParam(teamLeaderEntity, pieceType, PrimarySecondaryParamType.Pet)
    playerElementCmpt:SetUseSecondaryType(true)
  else
    self:SelectPetPrimarySecondaryParam(teamLeaderEntity, pieceType, PrimarySecondaryParamType.TeamLeader)
    playerElementCmpt:SetUseSecondaryType(false)
  end
  local firstElementType = self:_CalcFirstElementTypeForTwoColorChain(teamEntity, pieceType)
  if not battleStatCmpt:IsActiveSkillLinkLine() then
    local teamOrder = teamEntity:Team():GetTeamOrder()
    for i = 2, #teamOrder do
      local petPstID = teamOrder[i]
      local entityID = self:_CheckPetBattle(petPstID, pieceType, teamEntity)
      if entityID ~= nil then
        logicTeamCmpt:AddPetToRoundTeam(entityID)
      else
        local forceChainEntityID = self:_CheckPetBattleForceChain(petPstID, pieceType, teamEntity, skillType)
        if forceChainEntityID ~= nil then
          logicTeamCmpt:AddPetToRoundTeam(forceChainEntityID)
        end
        if firstElementType ~= PieceType.None then
          local firstElementEntityID = self:_CheckPetBattle(petPstID, firstElementType, teamEntity)
          if firstElementEntityID ~= nil then
            logicTeamCmpt:AddPetToRoundTeam(firstElementEntityID)
          end
        end
      end
    end
  end
  local changeOrderList = {}
  local orderBuffKey = "PetRoundTeamOrder_" .. skillType
  local normalOrder = 100
  local hasChangrOrder = false
  local petRoundTeam = teamEntity:LogicRoundTeam():GetPetRoundTeam()
  local sortedArray = SortedArray:New(Algorithm.COMPARE_LESS, nil)
  for petIndex = 1, #petRoundTeam do
    local petEntityID = petRoundTeam[petIndex]
    local petEntity = self._world:GetEntityByID(petEntityID)
    local buffCmpt = petEntity:BuffComponent()
    local orderBuffValue = buffCmpt:GetBuffValue(orderBuffKey)
    if orderBuffValue then
      changeOrderList[orderBuffValue] = petEntityID
      hasChangrOrder = true
      sortedArray:Insert(orderBuffValue)
    else
      changeOrderList[normalOrder] = petEntityID
      sortedArray:Insert(normalOrder)
      normalOrder = normalOrder + 1
    end
  end
  if battleStatCmpt:IsActiveSkillLinkLine() then
    hasChangrOrder = true
  end
  if hasChangrOrder then
    logicTeamCmpt:ClearLogicRoundTeam()
    teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
    teamEntity:Team():SetOriginalTeamLeaderID(teamLeaderEntityID)
    local setTeamLeader = false
    for i = 1, sortedArray:Size() do
      local keySort = sortedArray:GetAt(i)
      local petEntityID = changeOrderList[keySort]
      if not setTeamLeader then
        setTeamLeader = true
        local petEntity = self._world:GetEntityByID(petEntityID)
        teamEntity:SetTeamLeaderPetEntity(petEntity)
      end
      logicTeamCmpt:AddPetToRoundTeam(petEntityID)
    end
  end
end

function ChainPathTargetSelector:_CalcFirstElementTypeForTwoColorChain(teamEntity, cmdElementType)
  local firstElementType = PieceType.None
  local isTwoColorChain = self:IsTwoColorChain(teamEntity)
  if not isTwoColorChain then
    return firstElementType
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainPathData = logicChainPathCmpt:GetLogicChainPath()
  for chainIndex, v in ipairs(chainPathData) do
    local curPieceType = boardCmpt:GetPieceType(v)
    if chainIndex == 2 then
      local firstLinkMapPiece = utilDataSvc:GetMapForFirstChainPath()
      if firstLinkMapPiece then
        curPieceType = firstLinkMapPiece
      end
    end
    if curPieceType ~= PieceType.None and curPieceType ~= PieceType.Any and curPieceType ~= cmdElementType then
      firstElementType = curPieceType
      break
    end
  end
  return firstElementType
end

function ChainPathTargetSelector:IsTwoColorChain(teamEntity)
  local utilDataSvc = self._world:GetService("UtilData")
  local useTwoColorChain = utilDataSvc:GetEntityBuffValue(teamEntity, "TwoColorChain")
  return useTwoColorChain
end

function ChainPathTargetSelector:_CheckPetBattleForceChain(petPstID, pieceType, teamEntity, skillType)
  if skillType == SkillType.Normal then
    return
  end
  local e = teamEntity:Team():GetPetEntityByPetPstID(petPstID)
  if not e:HasPetDeadMark() and not e:HasBuffFlag(BuffFlags.SealedCurse) and not e:HasBuffFlag(BuffFlags.Pet1702361NotLinkLine) then
    local buffComponent = e:BuffComponent()
    local petForceChain = buffComponent:GetBuffValue("PetForceChain") == 1
    if petForceChain then
      local elementCmpt = e:Element()
      elementCmpt:SetUseSecondaryType(false)
      e:Attributes():Modify("PrimarySecondaryParam", BattleConst.PrimarySecondaryDefaultParam)
      local skillEffectResultContainer = e:SkillContext():GetResultContainer()
      skillEffectResultContainer:SetFinalAttack(false)
      skillEffectResultContainer:SetNormalAttack(false)
      return e:GetID()
    end
  end
  return nil
end

function ChainPathTargetSelector:_IsMatchPieceType(petEntityID, pieceType)
  local fettersSvc = self._world:GetService("Fetters")
  if not fettersSvc then
    local petEntity = self._world:GetEntityByID(petEntityID)
    local elementCmpt = petEntity:Element()
    local primaryType = elementCmpt:GetPrimaryType()
    return CanMatchPieceType(primaryType, pieceType)
  end
  return fettersSvc:IsMatchPieceType(petEntityID, pieceType, true)
end

function ChainPathTargetSelector:_CheckPetBattle(petPstID, pieceType, teamEntity)
  local e = teamEntity:Team():GetPetEntityByPetPstID(petPstID)
  if not e:HasPetDeadMark() and not e:HasBuffFlag(BuffFlags.SealedCurse) and not e:HasBuffFlag(BuffFlags.Pet1702361NotLinkLine) then
    local elementCmpt = e:Element()
    local primaryType = elementCmpt:GetPrimaryType()
    local sencondardType = elementCmpt:GetSecondaryType()
    local primaryMatch = self:_IsMatchPieceType(e:GetID(), pieceType)
    local secondaryMatch = CanMatchPieceType(sencondardType, pieceType)
    local buffComponent = e:BuffComponent()
    local petForceChain = buffComponent:GetBuffValue("PetForceChain") == 1
    local forceMatch = buffComponent:GetBuffValue("PetForceMatch")
    if forceMatch then
      primaryMatch = true
    end
    if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
      primaryMatch, secondaryMatch = self:_CalcPieceMatchForNoElementCostStep(teamEntity, e, pieceType)
    end
    if primaryMatch or secondaryMatch then
      if petForceChain or forceMatch then
        elementCmpt:SetUseSecondaryType(false)
      elseif primaryMatch == true then
        elementCmpt:SetUseSecondaryType(false)
      elseif secondaryMatch == true then
        elementCmpt:SetUseSecondaryType(true)
      end
      self:SelectPetPrimarySecondaryParam(e, pieceType, PrimarySecondaryParamType.Pet, petForceChain)
      local skillEffectResultContainer = e:SkillContext():GetResultContainer()
      skillEffectResultContainer:SetFinalAttack(false)
      skillEffectResultContainer:SetNormalAttack(false)
      return e:GetID()
    end
  end
  return nil
end

function ChainPathTargetSelector:_CalcPieceMatchForNoElementCostStep(teamEntity, petEntity, pieceType)
  local primaryMatch = true
  local secondaryMatch = false
  if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    local elementCmpt = petEntity:Element()
    local primaryType = elementCmpt:GetPrimaryType()
    local sencondardType = elementCmpt:GetSecondaryType()
    local teamBuffCmpt = teamEntity:BuffComponent()
    if teamBuffCmpt then
      local onlyTeamLeaderColorPet = teamBuffCmpt:GetBuffValue("OnlyTeamLeaderColorPet")
      if onlyTeamLeaderColorPet and onlyTeamLeaderColorPet == 1 then
        local teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
        local teamLeaderEntity = self._world:GetEntityByID(teamLeaderEntityID)
        if teamLeaderEntity then
          local teamLeaderElementCmpt = teamLeaderEntity:Element()
          if teamLeaderElementCmpt then
            local teamLeaderPrimaryType = teamLeaderElementCmpt:GetPrimaryType()
            primaryMatch = self:_IsMatchPieceType(petEntity:GetID(), teamLeaderPrimaryType)
            if primaryMatch then
              secondaryMatch = CanMatchPieceType(sencondardType, teamLeaderPrimaryType)
            else
              secondaryMatch = false
            end
          end
        end
      else
        primaryMatch = true
        secondaryMatch = false
      end
    end
  end
  return primaryMatch, secondaryMatch
end

function ChainPathTargetSelector:_CalcPathNormalAttackTarget(teamEntity, petEntityID)
  local petEntity = self._world:GetEntityByID(petEntityID)
  local petAttackDataCmpt = petEntity:SkillPetAttackData()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainPathData = logicChainPathCmpt:GetLogicChainPath()
  local chainPathType = logicChainPathCmpt:GetLogicPieceType()
  local posActor = teamEntity:GetGridPosition()
  for chainPathIndex, piecePosition in ipairs(chainPathData) do
    local hasAttackData = petAttackDataCmpt:HasNormalAttackData(piecePosition)
    if not hasAttackData then
      local pathPointNormalAttackData = SkillPathPointNormalAttackData:New(self._world)
      petAttackDataCmpt:AddNormalAttackData(piecePosition, pathPointNormalAttackData)
      self:_CalcPathPointNormalAttackTarget(teamEntity, petEntityID, piecePosition, pathPointNormalAttackData, chainPathType, chainPathData, chainPathIndex)
    end
  end
  petAttackDataCmpt:RemoveUnusedPathPointData(chainPathData)
end

function ChainPathTargetSelector:_CalcPathPointNormalAttackTarget(teamEntity, petEntityID, casterPos, pathPointNormalAttackData, chainPathType, chainPath, chainPathIndex)
  local teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
  if petEntityID == teamLeaderEntityID then
    local affixSvc = self._world:GetService("Affix")
    if not affixSvc:IsTeamLeaderCanAttack(teamEntity, chainPathType) then
      return
    end
  end
  local utilData = self._world:GetService("UtilData")
  if utilData:IsPosBlock(casterPos, BlockFlag.LinkLine) then
    return
  end
  local pet_entity = self._world:GetEntityByID(petEntityID)
  local skill_info_cmpt = pet_entity:SkillInfo()
  local normal_skill_id = skill_info_cmpt:GetNormalSkillID()
  local canRepeatAdd = false
  local petBuffCmpt = pet_entity:BuffComponent()
  local calcChainPathRightAngle = petBuffCmpt:GetBuffValue("ChangeNormalSkillIDWithChainPathRightAngle")
  if calcChainPathRightAngle then
    normal_skill_id = calcChainPathRightAngle[1]
    canRepeatAdd = true
    if 1 < chainPathIndex and chainPathIndex < table.count(chainPath) then
      local lastPos = chainPath[chainPathIndex - 1]
      local lastDir = casterPos - lastPos
      local nextPos = chainPath[chainPathIndex + 1]
      local curDir = nextPos - casterPos
      local diffAngle = Vector2.Angle(lastDir, curDir)
      diffAngle = math.floor(diffAngle + 0.5)
      if 90 <= diffAngle then
        normal_skill_id = calcChainPathRightAngle[2]
      end
    end
  end
  local posAurasValue = petBuffCmpt:GetBuffValue("ChangeNormalSkillIDWithPosAndAuras")
  if posAurasValue then
    local tmpSkillID = posAurasValue[1]
    local auraGroupID = posAurasValue[2]
    local curPos = chainPath[chainPathIndex]
    local battleSvc = self._world:GetService("Battle")
    if battleSvc:IsPosInAuraRange(auraGroupID, curPos) then
      normal_skill_id = tmpSkillID
    end
  end
  local calcBuffLayerAndTrap = petBuffCmpt:GetBuffValue("ChangeNormalSkillWithBuffLayerAndTrap")
  if calcBuffLayerAndTrap then
    local curLayerCount = calcBuffLayerAndTrap.curLayerCount
    local trapIDs = calcBuffLayerAndTrap.trapIDs
    local addLayer = calcBuffLayerAndTrap.addLayer
    local udsvc = self._world:GetService("UtilData")
    local findTrap = false
    local traps = udsvc:GetTrapsAtPos(casterPos)
    if traps then
      for index, e in ipairs(traps) do
        if table.intable(trapIDs, e:Trap():GetTrapID()) then
          findTrap = true
          break
        end
      end
    end
    if findTrap then
      curLayerCount = curLayerCount + addLayer
      if curLayerCount < 0 then
        curLayerCount = 0
      end
      calcBuffLayerAndTrap.curLayerCount = curLayerCount
    end
    local skillList = calcBuffLayerAndTrap.skillList
    for k, v in pairs(skillList) do
      if k >= curLayerCount then
        normal_skill_id = v
        break
      end
    end
    petBuffCmpt:SetBuffValue("ChangeNormalSkillWithBuffLayerAndTrap", calcBuffLayerAndTrap)
  end
  local configService = self._configService
  local skillConfigData = configService:GetSkillConfigData(normal_skill_id)
  local skillTargetType = skillConfigData:GetSkillTargetType()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, casterPos, pet_entity)
  local skill_range_grid_list = scopeResult:GetAttackRange()
  skill_range_grid_list = HelperProxy:SortPosByCenterArrow(casterPos, skill_range_grid_list)
  local targetEntities
  if self._world:MatchType() == MatchType.MT_BlackFist then
    targetEntities = {
      self._world:Player():GetCurrentEnemyTeamEntity()
    }
  else
    local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    targetEntities = monster_group:GetEntities()
  end
  if pet_entity:BuffComponent():GetBuffValue("ForcePetNormalAttackAfterMove") then
    for i = 2, #chainPath do
      local v2 = chainPath[i]
      pathPointNormalAttackData:AddAttackGridDataOnlyCheckPos(v2, petEntityID, normal_skill_id, petEntityID, casterPos)
    end
  else
    for _, e in ipairs(targetEntities) do
      if self._skillScopeTargetSelector:SelectConditionFilter(e, true) then
        local monster_grid_location_cmpt = e:GridLocation()
        local monster_body_area_cmpt = e:BodyArea()
        local monster_body_area = monster_body_area_cmpt:GetArea()
        if canRepeatAdd then
          for i, bodyArea in ipairs(monster_body_area) do
            local curMonsterBodyPos = monster_grid_location_cmpt.Position + bodyArea
            if table.icontains(skill_range_grid_list, curMonsterBodyPos) then
              pathPointNormalAttackData:AddAttackGridDataOnlyCheckPos(curMonsterBodyPos, e:GetID(), normal_skill_id, petEntityID, casterPos)
            end
          end
        else
          local attackPosCandidate = {}
          for i, bodyArea in ipairs(monster_body_area) do
            local curMonsterBodyPos = monster_grid_location_cmpt.Position + bodyArea
            if table.icontains(skill_range_grid_list, curMonsterBodyPos) then
              table.insert(attackPosCandidate, {
                index = table.ikey(skill_range_grid_list, curMonsterBodyPos),
                pos = curMonsterBodyPos,
                sortIndex = #attackPosCandidate
              })
            end
          end
          if 0 < #attackPosCandidate then
            table.sort(attackPosCandidate, function(a, b)
              if a.index ~= b.index then
                return a.index < b.index
              else
                return a.sortIndex < b.sortIndex
              end
            end)
            local finalAttackPos = attackPosCandidate[1].pos
            pathPointNormalAttackData:AddAttackGridData(finalAttackPos, e:GetID(), normal_skill_id, petEntityID, casterPos)
            local canNormalAttackSeparateDouble, replaceSkillID = self:_OnCheckNormalAttackSeparateDouble(pet_entity, e:GetID())
            if canNormalAttackSeparateDouble then
              if replaceSkillID == nil then
                replaceSkillID = normal_skill_id
              end
              pathPointNormalAttackData:AddAttackGridDataAdditional(finalAttackPos, e:GetID(), replaceSkillID, petEntityID, casterPos)
            end
          end
        end
      end
    end
  end
end

function ChainPathTargetSelector:_CalcChainSkillAttackTarget(teamEntity, petEntityID, chainTimeIndex, index)
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chain_path_data = logicChainPathCmpt:GetLogicChainPath()
  local chain_path_count = #chain_path_data
  local chain_rate = logicChainPathCmpt:GetChainRateAtIndex(chain_path_count)
  local pet_entity = self._world:GetEntityByID(petEntityID)
  local petSkillRoutine = pet_entity:SkillContext():GetResultContainer()
  local utilData = self._world:GetService("UtilData")
  local chain_skill_config_id = utilData:OnGetCurChainSkillID(pet_entity, chainTimeIndex, index)
  if chain_skill_config_id <= 0 then
    return
  end
  local petAttackDataCmpt = pet_entity:SkillPetAttackData()
  petAttackDataCmpt:SetChainSkillID(chain_skill_config_id)
  petSkillRoutine:SetSkillID(chain_skill_config_id)
  local configService = self._configService
  local skillConfigData = configService:GetSkillConfigData(chain_skill_config_id)
  local skillTargetType = skillConfigData:GetSkillTargetType()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local caster_pos = chain_path_data[chain_path_count]
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  local buffService = self._world:GetService("BuffLogic")
  if buffService:IsChainSkillUseChainScope(pet_entity) and not self._world:BattleStat():IsCastChainByDimensionDoor() then
    local chainPathPieceType = logicChainPathCmpt:GetLogicPieceType()
    boardCmpt:AddTmpPieceType(chain_path_data[1], PieceType.None)
    for i = 2, #chain_path_data do
      local pos = chain_path_data[i]
      boardCmpt:AddTmpPieceType(pos, chainPathPieceType)
    end
  end
  local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, caster_pos, pet_entity)
  local attack_range = scopeResult:GetAttackRange()
  local whole_range = scopeResult:GetWholeGridRange()
  boardCmpt:ClearTmpPieceType()
  local petBuffCmpt = pet_entity:BuffComponent()
  petAttackDataCmpt:SetCastChainSkill(false)
  petAttackDataCmpt:AddMultiStageChainAttackData(chainTimeIndex, index, chain_skill_config_id)
  local chainAttackData = petAttackDataCmpt:GetMultiStageChainAttackData(chainTimeIndex, index)
  chainAttackData:SetSkillID(chain_skill_config_id)
  chainAttackData:SetScopeResult(scopeResult)
  self:_SelectScopeResultTarget(pet_entity, skillTargetType, scopeResult, chain_skill_config_id, attack_range)
end

function ChainPathTargetSelector:_SelectScopeResultTarget(petEntity, targetType, scopeResult, skillID, attackRange)
  local targetEntityIDArray = self._skillScopeTargetSelector:DoSelectSkillTarget(petEntity, targetType, scopeResult, skillID)
  for _, gridPos in ipairs(attackRange) do
    for _, targetEntityID in ipairs(targetEntityIDArray) do
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      local gridLocationCmpt = targetEntity:GridLocation()
      local bodyAreaCmpt = targetEntity:BodyArea()
      local bodyAreaList = bodyAreaCmpt:GetArea()
      for i, bodyArea in ipairs(bodyAreaList) do
        local curBodyPos = Vector2(gridLocationCmpt.Position.x + bodyArea.x, gridLocationCmpt.Position.y + bodyArea.y)
        if curBodyPos == gridPos then
          scopeResult:AddTargetIDAndPos(targetEntityID, gridPos)
        end
      end
    end
  end
end

function ChainPathTargetSelector:SelectPetPrimarySecondaryParam(petEntity, pieceType, type, petForceChain)
  local primarySecondaryParam = BattleConst.PrimarySecondaryDefaultParam
  if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    petEntity:Attributes():Modify("PrimarySecondaryParam", primarySecondaryParam)
    return
  end
  local battleStatCmpt = self._world:BattleStat()
  if battleStatCmpt:IsActiveSkillLinkLine() then
    petEntity:Attributes():Modify("PrimarySecondaryParam", primarySecondaryParam)
    return
  end
  local elementCmpt = petEntity:Element()
  local sencondardType = elementCmpt:GetSecondaryType()
  local primaryMatch = self:_IsMatchPieceType(petEntity:GetID(), pieceType)
  local secondaryMatch = CanMatchPieceType(sencondardType, pieceType)
  local buffComponent = petEntity:BuffComponent()
  local forceMatch = buffComponent:GetBuffValue("PetForceMatch")
  if forceMatch then
    primaryMatch = true
  end
  if type == PrimarySecondaryParamType.TeamLeader then
    if primaryMatch and not secondaryMatch then
      primarySecondaryParam = BattleConst.LeaderPrimaryParam
    elseif not primaryMatch and secondaryMatch then
      primarySecondaryParam = BattleConst.LeaderSecondaryParam
    elseif primaryMatch and secondaryMatch then
      local petAttriCmpt = petEntity:Attributes()
      primarySecondaryParam = petAttriCmpt:GetAttribute("AllAttackParam")
    elseif not primaryMatch and not secondaryMatch then
      primarySecondaryParam = BattleConst.LeaderNullParam
    end
  elseif type == PrimarySecondaryParamType.Pet then
    if primaryMatch and not secondaryMatch then
      primarySecondaryParam = BattleConst.PetPrimaryParam
    elseif petForceChain then
      primarySecondaryParam = BattleConst.PrimarySecondaryDefaultParam
    elseif not primaryMatch and secondaryMatch then
      local petAttriCmpt = petEntity:Attributes()
      primarySecondaryParam = petAttriCmpt:GetAttribute("SecondaryAttackParam")
    elseif primaryMatch and secondaryMatch then
      local petAttriCmpt = petEntity:Attributes()
      primarySecondaryParam = petAttriCmpt:GetAttribute("AllAttackParam")
    end
  end
  petEntity:Attributes():Modify("PrimarySecondaryParam", primarySecondaryParam)
end

function ChainPathTargetSelector:_OnCheckNormalAttackSeparateDouble(casterEntity, targetEntityID)
  local buffComponent = casterEntity:BuffComponent()
  local separateDoubleCountKey = "NormalAttackSeparateDoubleCount"
  local separateDoubleCountCount = buffComponent:GetBuffValue(separateDoubleCountKey)
  if not separateDoubleCountCount or separateDoubleCountCount <= 0 then
    return false
  end
  local levelRound = self._world:BattleStat():GetLevelTotalRoundCount()
  local calcTargetIDList = buffComponent:GetBuffValue("NormalAttackSeparateDoubleCalcTargetIDList") or {}
  if not calcTargetIDList[levelRound] then
    calcTargetIDList[levelRound] = {}
  end
  local curRoundData = calcTargetIDList[levelRound]
  if not curRoundData[casterEntity:GetID()] then
    curRoundData[casterEntity:GetID()] = {}
  end
  local curPetData = curRoundData[casterEntity:GetID()]
  if table.icontains(curPetData, targetEntityID) then
    return false
  end
  table.insert(curPetData, targetEntityID)
  buffComponent:SetBuffValue("NormalAttackSeparateDoubleCalcTargetIDList", calcTargetIDList)
  local newCount = separateDoubleCountCount - 1
  buffComponent:SetBuffValue(separateDoubleCountKey, newCount)
  local separateDoubleSkillID = buffComponent:GetBuffValue("NormalAttackSeparateDoubleSkillID")
  if separateDoubleSkillID then
    return true, separateDoubleSkillID
  end
  return true, nil
end
