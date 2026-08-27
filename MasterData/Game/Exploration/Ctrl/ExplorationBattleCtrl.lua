local DungeonBattleBaseCtrl = require("Game.Common.CommonGameCtrl.DungeonBattleBaseCtrl")
local ExplorationBattleCtrl = class("ExplorationBattleCtrl", DungeonBattleBaseCtrl)
local base = DungeonBattleBaseCtrl
local CS_BattleManager_Ins = CS.BattleManager.Instance
local CS_eBattleState = CS.eBattleState
local cs_MessageCommon = CS.MessageCommon
local DeployTeamUtil = require("Game.Exploration.Util.DeployTeamUtil")
local cs_BattleStatistics = CS.BattleStatistics.Instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local util = require("XLua.Common.xlua_util")
local EpGuideUtil = require("Game.Exploration.Util.EpGuideUtil")
local BattleCustomMoveCtrl = require("Game.BattleCustomMove.BattleCustomMoveCtrl")
local startBattleType = {normal = 1, ambush = 2}

function ExplorationBattleCtrl:ctor(epCtrl)
  self.epCtrl = epCtrl
  table.insert(self.epCtrl.ctrls, self)
  self.__OnTimelineNoticeOpenResultUI = BindCallback(self, self.OnTimelineNoticeOpenResultUI)
  MsgCenter:AddListener(eMsgEventId.OnTimelineNoticeCreateResultUI, self.__OnTimelineNoticeOpenResultUI)
  self.startBattleType = startBattleType.normal
  self.__curStateId = -1
  self.__battleCount = 0
  self.__closeReload = false
  self.__waitSelectChip = nil
  self.__waitSettleResult = nil
  self.__settleTimelinePause = nil
  self.__loadedBattleObj = false
  self.canShowNewEnemyDetail = true
  self._isInTd = ExplorationManager:IsInTDExp()
  if BattleUtil.IsInBrotatBattle() then
    self.CustomMoveCtrl = BattleCustomMoveCtrl.CreateCustomMoveCtrl(btlMgr)
  end
end

function ExplorationBattleCtrl:IsBattleState(state)
  return self.__curStateId == state
end

function ExplorationBattleCtrl:IsBattleBeforeRunning()
  return self.__curStateId <= eBattleState.Deploy
end

function ExplorationBattleCtrl:StartNewEpBattle(roomData, dynPlayer)
  self.__roomData = roomData
  self:__OnEnterBattleScene(roomData)
  MsgCenter:Broadcast(eMsgEventId.BeforeNewEpBattle, roomData)
  if not self._isInTd then
    local autoRunning = self.epCtrl.autoCtrl:IsAutoModeRunning()
    local dynPlayer = ExplorationManager:GetDynPlayer()
    local size_row, size_col, deploy_rows = ExplorationManager:GetEpSceneBattleFieldSize()
    DeployTeamUtil.AutoBattleDeploy(roomData, dynPlayer.heroList, size_row, size_col, deploy_rows, autoRunning)
  end
  local actionList = ExplorationManager:GetEpGuideActionList(self.__roomData.x, ExplorationEnum.epGuideMomentType.BeforeNewEpBattle)
  if actionList ~= nil and 0 < #actionList then
    EpGuideUtil.ExecuteEpGuideActions(actionList, 0)
  end
  self.__battleCount = 0
  local csbattleCtrl = CS_BattleManager_Ins:StartNewBattle(roomData, dynPlayer, self)
  return csbattleCtrl
end

function ExplorationBattleCtrl:__OnEnterBattleScene(roomData)
  self.needShowEpBuff = false
  if not roomData:IsDeployRoom() and not ExplorationManager:IsSectorNewbee() then
    self.needShowEpBuff = true
  end
end

function ExplorationBattleCtrl:SetCanShowNewEnemyDetail(bool)
  self.canShowNewEnemyDetail = bool
end

function ExplorationBattleCtrl:AutoShowNewEnemyDetail()
  if ExplorationManager:IsSectorNewbee() or self.battleCtrl == nil or ExplorationManager:IsInBrotatoExp() then
    return false
  end
  local haveNew = false
  local enemyList
  if not self.isDeployRoom and self.canShowNewEnemyDetail then
    local isFirsh = true
    local list = self.battleCtrl.EnemyTeamController.battleOriginRoleList
    for i = 0, list.Count - 1 do
      local enemy = list[i]
      if PlayerDataCenter:IsNewEnemy(enemy.roleDataId) then
        if enemyList == nil then
          enemyList = {}
        end
        table.insert(enemyList, enemy)
        PlayerDataCenter:AddOldEnemy(enemy.roleDataId)
        if isFirsh then
          isFirsh = false
          haveNew = true
        end
      end
    end
  end
  if enemyList ~= nil then
    self._delayNewEnemyDetailCo = GR.StartCoroutine(util.cs_generator(function()
      local isAutoOpen = false
      for _, enemy in ipairs(enemyList) do
        coroutine.yield()
        enemy.battleRoleView:ShowNewArrow(true)
        if not isAutoOpen then
          isAutoOpen = true
          self.battleCtrl:BroadCaseSelectRole(enemy)
        end
      end
    end))
  end
  return haveNew
