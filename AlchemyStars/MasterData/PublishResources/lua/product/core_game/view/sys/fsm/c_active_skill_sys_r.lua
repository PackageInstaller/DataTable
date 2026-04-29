require("active_skill_system")
_class("ClientActiveSkillSystem_Render", ActiveSkillSystem)
ClientActiveSkillSystem_Render = ClientActiveSkillSystem_Render

function ClientActiveSkillSystem_Render:_DoRenderCheckNoGhost(TT, teamEntity, casterEntity)
  if not EDITOR then
    return
  end
  local ghostEntities = self._world:GetGroup(self._world.BW_WEMatchers.Ghost):GetEntities()
  if 0 < #ghostEntities then
    Log.exception("[GhostDestroyCheck] Ghost still alive. current skillID: ")
  end
end

function ClientActiveSkillSystem_Render:_DoRenderPreActiveSkillStart(TT)
  self._world:MainCamera():EnableEffectCamera(true)
  local playSkillService = self._world:GetService("PlaySkill")
  playSkillService:ResetWaitFreeList()
end

function ClientActiveSkillSystem_Render:_DoRenderNotifyActiveSkillStart(TT, teamEntity, casterEntity)
  local isPetActiveSkill = self:_IsPetCastActiveSkill(teamEntity)
  if isPetActiveSkill then
    local playBuffService = self._world:GetService("PlayBuff")
    playBuffService:PlayBuffView(TT, NTBeforePetActiveSkillClearPower:New(casterEntity))
    playBuffService:PlayBuffView(TT, NTActiveSkillAttackStart:New(casterEntity))
  end
end

function ClientActiveSkillSystem_Render:_DoRenderGuidActiveSkill(TT, teamEntity, casterEntity)
  local guideService = self._world:GetService("Guide")
  guideService:FinishGuideWeakLine()
  local guideTaskId = guideService:Trigger(GameEventType.GuidePlayerHandleFinish, GuidePlayerHandle.MainSkillFinish, casterEntity)
  return guideTaskId
end

function ClientActiveSkillSystem_Render:_DoRenderWaitPlaySkillTaskFinish(TT)
  local playSkillService = self._world:GetService("PlaySkill")
  local listWaitTask = playSkillService:GetWaitFreeList()
  self:_WaitTasksEnd(TT, listWaitTask)
end

function ClientActiveSkillSystem_Render:_DoRenderWaitTeleportFinish(TT, listTrapTrigger, teamEntity, casterEntity)
  local sPlaySkillInstruction = self._world:GetService("PlaySkillInstruction")
  local listTrapTask = sPlaySkillInstruction:PlayTrapTrigger(TT, casterEntity, listTrapTrigger)
  self:_WaitTasksEnd(TT, listTrapTask)
end

function ClientActiveSkillSystem_Render:_DoRenderResetPieceAnim(TT, teamEntity, casterEntity)
  local pieceService = self._world:GetService("Piece")
  pieceService:RefreshPieceAnim()
  pieceService:RefreshMonsterAreaOutLine(TT)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ResetGridElement)
  local playBuffService = self._world:GetService("PlayBuff")
  if result then
    local array = result:GetResetGridData()
    playBuffService:PlayBuffView(TT, NTResetGridElement:New(array, casterEntity))
    playBuffService:PlayBuffView(TT, NTResetGridFlushTrap:New())
  end
end

function ClientActiveSkillSystem_Render:_DoRenderResetPreview(TT, teamEntity, casterEntity)
  local previewConvertElementCmpt = casterEntity:PreviewConvertElement()
  if previewConvertElementCmpt ~= nil then
    previewConvertElementCmpt:SetTempConvertElementDic({})
  else
    Log.notice("Clear Convert Element no cmpt")
  end
end

function ClientActiveSkillSystem_Render:_DoRenderNotifyActiveSkillFinish(TT, teamEntity, casterEntity, activeSkillID)
  local isPetActiveSkill = self:_IsPetCastActiveSkill(teamEntity)
  if isPetActiveSkill then
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTActiveSkillAttackEnd:New(casterEntity))
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTActiveSkillDamageEnd:New(casterEntity))
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTActiveSkillCostCasterHPEnd:New(casterEntity))
  end
  if casterEntity:HasTrapID() then
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTTrapActiveSkillEnd:New(casterEntity, activeSkillID))
  end
end

function ClientActiveSkillSystem_Render:_DoRenderNotifyActiveFinishBeforeMonsterDead(TT, teamEntity, casterEntity)
  local isPetActiveSkill = self:_IsPetCastActiveSkill(teamEntity)
  if isPetActiveSkill then
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTActiveSkillDamageEnd:New(casterEntity))
    self._world:GetService("PlayBuff"):PlayBuffView(TT, NTActiveSkillAttackEndBeforeMonsterDead:New(casterEntity))
  end
