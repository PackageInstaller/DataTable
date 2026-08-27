local DungeonBattleBaseCtrl = require("Game.Common.CommonGameCtrl.DungeonBattleBaseCtrl")
local BattleDungeonBattleCtrl = class("BattleDungeonBattleCtrl", DungeonBattleBaseCtrl)
local base = DungeonBattleBaseCtrl
local DungeonConst = require("Game.BattleDungeon.DungeonConst")
local DungeonBattleRoom = require("Game.BattleDungeon.Data.DungeonBattleRoom")
local ChipData = require("Game.PlayerData.Item.ChipData")
local JumpManager = require("Game.Jump.JumpManager")
local util = require("XLua.Common.xlua_util")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local DeployTeamUtil = require("Game.Exploration.Util.DeployTeamUtil")
local BattleCustomMoveCtrl = require("Game.BattleCustomMove.BattleCustomMoveCtrl")
local cs_BattleStatistics = CS.BattleStatistics.Instance
local cs_MessageCommon = CS.MessageCommon

function BattleDungeonBattleCtrl:ctor(bdCtrl)
  self.bdCtrl = bdCtrl
  table.insert(self.bdCtrl.ctrls, self)
  self.__battleStepLogic = BindCallback(self, self.DungeonBattleStepLogic)
  self.bdCtrl:RegisterDungeonLogic(DungeonConst.LogicType.BattleStep, self.__battleStepLogic)
  self.__chipStepLogic = BindCallback(self, self.DungeonChipStepLogic)
  self.bdCtrl:RegisterDungeonLogic(DungeonConst.LogicType.ChipStep, self.__chipStepLogic)
  self.__OnTimelineNoticeOpenResultUI = BindCallback(self, self.OnTimelineNoticeOpenResultUI)
  MsgCenter:AddListener(eMsgEventId.OnTimelineNoticeCreateResultUI, self.__OnTimelineNoticeOpenResultUI)
  self._OnWinterChallengeScoreShowFunc = BindCallback(self, self._OnWinterChallengeScoreShow)
  MsgCenter:AddListener(eMsgEventId.WinterChallengeScoreShow, self._OnWinterChallengeScoreShowFunc)
  self.__onOverKillValueChange = BindCallback(self, self.__OnOverKillValueChange)
  MsgCenter:AddListener(eMsgEventId.OnOverKillValueChange, self.__onOverKillValueChange)
end

function BattleDungeonBattleCtrl:GetEffectPoolCtrl()
  return self.bdCtrl.sceneCtrl.effectPoolCtrl
end

function BattleDungeonBattleCtrl:GetHeroObjectDic()
  return self.bdCtrl.sceneCtrl.heroObjectDic
end

function BattleDungeonBattleCtrl:OnBattleStateChange(battleCtrl, stateId, isDeployRoom)
  if stateId == eBattleState.Deploy then
    UIManager:ShowWindowOnly(UIWindowTypeID.EpChipSuit)
  elseif stateId == eBattleState.End then
    LuaSkillCtrl:DestoryBindSummonerGo()
  end
end

function BattleDungeonBattleCtrl:GetRoleAppearEffect()
  return self.bdCtrl.sceneCtrl:GetRoleAppearEffect()
end

function BattleDungeonBattleCtrl:GetRoleDisappearEffect()
  return self.bdCtrl.sceneCtrl:GetRoleDisappearEffect()
end

function BattleDungeonBattleCtrl:DungeonBattleStepLogic(monsterGroup)
  local battleRoomData = DungeonBattleRoom.CreateBattleDungeonRoom(self.bdCtrl, monsterGroup, self.bdCtrl.dungeonCfg, self.bdCtrl.dynPlayer)
  self.battleRoomData = battleRoomData
  local isBattleOffLine = isEditorMode and CS.GMController.Instance.isBattleOffLine
  if not isBattleOffLine then
    local dungeonCfg = self.bdCtrl.dungeonCfg
    DeployTeamUtil.AutoBattleDeploy(self.battleRoomData, self.bdCtrl.dynPlayer.heroList, dungeonCfg.size_row, dungeonCfg.size_col, dungeonCfg.deploy_rows, false)
  end
  local btlMgr = CS.BattleManager.Instance
  local IsWithFormation = self.battleRoomData.formation
  local battleCtrl = btlMgr:StartNewBattle(battleRoomData, self.bdCtrl.dynPlayer, self, not IsWithFormation)
  if BattleUtil.IsInBrotatBattle() then
    self.CustomMoveCtrl = BattleCustomMoveCtrl.CreateCustomMoveCtrl(btlMgr)
  end
  if IsWithFormation then
    battleCtrl:StartEnterDeployState()
    self.bdCtrl.sceneCtrl:TryPlayFairyEnterAni(false)
  else
    battleCtrl:StartBattleSkipDeploy()
    self.bdCtrl.sceneCtrl:TryPlayFairyEnterAni(true)
  end
  if isBattleOffLine then
    return
  end
  if self.bdCtrl.sceneCtrl.sceneWave ~= nil then
    UIManager:CreateWindowAsync(UIWindowTypeID.DungeonWaveTip, function(window)
      window:InjectWave(self.bdCtrl.sceneCtrl.sceneWave, self.bdCtrl.dungeonId)
      window:Show()
    end)
  end
end

