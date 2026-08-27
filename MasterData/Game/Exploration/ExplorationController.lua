local ExplorationController = class("ExplorationController")
local ExplorationPlayerCtrl = require("Game.Exploration.Ctrl.ExplorationPlayerCtrl")
local ExplorationMapCtrl = require("Game.Exploration.Ctrl.ExplorationMapCtrl")
local ExplorationTreasureCtrl = require("Game.Exploration.Ctrl.ExplorationTreasureCtrl")
local ExplorationStoreCtrl = require("Game.Exploration.Ctrl.ExplorationStoreCtrl")
local ExplorationResidentStoreCtrl = require("Game.Exploration.Ctrl.ExplorationResidentStoreCtrl")
local ExplorationEventCtrl = require("Game.Exploration.Ctrl.ExplorationEventCtrl")
local ExplorationResetRoomCtrl = require("Game.Exploration.Ctrl.ExplorationResetRoomCtrl")
local ExplorationSceneCtrl = require("Game.Exploration.Ctrl.ExplorationSceneCtrl")
local ExplorationBattleCtrl = require("Game.Exploration.Ctrl.ExplorationBattleCtrl")
local ExplorationAutoCtrl = require("Game.Exploration.Ctrl.ExplorationAutoCtrl")
local ExplorationCampFetterCtrl = require("Game.Exploration.Ctrl.ExplorationCampFetterCtrl")
local ExplorationSupportCtrl = require("Game.Exploration.Ctrl.ExplorationSupportCtrl")
local ExplorationOverclockCtrl = require("Game.Exploration.Ctrl.ExplorationOverclockCtrl")
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local ePlayerState = {
  InTheRoom = 1,
  OutsideTheRoom = 2,
  SelectingChip = 3,
  HalfOver = 4,
  DropChip = 5,
  BattleFailure = 6,
  ReplaceChip = 7,
  MonsterLvUpgrade = 8
}

function ExplorationController:ctor(mapData, dynPlayer)
  self.ctrls = {}
  self.mapData = mapData
  self.dynPlayer = dynPlayer
  self.loadSceneComplete = false
  self.playerCtrl = ExplorationPlayerCtrl.New(self)
  self.mapCtrl = ExplorationMapCtrl.New(self)
  self.treasureCtrl = ExplorationTreasureCtrl.New(self)
  self.storeCtrl = ExplorationStoreCtrl.New(self)
  self.eventCtrl = ExplorationEventCtrl.New(self)
  self.resetRoomCtrl = ExplorationResetRoomCtrl.New(self)
  self.sceneCtrl = ExplorationSceneCtrl.New(self)
  self.battleCtrl = ExplorationBattleCtrl.New(self)
  self.residentStoreCtrl = ExplorationResidentStoreCtrl.New(self)
  self.autoCtrl = ExplorationAutoCtrl.New(self)
  self.campFetterCtrl = ExplorationCampFetterCtrl.New(self)
  self.epSupportCtrl = ExplorationSupportCtrl.New(self)
  self.overclockCtrl = ExplorationOverclockCtrl.New(self)
  self.epNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.itemRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.ItemRoom)
  self.storeRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.StoreRoom)
  self.eventRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.EventRoom)
  self.resetRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.ResetRoom)
  self.__onUpdateNextRoomInfo = BindCallback(self, self.UpdateNextRoomInfo)
  MsgCenter:AddListener(eMsgEventId.OnEpGridDetailDiff, self.__onUpdateNextRoomInfo)
  self.__onEpResidentDiff = BindCallback(self, self.UpdateResidentDetail)
  MsgCenter:AddListener(eMsgEventId.OnEpResidentDiff, self.__onEpResidentDiff)
  self.__onEnterEpSceneCompleteAction = BindCallback(self, self.__OnEnterEpSceneComplete)
end

function ExplorationController:RecordLastSelectChoiceCtrl(roomCtrl)
  self.__lastSelectChoiceCtrl = roomCtrl
end

function ExplorationController:GetLastSelectChoiceCtrl()
  return self.__lastSelectChoiceCtrl
end

function ExplorationController:Start(isReconnect, isFirstEnter)
  self.__isReconnect = isReconnect
  self.__isFirstEnter = isFirstEnter
  self.sceneCtrl:FirstEnterScene(BindCallback(self, self.OnSceneLoadComplete), BindCallback(self, self.OnStartTimelineComplete))
end

function ExplorationController:IsFirstEnterEp()
  return self.__isFirstEnter
end

