_class("PlaySkillInstructionService", Object)
PlaySkillInstructionService = PlaySkillInstructionService

function PlaySkillInstructionService:Constructor(world)
  self._world = world
  self.m_listSummonFunction = {}
  self.m_listSummonFunction[SkillEffectEnum_SummonType.Monster] = self._SummonShow_Monster
  self.m_listSummonFunction[SkillEffectEnum_SummonType.Trap] = self._SummonShow_Trap
end

local RoleShowType = {
  TeleportHide = 3,
  TeleportMove = 5,
  TeleportShow = 6,
  BuffNotify = 9,
  Teleport2Sky = 10,
  TeleportHide2Sky = 11,
  TeleportMoveNoTurn = 12,
  TeleportHideTrap = 13
}
_enum("RoleShowType", RoleShowType)

function PlaySkillInstructionService:Teleport(TT, targetEntity, showType, onlySelf, teleportEffectResult)
  if targetEntity:HasTeam() then
    targetEntity = targetEntity:GetTeamLeaderPetEntity()
  end
  local trapServiceRender = self._world:GetService("TrapRender")
  if RoleShowType.TeleportHide == showType then
    local oldPos = teleportEffectResult:GetPosOld()
    local oldColor = teleportEffectResult:GetColorOld()
    self:_RoleShow(targetEntity, false, false)
    self:_RebuildGrid(TT, targetEntity, oldColor, 1, oldPos, SkillEffectType.Teleport)
    trapServiceRender:ShowHideTrapAtPos(oldPos, true)
  elseif RoleShowType.TeleportHide2Sky == showType then
    local oldPos = teleportEffectResult:GetPosOld()
    local oldColor = teleportEffectResult:GetColorOld()
    self:_RoleShow(targetEntity, false, false, true)
    self:_RebuildGrid(TT, targetEntity, oldColor, 1, oldPos, SkillEffectType.Teleport)
    trapServiceRender:ShowHideTrapAtPos(oldPos, true)
  elseif RoleShowType.TeleportMove == showType then
    self:_TeleportTargetPos(TT, targetEntity, teleportEffectResult, onlySelf)
  elseif RoleShowType.TeleportMoveNoTurn == showType then
    self:_TeleportTargetPos(TT, targetEntity, teleportEffectResult, onlySelf, true)
  elseif RoleShowType.Teleport2Sky == showType then
    self:_TeleportTarget2Sky(TT, targetEntity, teleportEffectResult, onlySelf)
    local oldPos = teleportEffectResult:GetPosOld()
    trapServiceRender:ShowHideTrapAtPos(oldPos, true)
  elseif RoleShowType.TeleportShow == showType then
    local newColor = teleportEffectResult:GetColorNew()
    local newPos = teleportEffectResult:GetPosNew()
    self:_RebuildGrid(TT, targetEntity, newColor, 0, newPos, SkillEffectType.Teleport)
    self:_RoleShow(targetEntity, true, true)
    trapServiceRender:ShowHideTrapAtPos(newPos, false)
    if targetEntity:HasMonsterID() then
      local trapIDList = teleportEffectResult:GetTriggerTrapIDList()
      local trapEntityList = {}
      for _, v in ipairs(trapIDList) do
        local trapEntity = self._world:GetEntityByID(v)
        trapEntityList[#trapEntityList + 1] = trapEntity
      end
      self:PlayTrapTrigger(TT, targetEntity, trapEntityList)
    end
    if targetEntity:HasPetPstID() or targetEntity:HasTeam() then
      local pieceService = self._world:GetService("Piece")
      pieceService:RemovePrismAt(newPos)
    end
  elseif RoleShowType.BuffNotify == showType then
    local oldPos = teleportEffectResult:GetPosOld()
    local newPos = teleportEffectResult:GetPosNew()
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTTeleport:New(targetEntity, oldPos, newPos))
  elseif RoleShowType.TeleportHideTrap == showType then
    local trapID = teleportEffectResult:GetNeedDelTrapEntityID()
    if trapID ~= 0 then
      local trap = self._world:GetEntityByID(trapID)
      if trap then
        trapServiceRender:PlayTrapDieSkill(TT, {trap}, 1)
      end
    end
  end
end

