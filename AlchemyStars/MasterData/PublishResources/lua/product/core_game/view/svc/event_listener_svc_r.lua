_class("EventListenerServiceRender", BaseService)
EventListenerServiceRender = EventListenerServiceRender

function EventListenerServiceRender:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._preClickSkillID = -1
  self._currentSkillID = -1
  self._autoBinder = AutoEventBinder:New(self._world:EventDispatcher())
  self._autoBinder:BindEvent(GameEventType.MatchStart, self, self._OnMatchStart)
  Log.notice("EventListenerServiceRender start")
  self._autoBinder:BindEvent(GameEventType.ClickPetHead, self, self._OnClickPetHead)
  self._autoBinder:BindEvent(GameEventType.ClickTrapHead, self, self._OnClickTrapHead)
  self._autoBinder:BindEvent(GameEventType.ClickPersonaSkill, self, self._OnClickPersonaSkill)
  self._autoBinder:BindEvent(GameEventType.StopPreviewActiveSkill, self, self._StopPreviewActiveSkill)
  self._autoBinder:BindEvent(GameEventType.CasterPreviewAnimatorExitPreview, self, self._CasterPreviewAnimatorExitPreview)
  self._autoBinder:BindEvent(GameEventType.StopPreviewFeatureSkill, self, self._StopPreviewFeatureSkill)
  self._autoBinder:BindEvent(GameEventType.CastActiveSkill, self, self.OnCastActiveSkill)
  self._autoBinder:BindEvent(GameEventType.CastActiveSkillNoPet, self, self.OnCastActiveSkillNoPet)
  self._autoBinder:BindEvent(GameEventType.CastPersonaSkill, self, self.OnCastPersonaSkill)
  self._autoBinder:BindEvent(GameEventType.ActiveSkillPickUp, self, self.OnActiveSkillPickUp)
  self._autoBinder:BindEvent(GameEventType.CancelActiveSkillCast, self, self.OnCancelActiveSkillCast)
  self._autoBinder:BindEvent(GameEventType.CastPickUpSkill, self, self.OnCastPickUpSkill)
  self._autoBinder:BindEvent(GameEventType.CastShopSkill, self, self.OnCastShopSkill)
  self._autoBinder:BindEvent(GameEventType.CancelChainSkillCast, self, self.OnCancelChainSkillCast)
  self._autoBinder:BindEvent(GameEventType.CastPickUpChainSkill, self, self.OnCastPickUpChainSkill)
  self._autoBinder:BindEvent(GameEventType.CancelReborn, self, self.OnCancelReborn)
  self._autoBinder:BindEvent(GameEventType.PreClickPetHead, self, self.OnPreClickHead)
  self._autoBinder:BindEvent(GameEventType.AutoFight, self, self._AutoFight)
  self._autoBinder:BindEvent(GameEventType.DoubleSpeed, self, self._DoubleSpeed)
  self._autoBinder:BindEvent(GameEventType.ChangeTeamLeader, self, self._ChangeTeamLeader)
  self._autoBinder:BindEvent(GameEventType.UIChangeTeamLeader, self, self._OnUIChangeTeamLeader)
  self._autoBinder:BindEvent(GameEventType.DumpSyncLog, self, self._DumpSyncLog)
  self._autoBinder:BindEvent(GameEventType.SpecialMissionQuitGame, self, self.OnSpecialMissionQuitGame)
  self._autoBinder:BindEvent(GameEventType.ClickUI2ClosePreviewMonster, self, self.OnClickUI2ClosePreviewMonster)
  self._autoBinder:BindEvent(GameEventType.OnUIGMCheatCommand, self, self.OnUIGMCheatCommand)
  self._autoBinder:BindEvent(GameEventType.ClientExceptionReport, self, self.OnClientExceptionReport)
  self._autoBinder:BindEvent(GameEventType.BattleUISelectTargetTeamPosition, self, self.OnBattleUISelectTargetTeamPosition)
  self._autoBinder:BindEvent(GameEventType.ClearSelectedTeamOrderPosition, self, self.OnClearSelectedTeamOrderPosition)
  self._autoBinder:BindEvent(GameEventType.ChessUIInputMoveAction, self, self.OnChessUIInputMoveAction)
  self._autoBinder:BindEvent(GameEventType.ChessUIInputAttackAction, self, self.OnChessUIInputAttackAction)
  self._autoBinder:BindEvent(GameEventType.ChessUIInputSkipAction, self, self.OnChessUIInputSkipAction)
  self._autoBinder:BindEvent(GameEventType.ChessUIInputFinishTurnAction, self, self.OnChessUIInputFinishTurnAction)
  self._autoBinder:BindEvent(GameEventType.GuideChessClick, self, self.OnGuideChessClick)
  self._autoBinder:BindEvent(GameEventType.UIMiniMazeChooseWaveAward, self, self.OnUIMiniMazeChooseWaveAward)
  self._autoBinder:BindEvent(GameEventType.GuideMonsterClick, self, self.OnGuideMonsterClick)
  self._autoBinder:BindEvent(GameEventType.ScanFeatureSaveInfo, self, self.OnScanFeatureSaveInfo)
  self._autoBinder:BindEvent(GameEventType.MirageUIClearPickUp, self, self.OnMirageUIClearPickUp)
  self._autoBinder:BindEvent(GameEventType.MirageUIConfirmPickUp, self, self.OnMirageUIConfirmPickUp)
  self._autoBinder:BindEvent(GameEventType.MirageUICountDownOver, self, self.OnMirageUICountDownOver)
  self._autoBinder:BindEvent(GameEventType.MirageUIRefreshStep, self, self.OnMirageUIRefreshStep)
  self._autoBinder:BindEvent(GameEventType.UIBattleSwitchPetEquipRefine, self, self.OnSwitchPetEquipRefine)
  self._autoBinder:BindEvent(GameEventType.UIBlackChange, self, self.OnResolutionChanged)
  self._autoBinder:BindEvent(GameEventType.PopStarPickUp, self, self.OnPopStarPickUp)
  self._autoBinder:BindEvent(GameEventType.UIChooseEnterPuzzle, self, self.OnEnterPuzzle)
  self._autoBinder:BindEvent(GameEventType.SyncClientUnscaledCountDownFinish, self, self.OnSyncClientUnscaledCountDownFinish)
  self._autoBinder:BindEvent(GameEventType.UIShowChangeTeamLeaderData, self, self.HandleShowChangeTeamLeader)
  self._autoBinder:BindEvent(GameEventType.IstavanPreviewChoosePetHeadUI, self, self.OnSPIstavanChoosePetHead)
  self._autoBinder:BindEvent(GameEventType.UITetrisOP, self, self.OnTetrisFeatureOP)
  self._fightResultEventListener = FightResultEventListenerRender:New(self._world, self._autoBinder)
end

function EventListenerServiceRender:Dispose()
  self._autoBinder:UnBindAllEvents()
end

function EventListenerServiceRender:_OnMatchStart()
  local battleRenderConfigCmpt = self._world:BattleRenderConfig()
  battleRenderConfigCmpt:SetIsMatchStart(true)
end

