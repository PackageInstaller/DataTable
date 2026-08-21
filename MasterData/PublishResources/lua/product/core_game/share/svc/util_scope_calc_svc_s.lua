require("switch_body_area_dir_type")
_class("UtilScopeCalcServiceShare", Object)
UtilScopeCalcServiceShare = UtilScopeCalcServiceShare

function UtilScopeCalcServiceShare:Constructor(world)
  self._world = world
  self._skillScopeCalc = SkillScopeCalculator:New(self)
  self._gridFilter = SkillScopeDefaultFilter:New()
  self._chainPathTargetSelector = ChainPathTargetSelector:New(self._world)
  self._skillScopeTargetSelector = self._world:GetSkillScopeTargetSelector()
  self._skillEffectTargetSorter = SkillEffectTargetSorter:New(self._world)
end

function UtilScopeCalcServiceShare:SortHitbackTargetByDirType(enemyIDList, hitbackDirType, casterPos)
  self._skillEffectTargetSorter:_SortHitbackTargetByDirType(enemyIDList, hitbackDirType, casterPos)
end

function UtilScopeCalcServiceShare:_GetRandomNumber(m, n)
  local randomService = self._world:GetService("RandomLogic")
  return randomService:LogicRand(m, n)
end

function UtilScopeCalcServiceShare:CalcCenterPosAndBodyArea(centerType, casterPos, PlayerBodyArea, scopeParam, casterEntity)
  local centerPos = casterPos
  local bodyArea = PlayerBodyArea
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if not centerType or centerType == SkillScopeCenterType.CasterPos then
  elseif centerType == SkillScopeCenterType.Component then
    centerPos = self:GetComponentCenterPos()
  elseif centerType == SkillScopeCenterType.PickUpGridPos then
    local retPos = self:GetPickUpGridPosCenterPos()
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.PickUpMultiGridPos then
    local retPos = self:GetPickUpMultiGridPosCenterPos()
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.SelectNeareat2Pet then
    centerPos = self:_SelectNeareat2Pet(casterPos, scopeParam, teamEntity)
  elseif centerType == SkillScopeCenterType.ChainSkillPickUpGridPos then
    local logicPickUpCmpt = teamEntity:LogicPickUp()
    centerPos = logicPickUpCmpt:GetLogicCurPickUpGridSafePos()
  elseif centerType == SkillScopeCenterType.FirstPickUpGridPos then
    local retPos = self:GetFirstPickUpGridPosCenterPos()
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.CastBombPos then
    centerPos = self:_CalcBombPos(teamEntity, casterPos, scopeParam)
  elseif centerType == SkillScopeCenterType.RoundBeginPlayerPos then
    centerPos = self._world:BattleStat():GetRoundBeginPlayerPos()
  elseif centerType == SkillScopeCenterType.PlayerPos then
    local playerPos = teamEntity:GetGridPosition()
    centerPos = playerPos
  elseif centerType == SkillScopeCenterType.NearestPetChessPos then
    centerPos = self:GetNearestPetChessPosCenterPos(casterPos)
  elseif centerType == SkillScopeCenterType.NearestPosToCasterInPickMonster then
    local retPos = self:GetNearestPosToCasterInPickMonster()
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.PickUpMonsterPos then
    local retPos = self:GetPickUpMonsterPosCenterPos()
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.PickUpMonsterPosAndCasterPos then
    local retPos = self:GetPickUpMonsterPosAndCasterPosCenterPos()
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.MonsterBodyAreaIndex then
    centerPos = bodyArea[2] + casterPos
  elseif centerType == SkillScopeCenterType.NearestMonsterGrid then
    local retPos = self:GetNearestMonsterGridCenterPos(casterPos)
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.NearestMonsterGridForChainSubScope then
    if casterEntity then
      local petBuffCmpt = casterEntity:BuffComponent()
      if petBuffCmpt then
        local replaceChainEntityID = petBuffCmpt:GetBuffValue("ReplaceEntityID")
        local replaceChainEntity = self._world:GetEntityByID(replaceChainEntityID)
        if replaceChainEntity and not replaceChainEntity:HasDeadMark() then
          casterPos = replaceChainEntity:GridLocation().Position
        end
      end
    end
    local retPos = self:GetNearestMonsterGridCenterPos(casterPos)
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.PlayerPosAndFarthestMonsterGridPos then
    local retPosArray = self:GetPlayerPosAndFarthestMonsterGridPos()
    if retPosArray then
      centerPos = retPosArray
    end
  elseif centerType == SkillScopeCenterType.FarthestMonsterGridPos then
    local retPos = self:GetFarthestMonsterGridPos(casterPos)
    if retPos then
      centerPos = retPos
    end
  end
  return centerPos, bodyArea
end

function UtilScopeCalcServiceShare:GetFirstPickUpGridPosCenterPos()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicPickUpCmpt = teamEntity:LogicPickUp()
  local petPstID = logicPickUpCmpt:GetLogicPetPstid()
  local entityID = logicPickUpCmpt:GetEntityID()
  if entityID == -1 then
    local utilDataSvc = self._world:GetService("UtilData")
    entityID = utilDataSvc:GetEntityIDByPstID(petPstID)
  else
  end
  local casterEntity = self._world:GetEntityByID(entityID)
  if casterEntity then
    local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
    if activeSkillPickUpComponent then
      local centerPos = activeSkillPickUpComponent:GetFirstValidPickUpGridPos()
      return centerPos
    end
  end
end

function UtilScopeCalcServiceShare:GetPickUpMultiGridPosCenterPos()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicPickUpCmpt = teamEntity:LogicPickUp()
  local petPstID = logicPickUpCmpt:GetLogicPetPstid()
  local entityID = logicPickUpCmpt:GetEntityID()
  if entityID == -1 then
    local utilDataSvc = self._world:GetService("UtilData")
    entityID = utilDataSvc:GetEntityIDByPstID(petPstID)
  else
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  local casterEntity = self._world:GetEntityByID(entityID)
  if casterEntity then
    local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
    if activeSkillPickUpComponent then
      local centerPos = activeSkillPickUpComponent:GetAllValidPickUpGridPos()
      return centerPos
    end
  end
end

function UtilScopeCalcServiceShare:GetPickUpGridPosCenterPos()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicPickUpCmpt = teamEntity:LogicPickUp()
  local petPstID = logicPickUpCmpt:GetLogicPetPstid()
  local entityID = logicPickUpCmpt:GetEntityID()
  if entityID == -1 then
    local utilDataSvc = self._world:GetService("UtilData")
    entityID = utilDataSvc:GetEntityIDByPstID(petPstID)
  else
  end
  local casterEntity = self._world:GetEntityByID(entityID)
  if casterEntity then
    local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
    if activeSkillPickUpComponent then
      local centerPos = activeSkillPickUpComponent:GetLastPickUpGridPos()
      return centerPos
    end
  end
end

function UtilScopeCalcServiceShare:GetComponentCenterPos()
  local posList = {}
  local g = self._world:GetGroup(self._world.BW_WEMatchers.ScopeCenter)
  for _, e in ipairs(g:GetEntities()) do
    if not e:HasDeadMark() then
      local area = e:BodyArea():GetArea()
      for _, posArea in ipairs(area) do
        local pos = e:GridLocation():GetGridPos() + posArea
        table.insert(posList, pos)
      end
    end
  end
  return posList
end

function UtilScopeCalcServiceShare:GetNearestPetChessPosCenterPos(casterPos)
  local petEntityIDList = self:GetSortChessPetByMonsterPos(casterPos)
  local entity = self._world:GetEntityByID(petEntityIDList[1])
  local pos = entity:GetGridPosition()
  return pos
end

function UtilScopeCalcServiceShare:CalcPreviewCenterPosAndBodyArea(centerType, casterPos, PlayerBodyArea, scopeParam, casterEntity)
  local centerPos = casterPos
  local bodyArea = PlayerBodyArea
  if not centerType or centerType == SkillScopeCenterType.CasterPos then
  elseif centerType == SkillScopeCenterType.Component then
    local posList = {}
    local g = self._world:GetGroup(self._world.BW_WEMatchers.ScopeCenter)
    for _, e in ipairs(g:GetEntities()) do
      if not e:HasDeadMark() then
        local area = e:BodyArea():GetArea()
        for _, posArea in ipairs(area) do
          local pos = e:GridLocation():GetGridPos() + posArea
          table.insert(posList, pos)
        end
      end
    end
    centerPos = posList
  elseif centerType == SkillScopeCenterType.PickUpGridPos then
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    if previewPickUpComponent then
      centerPos = previewPickUpComponent:GetLastPickUpGridPos()
    end
  elseif centerType == SkillScopeCenterType.PickUpMultiGridPos then
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    if previewPickUpComponent then
      centerPos = previewPickUpComponent:GetAllValidPickUpGridPos()
    end
  elseif centerType == SkillScopeCenterType.SelectNeareat2Pet then
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    centerPos = self:_SelectNeareat2Pet(casterPos, scopeParam, teamEntity)
  elseif centerType == SkillScopeCenterType.ChainSkillPickUpGridPos then
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
    centerPos = pickUpTargetCmpt:GetCurPickUpGridSafePos()
  elseif centerType == SkillScopeCenterType.CastBombPos then
    centerPos = self:_PreviewCalcBombPos(casterPos, scopeParam)
  elseif centerType == SkillScopeCenterType.FirstPickUpGridPos then
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    if previewPickUpComponent then
      centerPos = previewPickUpComponent:GetFirstValidPickUpGridPos()
    end
  elseif centerType == SkillScopeCenterType.NearestPetChessPos then
    centerPos = self:GetNearestPetChessPosCenterPos(centerPos)
  elseif centerType == SkillScopeCenterType.NearestPosToCasterInPickMonster then
    local retPos = self:PreviewGetNearestPosToCasterInPickMonster(casterEntity)
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.PickUpMonsterPos then
    local retPos = self:PreviewGetPickUpMonsterPosCenterPos(casterEntity)
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.PickUpMonsterPosAndCasterPos then
    local retPos = self:PreviewGetPickUpMonsterPosAndCasterPosCenterPos(casterEntity)
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.MonsterBodyAreaIndex then
    centerPos = bodyArea[2] + casterPos
  elseif centerType == SkillScopeCenterType.NearestMonsterGrid then
    local retPos = self:PreviewGetNearestMonsterGridCenterPos(casterEntity)
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.NearestMonsterGridForChainSubScope then
    local retPos = self:PreviewGetNearestMonsterGridCenterPos(casterEntity)
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.PlayerPosAndFarthestMonsterGridPos then
    local retPos = self:GetPlayerPosAndFarthestMonsterGridPos()
    if retPos then
      centerPos = retPos
    end
  elseif centerType == SkillScopeCenterType.FarthestMonsterGridPos then
    local retPos = self:PreviewGetFarthestMonsterGridCenterPos(casterEntity)
    if retPos then
      centerPos = retPos
    end
  end
  return centerPos, bodyArea
end

