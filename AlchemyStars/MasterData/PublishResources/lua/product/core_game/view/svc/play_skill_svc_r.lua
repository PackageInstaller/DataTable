_class("PlaySkillService", BaseService)
PlaySkillService = PlaySkillService

function PlaySkillService:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._hitBackSpeed = 10
  self._finalEffectEntity = nil
  self._curLoopAudioPlayingID = nil
  self:RegistSkillPhaseFunc(world)
  self.m_listWaitTask = {}
  self._skillViewConditionHelper = SkillViewConditionHelper:New(self._world)
end

function PlaySkillService:GetSkillViewConditionHelper()
  return self._skillViewConditionHelper
end

function PlaySkillService:SetTargetDirection(entity, dir)
  if self:CheckSourceCanTurn(entity) then
    entity:SetDirection(dir)
  end
end

function PlaySkillService:CheckSourceCanTurn(source_entity)
  local trapRenderCmpt = source_entity:TrapRender()
  if trapRenderCmpt then
    return false
  end
  local buff = source_entity:BuffView()
  if buff and buff:HasBuffEffect(BuffEffectType.Stun) then
    return false
  end
  if source_entity:HasTeam() then
    source_entity = source_entity:GetTeamLeaderPetEntity()
  end
  local cfgsvc = self._world:GetService("Config")
  if source_entity:HasMonsterID() then
    local mstcfg = cfgsvc:GetMonsterConfigData()
    local utilData = self._world:GetService("UtilData")
    local buffVal = utilData:GetEntityBuffValue(source_entity, "MONSTER_VIEW_CAN_TURN")
    if buffVal == nil then
      local cMonsterID = source_entity:MonsterID()
      if not mstcfg:CanTurn(cMonsterID:GetMonsterID()) then
        return false
      end
    elseif buffVal == 0 then
      return false
    end
  end
  if not source_entity:Location() then
    return false
  end
  return true
end

function PlaySkillService:StartSkillRoutine(casterEntity, skillPhaseArray, skillId)
  if GameGlobal.GetModule(SkillPerfModule):IsPerfCoreGame() then
    GameGlobal.GetModule(SkillPerfModule):SetSkillState(true, skillId)
  end
  local taskid = GameGlobal.TaskManager():CoreGameStartTask(self._SkillRoutineTask, self, casterEntity, skillPhaseArray, skillId)
  self:AddWaitFreeTask(taskid)
  return taskid
end

function PlaySkillService:_SkillRoutineTask(TT, casterEntity, skillPhaseArray, skillId)
  if casterEntity:EntityType():IsSkillHolder() then
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTBuffCastSkillAttackBegin:New(casterEntity, skillId))
  end
  Log.notice("[skill] SkillRoutineTask start ", skillId, " Coroutine:", TaskManager:GetInstance().curTask.id)
  local phaseCount = #skillPhaseArray
  if phaseCount < 1 then
    Log.notice("phase count is ", phaseCount, Log.traceback())
    return
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local director = SkillPhaseDirectorBase:New(self._world)
  director:DoPlaySkillPhase(TT, casterEntity, skillPhaseArray, self._phaseFuncDic)
  if casterEntity:HasMonsterID() then
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTMonsterAttackOrSkillDamageEnd:New(casterEntity))
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTMonsterSkillDamageEnd:New(casterEntity, skillId))
  end
  if casterEntity:EntityType():IsSkillHolder() then
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTBuffCastSkillAttackEnd:New(casterEntity, skillId))
  end
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTBuffLogicCastSkillCalcEffectEnd:New(casterEntity, skillId))
  Log.notice("[skill] SkillRoutineTask End ", skillId, " Coroutine: ", TaskManager:GetInstance().curTask.id)
end

function PlaySkillService:_doSkillPosDirProc(casterEntity, PhaseData)
  local posDirParam = PhaseData:GetPosDirParam()
  local gridlocation = casterEntity:GridLocation()
  local srcPos = gridlocation:GetGridPos()
  local srcDir = gridlocation:GetGridDir()
  if posDirParam ~= nil then
    local targetPos = srcPos
    local targetDir = srcDir
    if posDirParam:GetPos() ~= nil then
      targetPos = posDirParam:GetPos()
    end
    if posDirParam:GetDir() ~= nil then
      targetDir = posDirParam:GetDir()
    end
    casterEntity:SetLocation(targetPos, targetDir)
    return srcPos, srcDir
  else
    return nil, nil
  end
end