function BattleDungeonBattleCtrl:ReqStartBattle(battleRoomData, originRoleList, battleAction)
  if self.battleRoomData.formation then
    local roleCount = originRoleList.Count
    local sendMsg = {}
    sendMsg.data = {}
    for i = 0, roleCount - 1 do
      local role = originRoleList[i]
      local heroId = role.roleDataId
      local pos = BattleUtil.XYCoord2Pos(role.x, role.y)
      local uid = self.bdCtrl.dynPlayer:GetDynHeroByDataId(heroId).uid
      sendMsg.data[uid] = pos
    end
    self.bdCtrl.battleNetwork:CS_BATTLE_StartBattleWithForm(sendMsg, function(objList)
      if battleAction ~= nil then
        local randomSeed = 0
        if objList ~= nil and 0 < objList.Count then
          randomSeed = objList[0]
        end
        battleAction(randomSeed)
        base.ReqStartBattle(self, battleRoomData, originRoleList, battleAction)
      end
    end)
  elseif battleAction ~= nil then
    battleAction()
    base.ReqStartBattle(self, battleRoomData, originRoleList, battleAction)
  end
end

function BattleDungeonBattleCtrl:OnBattleStart(battleCtrl)
  base.OnBattleStart(self, battleCtrl)
  local dInterfaceData = BattleDungeonManager.dunInterfaceData
  if dInterfaceData ~= nil then
    local enableRacingTime, lastRacingTime, hideCompare, hideRaceTimeShow = dInterfaceData:GetDunRacingData()
    if enableRacingTime then
      local uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
      if hideCompare then
        lastRacingTime = -1
      end
      if not hideRaceTimeShow then
        uiBattle.gameplayScore:StartBattleRacingShow(battleCtrl, lastRacingTime)
      end
    end
  end
  if self.CustomMoveCtrl ~= nil then
    self.CustomMoveCtrl:BeginCustomControl(battleCtrl, BattleDungeonManager:TryGetCurBattleDungeonId())
  end
end

function BattleDungeonBattleCtrl:OnBattleEnd(battleEndState, evenId, dealBattleEndEvent)
  local function dealBattleEndEventFunc()
    dealBattleEndEvent(evenId)
  end
  
  self._isWin = evenId == DungeonBattleBaseCtrl.eBattleEndType.Victory
  if self._isWin and BattleUtil.IsInCardSetDungeon() then
    self._delayReqBattleSettle = true
  end
  if evenId == DungeonBattleBaseCtrl.eBattleEndType.Failure and (BattleUtil.IsInDailyDungeon() or BattleUtil.IsInWinterChallengeDungeon() or BattleUtil.IsInHGV3NormalDungeon()) then
    self:_DailyDungeonFail(battleEndState, dealBattleEndEventFunc)
  else
    dealBattleEndEventFunc()
  end
  if self.CustomMoveCtrl ~= nil then
    self.CustomMoveCtrl:EndCustomControl(battleEndState.battleController)
  end
end

function BattleDungeonBattleCtrl:ReqBattleSettle(battleEndState, requestData, callBack)
  if self._delayReqBattleSettle then
    self._delayReqBattleSettleData = {battleEndState = battleEndState, requestData = requestData}
    return
  end
  self.__waitSettleResult = true
  if BattleUtil.IsInWinterChallengeDungeon() then
    self._lastWinChallengeScore = BattleDungeonManager.dunInterfaceData:GetDgWinChallengeCurScore()
  end
  local win = battleEndState.win
  local battleCtrl = battleEndState.battleController
  local playerRoleSettle = requestData.playerRoleSettle
  local monsterRoleSettle = requestData.monsterRoleSettle
  local battlePlayerController = battleCtrl.PlayerController
  local sendMsg = {}
  sendMsg.hero = {}
  sendMsg.monster = {}
  sendMsg.win = win
  sendMsg.misc = self:CreateBattleSettleMisc(battleCtrl)
  sendMsg.valid = self:CreateBattleSettleValid(battleCtrl, requestData)
  local isInTdMode = BattleUtil.IsInTDBattle()
  if isInTdMode then
    sendMsg.tdHeroCoord = {}
    sendMsg.tdHpPer = self.bdCtrl.dynPlayer.dungeonRoleHpPerDic
  end
  for k, v in pairs(playerRoleSettle) do
    sendMsg.hero[k] = v.hpPer
    local role = v.role
    if isInTdMode then
      local coord = self:__UpdatePlayerPosOnTDSettle(role.roleDataId, role.x, role.y)
      if coord ~= nil then
        sendMsg.tdHeroCoord[k] = coord
      end
    end
  end
  for k, v in pairs(monsterRoleSettle) do
    sendMsg.monster[k] = v.hpPer
  end
  sendMsg.hmp = self.bdCtrl.dynPlayer.playerUltSkillMp
  sendMsg.mp = self.bdCtrl.dynPlayer.playerSkillMp
  sendMsg.tdmp = self.bdCtrl.dynPlayer.playerTDMp or 0
  if BattleUtil.IsInWinterChallengeDungeon() then
    local combatStatStaticData = CS.BattleStatistics.Instance.combatStatStaticData
    sendMsg.valid.combatStat = {}
    local csBtCtrl = battleEndState.battleController
    cs_BattleStatistics:RecordBattleTime(csBtCtrl.frame, csBtCtrl.CrazyTime, true)
    if combatStatStaticData.TotalRecord ~= nil then
      for k, v in pairs(combatStatStaticData.TotalRecord) do
        sendMsg.valid.combatStat[k] = v
      end
    end
  end
  local allDamageNum = self:__CalDamageValue()
  self:__OnEndDamageValueChange(allDamageNum)
  sendMsg.valid.luaCombatStat = {}
  sendMsg.valid.luaCombatStat[proto_object_CombatStatKey.LuaCombatHurtMonsterHp] = self.__endDamageValue
  sendMsg.valid.overkill = self.__overkillValue or 0
  self.bdCtrl.battleNetwork:CS_BATTLE_BattleSettle(sendMsg, function(dataList)
    if not win and not BattleUtil.IsBattleEnableFormation() then
      self:_NormalDungeonFail(battleEndState)
    end
    self.bdCtrl:StartRunNextLogic()
    self.__waitSettleResult = false
    if callBack then
      callBack()
    end
  end)