function EventListenerServiceRender:_OnClickPetHead(castSkillPetPstID, energyReady, curSkillID)
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  local playSkillService = self._world:GetService("PlaySkill")
  local configService = self._world:GetService("Config")
  if castSkillPetPstID ~= 0 then
    local e = self._world:Player():GetPetEntityByPetPstID(castSkillPetPstID)
    local skillInfoComponent = e:SkillInfo()
    local skillID = skillInfoComponent:GetActiveSkillID()
    local hp = e:HP()
    hp:SetHPPosDirty(true, false)
    if curSkillID then
      local skillConfigData = configService:GetSkillConfigData(skillID, e)
      local subSkillList = skillConfigData:GetSubSkillIDList()
      if 0 < #subSkillList and table.icontains(subSkillList, curSkillID) then
        skillID = curSkillID
      else
        local extraSkillList = skillInfoComponent:GetExtraActiveSkillIDList()
        if extraSkillList and table.icontains(extraSkillList, curSkillID) then
          skillID = curSkillID
        else
          local variantActiveSkillInfo = skillInfoComponent:GetVariantActiveSkillInfo()
          if variantActiveSkillInfo then
            local variantList = variantActiveSkillInfo[skillID]
            if variantList and table.icontains(variantList, curSkillID) then
              skillID = curSkillID
            end
          end
        end
      end
    end
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
    pickUpTargetCmpt:SetCurActiveSkillInfo(skillID, castSkillPetPstID)
    e:ReplacePreviewActiveSkill(skillID, castSkillPetPstID)
    if self._world:MatchType() == MatchType.MT_PopStar then
      local popStarRSvc = self._world:GetService("PopStarRender")
      popStarRSvc:PopStarShowCasterEntity(castSkillPetPstID)
    elseif not table.icontains(BattleConst.NoShowCasterEntityOnPreview, skillID) then
      local skillConfigData = configService:GetSkillConfigData(skillID, e)
      local pickUpType = skillConfigData:GetSkillPickType()
      if pickUpType ~= SkillPickUpType.LinkLineSP then
        playSkillService:ShowCasterEntity(e:GetID())
      end
    end
    self:_PreviewSkill(skillID, castSkillPetPstID)
  end
end

function EventListenerServiceRender:_OnClickTrapHead(skillID, trapEntityID, energyReady)
  if self._preClickSkillID ~= skillID then
    Log.fatal("click head skill not match", self._preClickSkillID, skillID)
    return
  end
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  local trap = self._world:GetEntityByID(trapEntityID)
  if not trap then
    return
  end
  trap:RemovePreviewPickUpComponent()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  pickUpTargetCmpt:SetCurActiveSkillInfo(skillID, -1)
  pickUpTargetCmpt:SetEntityID(trap:GetID())
  trap:ReplacePreviewActiveSkill(skillID, trapEntityID)
  local playSkillService = self._world:GetService("PlaySkill")
  playSkillService:ShowCasterEntity(trap:GetID())
  local pickUpCmpt = self._world:PickUp()
  pickUpCmpt:SetCurActiveSkillInfo(skillID, -1)
  pickUpCmpt:SetEntityID(trap:GetID())
  self:_PreviewSkill(skillID, trapEntityID)
end

function EventListenerServiceRender:_OnClickPersonaSkill(featureType, skillID)
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  if self._world:MatchType() == MatchType.MT_PopStar then
    local popStarRSvc = self._world:GetService("PopStarRender")
    popStarRSvc:PopStarShowCasterEntity(-1)
  end
  local skillHolder = FeatureServiceHelper.GetFeatureSkillHolderEntity(featureType)
  local e = skillHolder
  if not e then
    return
  end
  e:RemovePreviewPickUpComponent()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  pickUpTargetCmpt:SetCurActiveSkillInfo(skillID, -1)
  pickUpTargetCmpt:SetEntityID(e:GetID())
  e:ReplacePreviewActiveSkill(skillID)
  local playSkillService = self._world:GetService("PlaySkill")
  local teamEntity = self._world:Player():GetPreviewTeamEntity()
  playSkillService:ShowPlayerEntity(teamEntity)
  if self._world:MatchType() ~= MatchType.MT_PopStar then
    local teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
    local teamLeaderEntity = self._world:GetEntityByID(teamLeaderEntityID)
    if teamLeaderEntity:HasView() then
      teamLeaderEntity:SetViewVisible(false)
      teamLeaderEntity:SetViewVisible(true)
    end
  end
  local pickUpCmpt = self._world:PickUp()
  pickUpCmpt:SetCurActiveSkillInfo(skillID, -1)
  pickUpCmpt:SetEntityID(e:GetID())
  local castSkillPetPstID = 0
  self:_PreviewSkill(skillID, castSkillPetPstID)
end

function EventListenerServiceRender:_PreviewSkill(skillID, castSkillPetPstID)
  local sPreviewSkill = self._world:GetService("PreviewActiveSkill")
  sPreviewSkill:StartPreviewFocusEffect()
  local skillConfigData = ConfigServiceHelper.GetSkillConfigData(skillID, castSkillPetPstID)
  local pickUpType = skillConfigData:GetSkillPickType()
  local curState = self:_GetCurState()
  if pickUpType == SkillPickUpType.None then
    if curState == GameStateID.WaitInput then
      self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 3)
    elseif curState == GameStateID.PickUpActiveSkillTarget then
      self._world:EventDispatcher():Dispatch(GameEventType.PickUpActiveSkillTargetFinish, 3)
    elseif curState == GameStateID.PreviewActiveSkill then
    else
      Log.fatal("preview skill state error:", curState)
    end
  elseif pickUpType == SkillPickUpType.FeatureSkipPreview then
    self._world.EventDispatcher():Dispatch(GameEventType.CastPersonaSkill, skillID)
  elseif curState == GameStateID.WaitInput then
    sPreviewSkill:PlaySkillView_Preview(self._world, skillID, castSkillPetPstID, true)
    self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 3)
  elseif curState == GameStateID.PickUpActiveSkillTarget then
    sPreviewSkill:PlaySkillView_Preview(self._world, skillID, castSkillPetPstID, true)
    self._world:EventDispatcher():Dispatch(GameEventType.PickUpActiveSkillTargetFinish, 3)
  elseif curState == GameStateID.PreviewActiveSkill then
    sPreviewSkill:PlaySkillView_Preview(self._world, skillID, castSkillPetPstID, true)
  else
    Log.fatal("preview pick up skill state error:", curState)
  end
end

function EventListenerServiceRender:_GetCurState()
  local utilDataSvc = self._world:GetService("UtilData")
  return utilDataSvc:GetCurMainStateID()
end

function EventListenerServiceRender:_CasterPreviewAnimatorExitPreview(petPstID, activeSkillID)
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityID = utilDataSvc:GetEntityIDByPstID(petPstID)
  if not petEntityID then
    return
  end
  local petEntity = self._world:GetEntityByID(petEntityID)
  if not petEntity then
    return
  end
  if not activeSkillID then
    return
  end
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID, petEntity)
  local pickUpType = skillConfigData:GetSkillPickType()
  if pickUpType == SkillPickUpType.None then
    return
  end
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  previewActiveSkillService:PlayCasterPreviewAnim(petEntity, false, "AtkUltPreviewCancel")
end