function PlaySkillService:_SingleGridEffect(TT, gridEffectID, gridPos, bestEffectTime, targetGridType, bForbidFreshAll)
  local boardService = self._world:GetService("BoardRender")
  self._world:GetService("Effect"):CreateWorldPositionEffect(gridEffectID, gridPos)
  YIELD(TT, bestEffectTime)
  boardService:ReCreateGridEntity(targetGridType, gridPos, false)
  YIELD(TT)
  local piece_service = self._world:GetService("Piece")
  if piece_service then
    if nil == bForbidFreshAll or false == bForbidFreshAll then
      piece_service:RefreshPieceAnim()
    else
      local piecePos = Vector2.New(gridPos.x, gridPos.y)
      piece_service:SetPieceAnimNormal(piecePos)
    end
  end
end

local OutlineDirType = {
  Up = 1,
  Down = 2,
  Left = 3,
  Right = 4,
  LeftUp = 5,
  RightUp = 6,
  RightDown = 7,
  LeftDown = 8
}
local OutlineType = {
  Short = 1,
  LeftShort = 2,
  RightShort = 3,
  Long = 4
}

function PlaySkillService:_SetOutlineEntityPosAndDir(pos, outlineEntity, outlineDirType)
  local gridOutlineRadius = 0.52
  local outlinePos = pos
  local outlineDir = Vector2(0, 0)
  if outlineDirType == OutlineDirType.Up then
    outlinePos = pos + Vector2(0, gridOutlineRadius)
    outlineDir = Vector2(0, 1)
  elseif outlineDirType == OutlineDirType.Down then
    outlinePos = pos + Vector2(0, -gridOutlineRadius)
    outlineDir = Vector2(0, -1)
  elseif outlineDirType == OutlineDirType.Left then
    outlinePos = pos + Vector2(-gridOutlineRadius, 0)
    outlineDir = Vector2(-1, 0)
  elseif outlineDirType == OutlineDirType.Right then
    outlinePos = pos + Vector2(gridOutlineRadius, 0)
    outlineDir = Vector2(1, 0)
  end
  outlineEntity:SetLocation(outlinePos, outlineDir)
end

function PlaySkillService:FreezeFrame(targetEntity)
  local targetViewCmpt = targetEntity:View()
  if targetViewCmpt == nil then
    return
  end
  local targetObj = targetViewCmpt:GetGameObject()
  local targetAttachPoint = self:GetEntityRenderHitTransform(targetEntity)
  if targetAttachPoint == nil then
    Log.fatal("not hit attach point", targetObj.name)
    return
  end
  local targetPos = targetAttachPoint.position
  local finalEffectEntity = self:GetFinalEffect()
  if not finalEffectEntity then
    Log.fatal("not find final effect")
    return
  end
  local viewCmpt = finalEffectEntity:View()
  if viewCmpt ~= nil then
    local viewObj = viewCmpt:GetGameObject()
    viewObj:SetActive(true)
    viewObj.transform.position = targetPos
    GameGlobal.TaskManager():CoreGameStartTask(self._WaitFreezeEnd, self)
  end
end

function PlaySkillService:_WaitFreezeEnd(TT)
  YIELD(TT, BattleConst.FreezeDuration)
  local finalEffectEntity = self:GetFinalEffect()
  local viewCmpt = finalEffectEntity:View()
  if viewCmpt ~= nil then
    local viewObj = viewCmpt:GetGameObject()
    viewObj:SetActive(false)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, true)
end

function PlaySkillService:ShowCasterEntity(casterEntityID)
  if self._world:MatchType() == MatchType.MT_PopStar then
    return
  end
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  if casterEntity:HasView() == false then
    Log.fatal("_ShowCasterEntity not has view")
    return
  end
  local viewCmpt = casterEntity:View()
  local gameObj = viewCmpt:GetGameObject()
  if gameObj == nil then
    Log.fatal("_ShowCasterEntity game obj is null")
    return
  end
  if casterEntity:HasPetPstID() then
    local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    local pets = teamEntity:Team():GetTeamPetEntities()
    for _, e in ipairs(pets) do
      if e:GetID() == casterEntity:GetID() then
        e:SetViewVisible(true)
      else
        e:SetViewVisible(false)
      end
    end
    local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
    local playerGridLocationCmpt = teamLeaderEntity:Location()
    local utilData = self._world:GetService("UtilData")
    if not utilData:PlayerIsDead(teamEntity) then
      casterEntity:SetLocation(playerGridLocationCmpt.Position:Clone(), playerGridLocationCmpt.Direction:Clone())
    end
  end
