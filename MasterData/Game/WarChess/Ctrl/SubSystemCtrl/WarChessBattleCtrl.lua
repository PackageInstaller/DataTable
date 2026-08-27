local DungeonBattleBaseCtrl = require("Game.Common.CommonGameCtrl.DungeonBattleBaseCtrl")
local base = DungeonBattleBaseCtrl
local WarChessBattleCtrl = class("WarChessBattleCtrl", base)
local util = require("XLua.Common.xlua_util")
local CS_BattleManager_Ins = CS.BattleManager.Instance
local WarChessBattleSceneCtrl = require("Game.WarChess.Ctrl.SubSystemCtrl.WarChessBattleSceneCtrl")
local WarChessBattleRoom = require("Game.WarChess.Data.Battle.WarChessBattleRoom")
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local ChipData = require("Game.PlayerData.Item.ChipData")
local DeployTeamUtil = require("Game.Exploration.Util.DeployTeamUtil")
local WarChessBuffData = require("Game.WarChess.Data.WarChessBuffData")

function WarChessBattleCtrl:ctor(wcCtrl)
  self.wcCtrl = wcCtrl
  self.sceneCtrl = WarChessBattleSceneCtrl.New(wcCtrl, self)
  table.insert(self.wcCtrl.ctrls, self)
  self.wcCtrl.cat2SubCtrlDic[eWarChessEnum.eSystemCat.battle] = self
  self.bind = nil
  self.heroPrefabs = nil
  self.heroObjectDic = nil
  self.curDynPlayer = nil
  self.__winChipList = nil
  self.__winBuffList = nil
  self.__winRewardDic = nil
  self.__InstaKillFxName = nil
  self._eventCSelectChipComplete = BindCallback(self, self.__WCSelectChipComplete)
  self.__OnTimelineNoticeOpenResultUI = BindCallback(self, self.OnTimelineNoticeOpenResultUI)
  MsgCenter:AddListener(eMsgEventId.OnTimelineNoticeCreateResultUI, self.__OnTimelineNoticeOpenResultUI)
end

function WarChessBattleCtrl:GetBattleEntity()
  return self.enemyEntityData
end

function WarChessBattleCtrl:OpenWCSubSystem(systemState, identify)
  if systemState == nil or systemState.battleSystemData == nil then
    error("not have data")
    return
  end
  local x, y = WarChessHelper.Coordination2Pos(systemState.pos)
  local entityData = self.wcCtrl.mapCtrl:GetEntityDataByLogicPosXY(nil, x, y)
  self.enemyEntityData = entityData
  self.wcCtrl.palySquCtrl:SetWhereNewRewradBagFrom(entityData)
  local battleSystemData = systemState.battleSystemData
  self.curSceneId = battleSystemData.sceneId
  local monsters = battleSystemData.monsters
  local teamUid = identify.tid
  local teamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamUid(teamUid)
  self.teamData = teamData
  self.curDynPlayer = teamData:GetTeamDynPlayer()
  self.__systemPos = systemState.pos
  self.__allowQuit = battleSystemData.allowQuit
  self.__useedEventSystem = battleSystemData.useedEventSystem
  self.__identify = identify
  self.__refreshTime = battleSystemData.refreshTime
  self._originHeroPos = nil
  self.__winChipList = {}
  for _, v in pairs(battleSystemData.algList) do
    local chipData = ChipData.NewChipForServer(v)
    table.insert(self.__winChipList, chipData)
  end
  self.__winBuffList = battleSystemData.propChips
  self.__winRewardDic = battleSystemData.rewards or {}
  if systemState.state == eWarChessEnum.eSystemState.selectChip_miaosha then
    if isGameDev then
      print("<color=blue>skip battle</color>")
    end
    local pos = self.enemyEntityData:GetEntityShowPos()
    local instantDeathFx = self.wcCtrl.animaCtrl:ShowWCEffect(self.__InstaKillFxName or "FXP_bisha_GroundEffcte-monster", pos)
    self.enemyEntityData:PlayEntityAnimation(-1, nil, function()
      self.wcCtrl.animaCtrl:RecycleWCEffect(self.__InstaKillFxName or "FXP_bisha_GroundEffcte-monster", instantDeathFx)
      self:SelectWCBattleChip(true)
      self.enemyEntityData = nil
      self.__InstaKillFxName = nil
    end)
    return
  elseif systemState.state == eWarChessEnum.eSystemState.selectChip then
    self:SelectWCBattleChip(true)
    return
  end
  
  local function EnterBattleFunc()
    local loadingWindow = UIManager:GetWindow(UIWindowTypeID.WarChessLoading)
    if loadingWindow ~= nil then
      loadingWindow:Delete()
    end
    loadingWindow = UIManager:ShowWindow(UIWindowTypeID.WarChessLoading)
    if loadingWindow ~= nil then
      local enemyEntity = self:GetBattleEntity()
      local forcePos = Vector3.New(0, 0, 0)
      if enemyEntity ~= nil then
        forcePos = Vector3.New(enemyEntity.pos.x, enemyEntity.pos.y, enemyEntity.pos.z)
      end
      self.__isInBattleScene = true
      loadingWindow:PlayLoadEffect(forcePos, true, function()
        self.wcCtrl:LeaveWarChessSecne()
        self.sceneCtrl:WCLoadBattleScene(self.curSceneId, self.curDynPlayer, monsters, function()
          self:__InitBattle(teamData, battleSystemData)
        end)
      end)
    end
  end
  
  if self.enemyEntityData ~= nil then
    self.enemyEntityData:PlayMonsetAttackAnimation(self.teamData, EnterBattleFunc)
  else
    error("can't get enemyEntity by pos:" .. tostring(x) .. "," .. tostring(y))
    EnterBattleFunc()
  end