function UtilScopeCalcServiceShare:AutoFightCalcBombPos(casterPos, pickUpGridPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local dir = pickUpGridPos - casterPos
  if dir.x > 0 then
    dir.x = 1
  end
  if dir.x < 0 then
    dir.x = -1
  end
  if 0 < dir.y then
    dir.y = 1
  end
  if 0 > dir.y then
    dir.y = -1
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local maxX = boardServiceLogic:GetCurBoardMaxX()
  local maxY = boardServiceLogic:GetCurBoardMaxY()
  local max = math.max(maxX, maxY)
  local centerPos = casterPos
  for i = 1, max do
    local pos = casterPos + dir * i
    if not self:IsValidPiecePos(pos) then
      centerPos = pos - dir
      break
    end
    if utilDataSvc:IsPosBlock(pos, BlockFlag.LinkLine) or utilDataSvc:GetPieceType(pos) == PieceType.None then
      centerPos = pos
      break
    end
  end
  return centerPos
end

function UtilScopeCalcServiceShare:_PreviewCalcBombPos(casterPos, scopeParam)
  local utilDataSvc = self._world:GetService("UtilData")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local dir = pickUpGridPos - casterPos
  if dir.x > 0 then
    dir.x = 1
  end
  if dir.x < 0 then
    dir.x = -1
  end
  if 0 < dir.y then
    dir.y = 1
  end
  if 0 > dir.y then
    dir.y = -1
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local maxX = boardServiceLogic:GetCurBoardMaxX()
  local maxY = boardServiceLogic:GetCurBoardMaxY()
  local max = math.max(maxX, maxY)
  local centerPos = casterPos
  for i = 1, max do
    local pos = casterPos + dir * i
    if not self:IsValidPiecePos(pos) then
      centerPos = pos - dir
      break
    end
    if utilDataSvc:IsPosBlock(pos, BlockFlag.LinkLine) or utilDataSvc:GetPieceType(pos) == PieceType.None then
      centerPos = pos
      break
    end
  end
  return centerPos
end

function UtilScopeCalcServiceShare:_CalcBombPos(teamEntity, casterPos, scopeParam)
  local centerPos = casterPos
  local logicPickUpCmpt = teamEntity:LogicPickUp()
  local petPstID = logicPickUpCmpt:GetLogicPetPstid()
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  local activeSkillPickUpComponent = petEntity:ActiveSkillPickUpComponent()
  if activeSkillPickUpComponent then
    local pickUpPos = activeSkillPickUpComponent:GetLastPickUpGridPos()
    local dir = pickUpPos - casterPos
    if dir.x > 0 then
      dir.x = 1
    end
    if dir.x < 0 then
      dir.x = -1
    end
    if 0 < dir.y then
      dir.y = 1
    end
    if 0 > dir.y then
      dir.y = -1
    end
    local boardServiceLogic = self._world:GetService("BoardLogic")
    local maxX = boardServiceLogic:GetCurBoardMaxX()
    local maxY = boardServiceLogic:GetCurBoardMaxY()
    local max = math.max(maxX, maxY)
    for i = 1, max do
      local pos = casterPos + dir * i
      if not self:IsValidPiecePos(pos) then
        centerPos = pos - dir
        break
      end
      if utilDataSvc:IsPosBlock(pos, BlockFlag.LinkLine) or utilDataSvc:GetPieceType(pos) == PieceType.None then
        centerPos = pos
        break
      end
    end
  end
  return centerPos
end

function UtilScopeCalcServiceShare:_SelectNeareat2Pet(casterPos, scopeParam, teamEntity)
  if scopeParam then
    local tPos = scopeParam:GetScopeCenterParam()
    if tPos then
      local posTeam = teamEntity:GridLocation():GetGridPos()
      local distance = 999
      local pos
      for i, p in ipairs(tPos) do
        local posParam = Vector2(p[1], p[2])
        local dis = Vector2.Distance(posParam, posTeam)
        if distance > dis then
          distance = dis
          pos = posParam
        end
      end
      local posArr = tPos[1]
      return pos or Vector2(posArr[1], posArr[2])
    end
  end
  return casterPos
end

function UtilScopeCalcServiceShare:CalcSkillScope(skillConfigData, casterPos, casterEntity, casterDir)
  local playerBodyArea = casterEntity:BodyArea():GetArea()
  local dir = casterDir or casterEntity:GridLocation():GetGridDir()
  local scopeResult = self._skillScopeCalc:CalcSkillScope(skillConfigData, casterPos, dir, playerBodyArea, casterEntity)
  return scopeResult
end

function UtilScopeCalcServiceShare:CalcSkillScopeForChainSkillPreview(skillConfigData, playerGridPos, casterEntity)
  return self._skillScopeCalc:CalcSkillScopeForChainSkillPreview(skillConfigData, playerGridPos, casterEntity)
end

function UtilScopeCalcServiceShare:CalcScopeResult(scopeParam, casterEntity)
  local casterPos = casterEntity:GridLocation():CenterNoOffset()
  local scopeResult = self:CalcSKillPreviewScopeResult(scopeParam, casterPos, casterEntity)
  return scopeResult
end

function UtilScopeCalcServiceShare:CalcSKillPreviewScopeResult(skillPreviewScopeParam, casterPos, casterEntity)
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local dir = casterEntity:GridLocation():GetGridDir()
  local scopeResult = self._skillScopeCalc:CalcSkillPreviewScope(casterPos, dir, casterBodyArea, skillPreviewScopeParam, casterEntity)
  return scopeResult
end

function UtilScopeCalcServiceShare:CalcSkillEffectScopeResult(skillEffectParam, casterPos, casterEntity)
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local dir = casterEntity:GridLocation():GetGridDir()
  return self._skillScopeCalc:CalcSkillEffectScope(casterPos, dir, casterBodyArea, skillEffectParam, casterEntity)
end

function UtilScopeCalcServiceShare:GetSkillScopeCalc()
  return self._skillScopeCalc
end

function UtilScopeCalcServiceShare:IsValidPiecePos(pos)
  local utilData = self._world:GetService("UtilData")
  local isValidGrid = utilData:IsValidPiecePos(pos)
  return isValidGrid
end

function UtilScopeCalcServiceShare:IsPosBlock(pos, blockFlag)
  local utilData = self._world:GetService("UtilData")
  local isBlocked = utilData:IsPosBlock(pos, blockFlag)
  return isBlocked
end

function UtilScopeCalcServiceShare:GetBlockGridTrapPosList(blockType)
  blockType = blockType or BlockFlag.Skill
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local posList = boardServiceLogic:GetPosListByFlag(blockType)
  return posList
end

function UtilScopeCalcServiceShare:GetBlockMovePosList()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local posList = boardServiceLogic:GetPosListByFlag(BlockFlag.MonsterLand)
  return posList
end

function UtilScopeCalcServiceShare:SelectAllMonster(casterEntity, limit)
  local monsters = {}
  local monsters_pos = {}
  if casterEntity and self._world:MatchType() == MatchType.MT_BlackFist then
    if casterEntity:HasSuperEntity() then
      casterEntity = casterEntity:GetSuperEntity()
    elseif casterEntity:HasSummoner() then
      casterEntity = casterEntity:GetSummonerEntity()
    end
    if casterEntity:HasPet() then
      local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
      local enemyEntity = teamEntity:Team():GetEnemyTeamEntity()
      monsters[1] = enemyEntity
      monsters_pos[1] = enemyEntity:GetGridPosition()
    end
    return monsters, monsters_pos
  end
  local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monster_group:GetEntities()) do
    if not e:HasDeadMark() then
      local buffComponent = e:BuffComponent()
      if buffComponent and not buffComponent:HasBuffEffect(BuffEffectType.NotBeSelectedAsSkillTarget) then
        local monster_grid_location_cmpt = e:GridLocation()
        local bodyAreaList = e:BodyArea():GetArea()
        if not limit or limit > #monsters then
          table.insert(monsters, e)
          for _, bodyArea in ipairs(bodyAreaList) do
            local pos = monster_grid_location_cmpt.Position + bodyArea
            table.insert(monsters_pos, pos)
          end
        end
      end
    end
  end
  return monsters, monsters_pos
end

function UtilScopeCalcServiceShare:SelectMonsterWithBuff(buffEffectType, casterEntity, have)
  local monsters = {}
  local monsters_pos = {}
  local targets = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    targets = {
      casterEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    }
  else
    local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    targets = monster_group:GetEntities()
  end
  for _, e in ipairs(targets) do
    local monster_grid_location_cmpt = e:GridLocation()
    if e:BuffComponent() and have == 1 and e:BuffComponent():HasBuffEffect(buffEffectType) or have == 0 and not e:BuffComponent():HasBuffEffect(buffEffectType) then
      table.insert(monsters, e)
      table.insert(monsters_pos, monster_grid_location_cmpt.Position)
    end
  end
  return monsters, monsters_pos
end