end

function ExplorationBattleCtrl:__TryAutoShowNewEnemyDetail()
  if self:AutoShowNewEnemyDetail() then
    self.hasNewEnemyDetail = true
    if GuideManager:TryTriggerGuide(eGuideCondition.InNewMonsterDetail) then
    end
  end
end

function ExplorationBattleCtrl:IsCloseReloadSupport()
  return self.__closeReload
end

function ExplorationBattleCtrl:SetCloseReloadSupport(value)
  self.__closeReload = value
end

function ExplorationBattleCtrl:OnBattleStateChange(battleCtrl, stateId, isDeployRoom)
  self.battleCtrl = battleCtrl
  self.__curStateId = stateId
  self.isDeployRoom = isDeployRoom
  if stateId == eBattleState.Init then
    if self.epCtrl.autoCtrl:IsAutoModeRunning() and not isDeployRoom then
      PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetIsAutoBattle(true)
      PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetBattleSpeed(2)
    end
    self.__battleCount = self.__battleCount + 1
    if self.__battleCount > 1 and self.epCtrl.overclockCtrl:IsLevelHasOverclock() then
      local battleWindow = UIManager:GetWindow(UIWindowTypeID.Battle)
      if battleWindow ~= nil then
        battleWindow:SetOverclockHighlight(not self.epCtrl.overclockCtrl:IsUseClockLimit())
      end
    end
    local actionList = ExplorationManager:GetEpGuideActionList(self.__roomData.x, ExplorationEnum.epGuideMomentType.BattleUltFull)
    if actionList ~= nil then
      self.__ultFullActions = actionList
      self.__ultFullCount = 0
      self.__OnEpBattleUpdateUltSkill = BindCallback(self, self.OnEpBattleUpdateUltSkill)
      MsgCenter:AddListener(eMsgEventId.OnBattleUpdateUltSkill, self.__OnEpBattleUpdateUltSkill)
      self.__OnBattleAfterUltSkilPlay = BindCallback(self, self.OnBattleAfterUltSkilPlay)
      MsgCenter:AddListener(eMsgEventId.OnBattleAfterUltSkilPlay, self.__OnBattleAfterUltSkilPlay)
    end
    local actionList = ExplorationManager:GetEpGuideActionList(self.__roomData.x, ExplorationEnum.epGuideMomentType.AfterRoleDead)
    if actionList ~= nil then
      self.__OnEpAfterRoleDead = BindCallback(self, self.OnEpAfterRoleDead)
      battleCtrl:onCharacterDead("+", self.__OnEpAfterRoleDead)
    end
    if self.CustomMoveCtrl ~= nil then
      self.CustomMoveCtrl:OnBattleStateInit(battleCtrl)
    end
  elseif stateId == eBattleState.Deploy then
    self:ShowRandomBeforeRandomUI(isDeployRoom)
    if not self.epCtrl.autoCtrl:IsAutoModeRunning() and GuideManager:TryTriggerGuide(eGuideCondition.InBattleDeploy) then
      GuideManager:SetEndAction(function()
        self:__TryAutoShowNewEnemyDetail()
      end)
    else
      self:__TryAutoShowNewEnemyDetail()
    end
    if not isDeployRoom then
      self.epCtrl.campFetterCtrl:OnEpBattleDeploy()
    end
    if self.__loadedBattleObj then
      self:__OnEpBattleLoadReady()
    end
    local win = UIManager:GetWindow(UIWindowTypeID.EpChipSuit)
    if win ~= nil and not win.active then
      win:Show()
    end
    local actionList = ExplorationManager:GetEpGuideActionList(self.__roomData.x, ExplorationEnum.epGuideMomentType.BattleDeployState)
    if actionList ~= nil and 0 < #actionList then
      EpGuideUtil.ExecuteEpGuideActions(actionList, self:GetEpBattleCount() - 1)
    end
  elseif stateId == eBattleState.Running then
  elseif stateId == eBattleState.End then
    LuaSkillCtrl:DestoryBindSummonerGo()
  elseif stateId == eBattleState.Delete then
    self.__loadedBattleObj = false
    self.__curStateId = -1
    self.hasNewEnemyDetail = false
    self.__closeReload = false
    self.battleCtrl = nil
    self.__ultFullCount = 0
    if self.__OnEpBattleUpdateUltSkill ~= nil then
      self.__ultFullActions = nil
      MsgCenter:RemoveListener(eMsgEventId.OnBattleUpdateUltSkill, self.__OnEpBattleUpdateUltSkill)
      MsgCenter:RemoveListener(eMsgEventId.OnBattleAfterUltSkilPlay, self.__OnBattleAfterUltSkilPlay)
    end
    if self.__OnEpAfterRoleDead ~= nil then
      battleCtrl:onCharacterDead("-", self.__OnEpAfterRoleDead)
      self.__OnEpAfterRoleDead = nil
    end
  end