end

function PlaySkillService:ShowPlayerEntity(teamEntity)
  if self._world:MatchType() == MatchType.MT_PopStar then
    return
  end
  local teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
  self:ShowCasterEntity(teamLeaderEntityID)
end

function PlaySkillService:HandleBeHit(TT, param)
  local casterEntity = param:GetHandleBeHitParam_CasterEntity()
  local targetEntity = param:GetHandleBeHitParam_TargetEntity()
  local hitAnimName = param:GetHandleBeHitParam_HitAnimName()
  local hitEffectID = param:GetHandleBeHitParam_HitEffectID()
  local damageInfo = param:GetHandleBeHitParam_DamageInfo()
  local damageTextPos = param:GetHandleBeHitParam_DamagePos()
  local hitTurnTarget = param:GetHandleBeHitParam_HitTurnTarget()
  local deathClear = param:GetHandleBeHitParam_DeathClear()
  local isFinalHit = param:GetHandleBeHitParam_IsFinalHit()
  local skillID = param:GetHandleBeHitParam_SkillID()
  local hitBackSpeed = param:GetHandleBeHitParam_HitBackSpeed()
  local damageIndex = param:GetHandleBeHitParam_DamageIndex()
  local isPlayHitBack = param:GetHandleBeHitParam_PlayHitBack()
  local isHitBackUseDamageIndex = param:IsHandleBeHitParam_HitBackUseDamageIndex()
  local isHitBackUseDamagePos = param:IsHandleBeHitParam_HitBackUseDamagePos()
  local hitCasterEntity = param:GetHandleBeHitParam_HitCasterEntity() or casterEntity
  if not targetEntity then
    return
  end
  local defenderHPMaster, defenderEntity
  if targetEntity:HasTeam() then
    defenderHPMaster = targetEntity
    defenderEntity = targetEntity:GetTeamLeaderPetEntity()
  else
    defenderHPMaster = targetEntity
    defenderEntity = targetEntity
  end
  local attackPos = damageInfo:GetAttackPos()
  attackPos = attackPos or casterEntity:GetRenderGridPosition()
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:_OnAttackStart(TT, skillID, casterEntity, targetEntity, attackPos, damageTextPos, damageInfo)
  if isFinalHit then
    local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
    local finalAttackEntityID = skillEffectResultContainer:GetFinalAttackEntityID()
    if finalAttackEntityID then
      if finalAttackEntityID == targetEntity:GetID() then
        self:FreezeFrame(targetEntity)
      end
    else
      self:FreezeFrame(targetEntity)
    end
  end
  local bEnabelDeathClear = false
  if deathClear then
    if type(deathClear) == "boolean" then
      bEnabelDeathClear = deathClear
    elseif type(deathClear) == "number" and 0 < deathClear then
      bEnabelDeathClear = true
    end
  end
  if bEnabelDeathClear and (nil == defenderHPMaster or 0 >= defenderHPMaster:GetWhiteHP()) then
    return
  end
  if hitTurnTarget == nil then
    hitTurnTarget = TurnToTargetType.Caster
  end
  if hitTurnTarget ~= TurnToTargetType.None then
    local resvc = self._world:GetService("RenderEntity")
    resvc:TurnToTarget(defenderHPMaster, casterEntity, nil, nil, hitTurnTarget)
  end
  self:_OnPlayHitAnim(targetEntity, defenderEntity, damageInfo, hitAnimName)
  self:_OnPlayHitEffect(TT, casterEntity, defenderEntity, damageInfo, skillID, hitEffectID, damageTextPos, hitTurnTarget, hitCasterEntity)
  local trapRenderCmpt = targetEntity:TrapRender()
  if trapRenderCmpt then
    local hitSkillId = trapRenderCmpt:GetHitSkillID()
    if hitSkillId and 0 < hitSkillId and 0 < damageInfo:GetDamageValue() then
      local playSkillService = self._world:GetService("PlaySkill")
      local tskId = playSkillService:PlaySkillView(targetEntity, hitSkillId)
    end
  end
  local playDamageService = self._world:GetService("PlayDamage")
  local showType = playDamageService:SingleOrGrid(skillID)
  damageInfo:SetRenderGridPos(damageTextPos)
  damageInfo:SetShowType(showType)
  playDamageService:AsyncUpdateHPAndDisplayDamage(targetEntity, damageInfo, damageTextPos)
  self:_ShowCombo(casterEntity, targetEntity, damageInfo)
  self:_OnPlayAddBuff(TT, casterEntity, targetEntity, damageInfo)
  if isPlayHitBack then
    local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
    local hitbackResult = skillEffectResultContainer:GetEffectResultByTargetID(SkillEffectType.HitBack, defenderHPMaster:GetID())
    if isHitBackUseDamageIndex then
      hitbackResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.HitBack, damageIndex)
    elseif isHitBackUseDamagePos then
      local resultList = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.HitBack)
      if resultList then
        for index, result in ipairs(resultList) do
          local hitStartPos = result:GetStartPos()
          if not result:GetHadPlay() and hitStartPos == damageTextPos then
            hitbackResult = result
            break
          end
        end
      end
    end
    local processHitTaskID
    if hitbackResult and not targetEntity:HasHitback() and not hitbackResult:GetHadPlay() then
      hitbackResult:SetHadPlay(true)
      processHitTaskID = self:ProcessHit(casterEntity, targetEntity, hitbackResult, hitBackSpeed)
    end
    if processHitTaskID then
      while not TaskHelper:GetInstance():IsTaskFinished(processHitTaskID) do
        YIELD(TT)
      end
    end
    YIELD(TT)
    if hitbackResult then
      local pieceService = self._world:GetService("Piece")
      pieceService:RemovePrismAt(hitbackResult:GetPosTarget())
    end
  end
  if bEnabelDeathClear and 0 >= targetEntity:GetWhiteHP() then
    local nTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._ClearDeathBody, self, casterEntity, targetEntity)
    self:AddWaitFreeTask(nTaskID)
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:_OnAttackEnd(TT, skillID, casterEntity, targetEntity, attackPos, damageTextPos, damageIndex, damageInfo)
  local nTaskID = GameGlobal.TaskManager():CoreGameStartTask(self.PlayHitTrap, self, casterEntity, targetEntity)
  self:AddWaitFreeTask(nTaskID)