function EventListenerServiceRender:_StopPreviewActiveSkill(isSwitch, bShowPlayerEntity, activeSkillID, petPstID)
  local teamEntity = self._world:Player():GetPreviewTeamEntity()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  if isSwitch ~= true then
    previewActiveSkillService:StopDarkScreenImmediately()
  end
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  GameGlobal.TaskManager():CoreGameStartTask(self.DoCancelPreviewInstruction, self, activeSkillID, petPstID)
  if bShowPlayerEntity then
    local playSkillService = self._world:GetService("PlaySkill")
    playSkillService:ShowPlayerEntity(teamEntity)
  end
  previewActiveSkillService:_DestroyPickUpArrow()
  local flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID):GetEntities()
  for _, v in ipairs(flashEnemyEntities) do
    local comp = v:MaterialAnimationComponent()
    if comp then
      comp:StopLayer(MaterialAnimLayer.SkillPreview)
    end
  end
  previewActiveSkillService:ResetPreview()
  previewActiveSkillService:_ClearPreviewActiveSkill(isSwitch)
  previewActiveSkillService:ClearPreviewLinkLine(activeSkillID, petPstID)
  local pieceService = self._world:GetService("Piece")
  pieceService:RefreshPieceAnim()
end

function EventListenerServiceRender:_StopPreviewFeatureSkill(isSwitch, bShowPlayerEntity, featureSkillID, featureType)
  local teamEntity = self._world:Player():GetPreviewTeamEntity()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  if isSwitch ~= true then
    previewActiveSkillService:StopDarkScreenImmediately()
  end
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  GameGlobal.TaskManager():CoreGameStartTask(self.DoFeatureCancelPreviewInstruction, self, featureSkillID, featureType)
  if bShowPlayerEntity then
    local playSkillService = self._world:GetService("PlaySkill")
    playSkillService:ShowPlayerEntity(teamEntity)
  end
  previewActiveSkillService:_DestroyPickUpArrow()
  local flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID):GetEntities()
  for _, v in ipairs(flashEnemyEntities) do
    local comp = v:MaterialAnimationComponent()
    if comp then
      comp:StopLayer(MaterialAnimLayer.SkillPreview)
    end
  end
  previewActiveSkillService:ResetPreview()
  previewActiveSkillService:_ClearPreviewActiveSkill(isSwitch)
  local pieceService = self._world:GetService("Piece")
  pieceService:RefreshPieceAnim()
end

function EventListenerServiceRender:CastPickUpActiveSkill(TT, activeSkillID, petPstID, entityID)
  local configService = self._configService
  local utilDataSvc = self._world:GetService("UtilData")
  local casterPetEntityID = utilDataSvc:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(casterPetEntityID)
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  previewActiveSkillService:_DestroyPickUpArrow()
  previewActiveSkillService:_RevertBright()
  local flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID):GetEntities()
  for _, v in ipairs(flashEnemyEntities) do
    local comp = v:MaterialAnimationComponent()
    if comp then
      comp:StopLayer(MaterialAnimLayer.SkillPreview)
    end
  end
  previewActiveSkillService:ResetPreview()
  previewActiveSkillService:_ClearPreviewActiveSkill(false, true)
  if skillConfigData:GetSkillType() == SkillType.Active then
    if casterPetEntityID < 0 then
      Log.fatal("caster entity id invalid")
      return
    end
    self:_LogPetCasterInfo(casterPetEntityID, activeSkillID)
    skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
    local pickUpType = skillConfigData:GetSkillPickType()
    local previewPickUpComponent = petEntity:PreviewPickUpComponent()
    local canSendBefore, errorTypeBefore = self:_CheckCanSendActivePickSkillCmd(previewPickUpComponent, petEntity, activeSkillID, pickUpType)
    if canSendBefore then
      self:DoActiveSkillInstruction(TT, activeSkillID, petPstID)
      local canSend, errorType = self:_CheckCanSendActivePickSkillCmd(previewPickUpComponent, petEntity, activeSkillID, pickUpType)
      self._world:GetService("Piece"):RefreshPieceAnim()
      if canSend then
        self:SendCastPickUpActiveSkillCommand(activeSkillID, petPstID, previewPickUpComponent)
        if pickUpType == SkillPickUpType.LinkLine or pickUpType == SkillPickUpType.LinkLineSP or pickUpType == SkillPickUpType.Moye then
          local inputCmpt = self._world:Input()
          inputCmpt:SetPreviewActiveSkill(false)
        end
      else
        local errorStep = ActivePickSkillCheckErrorStep.SendBeforeAfterDoIns
        self:_OnCastActivePickSkillFail(errorStep, errorType, activeSkillID, petPstID, previewPickUpComponent)
      end
    else
      local errorStep = ActivePickSkillCheckErrorStep.SendBeforeDoIns
      self:_OnCastActivePickSkillFail(errorStep, errorTypeBefore, activeSkillID, petPstID, previewPickUpComponent)
    end
  elseif skillConfigData:GetSkillType() == SkillType.TrapSkill then
    self:DoActiveSkillInstruction(TT, activeSkillID, petPstID, entityID)
    local casterEntity = self._world:GetEntityByID(entityID)
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    self._world:GetService("Piece"):RefreshPieceAnim()
    self:SendCastPickUpActiveSkillCommand(activeSkillID, 0, previewPickUpComponent, entityID)
  elseif skillConfigData:GetSkillType() == SkillType.FeatureSkill then
    self:DoActiveSkillInstruction(TT, activeSkillID, petPstID, entityID)
    local casterEntity = self._world:GetEntityByID(entityID)
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    self._world:GetService("Piece"):RefreshPieceAnim()
    self:SendCastPickUpActiveSkillCommand(activeSkillID, 0, previewPickUpComponent, entityID)
  end
end

function EventListenerServiceRender:OnCastActiveSkill(activeSkillID, petPstID)
  local utilDataSvc = self._world:GetService("UtilData")
  local casterPetEntityID = utilDataSvc:GetEntityIDByPstID(petPstID)
  if casterPetEntityID < 0 then
    Log.fatal("caster entity id invalid")
    return
  end
  local e = self._world:GetEntityByID(casterPetEntityID)
  local configService = self._configService
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local pickUpType = skillConfigData:GetSkillPickType()
  local playSkillService = self._world:GetService("PlaySkill")
  if not table.icontains(BattleConst.NoShowCasterEntityOnPreview, activeSkillID) and pickUpType ~= SkillPickUpType.LinkLineSP then
    playSkillService:ShowCasterEntity(casterPetEntityID)
  end
  local petEntity = self._world:GetEntityByID(casterPetEntityID)
  petEntity:RemovePreviewPickUpComponent()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  if pickUpType == SkillPickUpType.None then
    self:_LogPetCasterInfo(casterPetEntityID, activeSkillID)
    previewActiveSkillService:_RevertBright()
    previewActiveSkillService:ResetPreview()
    previewActiveSkillService:_ClearPreviewActiveSkill(false, true)
    self._world:GetService("Piece"):RefreshPieceAnim()
    self:SendCastActiveSkillCommand(activeSkillID, petPstID)
    GameGlobal.TaskManager():CoreGameStartTask(self.DoActiveSkillInstruction, self, activeSkillID, petPstID)
  else
    local monsterEntities = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID):GetEntities()
    for _, v in ipairs(monsterEntities) do
      if v:BuffView() and not v:BuffView():HasBuffEffect(BuffEffectType.NotPlayMaterialAnimation) then
        v:NewEnableTransparent()
      end
    end
    local pickUpCmpt = self._world:PickUp()
    pickUpCmpt:SetCurActiveSkillInfo(activeSkillID, petPstID)
    Log.notice("cast pick up active skill", activeSkillID)
  end
end

