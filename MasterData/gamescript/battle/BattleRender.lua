local TimeUtil = CS.Framework.TimeUtil
local BattleRender, Super = System.NewClass("BattleRender", BattleEntity)

function BattleRender:ctor(battleData)
  Super.ctor(self)
  self.battleData = battleData
  bg.battleRender = self
  self.renderTime = 0
  self.isIntro = self.battleData and self.battleData.isIntro
  self.gameSpeed = 1
  if self.battleData then
    local gameSpeed = MobileFileDataManager.Instance:GetPlayerFileValue(bc.BattleGameSpeedKey, 1)
    self.gameSpeed = gameSpeed
  end
  if bg.isPVP then
    self.gameSpeed = bg.DT.GetConstant("PVPPlaybackSpeed")
  end
  self.battlePhase = bc.BattlePhase.None
  self.battleTid = self.battleData.battleTid
  self.lives = self.battleData and self.battleData.lives or 0
  self.isEntranceAnimEnd = false
  bg.ResetTextFloat()
  if 1.0 ~= bg.debugTimeScale then
    TimeUtil.SetTimeScale(bg.debugTimeScale)
  end
  if battleData.gameplayType == bc.BattleGameplayType.PVP then
    local resourceCache = ResourceCache(self, true)
    bg.DT = resourceCache:GetDataTable(false)
  else
    bg.DT = DataTable
  end
  self.eventMgr = BattleEventMgr()
  self.scheduler = BattleScheduler()
  self.boutMgr = BattleBoutMgrClient()
  self.embryoMgr = BattleEmbryoMgrClient()
  self.cardMgr = self:CreateCardMgr()
  self.relicMgr = BattleRelicMgrClient()
  self.ultiSkillMgr = BattleUltiSkillMgrClient()
  self.sfxMgr = BattleSfxManager()
  self.recordMgr = BattleRecordMgrClient()
  self.robotMgr = BattleRobotMgrClient()
  self.stateMgr = BattleStateMgrClient()
  self.roleMgr = self:CreateRoleMgr()
  self.entranceAnim = BattleSceneEntranceAnimation()
  self.battlePerformQueue = BattlePerformQueue()
  self.statsMgr = BattleStatsMgrClient()
  self.cmdTargetMgr = self:CreateCmdTargetMgr()
  self.eventHandler = BattleRenderEventHandler(self)
  self.csLogInstance = CS.Z1Client.Z1BattleLog.Instance
  self.curCommand = false
  self._genUid = 10000
  DataCenter.gameData.IsInCombat = true
  self:Awake()
end

function BattleRender:Awake()
  self.recordMgr:Awake()
  self.embryoMgr:Awake()
  self.stateMgr:Awake()
  self.boutMgr:Awake()
  self.roleMgr:Awake()
  self.robotMgr:Awake()
  self.entranceAnim:Awake()
  self.eventHandler:Awake()
  if self.cmdTargetMgr then
    self.cmdTargetMgr:Awake()
  end
  self:StartLogFile()
end

function BattleRender:Dispose()
  Super.Dispose(self)
  self.embryoMgr:Dispose()
  self.robotMgr:Dispose()
  self.stateMgr:Dispose()
  self.recordMgr:Dispose()
  self.entranceAnim:Dispose()
  self.boutMgr:Dispose()
  self.cardMgr:Dispose()
  self.sfxMgr:Dispose()
  self.eventHandler:Dispose()
  if self.cmdTargetMgr then
    self.cmdTargetMgr:Dispose()
  end
  self.eventMgr:Dispose()
  DataCenter.gameData.IsInCombat = false
  self.csLogInstance = nil
  self.battlePerformQueue:Clear()
  self.scheduler:Dispose()
end

function BattleRender:CreateRoleMgr()
  if bg.isPVE then
    do return end
    return PvERoleMgrClient
  end
  do return end
  return PvPRoleMgrClient
end

function BattleRender:CreateCardMgr()
  if bg.isPVE then
    do return end
    return BattleCardMgrClient
  end
  do return end
  return PvPBattleCardMgrClient
end