end

function PlaySkillService:HandleBeHitMultiStage(TT, casterEntity, targetEntity, hitAnimName, hitEffectID, damageInfoList, damageTextPos, hitTurnTarget, isFinalHit, skillID, damageStageValueList, intervalTime)
  if not targetEntity then
    return
  end
  local listTask = {}
  local damageInfo = damageInfoList[1]
  local multiStageCount = table.count(damageInfoList)
  local defenderHPMaster, defenderEntity
  if targetEntity:HasTeam() then
    defenderHPMaster = targetEntity
    defenderEntity = targetEntity:GetTeamLeaderPetEntity()
  else
    defenderHPMaster = targetEntity
    defenderEntity = targetEntity
  end
  local attackPos = casterEntity:GetRenderGridPosition()
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:_OnAttackStart(TT, skillID, casterEntity, targetEntity, attackPos, damageTextPos, damageInfo)
  local freezeFrame = false
  if isFinalHit then
    local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
    local finalAttackEntityID = skillEffectResultContainer:GetFinalAttackEntityID()
    if finalAttackEntityID then
      if finalAttackEntityID == targetEntity:GetID() then
        freezeFrame = true
      end
    else
      freezeFrame = true
    end
  end
  if freezeFrame then
    local nTask = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      YIELD(TT, intervalTime * (multiStageCount - 1))
      self:FreezeFrame(targetEntity)
    end)
    table.insert(listTask, nTask)
  end
  if hitTurnTarget == nil then
    hitTurnTarget = true
  end
  if hitTurnTarget then
    local resvc = self._world:GetService("RenderEntity")
    resvc:TurnToTarget(defenderHPMaster, casterEntity)
  end
  local defenderHPMaster, defenderEntity
  if targetEntity:HasTeam() then
    defenderHPMaster = targetEntity
    defenderEntity = targetEntity:GetTeamLeaderPetEntity()
  else
    defenderHPMaster = targetEntity
    defenderEntity = targetEntity
  end
  local nTaskHitAnim = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    for i = 1, multiStageCount do
      self:_OnPlayHitAnim(targetEntity, defenderEntity, damageInfo, hitAnimName)
      YIELD(TT, intervalTime)
    end
  end)
  table.insert(listTask, nTaskHitAnim)
  if hitEffectID then
    local nTaskPlayHitEffect = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      for i = 1, multiStageCount do
        self:_OnPlayHitEffect(TT, casterEntity, defenderEntity, damageInfo, skillID, hitEffectID, damageTextPos)
        YIELD(TT, intervalTime)
      end
    end)
    table.insert(listTask, nTaskPlayHitEffect)
  end
  local trapRenderCmpt = targetEntity:TrapRender()
  if trapRenderCmpt then
    local hitSkillId = trapRenderCmpt:GetHitSkillID()
    if hitSkillId and 0 < hitSkillId and 0 < damageInfo:GetDamageValue() then
      local playSkillService = self._world:GetService("PlaySkill")
      local tskId = playSkillService:PlaySkillView(targetEntity, hitSkillId)
    end
  end
  local playDamageService = self._world:GetService("PlayDamage")
  for _, _damageInfo in ipairs(damageInfoList) do
    local showType = playDamageService:SingleOrGrid(skillID)
    _damageInfo:SetShowType(showType)
    _damageInfo:SetRenderGridPos(damageTextPos)
  end
  playDamageService:AsyncUpdateHPAndDisplayDamageMultiStage(targetEntity, damageInfoList, damageStageValueList, intervalTime)
  self:_ShowCombo(casterEntity, defenderEntity, damageInfo)
  self:_OnPlayAddBuff(TT, casterEntity, targetEntity, damageInfo)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local hitbackResult = skillEffectResultContainer:GetEffectResultByTargetID(SkillEffectType.HitBack, defenderHPMaster:GetID())
  local processHitTaskID
  if hitbackResult then
    processHitTaskID = self:ProcessHit(casterEntity, targetEntity, hitbackResult)
  end
  if processHitTaskID then
    while not TaskHelper:GetInstance():IsTaskFinished(processHitTaskID) do
      YIELD(TT)
    end
  end
  YIELD(TT)
  if hitbackResult then
    local pieceService = self._world:GetService("Piece")
    pieceService:RemovePrismAt(hitbackResult:GetPosTarget())
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:_OnAttackEnd(TT, skillID, casterEntity, targetEntity, attackPos, damageTextPos, damageInfo)
  GameGlobal.TaskManager():CoreGameStartTask(self.PlayHitTrap, self, casterEntity, targetEntity)
  while not TaskHelper:GetInstance():IsAllTaskFinished(listTask) do
    YIELD(TT)
  end
