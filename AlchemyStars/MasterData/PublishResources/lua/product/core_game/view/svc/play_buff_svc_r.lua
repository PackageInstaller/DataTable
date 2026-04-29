_class("PlayBuffService", BaseService)
PlayBuffService = PlayBuffService

function PlayBuffService:Constructor(world)
  self._configService = world:GetService("Config")
end

function PlayBuffService:_OnGetPlayUnitTurnBuffViewTaskIDs(entity, notify, isDelay)
  local taskIDs = {}
  local viewIns = entity:BuffView():GetBuffViewInstanceArray()
  local views = {}
  for _, inst in ipairs(viewIns) do
    local buffEffectType = inst:GetBuffEffectType()
    local qualified = false
    if isDelay and table.icontains(_G.UnitTurnDelayStartEffectType, buffEffectType) then
      qualified = true
    elseif not isDelay and not table.icontains(_G.UnitTurnDelayStartEffectType, buffEffectType) then
      qualified = true
    end
    if qualified then
      local vs = inst:GetBuffView(notify)
      if vs then
        for index, value in ipairs(vs) do
          views[#views + 1] = value
        end
      end
    end
  end
  if 0 < #views then
    local taskId = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      for _, view in ipairs(views) do
        Log.notice("play buff view ", view:ViewName(), " entityID=", entity:GetID())
        view:PlayView(TT, notify)
      end
    end)
    taskIDs[#taskIDs + 1] = taskId
  end
  return taskIDs
end

local canDelayNotifyType = {
  NotifyType.MonsterTurnStart,
  NotifyType.PlayerTurnStart
}

function PlayBuffService:PlayUnitTurnBuffView(TT, notify, isDelay, notRemove)
  if not table.icontains(canDelayNotifyType, notify:GetNotifyType()) then
    return self:PlayBuffView(TT, notify, notRemove)
  end
  local notifyEntity = notify:GetNotifyEntity()
  local notifyEntityID = 0
  if notifyEntity then
    notifyEntityID = notifyEntity:GetID()
  end
  Log.debug("PlayUnitTurnBuffView() notify ", notify:GetNotifyType(), GetEnumKey("NotifyType", notify:GetNotifyType()), " notifyEntity=", notifyEntityID)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.BuffView)
  local taskIDsAll = {}
  for _, e in ipairs(group:GetEntities()) do
    if self:_OnCheckPlayConditions(e, notify) then
      local taskIDs = self:_OnGetPlayUnitTurnBuffViewTaskIDs(e, notify, isDelay)
      table.appendArray(taskIDsAll, taskIDs)
    end
  end
  JOIN_TASK_ARRAY(TT, taskIDsAll)
  local nt = notify:GetSubordinateNotify()
  if nt then
    self:PlayBuffView(TT, nt, notRemove)
  end
  if notRemove then
    return
  end
  self:PlayAutoRemoveBuff(TT, notify)
end

function PlayBuffService:PlayBuffView(TT, notify, notRemove)
  local notifyEntity = notify:GetNotifyEntity()
  local notifyEntityID = 0
  if notifyEntity then
    notifyEntityID = notifyEntity:GetID()
  end
  Log.debug("PlayBuffView() notify ", notify:GetNotifyType(), GetEnumKey("NotifyType", notify:GetNotifyType()), " notifyEntity=", notifyEntityID)
  local detailLogger = self._world:GetDetailMatchLogger()
  detailLogger:ViewBeginPlayBuffView(notify)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.BuffView)
  local taskIDsAll = {}
  for _, e in ipairs(group:GetEntities()) do
    if self:_OnCheckPlayConditions(e, notify) then
      local taskIDs = self:_OnGetPlayBuffViewTaskIDs(e, notify)
      table.appendArray(taskIDsAll, taskIDs)
    end
  end
  detailLogger:ViewEndPlayBuffView(notify)
  JOIN_TASK_ARRAY(TT, taskIDsAll)
  local nt = notify:GetSubordinateNotify()
  if nt then
    self:PlayBuffView(TT, nt, notRemove)
  end
  if notRemove then
    return
  end
  self:PlayAutoRemoveBuff(TT, notify)