function EventListenerServiceRender:OnCastActiveSkillNoPet(activeSkillID, trapEntityID)
  local trap = self._world:GetEntityByID(trapEntityID)
  local entityPos = trap:GridLocation():CenterNoOffset()
  local configService = self._configService
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local pickUpType = skillConfigData:GetSkillPickType()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  if pickUpType == SkillPickUpType.None then
    previewActiveSkillService:_RevertBright()
    previewActiveSkillService:ResetPreview()
    previewActiveSkillService:_ClearPreviewActiveSkill(false, true)
    self._world:GetService("Piece"):RefreshPieceAnim()
    self:SendCastActiveSkillCommand(activeSkillID, 0, trap:GetID())
  else
    local monsterEntities = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID):GetEntities()
    for _, v in ipairs(monsterEntities) do
      if v:BuffView() and not v:BuffView():HasBuffEffect(BuffEffectType.NotPlayMaterialAnimation) then
        v:NewEnableTransparent()
      end
    end
    local pickUpCmpt = self._world:PickUp()
    pickUpCmpt:SetCurActiveSkillInfo(activeSkillID, -1)
    pickUpCmpt:SetEntityID(trap:GetID())
    Log.notice("cast pick up active skill", activeSkillID)
  end
end

function EventListenerServiceRender:OnCastPersonaSkill(personaSkillID)
  local configService = self._configService
  local skillConfigData = configService:GetSkillConfigData(personaSkillID)
  local pickUpType = skillConfigData:GetSkillPickType()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  if pickUpType == SkillPickUpType.None or pickUpType == SkillPickUpType.FeatureSkipPreview then
    previewActiveSkillService:_RevertBright()
    previewActiveSkillService:ResetPreview()
    previewActiveSkillService:_ClearPreviewActiveSkill(false, true)
    self._world:GetService("Piece"):RefreshPieceAnim()
    self:SendCastActiveSkillCommand(personaSkillID, 0, nil)
  else
    local monsterEntities = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID):GetEntities()
    for _, v in ipairs(monsterEntities) do
      if v:BuffView() and not v:BuffView():HasBuffEffect(BuffEffectType.NotPlayMaterialAnimation) then
        v:NewEnableTransparent()
      end
    end
    local pickUpCmpt = self._world:PickUp()
    local petPstID = 0
    pickUpCmpt:SetCurActiveSkillInfo(personaSkillID, petPstID)
    Log.notice("cast pick up personaSkillID skill", personaSkillID)
  end
end

function EventListenerServiceRender:OnCastShopSkill(skillID, selectInfo)
  local configService = self._configService
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local pickUpType = skillConfigData:GetSkillPickType()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  if pickUpType == SkillPickUpType.None then
    previewActiveSkillService:_RevertBright()
    previewActiveSkillService:ResetPreview()
    previewActiveSkillService:_ClearPreviewActiveSkill(false, true)
    self._world:GetService("Piece"):RefreshPieceAnim()
    self:SendCastSelectInfoActiveSkillCommand(skillID, 0, selectInfo)
  else
    local monsterEntities = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID):GetEntities()
    for _, v in ipairs(monsterEntities) do
      if v:BuffView() and not v:BuffView():HasBuffEffect(BuffEffectType.NotPlayMaterialAnimation) then
        v:NewEnableTransparent()
      end
    end
    local pickUpCmpt = self._world:PickUp()
    local petPstID = 0
    pickUpCmpt:SetCurActiveSkillInfo(skillID, petPstID)
    Log.notice("cast pick up shop skill", skillID)
  end
end

function EventListenerServiceRender:OnActiveSkillPickUp(activeSkillID, petPstID)
  local skillConfigData = ConfigServiceHelper.GetSkillConfigData(activeSkillID, petPstID)
  local pickUpType = skillConfigData:GetSkillPickType()
  local curState = self:_GetCurState()
  if curState == GameStateID.PreviewActiveSkill then
    if pickUpType == SkillPickUpType.LinkLine or pickUpType == SkillPickUpType.Moye then
      local inputCmpt = self._world:Input()
      inputCmpt:SetPreviewActiveSkill(true)
    end
    if pickUpType == SkillPickUpType.LinkLineSP then
      self:OnPet1702361ActiveStart(activeSkillID, petPstID)
    else
      self._world:EventDispatcher():Dispatch(GameEventType.PreviewActiveSkillFinish, 3)
      local utilStatSvc = self._world:GetService("UtilData")
      if not utilStatSvc:GetStatAutoFight() then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.PickUPValidGridShowChooseTarget, true)
      end
      local sPreviewSkill = self._world:GetService("PreviewActiveSkill")
      if pickUpType == SkillPickUpType.PickUpUIAndTrap then
        sPreviewSkill:PlaySkillView_PlayPickUI(self._world, activeSkillID, petPstID, true)
      end
    end
  end
end

function EventListenerServiceRender:OnCancelActiveSkillCast(activeSkillID, petPstID)
  local taskManager = GameGlobal.TaskManager()
  local nTaskID = taskManager:CoreGameStartTask(self.TT_OnCancelActiveSkillCast, self, activeSkillID, petPstID)
  local configService = self._configService
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  if not skillConfigData then
    Log.exception("OnCancelActiveSkillCast no skill config ,skillId: ", activeSkillID)
    return
  end
  if skillConfigData:GetSkillType() == SkillType.TrapSkill then
    local casterEntity = self._world:GetEntityByID(petPstID)
    if casterEntity then
      casterEntity:RemovePreviewPickUpComponent()
    end
  end
end

function EventListenerServiceRender:TT_OnCancelActiveSkillCast(TT, activeSkillID, petPstID)
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  previewActiveSkillService:CancelActiveSkillCast(TT, activeSkillID, petPstID)
end

function EventListenerServiceRender:OnCancelChainSkillCast(skillID, petPstID)
  local function TT_OnCancelChainSkillCast(TT)
    local sPreviewSkill = self._world:GetService("PreviewActiveSkill")
    
    sPreviewSkill:ClearChainPreviewData()
    sPreviewSkill:StopPreviewChainSkill(TT)
    YIELD(TT, 200)
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local renderBoardCmpt = renderBoardEntity:RenderBoard()
    local taskID = renderBoardCmpt:GetDimensionClearPreviewTaskID()
    while not TaskHelper:GetInstance():IsTaskFinished(taskID) do
      YIELD(TT)
    end
    local cmd = CancelChainSkillCommand:New()
    self._world:Player():SendCommand(cmd)
  end
  
  local taskManager = GameGlobal.TaskManager()
  local nTaskID = taskManager:CoreGameStartTask(TT_OnCancelChainSkillCast, self)
end

function EventListenerServiceRender:OnCastPickUpChainSkill()
  local function CastPickUpChainSkill(TT)
    local sPreviewSkill = self._world:GetService("PreviewActiveSkill")
    
    sPreviewSkill:ClearChainPreviewData()
    YIELD(TT, 200)
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local renderBoardCmpt = renderBoardEntity:RenderBoard()
    local taskID = renderBoardCmpt:GetDimensionClearPreviewTaskID()
    while not TaskHelper:GetInstance():IsTaskFinished(taskID) do
      YIELD(TT)
    end
    local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
    local cmd = CastPickUpChainSkillCommand:New()
    cmd:SetCmdPickUpResult(pickUpTargetCmpt:GetCurPickUpGridSafePos())
    self._world:Player():SendCommand(cmd)
  end
  
  GameGlobal.TaskManager():CoreGameStartTask(CastPickUpChainSkill, self)
end