end

function ClientActiveSkillSystem_Render:_DoRenderGuideActiveSkillEnd(TT, teamEntity, casterEntity)
  local guideService = self._world:GetService("Guide")
  local guideTaskId = guideService:Trigger(GameEventType.GuidePlayerSkillFinish, GuidePlaySkillFinish.MainSkillFinish, casterEntity)
  while not TaskHelper:GetInstance():IsTaskFinished(guideTaskId, true) do
    YIELD(TT)
  end
end

function ClientActiveSkillSystem_Render:_DoRenderGuideActiveSkillRealEnd(TT, teamEntity, casterEntity)
  local guideService = self._world:GetService("Guide")
  local guideTaskId = guideService:Trigger(GameEventType.GuidePlayerSkillRealFinish, GuidePlaySkillFinish.MainSkillFinish, casterEntity)
  while not TaskHelper:GetInstance():IsTaskFinished(guideTaskId, true) do
    YIELD(TT)
  end
end

function ClientActiveSkillSystem_Render:_DoRenderShowAfterActiveSkill(TT, teamEntity, casterEntity)
  local isPetActiveSkill = self:_IsPetCastActiveSkill(teamEntity)
  if not isPetActiveSkill then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowCanMoveArrow)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TrapPowerVisible, true)
  end
  local playSkillService = self._world:GetService("PlaySkill")
  playSkillService:ShowPlayerEntity(teamEntity)
  self._world:MainCamera():EnableEffectCamera(false)
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  previewActiveSkillService:StopDarkScreenImmediately()
  self:_RefreshAllHpPos()
end

function ClientActiveSkillSystem_Render:_RefreshAllHpPos()
  local hpGroup = self._world:GetGroup(self._world.BW_WEMatchers.HP)
  if hpGroup then
    local targetEntitys = hpGroup:GetEntities()
    if targetEntitys then
      for i, e in ipairs(targetEntitys) do
        local hpCmpt = e:HP()
        if hpCmpt then
          hpCmpt:SetHPPosDirty(true)
        end
      end
    end
  end
end

function ClientActiveSkillSystem_Render:_DoRenderPlayActiveSkill(isFinalAttack, teamEntity, casterEntity)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local result = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ActiveAttack)
  local skillResult = result:GetSkillResult()
  local activeSkillID = result:GetL2RActiveAttackResult_SkillID()
  if casterEntity:HasPetPstID() then
    GameGlobal.UAReportForceGuideEvent("FightSpellMainSkill", {
      activeSkillID,
      casterEntity:PetPstID():GetTemplateID()
    }, false, true)
  end
  local playSkillService = self._world:GetService("PlaySkill")
  local configService = self._world:GetService("Config")
  local skinId = 1
  if casterEntity:MatchPet() then
    skinId = casterEntity:MatchPet():GetMatchPet():GetSkinId()
  end
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, casterEntity)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray(skinId)
  if not table.icontains(BattleConst.NoShowCasterEntityOnPreview, activeSkillID) then
    playSkillService:ShowCasterEntity(casterEntity:GetID())
  end
  casterEntity:SkillRoutine():ClearSkillRoutine()
  casterEntity:SkillRoutine():SetResultContainer(skillResult)
  self:_CheckFreezeTime(casterEntity, isFinalAttack)
  if skillResult:GetIsInvalidated() then
    casterEntity:SetViewVisible(false)
    casterEntity:SetViewVisible(true)
    return
  end
  local waitTaskID = playSkillService:StartSkillRoutine(casterEntity, skillPhaseArray, activeSkillID)
  return waitTaskID
end

function ClientActiveSkillSystem_Render:_CheckFreezeTime(casterEntity, isFinalAttack)
  if not casterEntity:HasPetPstID() then
    return
  end
  if not isFinalAttack then
    return
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local targetIDArray = scopeResult:GetTargetIDs()
  if table.count(targetIDArray) <= 0 then
    return
  end
  skillEffectResultContainer:SetFinalAttack(true)
  self:_SelectFinalAttackEntityID(skillEffectResultContainer)
  self:_PatchFinalAttackForSpecificPet(casterEntity, skillEffectResultContainer)
end

function ClientActiveSkillSystem_Render:_SelectFinalAttackEntityID(skillEffectResultContainer)
  local results = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.RandAttack)
  if results ~= nil then
    local count = results:GetListDefenderCount()
    if 0 < count then
      skillEffectResultContainer:SetFinalAttackEntityID(-1)
    end
  end
end