function ExplorationController:OnSceneLoadComplete()
  self.loadSceneComplete = true
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Sector.name, eAuSelct.Sector.normalCombat)
  local sceneCfg = self.mapData:GetEpSceneCfg()
  AudioManager:PlayAudioById(sceneCfg.audio_id)
  local epWindow = UIManager:ShowWindow(UIWindowTypeID.Exploration)
  epWindow:ShowExplorationFirst(self.dynPlayer)
  epWindow:Hide()
  local epWindow = UIManager:ShowWindow(UIWindowTypeID.DungeonStateInfo)
  epWindow:InitHeroAndChip(self.dynPlayer)
  epWindow:Hide()
  local curRoomData = self:GetCurrentRoomData()
  MsgCenter:Broadcast(eMsgEventId.OnEpPlayerMoveComplete, curRoomData)
  GuideManager:TryTriggerGuide(eGuideCondition.InExploration)
end

function ExplorationController:OnStartTimelineComplete()
  self:ContinueExploration()
  self.autoCtrl:OnExplorationStart()
end

function ExplorationController:ContinueExploration(isRevive)
  self.__isRevive = isRevive or false
  local currentRoom = self:GetCurrentRoomData()
  local opDetail = self.dynPlayer:GetOperatorDetail()
  local opState = opDetail.state
  if opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_Secleted then
    if self.inTheTempRoom then
      return
    end
    if currentRoom:IsBattleRoom() then
      self:__EnterBattleScene(currentRoom, self.__isReconnect)
    else
      self:__EnterExplorationScene(ePlayerState.InTheRoom)
    end
  elseif opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    self:__EnterExplorationScene(ePlayerState.OutsideTheRoom)
  elseif opState == proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleALGWaiting then
    self:__EnterExplorationScene(ePlayerState.SelectingChip)
  elseif opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_DropAlg then
    self:__EnterExplorationScene(ePlayerState.DropChip)
  elseif opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_MonsterLvUpgrade then
    if self.__isReconnect then
      self:__EnterExplorationScene(ePlayerState.MonsterLvUpgrade)
    else
      self:__EnterExplorationScene(ePlayerState.OutsideTheRoom)
    end
  elseif opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_HalfOver then
    self:__EnterExplorationScene(ePlayerState.HalfOver)
  elseif opState == proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleFailure then
    self:__EnterExplorationScene(ePlayerState.BattleFailure)
  elseif opState == proto_object_ExplorationCurGridState.ExplorationCurGridStateReplaceChip then
    self:__EnterExplorationScene(ePlayerState.ReplaceChip)
  else
    error("Unsupported opState : " .. tostring(opState))
  end
  self.campFetterCtrl:__OnEpOpStateChanged(nil, opState)
  self.__isReconnect = nil
end

function ExplorationController:__EnterExplorationScene(state)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Sector.name, eAuSelct.Sector.roomSelect)
  self.__playerState = state
  if self.sceneCtrl:InBattleScene() then
    local window = UIManager:GetWindow(UIWindowTypeID.Exploration)
    if window ~= nil then
      window:RefreshPlayerData(self.dynPlayer)
    end
    self.sceneCtrl:BattleToExplorationScene(self.__onEnterEpSceneCompleteAction)
  else
    self.sceneCtrl:ChangeEpSceneState(ExplorationEnum.eEpSceneState.InEpScene)
    self:__OnEnterEpSceneComplete()
  end
end

function ExplorationController:__OnEnterEpSceneComplete()
  if self.__playerState == ePlayerState.InTheRoom then
    local currentRoom = self:GetCurrentRoomData()
    self:OnPlayerMoveComplete(currentRoom)
  elseif self.__playerState == ePlayerState.OutsideTheRoom then
    self._outsideTheRoomFunc = self._outsideTheRoomFunc or function()
      self:CheckBossRoom()
      GuideManager:TryTriggerGuide(eGuideCondition.InEpRoomOutside)
    end
    if not self.residentStoreCtrl:CheckEpResidentStore(self._outsideTheRoomFunc) then
      self._outsideTheRoomFunc()
    end
    self.__isFirstEnter = false
  elseif self.__playerState == ePlayerState.SelectingChip then
    self.__ContinueSelectChipCompleteFunc = self.__ContinueSelectChipCompleteFunc or BindCallback(self, self.__ContinueSelectChipComplete)
    self:CheckChipSelect(self.__ContinueSelectChipCompleteFunc)
    GuideManager:TryTriggerGuide(eGuideCondition.InEpRoomOutside)
  elseif self.__playerState == ePlayerState.DropChip then
    self:DiscardChip()
  elseif self.__playerState == ePlayerState.BattleFailure then
    self:ExplorationFailSettle()
  elseif self.__playerState == ePlayerState.HalfOver then
    warn("未实现该功能：中场结束,自动选下一个房间")
  elseif self.__playerState == ePlayerState.ReplaceChip then
    self:OpenChipReplace()
  elseif self.__playerState == ePlayerState.MonsterLvUpgrade then
    self:OpenSelectDebuffUI()
  end