function EventListenerServiceRender:DoActiveSkillInstruction(TT, activeSkillID, petPstID, entityID)
  if not activeSkillID or not petPstID then
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  petEntity = petEntity or self._world:GetEntityByID(entityID)
  local taskIDList = {}
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  for _, v in ipairs(skillConfigData._previewParamList) do
    if v:GetPreviewType() == SkillPreviewType.Instruction then
      local instructionParam = v
      for _, skillPreviewConfigData in pairs(instructionParam._previewList) do
        local instructionSet = skillPreviewConfigData:GetActiveSkillInstructionSet()
        if instructionSet then
          local previewContext = previewActiveSkillService:CreatePreviewContext(skillPreviewConfigData, petEntity)
          local taskID = GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkillService.DoPreviewInstruction, previewActiveSkillService, instructionSet, petEntity, previewContext)
          table.insert(taskIDList, taskID)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function EventListenerServiceRender:DoCancelPreviewInstruction(TT, activeSkillID, petPstID)
  if not activeSkillID or not petPstID then
    return
  end
  if activeSkillID <= 0 then
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  if not petEntity then
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
    local entityID = pickUpTargetCmpt:GetEntityID()
    petEntity = self._world:GetEntityByID(entityID)
  end
  if petEntity and petEntity:HasHP() then
    local hp = petEntity:HP()
    hp:SetHPPosDirty(true)
  else
    return
  end
  local taskIDList = {}
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  for _, v in ipairs(skillConfigData._previewParamList) do
    if v:GetPreviewType() == SkillPreviewType.Instruction then
      local instructionParam = v
      for _, skillPreviewConfigData in pairs(instructionParam._previewList) do
        local instructionSet = skillPreviewConfigData:GetCancelPreviewInstructionSet()
        if instructionSet then
          local previewContext = previewActiveSkillService:CreatePreviewContext(skillPreviewConfigData, petEntity)
          local taskID = GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkillService.DoPreviewInstruction, previewActiveSkillService, instructionSet, petEntity, previewContext)
          table.insert(taskIDList, taskID)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function EventListenerServiceRender:DoFeatureCancelPreviewInstruction(TT, featureSkillID, featureType)
  if not featureSkillID or not featureType then
    return
  end
  if featureSkillID <= 0 then
    return
  end
  local skillHolder = FeatureServiceHelper.GetFeatureSkillHolderEntity(featureType)
  local e = skillHolder
  if not e then
    return
  end
  local taskIDList = {}
  local skillConfigData = self._configService:GetSkillConfigData(featureSkillID)
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  for _, v in ipairs(skillConfigData._previewParamList) do
    if v:GetPreviewType() == SkillPreviewType.Instruction then
      local instructionParam = v
      for _, skillPreviewConfigData in pairs(instructionParam._previewList) do
        local instructionSet = skillPreviewConfigData:GetCancelPreviewInstructionSet()
        if instructionSet then
          local previewContext = previewActiveSkillService:CreatePreviewContext(skillPreviewConfigData, e)
          local taskID = GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkillService.DoPreviewInstruction, previewActiveSkillService, instructionSet, e, previewContext)
          table.insert(taskIDList, taskID)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function EventListenerServiceRender:OnCastPickUpSkill()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  if pickUpTargetCmpt == nil then
    Log.fatal("pick up target is nil")
    return
  end
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local entityID = pickUpTargetCmpt:GetEntityID()
  if entityID < 0 and petPstID < 0 or activeSkillID < 0 then
    Log.fatal("OnCastPickUpSkill id invalid")
    return
  end
  if SkillPickUpType.Puzzle == pickUpTargetCmpt:GetPickUpTargetType() then
    local previewPuzzleSvc = self._world:GetService("PreviewPuzzle")
    previewPuzzleSvc:LeavePuzzle()
  end
  GameGlobal.TaskManager():CoreGameStartTask(self.CastPickUpActiveSkill, self, activeSkillID, petPstID, entityID)
end

function EventListenerServiceRender:OnCancelReborn()
  GameGlobal.TaskManager():CoreGameStartTask(self._CancelRebornTask, self)
end

function EventListenerServiceRender:_CancelRebornTask(TT)
  Log.debug("[match] EventListenerServiceRender:_CancelRebornTask")
  local playerEntity = self._world:Player():GetLocalTeamEntity()
  local utilData = self._world:GetService("UtilData")
  if utilData:PlayerIsDead(playerEntity) and playerEntity then
    local deadTriggerParam = "Death"
    playerEntity:SetAnimatorControllerTriggers({deadTriggerParam})
    YIELD(TT, 1000)
  end
  if not GameSingle then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowGuideFailed)
    GuideHelper.IsUIGuideFailedComplete(TT)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowTransitionEffect)
  YIELD(TT, 1000)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowUIResult, false)
end

function EventListenerServiceRender:OnPreClickHead(skillID)
  self._preClickSkillID = skillID
end

function EventListenerServiceRender:GetPreClickHeadSkillID()
  return self._preClickSkillID
end

function EventListenerServiceRender:SendCastActiveSkillCommand(skillID, petPstID, casterTrapID)
  local cmd = CastActiveSkillCommand:New()
  cmd:SetCmdActiveSkillID(skillID)
  cmd:SetCmdCasterPstID(petPstID)
  if casterTrapID then
    cmd:SetCmdCasterTrapEntityID(casterTrapID)
  end
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:SendCastPickUpActiveSkillCommand(skillID, petPstID, previewPickUpComponent, casterTrapID)
  local utilDataSvc = self._world:GetService("UtilData")
  local casterPetEntityID = utilDataSvc:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(casterPetEntityID)
  local skillConfigData = self._configService:GetSkillConfigData(skillID, petEntity)
  local pickUpType = skillConfigData:GetSkillPickType()
  local canSend, errorType = self:_CheckCanSendActivePickSkillCmd(previewPickUpComponent, petEntity, skillID, pickUpType)
  if canSend then
    local cmd = CastPickUpActiveSkillCommand:New()
    cmd:SetCmdActiveSkillID(skillID)
    cmd:SetCmdCasterPstID(petPstID)
    if casterTrapID then
      cmd:SetCmdCasterTrapEntityID(casterTrapID)
    end
    local pickPosList = previewPickUpComponent:GetAllValidPickUpGridPos()
    cmd:SetCmdPickUpResult(pickPosList)
    cmd:SetPickUpDirectionResult(previewPickUpComponent:GetPickUpDirectionPos(), previewPickUpComponent:GetAllDirection(), previewPickUpComponent:GetLastPickUpDirection())
    cmd:SetReflectDir(previewPickUpComponent:GetReflectDir())
    cmd:SetCmdPickUpExtraParamResult(previewPickUpComponent:GetAllPickExtraParam())
    cmd:SetPickUpPetPstID(previewPickUpComponent:GetPickUpPetPstID())
    local utilDataSvcL = self._world:GetService("UtilData")
    if pickUpType == SkillPickUpType.PickUpAndTurnTetris then
      if not previewPickUpComponent:GetTetrisDirIndex() then
        Log.fatal("GetTetrisDirIndex Is Nil")
      end
      local newDirIndex = utilDataSvcL:GetFeatureTetrisDirIndex()
      local tetrisDirIndex = newDirIndex
      cmd:SetPickUpTetrisDirIndex(tetrisDirIndex)
    end
    self._world:Player():SendCommand(cmd)
    local curstateid = self:_GetCurState()
    Log.debug("EventListenerServiceRender:SendCastPickUpActiveSkillCommand gamefsm state ", curstateid)
  else
    Log.debug("EventListenerServiceRender:SendCastPickUpActiveSkillCommand error no previewPickUpComponent, skillID: ", skillID)
    local errorStep = ActivePickSkillCheckErrorStep.TrySend
    self:_OnCastActivePickSkillFail(errorStep, errorType, skillID, petPstID, previewPickUpComponent)
  end
  local worldPickUpCmpt = self._world:PickUp()
  worldPickUpCmpt:ResetPickUpData()