end

function WarChessBattleCtrl:__InitBattle(teamData, battleSystemData)
  if teamData:GetWCTeamIsGhost() or teamData:GetWCTeamIsDead() then
    error("dead or ghost team not allow to battle pls check it, force quit")
    WarChessManager:ExitWarChess()
    return
  end
  local wcDynPlayer = teamData:GetTeamDynPlayer()
  local battleRoomData = WarChessBattleRoom.CreateWCBattleRoom(battleSystemData, wcDynPlayer, self)
  self._battleRoomData = battleRoomData
  self.battleRoomId = battleSystemData.roomId
  WarChessManager:PlayWcAuBgm()
  if battleRoomData:IsWcBossRoom() then
    WarChessManager:PlayWcAuSelctBossCombat()
  else
    WarChessManager:PlayWcAuSelctNormalCombat()
  end
  local epWindow = UIManager:ShowWindow(UIWindowTypeID.DungeonStateInfo)
  epWindow:InitHeroAndChip(wcDynPlayer)
  local onBattleNum = 0
  local normalNum = ConfigData.formation_rule[0].stage_num
  if self.curDynPlayer ~= nil then
    self._originHeroPos = {}
    for index, dynHero in pairs(self.curDynPlayer.heroList) do
      local x, y = BattleUtil.Pos2XYCoord(dynHero.coord)
      local isOneBench = x >= ConfigData.buildinConfig.BenchX
      if not isOneBench then
        onBattleNum = onBattleNum + 1
        if normalNum < onBattleNum then
          local coord = BattleUtil.XYCoord2Pos(ConfigData.buildinConfig.BenchX, 0)
          dynHero:SetCoord(coord, ConfigData.buildinConfig.BenchX)
        end
      end
      self._originHeroPos[index] = dynHero.coord
    end
  else
    self._originHeroPos = nil
  end
  local size_row, size_col, deploy_rows = self.sceneCtrl:GetBattleFieldSizeBySceneId()
  DeployTeamUtil.AutoBattleDeploy(battleRoomData, wcDynPlayer.heroList, size_row, size_col, deploy_rows, false)
  WarChessManager:QuickExeWCGuideActions(eWarChessEnum.wcGuideMomentType.BeforeNewWCBattle, self.__systemPos)
  local IsWithFormation = true
  local battleCtrl = CS.BattleManager.Instance:StartNewBattle(battleRoomData, wcDynPlayer, self, not IsWithFormation)
  if IsWithFormation then
    battleCtrl:StartEnterDeployState()
    self.sceneCtrl:TryPlayFairyEnterAni(false)
  else
    battleCtrl:StartBattleSkipDeploy()
    self.sceneCtrl:TryPlayFairyEnterAni(true)
  end