end

function PlaySkillService:PlayHitTrap(TT, casterEntity, targetEntity)
  local trapRenderCmpt = targetEntity:TrapRender()
  if not trapRenderCmpt then
    return
  end
  local trapServiceRender = self._world:GetService("TrapRender")
  if trapServiceRender:CanDestroyAtOnce(targetEntity) then
    trapServiceRender:PlayOneTrapDead(TT, targetEntity)
  end
end

function PlaySkillService:_OnPlayHitAnim(targetEntity, defenderEntity, damageInfo, hitAnimName)
  local performanceEntity = defenderEntity
  local performanceTargetEntity = targetEntity
  if defenderEntity:HasRenderPerformanceByAgent() then
    local agentCmpt = defenderEntity:RenderPerformanceByAgent()
    local agentEntityID = agentCmpt:GetAgentEntityID()
    local agentEntity = self._world:GetEntityByID(agentEntityID)
    if agentEntity then
      performanceEntity = agentEntity
      performanceTargetEntity = agentEntity
    end
  end
  local nDamageType = damageInfo:GetDamageType()
  if nDamageType == DamageType.Guard then
    if targetEntity:HasTrapID() and targetEntity:TrapRender():GetTrapType() == TrapType.Protected then
      self._world:GetService("Effect"):CreateEffect(BattleConst.AircraftHitShieldEffect, targetEntity)
    end
  elseif nDamageType == DamageType.Miss then
  else
    local playingSkill
    local renderState = targetEntity:RenderState()
    playingSkill = renderState and renderState:GetRenderStateType() == RenderStateType.PlayingSkill
    local isStun = performanceTargetEntity:GetAnimatorControllerBoolsData("Stun")
    if hitAnimName and not damageInfo:IsHPShieldGuard() and not playingSkill and not isStun then
      performanceEntity:SetAnimatorControllerTriggers({hitAnimName})
    end
    local mtrAni = performanceEntity:MaterialAnimationComponent()
    if mtrAni and performanceEntity:BuffView() and not performanceEntity:BuffView():HasBuffEffect(BuffEffectType.NotPlayMaterialAnimation) and not mtrAni:IsPlayingCommonInvalid() then
      mtrAni:PlayHit()
    end
    if targetEntity:MonsterID() and targetEntity:MonsterID():GetDamageSyncMonsterID() then
      local utilDataSvc = self._world:GetService("UtilData")
      local damageSyncEntityList = utilDataSvc:FindSyncMonsterTargetList(targetEntity)
      for i, entity in ipairs(damageSyncEntityList) do
        local pos = entity:GetRenderGridPosition()
        local newDamageInfo = DamageInfo:New()
        newDamageInfo:Clone(damageInfo)
        newDamageInfo:SetShowPosition(pos)
        newDamageInfo:SetRenderGridPos(pos)
        newDamageInfo:SetTargetEntityID(entity:GetID())
        self:_OnPlayHitAnim(entity, entity, newDamageInfo, hitAnimName)
      end
    end
  end