end

function EventListenerServiceRender:SendCastSelectInfoActiveSkillCommand(skillID, petPstID, selectInfo)
  local cmd = CastSelectInfoActiveSkillCommand:New()
  cmd:SetCmdActiveSkillID(skillID)
  cmd:SetCmdCasterPstID(petPstID)
  cmd:SetCmdSelectInfo(selectInfo)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:_AutoFight(enable)
  local cmd = AutoFightCommand:New()
  cmd:SetCmdAutoFight(enable)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:_DoubleSpeed(speed)
  self._world:RenderBattleStat():SetEverSpeed(speed)
end

function EventListenerServiceRender:_LogPetCasterInfo(casterPetEntityID, skillID)
  local petEntity = self._world:GetEntityByID(casterPetEntityID)
  if petEntity == nil then
    Log.notice("caster is nil:", skillID)
    return
  end
  local pstIDCmpt = petEntity:PetPstID()
  if pstIDCmpt == nil then
    return
  end
  local petTemplateID = pstIDCmpt:GetTemplateID()
  Log.notice("[Skill] Caster:", petTemplateID, ",skill:", skillID)
end

function EventListenerServiceRender:_ChangeTeamLeader(petPstID, oldPstID)
  local cmd = ChangeTeamLeaderCommand:New()
  cmd:SetNewTeamLeaderPstID(petPstID)
  cmd:SetOldTeamLeaderPstID(oldPstID)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:_OnUIChangeTeamLeader(newPetPstID, oldPetPstID, remainTimes, teamOrderBefore, teamOrderAfter)
  local renderBattleService = self._world:GetService("RenderBattle")
  renderBattleService:RenderChangeTeamLeader(newPetPstID, oldPetPstID)
  GameGlobal.TaskManager():CoreGameStartTask(self._OnPlayBuffViewTeamOrderChange, self, newPetPstID, teamOrderBefore, teamOrderAfter)
  GameGlobal.TaskManager():CoreGameStartTask(self._OnPlayBuffViewChangeTeamLeader, self, newPetPstID, oldPetPstID)
end

function EventListenerServiceRender:_OnPlayBuffViewChangeTeamLeader(TT, newPetPstID, oldPetPstID)
  local playBuffService = self._world:GetService("PlayBuff")
  local petEntity = self._world:Player():GetPetEntityByPetPstID(newPetPstID)
  local oldLeaderPetEntity = self._world:Player():GetPetEntityByPetPstID(oldPetPstID)
  playBuffService:PlayBuffView(TT, NTChangeTeamLeader:New(petEntity, oldLeaderPetEntity))
  local playDamageService = self._world:GetService("PlayDamage")
  playDamageService:OnTeamOrderChangeRefresh()
end

function EventListenerServiceRender:_OnPlayBuffViewTeamOrderChange(TT, newPetPstID, teamOrderBefore, teamOrderAfter)
  local playBuffService = self._world:GetService("PlayBuff")
  local petEntity = self._world:Player():GetPetEntityByPetPstID(newPetPstID)
  local cPet = petEntity:Pet()
  local eTeam = cPet:GetOwnerTeamEntity()
  playBuffService:PlayBuffView(TT, NTTeamOrderChange:New(eTeam, teamOrderBefore, teamOrderAfter))
  local playDamageService = self._world:GetService("PlayDamage")
  playDamageService:OnTeamOrderChangeRefresh()
end

function EventListenerServiceRender:_DumpSyncLog()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  utilCalcSvc:SaveSyncLog()
end

function EventListenerServiceRender:OnSpecialMissionQuitGame()
  local utilCalc = self._world:GetService("UtilCalc")
  local battleSvcR = self._world:GetService("RenderBattle")
  local battleResult = utilCalc:CalcBattleResult(self._world:MatchType(GetMatchTypeType.CalcBattleResult), true)
  battleSvcR:NotifyUIBattleGameOver(battleResult)
end

function EventListenerServiceRender:OnClickUI2ClosePreviewMonster()
  local prvwSvc = self._world:GetService("PreviewMonsterTrap")
  prvwSvc:ClearMonsterTrapPreview()
  if self._world:MatchType() == MatchType.MT_PopStar then
    local popStarRSvc = self._world:GetService("PopStarRender")
    popStarRSvc:StopPreviewPopStar()
  else
    self:HandleShowChangeTeamLeader()
  end
end

function EventListenerServiceRender:HandleShowChangeTeamLeader()
  if self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    local popStarProRSvc = self._world:GetService("PopStarProRender")
    popStarProRSvc:StopPreviewPopStar()
  end
end

function EventListenerServiceRender:OnUIGMCheatCommand(cmd)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnClientExceptionReport(cmd)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnBattleUISelectTargetTeamPosition(petPstID)
  local eTeam = self._world:Player():GetLocalTeamEntity()
  local ePet = eTeam:Team():GetPetEntityByPetPstID(petPstID)
  if not ePet then
    return
  end
  local targetPos = 0
  for index, pstID in ipairs(eTeam:Team():GetTeamOrder()) do
    if pstID == petPstID then
      targetPos = index
      break
    end
  end
  local cmd = CastSelectTeamOrderPositionCommand.GenerateCommand(eTeam:GetID(), petPstID, targetPos)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnClearSelectedTeamOrderPosition(petPstID)
  local eTeam = self._world:Player():GetLocalTeamEntity()
  local ePet = eTeam:Team():GetPetEntityByPetPstID(petPstID)
  if not ePet then
    return
  end
  local cmd = CastClearSelectedTeamOrderPositionCommand.GenerateCommand(eTeam:GetID(), petPstID)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnChessUIInputMoveAction()
  self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.FinishTurnOnly)
  self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateBlockRaycast, false)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpResCmpt = renderBoardEntity:PickUpChessResult()
  local chessPetID = pickUpResCmpt:GetPickUpChessPetEntityID()
  local chessPath = pickUpResCmpt:GetChessPetMovePath()
  local chessSvcRender = self._world:GetService("ChessRender")
  chessSvcRender:ClearAllChessUnitPreview()
  chessSvcRender:HdieChessPetCanMoveEffect(chessPetID)
  local cmd = CastChessMoveCommand:New()
  cmd:SetCmdCasterEntityID(chessPetID)
  cmd:SetCmdChessPath(chessPath)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnChessUIInputAttackAction()
  self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateTransit, UIBattleWidgetChessState.FinishTurnOnly)
  self._world:EventDispatcher():Dispatch(GameEventType.ChessUIStateBlockRaycast, false)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpResCmpt = renderBoardEntity:PickUpChessResult()
  local chessPetID = pickUpResCmpt:GetPickUpChessPetEntityID()
  local chessPath = pickUpResCmpt:GetChessPetMovePath()
  local monsterID = pickUpResCmpt:GetPickUpMonsterEntityID()
  local pickUpPos = pickUpResCmpt:GetCurChessPickUpPos()
  local chessSvcRender = self._world:GetService("ChessRender")
  chessSvcRender:ClearAllChessUnitPreview()
  chessSvcRender:HdieChessPetCanMoveEffect(chessPetID)
  local cmd = CastChessPetAttackCommand:New()
  cmd:SetCmdCasterEntityID(chessPetID)
  cmd:SetCmdChessPath(chessPath)
  cmd:SetCmdPickUpResult(pickUpPos)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnChessUIInputSkipAction()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpResCmpt = renderBoardEntity:PickUpChessResult()
  local chessPetID = pickUpResCmpt:GetPickUpChessPetEntityID()
  local targetPos = pickUpResCmpt:GetCurChessPickUpPos()
  local chessSvcRender = self._world:GetService("ChessRender")
  chessSvcRender:ClearAllChessUnitPreview()
  chessSvcRender:HdieChessPetCanMoveEffect(chessPetID)
  local chessPetEntity = self._world:GetEntityByID(chessPetID)
  local matAnimCmpt = chessPetEntity:MaterialAnimationComponent()
  if matAnimCmpt then
    matAnimCmpt:PlayInvalid()
  end
  local cmd = CastChessPetEndTurnCommand:New()
  cmd:SetCmdTurnType(ChessTurnEndType.Single)
  cmd:SetTurnEndEntityID(chessPetID)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnChessUIInputFinishTurnAction()
  local chessSvcRender = self._world:GetService("ChessRender")
  chessSvcRender:ClearAllChessUnitPreview()
  chessSvcRender:HdieAllChessPetCanMoveEffect()
  local cmd = CastChessPetEndTurnCommand:New()
  cmd:SetCmdTurnType(ChessTurnEndType.All)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:FinishChessPetTurn(finishAll, targetEntityID)
  local chessSvcRender = self._world:GetService("ChessRender")
  local group = self._world:GetGroup(self._world.BW_WEMatchers.ChessPetRender)
  local chessPetEntitys = group:GetEntities()
  for i, v in ipairs(chessPetEntitys) do
    local chessPetRenderCmpt = v:ChessPetRender()
    if finishAll then
      chessPetRenderCmpt:SetChessPetFinishTurn(true)
    elseif targetEntityID == v:GetID() then
      chessPetRenderCmpt:SetChessPetFinishTurn(true)
    end
    chessSvcRender:RefreshChessPetFinishStateRender(v)
  end