end

function BattleDungeonBattleCtrl:_NormalDungeonFail(battleEndState)
  PlayerDataCenter.cacheSaveData:SetIsEndBattleForHeroInteration(true)
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonFailureResult, function(window)
    if window == nil then
      return
    end
    window:FailDungeon(function()
      battleEndState:EndBattleAndClear()
    end, function()
      self.bdCtrl:ExitBattleDungeon(false)
    end, function()
      window:Hide()
      UIManager:ShowWindowAsync(UIWindowTypeID.ResultSkada, function(SkadaWindow)
        if SkadaWindow == nil then
          return
        end
        SkadaWindow:InitBattleSkada(CS.BattleStatistics.Instance, battleEndState.battleController.PlayerTeamController.battleOriginRoleList, battleEndState.battleController.EnemyTeamController.battleOriginRoleList)
        SkadaWindow:SetSkadaCloseCallback(function()
          window:Show()
        end)
      end)
    end)
    if BattleDungeonManager.dunInterfaceData ~= nil and BattleDungeonManager.dunInterfaceData:AbleFailRestart() then
      self.battleEndState = battleEndState
      self.__BattleDungeonAgain = self.__BattleDungeonAgain or BindCallback(self, self.BattleDungeonAgain)
      window:DungeonFaileSetPlayeAgain(self.__BattleDungeonAgain, BattleDungeonManager.dunInterfaceData)
    end
    BattleDungeonManager.autoCtrl:ExitDungeonAutoModel()
  end)
end

function BattleDungeonBattleCtrl:_DailyDungeonFail(battleEndState, dealBattleEndEventFunc)
  PlayerDataCenter.cacheSaveData:SetIsEndBattleForHeroInteration(true)
  UIManager:ShowWindowAsync(UIWindowTypeID.BattleFail, function(win)
    win:SetBattleFailEnterFmtFunc(function()
      self.bdCtrl:AddDungeonLogic(DungeonConst.LogicType.DailyDungeonEnterFmt, nil, function()
        battleEndState:EndBattleAndClear()
        if BattleUtil.IsInDailyDungeon() then
          local dgDyncData = BattleDungeonManager.dunInterfaceData:GetDgInterfaceDungeonDyncData()
          local dailyDgCtrl = ControllerManager:GetController(ControllerTypeId.DailyDungeonLevelCtrl, true)
          dailyDgCtrl:ReqEnterDailyDungeon(dgDyncData)
        elseif BattleUtil.IsInWinterChallengeDungeon() then
          local dgLvData = BattleDungeonManager.dunInterfaceData:GetIDungeonLevelData()
          local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
          if sectorIICtrl ~= nil then
            sectorIICtrl:ReqEnterActSctIIChallengeDg(dgLvData)
          end
        elseif BattleUtil.IsInHGV3NormalDungeon(true) then
          local HGV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3, true)
          local hgv3Type = BattleDungeonManager.dunInterfaceData.hgv3Type
          local heroGrowV3Data = HGV3Ctrl:GetHeroGrowV3Data()
          local normalData = heroGrowV3Data:GetGetHGV3NormalDataDic()[hgv3Type]
          local dunStagIds = normalData:GetHGV3NormalLevels()
          local curIndex = normalData:GetHGV3CurLvProgress()
          local dunStageId = dunStagIds[curIndex + 1]
          HGV3Ctrl:EnterHeroGrowV3Normal(heroGrowV3Data, normalData, dunStageId)
        end
      end)
      dealBattleEndEventFunc()
    end)
    win:InitBattleFail(function()
      self.bdCtrl:AddDungeonLogic(DungeonConst.LogicType.ExitDungeon, nil, function()
        battleEndState:EndBattleAndClear()
        self.bdCtrl:ExitBattleDungeon(false)
      end)
      dealBattleEndEventFunc()
    end, function()
      battleEndState:RestartBattle()
    end, function()
      win:Hide()
      UIManager:ShowWindowAsync(UIWindowTypeID.ResultSkada, function(SkadaWindow)
        if SkadaWindow == nil then
          return
        end
        SkadaWindow:InitBattleSkada(cs_BattleStatistics, battleEndState.battleController.PlayerTeamController.battleOriginRoleList, battleEndState.battleController.EnemyTeamController.battleOriginRoleList)
        SkadaWindow:SetSkadaCloseCallback(function()
          win:SetIgnoreDelayFlagOnce(true)
          win:Show()
        end)
      end)
    end, function()
      if BattleUtil.IsInHGV3NormalDungeon() then
        local HGV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3, true)
        local hgv3Type = BattleDungeonManager.dunInterfaceData.hgv3Type
        local heroGrowV3Data = HGV3Ctrl:GetHeroGrowV3Data()
        local normalData = heroGrowV3Data:GetGetHGV3NormalDataDic()[hgv3Type]
        local dunStagIds = normalData:GetHGV3NormalLevels()
        local curIndex = normalData:GetHGV3CurLvProgress()
        local dunStageId = dunStagIds[curIndex + 1]
        local itemId, maxNum = heroGrowV3Data:GetHGV3medicineItemId()
        local curNum = PlayerDataCenter:GetItemCount(itemId)
        if curNum <= 0 then
          return
        end
        cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(7917), function()
          local actLongId = heroGrowV3Data:GetActFrameId()
          local moduleId = normalData:GetHGV3ModuleId()
          dealBattleEndEventFunc()
          self.bdCtrl:AddDungeonLogic(DungeonConst.LogicType.DailyDungeonEnterFmt, nil, function()
            NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_Activity_DungeonGroup_Restore(actLongId, moduleId, function()
              cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7918))
              battleEndState:EndBattleAndClear()
              HGV3Ctrl:EnterHeroGrowV3Normal(heroGrowV3Data, normalData, dunStageId)
            end)
          end)
        end, nil)
      end
    end)
    BattleDungeonManager.autoCtrl:ExitDungeonAutoModel()
  end)