function UtilScopeCalcServiceShare:SelectNearestMonsterInRangeOnPos(casterEntity, caster_pos, limit, range)
  local targetIDArray = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    if casterEntity:HasSuperEntity() then
      casterEntity = casterEntity:SuperEntityComponent():GetSuperEntity()
    end
    if casterEntity:HasSummoner() then
      casterEntity = casterEntity:GetSummonerEntity()
      if casterEntity:HasSuperEntity() then
        casterEntity = casterEntity:SuperEntityComponent():GetSuperEntity()
      end
    end
    local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    local enemy = teamEntity:Team():GetEnemyTeamEntity()
    if table.icontains(range, enemy:GetGridPosition()) then
      targetIDArray[#targetIDArray + 1] = enemy:GetID()
    end
    return targetIDArray
  end
  if limit == -1 then
    local boardService = self._world:GetService("BoardLogic")
    local distance_monster = {}
    local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    limit = #monster_group:GetEntities()
  end
  local skillScopeTargetSelector = self._world:GetSkillScopeTargetSelector()
  local selectedMonsterIds = {}
  for _, skillRangePos in ipairs(range) do
    local targetIDInSkillRangeList = skillScopeTargetSelector:_CalcMonsterInSkillRange(skillRangePos)
    for _, v in ipairs(targetIDInSkillRangeList) do
      if 0 < v then
        selectedMonsterIds[#selectedMonsterIds + 1] = v
      end
    end
  end
  selectedMonsterIds = table.unique(selectedMonsterIds)
  local sortMonsterList = self:SortMonstersListByPos(caster_pos, selectedMonsterIds)
  for i, id in ipairs(sortMonsterList) do
    if i > limit then
      break
    end
    table.insert(targetIDArray, id.monster_e:GetID())
  end
  return targetIDArray
end

function UtilScopeCalcServiceShare:SelectNearestMonsterOnPos(caster_pos, limit, includeDead)
  if limit == -1 then
    local boardService = self._world:GetService("BoardLogic")
    local distance_monster = {}
    local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    limit = #monster_group:GetEntities()
  end
  local monsters = {}
  local monsters_pos = {}
  local distance_monster = self:SortMonstersByPos(caster_pos, true)
  local skillScopeTargetSelector = self._world:GetSkillScopeTargetSelector()
  for _, element in ipairs(distance_monster) do
    local monsterEntity = element.monster_e
    local curHP = monsterEntity:Attributes():GetCurrentHP()
    local deadChekPass = false
    if includeDead then
      deadChekPass = true
    else
      deadChekPass = not monsterEntity:HasDeadMark() and 0 < curHP
    end
    if limit > #monsters and deadChekPass and skillScopeTargetSelector:SelectConditionFilter(monsterEntity) then
      table.insert(monsters, element.monster_e)
      table.insert(monsters_pos, element.pos)
    end
  end
  return monsters, monsters_pos
end

function UtilScopeCalcServiceShare:SortMonstersListByPos(target_pos, monsterIDList, nearestForMultiGridMonster)
  local utilData = self._world:GetService("UtilData")
  local distance_monster = {}
  for _, entityID in ipairs(monsterIDList) do
    local e = self._world:GetEntityByID(entityID)
    local position = e:GridLocation().Position
    if utilData:IsValidPiecePos(position) then
      if nearestForMultiGridMonster then
        local pos = position
        local distance = Vector2.Distance(pos, target_pos)
        local tBodyArea = e:BodyArea():GetArea()
        for _, v2RelativeBody in ipairs(tBodyArea) do
          local v2 = v2RelativeBody + position
          local newDis = Vector2.Distance(v2, target_pos)
          if distance > newDis then
            distance = newDis
            pos = v2
          end
        end
        table.insert(distance_monster, {
          dis = distance,
          monster_e = e,
          pos = pos
        })
      else
        local distance = Vector2.Distance(position, target_pos)
        table.insert(distance_monster, {
          dis = distance,
          monster_e = e,
          pos = position
        })
      end
    end
  end
  
  local function get_index(c, p)
    if p.x - c.x == 0 and 0 < p.y - c.y then
      return 1
    end
    if p.x - c.x > 0 and 0 < p.y - c.y then
      return 2
    end
    if p.x - c.x > 0 and p.y - c.y == 0 then
      return 3
    end
    if p.x - c.x > 0 and 0 > p.y - c.y then
      return 4
    end
    if p.x - c.x == 0 and 0 > p.y - c.y then
      return 5
    end
    if p.x - c.x < 0 and 0 > p.y - c.y then
      return 6
    end
    if p.x - c.x < 0 and p.y - c.y == 0 then
      return 7
    end
    if p.x - c.x < 0 and 0 < p.y - c.y then
      return 8
    end
    return 1
  end
  
  local function cmp_fun(ele1, ele2)
    if ele1.dis == ele2.dis then
      return get_index(target_pos, ele1.pos) < get_index(target_pos, ele2.pos)
    else
      return ele1.dis < ele2.dis
    end
  end
  
  table.sort(distance_monster, cmp_fun)
  return distance_monster
end

function UtilScopeCalcServiceShare:SortMonstersListByBodyAreaAndPos(target_pos, monsterIDList, nearestForMultiGridMonster)
  local utilData = self._world:GetService("UtilData")
  local distance_monster = {}
  for _, entityID in ipairs(monsterIDList) do
    local e = self._world:GetEntityByID(entityID)
    local position = e:GridLocation().Position
    if utilData:IsValidPiecePos(position) then
      local tBodyArea = e:BodyArea():GetArea()
      local bodyAreaSize = #tBodyArea
      if nearestForMultiGridMonster then
        local pos = position
        local distance = Vector2.Distance(pos, target_pos)
        for _, v2RelativeBody in ipairs(tBodyArea) do
          local v2 = v2RelativeBody + position
          local newDis = Vector2.Distance(v2, target_pos)
          if distance > newDis then
            distance = newDis
            pos = v2
          end
        end
        table.insert(distance_monster, {
          dis = distance,
          monster_e = e,
          pos = pos,
          size = bodyAreaSize
        })
      else
        local distance = Vector2.Distance(position, target_pos)
        table.insert(distance_monster, {
          dis = distance,
          monster_e = e,
          pos = position,
          size = bodyAreaSize
        })
      end
    end
  end
  
  local function get_index(c, p)
    if p.x - c.x == 0 and 0 < p.y - c.y then
      return 1
    end
    if p.x - c.x > 0 and 0 < p.y - c.y then
      return 2
    end
    if p.x - c.x > 0 and p.y - c.y == 0 then
      return 3
    end
    if p.x - c.x > 0 and 0 > p.y - c.y then
      return 4
    end
    if p.x - c.x == 0 and 0 > p.y - c.y then
      return 5
    end
    if p.x - c.x < 0 and 0 > p.y - c.y then
      return 6
    end
    if p.x - c.x < 0 and p.y - c.y == 0 then
      return 7
    end
    if p.x - c.x < 0 and 0 < p.y - c.y then
      return 8
    end
    return 1
  end
  
  local function cmp_fun(ele1, ele2)
    if ele1.size == ele2.size then
      if ele1.dis == ele2.dis then
        return get_index(target_pos, ele1.pos) < get_index(target_pos, ele2.pos)
      else
        return ele1.dis < ele2.dis
      end
    else
      return ele1.size < ele2.size
    end
  end
  
  table.sort(distance_monster, cmp_fun)
  return distance_monster
end

function UtilScopeCalcServiceShare:SortMonstersByPos(target_pos, nearestForMultiGridMonster)
  local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local monsterIDList = {}
  for _, e in ipairs(monster_group:GetEntities()) do
    table.insert(monsterIDList, e:GetID())
  end
  return self:SortMonstersListByPos(target_pos, monsterIDList, nearestForMultiGridMonster)
end

function UtilScopeCalcServiceShare:FindPieceElementByTypeCountAndCenter(centerPos, pieceTypeList, maxCount, excludeTrap, excludePosList, canPlayerMove)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  return utilCalcSvc:FindPieceElementByTypeCountAndCenter(centerPos, pieceTypeList, maxCount, nil, nil, excludeTrap, excludePosList, canPlayerMove)
end

function UtilScopeCalcServiceShare:FindPieceElementByTypeAndArea(areaGridList, pieceTypeList, excludeTrap)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  return utilCalcSvc:FindPieceElementByTypeAndArea(areaGridList, pieceTypeList, excludeTrap)
end

function UtilScopeCalcServiceShare:ChangeGameFSMState2PickUp()
  local gameFsmCmpt = self._world:GameFSM()
  local gameFsmStateID = gameFsmCmpt:CurStateID()
  if gameFsmStateID == GameStateID.PreviewActiveSkill then
    self._world:EventDispatcher():Dispatch(GameEventType.PreviewActiveSkillFinish, 3)
    self._world:EventDispatcher():Dispatch(GameEventType.PickUPValidGridShowChooseTarget, true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnClickWhenPickUp)
  end
end

function UtilScopeCalcServiceShare:IsPosHaveMonsterOrPet(pos)
  local boardCmpt = self._world:GetBoardEntity():Board()
  local es = boardCmpt:GetPieceEntities(pos, function(e)
    return e:HasTeam() or e:HasMonsterID()
  end)
  return 0 < #es
end

function UtilScopeCalcServiceShare:GetEmptyPieces(fixedRange)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local posTable = {}
  local teamGroup = self._world:GetGroup(self._world.BW_WEMatchers.Team)
  for i, e in ipairs(teamGroup:GetEntities()) do
    local player_pos = e:GridLocation().Position
    if not posTable[player_pos.x] then
      posTable[player_pos.x] = {}
    end
    posTable[player_pos.x][player_pos.y] = true
  end
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() then
      local trapPos = e:GridLocation().Position
      if not posTable[trapPos.x] then
        posTable[trapPos.x] = {}
      end
      posTable[trapPos.x][trapPos.y] = true
    end
  end
  local blockPosList = boardServiceLogic:GetPosListByFlag(BlockFlag.LinkLine)
  if blockPosList then
    for i, pos in ipairs(blockPosList) do
      if not posTable[pos.x] then
        posTable[pos.x] = {}
      end
      posTable[pos.x][pos.y] = true
    end
  end
  local validPos
  if fixedRange then
    validPos = fixedRange
  else
    validPos = boardServiceLogic:GetPlayerAreaPosList()
  end
  local target_area_grid = {}
  for i, pos in ipairs(validPos) do
    if not posTable[pos.x] or not posTable[pos.x][pos.y] then
      table.insert(target_area_grid, pos)
    end
  end
  return target_area_grid
end

function UtilScopeCalcServiceShare:GetAllValidGridPosList()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  return boardServiceLogic:GetPlayerAreaPosList()
end

function UtilScopeCalcServiceShare:SelectTarget(actorEntity, pieceType)
  self._chainPathTargetSelector:DoSelectTarget(actorEntity, pieceType)
end

function UtilScopeCalcServiceShare:SelectSkillTarget(castEntity, targetType, scopeResult, skillID, skillEffectTargetTypeParam)
  return self._skillScopeTargetSelector:DoSelectSkillTarget(castEntity, targetType, scopeResult, skillID, skillEffectTargetTypeParam)
end

function UtilScopeCalcServiceShare:BuildScopeGridList_CheckPosFunc(onlyCanmove, notDoor, canConvert, pos, enemyTeamPos, boardServiceLogic, notExit)
  if canConvert and self:IsPosBlock(pos, BlockFlag.ChangeElement) then
    return
  end
  if onlyCanmove and (self:IsPosBlock(pos, BlockFlag.LinkLine) or pos == enemyTeamPos) then
    return
  end
  if notDoor and boardServiceLogic:IsDoor(pos) then
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  if notExit and utilDataSvc:IsPosExit(pos) then
    return
  end
  return true
end

function UtilScopeCalcServiceShare:BuildScopeGridList(scopeParamList, casterEntity, centerPos)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local enemyTeamPos
  if self._world:MatchType() == MatchType.MT_BlackFist then
    if casterEntity:HasPet() then
      enemyTeamPos = casterEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity():GetGridPosition()
    elseif casterEntity:Trap():IsPetTrapCastSkill() and casterEntity:HasSummoner() then
      local summonEntityID = casterEntity:Summoner():GetSummonerEntityID()
      local summonEntity = casterEntity:GetSummonerEntity()
      if summonEntity and summonEntity:HasSuperEntity() and summonEntity:GetSuperEntity() then
        summonEntityID = summonEntity:GetSuperEntity():GetID()
      end
      summonEntity = self._world:GetEntityByID(summonEntityID)
      enemyTeamPos = summonEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity():GetGridPosition()
    end
  end
  local casterPos = casterEntity:GridLocation():CenterNoOffset()
  if centerPos then
    casterPos = centerPos:Clone()
  end
  local scopeGirdList = {}
  for _, scopeParam in ipairs(scopeParamList) do
    local scopeResult = self:CalcSKillPreviewScopeResult(scopeParam, casterPos, casterEntity)
    local scopeList = scopeResult:GetAttackRange()
    local realScopeList = {}
    for i, pos in ipairs(scopeList) do
      if self:BuildScopeGridList_CheckPosFunc(scopeParam:GetOnlyCanMove(), scopeParam:GetNotDoor(), scopeParam:GetCanConvert(), pos, enemyTeamPos, boardServiceLogic, scopeParam:GetNotExit()) then
        realScopeList[Vector2.Pos2Index(pos)] = true
      end
    end
    for v2Idx, _ in pairs(realScopeList) do
      local pos = Vector2.Index2Pos(v2Idx)
      table.insert(scopeGirdList, pos)
    end
  end
  return scopeGirdList
end

function UtilScopeCalcServiceShare:IsPosHasMonster(pos)
  if not pos then
    return false, nil
  end
  local monsterEntityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterEntityList) do
    local monsterEntityID = e:GetID()
    local monsterPos = e:GetGridPosition()
    local monster_body_area_cmpt = e:BodyArea()
    local monster_body_area = monster_body_area_cmpt:GetArea()
    for i, bodyArea in ipairs(monster_body_area) do
      if monsterPos.x + bodyArea.x == pos.x and monsterPos.y + bodyArea.y == pos.y then
        return true, monsterEntityID
      end
    end
  end
  return false, nil
end

function UtilScopeCalcServiceShare:SortSkillRangeByDirectionAndDistance(casterPos, skillRangePos)
  local sortGridList = {}
  for _, gridPos in ipairs(skillRangePos) do
    local direction = gridPos - casterPos
    local directionName
    if direction.x == 0 and 0 < direction.y then
      directionName = 1
    elseif direction.x == 0 and 0 > direction.y then
      directionName = 2
    elseif direction.x > 0 and direction.y == 0 then
      directionName = 3
    elseif direction.x < 0 and direction.y == 0 then
      directionName = 4
    end
    if directionName then
      if not sortGridList[directionName] then
        sortGridList[directionName] = {}
      end
      table.insert(sortGridList[directionName], gridPos)
    end
  end
  if 0 < table.count(sortGridList) then
    for _, gridPosList in pairs(sortGridList) do
      table.sort(gridPosList, function(a, b)
        local disA = Vector2.Distance(a, casterPos)
        local disB = Vector2.Distance(b, casterPos)
        return disA < disB
      end)
    end
  end
  return sortGridList
end

function UtilScopeCalcServiceShare:CalcSkillResultByConfigData(skillConfigData, casterEntity)
  local targetType = skillConfigData:GetSkillTargetType()
  local targetTypeParam = skillConfigData:GetSkillTargetTypeParam()
  local scopeParam = SkillPreviewScopeParam:New({
    TargetType = targetType,
    ScopeType = skillConfigData:GetSkillScopeType(),
    ScopeCenterType = skillConfigData:GetSkillScopeCenterType(),
    TargetTypeParam = targetTypeParam
  })
  scopeParam:SetScopeParamData(skillConfigData:GetSkillScopeParam())
  local scopeResult = self:CalcScopeResult(scopeParam, casterEntity)
  return scopeResult:GetAttackRange()
end

function UtilScopeCalcServiceShare:GetEntityDistanceInfoArray(entityIDs, v2CenterPos)
  local tTargetDistanceInfo = {}
  for _, targetID in ipairs(entityIDs) do
    local e = self._world:GetEntityByID(targetID)
    if e then
      local v2GridPos = e:GetGridPosition()
      local distance = Vector2.Distance(v2GridPos, v2CenterPos)
      table.insert(tTargetDistanceInfo, {
        targetID = targetID,
        gridPos = v2GridPos,
        distance = distance,
        entity = e
      })
    end
  end
  local scopeCalc = self:GetSkillScopeCalc()
  table.sort(tTargetDistanceInfo, function(a, b)
    if a.distance ~= b.distance then
      return a.distance < b.distance
    end
    local HBDTa = scopeCalc:GetDirection(a.gridPos, v2CenterPos)
    local HBDTb = scopeCalc:GetDirection(b.gridPos, v2CenterPos)
    if HBDTa ~= HBDTb then
      return HBDTa < HBDTb
    end
    if a.entity:HasRide() then
      local rideCmpt = a.entity:Ride()
      return a.targetID == rideCmpt:GetRiderID()
    end
  end)
  return tTargetDistanceInfo
end

function UtilScopeCalcServiceShare:GetEntityDistanceInfoArrayByPosDic(entityIDs, v2CenterPos, posDic)
  local tTargetDistanceInfo = {}
  for _, targetID in ipairs(entityIDs) do
    local e = self._world:GetEntityByID(targetID)
    if e then
      local v2GridPos = posDic[targetID] and table.remove(posDic[targetID], 1) or nil
      if v2GridPos then
        local distance = Vector2.Distance(v2GridPos, v2CenterPos)
        table.insert(tTargetDistanceInfo, {
          targetID = targetID,
          gridPos = v2GridPos,
          distance = distance,
          entity = e
        })
      end
    end
  end
  local scopeCalc = self:GetSkillScopeCalc()
  table.sort(tTargetDistanceInfo, function(a, b)
    if a.distance ~= b.distance then
      return a.distance < b.distance
    end
    local HBDTa = scopeCalc:GetDirection(a.gridPos, v2CenterPos)
    local HBDTb = scopeCalc:GetDirection(b.gridPos, v2CenterPos)
    if HBDTa ~= HBDTb then
      return HBDTa < HBDTb
    end
    if a.entity:HasRide() then
      local rideCmpt = a.entity:Ride()
      return a.targetID == rideCmpt:GetRiderID()
    end
  end)
  return tTargetDistanceInfo
end

function UtilScopeCalcServiceShare:GetSpBlockRange(blockFlag)
  local range = {}
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local board = self._world:GetBoardEntity():Board()
  local arr = board:GetBlockFlagArray()
  for x, col in pairs(arr) do
    for y, block in pairs(col) do
      local grid = Vector2(x, y)
      if not boardServiceLogic:IsPosBlock(grid, blockFlag) then
        table.insert(range, grid)
      end
    end
  end
  return range
end

function UtilScopeCalcServiceShare:GetFullScreenCanSummonTrapRange()
  return self:GetSpBlockRange(BlockFlag.SummonTrap)
end

function UtilScopeCalcServiceShare:GetFullScreenCanChangeElementRange()
  return self:GetSpBlockRange(BlockFlag.ChangeElement)
end

function UtilScopeCalcServiceShare:GetFullScreenNoBlockRange(blockFlag)
  return self:GetSpBlockRange(blockFlag)
end

function UtilScopeCalcServiceShare:GetBoardQuadrantsByCenter(centerPos, casterEntity, excludeSelf)
  local baseScopeCalc = SkillScopeCalculator:New(self)
  local fullScreenCalc = SkillScopeCalculator_FullScreen:New(baseScopeCalc)
  local platformScopeResult = fullScreenCalc:CalcRange(SkillScopeType.FullScreen, excludeSelf and 1 or 0, centerPos, casterEntity:BodyArea():GetArea(), casterEntity:GetGridDirection(), SkillTargetType.Board, centerPos)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local rt, rb, lb, lt = utilCalcSvc:DivideGridsByQuadrant(platformScopeResult:GetAttackRange(), centerPos)
  return {
    [BoardQuadrant.RightTop] = rt,
    [BoardQuadrant.RightBottom] = rb,
    [BoardQuadrant.LeftBottom] = lb,
    [BoardQuadrant.LeftTop] = lt
  }
end

function UtilScopeCalcServiceShare:BuildScopeGridListMultiPick(scopeParamList, casterEntity, pickPosList)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local enemyTeamPos
  if self._world:MatchType() == MatchType.MT_BlackFist then
    enemyTeamPos = casterEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity():GetGridPosition()
  end
  local casterPos = pickPosList
  local scopeGirdList = {}
  for _, scopeParam in ipairs(scopeParamList) do
    local scopeResult = self:CalcSKillPreviewScopeResult(scopeParam, casterPos, casterEntity)
    local scopeList = scopeResult:GetAttackRange()
    local realScopeList = {}
    for i, pos in ipairs(scopeList) do
      if self:BuildScopeGridList_CheckPosFunc(scopeParam:GetOnlyCanMove(), scopeParam:GetNotDoor(), scopeParam:GetCanConvert(), pos, enemyTeamPos, boardServiceLogic, scopeParam:GetNotExit()) then
        realScopeList[Vector2.Pos2Index(pos)] = true
      end
    end
    for v2Idx, _ in pairs(realScopeList) do
      local pos = Vector2.Index2Pos(v2Idx)
      table.insert(scopeGirdList, pos)
    end
  end
  return scopeGirdList
end

function UtilScopeCalcServiceShare:GetTrapPiecesExceptTrapID(trapID, fixedRange)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local trapPosList = self:_GetTrapPosList(fixedRange)
  local utilDataSvc = self._world:GetService("UtilData")
  local canSummonTrapPosList = {}
  for _, pos in ipairs(trapPosList) do
    if not utilDataSvc:IsPosBlock(pos, BlockFlag.SummonTrap) then
      table.insert(canSummonTrapPosList, pos)
    end
  end
  local boardCmpt = self._world:GetBoardEntity():Board()
  local configService = self._world:GetService("Config")
  local trapConfigData = configService:GetTrapConfigData()
  local trapData = trapConfigData:GetTrapData(trapID)
  local posList = {}
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local onlyViewTrap = trapServiceLogic:IsViewTrapLevel(trapData.TrapLevel)
  for _, pos in ipairs(canSummonTrapPosList) do
    local es = boardCmpt:GetPieceEntities(pos, function(e)
      return e:HasTrap() and not e:HasDeadMark() and e:Trap():GetTrapLevel() == trapData.TrapLevel and not onlyViewTrap
    end)
    if #es == 0 then
      table.insert(posList, pos)
    end
  end
  if #posList == 0 then
    posList = canSummonTrapPosList
  end
  return posList
end

function UtilScopeCalcServiceShare:_GetTrapPosList(fixedRange)
  local trapPosList = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() then
      local trapPos = e:GridLocation().Position
      if not table.icontains(trapPosList, trapPos) then
        if fixedRange then
          if table.icontains(fixedRange, trapPos) then
            table.insert(trapPosList, trapPos)
          end
        else
          table.insert(trapPosList, trapPos)
        end
      end
    end
  end
  return trapPosList
end

function UtilScopeCalcServiceShare:GetSortChessPetByMonsterPos(monsterPos)
  local entityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.ChessPet)
  local entityInfoList = {}
  for i, entity in ipairs(entityList) do
    local hp = entity:Attributes():GetCurrentHP()
    local dis = Vector2.Distance(monsterPos, entity:GetGridPosition())
    table.insert(entityInfoList, {
      entity = entity,
      hp = hp,
      dis = dis,
      id = entity:GetID()
    })
  end
  table.sort(entityInfoList, function(a, b)
    if a.dis ~= b.dis then
      return a.dis < b.dis
    elseif a.hp ~= b.hp then
      return a.hp < b.hp
    else
      return a.id < b.id
    end
  end)
  local retEntityIDList = {}
  for i, v in ipairs(entityInfoList) do
    table.insert(retEntityIDList, v.id)
  end
  return retEntityIDList