end

function PlayBuffService:_OnGetPlayBuffViewTaskIDs(entity, notify)
  local taskIDs = {}
  local viewIns = entity:BuffView():GetBuffViewInstanceArray()
  local views = {}
  for _, inst in ipairs(viewIns) do
    local vs = inst:GetBuffView(notify)
    if vs then
      for index, value in ipairs(vs) do
        views[#views + 1] = value
      end
    end
  end
  if 0 < #views then
    local detailLogger = self._world:GetDetailMatchLogger()
    detailLogger:ViewRecordPlayBuffView(entity, notify, views)
    local taskId = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      for _, view in ipairs(views) do
        Log.notice("play buff view ", view:ViewName(), " entityID=", entity:GetID())
        view:PlayView(TT, notify)
      end
    end)
    taskIDs[#taskIDs + 1] = taskId
  end
  return taskIDs
end

function PlayBuffService:_OnCheckPlayConditions(entity, notify)
  local play = false
  if entity:HasShowDeath() then
    if notify:GetNotifyType() == NotifyType.MonsterDead or notify:GetNotifyType() == NotifyType.MonsterDeadStart or notify:GetNotifyType() == NotifyType.MonsterDeadEnd or notify:GetNotifyType() == NotifyType.ReduceShieldLayer then
      play = true
    end
  else
    play = true
  end
  return play
end

function PlayBuffService:PlayAutoAddBuff(TT)
  Log.notice("PlayAutoAddBuff()!!!")
  local group = self._world:GetGroup(self._world.BW_WEMatchers.BuffView)
  for _, e in ipairs(group:GetEntities()) do
    local viewIns = e:BuffView():GetBuffViewInstanceArray()
    for _, inst in ipairs(viewIns) do
      self:PlayAddBuff(TT, inst)
    end
  end
end

function PlayBuffService:PlayBuffSeqs(TT, buffseqs)
  for _, v in ipairs(buffseqs) do
    local e = v[1]
    local seq = v[2]
    local buffViewInstance = e:BuffView():GetBuffViewInstance(seq)
    self:PlayAddBuff(TT, buffViewInstance)
  end
end

function PlayBuffService:PlayAutoRemoveBuff(TT, notify)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.BuffView)
  for _, e in ipairs(group:GetEntities()) do
    local viewIns = e:BuffView():GetBuffViewInstanceArray()
    for i = #viewIns, 1, -1 do
      local inst = viewIns[i]
      if inst:IsUnload(notify) and not inst:HasBuffView() then
        self:PlayRemoveBuff(TT, inst, notify)
      end
    end
  end
end

function PlayBuffService:PlayAddBuff(TT, buffViewInstance, casterEntityID, NoAddBuffNotify)
  buffViewInstance:SetShow()
  local entity = buffViewInstance:Entity()
  self:AttachBuffEffect(buffViewInstance)
  local views = buffViewInstance:GetBuffView(NTBuffLoad:New(buffViewInstance:Entity(), casterEntityID))
  if views then
    for index, view in ipairs(views) do
      Log.notice("play add buff: view ", view:ViewName())
      view:PlayView(TT, nil, Log.traceback())
    end
  end
  self:PlayBuffHeadEffect(entity)
  self:PlayUIChangeBuff(entity)
  local ntAddBuffEnd = NTAddBuffEnd:New(entity, buffViewInstance:BuffSeq(), buffViewInstance:BuffID(), buffViewInstance:GetBuffType())
  self:PlayBuffView(TT, ntAddBuffEnd)
  if not NoAddBuffNotify then
    self:PlayBuffView(TT, NTAfterEntityAddBuff:New(entity, buffViewInstance:BuffID(), buffViewInstance:GetBuffType(), buffViewInstance:BuffSeq()))
  end
  if buffViewInstance:GetBuffType() == BuffType.Control then
    local nt = NTAddControlBuffEnd:New(entity, buffViewInstance:BuffSeq(), buffViewInstance:BuffID(), buffViewInstance:GetBuffType())
    self:PlayBuffView(TT, nt)
  end