end

function BattleDungeonBattleCtrl:VictoryBattleEndCoroutine(battleEndState)
  PlayerDataCenter.cacheSaveData:SetIsEndBattleForHeroInteration(true)
  local wave = self.bdCtrl.sceneCtrl.sceneWave
  local battleController = battleEndState.battleController
  if wave.total ~= wave.cur then
    battleController:PlayRecycleRoleEffect()
    battleEndState:EndBattleAndClear()
    return
  end
  local CS_CameraController_Ins = CS.CameraController.Instance
  self.__settleTimelinePause = false
  self.__showResultUI = false
  local playerRoleList = battleController.PlayerTeamController.battleOriginRoleList
  local enemyRoleList = battleController.EnemyTeamController.battleOriginRoleList
  local mvpGrade = BattleUtil.GenMvp(playerRoleList)
  local resultData = {
    playerRoleList = playerRoleList,
    enemyRoleList = enemyRoleList,
    lastHeroList = {}
  }
  local dungeonPlayer = battleController.PlayerData
  for _, dynHero in ipairs(dungeonPlayer.heroList) do
    local lastHeroData = {}
    lastHeroData.exp = dynHero:GetCurExp()
    lastHeroData.level = dynHero:GetLevel()
    lastHeroData.totalExp = dynHero:GetTotalExp()
    table.insert(resultData.lastHeroList, lastHeroData)
  end
  
  local function battleEndCoroutine()
    local isGuide = BattleDungeonManager:GetIsGuide()
    if not isGuide then
      local win = UIManager:CreateWindow(UIWindowTypeID.DungeonResult)
      win:Hide()
    end
    CS_CameraController_Ins:PlaySettlementCut(battleController, mvpGrade.role, self:GetRoleMvpCameraOffset(mvpGrade.role))
    while self.__waitSettleResult and not self._delayReqBattleSettle do
      coroutine.yield()
    end
    local resMsg = self.bdCtrl.objectCtrl.rewardMsg
    local resultInfo = {
      rewardMsg = resMsg,
      endDamageValue = self.__endDamageValue
    }
    BattleDungeonManager.dunInterfaceData:DealDungeonResult(resultInfo)
    if self.__settleTimelinePause then
      CS_CameraController_Ins:PauseSettlementCut(false)
    end
    while not self.__showResultUI do
      coroutine.yield()
    end
    self.battleEndState = battleEndState
    if self.bdCtrl.objectCtrl.dontShowResult then
      self.bdCtrl:ExitBattleDungeon(true)
      return
    end
    BattleDungeonManager:PlayMVPVoice(mvpGrade.role.roleDataId)
    local dungeonRoleList = battleController.PlayerTeamController.battleRoleList
    self:PlayRoleWinActionAndEffect(dungeonRoleList, mvpGrade.role)
    local isAuto, isEndAoto = BattleDungeonManager.autoCtrl:RecordAndCheckAutoState()
    local StOCareerItemIdDic = ConfigData.game_config.STOCareerCostDic
    local showRewards = {}
    local StOCareerRewardDic = {}
    local activityExchangeDic = {}
    local notShowExtrAward = BattleDungeonManager.dunInterfaceData:IsNotShowExtrAward()
    local extrAwardDic = {}
    table.merge(extrAwardDic, ConfigData.activity_time_limit.exchangeMapping)
    if not notShowExtrAward then
      local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
      if sectorIICtrl ~= nil then
        local idDic = sectorIICtrl:GetAfterBattleShowItemDic()
        table.merge(extrAwardDic, idDic)
      end
    end
    
    local function AddItemFunc(resourceDic)
      for id, count in pairs(resourceDic) do
        local dic
        if StOCareerItemIdDic[id] ~= nil then
          dic = StOCareerRewardDic
        elseif not notShowExtrAward and extrAwardDic[id] ~= nil then
          dic = activityExchangeDic
        else
          dic = showRewards
        end
        local newCount = dic[id] or 0
        dic[id] = newCount + count
      end
    end
    
    local challengeQuestRewards
    local challengeQuestList = table.emptytable
    if resMsg then
      AddItemFunc(resMsg.innerRewards)
      AddItemFunc(resMsg.firstClear)
      AddItemFunc(resMsg.overRewards)
    end
    local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment, true)
    aftertTeatmentCtrl:AddShowStOCareerReward(StOCareerRewardDic)
    aftertTeatmentCtrl:AddShowReward(activityExchangeDic)
    if resMsg and resMsg.challenge then
      challengeQuestList = resMsg.challenge.FinishQuestIds
      challengeQuestRewards = resMsg.challenge.challengeRewards
      local dungeonId = BattleDungeonManager.dunInterfaceData:GetDgInterfaceStgChallengeData():GetDgStgClgTaskDungeonId()
      if challengeQuestRewards ~= nil and 0 < #challengeQuestList then
        local fromNum = PlayerDataCenter.dungeonCenterData:GetDgChallengeTaskCompleteNum(dungeonId)
        local toNum = fromNum + #challengeQuestList
        local totalNum = PlayerDataCenter.dungeonCenterData:GetDgChallengeTaskNum(dungeonId)
        aftertTeatmentCtrl:SetShowChallengeModeReward(challengeQuestRewards, fromNum, toNum, totalNum)
      end
      for k, questId in ipairs(challengeQuestList) do
        PlayerDataCenter.dungeonCenterData:SetDgChallengeTaskComplete(dungeonId, questId)
      end
    end
    if isAuto then
      aftertTeatmentCtrl:AddDungeonAutoFightReward(BattleDungeonManager.dunInterfaceData, showRewards, self.bdCtrl.objectCtrl.rewardMsg.getATH, BattleDungeonManager.autoCtrl:GetRealBattleCount())
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.DungeonResult, function(window)
      if window == nil then
        return
      end
      if BattleUtil.IsInCardSetDungeon() then
        window:InitCardSetDgResult(resultData, mvpGrade)
        self:_AddCardSetResultShow(battleController)
      else
        local isGuide = BattleDungeonManager:GetIsGuide()
        window:CompleteDungeon(isGuide, self.bdCtrl.objectCtrl.rewardMsg, showRewards, resultData, mvpGrade, self.battleRoomData.dungeonType)
      end
      local curDungeonId = BattleDungeonManager:TryGetCurBattleDungeonId()
      MsgCenter:Broadcast(eMsgEventId.OnBattleResutltOpen, curDungeonId)
      if BattleUtil.IsInWinterChallengeDungeon() then
        local curScore = BattleDungeonManager.dunInterfaceData:GetDgWinChallengeCurScore()
        local scoreAdd = curScore - self._lastWinChallengeScore
        local dgLvData = BattleDungeonManager.dunInterfaceData:GetIDungeonLevelData()
        local isLastDg = dgLvData:IsSctIIChallengeDgLast(curDungeonId)
        window:InitWinterChallengeDgResult(scoreAdd, curScore, isLastDg, function()
          local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
          if sectorIICtrl ~= nil then
            battleEndState:EndBattleAndClear()
            sectorIICtrl:ReqEnterActSctIIChallengeDg(dgLvData)
          end
        end)
        self:DgTryAddWinterChallengeScoreShow()
      elseif BattleUtil.IsInDailyDungeon() then
        local dgDyncData = BattleDungeonManager.dunInterfaceData:GetDgInterfaceDungeonDyncData()
        if dgDyncData.isDailyDungeonNew then
          dgDyncData = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
        end
        local isLastDungeon = dgDyncData:IsDgDyncComplete()
        window:InitDailyDgResult(isLastDungeon, function()
          battleEndState:EndBattleAndClear()
          local dailyDgCtrl = ControllerManager:GetController(ControllerTypeId.DailyDungeonLevelCtrl, true)
          dailyDgCtrl:ReqEnterDailyDungeon(dgDyncData)
        end)
      elseif BattleUtil.IsInHGV3NormalDungeon() then
        local HGV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3, true)
        local hgv3Type = BattleDungeonManager.dunInterfaceData.hgv3Type
        local heroGrowV3Data = HGV3Ctrl:GetHeroGrowV3Data()
        local normalData = heroGrowV3Data:GetGetHGV3NormalDataDic()[hgv3Type]
        local dunStagIds = normalData:GetHGV3NormalLevels()
        local curIndex = normalData:GetHGV3CurLvProgress()
        local isLastDungeon = curIndex == #dunStagIds
        local dunStageId = dunStagIds[curIndex + 1]
        window:InitDailyDgResult(isLastDungeon, function()
          battleEndState:EndBattleAndClear()
          HGV3Ctrl:EnterHeroGrowV3Normal(heroGrowV3Data, normalData, dunStageId)
        end)
      end
      local winEvent = BattleDungeonManager:GetBattleWinEvent()
      if winEvent ~= nil then
        local hasSupport = BattleDungeonManager.dungeonCtrl.enterMsgData ~= nil and BattleDungeonManager.dungeonCtrl.enterMsgData.ab ~= nil
        winEvent(hasSupport)
      end
      self.__ExitBattleDungeon = self.__ExitBattleDungeon or BindCallback(self, self.ExitBattleDungeon)
      self.__BattleDungeonAgain = self.__BattleDungeonAgain or BindCallback(self, self.BattleDungeonAgain)
      self.__BattleDungeonNext = self.__BattleDungeonNext or BindCallback(self, self.BattleDungeonNextLevel)
      self.__CheckCanAutoAgain = self.__CheckCanAutoAgain or BindCallback(self, self.CheckCanAutoAgain)
      if not BattleUtil.IsInCardSetDungeon() then
        self.bdCtrl:AddDungeonLogic(DungeonConst.LogicType.ExitDungeon, nil, self.__ExitBattleDungeon)
      end
      
      local function continueFunc()
        self.bdCtrl:StartRunNextLogic()
      end
      
      window:SetContinueCallback(continueFunc)
      if BattleDungeonManager.dunInterfaceData ~= nil then
        if not isGuide then
          if BattleDungeonManager.dunInterfaceData:AbleContinueNextLevel() then
            window:DungeonSetPlayeNext(self.__BattleDungeonNext, BattleDungeonManager.dunInterfaceData)
          else
            local dungeonStageData = BattleDungeonManager.dunInterfaceData:GetIDungeonStageData()
            window:DungeonSetPlayeAgain(self.__BattleDungeonAgain, BattleDungeonManager.dunInterfaceData, dungeonStageData)
          end
        end
        local enableRacingTime, lastRacingTime, hideCompare = BattleDungeonManager.dunInterfaceData:GetDunRacingData()
        if enableRacingTime then
          local stime = BattleDungeonManager.dunInterfaceData:GetDunRacingServerTime()
          local frame = battleController.frame
          local isNew = false
          local isCheat = stime >= BattleUtil.CheatFrame
          if not isCheat then
            isNew = lastRacingTime < 0 or lastRacingTime > frame
            isNew = isNew and not hideCompare
          end
          window:InitDungeonRacingResult(frame, isCheat, isNew)
        end
        local enableDamageNum = BattleDungeonManager.dunInterfaceData:GetIsDunDamageNum()
        if enableDamageNum then
          window:InitDungeonDamageResult(self.__endDamageValue or 0, false, false)
        end
        local isNeedScoreAddRateShowCheck = false
        local dunScoreServerData = resMsg and resMsg.activityDailyChallengeDungeonScore
        if dunScoreServerData ~= nil then
          local dunScoreServerDataType = eDungeonEnum.activityDailyChallengeDungeonScoreType.Daily
          if dunScoreServerData[1] ~= nil and dunScoreServerData[2] ~= nil then
            local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
            if springCtrl then
              local springData = springCtrl:GetTheLastSpring()
              if springData:IsActivityRunning() and springData:CheckIsSpringChallengeDungeon(dunScoreServerData[1]) then
                springData:UpdateDungeonFrameByDunId(dunScoreServerData[1], dunScoreServerData[2])
                dunScoreServerDataType = eDungeonEnum.activityDailyChallengeDungeonScoreType.Spring
              end
            end
          end
          local dungeonLevelData = BattleDungeonManager.dunInterfaceData:GetIDungeonLevelData()
          local dungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
          if dungeonLevelData ~= nil and dungeonLevelData:GetDungeonLevelType() == dungeonLevelEnum.DunLevelType.ActBlackHole and dunScoreServerData[2] ~= nil and dunScoreServerData[3] ~= nil and dunScoreServerData[4] ~= nil then
            local highestScore = dungeonLevelData:GetBlackHoleScoreNum()
            local frameTime = dunScoreServerData[3]
            local isCheatFrameTime = dunScoreServerData[4] == 1
            local isNewFrameTime = false
            window:InitDungeonRacingResult(frameTime, isCheatFrameTime, isNewFrameTime)
            local score = dunScoreServerData[2]
            local isNewScore = highestScore < score
            local isCheatScore = score == 0 or dunScoreServerData[4] == 1
            window:InitDungeonScoreResult(score, isNewScore, isCheatScore)
            dunScoreServerDataType = eDungeonEnum.activityDailyChallengeDungeonScoreType.BlackHole
          end
          if dungeonLevelData and dungeonLevelData:GetDungeonLevelType() == dungeonLevelEnum.DunLevelType.CommonHard then
            dunScoreServerDataType = eDungeonEnum.activityDailyChallengeDungeonScoreType.CommonHard
            window:InitDungeonScoreResult(dunScoreServerData[2], false, dunScoreServerData[3] == 1)
          end
          if dunScoreServerDataType == eDungeonEnum.activityDailyChallengeDungeonScoreType.Daily and dunScoreServerData[2] ~= nil then
            window:InitDungeonScoreResult(dunScoreServerData[2], false, dunScoreServerData[3] == 1)
            isNeedScoreAddRateShowCheck = dunScoreServerData[3] == 1
          end
          local enableScoreAddRate, scoreAddRate = BattleDungeonManager.dunInterfaceData:GetDunScoreAddRate()
          if enableScoreAddRate then
            window:InitDungeonScoreAddRateResult(scoreAddRate, false, isNeedScoreAddRateShowCheck)
          end
        end
      end
      if resMsg and 0 < table.count(resMsg.extraRewards) then
        UIManager:ShowWindowAsync(UIWindowTypeID.BattleResultExtra, function(resultExtraWindow)
          if resultExtraWindow == nil then
            return
          end
          if UIManager:GetWindow(UIWindowTypeID.DungeonResult) == nil then
            UIManager:DeleteWindow(UIWindowTypeID.BattleResultExtra)
            return
          end
          resultExtraWindow:InitBattleResultExtra(resMsg.extraRewards)
        end)
      end
      if isAuto then
        local battleCount = BattleDungeonManager.autoCtrl:GetBattleCount()
        local totalCount = BattleDungeonManager.autoCtrl:GetTotalDungeonAutoCount()
        self.__RealDungeonAgainCallback = self.__RealDungeonAgainCallback or BindCallback(self, self.__RealBattleAgain)
        BattleDungeonManager.autoCtrl:OnEnterBattleResult(self.__RealDungeonAgainCallback, self.__ExitBattleDungeon, self.__CheckCanAutoAgain, self.__BattleDungeonNext)
        window:InitAutoModeShow(battleCount, totalCount)
      end
    end)
  end
  
  return util.cs_generator(battleEndCoroutine)