end

function ExplorationBattleCtrl:OnBattleObjectLoadComplete(battleController)
  self.__loadedBattleObj = true
  if self.__curStateId == eBattleState.Deploy then
    self:__OnEpBattleLoadReady()
  end
end

function ExplorationBattleCtrl:__OnEpBattleLoadReady()
  local actionList = ExplorationManager:GetEpGuideActionList(self.__roomData.x, ExplorationEnum.epGuideMomentType.ReayBattle)
  if actionList ~= nil and 0 < #actionList then
    EpGuideUtil.ExecuteEpGuideActions(actionList, self:GetEpBattleCount() - 1)
  end
  MsgCenter:Broadcast(eMsgEventId.OnBattleReady)
end

function ExplorationBattleCtrl:OnEpBattleUpdateUltSkill(useEnable, curRatio, factor)
  if self.__ultSkillUseEnable == useEnable then
    return
  end
  self.__ultSkillUseEnable = useEnable
  if useEnable and self.__ultFullActions then
    EpGuideUtil.ExecuteEpGuideActions(self.__ultFullActions, self:GetEpBattleCount() - 1)
  end
end

function ExplorationBattleCtrl:OnBattleAfterUltSkilPlay(currentSkill, curHeroEntity)
  self.__ultFullCount = self.__ultFullCount + 1
  if self.__ultSkillUseEnable and self.__ultFullActions then
    EpGuideUtil.ExecuteEpGuideActions(self.__ultFullActions, self:GetEpBattleCount() - 1)
  end
end

function ExplorationBattleCtrl:OnEpAfterRoleDead(role)
  local actionList = ExplorationManager:GetEpGuideActionList(self.__roomData.x, ExplorationEnum.epGuideMomentType.AfterRoleDead)
  if actionList ~= nil then
    for _, guideAction in pairs(actionList) do
      if guideAction.action_delay == role.roleDataId then
        EpGuideUtil.ExecuteEpGuideActionOne(guideAction, self:GetEpBattleCount() - 1)
      end
    end
  end
end

function ExplorationBattleCtrl:GetEpBattleUltFullCount()
  return self.__ultFullCount or 0
end

function ExplorationBattleCtrl:GetEpBattleCount()
  return self.__battleCount or 0
end

function ExplorationBattleCtrl:OnBattleStart(battleCtrl)
  local actionList = ExplorationManager:GetEpGuideActionList(self.__roomData.x, ExplorationEnum.epGuideMomentType.StartBattleDelay)
  if actionList ~= nil and 0 < #actionList then
    for _, guideAction in pairs(actionList) do
      if 0 < guideAction.action_delay then
        LuaSkillCtrl:GetTimer(guideAction.action_delay, function()
          EpGuideUtil.ExecuteEpGuideActionOne(guideAction, self:GetEpBattleCount() - 1)
        end)
      else
        EpGuideUtil.ExecuteEpGuideActionOne(guideAction, self:GetEpBattleCount() - 1)
      end
    end
  end
  if self.CustomMoveCtrl ~= nil then
    self.CustomMoveCtrl:BeginCustomControl(battleCtrl, ExplorationManager:GetEpDungeonId())
  end
  DungeonBattleBaseCtrl.OnBattleStart(self, battleCtrl)
end

function ExplorationBattleCtrl:ReadyEnterBattleRunning()
  if not self.__loadedBattleObj or self.__curStateId ~= eBattleState.Deploy or self.battleCtrl == nil then
    return false
  end
  return true
end

function ExplorationBattleCtrl:EnterEpBattleRunning()
  if not self:ReadyEnterBattleRunning() then
    return
  end
  local battleWindow = UIManager:GetWindow(UIWindowTypeID.Battle)
  if battleWindow ~= nil then
    battleWindow:RealStartBattle()
    return
  end
  self.battleCtrl.fsm.currentState:StartBattle()
end

function ExplorationBattleCtrl:ShowRandomBeforeRandomUI(isDeployRoom)
  return
end

function ExplorationBattleCtrl:GetEffectPoolCtrl()
  return self.epCtrl.sceneCtrl.effectPoolCtrl
end

function ExplorationBattleCtrl:GetRoleAppearEffect()
  return self.epCtrl.sceneCtrl:GetRoleAppearEffect()
end

function ExplorationBattleCtrl:GetRoleDisappearEffect()
  return self.epCtrl.sceneCtrl:GetRoleDisappearEffect()
end