end

function WarChessBattleCtrl:ReqStartBattle(battleRoomData, originRoleList, battleAction)
  local roleCount = originRoleList.Count
  self._startDeployPos = {}
  for i = 0, roleCount - 1 do
    local role = originRoleList[i]
    local pos = BattleUtil.XYCoord2Pos(role.x, role.y)
    local uid = role.uid
    self._startDeployPos[uid] = pos
  end
  if battleRoomData.formation then
  elseif battleAction ~= nil then
    battleAction()
    base.ReqStartBattle(self, battleRoomData, originRoleList, battleAction)
  end
end

function WarChessBattleCtrl:GetWCAllowRetreatBattle()
  return self.__allowQuit and not self.__useedEventSystem
end

function WarChessBattleCtrl:SetWCAllowRetreatBattle(active)
  self.__allowQuit = active
end

function WarChessBattleCtrl:SetWCUseedEventSystemInbattle()
  self.__useedEventSystem = true
end

function WarChessBattleCtrl:WCEscapeFromBattle(callback)
  if self.__allowQuit and not self.__useedEventSystem then
    self.wcCtrl.wcNetworkCtrl:CS_WarChess_BattleSystem_Quit(self.__identify, function(args)
      if args.Count == 0 then
        error("args.Count == 0")
        return
      end
      local isSuccess = args[0]
      if isSuccess then
        local battleController = CS.BattleManager.Instance.CurBattleController
        if battleController ~= nil then
          battleController.fsm:ChangeState(CS.eBattleState.End)
          battleController.fsm.currentState:ResetPlayerCharacter(true)
          battleController.fsm.currentState:EndBattleAndClear()
        end
        if self._originHeroPos ~= nil and self.curDynPlayer ~= nil then
          for k, coord in pairs(self._originHeroPos) do
            local dynHero = self.curDynPlayer.heroList[k]
            dynHero:SetCoord(coord, ConfigData.buildinConfig.BenchX)
          end
        end
        self._originHeroPos = nil
        if callback ~= nil then
          self.wcCtrl.palySquCtrl:SetReLoadSceneOverCallback(callback)
        end
        UIManager:DeleteAllWindow()
        self:ExitWCBattle(false, true)
      end
    end)
  end
end

function WarChessBattleCtrl:WCReturnBattleBefore()
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_BattleSystem_BackBeforeBattle(self.__identify, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local battleController = CS.BattleManager.Instance.CurBattleController
    if battleController ~= nil then
      battleController.fsm:ChangeState(CS.eBattleState.End)
      battleController.fsm.currentState:ResetPlayerCharacter(true)
      battleController.fsm.currentState:EndBattleAndClear()
    end
    if self._originHeroPos ~= nil and self.curDynPlayer ~= nil then
      for k, coord in pairs(self._originHeroPos) do
        local dynHero = self.curDynPlayer.heroList[k]
        dynHero:SetCoord(coord, ConfigData.buildinConfig.BenchX)
      end
    end
    self._originHeroPos = nil
    local warChess = args[0]
    self.wcCtrl.palySquCtrl:SetReLoadSceneOverCallback(function()
      self.wcCtrl:WarChessApplyTimeRewind(warChess)
    end)
    UIManager:DeleteAllWindow()
    self:ExitWCBattle(false, true)
  end)
end

function WarChessBattleCtrl:OnBattleEnd(battleEndState, evenId, dealBattleEndEvent)
  if WarChessSeasonManager:IsInWCS() then
    self:__OnBattleEndWcSeason(battleEndState, evenId, dealBattleEndEvent)
  else
    self:__OnBattleEndWc(battleEndState, evenId, dealBattleEndEvent)
  end
end