end

function EventListenerServiceRender:OnGuideChessClick(entityID)
  local entity = self._world:GetEntityByID(entityID)
  local posCaster = entity:GetGridPosition()
  local boardServiceRender = self._world:GetService("BoardRender")
  local targetPos = boardServiceRender:GridPosition2LocationPos(posCaster, entity)
  local chessPickUpCmpt = self._world:ChessPickUp()
  chessPickUpCmpt:SetChessClickPos(targetPos)
  local component = self._world:GetUniqueComponent(self._world.BW_UniqueComponentsEnum.ChessPickUp)
  self._world:SetUniqueComponent(self._world.BW_UniqueComponentsEnum.ChessPickUp, component)
end

function EventListenerServiceRender:OnGuideMonsterClick(entityID)
  local entity = self._world:GetEntityByID(entityID)
  local position = entity:GetGridPosition()
  local boardSvcR = self._world:GetService("BoardRender")
  local inputCmpt = self._world:Input()
  local v3Pos = boardSvcR:GridPos2RenderPos(position)
  inputCmpt:SetTouchBeginPosition(v3Pos)
  local prvwSvc = self._world:GetService("PreviewMonsterTrap")
  prvwSvc:CheckPreviewMonsterAction(position, Vector2(0, 0))
end

function EventListenerServiceRender:_OnCastActivePickSkillFail(errorStep, errorType, activeSkillID, petPstID, previewPickUpComponent)
  local pickPosList = {}
  if previewPickUpComponent then
    pickPosList = previewPickUpComponent:GetAllValidPickUpGridPos()
  end
  local cmd = ClientExceptionReportCommand.CreateAutoFightPickErrorReport(activeSkillID, errorStep, errorType, pickPosList)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClientExceptionReport, cmd)
  self:OnCancelActiveSkillCast(activeSkillID, petPstID)
end

function EventListenerServiceRender:_OnCastActivePickSkillFailSwithState(TT)
  YIELD(TT, 500)
  if self._world:RunAtClient() and self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
    self._world:EventDispatcher():Dispatch(GameEventType.PickUpActiveSkillTargetFinish, 1)
  end
end

function EventListenerServiceRender:_CheckCanSendActivePickSkillCmd(previewPickUpComponent, petEntity, skillID, pickUpType)
  local dbgCheck = true
  if not dbgCheck then
    return true, 0
  end
  local errorType = 0
  local canSend = true
  local isReady = AutoPickCheckHelperRender.CheckPetSkillReady(petEntity, skillID)
  if not isReady then
    errorType = ActivePickSkillCheckErrorType.PetNotReady
    canSend = false
    return canSend, errorType
  end
  if previewPickUpComponent then
    local pickPosList = previewPickUpComponent:GetAllValidPickUpGridPos()
    if #pickPosList == 0 and pickUpType ~= SkillPickUpType.PickUpUIAndTrap then
      local ignoreCheck = previewPickUpComponent:IsIgnorePickCheck()
      if not ignoreCheck then
        canSend = false
        errorType = ActivePickSkillCheckErrorType.PickPosListEmpty
      end
    end
  else
    canSend = false
    errorType = ActivePickSkillCheckErrorType.NoActivePickCmpt
  end
  return canSend, errorType
end

function EventListenerServiceRender:OnScanFeatureSaveInfo(data)
  local localTeamEntity = self._world:Player():GetLocalTeamEntity()
  local cmd = ScanFeatureCommand:New(localTeamEntity:GetID(), data.skillType, data.trapID)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnUIMiniMazeChooseWaveAward(relicID, partnerID, isOpening)
  local cmd = ChooseMiniMazeWaveAwardCommand:New()
  cmd:SetChooseRelicID(relicID)
  cmd:SetChoosePartnerID(partnerID)
  if isOpening ~= nil then
    cmd:SetIsBattleOpening(isOpening)
  end
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnMirageUIClearPickUp()
  local pickUpCmpt = self._world:MiragePickUp()
  pickUpCmpt:GetCurPickUpGridPos(Vector2.zero)
  local mirageSvcRender = self._world:GetService("MirageRender")
  mirageSvcRender:ClearMiragePick()
end

function EventListenerServiceRender:OnMirageUIConfirmPickUp(autoFight)
  local piece_service = self._world:GetService("Piece")
  piece_service:RefreshPieceAnim()
  local gridPos
  if not autoFight then
    local pickUpCmpt = self._world:MiragePickUp()
    gridPos = pickUpCmpt:GetCurPickUpGridPos()
  else
    local mirageSvcRender = self._world:GetService("MirageRender")
    gridPos = mirageSvcRender:GetMirageAutoFightPickUpPos()
  end
  if gridPos == Vector2.zero then
    return
  end
  local cmd = MiragePickUpCommand:New()
  cmd:SetPickUpGridPos(gridPos)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnMirageUICountDownOver()
  local piece_service = self._world:GetService("Piece")
  piece_service:RefreshPieceAnim()
  local pickUpCmpt = self._world:MiragePickUp()
  pickUpCmpt:GetCurPickUpGridPos(Vector2.zero)
  local cmd = MirageForceCloseCommand:New()
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnMirageUIRefreshStep(stepNum)
  local mirageSvcRender = self._world:GetService("MirageRender")
  mirageSvcRender:RefreshMirageStepNum(stepNum)
end