function ExplorationBattleCtrl:SetAmbush(bool)
  if bool then
    local win = UIManager:GetWindow(UIWindowTypeID.Battle)
    win:ChangeStartBattleBtnText(1)
    self.startBattleType = startBattleType.ambush
  else
    local win = UIManager:GetWindow(UIWindowTypeID.Battle)
    win:ChangeStartBattleBtnText(0)
    self.startBattleType = startBattleType.normal
  end
end

function ExplorationBattleCtrl:SetSneak()
  self.battleCtrl.fsm:ChangeState(CS_eBattleState.End)
  CS_BattleManager_Ins:ForceExitBattle()
  ExplorationManager.epCtrl:__EnterExplorationScene(2)
end

function ExplorationBattleCtrl:GetHeroObjectDic()
  return self.epCtrl.sceneCtrl.heroObjectDic
end

function ExplorationBattleCtrl:BattleLoadReady(battleController)
  if self.needShowEpBuff then
    self:__ShowEpBuff(battleController.BattleRoomData)
    self.needShowEpBuff = false
  end
end

function ExplorationBattleCtrl:__ShowEpBuff(roomData)
  local epBuffCfgList = roomData:GetEpBuffEffective(self.epCtrl.dynPlayer)
  if epBuffCfgList ~= nil and 0 < #epBuffCfgList then
    UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffShow, function(window)
      if window == nil then
        return
      end
      window:InitEpBuffShow(epBuffCfgList)
    end)
  end
end

function ExplorationBattleCtrl:_ShowWeeklyBossResult(battleEndState, evenId, dealBattleEndEventFunc)
  local combatStatStaticData = cs_BattleStatistics.combatStatStaticData
  local ok, unlimitedBossHp = combatStatStaticData.TotalRecord:TryGetValue(proto_object_CombatStatKey.CombatStatUnlimitedBoss)
  if not ok then
    unlimitedBossHp = 0
  end
  local tdHpPerDic
  if BattleUtil.IsInTDBattle() then
    tdHpPerDic = self.epCtrl.dynPlayer.dungeonRoleHpPerDic
  end
  local resultTab = {}
  local csBtCtrl = battleEndState.battleController
  local bossCharaEntity
  if BattleUtil.IsInTDBattle() then
    local dynMon = csBtCtrl.CurBattleMapCfg.waitToCasterMonsterList[csBtCtrl.CurBattleMapCfg.BossIndex]
    local bossUid = dynMon ~= nil and dynMon.uid
    if bossUid ~= nil then
      for i = 0, csBtCtrl.EnemyTeamController.battleRoleList.Count - 1 do
        local entity = csBtCtrl.EnemyTeamController.battleRoleList[i]
        if entity.uid == bossUid then
          bossCharaEntity = entity
          break
        end
      end
      if bossCharaEntity == nil then
        for i = 0, csBtCtrl.EnemyTeamController.deadbattleCharacterList.Count - 1 do
          local entity = csBtCtrl.EnemyTeamController.deadbattleCharacterList[i]
          if entity.uid == bossUid then
            bossCharaEntity = entity
            break
          end
        end
      end
    end
  else
    bossCharaEntity = csBtCtrl.EnemyTeamController.battleOriginRoleList[csBtCtrl.CurBattleMapCfg.BossIndex]
  end
  if bossCharaEntity ~= nil then
    resultTab.bossName = bossCharaEntity.name
    resultTab.bossCurHp = bossCharaEntity.hp
    resultTab.bossMaxHp = bossCharaEntity.maxHp
  end
  local battleFrame = csBtCtrl.frame
  resultTab.battleCurSecond = BattleUtil.FrameToTime(battleFrame)
  resultTab.battleAllSecond = BattleUtil.FrameToTime(cs_BattleStatistics.battleLimitFrame)
  UIManager:ShowWindowAsync(UIWindowTypeID.PeriodicBattleBossResult, function(win)
    if win == nil then
      return
    end
    win:Hide()
  end)
  local score = {}
  for k, v in pairs(csBtCtrl.gameScore) do
    score[k] = v
  end
  local isWin = evenId == DungeonBattleBaseCtrl.eBattleEndType.Victory
  cs_BattleStatistics:RecordBattleTime(battleFrame, csBtCtrl.CrazyTime, isWin)
  local combatStatDic = {}
  for k, v in pairs(combatStatStaticData.TotalRecord) do
    combatStatDic[k] = v
  end
  local valid = {}
  valid.score = score
  valid.combatStat = combatStatDic
  valid.activeAlgConsume = self:GetBattleConsumeSkillChipUseTimeDic(csBtCtrl.PlayerController)
  self.epCtrl.epNetwork:CS_WEEKLYCHALLENGE_ScorePreview(valid, tdHpPerDic, function(objList)
    if objList.Count ~= 1 then
      error("objList.Count error:" .. tostring(objList.Count))
      return
    end
    local msg = objList[0]
    resultTab.score = msg.score
    UIManager:ShowWindowAsync(UIWindowTypeID.PeriodicBattleBossResult, function(win)
      if win == nil then
        return
      end
      win:InitPeriodicBattleBossResult(resultTab, dealBattleEndEventFunc, function()
        battleEndState:RestartBattle()
      end, function()
        win:Hide()
        BattleUtil.ShowBattleResultSkada(csBtCtrl, function()
          win:Show()
        end)
      end)
    end)
  end)