function WarChessBattleCtrl:__OnBattleEndWcSeason(battleEndState, evenId, dealBattleEndEvent)
  local function LocalFunc_OpenRewind()
    local warchessCtrl = WarChessManager:GetWarChessCtrl()
    
    local _, rewindCount = warchessCtrl.turnCtrl:GetWCRewindTimes()
    if rewindCount <= 0 then
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessTimeRewind, function(win)
      if win == nil then
        return
      end
      win:InitWCTimeRewindInBattle(function(wid, rewindTurnNum)
        self:WCEscapeFromBattle(function()
          self.wcCtrl.wcNetworkCtrl:CS_WarChess_ResetTheRound(wid, rewindTurnNum)
        end)
      end, function(wid)
        self:WCReturnBattleBefore()
      end)
    end)
  end
  
  local function LocalFunc_OpenReborn()
    local healingItemId, healingCount, enventId = WarChessSeasonManager:GetWcSSpItemByLogicType(eWarChessEnum.WCSpecialItemLogicType.healing)
    local spitemCfg = WarChessSeasonManager:GetWcSSpItemConfigByLogicType(eWarChessEnum.WCSpecialItemLogicType.healing)
    if (healingCount or 0) < spitemCfg.ex_arg2[2] then
      return
    end
    local WarchessEventUtil = require("Game.WarChess.WarchessEventUtil")
    WarchessEventUtil:ApplyWcEventInBattle(spitemCfg.ex_arg2[1], false, function()
      self.__useedEventSystem = true
      local battleCtrl = battleEndState.battleController
      local enemyList = battleCtrl.EnemyTeamController.battleOriginRoleList
      local curHpDic = {}
      for i = 0, enemyList.Count - 1 do
        local enemy = enemyList[i]
        curHpDic[enemy.uid] = enemy.hp * 10000 // enemy.maxHp
      end
      local luaEnemyList = self._battleRoomData.monsterList
      for i, monster in ipairs(luaEnemyList) do
        if curHpDic[monster.uid] ~= nil then
          monster.hpPer = curHpDic[monster.uid]
        else
          monster.hpPer = 0
          curHpDic[monster.uid] = 0
        end
      end
      local teamData = self.wcCtrl.battleCtrl:GetCurSelectedTeamData()
      local wid, tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(teamData)
      local identify = {wid = wid, tid = tid}
      self.wcCtrl.wcNetworkCtrl:CS_WarChess_BattleSystem_UpdateData(identify, curHpDic)
      self:ReqRestartBattle(battleEndState.battleController)
      UIManager:DeleteWindow(UIWindowTypeID.BattleFail)
      UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
      UIManager:DeleteWindow(UIWindowTypeID.RichIntro)
    end)
  end
  
  if evenId == DungeonBattleBaseCtrl.eBattleEndType.Failure then
    UIManager:ShowWindowAsync(UIWindowTypeID.BattleFail, function(win)
      win:InitWCSeasonBattleFail(self:GetBattleSettleName(), LocalFunc_OpenRewind, function()
        dealBattleEndEvent(evenId)
        UIManager:DeleteWindow(UIWindowTypeID.BattleFail)
      end, function()
        self:ReqRestartBattle(battleEndState.battleController)
      end, function()
        win:Hide()
        BattleUtil.ShowBattleResultSkada(battleEndState.battleController, function()
          win:SetIgnoreDelayFlagOnce(true)
          win:Show()
        end)
      end, LocalFunc_OpenReborn)
      if not self.__allowQuit then
        win:HideBattleReviewBtn()
      end
    end)
  else
    dealBattleEndEvent(evenId)
  end
end

function WarChessBattleCtrl:__OnBattleEndWc(battleEndState, evenId, dealBattleEndEvent)
  if evenId == DungeonBattleBaseCtrl.eBattleEndType.Failure then
    UIManager:ShowWindowAsync(UIWindowTypeID.BattleFail, function(win)
      win:InitWCBattleFail(self:GetBattleSettleName(), function()
        self:WCEscapeFromBattle()
      end, function()
        dealBattleEndEvent(evenId)
        UIManager:DeleteWindow(UIWindowTypeID.BattleFail)
      end, function()
        self:ReqRestartBattle(battleEndState.battleController)
      end, function()
        win:Hide()
        BattleUtil.ShowBattleResultSkada(battleEndState.battleController, function()
          win:SetIgnoreDelayFlagOnce(true)
          win:Show()
        end)
      end)
      win:SetBattleGiveupAcitve(self:GetWCAllowRetreatBattle())
    end)
  else
    dealBattleEndEvent(evenId)
  end