function EventListenerServiceRender:OnSwitchPetEquipRefine(uiState, petPstID)
  local cmd = SwitchPetEquipRefineUICommand:New()
  cmd:SetCmdRefineUIState(uiState)
  cmd:SetCmdCasterPstID(petPstID)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnPopStarPickUp(pos, connectPieces)
  local cmd = PopStarPickUpCommand:New()
  cmd:SetCmdPickUpPos(pos)
  cmd:SetCmdConnectPieces(connectPieces)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnResolutionChanged()
  local curState = self:_GetCurState()
  if curState == GameStateID.Loading then
    Log.info("进局loading过程中改变分辨率 不处理")
    return
  end
  local cameraSvc = self._world:GetService("Camera")
  if cameraSvc then
    cameraSvc:ResetFov_ForFoldableDevice()
  end
  local entities = self._world:GetGroup(self._world.BW_WEMatchers.HP):GetEntities()
  for _, e in ipairs(entities) do
    e:HP():SetHPPosDirty(true)
  end
end

function EventListenerServiceRender:OnEnterPuzzle()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  if pickUpTargetCmpt == nil then
    Log.fatal("OnEnterPuzzle pick up target is nil")
    return
  end
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  if petPstID < 0 or activeSkillID < 0 then
    Log.fatal("OnEnterPuzzle id invalid")
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  if not petEntity then
    Log.fatal("DoPreActiveSkillInstruction pet entity is invalid")
    return
  end
  local previewPuzzleSvc = self._world:GetService("PreviewPuzzle")
  previewPuzzleSvc:PreEnterPuzzle()
  
  local function funCallBack()
    local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
    local pickUpParam = skillConfigData:GetSkillPickParam()
    local countdownTime = pickUpParam.CountdownTime
    self._world:EventDispatcher():Dispatch(GameEventType.ShowPuzzleUI, true, countdownTime)
    previewPuzzleSvc:EnterPuzzle(petEntityId, pickUpParam)
  end
  
  GameGlobal.TaskManager():CoreGameStartTask(self.DoPreActiveSkillInstruction, self, activeSkillID, petEntity, funCallBack)
end

function EventListenerServiceRender:DoPreActiveSkillInstruction(TT, activeSkillID, petEntity, funCallBack)
  if not activeSkillID or not petEntity then
    return
  end
  local prePickUpCmpt = petEntity:PreviewPickUpComponent()
  if not prePickUpCmpt then
    Log.fatal("DoPreActiveSkillInstruction PreviewPickUpComponent is nil")
    return
  end
  local pickUpPos = prePickUpCmpt:GetLastPickUpGridPos()
  local taskIDList = {}
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local preASSvc = self._world:GetService("PreviewActiveSkill")
  for _, v in ipairs(skillConfigData._previewParamList) do
    if v:GetPreviewType() == SkillPreviewType.Instruction then
      local instructionParam = v
      for _, skillPreviewConfigData in pairs(instructionParam._previewList) do
        local instructionSet = skillPreviewConfigData:GetPreActiveSkillInstructionSet()
        if instructionSet then
          local previewContext = preASSvc:CreatePreviewContext(skillPreviewConfigData, petEntity, pickUpPos)
          previewContext:SetPreviewActiveSkillID(activeSkillID)
          local taskID = GameGlobal.TaskManager():CoreGameStartTask(preASSvc.DoPreviewInstruction, preASSvc, instructionSet, petEntity, previewContext)
          table.insert(taskIDList, taskID)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
  if funCallBack then
    funCallBack()
  end
end

function EventListenerServiceRender:OnSyncClientUnscaledCountDownFinish(flagID, state)
  local cmd = SyncClientUnscaledCountDownCommand:New()
  cmd:SetCmdFlagID(flagID)
  cmd:SetCmdState(state)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnSPIstavanChoosePetHead(petPstID)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(pickUpTargetCmpt:GetPetPstid())
  local petEntity = self._world:GetEntityByID(petEntityId)
  if not petEntity:HasPreviewPickUpComponent() then
    petEntity:AddPreviewPickUpComponent()
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  previewPickUpComponent:SetPickUpPetPstID(petPstID)
  previewPickUpComponent:ClearGridPos()
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
    for i, v in ipairs(skillConfigData._previewParamList) do
      if v:GetPreviewType() == SkillPreviewType.Instruction then
        local instructionParam = v
        for _, skillPreviewConfigData in ipairs(instructionParam._previewList) do
          local instructionSet = previewActiveSkillService:_GetInstructSet(PickUpInstructionType.Repeat, skillPreviewConfigData)
          if instructionSet then
            local previewContext = previewActiveSkillService:_GetPreviewContext(PickUpInstructionType.Repeat, skillPreviewConfigData, petEntity, skillPreviewConfigData:GetID(), {})
            local taskID = GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkillService.DoPreviewInstruction, previewActiveSkillService, instructionSet, petEntity, previewContext)
          end
        end
      end
    end
    local canCast = utilDataSvc:CheckPetCanCastSkill(petEntity, activeSkillID, petPstID)
    self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, 0)
    self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, canCast)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.IstavanPreviewCancelPetHeadUI, false, petPstID)
  end)
end

function EventListenerServiceRender:OnTetrisFeatureOP(opType, opValue)
  local cmd = TetrisFeatureCommand:New(opType, opValue)
  self._world:Player():SendCommand(cmd)
end

function EventListenerServiceRender:OnPet1702361ActiveStart(activeSkillID, petPstID)
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  local activeSkillPickUpComponent = petEntity:ActiveSkillPickUpComponent()
  if not activeSkillPickUpComponent then
    petEntity:AddActiveSkillPickUpComponent()
  end
  local renderBattleStatCmpt = self._world:RenderBattleStat()
  renderBattleStatCmpt:SetPet1702361ActiveSkillPreviewState(true)
  local taskManager = GameGlobal.TaskManager()
  taskManager:CoreGameStartTask(function(TT)
    local inputCmpt = self._world:Input()
    inputCmpt:SetPreviewActiveSkillPlay(true)
    local sPreviewSkill = self._world:GetService("PreviewActiveSkill")
    local taskID = sPreviewSkill:PlaySkillView_PlayPreviewInstSet(activeSkillID, petPstID, PickUpInstructionType.Empty)
    while not TaskHelper:GetInstance():IsTaskFinished(taskID) do
      YIELD(TT)
    end
    local previewEntity = self._world:GetPreviewEntity()
    local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
    local previewChainPathCmpt = previewEntity:PreviewChainPath()
    previewChainPathCmpt:SetLinkLineType(ELinkLineType.ELLT_LINE_NoElementCostStep)
    previewLinkLineCmpt:SetLinkLineType(ELinkLineType.ELLT_LINE_NoElementCostStep)
    local inputCmpt = self._world:Input()
    inputCmpt:SetPreviewActiveSkill(true)
    inputCmpt:SetPreviewActiveSkillPlay(false)
    self._world:EventDispatcher():Dispatch(GameEventType.PreviewActiveSkillFinish, 3)
    local utilStatSvc = self._world:GetService("UtilData")
    if not utilStatSvc:GetStatAutoFight() then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PickUPValidGridShowChooseTarget, true)
    end
    local utilDataSvc = self._world:GetService("UtilData")
    local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
    local petEntity = self._world:GetEntityByID(petEntityId)
    local pickUpNum = utilDataSvc:GetPet1702361LinkLineStep(petEntity, activeSkillID)
    self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, pickUpNum)
  end)
end