end

function BattleDungeonBattleCtrl:OnTimelineNoticeOpenResultUI()
  self.__showResultUI = true
  if self.__waitSettleResult then
    CS.CameraController.Instance:PauseSettlementCut(true)
    self.__settleTimelinePause = true
  end
end

function BattleDungeonBattleCtrl:ReqBattleFreshFormation(battleController)
end

function BattleDungeonBattleCtrl:DungeonChipStepLogic(chipDataGroup)
  local rewardChipList = {}
  for k, v in ipairs(chipDataGroup.alg) do
    local chipData = ChipData.NewChipForServer(v)
    rewardChipList[k] = chipData
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectChip, function(window)
    if window == nil then
      return
    end
    MsgCenter:Broadcast(eMsgEventId.OnSettleMentTimeLinePlayToEnd)
    window:InitSelectChip(false, rewardChipList, self.bdCtrl.dynPlayer, BindCallback(self, self.__SelectChipComplete), BindCallback(self, self.__GiveSelectChipComplect), false, nil)
  end)
end

function BattleDungeonBattleCtrl:__SelectChipComplete(index, selectComplete)
  index = index - 1
  self.bdCtrl.battleNetwork:CS_BATTLE_AlgSelect(index, function(dataList)
    self.bdCtrl:StartRunNextLogic()
    if selectComplete ~= nil then
      selectComplete()
    end
  end)