end

function ExplorationController:__ContinueSelectChipComplete()
  if self.dynPlayer:GetOperatorDetailState() ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_DropAlg then
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.OutsideSelectChip)
  end
end

function ExplorationController:CheckBossRoom()
  local currentRoom = self:GetCurrentRoomData()
  if currentRoom:IsRealBossRoom() then
    if self.mapData:HasWeeklyChallengeBigBossRoom() then
      local bossMonsterName = "?"
      local bigBossRoomData = currentRoom:GetNextRoom()[1]
      if bigBossRoomData ~= nil and bigBossRoomData.mode == 5 then
        for _, dynMonster in pairs(bigBossRoomData.monsterList) do
          if dynMonster:GetBossBloodNum() > 0 then
            bossMonsterName = dynMonster:GetName()
            break
          end
        end
      end
      cs_MessageCommon.ShowMessageBox(string.format(ConfigData:GetTipContent(905), bossMonsterName))
    elseif self.mapData:HasOverBossRoom() then
      if self.autoCtrl:IsAutoModeRunning() or self.__isRevive then
      else
        local stageId = ExplorationManager:GetSectorStageCfg().id
        local curFloor = ExplorationManager:GetCurLevelIndex() + 1
        ControllerManager:GetController(ControllerTypeId.AvgPlay, true):TryPlayAvg(eAvgTriggerType.MainAvgEp, stageId, curFloor, 3, function()
          UIManager:ShowWindowAsync(UIWindowTypeID.MessageBox, function(win)
            if win == nil then
              return
            end
            win:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(255), function()
            end, function()
              self:StartCompleteExploration()
            end)
          end)
        end)
      end
    else
      self:StartCompleteExploration()
    end
  elseif currentRoom:IsEndColRoom() then
    self:StartCompleteExploration()
  end
end

function ExplorationController:IsCompleteExploration()
  if self.dynPlayer:GetOperatorDetail().canFloorOver and not ExplorationManager:HasNextLevel() then
    return true
  end
  return false
end

function ExplorationController:StartCompleteExploration(endAction)
  if ExplorationManager:HasNextLevel() then
    self:__CompleteExplorationFloor(endAction)
  else
    self:__CompleteExploration(endAction)
  end
end

function ExplorationController:__CompleteExplorationFloor(endAction)
  UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
    if window ~= nil then
      window:CompleteExplorationFloor(data)
    end
    self.autoCtrl:OnEpFloorSettle()
    if self.mapCtrl ~= nil then
      self.mapCtrl:HideMapCavasWithoutBg()
    end
    UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
    UIManager:HideWindow(UIWindowTypeID.Exploration)
    if endAction ~= nil then
      endAction()
    end
  end)
end

function ExplorationController:ExplorationFailSettle(clearAction)
  if ExplorationManager:HasEpRewardBag() then
    local epBagDropList = ExplorationManager:GetDynPlayer().dynRewardBag:GetEpRewardBagDataList()
    local hasBagDrop = epBagDropList ~= nil and 0 < #epBagDropList
    if hasBagDrop then
      UIManager:ShowWindowAsync(UIWindowTypeID.EpRewardBag, function(window)
        if window == nil then
          return
        end
        local rewardList = ExplorationManager:GetDynPlayer().dynRewardBag:GetEpRewardBagDataList()
        local stageCfg = ExplorationManager:GetSectorStageCfg()
        local epModuleId = ExplorationManager:GetEpModuleId()
        local stageId = ExplorationManager:GetEpDungeonId()
        window:InitEpRewardBag(rewardList, stageCfg, true, nil, true, epModuleId, stageId)
        self.autoCtrl:CloseAutoMode()
        if self.mapCtrl ~= nil then
          self.mapCtrl:HideMapCavasWithoutBg()
        end
        UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
        UIManager:HideWindow(UIWindowTypeID.Exploration)
        UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
        window:SetEpRewardBagCloseFunc(function(rewardDic)
          window:Delete()
          UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(resultWindow)
            if resultWindow == nil then
              return
            end
            resultWindow:FailExploration(clearAction, nil, rewardDic, true)
          end)
        end)
      end)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(resultWindow)
        if resultWindow == nil then
          return
        end
        self.autoCtrl:CloseAutoMode()
        if self.mapCtrl ~= nil then
          self.mapCtrl:HideMapCavasWithoutBg()
        end
        UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
        UIManager:HideWindow(UIWindowTypeID.Exploration)
        UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
        resultWindow:FailExploration(clearAction, nil, nil, false)
      end)
    end
  elseif ExplorationManager:GetIsInWeeklyChallenge() then
    ExplorationManager:SendSettle(function(dataList)
      local msgData
      if dataList.Count > 0 then
        msgData = dataList[0]
      else
        msgData = {}
      end
      UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
        if window == nil then
          return
        end
        self.autoCtrl:CloseAutoMode()
        window:FailExploration(clearAction, msgData.rewards)
      end)
    end, false, nil, false)
  else
    self.epNetwork:CS_EXPLORATION_RewardsShow(function(dataList)
      local msgData
      if dataList.Count > 0 then
        msgData = dataList[0]
      else
        msgData = {}
      end
      if ExplorationManager:GetIsInWeeklyChallenge() then
        ExplorationManager:SendSettle(function()
          UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
            if window == nil then
              return
            end
            self.autoCtrl:CloseAutoMode()
            window:FailExploration(clearAction, msgData.rewards)
          end)
        end, false, nil, false)
      else
        UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
          if window == nil then
            return
          end
          self.autoCtrl:CloseAutoMode()
          window:FailExploration(clearAction, msgData.rewards)
        end)
      end
    end)
  end