end

function ExplorationBattleCtrl:OnBattleEnd(battleEndState, evenId, dealBattleEndEvent)
  if self.CustomMoveCtrl ~= nil then
    self.CustomMoveCtrl:EndCustomControl(battleEndState.battleController)
  end
  if ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge and (evenId == DungeonBattleBaseCtrl.eBattleEndType.Victory or evenId == DungeonBattleBaseCtrl.eBattleEndType.Failure) and self.epCtrl:GetCurrentRoomData():GetIsInBigBossRoom() then
    self:_ShowWeeklyBossResult(battleEndState, evenId, function()
      dealBattleEndEvent(evenId)
    end)
    return
  end
  if evenId == DungeonBattleBaseCtrl.eBattleEndType.Failure then
    self.epCtrl.autoCtrl:BreakAutoModeForce()
    self.epCtrl.autoCtrl:DisableEpAutoMode()
    local actionList = ExplorationManager:GetEpGuideActionList(self.__roomData.x, ExplorationEnum.epGuideMomentType.FailBattleRestart)
    if actionList ~= nil and 0 < #actionList then
      battleEndState:RestartBattle()
      EpGuideUtil.ExecuteEpGuideActions(actionList, self:GetEpBattleCount() - 1)
      return
    end
    if ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
      local contentNum = 286
      cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(contentNum), function()
        battleEndState:RestartBattle()
      end, function()
        dealBattleEndEvent(evenId)
      end)
    else
      local lastTime = self:GetEpBattleLastCount()
      if 0 < lastTime then
        UIManager:ShowWindowAsync(UIWindowTypeID.BattleFail, function(win)
          win:InitBattleFail(function()
            dealBattleEndEvent(evenId)
          end, function()
            self.epCtrl.epNetwork:CS_EXPLORATION_BATTLE_Restart(function(dataList)
              battleEndState:RestartBattle()
            end)
          end, function()
            win:Hide()
            BattleUtil.ShowBattleResultSkada(battleEndState.battleController, function()
              win:SetIgnoreDelayFlagOnce(true)
              win:Show()
            end)
          end)
        end)
      else
        dealBattleEndEvent(evenId)
      end
    end
  else
    if evenId == DungeonBattleBaseCtrl.eBattleEndType.Restart then
      self.epCtrl.autoCtrl:BreakAutoModeForce()
      self.epCtrl.autoCtrl:DisableEpAutoMode()
      local battleCtrl = battleEndState.battleController
      local dynPlayer = battleCtrl.PlayerData
      dynPlayer:RestNotPickupMoneyCount()
    end
    if evenId == DungeonBattleBaseCtrl.eBattleEndType.Victory and self.epCtrl.autoCtrl:IsAutoModeRunning() then
      local battleCtrl = battleEndState.battleController
      local roomData = battleCtrl.BattleRoomData
      if not roomData:IsBossRoom() then
        local count = 0
        local deadCount = 0
        local totalHpRatio = 0
        local roleList = battleCtrl.PlayerTeamController.battleOriginRoleList
        local len = roleList.Count
        for i = 0, len - 1 do
          local role = roleList[i]
          if not role.roleOnBench then
            if role.isDead then
              deadCount = deadCount + 1
            end
            count = count + 1
            local hpPer = role.hp / role.maxHp * 100
            totalHpRatio = totalHpRatio + hpPer
          end
        end
        local avgHpRatio = 0
        if 0 < count then
          avgHpRatio = totalHpRatio / count
        end
        if deadCount >= ConfigData.game_config.epAutoBattleJudge[1] or avgHpRatio <= ConfigData.game_config.epAutoBattleJudge[2] then
          cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(1201), function()
            self.epCtrl.autoCtrl:BreakAutoModeForce()
            self.epCtrl.autoCtrl:DisableEpAutoMode()
            battleEndState:RestartBattle()
          end, function()
            dealBattleEndEvent(evenId)
          end)
          return
        end
      end
    end
    dealBattleEndEvent(evenId)
  end
end