end

function PlaySkillService:_OnPlayHitEffect(TT, casterEntity, defenderEntity, damageInfo, skillID, hitEffectID, damageTextPos, hitTurnTarget, hitCasterEntity)
  if not damageInfo or not damageInfo.GetDamageType then
    Log.fatal("11111")
  end
  local performanceEntity = defenderEntity
  if defenderEntity:HasRenderPerformanceByAgent() then
    local agentCmpt = defenderEntity:RenderPerformanceByAgent()
    local agentEntityID = agentCmpt:GetAgentEntityID()
    local agentEntity = self._world:GetEntityByID(agentEntityID)
    if agentEntity then
      performanceEntity = agentEntity
    end
  end
  local nDamageType = damageInfo:GetDamageType()
  if nDamageType == DamageType.Miss then
  elseif hitEffectID then
    local damageShowType = self:GetService("PlayDamage"):SingleOrGrid(skillID)
    if type(hitEffectID) == "number" and 0 < hitEffectID then
      hitEffectID = {hitEffectID}
    end
    if type(hitEffectID) == "table" and 0 < #hitEffectID then
      for _, effID in ipairs(hitEffectID) do
        local beHitEffectEntity = self._world:GetService("Effect"):CreateBeHitEffect(effID, performanceEntity, damageShowType, damageTextPos)
        if beHitEffectEntity and hitTurnTarget ~= TurnToTargetType.None then
          local castPos = casterEntity:GetRenderGridPosition()
          if not castPos then
            if casterEntity:HasSuperEntity() then
              castPos = casterEntity:GetSuperEntity():GetRenderGridPosition()
            elseif casterEntity:HasSummoner() then
              castPos = casterEntity:GetSummonerEntity():GetRenderGridPosition()
            else
              castPos = damageTextPos
            end
          end
          local gridDir = damageTextPos - castPos
          if hitTurnTarget == TurnToTargetType.PickupPos then
            local renderPickUpComponent = casterEntity:RenderPickUpComponent()
            local firstPickUpPos = renderPickUpComponent:GetFirstValidPickUpGridPos()
            gridDir = firstPickUpPos - damageTextPos
          end
          local view, go
          if beHitEffectEntity then
            view = beHitEffectEntity:View()
          end
          if view then
            go = view:GetGameObject()
          end
          if go then
            local effectTransform = go.transform
            beHitEffectEntity:SetLocation(effectTransform.position, gridDir)
          end
        end
        if beHitEffectEntity ~= nil then
          local effectCtrl = beHitEffectEntity:EffectController()
          if effectCtrl ~= nil and casterEntity ~= nil then
            if hitCasterEntity then
              effectCtrl:SetEffectCasterID(hitCasterEntity:GetID())
            else
              effectCtrl:SetEffectCasterID(casterEntity:GetID())
            end
          end
        end
      end
    end
  end
end

function PlaySkillService:_OnPlayAddBuff(TT, casterEntity, targetEntity, damageInfo)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local playBuffService = self._world:GetService("PlayBuff")
  local damageStageIndex = damageInfo:GetDamageStageIndex()
  local buffResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBuff, damageStageIndex)
  local beHitRefreshBuff = damageInfo:GetBeHitRefreshBuff()
  local selectPlayBuffResult = damageInfo:GetPlayBuffResult()
  if buffResultArray then
    for _, v in pairs(buffResultArray) do
      local buffArray = v:GetAddBuffResult()
      if buffArray then
        for _, seq in pairs(buffArray) do
          local buffTargetEntityID = v:GetEntityID()
          if targetEntity:GetID() == buffTargetEntityID then
            local buffViewInstance = targetEntity:BuffView():GetBuffViewInstance(seq)
            if buffViewInstance then
              if beHitRefreshBuff == false then
                if selectPlayBuffResult == v then
                  playBuffService:PlayAddBuff(TT, buffViewInstance, casterEntity:GetID())
                end
              else
                playBuffService:PlayAddBuff(TT, buffViewInstance, casterEntity:GetID())
              end
            end
          end
        end
      end
    end
  end