end

function ExplorationController:__CompleteExploration(endAction)
  local beforeSettleStageState = PlayerDataCenter.sectorStage:GetStageState(ExplorationManager:GetSectorStageCfg().id)
  local resultSettlementData = ExplorationManager.epCtrl.dynPlayer:SetResultSettlementData()
  CS.BattleManager.Instance:ForceExitBattle()
  Time.unity_time.timeScale = 1
  if ExplorationManager:HasEpRewardBag() then
    local epBagDropList = ExplorationManager:GetDynPlayer().dynRewardBag:GetEpRewardBagDataList()
    local hasBagDrop = epBagDropList ~= nil and 0 < #epBagDropList
    if hasBagDrop then
      UIManager:ShowWindowAsync(UIWindowTypeID.EpRewardBag, function(window)
        if window == nil then
          return
        end
        local rewardList = ExplorationManager:GetDynPlayer().dynRewardBag:GetEpRewardBagDataList()
        local stageCfg = ExplorationManager:GetSectorStageCfg()
        local epModuleId = ExplorationManager:GetEpModuleId()
        local stageId = ExplorationManager:GetEpDungeonId()
        local firstClearRewards = ExplorationManager:GetEpFirstClearDic(stageId, epModuleId)
        window:InitEpRewardBag(rewardList, stageCfg, true, firstClearRewards, true, epModuleId, stageId)
        self.autoCtrl:CloseAutoMode()
        if self.mapCtrl ~= nil then
          self.mapCtrl:HideMapCavasWithoutBg()
        end
        UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
        UIManager:HideWindow(UIWindowTypeID.Exploration)
        UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
        if endAction ~= nil then
          endAction()
        end
        window:SetEpRewardBagCloseFunc(function(rewardDic)
          window:Delete()
          UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(resultWindow)
            local epModuleId = ExplorationManager:GetEpModuleId()
            local stageId = ExplorationManager:GetEpDungeonId()
            local firstClearRewards = ExplorationManager:GetEpFirstClearDic(stageId, epModuleId)
            if resultWindow ~= nil then
              resultWindow:CompleteExploration(nil, firstClearRewards, nil, resultSettlementData, rewardDic, true)
            end
          end)
        end)
      end)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(resultWindow)
        local epModuleId = ExplorationManager:GetEpModuleId()
        local stageId = ExplorationManager:GetEpDungeonId()
        local firstClearRewards = ExplorationManager:GetEpFirstClearDic(stageId, epModuleId)
        if resultWindow ~= nil then
          resultWindow:CompleteExploration(nil, firstClearRewards, nil, resultSettlementData, nil, false)
        end
        self.autoCtrl:CloseAutoMode()
        if self.mapCtrl ~= nil then
          self.mapCtrl:HideMapCavasWithoutBg()
        end
        UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
        UIManager:HideWindow(UIWindowTypeID.Exploration)
        UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
        if endAction ~= nil then
          endAction()
        end
      end)
    end
  else
    ExplorationManager:SendSettle(function(msg)
      local data = {}
      if msg.Count < 1 then
        error("can't get msg arg0")
      else
        data = msg[0]
      end
      local StageState = PlayerDataCenter.sectorStage:GetStageState(ExplorationManager:GetSectorStageCfg().id)
      local needFirsPassReward = false
      if StageState ~= beforeSettleStageState and StageState == proto_object_DungeonStageState.DungeonStageStatePicked then
        needFirsPassReward = true
      end
      UIManager:ShowWindowAsync(UIWindowTypeID.ExplorationResult, function(window)
        if window ~= nil then
          window:CompleteExploration(data.rewards, data.firstClearRewards, needFirsPassReward, resultSettlementData)
        end
        self.autoCtrl:CloseAutoMode()
        if self.mapCtrl ~= nil then
          self.mapCtrl:HideMapCavasWithoutBg()
        end
        UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
        UIManager:HideWindow(UIWindowTypeID.Exploration)
        UIManager:HideWindow(UIWindowTypeID.EpEventRoom)
        if endAction ~= nil then
          endAction()
        end
      end)
    end, nil, nil, true)
  end
  local heroIdList = {}
  for index, heroData in ipairs(self.dynPlayer.heroList) do
    table.insert(heroIdList, heroData.dataId)
  end