function BattleRender:CreateCmdTargetMgr()
  if bg.isPVE then
    return nil
  end
  do return end
  return PvPCmdTargetMgrClient
end

function BattleRender:Tick(deltaTime)
  Super.Tick(self, deltaTime)
  if 0 == deltaTime then
    TimeUtil.SetTimeScale(1)
  end
  self.renderTime = self.renderTime + deltaTime
  self.scheduler:Tick(deltaTime)
  if not bg.battleRender then
    return
  end
  self.boutMgr:Tick(deltaTime)
  self.cardMgr:Tick(deltaTime)
  self.roleMgr:Tick(deltaTime)
  self.sfxMgr:Tick(deltaTime)
  self.robotMgr:Tick(deltaTime)
  if self.isEntranceAnimEnd then
    self.recordMgr:Tick(deltaTime)
  end
  if bg.battlePanel then
    bg.battlePanel:Tick(deltaTime)
  end
end

function BattleRender:GenUid()
  self._genUid = self._genUid + 1
  return self._genUid
end

function BattleRender:PerformWithDelay(delayTime, callback, target)
  local schedulerId = self.scheduler:PerformWithDelay(delayTime, callback, target)
  return schedulerId
end

function BattleRender:UnperformWithDelay(schedulerId)
  self.scheduler:UnperformWithDelay(schedulerId)
end

function BattleRender:UnperformWithAllDelaysByTarget(target)
  self.scheduler:UnperformWithAllDelaysByTarget(target)
end

function BattleRender:StartLogFile()
  local DT = bg.DT
  local serverName = "serverName"
  local serverInfo = LoginMgr.Instance.model:GetCurrServerData()
  if serverInfo and serverInfo.name then
    serverName = serverInfo.name
  end
  local account = LoginMgr.Instance:GetAccount()
  local battleCfg = DT.BattleConfig[self.battleTid]
  local battleUid = self.battleData.battleUid
  local battleCnId = battleCfg and battleCfg.CnID or "Battle"
  local stageTid = WorldStageManager.Instance:GetCurStageId()
  local stageCfg = stageTid and DT.Stage[stageTid] or nil
  local stageCnId = stageCfg and stageCfg.CnID or "Stage"
  local fileName = string.format("%s_%s_%s_%s_", serverName, account, stageCnId, battleCnId)
  local trigger_ts = self.battleData.trigger_ts or os.time()
  fileName = fileName .. os.date("%Y_%m_%d_%H_%M_%S", trigger_ts)
  if battleUid then
    fileName = fileName .. "_" .. battleUid
  end
  self.logFileName = fileName
  self.csLogInstance:SetFileName(fileName)
end

function BattleRender:GetLogFileName()
  return self.logFileName or ""
end

function BattleRender:LogBattle(msg)
  local csLogInstance = self.csLogInstance or CS.Z1Client.Z1BattleLog.Instance
  if not csLogInstance then
    return
  end
  csLogInstance:LogBattle(msg)
end

function BattleRender:LogBattleDetail(data)
  if BattleManager.Instance then
    BattleManager.Instance:LogBattleDetail(data)
  end
end

function BattleRender:GetBattleuUid()
  return self.battleData.battleUuid
end

function BattleRender:GetBattleId()
  return self.battleTid
end

function BattleRender:GetCmdParser()
  if not self._cmdParser then
    self._cmdParser = BattleCmdParserClient({})
  end
  return self._cmdParser
end

function BattleRender:SetCurCommand(command)
  self.curCommand = command
end

function BattleRender:CanUseCommand(msgId)
  local DT = bg.DT
  if self.curCommand and self.curCommand ~= msgId then
    local desc = LT.Textf(DT.TipsType[10118].Desc, self.curCommand, msgId)
    Alert.Show(10118, nil, nil, nil, desc)
    return false
  end
  return true
end

function BattleRender:SetWinCamp(camp)
  self.winCamp = camp
end

function BattleRender:GetWinCamp()
  return self.winCamp
end

function BattleRender:SyncAction(renderEventType, data)
  local record = {
    time = nil,
    eventId = renderEventType,
    data = data
  }
  local sendData = {
    frameList = {record}
  }
  self:SendCommand(BattleCommand.lg_ClientAction, sendData)