end

function PlayBuffService:PlayUIChangeBuff(entity)
  local team
  if entity:HasTeam() then
    team = entity
  elseif entity:HasPet() then
    team = entity:Pet():GetOwnerTeamEntity()
  end
  if team and self._world:Player():IsLocalTeamEntity(team) then
    local teamBuffList = team:BuffView():GetBuffTeamStateShowList()
    self._world:EventDispatcher():Dispatch(GameEventType.ChangeTeamBuff, teamBuffList)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff, entity:GetID())
end

function PlayBuffService:PlayRemoveBuff(TT, buffViewInstance, notify)
  if notify then
    self:PlayBuffView(TT, notify, true)
  end
  self:DetachBuffEffect(buffViewInstance)
  local entity = buffViewInstance:Entity()
  entity:RemoveBuffViewInstance(buffViewInstance)
  self:PlayBuffHeadEffect(entity)
  self:PlayUIChangeBuff(entity)
end

function PlayBuffService:PlayPlayerTurnStartBuff(TT, teamEntity, formerTeamOrder, isDelayed)
  local playBuffService = self._world:GetService("PlayBuff")
  playBuffService:PlayUnitTurnBuffView(TT, NTPlayerTurnStart:New(teamEntity, formerTeamOrder), isDelayed)
end

function PlayBuffService:PlayPlayerTurnBuff(TT, teamEntity, formerTeamOrder, isDelayed)
  self:PlayPlayerTurnStartBuff(TT, teamEntity, formerTeamOrder, isDelayed)
  self:PlayBuffView(TT, NTEnemyTurnStart:New(teamEntity))
  self:PlayBuffView(TT, NTPlayerTurnStartLast:New())
  self:PlayBuffView(TT, NTPlayerTurnBuffAddRoundEnd:New(teamEntity))
  self:PlayBuffView(TT, NTPlayerTurnBuffAddRoundEndAfter:New(teamEntity))
end

function PlayBuffService:PlayMonsterTurnBuff(TT, isDelay)
  self:PlayUnitTurnBuffView(TT, NTMonsterTurnStart:New(), isDelay)
  self:PlayBuffView(TT, NTMonsterTurnAfterAddBuffRound:New())
end

function PlayBuffService:PlayChessTurnBuff(TT)
  self:PlayBuffView(TT, NTPlayerTurnStart:New())
end

function PlayBuffService:PlayMonsterTurnDelayedBuff(TT)
  self:PlayBuffView(TT, NTMonsterTurnAfterDelayedAddBuffRound:New())
end

function PlayBuffService:AttachBuffEffect(buffViewInstance)
  local targetEntity = buffViewInstance:Entity()
  if 0 == buffViewInstance:GetBuffEffectEntityID() then
    local targetEffectID = buffViewInstance:BuffConfigData():GetLoadEffectID()
    if targetEffectID == nil then
      return
    end
    local effectService = self._world:GetService("Effect")
    local effectEntity = effectService:CreateEffect(targetEffectID, targetEntity)
    buffViewInstance:SetBuffEffectEntityID(effectEntity:GetID())
  end
end

function PlayBuffService:DetachBuffEffect(buffViewInstance)
  if not buffViewInstance then
    return
  end
  local buffEffectEntityID = buffViewInstance:GetBuffEffectEntityID()
  local buffEffectEntity = self._world:GetEntityByID(buffEffectEntityID)
  if buffEffectEntity then
    self._world:DestroyEntity(buffEffectEntity)
  end
  buffViewInstance:SetBuffEffectEntityID(0)
end