end

function ExplorationController:__EnterBattleScene(roomData, isReconnect)
  if isGameDev then
    print("[Dev]battleId:", roomData.battleId)
  end
  if self.bloodGridMax == nil then
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local unitBlood, bossUnitBlood = saveUserData:GetUnitBlood()
    if 0 < (unitBlood or 0) then
      self:SetBloodGrid(unitBlood, bossUnitBlood)
    else
      self:CalculateBloodGrid()
    end
  end
  roomData.battleMap:SetBloodGridParam(self.unitBlood, self.bossUnitBlood, self.bloodGridMax)
  if (roomData:IsBossRoom() or roomData:GetRoomType() == ExplorationEnum.eRoomType.challenge) and not ExplorationManager:IsSectorNewbee() then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Sector.name, eAuSelct.Sector.bossCombat)
  else
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Sector.name, eAuSelct.Sector.normalCombat)
  end
  self:RollbackTempChipCurBattleRoom(self.dynPlayer:GetEpBuffChipDic())
  self:ExecuteTempChipCurBattleRoom(self.dynPlayer:GetEpBuffChipDic())
  local window = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if window ~= nil then
    window:Hide(true)
  end
  window = UIManager:GetWindow(UIWindowTypeID.Exploration)
  if window ~= nil then
    window:Hide(true)
  end
  local csbattleCtrl = self.battleCtrl:StartNewEpBattle(roomData, self.dynPlayer)
  
  local function epToBattleAction()
    csbattleCtrl:StartEnterDeployState()
  end
  
  if roomData:IsDeployRoom() or isReconnect then
    self.sceneCtrl:ExplorationToBattleSceneInReconnected(epToBattleAction)
  else
    local epDetail = self.dynPlayer:GetOperatorDetail()
    local index = epDetail.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over and #epDetail.path - 1 or #epDetail.path
    local lastRoomCoord = epDetail.path[index]
    local lastRoomPos = self.mapCtrl:GetRoomEntity(lastRoomCoord):GetRoomEntityLocalPos(0)
    local curRoomPos = self.mapCtrl:GetRoomEntity(roomData.position):GetRoomEntityLocalPos(0)
    local isUp = curRoomPos.y > lastRoomPos.y
    local dir = -1
    if isUp then
      dir = 1
    end
    if roomData:IsBossRoom() then
      dir = 0
    end
    local roomPos = self.mapCtrl:GetRoomEntityPos(roomData)
    local mapRoot = self:GetRoomRoot()
    self.sceneCtrl:ExplorationToBattleSceneNormal(dir, mapRoot, roomPos, epToBattleAction)
  end
end

function ExplorationController:EnterDeployRoom()
  local epState = self.dynPlayer:GetOperatorDetailState()
  if epState ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    return
  end
  local deployRoomData = self.mapData:GetDeployRoom()
  self:__EnterBattleScene(deployRoomData)
end

function ExplorationController:GenExplorationMap()
  self.mapCtrl:GenMap(self.mapData, self:GetCurrentRoomData(true))
end

function ExplorationController:SetViewPositionOffset(offsetPosition)
  local position = self.mapCtrl:GetViewPosition() + offsetPosition
  return self.mapCtrl:SetViewPosition(position)
end

function ExplorationController:GetViewPosition()
  return self.mapCtrl:GetViewPosition()
end

function ExplorationController:OnPlayerMoveStart(roomData)
  AudioManager:PlayAudioById(1002)
  if roomData:IsBattleRoom() then
    self.mapCtrl:PlayerPosItemMove2NextPos()
    self:OnPlayerMoveComplete(roomData)
  else
    UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
    local roomUI = self:GetRoomUI(roomData.position)
    self.mapCtrl:PlayerPosItemMove2NextPos()
    self.sceneCtrl.epSceneEntity:EpRoomCoverBattleMap(true, function()
      self:OnPlayerMoveComplete(roomData)
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    end, roomUI.transform.position)
  end
end