function PlaySkillInstructionService:_RoleShow(entityWork, bShowRole, bShowBloodSlider, noActiveModel)
  if not noActiveModel then
    entityWork:SetViewVisible(bShowRole)
  else
    entityWork:SetLocationHeight(1000)
  end
  local slider_entity_id = 0
  if entityWork:HasPetPstID() then
    local captainEntity = entityWork:Pet():GetOwnerTeamEntity()
    slider_entity_id = captainEntity:HP():GetHPSliderEntityID()
  else
    slider_entity_id = entityWork:HP():GetHPSliderEntityID()
  end
  local slider_entity = self._world:GetEntityByID(slider_entity_id)
  if slider_entity then
    slider_entity:SetViewVisible(bShowBloodSlider)
  end
end

function PlaySkillInstructionService:_SendNTGridConvertRender(TT, pos, pieceType, effectType)
  local playBuffSvc = self._world:GetService("PlayBuff")
  return playBuffSvc:_SendNTGridConvertRender(TT, pos, pieceType, effectType)
end

function PlaySkillInstructionService:_RebuildGrid(TT, entityWork, color, bLight, rebuildPos, effectType)
  local targetPos = entityWork:GetGridPosition()
  if entityWork:HasPetPstID() then
    local boardService = self._world:GetService("BoardRender")
    boardService:ReCreateGridEntity(color, rebuildPos)
    if bLight and 0 < bLight then
      self:_SendNTGridConvertRender(TT, rebuildPos, color, effectType)
    end
  else
    local pieceService = self._world:GetService("Piece")
    local renderEntityService = self._world:GetService("RenderEntity")
    if bLight and 0 < bLight then
      renderEntityService:DestroyMonsterAreaOutLineEntity(entityWork)
    else
      renderEntityService:DestroyMonsterAreaOutLineEntity(entityWork)
      renderEntityService:CreateMonsterAreaOutlineEntity(entityWork)
    end
    local utilDataService = self._world:GetService("UtilData")
    local bodyArea = entityWork:BodyArea():GetArea()
    for i = 1, #bodyArea do
      local posWork = targetPos + bodyArea[i]
      if utilDataService:IsValidPiecePos(posWork) then
        if bLight and 0 < bLight then
          pieceService:SetPieceAnimUp(posWork)
        else
          pieceService:SetPieceAnimDown(posWork)
        end
      end
    end
  end
end

function PlaySkillInstructionService:_TeleportTargetPos(TT, entityWork, skillResult, onlySelf, noTurn)
  if nil == entityWork then
    return
  end
  local posNew = skillResult:GetPosNew()
  if nil == posNew then
    return
  end
  local dirNew = skillResult:GetDirNew()
  local casterDir
  if dirNew then
    casterDir = dirNew
  else
    casterDir = entityWork:GridLocation().Direction
  end
  local posOld = skillResult:GetPosOld()
  local bOnlyWorkEntity = false
  if entityWork:HasPetPstID() then
    local teamEntity = entityWork:Pet():GetOwnerTeamEntity()
    local isPetActiveSkill = skillResult:GetTeleportResult_IsPetActiveSkill()
    if isPetActiveSkill then
      bOnlyWorkEntity = false
    else
      bOnlyWorkEntity = onlySelf or false
    end
    entityWork:SetLocation(posNew, casterDir)
    teamEntity:SetLocation(posNew, casterDir)
    local utilDataSvc = self._world:GetService("UtilData")
    if utilDataSvc:CanChangePieceToGray() then
      local boardServiceRender = self._world:GetService("BoardRender")
      boardServiceRender:ReCreateGridEntity(PieceType.None, posNew)
    end
  else
    bOnlyWorkEntity = true
    if noTurn then
      entityWork:SetPosition(posNew + entityWork:GetGridOffset())
    else
      entityWork:SetLocation(posNew + entityWork:GetGridOffset(), casterDir)
    end
  end
  if not bOnlyWorkEntity then
    local teamEntity = entityWork:Pet():GetOwnerTeamEntity()
    for i, petEntity in ipairs(teamEntity:Team():GetTeamPetEntities()) do
      petEntity:SetLocation(posNew, casterDir)
    end
  end
end

function PlaySkillInstructionService:_TeleportTarget2Sky(TT, entityWork, skillResult, onlySelf)
  if nil == entityWork then
    return
  end
  if entityWork:HasMonsterID() then
    local oldPos = skillResult:GetPosOld()
    local pieceService = self._world:GetService("Piece")
    local entityRenderService = self._world:GetService("RenderEntity")
    entityRenderService:DestroyMonsterAreaOutLineEntity(entityWork)
    local bodyArea = entityWork:BodyArea():GetArea()
    for i = 1, #bodyArea do
      local posWork = oldPos + bodyArea[i]
      pieceService:SetPieceAnimUp(posWork)
    end
    local newPos = skillResult:GetPosNew()
    entityWork:SetPosition(newPos)
  end