end

function WarChessBattleCtrl:ReqBattleSettle(battleEndState, requestData)
  local wid, tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(self.teamData)
  local isBattleWin = battleEndState.win
  local battleCtrl = battleEndState.battleController
  local playerRoleSettle = requestData.playerRoleSettle
  local monsterRoleSettle = requestData.monsterRoleSettle
  local dynPlayer = battleCtrl.PlayerData
  local sendMsg = {}
  sendMsg.identify = {wid = wid, tid = tid}
  sendMsg.win = isBattleWin
  sendMsg.misc = self:CreateBattleSettleMisc(battleCtrl)
  sendMsg.valid = self:CreateBattleSettleValid(battleCtrl, requestData)
  sendMsg.eplGoldNum = WarChessManager:GetWCCacheCoinNum()
  local isInGuardMode = self:IsInGuardBattle()
  if isInGuardMode then
    sendMsg.tdHpPer = dynPlayer.dungeonRoleHpPerDic
  end
  sendMsg.roles = {}
  for k, v in pairs(playerRoleSettle) do
    local role = v.role
    local coord
    if self._startDeployPos ~= nil then
      coord = self._startDeployPos[k]
    end
    local elem = {
      hp = v.hpPer,
      coordination = coord
    }
    sendMsg.roles[role.roleDataId] = elem
  end
  sendMsg.monster = {}
  local hpDic = {}
  for k, v in pairs(monsterRoleSettle) do
    local role = v.role
    if v.dead then
      sendMsg.monster[role.uid] = 0
      hpDic[role.uid] = 0
    else
      sendMsg.monster[role.uid] = v.hpPer
      hpDic[role.uid] = v.hpPer
    end
  end
  sendMsg.hmp = self.curDynPlayer.playerUltSkillMp
  sendMsg.mp = self.curDynPlayer.playerSkillMp
  sendMsg.tdmp = self.curDynPlayer.playerTDMp or 0
  local epMvpData = self.wcCtrl.teamCtrl:GetWCMvpData()
  epMvpData:AddBattleStatisticsData()
  local combatStatStaticData = CS.BattleStatistics.Instance.combatStatStaticData
  sendMsg.valid.combatStat = {}
  if combatStatStaticData.TotalRecord ~= nil then
    for k, v in pairs(combatStatStaticData.TotalRecord) do
      sendMsg.valid.combatStat[k] = v
    end
  end
  sendMsg.hurtMonsterHp = 0
  local playerDamageDic = CS.BattleStatistics.Instance.playerDamage
  for k, v in pairs(playerDamageDic) do
    sendMsg.hurtMonsterHp = v.damage + sendMsg.hurtMonsterHp
  end
  local bossDamageHpRatio = 0
  local bossEntity = battleCtrl.EnemyTeamController.bossEntity
  if bossEntity ~= nil then
    bossDamageHpRatio = math.floor((1 - bossEntity.hp / bossEntity.maxHp) * 1000)
  end
  sendMsg.bossDamagePecent = bossDamageHpRatio
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_BattleSystem_Settle(sendMsg, function()
    self._originHeroPos = nil
    if not isBattleWin then
      battleEndState:ResetPlayerCharacter(true)
      battleEndState:EndBattleAndClear()
      if self.enemyEntityData ~= nil then
        self.enemyEntityData:GenWCMonsterHP(hpDic)
      end
      self:ExitWCBattle(isBattleWin)
    end
    self.__waitSettleResult = false
  end)
end