function ExplorationController:OnPlayerMoveComplete(roomData)
  local roomLogicType = roomData:GetRoomLogicType()
  if roomData:IsBattleRoom() then
    self:__EnterBattleScene(roomData)
  elseif roomLogicType == ExplorationEnum.eRoomLogicType.chip then
    self.resetRoomCtrl:OnResetRoomOpen(roomData)
  elseif roomLogicType == ExplorationEnum.eRoomLogicType.store then
    self.storeCtrl:OnStoreRoomOpen(roomData, true)
  elseif roomLogicType == ExplorationEnum.eRoomLogicType.treasure then
    self.treasureCtrl:OnTreasureRoomOpen(roomData, true)
  elseif roomLogicType == ExplorationEnum.eRoomLogicType.event then
    self.eventCtrl:OnEventRoomOpen(roomData, true)
  elseif roomLogicType == ExplorationEnum.eRoomLogicType.none then
  elseif roomLogicType > ExplorationEnum.eRoomLogicType.none or roomLogicType == nil then
    error("Unsupported room logicType : " .. tostring(roomLogicType))
  end
  MsgCenter:Broadcast(eMsgEventId.OnEpPlayerMoveComplete, roomData)
  roomData:ResetJumpCat()
end

function ExplorationController:OnExitEpRoom()
  local curRoomData = self:GetCurrentRoomData(true)
  if curRoomData:IsEndColRoom() then
    return
  end
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
  self.mapCtrl:PlayerPosItemMove2NextPos(function()
    self.sceneCtrl.epSceneEntity:EpRoomCoverBattleMap(true, function()
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
      if curRoomData:IsCrossRoom() and not self.autoCtrl:IsAutoModeRunning() then
        GuideManager:TryTriggerGuide(eGuideCondition.AfterEpCrossRoom)
      end
    end)
  end)
end

function ExplorationController:UpdateNextRoomInfo(epGrid, jumpCat)
  if epGrid.monster ~= nil then
    for k, v in pairs(epGrid.monster) do
      local roomData = self.mapData:GetRoomByCoord(k)
      if roomData ~= nil and roomData:IsBattleRoom(jumpCat) then
        roomData:InitBattleData(v)
        roomData:ExecuteMonsterChip(self.dynPlayer)
        if roomData:IsGuardTDBattle() then
          roomData:ExecuteDungeonRoleChip(self.dynPlayer)
        end
        self.mapCtrl:ShowFightingPower(roomData, self.dynPlayer:GetCacheFightPower())
        roomData:SetAmbushAndSneakData(v.ambush, v.stealth)
      end
    end
  end
  if epGrid.item ~= nil then
    for k, v in pairs(epGrid.item) do
      local roomData = self.mapData:GetRoomByCoord(k)
      if roomData ~= nil then
        roomData:InitTreasureRoomData(v)
      end
    end
  end
  if epGrid.store ~= nil then
    for k, v in pairs(epGrid.store) do
      local roomData = self.mapData:GetRoomByCoord(k)
      if roomData ~= nil then
        roomData:InitStoreRoomData(v)
      end
    end
  end
  if epGrid.evt ~= nil then
    for k, v in pairs(epGrid.evt) do
      local roomData = self.mapData:GetRoomByCoord(k)
      if roomData ~= nil then
        roomData:InitEventAndRecoveryRoomData(v, jumpCat)
      end
    end
  end
  if epGrid.reconstitution ~= nil then
    for k, v in pairs(epGrid.reconstitution) do
      local roomData = self.mapData:GetRoomByCoord(k)
      if roomData ~= nil then
        roomData:InitResetRoomData(v)
      end
    end
  end
  if epGrid.tmpStore ~= nil then
    local tmpStore = epGrid.tmpStore
    local curRoomData = self:GetCurrentRoomData()
    local curPos = curRoomData:GetRoomPosition()
    local x, y = ExplorationManager.Coordination2Pos(curPos)
    local DynEpRoomData = require("Game.Exploration.MapData.DynEpRoomData")
    local type = ExplorationEnum.eRoomType.store
    local roomData = DynEpRoomData.New(x, y, type, curPos, false)
    roomData:InitStoreRoomData(tmpStore)
    self.storeCtrl:OnStoreRoomOpen(roomData)
    self.inTheTempRoom = true
  end
  if epGrid.buffData ~= nil then
    local curRoomData = self:GetCurrentRoomData()
    if curRoomData ~= nil then
      curRoomData:InitEpBuffEffective(epGrid.buffData.data)
    end
  end
  if self.bloodGridMax == nil then
    self:CalculateBloodGrid()
  end
end

function ExplorationController:UpdateResidentDetail(epResident)
  self.residentStoreCtrl:UpdateResidentStore(epResident)
end

function ExplorationController:OpenResidentStore()
  self.residentStoreCtrl:OnResidentStoreRoomOpen()
end

function ExplorationController:IsMapLogic(mapLogic)
  return self.mapData.epMapLogic == mapLogic