function PlayBuffService:RemoveAllBuff(TT, entity)
  local buffViewCom = entity:BuffView()
  if not buffViewCom then
    return
  end
  local t = table.shallowcopy(buffViewCom:GetBuffViewInstanceArray())
  for i = #t, 1, -1 do
    local buffv = t[i]
    self:PlayRemoveBuff(TT, buffv, NTBuffUnload:New())
  end
end

function PlayBuffService:PlayBuffHeadEffect(entity)
  if not entity:BuffView() then
    return
  end
  local head_buff = entity:BuffView():GetHeadBuff()
  local com = entity:BuffHeadEffect()
  if not com then
    entity:AddBuffHeadEffect(head_buff)
  else
    local oldbv = com:GetBuffViewInstance()
    if oldbv ~= head_buff then
      self:DetachBuffEffect(oldbv)
      com:SetBuffViewInstance(head_buff)
    end
  end
end

function PlayBuffService:PlayDamageBuff(TT, buffView)
  local buffResult = buffView:GetBuffResult()
  if buffResult == nil then
    return
  end
  local PlayDamageService = self._world:GetService("PlayDamage")
  local damageInfo = buffResult:GetDamageInfo()
  local damageType = damageInfo:GetDamageType()
  local targetId = damageInfo:GetTargetEntityID()
  local targetEntity = buffView:Entity()
  if targetId then
    targetEntity = self._world:GetEntityByID(targetId)
  end
  PlayDamageService:AsyncUpdateHPAndDisplayDamage(targetEntity, damageInfo)
  if damageType == DamageType.Guard then
  elseif damageType == DamageType.Miss then
  else
    local hitAnim = "Hit"
    targetEntity:SetAnimatorControllerTriggers({hitAnim})
    if buffView:BuffViewInstance():GetBuffType() == BuffType.DOT then
      YIELD(TT, BattleConst.DamageBuffAnimatorHitDelay)
    end
  end
end

function PlayBuffService:RefreshLockHPView(TT, gsmState)
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local utilStatSvc = self._world:GetService("UtilData")
  local round = utilStatSvc:GetStatCurWaveTotalRoundCount()
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    local buffView = monsterEntity:BuffView()
    if buffView and not buffView:IsAlwaysHPLock() and buffView:IsHPNeedUnLock(round - 1, gsmState) then
      local index = buffView:GetHPLockIndex()
      local hpComponent = monsterEntity:HP()
      if hpComponent:IsShowHPSlider() then
        local sepPoolWidget = hpComponent:GetSepPoolWidget()
        if sepPoolWidget then
          local sepPool = sepPoolWidget:GetAllSpawnList()
          sepPool[index]:GetGameObject():SetActive(false)
        else
          Log.fatal("monster has no lockhp res,ID:", monsterEntity:GetID())
        end
      end
      hpComponent:AddHPLockUnlockedIndex(index)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeBossHPLock, index, false)
      Log.warn(" View NotifyBreakHPLock Index:", index)
      self._world:GetService("PlayBuff"):PlayBuffView(TT, NTBreakHPLock:New(monsterEntity))
      buffView:ResetHPLockState()
    end
  end
end

function PlayBuffService:LoadArchivedLockHPView(TT, arch)
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    local buffView = monsterEntity:BuffView()
    local unlockIndex = buffView:GetUnlockHPIndex()
    if unlockIndex then
      for _, idx in ipairs(unlockIndex) do
        local hpComponent = monsterEntity:HP()
        if hpComponent:IsShowHPSlider() then
          local sepPoolWidget = hpComponent:GetSepPoolWidget()
          if sepPoolWidget then
            local sepPool = sepPoolWidget:GetAllSpawnList()
            sepPool[idx]:GetGameObject():SetActive(false)
          else
            Log.fatal("monster has no lockhp res,ID:", monsterEntity:GetID())
          end
        end
        GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeBossHPLock, idx, false)
      end
    end
  end
end