end

function UtilScopeCalcServiceShare:GetTargetSquareRing(entityID, ringCount)
  local monsterEntity = self._world:GetEntityByID(entityID)
  local pos = monsterEntity:GetGridPosition()
  local bodyArea = monsterEntity:BodyArea():GetArea()
  local posList = ComputeScopeRange.ComputeRange_SquareRing(pos, #bodyArea, ringCount)
  return posList
end

function UtilScopeCalcServiceShare:GetMonsterAroundCanMovePosList(entity, offset)
  offset = offset or Offset8
  local ret = {}
  local pos = entity:GetGridPosition()
  local raceType = entity:MonsterID():GetMonsterRaceType()
  local effectCalcSvc = self._world:GetService("SkillEffectCalc")
  local blockFlag = effectCalcSvc:_TransBlockByRaceType(raceType)
  local utilDataSvc = self._world:GetService("UtilData")
  local boardSvc = self._world:GetService("BoardLogic")
  for i, v in ipairs(offset) do
    local newPos = Vector2(pos.x + v[1], pos.y + v[2])
    if (newPos.x ~= pos.x or newPos.y ~= pos.y) and utilDataSvc:IsValidPiecePos(newPos) and not boardSvc:IsPosBlock(newPos, blockFlag) and not utilDataSvc:IsPosHasSpTrap(newPos, TrapType.BadGrid) then
      table.insert(ret, newPos)
    end
  end
  return ret
end

function UtilScopeCalcServiceShare:GetPosAroundSameTypePosList(pos, pieceType)
  local ret = {}
  local utilDataSvc = self._world:GetService("UtilData")
  local boardSvc = self._world:GetService("BoardLogic")
  local board = self._world:GetBoardEntity():Board()
  for x = -1, 1 do
    for y = -1, 1 do
      local newPos = Vector2(pos.x + x, pos.y + y)
      if (newPos.x ~= pos.x or newPos.y ~= pos.y) and utilDataSvc:IsValidPiecePos(newPos) and not boardSvc:IsPosBlock(newPos, BlockFlag.LinkLine) and not utilDataSvc:IsPosHasSpTrap(newPos, TrapType.BadGrid) then
        local type = board:GetPieceType(newPos)
        if type == pieceType or type == PieceType.Any then
          table.insert(ret, newPos)
        end
      end
    end
  end
  return ret
end

function UtilScopeCalcServiceShare:SelectAllChessPet()
  local chessPets = {}
  local chessPets_pos = {}
  local chessPet_group = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
  for _, e in ipairs(chessPet_group:GetEntities()) do
    if not e:HasDeadMark() then
      local monster_grid_location_cmpt = e:GridLocation()
      local bodyAreaList = e:BodyArea():GetArea()
      table.insert(chessPets, e)
      for _, bodyArea in ipairs(bodyAreaList) do
        local pos = monster_grid_location_cmpt.Position + bodyArea
        table.insert(chessPets_pos, pos)
      end
    end
  end
  return chessPets, chessPets_pos
end

function UtilScopeCalcServiceShare:IsTargetInScope(targetID, scopeList)
  local e = self._world:GetEntityByID(targetID)
  local monster_grid_location_cmpt = e:GridLocation()
  local monster_body_area_cmpt = e:BodyArea()
  local monster_body_area = monster_body_area_cmpt:GetArea()
  for i, bodyArea in ipairs(monster_body_area) do
    local curMonsterBodyPos = monster_grid_location_cmpt.Position + bodyArea
    if table.Vector2Include(scopeList, curMonsterBodyPos) then
      return true
    end
  end
  return false
end

function UtilScopeCalcServiceShare:ChessMonsterSelectTarget(scopeList, targetCount)
  local entityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.ChessPet)
  local inScopeTargetList = {}
  for i, e in ipairs(entityList) do
    if self:IsTargetInScope(e:GetID(), scopeList) then
      local hp = e:Attributes():GetCurrentHP()
      local id = e:GetID()
      table.insert(inScopeTargetList, {id = id, hp = hp})
    end
  end
  if targetCount < #inScopeTargetList then
    table.sort(inScopeTargetList, function(a, b)
      if a.hp ~= b.hp then
        return a.hp < b.hp
      end
      return a.id < b.id
    end)
  end
  local retList = {}
  for i, v in ipairs(inScopeTargetList) do
    if targetCount < i then
      break
    end
    table.insert(retList, v.id)
  end
  return retList
end

function UtilScopeCalcServiceShare:GetChessEntityGridDirWithPickUpPos(entity, pickUpPos, targetMovePos)
  targetMovePos = targetMovePos or entity:GetGridPosition()
  local bodyArea = entity:BodyArea():GetArea()
  local dir = pickUpPos - targetMovePos
  if table.count(bodyArea) == 4 or Vector2.Distance(targetMovePos, pickUpPos) > 1 then
    local chessPetCmpt = entity:ChessPet()
    local attackSkill = chessPetCmpt:GetAttackSkillID()
    local cfgSvc = self._world:GetService("Config")
    local attackSkillConfigData = cfgSvc:GetSkillConfigData(attackSkill, entity)
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local vectors = {
      Vector2(-1, 0),
      Vector2(1, 0),
      Vector2(0, -1),
      Vector2(0, 1)
    }
    for i, dir in ipairs(vectors) do
      local scopeResultSelect = utilScopeSvc:CalcSkillScope(attackSkillConfigData, targetMovePos, entity, dir)
      local selectRange = scopeResultSelect:GetAttackRange()
      if table.intable(selectRange, pickUpPos) then
        return dir
      end
    end
  end
  return dir
end