end

function BattleRender:SendCommand(msgId, msgData)
  local returnObj = {}
  EventMgr.Instance.BattleSendCommand:Dispatch(msgId, msgData, returnObj)
  do return table.unpack end
  return table.unpack, returnObj, msgId, msgData, returnObj
end

function BattleRender:OnReceiveCommand(msgId, msgData)
  if msgId == BattleCommand.rd_InitBattle then
    self:rd_InitBattle(msgData)
  elseif msgId == BattleCommand.rd_BattleCut then
    self:rd_BattleCut(msgData)
  elseif msgId == BattleCommand.rd_BattleInstantCut then
    self:rd_BattleInstantCut(msgData)
  elseif msgId == BattleCommand.rd_RecoverBattle then
    self:rd_RecoverBattle(msgData)
  elseif msgId == BattleCommand.rd_CommandResult then
    self:rd_CommandResult(msgData)
  else
    Logger.Warn("BattleRender:OnReceiveCommand not handle msgId", msgId, table.tostring(msgData))
  end
end

function BattleRender:rd_CommandResult(msgData)
  if msgData and msgData.ret == false then
    Logger.Warn("CommandResult failed", msgData.msgId, table.tostring(msgData))
  end
  self.eventMgr:SendEvent(BattleRenderEvent.CommandResult, msgData)
end

function BattleRender:rd_InitBattle(msgData)
  bg.SendBattleEvent(rc.BattleEvent.DealInitBattle)
  self:PrintBattleInitData(msgData)
  BattleCameraDataUtils.OnBattleInit(msgData)
  bg.battleDataCenter:InitData(msgData, false)
  self.roleMgr:InitAllRole(msgData)
  self.cardMgr:InitAllCards(msgData.cardDataList)
  self.relicMgr:InitAllRelics(msgData.relicDataList)
  DataCenter.barrierData.InBattle = true
  self.battlePhase = bc.BattlePhase.Ready
  self.lives = msgData.lives or self.lives
  bg.battleScene:OnStartBattle()
end

function BattleRender:rd_RecoverBattle(msgData)
  print("BattleRender:rd_RecoverBattle", table.tostring(msgData))
  if bg.isReplay then
    return
  end
  if not bg.isPVP then
    EventMgr.Instance.SkipEntranceAniEvent:Dispatch()
  end
  if DataCenter.barrierData.InBattle then
    local isSame = msgData.battleUuid == bg.battleData.battleUuid or msgData.battleUid == bg.battleData.battleUid
    if isSame then
      self:ResetBattleData(msgData)
    end
    return
  end
  bg.SendBattleEvent(rc.BattleEvent.DealRecoverBattle)
  bg.battleDataCenter:InitData(msgData, true)
  self:PrintBattleInitData(msgData)
  self.roleMgr:InitAllRole(msgData)
  if msgData.camp then
    bg.battleDataCenter:SetRealCamp(msgData.camp)
  end
  self.boutMgr:RecoverBout(msgData.boutDataList, msgData.boutDamage)
  bg.battleDataCenter.recoverBoutLeftTime = msgData.boutLeftTime
  self.cardMgr:InitAllCards(msgData.cardDataList)
  self.relicMgr:InitAllRelics(msgData.relicDataList)
  DataCenter.barrierData.InBattle = true
  self.battlePhase = bc.BattlePhase.Battle
  self.lives = msgData.lives or self.lives
  for _, stateData in ipairs(msgData.stateDataList) do
    if stateData.stateType == bc.StateType.Card then
      self.stateMgr:OnAddCardState(stateData)
    else
      self.stateMgr:OnAddState(stateData)
    end
  end
  bg.battleScene:OnStartBattle()
  bg.battleScene:OnBattleRecover()
  self:ApplyRecoverBattleCamera(msgData)
end