end

function ExplorationController:CheckChipSelect(noSelectEvent, toFakeCamera)
  if noSelectEvent ~= nil then
    self.__noChipSelectEvent = noSelectEvent
  end
  if self.dynPlayer:GetOperatorDetailState() ~= proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleALGWaiting then
    if self.__noChipSelectEvent ~= nil then
      self.__noChipSelectEvent()
      self.__noChipSelectEvent = nil
    end
    return false
  end
  local chipList = self:GetCurrentRoomData():GetRewardChipList()
  if #chipList == 0 then
    error("rewardChipList.count == 0")
    return false
  end
  self.selectChipWindow = nil
  if toFakeCamera then
    self.selectChipWindow = UIManager:ShowWindow(UIWindowTypeID.SelectChip, UIWindowTypeID.ThreeDSelectChip)
  else
    self.selectChipWindow = UIManager:ShowWindow(UIWindowTypeID.SelectChip)
  end
  if self.selectChipWindow ~= nil then
    self.selectChipWindow:InitSelectChip(true, chipList, self.dynPlayer, BindCallback(self, self.__SelectChipComplete), BindCallback(self, self.__GiveSelectChipComplect), toFakeCamera, BindCallback(self, self.__ReqReFreshSelectChipAfterBtl))
    self.autoCtrl:OnEpBattleSelectChip()
  end
  self.campFetterCtrl:OnEpSelectChip()
  return true
end

function ExplorationController:__ReqReFreshSelectChipAfterBtl(currencyId, remainRefreshTime, refreshPrice, lockChipIdx)
  if 0 < remainRefreshTime or remainRefreshTime == -1 then
    if refreshPrice <= self.dynPlayer:GetItemCount(currencyId) or refreshPrice <= 0 then
      if lockChipIdx == nil then
        lockChipIdx = table.emptytable
      end
      self.epNetwork:CS_EXPLORATION_BATTLE_RefreshAlg(lockChipIdx, BindCallback(self, self.__UpdaterRefreshChipCountAfterBtlUI))
    else
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Treasure_MoneyInsufficient))
    end
  else
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Treasure_RefreshNumInsufficient))
  end
end

function ExplorationController:__UpdaterRefreshChipCountAfterBtlUI()
  if self.selectChipWindow == nil then
    return
  end
  local chipList = self:GetCurrentRoomData():GetRewardChipList()
  if #chipList == 0 then
    error("rewardChipList.count == 0")
    return false
  end
  self.selectChipWindow:RefreshChipList(chipList, true)
  self.selectChipWindow:OnUpdateRemainRefreshInfo()
end

function ExplorationController:__SelectChipComplete(index, selectComplete)
  index = index - 1
  local position = self:GetCurrentRoomData():GetRoomPosition()
  self.epNetwork:CS_EXPLORATION_BATTLE_ALGSelect(position, index, function(dataList)
    if selectComplete ~= nil then
      selectComplete()
    end
    self:CheckChipSelect()
  end)
end

function ExplorationController:__GiveSelectChipComplect(selectComplete)
  self.epNetwork:CS_EXPLORATION_BATTLE_GiveUpAlg(function()
    if selectComplete ~= nil then
      selectComplete(function()
        self:CheckChipSelect()
      end)
    end
  end)
end

function ExplorationController:DiscardChip()
  local win = UIManager:GetWindow(UIWindowTypeID.EpChipDiscard)
  if win ~= nil and win.active then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpChipDiscard, function(win)
    if win == nil then
      error("can't open EpChipDiscard UI")
      return
    end
    win:InitEpChipDiscard(self.dynPlayer, function()
      self:CheckBossRoom()
    end)
  end)
end

function ExplorationController:OpenSelectDebuffUI()
  local win = UIManager:GetWindow(UIWindowTypeID.EpSelectDebuff)
  if win ~= nil and win.active then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpSelectDebuff, function(win)
    if win == nil then
      error("can't open EpSelectDebuff UI")
      return
    end
    win:InitEpSelectDebuff(self.dynPlayer)
  end)
end

function ExplorationController:GetRoomRoot()
  return self.mapCtrl:GetRoomRoot()
end

function ExplorationController:GetRoomUI(position, index)
  return self.mapCtrl:GetRoomUI(position, index)
end

function ExplorationController:GetCurrentRoomData(withoutSpecialRoom)
  local currentRoom = self.playerCtrl:GetCurrentRoomData(withoutSpecialRoom)
  return currentRoom
end

function ExplorationController:GetCurrentRoomTitle()
  local currentRoom = self.playerCtrl:GetCurrentRoomData()
  local roomType = currentRoom:GetRoomType()
  local roomTypeCfg = ConfigData.exploration_roomtype[roomType]
  if roomTypeCfg == nil then
    error("exploration room type is null,id:" .. tostring(roomType))
    return ""
  end
  return LanguageUtil.GetLocaleText(roomTypeCfg.title)