end

function PlaySkillService:_ClearDeathBody(TT, casterEntity, targetEntity)
  if targetEntity:HasMonsterID() then
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTCollectSouls:New(casterEntity, 1, {targetEntity}))
  end
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  sMonsterShowRender:_DoOneMonsterDead(TT, targetEntity)
end

function PlaySkillService:GetFinalAttack(world, casterEntity, phaseContext)
  local playFinalAttack = false
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local curDamageIndex = phaseContext:GetCurDamageResultIndex()
  local curDamageResultStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, curDamageResultStageIndex)
  local damageResultStageCount = skillEffectResultContainer:GetEffectResultsStageCount(SkillEffectType.Damage)
  if skillEffectResultContainer:IsFinalAttack() and curDamageIndex == self:_GetFinalAttackIndex(damageResultArray) and curDamageResultStageIndex == damageResultStageCount then
    playFinalAttack = true
  end
  if playFinalAttack and not casterEntity:HasPetPstID() then
    local teamEntity = world:Player():GetCurrentTeamEntity()
    local pets = teamEntity:Team():GetTeamPetEntities()
    for i, petEntity in ipairs(pets) do
      local petskillEffectResultContainer = petEntity:SkillRoutine():GetResultContainer()
      if petskillEffectResultContainer and petskillEffectResultContainer:IsFinalAttack() then
        local petDamageResultArray = petskillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
        if petDamageResultArray and table.count(petDamageResultArray) > 0 then
          playFinalAttack = false
          return playFinalAttack
        end
      end
    end
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local chainPathData = renderBoardEntity:RenderChainPath():GetRenderChainPath()
    if chainPathData then
      local triggerTrapList = {}
      local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
      for i = 1, #chainPathData do
        for _, e in ipairs(trapGroup:GetEntities()) do
          local trapRenderCmpt = e:TrapRender()
          if trapRenderCmpt:GetTriggerSkillID() then
            local pos = e:GridLocation().Position
            if pos == chainPathData[i] then
              table.insert(triggerTrapList, e)
            end
          end
        end
      end
      local finalTrap
      for i = #triggerTrapList, 1, -1 do
        local trapEntity = triggerTrapList[i]
        local trapskillEffectResultContainer = trapEntity:SkillRoutine():GetResultContainer()
        if trapskillEffectResultContainer then
          local damageResultAll = trapskillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, curDamageResultStageIndex)
          if damageResultAll then
            for _, result in ipairs(damageResultAll) do
              local beAttackEntityID = result:GetTargetID()
              local targetEntity = world:GetEntityByID(beAttackEntityID)
              if targetEntity and targetEntity:HasMonsterID() then
                finalTrap = trapEntity
                break
              end
            end
          end
        end
        if finalTrap then
          break
        end
      end
      if finalTrap and finalTrap:GetID() ~= casterEntity:GetID() then
        playFinalAttack = false
      end
    end
  end
  return playFinalAttack
end

function PlaySkillService:_GetFinalAttackIndex(damageResultArray)
  if not damageResultArray then
    return -1
  end
  for i = #damageResultArray, 1, -1 do
    local result = damageResultArray[i]
    local targetId = result:GetTargetID()
    if targetId ~= nil and 0 < targetId then
      return i
    end
  end
  return -1
end

function PlaySkillService:_ShowCombo(casterEntity, defenderEntity, damageInfo)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if skillEffectResultContainer ~= nil then
    local isNormalAttack = skillEffectResultContainer:IsNormalAttack()
    if isNormalAttack == true then
      local renderBattleService = self._world:GetService("RenderBattle")
      local curComboNum = renderBattleService:GetComboNum()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DisplayCombo, curComboNum)
    end
  end
end

function PlaySkillService:_ClearCombo()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DisplayCombo, 0)
end

function PlaySkillService:GetFinalEffect()
  if self._finalEffectEntity ~= nil then
    return self._finalEffectEntity
  end
  local group = self._world:GetGroup(self._world.BW_WEMatchers.EntityType)
  for _, entity in ipairs(group:GetEntities()) do
    if entity:EntityType().Value == EntityType.FinalAttackEffect then
      self._finalEffectEntity = entity
    end
  end
  return self._finalEffectEntity
end

function PlaySkillService:GetLoopAudioPlayingID()
  return self._curLoopAudioPlayingID
end