function PlayBuffService:_OnAttackStart(TT, skillID, attacker, defender, attackPos, beAttackPos, damageInfo)
  local skillConfigData = self._configService:GetSkillConfigData(skillID, attacker)
  local isMatch = false
  if attacker:HasPetPstID() then
    isMatch = true
    local skillConfigData = self._configService:GetSkillConfigData(skillID, attacker)
    if skillConfigData:GetSkillType() == SkillType.Normal then
      self:PlayBuffView(TT, NTNormalAttackChangeBefore:New(attacker, attackPos, beAttackPos))
      self:PlayBuffView(TT, NTNormalEachAttackStart:New(attacker, defender, attackPos, beAttackPos))
    end
    if skillConfigData:GetSkillType() == SkillType.Chain then
      local skillResult = attacker:SkillRoutine():GetResultContainer()
      local chainTimeIndex = skillResult:GetChainEffectResultTimeIndex()
      local chainStageIndex = skillResult:GetChainEffectResultStageIndex()
      local notify = NTChainSkillEachAttackStart:New(attacker, defender, attackPos, beAttackPos)
      notify:SetChainSkillTimeIndex(chainTimeIndex)
      notify:SetChainSkillStageIndex(chainStageIndex)
      if damageInfo and damageInfo.GetRandHalfDamageIndex then
        local randHalfDamageIndex = damageInfo:GetRandHalfDamageIndex()
        if randHalfDamageIndex then
          notify:SetRandHalfDamageIndex(randHalfDamageIndex)
        end
      end
      self:PlayBuffView(TT, notify)
    end
    if skillConfigData:GetSkillType() == SkillType.Active then
      self:PlayBuffView(TT, NTActiveSkillEachAttackStart:New(attacker, defender, attackPos, beAttackPos))
    end
  elseif attacker:HasMonsterID() then
    isMatch = true
    self:PlayBuffView(TT, NTMonsterEachAttackStart:New(attacker, defender, attackPos, beAttackPos))
  elseif attacker:HasTrapID() then
    isMatch = true
    self:PlayBuffView(TT, NTTrapEachAttackStart:New(attacker, defender, attackPos, beAttackPos))
  end
  if skillConfigData:GetSkillType() == SkillType.AutoBeadSkill then
    isMatch = true
    local notify = NTAutoBeadSkillEachAttackStart:New(attacker, defender, attackPos, beAttackPos)
    self:PlayBuffView(TT, notify)
  end
  if not isMatch then
    self:PlayBuffView(TT, NTBuffCastSkillEachAttackBegin:New(attacker, defender, attackPos, beAttackPos))
  end
  if defender:HasMonsterID() then
    local nt = NTMonsterBeHitStart:New(attacker, defender, attackPos, beAttackPos)
    nt:SetSkillID(skillID)
    nt:SetSkillType(skillConfigData:GetSkillType())
    self:PlayBuffView(TT, nt)
  end
  if defender:HasPetPstID() or defender:HasTeam() then
    local nt = NTPlayerBeHitStart:New(attacker, defender, attackPos, beAttackPos)
    nt:SetSkillID(skillID)
    nt:SetSkillType(skillConfigData:GetSkillType())
    self:PlayBuffView(TT, nt)
  end
end