function UtilScopeCalcServiceShare:GetDirectionTypeByVector2(dir)
  if dir.x == 0 and dir.y == 1 then
    return DirectionType.Up
  elseif dir.x == 0 and dir.y == -1 then
    return DirectionType.Down
  elseif dir.x == 1 and dir.y == 0 then
    return DirectionType.Right
  elseif dir.x == -1 and dir.y == 0 then
    return DirectionType.Left
  elseif dir.x == 1 and dir.y == 1 then
    return DirectionType.RightUp
  elseif dir.x == -1 and dir.y == 1 then
    return DirectionType.LeftUp
  elseif dir.x == -1 and dir.y == -1 then
    return DirectionType.LeftDown
  elseif dir.x == 1 and dir.y == -1 then
    return DirectionType.RightDown
  end
end

function UtilScopeCalcServiceShare:GetEntityRenderDirType(entity)
  local dir = entity:GetRenderGridDirection()
  return self:GetDirectionTypeByVector2(dir)
end

function UtilScopeCalcServiceShare:GetEntityDirType(entity)
  local dir = entity:GetGridDirection()
  return self:GetDirectionTypeByVector2(dir)
end

function UtilScopeCalcServiceShare:GetDirByDirType(dirType)
  if dirType == DirectionType.Up then
    return Vector2(0, 1)
  elseif dirType == DirectionType.Down then
    return Vector2(0, -1)
  elseif dirType == DirectionType.Left then
    return Vector2(-1, 0)
  elseif dirType == DirectionType.Right then
    return Vector2(1, 0)
  end
end

function UtilScopeCalcServiceShare:GetVectorDirByBodyArea(entity)
  local bodyAreaCmpt = entity:BodyArea()
  local bodyArea = bodyAreaCmpt:GetArea()
  local pos = bodyArea[2]
  local dirType
  if pos == Vector2(0, -1) then
    dirType = DirectionType.Up
  elseif pos == Vector2(1, 0) then
    dirType = DirectionType.Left
  elseif pos == Vector2(0, 1) then
    dirType = DirectionType.Down
  elseif pos == Vector2(-1, 0) then
    dirType = DirectionType.Right
  end
  local dir = self:GetDirByDirType(dirType)
  return dir
end

function UtilScopeCalcServiceShare:GetNightKing_Skill1A(casterEntity, casterPos, dirType)
  local addRangeList = {}
  if dirType == DirectionType.Up then
    addRangeList = {
      Vector2(-1, 0),
      Vector2(-1, 1),
      Vector2(0, 1),
      Vector2(1, 1),
      Vector2(1, 0)
    }
  elseif dirType == DirectionType.Down then
    addRangeList = {
      Vector2(-1, 0),
      Vector2(-1, -1),
      Vector2(0, -1),
      Vector2(1, -1),
      Vector2(1, 0)
    }
  elseif dirType == DirectionType.Left then
    addRangeList = {
      Vector2(0, 1),
      Vector2(-1, 1),
      Vector2(-1, 0),
      Vector2(-1, -1),
      Vector2(0, -1)
    }
  elseif dirType == DirectionType.Right then
    addRangeList = {
      Vector2(0, 1),
      Vector2(1, 1),
      Vector2(1, 0),
      Vector2(1, -1),
      Vector2(0, -1)
    }
  end
  local rangList = {}
  for i, p in ipairs(addRangeList) do
    local newPos = Vector2(p.x + casterPos.x, p.y + casterPos.y)
    table.insert(rangList, newPos)
  end
  return rangList
end

function UtilScopeCalcServiceShare:GetNightKing_SkillCScope(casterEntity, casterPos)
  local dirType = self:GetEntityDirType(casterEntity)
  local leftScope = {}
  local rightScope = {}
  local utilDataCalcSvc = self._world:GetService("UtilData")
  if dirType == DirectionType.Up or dirType == DirectionType.Down then
    local range1, range2 = {}, {}
    for y = -1, 1 do
      for x = -2, BattleConst.BoardMaxLen * -1, -1 do
        local newPos = Vector2(x + casterPos.x, y + casterPos.y)
        if utilDataCalcSvc:IsValidPiecePos(newPos) then
          table.insert(range1, newPos)
        end
      end
    end
    for y = -1, 1 do
      for x = 2, BattleConst.BoardMaxLen do
        local newPos = Vector2(x + casterPos.x, y + casterPos.y)
        if utilDataCalcSvc:IsValidPiecePos(newPos) then
          table.insert(range2, newPos)
        end
      end
    end
    if dirType == DirectionType.Up then
      leftScope = range1
      rightScope = range2
    elseif dirType == DirectionType.Down then
      leftScope = range2
      rightScope = range1
    end
  elseif dirType == DirectionType.Left or dirType == DirectionType.Right then
    local range1, range2 = {}, {}
    for x = -1, 1 do
      for y = -2, BattleConst.BoardMaxLen * -1, -1 do
        local newPos = Vector2(x + casterPos.x, y + casterPos.y)
        if utilDataCalcSvc:IsValidPiecePos(newPos) then
          table.insert(range1, newPos)
        end
      end
    end
    for x = -1, 1 do
      for y = 2, BattleConst.BoardMaxLen do
        local newPos = Vector2(x + casterPos.x, y + casterPos.y)
        if utilDataCalcSvc:IsValidPiecePos(newPos) then
          table.insert(range2, newPos)
        end
      end
    end
    if dirType == DirectionType.Left then
      leftScope = range1
      rightScope = range2
    elseif dirType == DirectionType.Right then
      leftScope = range2
      rightScope = range1
    end
  end
  return leftScope, rightScope
end

function UtilScopeCalcServiceShare:GetTailFlickSwitchBodyArea(casterEntity, targetEntity)
  local casterPos = casterEntity:GetGridPosition()
  local switchDirType = self:GetNightKingTailFlickSwitchBodyAreaDirType(casterEntity, casterPos, targetEntity)
  local dirType = self:GetEntityDirType(casterEntity)
  local newDir, newBodyArea = self:GetNewDirBySwitchDirType(switchDirType, dirType)
  return newDir, newBodyArea, switchDirType
end

function UtilScopeCalcServiceShare:IsNightKingCanCounterAttack(casterEntity, targetEntity)
  local casterPos = casterEntity:GetGridPosition()
  local switchDirType = self:GetNightKingCounterAttackSwitchBodyAreaDirType(casterEntity, casterPos, targetEntity)
  return switchDirType ~= SwitchBodyAreaDirType.None
end

function UtilScopeCalcServiceShare:GetCounterAttackSwitchBodyArea(casterEntity, targetEntity)
  local casterPos = casterEntity:GetGridPosition()
  local switchDirType = self:GetNightKingCounterAttackSwitchBodyAreaDirType(casterEntity, casterPos, targetEntity)
  local dirType = self:GetEntityDirType(casterEntity)
  local newDir, newBodyArea = self:GetNewDirBySwitchDirType(switchDirType, dirType)
  return newDir, newBodyArea, switchDirType
end

function UtilScopeCalcServiceShare:ValidPosInsertList(list, pos)
  local utilDataCalcSvc = self._world:GetService("UtilData")
  if utilDataCalcSvc:IsValidPiecePos(pos) then
    table.insert(list, pos)
  end
end

function UtilScopeCalcServiceShare:GetNightKingCounterAttackScope(casterEntity, casterPos)
  local dirType = self:GetEntityDirType(casterEntity)
  local leftScopeList, rightScopeList, downScopeList = {}, {}, {}
  local symbol = 1
  if dirType == DirectionType.Up or dirType == DirectionType.Left then
    symbol = -1
  end
  if dirType == DirectionType.Up or dirType == DirectionType.Down then
    self:ValidPosInsertList(downScopeList, Vector2(casterPos.x - 1, casterPos.y + symbol))
    self:ValidPosInsertList(downScopeList, Vector2(casterPos.x + 1, casterPos.y + symbol))
    self:ValidPosInsertList(leftScopeList, Vector2(casterPos.x + symbol, casterPos.y))
    self:ValidPosInsertList(rightScopeList, Vector2(casterPos.x + symbol * -1, casterPos.y))
  end
  if dirType == DirectionType.Left or dirType == DirectionType.Right then
    self:ValidPosInsertList(downScopeList, Vector2(casterPos.x + symbol * -1, casterPos.y - 1))
    self:ValidPosInsertList(downScopeList, Vector2(casterPos.x + symbol * -1, casterPos.y + 1))
    self:ValidPosInsertList(leftScopeList, Vector2(casterPos.x, casterPos.y + symbol))
    self:ValidPosInsertList(rightScopeList, Vector2(casterPos.x, casterPos.y + symbol * -1))
  end
  for a = 2, BattleConst.BoardMaxLen do
    for n = 2, BattleConst.BoardMaxLen do
      for b = n * -1, n do
        if dirType == DirectionType.Left or dirType == DirectionType.Right then
          self:ValidPosInsertList(downScopeList, Vector2(casterPos.x + a * symbol * -1, casterPos.y + b))
          self:ValidPosInsertList(leftScopeList, Vector2(casterPos.x + b, casterPos.y + symbol * a))
          self:ValidPosInsertList(rightScopeList, Vector2(casterPos.x + b, casterPos.y + symbol * -1 * a))
        end
        if dirType == DirectionType.Up or dirType == DirectionType.Down then
          self:ValidPosInsertList(downScopeList, Vector2(casterPos.x + b, casterPos.y + a * symbol))
          self:ValidPosInsertList(leftScopeList, Vector2(casterPos.x + symbol * a, casterPos.y + b))
          self:ValidPosInsertList(rightScopeList, Vector2(casterPos.x + symbol * a * -1, casterPos.y + b))
        end
      end
    end
  end
  return leftScopeList, rightScopeList, downScopeList
end

function UtilScopeCalcServiceShare:GetNightKingCounterAttackSwitchBodyAreaDirType(casterEntity, casterPos, targetEntity)
  local leftScopeList, rightScopeList, downScopeList = self:GetNightKingCounterAttackScope(casterEntity, casterPos)
  local targetPos = targetEntity:GetGridPosition()
  if table.Vector2Include(leftScopeList, targetPos) then
    return SwitchBodyAreaDirType.Left
  elseif table.Vector2Include(rightScopeList, targetPos) then
    return SwitchBodyAreaDirType.Right
  elseif table.Vector2Include(downScopeList, targetPos) then
    return SwitchBodyAreaDirType.Turn
  else
    return SwitchBodyAreaDirType.None
  end
end

function UtilScopeCalcServiceShare:GetNightKingTailFlickSwitchBodyAreaDirType(casterEntity, casterPos, targetEntity)
  local leftScopeList, rightScopeList = self:GetNightKing_SkillCScope(casterEntity, casterPos)
  local targetPos = targetEntity:GetGridPosition()
  if table.Vector2Include(leftScopeList, targetPos) then
    return SwitchBodyAreaDirType.Left
  elseif table.Vector2Include(rightScopeList, targetPos) then
    return SwitchBodyAreaDirType.Right
  else
    return SwitchBodyAreaDirType.Turn
  end
end

function UtilScopeCalcServiceShare:GetNewDirBySwitchDirType(switchDirType, casterDirType)
  local newDir, newBodyArea
  if casterDirType == DirectionType.Up then
    if switchDirType == SwitchBodyAreaDirType.Right then
      newDir = Vector2(1, 0)
      newBodyArea = Vector2(-1, 0)
    elseif switchDirType == SwitchBodyAreaDirType.Left then
      newDir = Vector2(-1, 0)
      newBodyArea = Vector2(1, 0)
    elseif switchDirType == SwitchBodyAreaDirType.Turn then
      newDir = Vector2(0, -1)
      newBodyArea = Vector2(0, 1)
    end
  elseif casterDirType == DirectionType.Down then
    if switchDirType == SwitchBodyAreaDirType.Right then
      newDir = Vector2(-1, 0)
      newBodyArea = Vector2(1, 0)
    elseif switchDirType == SwitchBodyAreaDirType.Left then
      newDir = Vector2(1, 0)
      newBodyArea = Vector2(-1, 0)
    elseif switchDirType == SwitchBodyAreaDirType.Turn then
      newDir = Vector2(0, 1)
      newBodyArea = Vector2(0, -1)
    end
  elseif casterDirType == DirectionType.Left then
    if switchDirType == SwitchBodyAreaDirType.Right then
      newDir = Vector2(0, 1)
      newBodyArea = Vector2(0, -1)
    elseif switchDirType == SwitchBodyAreaDirType.Left then
      newDir = Vector2(0, -1)
      newBodyArea = Vector2(0, 1)
    elseif switchDirType == SwitchBodyAreaDirType.Turn then
      newDir = Vector2(1, 0)
      newBodyArea = Vector2(-1, 0)
    end
  elseif casterDirType == DirectionType.Right then
    if switchDirType == SwitchBodyAreaDirType.Right then
      newDir = Vector2(0, -1)
      newBodyArea = Vector2(0, 1)
    elseif switchDirType == SwitchBodyAreaDirType.Left then
      newDir = Vector2(0, 1)
      newBodyArea = Vector2(0, -1)
    elseif switchDirType == SwitchBodyAreaDirType.Turn then
      newDir = Vector2(-1, 0)
      newBodyArea = Vector2(1, 0)
    end
  end
  Log.fatal("SwitchType:", switchDirType, "DirType:", casterDirType, "NewDir:", newDir, "NewBodyArea:", newBodyArea)
  return newDir, {
    Vector2(0, 0),
    newBodyArea
  }