end

function PlaySkillInstructionService:PlayTrapTrigger(TT, entityWork, listTrapTrigger)
  if not listTrapTrigger or table.count(listTrapTrigger) <= 0 then
    return
  end
  local sTrapRender = self._world:GetService("TrapRender")
  local listTaskReturn = {}
  for _, e in ipairs(listTrapTrigger) do
    local listTaskID = sTrapRender:PlayTrapTriggerSkill(TT, e, false, entityWork)
    table.appendArray(listTaskReturn, listTaskID)
  end
  return listTaskReturn
end

function PlaySkillInstructionService:GridConvert(TT, entityCaster, gridPos, dataSource, dataUser, notRefreshPrism)
  local skillEffectResultContainer = entityCaster:SkillRoutine():GetResultContainer()
  local nNewGridType
  local flushTraps = {}
  if 0 == dataSource then
    nNewGridType = dataUser or PieceType.None
  elseif SkillEffectType.ResetGridElement == dataSource then
    local skillResultArray = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ResetGridElement)
    if skillResultArray then
      nNewGridType = skillResultArray:FindGridDataNew(gridPos)
      flushTraps = skillResultArray:GetFlushTrapsAt(gridPos)
    end
  elseif SkillEffectType.ConvertGridElement == dataSource then
    local convertResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ConvertGridElement)
    if convertResult then
      nNewGridType = convertResult:GetTargetElementType()
    end
  elseif SkillEffectType.ManualConvert == dataSource then
    local convertResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ManualConvert)
    if convertResult then
      nNewGridType = convertResult:GetTargetElementType()
    end
  end
  if nNewGridType and nNewGridType >= PieceType.None and nNewGridType <= PieceType.Any then
    local boardService = self._world:GetService("BoardRender")
    local svcPlayBuff = self._world:GetService("PlayBuff")
    local pieceSvc = self._world:GetService("Piece")
    local nOldGridType = PieceType.None
    local gridEntity = pieceSvc:FindPieceEntity(gridPos)
    local pieceCmpt = gridEntity:Piece()
    nOldGridType = pieceCmpt:GetPieceType()
    local newGridEntity = boardService:ReCreateGridEntity(nNewGridType, gridPos, false, false, notRefreshPrism)
    if newGridEntity then
      pieceSvc:SetPieceEntityAnimNormal(newGridEntity)
    end
    local tConvertInfo = {}
    local convertInfo = NTGridConvert_ConvertInfo:New(gridPos, nOldGridType, nNewGridType)
    table.insert(tConvertInfo, convertInfo)
    local notify = NTGridConvert:New(entityCaster, tConvertInfo)
    notify:SetConvertEffectType(dataSource)
    notify.__attackPosMatchRequired = true
    svcPlayBuff:PlayBuffView(TT, notify)
  end
  local trapServiceRender = self._world:GetService("TrapRender")
  for _, trap in ipairs(flushTraps) do
    trapServiceRender:DestroyTrap(TT, trap)
  end
end

function PlaySkillInstructionService:ShowSummonAction(TT, world, resultSummon)
  if nil == resultSummon then
    return
  end
  local nSummonType = resultSummon:GetSummonType()
  local pFunction = self.m_listSummonFunction[nSummonType]
  if nil == pFunction then
    return
  end
  local nSummonID = resultSummon:GetSummonID()
  if nil == nSummonID then
    return
  end
  local posSummon = resultSummon:GetSummonPos()
  local posCenter = resultSummon:GetPosCenter()
  pFunction(self, TT, world, resultSummon, posCenter, posSummon, nSummonID)
end