function BattleRender:ApplyRecoverBattleCamera(msgData)
  if bg.isReplay or bg.isPVP or not bg.battleScene then
    return
  end
  if msgData and bg.battleData and not BattleCameraDataUtils.IsSameBattle(msgData, bg.battleData) then
    return
  end
  local sceneHelper = bg.battleScene.battleSceneMgr and bg.battleScene.battleSceneMgr.unityBattleScene
  local appliedSavedCamera = false
  if sceneHelper then
    appliedSavedCamera = BattleCameraDataUtils.TryApplySavedCamera(sceneHelper)
  end
  self:TempRecoverBattleBgm(appliedSavedCamera)
  if not appliedSavedCamera then
    BattleCameraDataUtils.RefreshStatusUIPosition()
  end
end

function BattleRender:TempRecoverBattleBgm(skipCamera)
  if not bg.battleDataCenter then
    return
  end
  if bg.isReplay then
    return
  end
  local state2sound = {
    {
      36816,
      "Set_State_D_LV2"
    },
    {
      36817,
      "Set_State_D_LV3",
      "StageBoss6_2"
    },
    {
      DT.GetConstant("Set_State_D_LV2"),
      "Set_State_D_LV2"
    },
    {
      DT.GetConstant("Set_State_D_LV3"),
      "Set_State_D_LV3"
    },
    {
      DT.GetConstant("Set_State_D_LV4"),
      "Set_State_D_LV4"
    },
    {
      DT.GetConstant("Set_State_D_LV5"),
      "Set_State_D_LV5"
    },
    {
      DT.GetConstant("Set_State_D_LV6"),
      "Set_State_D_LV6"
    },
    {
      DT.GetConstant("Set_State_D_LV7"),
      "Set_State_D_LV7"
    },
    {
      DT.GetConstant("Set_State_D_LV8"),
      "Set_State_D_LV8"
    },
    {
      DT.GetConstant("Set_State_D_LV9"),
      "Set_State_D_LV9"
    },
    {
      DT.GetConstant("Set_State_D_LV10"),
      "Set_State_D_LV10"
    }
  }
  for _, list in ipairs(state2sound) do
    local stateTid, soundEvent, camera = table.unpack(list)
    if not stateTid then
      break
    end
    local stateList = bg.battleDataCenter.stateData:GetStateListByTid(stateTid)
    if #stateList > 0 then
      AudioManager.Instance:PostSoundEvent(soundEvent)
      if camera and bg.battleScene and not skipCamera and not bg.isPVP then
        bg.battleScene:ChangeDefaultVMCamera(camera)
      end
    end
  end
end

function BattleRender:ResetBattleData(msgData)
  bg.SendBattleEvent(rc.BattleEvent.DealResetBattleData)
  bg.battleDataCenter:InitData(msgData, true)
  self:PrintBattleInitData(msgData)
  if msgData.camp then
    bg.battleDataCenter:SetRealCamp(msgData.camp)
  end
  if bg.battleDataCenter.boutData.boutNumber > 0 then
    local pvpSelectInitCardPanel = UIManager.Instance:GetWindow(Urls.PvPSelectInitCardPanel)
    if pvpSelectInitCardPanel then
      pvpSelectInitCardPanel:ForceClose()
    end
    local otherSelectInitCardPanel = UIManager.Instance:GetWindow(Urls.PvPOtherSelectInitCardPanel)
    if otherSelectInitCardPanel then
      otherSelectInitCardPanel:ForceClose()
    end
  end
  self.boutMgr:RecoverBout(msgData.boutDataList, msgData.boutDamage)
  self.cardMgr:InitAllCards(msgData.cardDataList)
  self.relicMgr:InitAllRelics(msgData.relicDataList)
  self.battlePhase = bc.BattlePhase.Battle
  self.lives = msgData.lives or self.lives
  self.isEntranceAnimEnd = true
  for _, stateData in ipairs(msgData.stateDataList) do
    if stateData.stateType == bc.StateType.Card then
      self.stateMgr:OnAddCardState(stateData)
    else
      self.stateMgr:OnAddState(stateData)
    end
  end
  if self.recordMgr then
    self.recordMgr:Reset()
  end
  if bg.isPVE then
    UIManager.Instance:Reopen(Urls.DbgBattlePanel)
  elseif bg.isPVP then
    UIManager.Instance:Reopen(Urls.PvPBattleMainPanel)
    if bg.isPVP_TRAIN then
      UIManager.Instance:Reopen(Urls.PvPBattleTrainPanel)
    end
  end
  bg.battleDataCenter:SetOpMode(rc.OpMode.Play)
  bg.battleScene:OnBattleRecover()
  self:ApplyRecoverBattleCamera(msgData)