end

function BattleDungeonBattleCtrl:__GiveSelectChipComplect(selectComplete)
  self.epNetwork:CS_BATTLE_AlgGiveUp(function()
    if selectComplete ~= nil then
      selectComplete()
    end
  end)
end

function BattleDungeonBattleCtrl:ReqGiveUpBattle(battleController)
  battleController.fsm:ChangeState(CS.eBattleState.End)
  battleController.fsm.currentState:EndBattleAndClear()
  self.bdCtrl.battleNetwork:CS_BATTLE_Quit(function()
    GuideManager:BreakSkipGuide()
    BattleDungeonManager:ExitDungeon()
  end)
end

function BattleDungeonBattleCtrl:BattleDungeonAgain(dinterfaceData)
  if dinterfaceData == nil then
    return
  end
  if dinterfaceData:RestartAthAlreadyFull() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    return
  end
  if dinterfaceData:GetReplayStaminaReplaceItemId() == ConstGlobalItem.SKey and PlayerDataCenter.stamina:GetCurrentStamina() < dinterfaceData:GetIStaminaCost() then
    JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
    return
  end
  if dinterfaceData:RestartAthMaybeFull() then
    cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(145), function()
      self:__RealBattleAgain(dinterfaceData)
    end, nil)
  else
    self:__RealBattleAgain(dinterfaceData)
  end