end

function UtilScopeCalcServiceShare:GetNightKingForwardSkillPos(casterEntity, casterPos)
  local dirType = self:GetEntityDirType(casterEntity)
  local leftPos, rightPos
  if dirType == DirectionType.Up then
    leftPos = Vector2(casterPos.x - 1, casterPos.y + 2)
    rightPos = Vector2(casterPos.x + 1, casterPos.y + 2)
  elseif dirType == DirectionType.Down then
    leftPos = Vector2(casterPos.x + 1, casterPos.y - 2)
    rightPos = Vector2(casterPos.x - 1, casterPos.y - 2)
  elseif dirType == DirectionType.Left then
    leftPos = Vector2(casterPos.x - 2, casterPos.y - 1)
    rightPos = Vector2(casterPos.x - 2, casterPos.y + 1)
  elseif dirType == DirectionType.Right then
    leftPos = Vector2(casterPos.x + 2, casterPos.y + 1)
    rightPos = Vector2(casterPos.x + 2, casterPos.y - 1)
  end
  return leftPos, rightPos
end

function UtilScopeCalcServiceShare:GetNewBodyAreaByDirType(dirType)
  local bodyArea
  if dirType == DirectionType.Up then
    bodyArea = Vector2(0, -1)
  elseif dirType == DirectionType.Left then
    bodyArea = Vector2(1, 0)
  elseif dirType == DirectionType.Down then
    bodyArea = Vector2(0, 1)
  elseif dirType == DirectionType.Right then
    bodyArea = Vector2(-1, 0)
  end
  return bodyArea
end

function UtilScopeCalcServiceShare:IsNewBodyAreaPosValidByDirType(casterPos, dirType)
  local bodyAreaPos = casterPos + self:GetNewBodyAreaByDirType(dirType)
  return not self:IsPosBlock(bodyAreaPos, BlockFlag.MonsterLand)
end

function UtilScopeCalcServiceShare:GetCurBoardMaxX()
  local svc = self._world:GetService("BoardLogic")
  return svc:GetCurBoardMaxX()
end

function UtilScopeCalcServiceShare:GetCurBoardMaxY()
  local svc = self._world:GetService("BoardLogic")
  return svc:GetCurBoardMaxY()
end

function UtilScopeCalcServiceShare:GetMinMaxGridXByGridY(y)
  local cBoard = self._world:GetBoardEntity():Board()
  return cBoard:GetMinMaxGridXByGridY(y)
end

function UtilScopeCalcServiceShare:GetMinMaxGridYByGridX(x)
  local cBoard = self._world:GetBoardEntity():Board()
  return cBoard:GetMinMaxGridYByGridX(x)
end

function UtilScopeCalcServiceShare:GetGridPossessedByTrapType(trapType)
  local tv2Grids = {}
  local globalTrapEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(globalTrapEntities) do
    if not e:HasDeadMark() then
      local cTrap = e:Trap()
      if cTrap:GetTrapType() == trapType then
        local bodyArea = e:BodyArea():GetArea()
        local v2GridPos = e:GetGridPosition()
        for _, v2Body in ipairs(bodyArea) do
          table.insert(tv2Grids, v2GridPos + v2Body)
        end
      end
    end
  end
  return tv2Grids
end

function UtilScopeCalcServiceShare:IsPosHasTrapByTrapID(pos, trapID)
  local utilData = self._world:GetService("UtilData")
  return utilData:IsPosHasTrapByTrapID(pos, trapID)
end

function UtilScopeCalcServiceShare:MonsterGetPosAroundSameTypePosList(pos, pieceType)
  local ret = {}
  local utilDataSvc = self._world:GetService("UtilData")
  local boardSvc = self._world:GetService("BoardLogic")
  local board = self._world:GetBoardEntity():Board()
  for x = -1, 1 do
    for y = -1, 1 do
      local newPos = Vector2(pos.x + x, pos.y + y)
      if (newPos.x ~= pos.x or newPos.y ~= pos.y) and utilDataSvc:IsValidPiecePos(newPos) and not boardSvc:IsPosBlock(newPos, BlockFlag.MonsterLand) and not utilDataSvc:IsPosHasSpTrap(newPos, TrapType.BadGrid) then
        local type = board:GetPieceType(newPos)
        if type == pieceType or type == PieceType.Any then
          table.insert(ret, newPos)
        end
      end
    end
  end
  return ret
end

function UtilScopeCalcServiceShare:GetStandardDirection8D(v2)
  local v = v2:Clone()
  if v.x > 0 then
    v.x = 1
  elseif v.x < 0 then
    v.x = -1
  end
  if 0 < v.y then
    v.y = 1
  elseif 0 > v.y then
    v.y = -1
  end
  return v
end

function UtilScopeCalcServiceShare:IsPosCanConvertGridElement(pos)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  return boardServiceLogic:GetCanConvertGridElement(pos)
end

function UtilScopeCalcServiceShare:CalcRangeByPickUpPosList(pickUpPosList)
  if #pickUpPosList < 2 then
    return nil
  end
  local centerPos = pickUpPosList[1]
  local dirPos = pickUpPosList[2]
  local dirType
  local step = 1
  local max, reverseMax
  if centerPos.x ~= dirPos.x then
    max = self:GetCurBoardMaxX()
    reverseMax = self:GetCurBoardMaxY()
    if centerPos.x > dirPos.x then
      dirType = DirectionType.Left
      step = -1
    elseif centerPos.x < dirPos.x then
      dirType = DirectionType.Right
    end
  elseif centerPos.y ~= dirPos.y then
    max = self:GetCurBoardMaxY()
    reverseMax = self:GetCurBoardMaxX()
    if centerPos.y > dirPos.y then
      dirType = DirectionType.Down
      step = -1
    elseif centerPos.y < dirPos.y then
      dirType = DirectionType.Up
    end
  end
  local ret = {}
  local edgeBegin = {}
  local invalidPos = {}
  local totalRange = {}
  for i = 0, max do
    for j = 1, reverseMax do
      local pos, prePos
      if dirType == DirectionType.Left or dirType == DirectionType.Right then
        pos = Vector2(centerPos.x + i * step, j)
        prePos = Vector2(centerPos.x + (i - 1) * step, j)
      elseif dirType == DirectionType.Up or dirType == DirectionType.Down then
        pos = Vector2(j, centerPos.y + i * step)
        prePos = Vector2(j, centerPos.y + i * step)
      end
      if self:IsValidPiecePos(pos) then
        if i == 0 then
          table.insert(edgeBegin, pos)
        end
        table.insert(totalRange, pos)
      end
      if self:IsValidPiecePos(pos) ~= PieceType.None and self:IsValidPiecePos(pos) ~= nil and self:IsPosCanConvertGridElement(pos) then
        table.insert(ret, pos)
        if self:IsValidPiecePos(prePos) == nil and i ~= 0 then
          table.insert(invalidPos, pos)
        end
      end
    end
  end
  return ret, dirType, edgeBegin, invalidPos, totalRange
end