end

function BattleRender:PrintBattleInitData(initData)
  if not ApplicationUtils.is_debug_mode() then
    return
  end
  for k, v in pairs(initData) do
    Logger.Info("战斗初始化", k, table.tostring(v))
  end
end

function BattleRender:AccelerateShow()
end

function BattleRender:rd_BattleCut(msgData)
  self.recordMgr:OnReceiveRecord(msgData)
end

function BattleRender:rd_BattleInstantCut(msgData)
  self.recordMgr:OnReceiveInstantRecord(msgData)
end

function BattleRender:StartEntranceAnimation(callback)
  local finishFunc
  
  function finishFunc()
    finishFunc = nil
    self:OnEntranceAnimationEnd()
    if callback then
      callback()
    end
  end
  
  local overTime = bg.isPVE and 18 or 3
  self:PerformWithDelay(overTime, function()
    if finishFunc then
      finishFunc()
    end
  end)
  self.entranceAnim:StartAnimation(function()
    if finishFunc then
      finishFunc()
    end
  end)
end

function BattleRender:OnEntranceAnimationEnd()
  self.isEntranceAnimEnd = true
  bg.SendBattleEvent(rc.BattleEvent.EntranceAnimationEnd)
  EventMgr.Instance.BattleCameraChange:Dispatch()
end

function BattleRender:OnBattleBegin()
  self.battlePhase = bc.BattlePhase.Battle
  bg.battleScene:OnBattleBegin()
end

function BattleRender:OnBattleFinishOverTime(result, data)
  if bg.isPVP then
    return
  end
  if AvgStoryManager.Instance:IsPlaying() then
    return
  end
  if UIManager.Instance:GetWindow(Urls.AlertConfirmPanel) or UIManager.Instance:GetWindow(Urls.AlertConfirm2Panel) or UIManager.Instance:GetWindow(Urls.AlertConfirm3Panel) then
    return
  end
  xpcall(function()
    local urls = {
      Urls.DBGMainCopyOutPanel,
      Urls.PvPBattleRankSettlePanel,
      Urls.PVPBattleDataSettlePanel
    }
    for _, url in ipairs(urls) do
      if UIManager.Instance:GetWindow(url) then
        return
      end
    end
    self:NotifyBattleResult(result, data)
    if bg.battleScene then
      bg.battleScene:OnBattleFinishOverTime()
    end
  end, debug.traceback)
  BattleManager.Instance:OnBattleFinish(result, data)
end

function BattleRender:NotifyBattleResult(battleResult, battleFinishData)
  if self._notifiedResult then
    return
  end
  self._notifiedResult = true
  EventMgr.Instance.BattleResult:Dispatch(battleResult, battleFinishData)
end

function BattleRender:DoBatttleFinish(data)
  local battleFinishData = data.battleFinishData
  local isShow = data.isShow
  if nil == isShow then
    isShow = true
  end
  bg.battleScene:OnBattleFinish(data.winCamp, battleFinishData, isShow, isShow)
end

function BattleRender:CallFuncAfterEnemyDead(retryTimes, callback)
  if retryTimes <= 0 then
    callback()
    return
  end
  if self:CheckEnemyDead(self.winCamp) then
    callback()
  else
    self:PerformWithDelay(1, function()
      if self:CheckEnemyDead(self.winCamp) then
        callback()
      else
        self:CallFuncAfterEnemyDead(retryTimes - 1, callback)
      end
    end, self)
  end
end

function BattleRender:CheckEnemyDead(winCamp)
  for _, role in pairs(bg.battleScene.roleList or {}) do
    if role.camp ~= winCamp and not role.dead.value then
      return false
    end
  end
  return true
end

function BattleRender:ExitBattle(battleResult, battleEndData)
  BattleManager.Instance:ExitBattle(battleResult)
end