function ExplorationBattleCtrl:ReqStartBattle(battleRoomData, originRoleList, battleAction)
  battleRoomData:InitEpBuffEffective(nil)
  local position = battleRoomData.position
  local roleCount = originRoleList.Count
  local sendMsg = {}
  sendMsg.position = position
  sendMsg.data = {}
  for i = 0, roleCount - 1 do
    local role = originRoleList[i]
    local heroId = self.epCtrl.dynPlayer:GetDynHeroByDataId(role.roleDataId).uid
    local pos = BattleUtil.XYCoord2Pos(role.x, role.y)
    sendMsg.data[heroId] = pos
  end
  if self.startBattleType == startBattleType.normal then
    self.epCtrl.epNetwork:CS_EXPLORATION_BATTLE_Start(sendMsg, function(dataList)
      if battleAction ~= nil then
        local randomSeed = 0
        if dataList ~= nil and 0 < dataList.Count then
          local msg = dataList[0]
          randomSeed = msg.seed
          self.__restartCount = msg.times
        end
        battleAction(randomSeed)
        base.ReqStartBattle(self, battleRoomData, originRoleList, battleAction)
      end
      MsgCenter:Broadcast(eMsgEventId.OnEnterBattle)
    end)
  elseif self.startBattleType == startBattleType.ambush then
    self.epCtrl.epNetwork:CS_EXPLORATION_BATTLE_Ambush(sendMsg, function(dataList)
      if battleAction ~= nil then
        local randomSeed = 0
        if dataList ~= nil and 0 < dataList.Count then
          randomSeed = dataList[0]
        end
        battleAction(randomSeed)
        base.ReqStartBattle(self, battleRoomData, originRoleList, battleAction)
      end
      self.startBattleType = startBattleType.normal
    end)
  end
end

function ExplorationBattleCtrl:ReqBattleSettle(battleEndState, requestData)
  self.epCtrl.autoCtrl:OnAutoStageOver()
  local playerRoleSettle = requestData.playerRoleSettle
  local monsterRoleSettle = requestData.monsterRoleSettle
  local battleCtrl = battleEndState.battleController
  local battlePlayerController = battleCtrl.PlayerController
  local position = battleCtrl.BattleRoomData.position
  local dynPlayer = battleCtrl.PlayerData
  local sendMsg = {}
  local win = battleEndState.win
  local isWCLastBoss = battleCtrl.BattleRoomData:GetIsInBigBossRoom()
  sendMsg.position = position
  sendMsg.mp = dynPlayer.playerSkillMp
  sendMsg.hmp = dynPlayer.playerUltSkillMp
  sendMsg.tdmp = dynPlayer.playerTDMp or 0
  sendMsg.win = win or isWCLastBoss
  sendMsg.charHpPer = {}
  sendMsg.monsterHpPer = {}
  sendMsg.misc = self:CreateBattleSettleMisc(battleCtrl)
  sendMsg.valid = self:CreateBattleSettleValid(battleCtrl, requestData)
  sendMsg.eplGoldNum = dynPlayer:GetCacheMoneyCount()
  sendMsg.remainGlod = dynPlayer:GetNotPickupMoneyCount()
  dynPlayer:SetCacheMoneyCount(0)
  dynPlayer:SetNotPickupMoneyCount(0)
  self.__waitSettleResult = true
  local isBossRoom = self.epCtrl:GetCurrentRoomData():IsRealBossRoom()
  ExplorationManager.epMvpData:AddBattleStatisticsData(isBossRoom)
  local isInTdMode = BattleUtil.IsInTDBattle()
  local isInGuardMode = BattleUtil.IsInGuardBattle()
  if isInTdMode or isInGuardMode then
    sendMsg.tdHeroCoord = {}
    sendMsg.tdHpPer = dynPlayer.dungeonRoleHpPerDic
  end
  for k, v in pairs(playerRoleSettle) do
    local elem = {
      per = v.hpPer,
      dead = v.dead
    }
    local role = v.role
    elem.injury = cs_BattleStatistics:GetHeroInjury(role)
    elem.damage = cs_BattleStatistics:GetHeroDamage(role)
    elem.record = ExplorationManager.epMvpData:GetSaveData(role.roleDataId, isBossRoom)
    sendMsg.charHpPer[k] = elem
    if isInTdMode then
      local coord = self:__UpdatePlayerPosOnTDSettle(role.roleDataId, role.x, role.y)
      if coord ~= nil then
        sendMsg.tdHeroCoord[k] = coord
      end
    end
  end
  for i, v in ipairs(dynPlayer.heroList) do
    if sendMsg.charHpPer[v.uid] == nil then
      sendMsg.charHpPer[v.uid] = {
        per = v.hpPer,
        dead = v:IsDead(),
        injury = 0,
        damage = 0,
        record = ExplorationManager.epMvpData:GetSaveData(v.dataId, isBossRoom)
      }
    end
  end
  for k, v in pairs(monsterRoleSettle) do
    local elem = {
      per = v.hpPer,
      dead = v.dead
    }
    sendMsg.monsterHpPer[k] = elem
  end
  local combatStatStaticData = CS.BattleStatistics.Instance.combatStatStaticData
  sendMsg.valid.combatStat = {}
  if combatStatStaticData.TotalRecord ~= nil then
    for k, v in pairs(combatStatStaticData.TotalRecord) do
      sendMsg.valid.combatStat[k] = v
    end
  end
  local allDamageNum = self:CalTotalDamageValue()
  sendMsg.valid.luaCombatStat = {}
  sendMsg.valid.luaCombatStat[proto_object_CombatStatKey.LuaCombatHurtMonsterHp] = allDamageNum
  local dropBufffs = dynPlayer:GetDropBuffs()
  if 0 < #dropBufffs then
    sendMsg.valid.dropAlg = {}
    for i, v in ipairs(dropBufffs) do
      sendMsg.valid.dropAlg = dropBufffs
    end
  end
  if self.__forceWinWithoutReward then
    sendMsg.notOver = true
    self.__forceWinWithoutReward = nil
  end
  self.epCtrl.epNetwork:CS_EXPLORATION_BATTLE_Settle(sendMsg, function(dataList)
    if dataList.Count == 0 then
      return
    end
    local recvSettle = dataList[0]
    PlayerDataCenter:CleanTempOldEnemy()
    if win then
      self.__waitSettleResult = false
      local curRoomData = ExplorationManager.epCtrl:GetCurrentRoomData()
      if curRoomData ~= nil then
        curRoomData:InitRoomRewardGroup(recvSettle.showRewards)
      end
      return
    end
    if recvSettle.over or isWCLastBoss then
      if win == false and self.epCtrl.dynPlayer:GetOperatorDetail().canFloorOver then
        self.epCtrl:StartCompleteExploration(function()
          battleEndState:ResetPlayerCharacter(true)
          battleEndState:EndBattleAndClear()
          MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
        end)
      else
        self.epCtrl:ExplorationFailSettle(function()
          battleEndState:EndBattleAndClear()
        end)
      end
    else
      CS.MessageCommon.ShowMessageBoxConfirm(ConfigData:GetTipContent(1009), function()
        battleEndState:ResetPlayerCharacter(true)
        battleEndState:EndBattleAndClear()
        ExplorationManager.epCtrl:ContinueExploration(true)
        AudioManager:PlayAudioById(1026)
      end)
    end
    MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
  end)