function WarChessBattleCtrl:VictoryBattleEndCoroutine(battleEndState)
  local battleController = battleEndState.battleController
  local CS_CameraController_Ins = CS.CameraController.Instance
  self.__settleTimelinePause = false
  self.__showResultUI = false
  self.__startSelectChip = false
  self.__waitSettleResult = true
  local isBattleWin = battleEndState.win
  local playerRoleList = battleController.PlayerTeamController.battleOriginRoleList
  local enemyRoleList = battleController.EnemyTeamController.battleOriginRoleList
  local mvpGrade = BattleUtil.GenMvp(playerRoleList)
  
  local function battleEndCoroutine()
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
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessBattleResult, function(win)
      if win == nil then
        return
      end
      win:SetWCBattleResultTitle(self:GetBattleSettleName())
      win:SetWCBattleResultBattleData(playerRoleList, enemyRoleList, mvpGrade)
      win:SetWCBattleResultRewardData(self.__winRewardDic)
      win:SetContinueCallback(function()
        local loadingWindow = UIManager:ShowWindow(UIWindowTypeID.WarChessLoading)
        
        local function preLoadFunc()
          self.__startSelectChip = true
        end
        
        if loadingWindow ~= nil then
          loadingWindow:PlayLoadEffect(nil, false, preLoadFunc)
        end
      end)
    end)
    while not CS_CameraController_Ins.settleTimlinePlayEnd or UIManager:GetWindow(UIWindowTypeID.WarChessBattleResult) == nil do
      coroutine.yield()
    end
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    while not self.__startSelectChip do
      coroutine.yield()
    end
    battleEndState:ResetPlayerCharacter(true)
    battleEndState:EndBattleAndClear()
    CS_BattleManager_Ins:ClearBattleCache()
    self:ExitWCBattle(isBattleWin)
    MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
  end
  
  return util.cs_generator(battleEndCoroutine)
end

function WarChessBattleCtrl:OnTimelineNoticeOpenResultUI()
  self.__showResultUI = true
  if self.__waitSettleResult then
    CS.CameraController.Instance:PauseSettlementCut(true)
    self.__settleTimelinePause = true
  end
end

function WarChessBattleCtrl:ExitWCBattle(isBattleWin, isEscape)
  self.__isInBattleScene = false
  self.wcCtrl:ReLoadWarChessSecne(function()
    self.sceneCtrl:OnWCBattleOver()
    if isBattleWin then
      self:SelectWCBattleChip()
    end
    WarChessManager:QuickExeWCGuideActions(eWarChessEnum.wcGuideMomentType.WCBattleExit, self.__systemPos)
  end)
end

function WarChessBattleCtrl:SelectWCBattleChip(isSkipBattle)
  self:__WCDropBuff(function()
    local chipList = self.__winChipList
    if #chipList == 0 then
      if isSkipBattle then
        self:__WCSelectChipSkip()
      end
      return
    end
    local teamDataDic = self.wcCtrl.teamCtrl:GetWCTeams()
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessSelectChip, function(wcChipWindow)
      wcChipWindow:InitWCSelectChip(chipList, teamDataDic, self._eventCSelectChipComplete)
      wcChipWindow:InitWCSelectChipRefresh(BindCallback(self, self.__WCSelectChipRefresh), self.__refreshTime)
      wcChipWindow:InitWCSelectChipSkip(BindCallback(self, self.__WCSelectChipSkip))
      local logicPos = self.teamData:GetWCTeamServerPos()
      WarChessManager:QuickExeWCGuideActions(eWarChessEnum.wcGuideMomentType.WCBSelectChip, self.__systemPos)
    end)
  end)
end

function WarChessBattleCtrl:__WCSelectChipComplete(index, teamData, selectComplete)
  if selectComplete ~= nil then
    selectComplete()
  end
  index = index - 1
  local stid = teamData:GetWCTeamId()
  local wid, tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(self.teamData)
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_BattleSystem_SelectAlg(wid, tid, index, stid, function()
    if self.enemyEntityData ~= nil then
      self.enemyEntityData:PlayEntityAnimation(-1)
      self.enemyEntityData = nil
    end
  end)
end

function WarChessBattleCtrl:__WCSelectChipRefresh()
  local wid, tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(self.teamData)
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_BattleSystem_RefreshAlg(wid, tid, function(msgList)
    if msgList.Count <= 0 then
      return
    end
    local msg = msgList[0]
    local algList = msg.algList
    self.__winChipList = {}
    for _, v in pairs(algList) do
      local chipData = ChipData.NewChipForServer(v)
      table.insert(self.__winChipList, chipData)
    end
    local chipList = self.__winChipList
    if #chipList == 0 then
      return
    end
    local wcChipWindow = UIManager:GetWindow(UIWindowTypeID.WarChessSelectChip)
    if wcChipWindow == nil then
      return wcChipWindow
    end
    local teamDataDic = self.wcCtrl.teamCtrl:GetWCTeams()
    wcChipWindow:InitWCSelectChip(chipList, teamDataDic, self._eventCSelectChipComplete)
    wcChipWindow:UpdateWCSelectChipRefreshInfo()
    wcChipWindow:UpdateWCSelectChipSkipInfo()
  end)