function PlayBuffService:_OnAttackEnd(TT, skillID, attacker, defender, attackPos, beAttackPos, damageIndex, damageInfo)
  local skillConfigData = self._configService:GetSkillConfigData(skillID, attacker)
  local isPetShadow = attacker:EntityType() and attacker:EntityType():IsPetShadow()
  if isPetShadow then
    local petShadowRenderComponent = attacker:PetShadowRender()
    local ownerEntityID = petShadowRenderComponent:GetOwnerEntityID()
    local ownerEntity = self._world:GetEntityByID(ownerEntityID)
    if ownerEntity then
      attacker = ownerEntity
    end
  end
  if attacker:HasPetPstID() then
    if skillConfigData:GetSkillType() == SkillType.Normal then
      local notify = NTNormalAttackChangeAfter:New(attacker, attackPos, beAttackPos)
      self:PlayBuffView(TT, notify)
      local notify2 = NTNormalEachAttackEnd:New(attacker, defender, attackPos, beAttackPos)
      if damageInfo and damageInfo.GetNormalAttackIndex and damageInfo:GetNormalAttackIndex() then
        notify2:SetNormalAttackIndex(damageInfo:GetNormalAttackIndex())
      end
      notify2:SetSkillID(skillID)
      self:PlayBuffView(TT, notify2)
    end
    if skillConfigData:GetSkillType() == SkillType.Chain then
      local skillResult = attacker:SkillRoutine():GetResultContainer()
      local chainTimeIndex = skillResult:GetChainEffectResultTimeIndex()
      local chainStageIndex = skillResult:GetChainEffectResultStageIndex()
      local notify = NTChainSkillEachAttackEnd:New(attacker, defender, attackPos, beAttackPos)
      notify:SetChainSkillTimeIndex(chainTimeIndex)
      notify:SetChainSkillStageIndex(chainStageIndex)
      if damageInfo and damageInfo.GetRandHalfDamageIndex then
        local randHalfDamageIndex = damageInfo:GetRandHalfDamageIndex()
        if randHalfDamageIndex then
          notify:SetRandHalfDamageIndex(randHalfDamageIndex)
        end
      end
      self:PlayBuffView(TT, notify)
    end
    if skillConfigData:GetSkillType() == SkillType.Active then
      self:PlayBuffView(TT, NTActiveSkillEachAttackEnd:New(attacker, defender, attackPos, beAttackPos))
    end
  elseif attacker:HasMonsterID() then
    if skillConfigData:GetSkillType() == SkillType.Normal then
      self:PlayBuffView(TT, NTMonsterEachAttackEnd:New(attacker, defender, attackPos, beAttackPos))
    end
    self:PlayBuffView(TT, NTMonsterEachDamageEnd:New(attacker, defender, attackPos, beAttackPos))
  elseif attacker:HasTrapID() then
    self:PlayBuffView(TT, NTTrapEachAttackEnd:New(attacker, defender, attackPos, beAttackPos))
  elseif attacker:EntityType():IsSkillHolder() then
    local notify = NTBuffCastSkillEachAttackEnd:New(attacker, defender, attackPos, beAttackPos)
    notify:SetSkillID(skillID)
    self:PlayBuffView(TT, notify)
  end
  if skillConfigData:GetSkillType() == SkillType.AutoBeadSkill then
    local autoBeadSkillIndex = 0
    if attacker:EntityType():IsAutoBeadSkillHolder() then
      local skillResult = attacker:SkillRoutine():GetResultContainer()
      autoBeadSkillIndex = skillResult:GetAutoBeadResultSkillIndex()
    end
    local notify = NTAutoBeadSkillEachAttackEnd:New(attacker, defender, attackPos, beAttackPos)
    notify:SetSkillID(skillID)
    notify:SetAutoBeadSkillIndex(autoBeadSkillIndex)
    self:PlayBuffView(TT, notify)
  end
  if defender:HasMonsterID() then
    local nt = NTMonsterBeHit:New(attacker, defender, attackPos, beAttackPos)
    nt:SetSkillID(skillID)
    nt:SetSkillType(skillConfigData:GetSkillType())
    if damageInfo and damageInfo.GetDamageStageIndex then
      local damageStageIndex = damageInfo:GetDamageStageIndex()
      if damageStageIndex then
        nt:SetDamageStageIndex(damageStageIndex)
      end
    end
    if damageInfo and damageInfo.GetCurSkillDamageIndex then
      local curSkillDamageIndex = damageInfo:GetCurSkillDamageIndex()
      if curSkillDamageIndex then
        nt:SetCurSkillDamageIndex(curSkillDamageIndex)
      end
    end
    self:PlayBuffView(TT, nt)
  end
  if defender:HasPetPstID() or defender:HasTeam() then
    local nt = NTPlayerBeHit:New(attacker, defender, attackPos, beAttackPos)
    nt:SetDamageIndex(damageIndex)
    self:PlayBuffView(TT, nt)
  end
  if defender:HasChessPet() then
    local nt = NTChessBeHit:New(attacker, defender, attackPos, beAttackPos)
    nt:SetSkillID(skillID)
    nt:SetSkillType(skillConfigData:GetSkillType())
    self:PlayBuffView(TT, nt)
  end