end

function ExplorationController:ExecuteTempChipCurBattleRoom(chipTemporaryDic)
  local curRoomData = self:GetCurrentRoomData()
  if curRoomData:IsBattleRoom() then
    curRoomData:ExecuteMonsterTempChip(chipTemporaryDic)
  end
end

function ExplorationController:RollbackTempChipCurBattleRoom(chipTemporaryDic)
  local curRoomData = self:GetCurrentRoomData()
  if curRoomData:IsBattleRoom() then
    curRoomData:RollbackMonsterTempChip(chipTemporaryDic)
  end
end

function ExplorationController:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnEpGridDetailDiff, self.__onUpdateNextRoomInfo)
  MsgCenter:RemoveListener(eMsgEventId.OnEpResidentDiff, self.__onEpResidentDiff)
  UIManager:DeleteWindow(UIWindowTypeID.Exploration)
  for k, v in pairs(self.ctrls) do
    v:OnDelete()
  end
  self.ctrls = nil
  self.loadSceneComplete = false
end

function ExplorationController:OpenChipReplace()
  local opDetail = self.dynPlayer:GetOperatorDetail()
  local roomData = self.mapData:GetRoomByCoord(opDetail.curPostion)
  UIManager:ShowWindowAsync(UIWindowTypeID.ChipDisplace, function(window)
    local remainCount = roomData.eventData.replaceChip.remainingReplaceChipTimes
    local isAllDisplace = roomData.eventData.replaceChip.replaceNum == 0
    window:InitChipDisplace(remainCount, isAllDisplace, self)
    self.autoCtrl:OnEnterChipReplace(true)
  end)
end

function ExplorationController:SendChipReplace(id)
  local opDetail = self.dynPlayer:GetOperatorDetail()
  local roomData = self.mapData:GetRoomByCoord(opDetail.curPostion)
  self.epNetwork:CS_EXPLORATION_EVENT_ReplaceAlg(opDetail.curPostion, id, function()
    self:ChipReplaceSuccess()
  end)
end

function ExplorationController:ChipReplaceSuccess()
  local opDetail = self.dynPlayer:GetOperatorDetail()
  local roomData = self.mapData:GetRoomByCoord(opDetail.curPostion)
  local window = UIManager:GetWindow(UIWindowTypeID.ChipDisplace)
  if window ~= nil then
    window:UpdateDiff()
    self.autoCtrl:OnEnterChipReplace(false)
  end
end

function ExplorationController:SendExitChipReplace()
  local opDetail = self.dynPlayer:GetOperatorDetail()
  self.epNetwork:CS_EXPLORATION_EVENT_ReplaceExit(opDetail.curPostion, function()
    self:ExitChipReplaceSuccess()
  end)
end

function ExplorationController:ExitChipReplaceSuccess()
  UIManager:DeleteWindow(UIWindowTypeID.ChipDisplace)
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.EventRoom)
end

function ExplorationController:CalculateBloodGrid()
  local roomList = {}
  local curRoom = self:GetCurrentRoomData(true)
  local nextRoomList = curRoom:GetNextRoom()
  table.insert(roomList, curRoom)
  table.insertto(roomList, nextRoomList)
  local heroDic = self.dynPlayer.heroDic
  local maxHp, minHp
  for id, dyHero in pairs(heroDic) do
    local hp = dyHero:GetRealAttr(eHeroAttr.maxHp)
    maxHp = maxHp == nil and hp or math.max(maxHp, hp)
    minHp = minHp == nil and hp or math.min(minHp, hp)
  end
  for _, epRoom in ipairs(roomList) do
    if epRoom ~= nil and epRoom:IsBattleRoom() then
      local monsterList = epRoom:GetMonsterList()
      for _, monster in ipairs(monsterList) do
        if monster:GetBossBloodNum() == 0 then
          local hp = monster:GetRealAttr(eHeroAttr.maxHp)
          maxHp = maxHp == nil and hp or math.max(maxHp, hp)
          minHp = minHp == nil and hp or math.min(minHp, hp)
        end
      end
    end
  end
  self.unitBlood, self.bossUnitBlood, self.bloodGridMax = BattleUtil.CalculateBloodGrid(maxHp, minHp)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetUnitBlood(self.unitBlood, self.bossUnitBlood)
end

function ExplorationController:SetBloodGrid(unitBlood, bossUnitBlood)
  self.unitBlood = unitBlood
  self.bossUnitBlood = bossUnitBlood
  self.bloodGridMax = ConfigData.game_config.bloodGridMax
end

return ExplorationController