function UtilScopeCalcServiceShare:CalcRangeByTrapCenter(param, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local tarpID = param[1]
  local scopeType = param[2]
  local trapServerLogic = self._world:GetService("TrapLogic")
  local centerPosList = trapServerLogic:FindTrapPosByTrapID(tarpID, false)
  local calc = SkillScopeCalculator:New(self)
  if table.count(centerPosList) == 0 then
    return SkillScopeResult:New(SkillScopeType.TrapCenterWithScope, casterPos, {}, {})
  end
  local scpoe_param = {}
  if table.count(param) >= 3 then
    scpoe_param = table.sub(param, 3, #param)
  end
  local attackRange, wholeRange = {}, {}
  for _, pos in ipairs(centerPosList) do
    local result = calc:ComputeScopeRange(scopeType, scpoe_param, pos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
    table.Vector2Append(attackRange, result:GetAttackRange(), attackRange)
    table.Vector2Append(wholeRange, result:GetWholeGridRange(), wholeRange)
  end
  local result = SkillScopeResult:New(SkillScopeType.TrapsCenterWithScope, casterPos, attackRange, wholeRange)
  return result
end

function UtilScopeCalcServiceShare:Monster2903501FindPlayer(dirType, casterPos, bodyArea)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  local boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  local maxLen, edgeLen
  local retRange = {}
  local off = 1
  if dirType == DirectionType.Up or dirType == DirectionType.Down then
    maxLen = boardMaxY
    edgeLen = boardMaxX
    if dirType == DirectionType.Down then
      off = -1
    end
  elseif dirType == DirectionType.Left or dirType == DirectionType.Right then
    maxLen = boardMaxX
    edgeLen = boardMaxY
    if dirType == DirectionType.Left then
      off = -1
    end
  end
  local bodyAreaOffSet = {}
  for _, v in ipairs(bodyArea) do
    local offset = Vector2(v.x + casterPos.x, v.y + casterPos.y)
    table.insert(bodyAreaOffSet, offset)
  end
  local j = 0
  for i = 2, maxLen, 2 do
    for _, v in ipairs(bodyAreaOffSet) do
      local newPos
      if dirType == DirectionType.Up or dirType == DirectionType.Down then
        newPos = Vector2(v.x, v.y + i * off)
      elseif dirType == DirectionType.Left or dirType == DirectionType.Right then
        newPos = Vector2(v.x + i * off, v.y)
      end
      if boardServiceLogic:IsValidPiecePos(newPos) and not table.Vector2Include(retRange, newPos) then
        table.insert(retRange, newPos)
      end
    end
    for o = -1 * j, j do
      for _, v in ipairs(bodyAreaOffSet) do
        local newPos
        if dirType == DirectionType.Up or dirType == DirectionType.Down then
          newPos = Vector2(v.x + o, v.y + i * off)
        elseif dirType == DirectionType.Left or dirType == DirectionType.Right then
          newPos = Vector2(v.x + i * off, v.y + o)
        end
        if boardServiceLogic:IsValidPiecePos(newPos) and not table.Vector2Include(retRange, newPos) then
          table.insert(retRange, newPos)
        end
      end
    end
    j = j + 1
  end
  return retRange
end

function UtilScopeCalcServiceShare:P2PAngleFreeLineRange(pos1, pos2, attackRange, wholeRange, bNoExtend, widthThreshold, forceSE)
  local pieceXYMap = self._world:GetService("BoardLogic").GridTiles
  local posOnLine = {}
  local casterX = pos1.x
  local casterY = pos1.y
  local pickupDistance = Vector2.Distance(pos2, pos1)
  local relativePickupPos = pos2 - pos1
  local relativePickupX = relativePickupPos.x
  local relativePickupY = relativePickupPos.y
  local a = relativePickupPos.x
  local b = relativePickupPos.y
  for x, tableY in pairs(pieceXYMap) do
    local relativeX = x - casterX
    for y, _ in pairs(tableY) do
      local relativeY = y - casterY
      local v2 = Vector2(x, y)
      local isPosValid = b * relativeX == a * relativeY
      isPosValid = isPosValid and 0 <= relativeX * relativePickupX and 0 <= relativeY * relativePickupY
      isPosValid = isPosValid and (not bNoExtend or pickupDistance >= Vector2.Distance(v2, pos1))
      if isPosValid then
        self:_P2PAFLR_InsertPos(v2, attackRange, wholeRange, posOnLine)
      end
    end
  end
  if forceSE then
    self:_P2PAFLR_InsertPos(pos1, attackRange, wholeRange, posOnLine)
    self:_P2PAFLR_InsertPos(pos2, attackRange, wholeRange, posOnLine)
  end
  for _, linePos in ipairs(posOnLine) do
    local disThreshold = Vector2.Distance(linePos, pos1) + widthThreshold
    local relativeLinePos = pos1 - linePos
    local a = relativeLinePos.x
    local b = relativeLinePos.y
    local sqrtLinePos = math.sqrt(a * a + b * b)
    local sqrt = sqrtLinePos * widthThreshold
    for x, tableY in pairs(pieceXYMap) do
      local relativeX = casterX - x
      for y, _ in pairs(tableY) do
        local relativeY = casterY - y
        local v2 = Vector2(x, y)
        local isPosValid = sqrt > math.abs(b * relativeX - a * relativeY)
        isPosValid = isPosValid and 0 <= relativeX * a and 0 <= relativeY * b
        isPosValid = isPosValid and (not bNoExtend or disThreshold > Vector2.Distance(v2, pos1))
        if isPosValid then
          if not table.Vector2Include(attackRange, v2) then
            table.insert(attackRange, v2)
          end
          if not table.Vector2Include(wholeRange, v2) then
            table.insert(wholeRange, v2)
          end
        end
      end
    end
  end
end

function UtilScopeCalcServiceShare:_P2PAFLR_InsertPos(pos, attackRange, wholeRange, posOnLine)
  if not table.icontains(attackRange, pos) then
    table.insert(attackRange, pos)
  end
  if not table.icontains(wholeRange, pos) then
    table.insert(wholeRange, pos)
  end
  if not table.icontains(posOnLine, pos) then
    table.insert(posOnLine, pos)
  end
end

function UtilScopeCalcServiceShare:SortTrapsByPos(checkIDList, target_pos, nearestForMultiGrid)
  local trap_group = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
  local trapIDList = {}
  for _, e in ipairs(trap_group:GetEntities()) do
    local trapID = e:TrapID():GetTrapID()
    if checkIDList then
      if table.icontains(checkIDList, trapID) then
        table.insert(trapIDList, e:GetID())
      end
    else
      table.insert(trapIDList, e:GetID())
    end
  end
  return self:SortTrapsListByPos(target_pos, trapIDList, nearestForMultiGrid)
end

function UtilScopeCalcServiceShare:SortTrapsListByPos(target_pos, trapIDList, nearestForMultiGrid)
  local utilData = self._world:GetService("UtilData")
  local distance_trap = {}
  for _, entityID in ipairs(trapIDList) do
    local e = self._world:GetEntityByID(entityID)
    local position = e:GridLocation().Position
    if utilData:IsValidPiecePos(position) then
      if nearestForMultiGrid then
        local pos = position
        local distance = Vector2.Distance(pos, target_pos)
        local tBodyArea = e:BodyArea():GetArea()
        for _, v2RelativeBody in ipairs(tBodyArea) do
          local v2 = v2RelativeBody + position
          local newDis = Vector2.Distance(v2, target_pos)
          if distance > newDis then
            distance = newDis
            pos = v2
          end
        end
        table.insert(distance_trap, {
          dis = distance,
          trap_e = e,
          pos = pos
        })
      else
        local distance = Vector2.Distance(position, target_pos)
        table.insert(distance_trap, {
          dis = distance,
          trap_e = e,
          pos = position
        })
      end
    end
  end
  
  local function get_index(c, p)
    if p.x - c.x == 0 and 0 < p.y - c.y then
      return 1
    end
    if p.x - c.x > 0 and 0 < p.y - c.y then
      return 2
    end
    if p.x - c.x > 0 and p.y - c.y == 0 then
      return 3
    end
    if p.x - c.x > 0 and 0 > p.y - c.y then
      return 4
    end
    if p.x - c.x == 0 and 0 > p.y - c.y then
      return 5
    end
    if p.x - c.x < 0 and 0 > p.y - c.y then
      return 6
    end
    if p.x - c.x < 0 and p.y - c.y == 0 then
      return 7
    end
    if p.x - c.x < 0 and 0 < p.y - c.y then
      return 8
    end
    return 1
  end
  
  local function cmp_fun(ele1, ele2)
    if ele1.dis == ele2.dis then
      return get_index(target_pos, ele1.pos) < get_index(target_pos, ele2.pos)
    else
      return ele1.dis < ele2.dis
    end
  end
  
  table.sort(distance_trap, cmp_fun)
  return distance_trap
end

function UtilScopeCalcServiceShare:SelectNearestTrapsOnPos(checkIDList, caster_pos, limit)
  if limit == -1 then
    local trap_group = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
    limit = #trap_group:GetEntities()
  end
  local traps = {}
  local trapIDs = {}
  local traps_pos = {}
  local distance_trap = self:SortTrapsByPos(checkIDList, caster_pos, true)
  local skillScopeTargetSelector = self._world:GetSkillScopeTargetSelector()
  for _, element in ipairs(distance_trap) do
    local trapEntity = element.trap_e
    if limit > #traps and not trapEntity:HasDeadMark() and skillScopeTargetSelector:SelectConditionFilter(trapEntity) then
      table.insert(traps, element.trap_e)
      table.insert(trapIDs, element.trap_e:GetID())
      table.insert(traps_pos, element.pos)
    end
  end
  return traps, traps_pos, trapIDs
end

function UtilScopeCalcServiceShare:GetNearestPosToCasterInPickMonster()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicPickUpCmpt = teamEntity:LogicPickUp()
  local petPstID = logicPickUpCmpt:GetLogicPetPstid()
  local entityID = logicPickUpCmpt:GetEntityID()
  if entityID == -1 then
    local utilDataSvc = self._world:GetService("UtilData")
    entityID = utilDataSvc:GetEntityIDByPstID(petPstID)
  else
  end
  local casterEntity = self._world:GetEntityByID(entityID)
  if casterEntity then
    local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
    if activeSkillPickUpComponent then
      local pickPos = activeSkillPickUpComponent:GetLastPickUpGridPos()
      local gridPosList = {pickPos}
      local targetSelector = self._world:GetSkillScopeTargetSelector()
      local skillScopeResult = SkillScopeResult:New(SkillScopeType.None, pickPos, gridPosList, gridPosList)
      local targetEntityIDList = targetSelector:DoSelectSkillTarget(casterEntity, SkillTargetType.Monster, skillScopeResult)
      if 0 < #targetEntityIDList then
        local targetID = targetEntityIDList[1]
        local monsterEntity = self._world:GetEntityByID(targetID)
        if monsterEntity then
          local area = monsterEntity:BodyArea():GetArea()
          local monsterPos = monsterEntity:GetGridPosition()
          local posList = {}
          for _, posArea in ipairs(area) do
            local pos = monsterPos + posArea
            table.insert(posList, pos)
          end
          local casterPos = casterEntity:GetGridPosition()
          local nearestPos
          local nearestDis = -1
          for index, checkPos in ipairs(posList) do
            local dis = math.abs(checkPos.x - casterPos.x) + math.abs(checkPos.y - casterPos.y)
            if nearestDis < 0 or nearestDis > dis then
              nearestDis = dis
              nearestPos = checkPos
            end
          end
          if nearestPos then
            return nearestPos
          end
        end
      end
    end
  end
end

function UtilScopeCalcServiceShare:PreviewGetNearestPosToCasterInPickMonster(casterEntity)
  if casterEntity then
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    if previewPickUpComponent then
      local pickPos = previewPickUpComponent:GetLastPickUpGridPos()
      local gridPosList = {pickPos}
      local targetSelector = self._world:GetSkillScopeTargetSelector()
      local skillScopeResult = SkillScopeResult:New(SkillScopeType.None, pickPos, gridPosList, gridPosList)
      local targetEntityIDList = targetSelector:DoSelectSkillTarget(casterEntity, SkillTargetType.Monster, skillScopeResult)
      if 0 < #targetEntityIDList then
        local targetID = targetEntityIDList[1]
        local monsterEntity = self._world:GetEntityByID(targetID)
        if monsterEntity then
          local area = monsterEntity:BodyArea():GetArea()
          local monsterPos = monsterEntity:GetGridPosition()
          local posList = {}
          for _, posArea in ipairs(area) do
            local pos = monsterPos + posArea
            table.insert(posList, pos)
          end
          local casterPos = casterEntity:GetGridPosition()
          local nearestPos
          local nearestDis = -1
          for index, checkPos in ipairs(posList) do
            local dis = math.abs(checkPos.x - casterPos.x) + math.abs(checkPos.y - casterPos.y)
            if nearestDis < 0 or nearestDis > dis then
              nearestDis = dis
              nearestPos = checkPos
            end
          end
          if nearestPos then
            return nearestPos
          end
        end
      end
    end
  end
end

function UtilScopeCalcServiceShare:GetPickUpMonsterPosCenterPos()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicPickUpCmpt = teamEntity:LogicPickUp()
  local petPstID = logicPickUpCmpt:GetLogicPetPstid()
  local entityID = logicPickUpCmpt:GetEntityID()
  if entityID == -1 then
    local utilDataSvc = self._world:GetService("UtilData")
    entityID = utilDataSvc:GetEntityIDByPstID(petPstID)
  else
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  local casterEntity = self._world:GetEntityByID(entityID)
  if casterEntity then
    local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
    if activeSkillPickUpComponent then
      local pickPosList = activeSkillPickUpComponent:GetAllValidPickUpGridPos()
      if #pickPosList == 1 then
        local firstCenterPos = self:_GetPickUpMonsterPos(casterEntity, pickPosList[1])
        if firstCenterPos then
          return {firstCenterPos}
        end
      elseif 1 < #pickPosList then
        local centerPos = {}
        for index, pickPos in ipairs(pickPosList) do
          local pickMonsterCenterPos = self:_GetPickUpMonsterPos(casterEntity, pickPos)
          if pickMonsterCenterPos then
            table.insert(centerPos, pickMonsterCenterPos)
          end
        end
        return centerPos
      end
    end
  end
end

function UtilScopeCalcServiceShare:PreviewGetPickUpMonsterPosCenterPos(casterEntity)
  if casterEntity then
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    if previewPickUpComponent then
      local pickPosList = previewPickUpComponent:GetAllValidPickUpGridPos()
      if #pickPosList == 1 then
        local firstCenterPos = self:_GetPickUpMonsterPos(casterEntity, pickPosList[1])
        if firstCenterPos then
          return {firstCenterPos}
        end
      elseif 1 < #pickPosList then
        local centerPos = {}
        for index, pickPos in ipairs(pickPosList) do
          local pickMonsterCenterPos = self:_GetPickUpMonsterPos(casterEntity, pickPos)
          if pickMonsterCenterPos then
            table.insert(centerPos, pickMonsterCenterPos)
          end
        end
        return centerPos
      end
    end
  end
end

function UtilScopeCalcServiceShare:GetPickUpMonsterPosAndCasterPosCenterPos()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicPickUpCmpt = teamEntity:LogicPickUp()
  local petPstID = logicPickUpCmpt:GetLogicPetPstid()
  local entityID = logicPickUpCmpt:GetEntityID()
  if entityID == -1 then
    local utilDataSvc = self._world:GetService("UtilData")
    entityID = utilDataSvc:GetEntityIDByPstID(petPstID)
  else
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  local casterEntity = self._world:GetEntityByID(entityID)
  if casterEntity then
    local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
    if activeSkillPickUpComponent then
      local pickPosList = activeSkillPickUpComponent:GetAllValidPickUpGridPos()
      if #pickPosList == 1 then
        local firstCenterPos = casterEntity:GetGridPosition()
        local secondCenterPos = self:_GetPickUpMonsterPos(casterEntity, pickPosList[1])
        if firstCenterPos and secondCenterPos then
          return {firstCenterPos, secondCenterPos}
        end
      elseif 1 < #pickPosList then
        local centerPos = {}
        for index, pickPos in ipairs(pickPosList) do
          local pickMonsterCenterPos = self:_GetPickUpMonsterPos(casterEntity, pickPos)
          if pickMonsterCenterPos then
            table.insert(centerPos, pickMonsterCenterPos)
          end
        end
        return centerPos
      end
    end
  end
end

function UtilScopeCalcServiceShare:PreviewGetPickUpMonsterPosAndCasterPosCenterPos(casterEntity)
  if casterEntity then
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    if previewPickUpComponent then
      local pickPosList = previewPickUpComponent:GetAllValidPickUpGridPos()
      if #pickPosList == 1 then
        local firstCenterPos = casterEntity:GetGridPosition()
        local secondCenterPos = self:_GetPickUpMonsterPos(casterEntity, pickPosList[1])
        if firstCenterPos and secondCenterPos then
          return {firstCenterPos, secondCenterPos}
        end
      elseif 1 < #pickPosList then
        local centerPos = {}
        for index, pickPos in ipairs(pickPosList) do
          local pickMonsterCenterPos = self:_GetPickUpMonsterPos(casterEntity, pickPos)
          if pickMonsterCenterPos then
            table.insert(centerPos, pickMonsterCenterPos)
          end
        end
        return centerPos
      end
    end
  end
end

function UtilScopeCalcServiceShare:_GetPickUpMonsterPos(casterEntity, pickPos)
  local gridPosList = {pickPos}
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local skillScopeResult = SkillScopeResult:New(SkillScopeType.None, pickPos, gridPosList, gridPosList)
  local targetEntityIDList = targetSelector:DoSelectSkillTarget(casterEntity, SkillTargetType.Monster, skillScopeResult)
  if 0 < #targetEntityIDList then
    local targetID = targetEntityIDList[1]
    local monsterEntity = self._world:GetEntityByID(targetID)
    if monsterEntity then
      local monsterPos = monsterEntity:GetGridPosition()
      return monsterPos
    end
  end
end

function UtilScopeCalcServiceShare:SortScopeRangeWithDir(scopeRange, dir)
  if not scopeRange or table.count(scopeRange) == 0 then
    return
  end
  table.sort(scopeRange, function(a, b)
    if dir == Vector2(0, -1) then
      if a.y == b.y then
        return a.x < b.x
      end
      return a.y > b.y
    elseif dir == Vector2(0, 1) then
      if a.y == b.y then
        return a.x < b.x
      end
      return a.y < b.y
    elseif dir == Vector2(-1, 0) then
      if a.x == b.x then
        return a.y < b.y
      end
      return a.x < b.x
    elseif dir == Vector2(-1, 0) then
      if a.x == b.x then
        return a.y < b.y
      end
      return a.x > b.x
    end
  end)
  return scopeRange
end

function UtilScopeCalcServiceShare:InsertValidPos(posList, pos)
  if self:IsValidPiecePos(pos) and not table.Vector2Include(posList, pos) then
    table.insert(posList, pos)
  end
end

function UtilScopeCalcServiceShare:CalcPickUpSingleLine(pickUpDir, casterPos)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local maxLen = boardServiceLogic:GetCurBoardMaxLen()
  local length = maxLen
  local pickDirScope = {}
  local pickNEGDirScope = {}
  for i = 1, length do
    if pickUpDir == HitBackDirectionType.RightDown then
      self:InsertValidPos(pickDirScope, Vector2(casterPos.x + i, casterPos.y - i))
      self:InsertValidPos(pickNEGDirScope, Vector2(casterPos.x - i, casterPos.y + i))
    elseif pickUpDir == HitBackDirectionType.LeftUp then
      self:InsertValidPos(pickDirScope, Vector2(casterPos.x - i, casterPos.y + i))
      self:InsertValidPos(pickNEGDirScope, Vector2(casterPos.x + i, casterPos.y - i))
    elseif pickUpDir == HitBackDirectionType.LeftDown then
      self:InsertValidPos(pickDirScope, Vector2(casterPos.x - i, casterPos.y - i))
      self:InsertValidPos(pickNEGDirScope, Vector2(casterPos.x + i, casterPos.y + i))
    elseif pickUpDir == HitBackDirectionType.RightUp then
      self:InsertValidPos(pickDirScope, Vector2(casterPos.x + i, casterPos.y + i))
      self:InsertValidPos(pickNEGDirScope, Vector2(casterPos.x - i, casterPos.y - i))
    elseif pickUpDir == HitBackDirectionType.Right then
      self:InsertValidPos(pickDirScope, Vector2(casterPos.x + i, casterPos.y))
      self:InsertValidPos(pickNEGDirScope, Vector2(casterPos.x - i, casterPos.y))
    elseif pickUpDir == HitBackDirectionType.Left then
      self:InsertValidPos(pickDirScope, Vector2(casterPos.x - i, casterPos.y))
      self:InsertValidPos(pickNEGDirScope, Vector2(casterPos.x + i, casterPos.y))
    elseif pickUpDir == HitBackDirectionType.Down then
      self:InsertValidPos(pickDirScope, Vector2(casterPos.x, casterPos.y - i))
      self:InsertValidPos(pickNEGDirScope, Vector2(casterPos.x, casterPos.y + i))
    elseif pickUpDir == HitBackDirectionType.Up then
      self:InsertValidPos(pickDirScope, Vector2(casterPos.x, casterPos.y + i))
      self:InsertValidPos(pickNEGDirScope, Vector2(casterPos.x, casterPos.y - i))
    end
  end
  return pickDirScope, pickNEGDirScope
end

function UtilScopeCalcServiceShare:PreviewGetNearestMonsterGridCenterPos(casterEntity)
  if not casterEntity then
    return
  end
  local retPos
  local casterPos = casterEntity:GetGridPosition()
  if self._world:MatchType() ~= MatchType.MT_BlackFist then
    local tMonsters, tMonsterPos
    local includeDead = true
    tMonsters, tMonsterPos = self:SelectNearestMonsterOnPos(casterPos, 1, includeDead)
    if tMonsters and 0 < #tMonsters then
      local targetEntity = tMonsters[1]
      local targetPos = tMonsterPos[1]
      if targetEntity then
        retPos = targetPos
      end
    end
  else
    if casterEntity:HasSuperEntity() then
      casterEntity = casterEntity:GetSuperEntity()
    elseif casterEntity:HasSummoner() then
      casterEntity = casterEntity:GetSummonerEntity()
    end
    if casterEntity:HasPet() then
      local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
      local enemyEntity = teamEntity:Team():GetEnemyTeamEntity()
      retPos = enemyEntity:GetGridPosition()
    end
  end
  return retPos
end

function UtilScopeCalcServiceShare:GetNearestMonsterGridCenterPos(casterPos)
  local retPos
  if self._world:MatchType() ~= MatchType.MT_BlackFist then
    local tMonsters, tMonsterPos
    local includeDead = true
    tMonsters, tMonsterPos = self:SelectNearestMonsterOnPos(casterPos, 1, includeDead)
    if tMonsters and 0 < #tMonsters then
      local targetEntity = tMonsters[1]
      local targetPos = tMonsterPos[1]
      if targetEntity then
        retPos = targetPos
      end
    end
  else
    local enemyEntity = self._world:Player():GetCurrentEnemyTeamEntity()
    retPos = enemyEntity:GetGridPosition()
  end
  return retPos
end

function UtilScopeCalcServiceShare:GetGridListCenterPos(gridList)
  table.sort(gridList, function(a, b)
    if a.x == b.x then
      return a.y > b.y
    elseif a.y == b.y then
      return a.x > b.x
    else
      return a.x > b.x
    end
  end)
  local centerIndex = #gridList / 2
  local centerPos
  if centerIndex == math.floor(centerIndex) then
    local pos1 = gridList[centerIndex]
    local pos2 = gridList[centerIndex + 1]
    centerPos = Vector2((pos1.x + pos2.x) / 2, (pos1.y + pos2.y) / 2)
  else
    centerIndex = math.floor(centerIndex + 0.5)
    centerPos = gridList[centerIndex]
  end
  return centerPos
end

function UtilScopeCalcServiceShare:GetPiecesExcludeBlockID(blockID)
  local boardSvc = self._world:GetService("BoardLogic")
  local utilDataSvc = self._world:GetService("UtilData")
  local posTable = {}
  local validPosList = self:GetAllValidGridPosList()
  local blockFlag = boardSvc:GetBlockFlagByBlockId(blockID)
  for _, pos in ipairs(validPosList) do
    if not utilDataSvc:IsPosBlock(pos, blockFlag) then
      table.insert(posTable, pos)
    end
  end
  return posTable
end

function UtilScopeCalcServiceShare:ExpandMaxChainSkillScope(casterEntity, skillID, scopeResult, playerGridPos)
  if casterEntity:SkillInfo():GetMaxChainSkillID() == skillID and casterEntity:BuffComponent():GetBuffValue("ExpandMaxChainSkillScope") then
    local playerBodyArea = casterEntity:BodyArea():GetArea()
    local dir = casterEntity:GridLocation():GetGridDir()
    local scopeType = casterEntity:BuffComponent():GetBuffValue("ExpandMaxChainSkillScopeType")
    local scopeParam = casterEntity:BuffComponent():GetBuffValue("ExpandMaxChainSkillScopeParam")
    local centerType = SkillScopeCenterType.CasterPos
    local nTargetType = SkillTargetType.Monster
    local scopeFilterParam = SkillScopeFilterParam.GenerateDefaultParam()
    local newScopeResult = self._skillScopeCalc:CalcSkillScopeWithParams(scopeType, scopeParam, centerType, nTargetType, scopeFilterParam, playerGridPos, dir, playerBodyArea, casterEntity)
    local expandRange = newScopeResult:GetAttackRange()
    table.Vector2Append(scopeResult._attackGridRange, expandRange, scopeResult._attackGridRange)
    table.Vector2Append(scopeResult._wholeGridRange, expandRange, scopeResult._wholeGridRange)
  end
end

function UtilScopeCalcServiceShare:GetPlayerPosAndFarthestMonsterGridPos()
  local retPosArray = {}
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  retPosArray[#retPosArray + 1] = playerPos
  local monsterPosArray = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local enemyEntity = teamEntity:Team():GetEnemyTeamEntity()
    monsterPosArray[1] = enemyEntity:GetGridPosition()
  else
    local skillScopeTargetSelector = self._world:GetSkillScopeTargetSelector()
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if not monsterEntity:HasDeadMark() and skillScopeTargetSelector:SelectConditionFilter(monsterEntity) then
        local pos = monsterEntity:GetGridPosition()
        local bodyAreaList = monsterEntity:BodyArea():GetArea()
        for _, offset in ipairs(bodyAreaList) do
          local tmpPos = pos + offset
          table.insert(monsterPosArray, tmpPos)
        end
      end
    end
  end
  if 0 < #monsterPosArray then
    local function fun(ele1, ele2)
      local dis1 = Vector2.Distance(playerPos, ele1)
      
      local dis2 = Vector2.Distance(playerPos, ele2)
      return dis1 > dis2
    end
    
    table.sort(monsterPosArray, fun)
    retPosArray[#retPosArray + 1] = monsterPosArray[1]
  end
  return retPosArray
end

function UtilScopeCalcServiceShare:GetFarthestMonsterGridPos(casterPos)
  local monsterPosArray = {}
  local retPos
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local enemyEntity = self._world:Player():GetCurrentEnemyTeamEntity()
    retPos = enemyEntity:GetGridPosition()
  else
    local skillScopeTargetSelector = self._world:GetSkillScopeTargetSelector()
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if not monsterEntity:HasDeadMark() and skillScopeTargetSelector:SelectConditionFilter(monsterEntity) then
        local pos = monsterEntity:GetGridPosition()
        table.insert(monsterPosArray, pos)
      end
    end
  end
  if 0 < #monsterPosArray then
    local function fun(ele1, ele2)
      local dis1 = Vector2.Distance(casterPos, ele1)
      
      local dis2 = Vector2.Distance(casterPos, ele2)
      return dis1 > dis2
    end
    
    table.sort(monsterPosArray, fun)
    retPos = monsterPosArray[1]
  end
  return retPos
end

function UtilScopeCalcServiceShare:PreviewGetFarthestMonsterGridCenterPos(casterEntity)
  if not casterEntity then
    return
  end
  local retPos
  local monsterPosArray = {}
  local casterPos = casterEntity:GetGridPosition()
  if self._world:MatchType() ~= MatchType.MT_BlackFist then
    local skillScopeTargetSelector = self._world:GetSkillScopeTargetSelector()
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if not monsterEntity:HasDeadMark() and skillScopeTargetSelector:SelectConditionFilter(monsterEntity) then
        local pos = monsterEntity:GetGridPosition()
        table.insert(monsterPosArray, pos)
      end
    end
  else
    if casterEntity:HasSuperEntity() then
      casterEntity = casterEntity:GetSuperEntity()
    elseif casterEntity:HasSummoner() then
      casterEntity = casterEntity:GetSummonerEntity()
    end
    if casterEntity:HasPet() then
      local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
      local enemyEntity = teamEntity:Team():GetEnemyTeamEntity()
      retPos = enemyEntity:GetGridPosition()
    end
  end
  if 0 < #monsterPosArray then
    local function fun(ele1, ele2)
      local dis1 = Vector2.Distance(casterPos, ele1)
      
      local dis2 = Vector2.Distance(casterPos, ele2)
      return dis1 > dis2
    end
    
    table.sort(monsterPosArray, fun)
    retPos = monsterPosArray[1]
  end
  return retPos
end