end

function WarChessBattleCtrl:__WCSelectChipSkip(selectComplete)
  local wid, tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(self.teamData)
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_BattleSystem_DropAlg(wid, tid, function()
    if self.enemyEntityData ~= nil then
      self.enemyEntityData:PlayEntityAnimation(-1)
      self.enemyEntityData = nil
    end
    if selectComplete ~= nil then
      selectComplete()
    end
  end)
end

function WarChessBattleCtrl:__WCDropBuff(callback)
  if self.__winBuffList ~= nil and #self.__winBuffList > 0 then
    local buffList = {}
    for k, id in pairs(self.__winBuffList) do
      local wcsBuffData = WarChessBuffData.CrearteBuffById(id)
      table.insert(buffList, wcsBuffData)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(win)
      win:InitWCBuffDesc(buffList, callback, 3)
    end)
  elseif callback ~= nil then
    callback()
  end
end

function WarChessBattleCtrl:GetEffectPoolCtrl()
  return self.sceneCtrl.effectPoolCtrl
end

function WarChessBattleCtrl:GetHeroObjectDic()
  return self.sceneCtrl.heroObjectDic
end

function WarChessBattleCtrl:GetRoleAppearEffect()
  return self.sceneCtrl:GetRoleAppearEffect()
end

function WarChessBattleCtrl:GetRoleDisappearEffect()
  return self.sceneCtrl:GetRoleAppearEffect()
end

function WarChessBattleCtrl:BattleLoadReady(battleController)
  base.BattleLoadReady(self)
  self:TryShowWarChessBeforeBattleBuff(battleController.BattleRoomData)
end

function WarChessBattleCtrl:TryShowWarChessBeforeBattleBuff()
  local buffDic = self.wcCtrl.backPackCtrl:GetWCBuffDic()
  local showBuffList = {}
  for _, wcBuffData in pairs(buffDic) do
    if wcBuffData:GetWCBuffShowType() == eWarChessEnum.eWarChessBuffShowType.beforeBattle then
      table.insert(showBuffList, wcBuffData)
    end
  end
  if 0 < #showBuffList then
    UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(win)
      win:InitWCBuffDesc(showBuffList, nil, 5)
    end)
  end
end

function WarChessBattleCtrl:GetBattleSettleName()
  if self.battleRoomId == nil then
    return ""
  end
  local monsterGroupCfg = ConfigData.warchess_room_monster[self.battleRoomId]
  if monsterGroupCfg ~= nil then
    return LanguageUtil.GetLocaleText(monsterGroupCfg.mon_name)
  end
  return ""
end

function WarChessBattleCtrl:IsInGuardBattle()
  if self.battleRoomId == nil then
    return false
  end
  local monsterGroupCfg = ConfigData.warchess_room_monster[self.battleRoomId]
  if monsterGroupCfg ~= nil then
    return monsterGroupCfg.type == proto_csmsg_DungeonType.DungeonType_GuardianProfessor
  end
  return false
end

function WarChessBattleCtrl:SetInstaKillName(fxName)
  self.__InstaKillFxName = fxName
end

function WarChessBattleCtrl:GetIsInBattleScene()
  return self.__isInBattleScene
end

function WarChessBattleCtrl:CloseWCSubSystem(isSwitchClose)
  if isSwitchClose then
    error("warChess Battle system not support Switch")
  end
  self.__allowQuit = nil
  self.__useedEventSystem = nil
  return
end

function WarChessBattleCtrl:GetCurSelectedTeamData()
  return self.teamData
end

function WarChessBattleCtrl:Delete()
  self.sceneCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnTimelineNoticeCreateResultUI, self.__OnTimelineNoticeOpenResultUI)
  self:OnDelete()
end

return WarChessBattleCtrl