end

function ExplorationBattleCtrl:CalTotalDamageValue()
  local num = 0
  local playerDamage = cs_BattleStatistics.playerDamage
  for i, v in pairs(playerDamage) do
    num = num + v.damage
  end
  local cmdDamage = cs_BattleStatistics.commanderDamager
  num = num + cmdDamage
  return num
end

function ExplorationBattleCtrl:VictoryBattleEndCoroutine(battleEndState)
  local battleController = battleEndState.battleController
  local CS_CameraController_Ins = CS.CameraController.Instance
  self.__waitSelectChip = true
  self.__settleTimelinePause = false
  self.__startSelectChip = false
  self.__showResultUI = false
  local curRoomData = ExplorationManager.epCtrl:GetCurrentRoomData()
  if curRoomData ~= nil then
    local roomMonsterCfg = ConfigData.exploration_room_monster[curRoomData.battleId]
    if roomMonsterCfg ~= nil then
      self.__isHideVictoryEffect = roomMonsterCfg.isHideVictoryEffect == 1
    end
  end
  local playerRoleList = battleController.PlayerTeamController.battleOriginRoleList
  local enemyRoleList = battleController.EnemyTeamController.battleOriginRoleList
  local mvpGrade = BattleUtil.GenMvp(playerRoleList)
  local battleEndCoroutine
  if self.__isHideVictoryEffect == true then
    function battleEndCoroutine()
      while self.__waitSettleResult do
        coroutine.yield()
      end
      self.epCtrl.autoCtrl:OnAutoStageOver()
      local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
      avgPlayCtrl:TryPlayTaskAvg(1, function()
        ExplorationManager.epCtrl:ContinueExploration()
      end)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.7))
      battleEndState:EndBattleAndClear()
      MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
    end
  else
    function battleEndCoroutine()
      CS_CameraController_Ins:PlaySettlementCut(battleController, mvpGrade.role, self:GetRoleMvpCameraOffset(mvpGrade.role))
      
      while self.__waitSettleResult do
        coroutine.yield()
      end
      UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
      if self.__settleTimelinePause then
        CS_CameraController_Ins:PauseSettlementCut(false)
      end
      while not self.__showResultUI do
        coroutine.yield()
      end
      ExplorationManager:PlayMVPVoice(mvpGrade.role.roleDataId)
      local dungeonRoleList = battleController.PlayerTeamController.battleRoleList
      self:PlayRoleWinActionAndEffect(dungeonRoleList, mvpGrade.role)
      UIManager:ShowWindowAsync(UIWindowTypeID.BattleResult, function(window)
        if window == nil then
          return
        end
        window:InitBattleResultData(playerRoleList, enemyRoleList, mvpGrade)
        window:SetContinueCallback(function()
          self.__startSelectChip = true
        end)
      end)
      while not CS_CameraController_Ins.settleTimlinePlayEnd or UIManager:GetWindow(UIWindowTypeID.BattleResult) == nil do
        coroutine.yield()
      end
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
      self.epCtrl.autoCtrl:OnEpBattleResultShow()
      while not self.__startSelectChip do
        coroutine.yield()
      end
      self.epCtrl.autoCtrl:OnAutoStageOver()
      local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
      avgPlayCtrl:TryPlayTaskAvg(1, function()
        ExplorationManager.epCtrl:ContinueExploration()
      end)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.7))
      battleEndState:EndBattleAndClear()
      MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
    end
  end
  return util.cs_generator(battleEndCoroutine)