function BattleRender:OnReqRespawn(effectUid, isRespawn, rewindToFirst)
  local msgData = {
    confirm = isRespawn,
    effectUid = effectUid,
    rewindToFirst = rewindToFirst or nil
  }
  Logger.Info("[BattleBackTrack] lg_Confirm %s", table.tostring(msgData))
  self:SendCommand(BattleCommand.lg_Confirm, msgData)
  if rewindToFirst then
    Logger.Info("[BattleBackTrack] lg_Confirm rewindToFirst=true, schedule restart battle")
    TimerManager.Instance:CreateTimer(0.1, 0, nil, function()
      if bg.battleScene then
        bg.battleScene:RestartBattle(nil, true)
      end
    end)
  end
end

function BattleRender:IsBattleAllowAuto()
  local isBattleAllowAuto = true
  if bg.battleScene.battleCfg.QuickClear ~= CommonDefine.NumberTrue then
    isBattleAllowAuto = false
  end
  return isBattleAllowAuto
end

function BattleRender:Push2Queue_RunInThisFrameData(func, tag, isBlock)
  self.battlePerformQueue:Push(func, tag, isBlock)
end

function BattleRender:PopPerformQueue(tag)
  self.battlePerformQueue:Pop(tag)
end

function BattleRender:IsHaveAvailAwakerSkill()
  do return self.roleMgr.IsHaveAvailAwakerSkill end
  return self.roleMgr.IsHaveAvailAwakerSkill, self.roleMgr
end

function BattleRender:HaveAvailKeeperSkill()
  do return self.roleMgr.HaveAvailKeeperSkill end
  return self.roleMgr.HaveAvailKeeperSkill, self.roleMgr
end

function BattleRender:IsInSelectCard()
  if UIManager.Instance:GetWindow(Urls.DeckCardSelectPanel) then
    return true
  end
  if UIManager.Instance:GetWindow(Urls.BattleCardDropSelectView) then
    return true
  end
  if UIManager.Instance:GetWindow(Urls.SkillCastSelectPanel) then
    return true
  end
end

function BattleRender:IsInTargetSelect()
  if UIManager.Instance:GetWindow(Urls.SkillCastSelectPanel) then
    return true
  end
end

function BattleRender:_HasUsingHandCard()
  if not bg.battlePanel or not bg.battleDataCenter then
    return false
  end
  local cardUI
  if bg.battlePanel.GetCardUI then
    cardUI = bg.battlePanel:GetCardUI(bg.battleDataCenter:GetMyCamp())
  else
    cardUI = bg.battlePanel.cardUI
  end
  return cardUI and cardUI.usingCardUidMap and next(cardUI.usingCardUidMap) or false
end

BattleRender.BattleActionShortCutBlockUrls = {
  Urls.BattleCardPanel,
  Urls.PvPSelectCreationPanel,
  Urls.DeckCardSelectPanel,
  Urls.BattleCardDropSelectView,
  Urls.KeeperSkillSelectPanel,
  Urls.DbgAwakerSelectionPanel,
  Urls.SkillCastSelectPanel,
  Urls.PVPTrainCardSelectPanel
}

function BattleRender:IsBattleActionShortCutBlocked()
  if self:IsInTargetSelect() then
    return true
  end
  if self:_HasUsingHandCard() then
    return true
  end
  local uiMgr = UIManager.Instance
  if not uiMgr then
    return false
  end
  for _, url in ipairs(self.BattleActionShortCutBlockUrls) do
    if uiMgr:GetWindow(url) then
      return true
    end
  end
  return false
end

function BattleRender:OnBeginPlayDrama(data)
  Logger.Debug("#BattleRender:OnBeginPlayDrama ", data.dramaTid)
  self.recordMgr:SetRecordState(bc.BattleRecordPlayState.Stop)
  if data.dramaType == bc.DramaType.End then
    self:CallFuncAfterEnemyDead(2, function()
      EventMgr.Instance.StartStory:Dispatch(data.dramaTid)
    end)
  else
    EventMgr.Instance.StartStory:Dispatch(data.dramaTid)
  end
end

function BattleRender:GetRenderTime()
  return self.renderTime
end

return BattleRender