function PlaySkillInstructionService:_SummonShow_Monster(TT, world, resultSummon, posCenter, posSummon, nSummonID)
  if nil == posSummon then
    return nil
  end
  local summonMonsterData = resultSummon:GetMonsterData()
  local summonTransformData = resultSummon:GetSummonTransformData()
  local summonFromCage = resultSummon:GetRenderIsFromCage()
  local eMonsters = {}
  local eHPs = {}
  local monsterIds = {}
  local entityWork = world:GetEntityByID(summonMonsterData.m_entityWorkID)
  table.insert(eMonsters, entityWork)
  table.insert(eHPs, summonMonsterData.m_entityHp)
  table.insert(monsterIds, summonMonsterData.m_nMonsterID)
  local sMonsterShowRender = world:GetService("MonsterShowRender")
  local taskID
  if summonFromCage then
    local fromCageParam = resultSummon:GetRenderFromCageParam()
    taskID = TaskManager:GetInstance():CoreGameStartTask(sMonsterShowRender.ShowSummonMonsterFromCage, sMonsterShowRender, entityWork, summonTransformData, nil, fromCageParam)
  else
    taskID = TaskManager:GetInstance():CoreGameStartTask(sMonsterShowRender.ShowSummonMonster, sMonsterShowRender, entityWork, summonTransformData)
  end
  while not HelperProxy:GetInstance():IsTaskFinished(taskID) do
    YIELD(TT)
  end
  return eMonsters
end

function PlaySkillInstructionService:_SummonShow_Trap(TT, world, resultSummon, posCenter, posSummon, nSummonID)
  if nil == posSummon then
    return nil
  end
  local summonMonsterData = resultSummon:GetTrapData()
  local trapEntity = world:GetEntityByID(summonMonsterData.m_entityWorkID)
  trapEntity:SetPosition(posSummon)
  local trapServiceRender = world:GetService("TrapRender")
  trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
end

function PlaySkillInstructionService:PlayAttackAudio(waitTime, casterEntity, audioID)
  local taskID = TaskManager:GetInstance():CoreGameStartTask(self._PlayAttackAudio, self, waitTime, casterEntity, audioID)
  return taskID
end

function PlaySkillInstructionService:_PlayAttackAudio(TT, waitTime, casterEntity, audioID)
  if waitTime and 0 < waitTime then
    YIELD(TT, waitTime)
  end
  if audioID then
    local playingID = AudioHelperController.PlayInnerGameSfx(audioID)
    local effectCpmt = casterEntity:EffectHolder()
    if not effectCpmt then
      casterEntity:AddEffectHolder()
      effectCpmt = casterEntity:EffectHolder()
    end
    effectCpmt:AttachAudioID(audioID, playingID)
  end
end

function PlaySkillInstructionService:PlayEntityMove(TT, entity, oldPos, newPos, speed)
  local boardServiceRender = self._world:GetService("BoardRender")
  self:StartMoveAnimation(entity, true)
  if entity:HasMonsterID() then
    boardServiceRender:RefreshPiece(entity, true, true)
  end
  local curPos = boardServiceRender:GetRealEntityGridPos(entity)
  entity:AddGridMove(speed, newPos, curPos)
  local walkDir = newPos - curPos
  entity:SetDirection(walkDir)
  while entity:HasGridMove() do
    YIELD(TT)
  end
  self:StartMoveAnimation(entity, false)
  if entity:HasMonsterID() then
    boardServiceRender:RefreshPiece(entity, false, true)
  end
end

function PlaySkillInstructionService:GetMoveSpeed(casterEntity)
  local cfgSvc = self._world:GetService("Config")
  local configData = cfgSvc:GetMonsterConfigData()
  local monsterIDCmpt = casterEntity:MonsterID()
  local monsterID = monsterIDCmpt:GetMonsterID()
  local speed = configData:GetMonsterSpeed(monsterID)
  speed = speed or 1
  return speed
end

function PlaySkillInstructionService:StartMoveAnimation(targetEntity, isMove)
  local curVal = targetEntity:GetAnimatorControllerBoolsData("Move")
  if curVal ~= isMove then
    targetEntity:SetAnimatorControllerBools({Move = isMove})
  end
end

function PlaySkillInstructionService:PlayArrivePosTriggerTrap(TT, monsterEntity, pos, trapResList)
  for _, v in ipairs(trapResList) do
    local walkTrapRes = v
    local trapEntityID = walkTrapRes:GetTrapEntityID()
    local trapEntity = self._world:GetEntityByID(trapEntityID)
    local trapSkillRes = walkTrapRes:GetTrapResult()
    local skillEffectResultContainer = trapSkillRes:GetResultContainer()
    trapEntity:SkillRoutine():SetResultContainer(skillEffectResultContainer)
    Log.debug("[AIMove] PlayArrivePos() monster=", monsterEntity:GetID(), " pos=", pos, " play trapid=", trapEntity:GetID(), " defender=", skillEffectResultContainer:GetScopeResult():GetTargetIDs()[1])
    local trapSvc = self._world:GetService("TrapRender")
    trapSvc:PlayTrapTriggerSkill(TT, trapEntity, false, monsterEntity)
  end
end