end

function BattleDungeonBattleCtrl:__RealBattleAgain(dinterfaceData)
  if self.battleEndState ~= nil then
    self.clearBattleFlag = true
  end
  local battleRestartEvent = dinterfaceData:GetIDungeonRestartEvent()
  if battleRestartEvent ~= nil then
    local formation = BattleDungeonManager:GetFormation()
    battleRestartEvent(formation, nil, dinterfaceData)
  end
end

function BattleDungeonBattleCtrl:BattleDungeonNextLevel(dinterfaceData)
  if dinterfaceData == nil then
    return
  end
  if dinterfaceData:RestartAthAlreadyFull() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    return
  end
  if dinterfaceData:GetINextStaminaReplaceItemId() == ConstGlobalItem.SKey and PlayerDataCenter.stamina:GetCurrentStamina() < dinterfaceData:GetINextStaminaCost() then
    JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
    return
  end
  if self.battleEndState ~= nil then
    self.clearBattleFlag = true
  end
  local battleNextEvent = dinterfaceData:GetIDungeonNextLevelEvent()
  if battleNextEvent ~= nil then
    local formation = BattleDungeonManager:GetFormation()
    battleNextEvent(formation, nil, dinterfaceData)
  end
end

function BattleDungeonBattleCtrl:CheckCanAutoAgain()
  local dungeonStageData = BattleDungeonManager.dunInterfaceData:GetIDungeonStageData()
  if dungeonStageData ~= nil and dungeonStageData:IsHaveATHReward() then
    local canContinue = #PlayerDataCenter.allAthData:GetAllAthList() < ConfigData.game_config.athMaxNum - ConfigData.game_config.athSpaceNotEnoughNum
    local reallyCannot = #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum
    return canContinue, ConfigData:GetTipContent(145), reallyCannot
  end
  return true