function ClientActiveSkillSystem_Render:_PatchFinalAttackForSpecificPet(casterEntity, container)
  if not casterEntity:HasPetPstID() then
    return
  end
  local cPetPstID = casterEntity:PetPstID()
  if cPetPstID:GetTemplateID() == 1600271 then
    local buffViewCmpt = casterEntity:BuffView()
    if buffViewCmpt:HasBuffByID(4300271) or buffViewCmpt:HasBuffByID(4300272) then
      local skillHolderName = "default"
      local skillHolderID = casterEntity:GetSkillHolder(skillHolderName)
      local skillHolder = self._world:GetEntityByID(skillHolderID)
      if not skillHolder then
        return
      end
      local skillEffectResultContainer = skillHolder:SkillRoutine():GetResultContainer()
      local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
      local hasTargetDamageResultArray = {}
      if damageResultArray then
        for _, v in ipairs(damageResultArray) do
          local damageResult = v
          local targetEntityID = damageResult:GetTargetID()
          local targetEntity = self._world:GetEntityByID(targetEntityID)
          if targetEntity then
            table.insert(hasTargetDamageResultArray, damageResult)
          end
        end
      end
      if table.count(hasTargetDamageResultArray) > 0 then
        container:SetFinalAttack(false)
      end
    end
  end
end

function ClientActiveSkillSystem_Render:_DoRenderInWave(TT, traps, monsters)
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  sMonsterShowRender:PlaySpawnInWave(TT, traps, monsters)
end

function ClientActiveSkillSystem_Render:_DoRenderMonsterDead(TT, teamEntity, casterEntity)
  local monsterDeadGroup = self._world:GetGroup(self._world.BW_WEMatchers.DeadFlag)
  for i, e in ipairs(monsterDeadGroup:GetEntities()) do
    if e:HasMonsterID() and not e:HasShowDeath() then
      self._world:GetService("PlayBuff"):PlayBuffView(TT, NTCollectSouls:New(casterEntity, 1, {e}))
    end
  end
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  sMonsterShowRender:DoAllMonsterDeadRender(TT)
end

function ClientActiveSkillSystem_Render:_DoRenderPlayAntiAttack(TT, monsterEntityIDArray)
  local playAISvc = self._world:GetService("PlayAI")
  if playAISvc == nil then
    return
  end
  local refreshAntiEntityIDList = {}
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local recorderCmpt = renderBoardEntity:AIRecorder()
  local orderList = recorderCmpt:GetOrderList()
  playAISvc:PlayParallelSpellResult(TT)
  for i, order in ipairs(orderList) do
    recorderCmpt:SetCurrentOrder(order)
    local entityIDList = recorderCmpt:GetAICasterIDList()
    for _, entityID in ipairs(entityIDList) do
      table.insert(refreshAntiEntityIDList, entityID)
    end
  end
  for _, entityID in ipairs(monsterEntityIDArray) do
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateAntiActiveSkill, entityID)
  end
  playAISvc:DoCommonRountine(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  for _, id in ipairs(monsterEntityIDArray) do
    local nt = NTMonsterPostAntiAttack:New(self._world:GetEntityByID(id))
    playBuffSvc:PlayBuffView(TT, nt)
  end
  return refreshAntiEntityIDList
end

function ClientActiveSkillSystem_Render:_DoRenderResetPickUp()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  pickUpTargetCmpt:Reset()
end

function ClientActiveSkillSystem_Render:_DoRenderPlayBuffAntiAttack(TT, teamEntity, casterEntity)
  local isPetActiveSkill = self:_IsPetCastActiveSkill(teamEntity)
  if isPetActiveSkill then
    local ntActiveSkillAntiAttack = NTActiveSkillAntiAttack:New(casterEntity)
    self._world:GetService("PlayBuff"):PlayBuffView(TT, ntActiveSkillAntiAttack)
  end
end

function ClientActiveSkillSystem_Render:_DoRenderRefreshAntiAttackParam(TT, refreshAntiEntityIDList)
  if not refreshAntiEntityIDList or table.count(refreshAntiEntityIDList) == 0 then
    return
  end
  for _, entityID in ipairs(refreshAntiEntityIDList) do
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateAntiActiveSkill, entityID)
  end
end

function ClientActiveSkillSystem_Render:_DoRenderActiveSkillEnd(TT, teamEntity, casterEntity)
  if casterEntity then
    casterEntity:RemoveRenderPickUpComponent()
  end
end

function ClientActiveSkillSystem_Render:_DoRenderPopStarHideCasterEntity(TT, casterEntity)
  if self._world:MatchType() ~= MatchType.MT_PopStar then
    return
  end
  if casterEntity:HasPetPstID() then
    casterEntity:SetViewVisible(false)
  end
end