end

function PlayBuffService:_SendNTGridConvertRender(TT, pos, pieceType, effectType)
  local boardEntity = self._world:GetRenderBoardEntity()
  local tConvertInfo = {}
  local convertInfo = NTGridConvert_ConvertInfo:New(Vector2(pos.x, pos.y), PieceType.None, pieceType)
  table.insert(tConvertInfo, convertInfo)
  local ntGridConvert = NTGridConvert:New(boardEntity, tConvertInfo)
  ntGridConvert:SetConvertEffectType(effectType)
  local svcPlayBuff = self._world:GetService("PlayBuff")
  svcPlayBuff:PlayBuffView(TT, ntGridConvert)
end

function PlayBuffService:ReplaceBuffName(configData, buffOwner)
  local buffName = configData:GetBuffName()
  local curTeamEntity = self._world:Player():GetLocalTeamEntity()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local replaceBuffNameReplaceTable = utilCalcSvc:GetBuffLogicValue(curTeamEntity, "ReplaceBuffNameReplaceTable")
  if not buffOwner:HasMonsterID() then
    if replaceBuffNameReplaceTable then
      if not utilCalcSvc:IsBlackFistRemoteEntity(buffOwner) then
        return buffName
      end
    else
      return buffName
    end
  end
  if replaceBuffNameReplaceTable and replaceBuffNameReplaceTable[configData:GetBuffEffectType()] then
    buffName = replaceBuffNameReplaceTable[configData:GetBuffEffectType()]
  end
  return buffName
end

function PlayBuffService:ReplaceBuffIcon(configData, buffOwner)
  local buffIcon = configData:GetBuffIcon()
  local curTeamEntity = self._world:Player():GetLocalTeamEntity()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local replaceBuffIconReplaceTable = utilCalcSvc:GetBuffLogicValue(curTeamEntity, "ReplaceBuffIconReplaceTable")
  if not buffOwner:HasMonsterID() then
    if replaceBuffIconReplaceTable then
      if not utilCalcSvc:IsBlackFistRemoteEntity(buffOwner) then
        return buffIcon
      end
    else
      return buffIcon
    end
  end
  if replaceBuffIconReplaceTable and replaceBuffIconReplaceTable[configData:GetBuffEffectType()] then
    buffIcon = replaceBuffIconReplaceTable[configData:GetBuffEffectType()]
  end
  return buffIcon
end

function PlayBuffService:ModifyMaxLayerCountByGlobalCfg(configData, buffOwner)
  local buffDesc = configData:GetBuffDesc()
  local curTeamEntity = self._world:Player():GetLocalTeamEntity()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local replaceBuffDescReplaceTable = utilCalcSvc:GetBuffLogicValue(curTeamEntity, "ReplaceBuffDescReplaceTable")
  if not buffOwner:HasMonsterID() then
    if replaceBuffDescReplaceTable then
      if not utilCalcSvc:IsBlackFistRemoteEntity(buffOwner) then
        return buffDesc
      end
    else
      return buffDesc
    end
  end
  if replaceBuffDescReplaceTable and replaceBuffDescReplaceTable[configData:GetBuffEffectType()] then
    buffDesc = replaceBuffDescReplaceTable[configData:GetBuffEffectType()]
  end
  local cfg = Cfg.cfg_global.ModifyBuffDesc
  if cfg and cfg.ArrayValue and table.icontains(cfg.ArrayValue, self._world:SubMatchType()) and cfg.TableValue and cfg.TableValue[configData:GetBuffEffectType()] then
    buffDesc = cfg.TableValue[configData:GetBuffEffectType()]
  end
  return buffDesc
end