end

function BattleDungeonBattleCtrl:_AddCardSetResultShow(battleController)
  local battleFrame = battleController.frame
  local dungeonPlayer = battleController.PlayerData
  local dynHeroList = dungeonPlayer.heroList
  local dynFairyData = dungeonPlayer:GetDynFairyData()
  
  local function showFunc()
    UIManager:ShowWindowAsync(UIWindowTypeID.CardSetBattleResult, function(win)
      if win == nil then
        return
      end
      
      local function confirmFunc()
        local function afterSettleFunc()
          local rewardMsg = self.bdCtrl.objectCtrl.rewardMsg
          
          local rewardDic = rewardMsg.overRewards
          if table.IsEmptyTable(rewardDic) then
            self.__ExitBattleDungeon()
            return
          end
          UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
            if window ~= nil then
              local CommonRewardData = require("Game.CommonUI.CommonRewardData")
              local CRData = CommonRewardData.CreateCRDataUseDic(rewardDic):SetCRShowOverFunc(self.__ExitBattleDungeon)
              window:AddAndTryShowReward(CRData)
            end
          end)
        end
        
        self._delayReqBattleSettle = false
        self:ReqBattleSettle(self._delayReqBattleSettleData.battleEndState, self._delayReqBattleSettleData.requestData, afterSettleFunc)
      end
      
      win:InitCardSetBattleResult(battleFrame, dynHeroList, dynFairyData, confirmFunc)
    end)
  end
  
  self.bdCtrl:AddDungeonLogic(DungeonConst.LogicType.CardSetBattleResult, nil, showFunc)
end

function BattleDungeonBattleCtrl:_OnWinterChallengeScoreShow(msg)
  local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment, true)
  aftertTeatmentCtrl:AddShowReward(msg.rewards)
  self._winterChallengeScoreShowMsg = msg
end

function BattleDungeonBattleCtrl:DgTryAddWinterChallengeScoreShow()
  if self._winterChallengeScoreShowMsg == nil then
    return
  end
  local msg = self._winterChallengeScoreShowMsg
  
  local function ShowScoreFunc()
    UIManager:ShowWindowAsync(UIWindowTypeID.WCDebuffResult, function(window)
      if window == nil then
        return
      end
      
      local function nextFunc()
        self.bdCtrl:StartRunNextLogic()
      end
      
      local historyMaxScore = BattleDungeonManager.dunInterfaceData:GetDgWinChallengeMaxScore()
      window:InitWinChallengeScoreShow(msg, self._isWin, historyMaxScore, nextFunc)
    end)
  end
  
  self.bdCtrl:AddDungeonLogic(DungeonConst.LogicType.WinterChallengeScoreShow, nil, ShowScoreFunc)
end

function BattleDungeonBattleCtrl:__OnOverKillValueChange(value, isEnd)
  if not isEnd then
    return
  end
  self.__overkillValue = value or 0
end

function BattleDungeonBattleCtrl:__CalDamageValue()
  local num = 0
  local playerDamage = cs_BattleStatistics.playerDamage
  for i, v in pairs(playerDamage) do
    num = num + v.damage
  end
  local cmdDamage = cs_BattleStatistics.commanderDamager
  num = num + cmdDamage
  return num
end

function BattleDungeonBattleCtrl:__OnEndDamageValueChange(value)
  self.__endDamageValue = value or 0
end

function BattleDungeonBattleCtrl:ExitBattleDungeon()
  if self.battleEndState ~= nil then
    self.battleEndState:EndBattleAndClear()
  end
  self.bdCtrl:ExitBattleDungeon(true, true)
end

function BattleDungeonBattleCtrl:OnDelete()
  if self.bdCtrl.objectCtrl.dontShowResult then
    PlayerDataCenter:UnlockCommanderSkill()
    if self.battleEndState ~= nil then
      self.battleEndState:EndBattleAndClear()
    end
    return
  end
  if self.battleEndState ~= nil and self.clearBattleFlag then
    self.battleEndState:EndBattleAndClear()
    self.clearBattleFlag = false
  end
  self.bdCtrl:UnRegisterDungeonLogic(DungeonConst.LogicType.BattleStep, self.__battleStepLogic)
  self.bdCtrl:UnRegisterDungeonLogic(DungeonConst.LogicType.ChipStep, self.__chipStepLogic)
  MsgCenter:RemoveListener(eMsgEventId.OnTimelineNoticeCreateResultUI, self.__OnTimelineNoticeOpenResultUI)
  MsgCenter:RemoveListener(eMsgEventId.WinterChallengeScoreShow, self._OnWinterChallengeScoreShowFunc)
  MsgCenter:RemoveListener(eMsgEventId.OnOverKillValueChange, self.__onOverKillValueChange)
  self.battleEndState = nil
  DungeonBattleBaseCtrl.OnDelete(self)
  if self.CustomMoveCtrl ~= nil then
    self.CustomMoveCtrl:OnDelete()
    self.CustomMoveCtrl = nil
  end
end

return BattleDungeonBattleCtrl