end

function ExplorationBattleCtrl:OnTimelineNoticeOpenResultUI()
  self.__showResultUI = true
  if self.__waitSettleResult then
    CS.CameraController.Instance:PauseSettlementCut(true)
    self.__settleTimelinePause = true
  end
end

function ExplorationBattleCtrl:ReqBattleFreshFormation(battleController)
  local originRoleList = battleController.PlayerTeamController.battleOriginRoleList
  local roleCount = originRoleList.Count
  local posDic = {}
  for i = 0, roleCount - 1 do
    local role = originRoleList[i]
    local heroId = self.epCtrl.dynPlayer:GetDynHeroByDataId(role.roleDataId).uid
    local pos = BattleUtil.XYCoord2Pos(role.x, role.y)
    posDic[heroId] = pos
  end
  self.epCtrl.epNetwork:CS_EXPLORATION_FreshFromation(posDic)
  self.epCtrl.dynPlayer:RefreshCacheFightPower()
end

function ExplorationBattleCtrl:ReqGiveUpBattle(battleController)
  if self:IsBattleBeforeRunning() then
    ExplorationManager.epCtrl.autoCtrl:DisableEpAutoMode()
  end
  if self.epCtrl:IsCompleteExploration() then
    self:__BeforeExitEp(battleController)
    self.epCtrl:StartCompleteExploration()
    return
  end
  if ExplorationManager:HasEpRewardBag() then
    local hasReward = self.epCtrl.dynPlayer.dynRewardBag:HasEpRewardBagData()
    local msg
    if hasReward then
      msg = ConfigData:GetTipContent(753)
    else
      msg = ConfigData:GetTipContent(752)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageBox, function(win)
      if win == nil then
        return
      end
      win:ShowTextBoxWithYesAndNo(msg, function()
        self:__BeforeExitEp(battleController)
        self.epCtrl:ExplorationFailSettle()
      end)
    end)
    return
  end
  local returnStamina = ExplorationManager:GetReturnStamina()
  local msg
  if returnStamina == 0 then
    msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
  else
    msg = string.format(ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpoWithStaminaBack), tostring(returnStamina))
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageBox, function(win)
    if win == nil then
      return
    end
    win:ShowTextBoxWithYesAndNo(msg, function()
      self:__BeforeExitEp(battleController)
      ExplorationManager.resultCtrl:EnterResultProcess(false, true)
    end)
  end)
end

function ExplorationBattleCtrl:__BeforeExitEp(battleController)
  GuideManager:BreakSkipGuide()
  UIManager:HideWindow(UIWindowTypeID.BattlePause)
  battleController.fsm:ChangeState(CS.eBattleState.End)
  battleController.fsm.currentState:EndBattleAndClear()
end

function ExplorationBattleCtrl:ReqRestartBattle(battleController)
  self.epCtrl.epNetwork:CS_EXPLORATION_BATTLE_Restart(function(dataList)
    DungeonBattleBaseCtrl.ReqRestartBattle(self, battleController)
  end)
end

function ExplorationBattleCtrl:ReqRestartBattleForSkill(battleController, buffs, mp, hmp)
  self.epCtrl.epNetwork:CS_EXPLORATION_RecordRestartBattle(buffs, mp, hmp)
  self.epCtrl.epNetwork:CS_EXPLORATION_BATTLE_Restart(function(dataList)
    DungeonBattleBaseCtrl.ReqRestartBattleForSkill(self, battleController, buffs, mp, hmp)
  end)
end

function ExplorationBattleCtrl:GetEpBattleLastCount()
  return ConfigData.game_config.epBattleRestartLimit - math.max(0, (self.__restartCount or 0) - 1)
end

function ExplorationBattleCtrl:TryFinishBattleButNotFailure()
  self.__roomData:IsBattleRoom()
  if self.__curStateId ~= eBattleState.Running then
    error()
  end
  self.__forceWinWithoutReward = true
  LuaSkillCtrl:ForceEndBattle(true)
end

function ExplorationBattleCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnTimelineNoticeCreateResultUI, self.__OnTimelineNoticeOpenResultUI)
  DungeonBattleBaseCtrl.OnDelete(self)
  if self.CustomMoveCtrl ~= nil then
    self.CustomMoveCtrl:OnDelete()
    self.CustomMoveCtrl = nil
  end
end

return ExplorationBattleCtrl