function PlaySkillService:SetLoopAudioPlayingID(playingID)
  self._curLoopAudioPlayingID = playingID
end

function PlaySkillService:GetWaitFreeList()
  return self.m_listWaitTask
end

function PlaySkillService:AddWaitFreeTask(nTaskID)
  if 0 < nTaskID then
    self.m_listWaitTask[#self.m_listWaitTask + 1] = nTaskID
  end
end

function PlaySkillService:ResetWaitFreeList()
  table.clear(self.m_listWaitTask)
end

function PlaySkillService:DoDropAnimation(dropAssetList, gridPos)
  if dropAssetList and 0 < #dropAssetList then
    for k, v in pairs(dropAssetList) do
      if v.asset.assetid == RoleAssetID.RoleAssetGold then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowDropCoinInfo, v.asset.count)
        local effectService = self._world:GetService("Effect")
        if v.effect and v.effect ~= 0 then
          effectService:CreateWorldPositionEffect(v.effect, gridPos, true)
        end
        Log.warn("DropGold Count：", v.asset.count, "GridPos:", tostring(gridPos), "EffectID:", v.effect, "DebugTrack:", Log.traceback())
      elseif v.asset.assetid == RoleAssetID.RoleAssetMazeCoin then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowDropMazeCoinInfo)
        local effectService = self._world:GetService("Effect")
        if v.effect and v.effect ~= 0 then
          effectService:CreateWorldPositionEffect(v.effect, gridPos, true)
        end
        Log.warn("DropGold Count：", v.asset.count, "GridPos:", tostring(gridPos), "EffectID:", v.effect, "DebugTrack:", Log.traceback())
      end
    end
  end
end

function PlaySkillService:IsTaskFinished(taskID)
  local task = TaskManager:GetInstance():FindTask(taskID)
  if task ~= nil then
    return false
  else
  end
  return true
end

function PlaySkillService:PlaySkillView(casterEntity, skillID)
  local waitTaskID = -1
  local skinId = 1
  if casterEntity:MatchPet() then
    skinId = casterEntity:MatchPet():GetMatchPet():GetSkinId()
  end
  local skillConfigData = self._configService:GetSkillConfigData(skillID, casterEntity)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray(skinId)
  waitTaskID = self:StartSkillRoutine(casterEntity, skillPhaseArray, skillID)
  return waitTaskID
end

function PlaySkillService:PlaySkillViewSync(TT, casterEntity, skillID)
  local skinId = 1
  if casterEntity:MatchPet() then
    skinId = casterEntity:MatchPet():GetMatchPet():GetSkinId()
  end
  local skillConfigData = self._configService:GetSkillConfigData(skillID, casterEntity)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray(skinId)
  self:_SkillRoutineTask(TT, casterEntity, skillPhaseArray, skillID)
end

function PlaySkillService:PlayCastAudio(TT, audioID, waitTime)
  if waitTime and 0 < waitTime then
    YIELD(TT, waitTime)
  end
  if audioID and audioID ~= 0 then
    AudioHelperController.PlayInnerGameSfx(audioID)
  end
end

function PlaySkillService:GetEntityRenderHitTransform(e)
  local cView = e:View()
  if not cView then
    Log.error("entity has no ViewComponent")
    return
  end
  local go = cView:GetGameObject()
  if not go or tostring(go) == "null" then
    Log.error("entity has ViewComponent, but no GameObject inside. ")
    return
  end
  local cstsfm = GameObjectHelper.FindChild(go.transform, "Hit")
  if cstsfm then
    return cstsfm
  end
  cstsfm = GameObjectHelper.FindChild(go.transform, "hit")
  if cstsfm then
    return cstsfm
  end
  Log.error("entity has ViewComponent and GameObject, but no Hit node here. GameObject name: ", tostring(go.name))
end

function PlaySkillService:GetEntityRenderSelectBoneTransform(e, boneName)
  if not boneName then
    return self:GetEntityRenderHitTransform(e)
  end
  local cView = e:View()
  if not cView then
    Log.error("entity has no ViewComponent")
    return
  end
  local go = cView:GetGameObject()
  if not go or tostring(go) == "null" then
    Log.error("entity has ViewComponent, but no GameObject inside. ")
    return
  end
  local cstsfm = GameObjectHelper.FindChild(go.transform, boneName)
  if cstsfm then
    return cstsfm
  end
  Log.error("entity has ViewComponent and GameObject, but no ", boneName, " node here. GameObject name: ", tostring(go.name))
  return go.transform
end
