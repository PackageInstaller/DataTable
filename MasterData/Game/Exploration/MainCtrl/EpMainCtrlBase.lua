local EpMainCtrlBase = class("EpMainCtrlBase")
local ExplorationTreasureCtrl = require("Game.Exploration.Ctrl.ExplorationTreasureCtrl")
local ExplorationStoreCtrl = require("Game.Exploration.Ctrl.ExplorationStoreCtrl")
local ExplorationResidentStoreCtrl = require("Game.Exploration.Ctrl.ExplorationResidentStoreCtrl")
local ExplorationEventCtrl = require("Game.Exploration.Ctrl.ExplorationEventCtrl")
local ExplorationResetRoomCtrl = require("Game.Exploration.Ctrl.ExplorationResetRoomCtrl")
local ExplorationAutoCtrl = require("Game.Exploration.Ctrl.ExplorationAutoCtrl")
local ExplorationCampFetterCtrl = require("Game.Exploration.Ctrl.ExplorationCampFetterCtrl")
local ExplorationSupportCtrl = require("Game.Exploration.Ctrl.ExplorationSupportCtrl")
local ExplorationOverclockCtrl = require("Game.Exploration.Ctrl.ExplorationOverclockCtrl")
local ExplorationExRoomCtrl = require("Game.Exploration.Ctrl.ExplorationExRoomCtrl")
local DynBuff = require("Game.Exploration.Data.DynBuff")
local cs_MessageCommon = CS.MessageCommon
local cs_Canvas = CS.UnityEngine.Canvas
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local ePlayerState = {
  InTheRoom = 1,
  OutsideTheRoom = 2,
  SelectingChip = 3,
  HalfOver = 4,
  DropChip = 5,
  BattleFailure = 6,
  ReplaceChip = 7,
  MonsterLvUpgrade = 8,
  EpTask = 9,
  EpBuffSelect = 10
}
EpMainCtrlBase.ePlayerState = ePlayerState

function EpMainCtrlBase:ctor(mapData, dynPlayer)
  self.ctrls = {}
  self.mapData = mapData
  self.dynPlayer = dynPlayer
  self:__RegisterRoomTypeLogic()
  self:InitEpMainSubCtrls()
  self.loadSceneComplete = false
  self.epNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.itemRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.ItemRoom)
  self.storeRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.StoreRoom)
  self.eventRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.EventRoom)
  self.resetRoomNetwork = NetworkManager:GetNetwork(NetworkTypeID.ResetRoom)
  self.__onMapDataUpdate = BindCallback(self, self.OnMapDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnEpMapDiff, self.__onMapDataUpdate)
  self.__onUpdateNextRoomInfo = BindCallback(self, self.UpdateNextRoomInfo)
  MsgCenter:AddListener(eMsgEventId.OnEpGridDetailDiff, self.__onUpdateNextRoomInfo)
  self.__onEpResidentDiff = BindCallback(self, self.UpdateResidentDetail)
  MsgCenter:AddListener(eMsgEventId.OnEpResidentDiff, self.__onEpResidentDiff)
  self.__onEnterEpSceneCompleteAction = BindCallback(self, self.__OnEnterEpSceneComplete)
  self.__operationProcessBind = BindCallback(self, self.__OperationProcess)
end

function EpMainCtrlBase:InitEpMainSubCtrls()
  self.treasureCtrl = ExplorationTreasureCtrl.New(self)
  self.storeCtrl = ExplorationStoreCtrl.New(self)
  self.eventCtrl = ExplorationEventCtrl.New(self)
  self.resetRoomCtrl = ExplorationResetRoomCtrl.New(self)
  self.residentStoreCtrl = ExplorationResidentStoreCtrl.New(self)
  self.autoCtrl = ExplorationAutoCtrl.New(self)
  self.campFetterCtrl = ExplorationCampFetterCtrl.New(self)
  self.epSupportCtrl = ExplorationSupportCtrl.New(self)
  self.overclockCtrl = ExplorationOverclockCtrl.New(self)
  self.exRoomCtrl = ExplorationExRoomCtrl.New(self)
end

function EpMainCtrlBase:RecordLastSelectChoiceCtrl(roomCtrl)
  self.__lastSelectChoiceCtrl = roomCtrl
end

function EpMainCtrlBase:GetLastSelectChoiceCtrl()
  return self.__lastSelectChoiceCtrl
end

function EpMainCtrlBase:Start(isReconnect, isFirstEnter)
  self.__isReconnect = isReconnect
  self.__isFirstEnter = isFirstEnter
  if self.__isReconnect then
    self.__isFirstFloor = false
  else
    self.__isFirstFloor = true
  end
  local opDetail = self.dynPlayer:GetOperatorDetail()
  local opState = opDetail.state
  if opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_Secleted or proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleALGWaiting or proto_object_ExplorationCurGridState.ExplorationCurGridState_DropAlg or proto_object_ExplorationCurGridState.ExplorationCurGridStateReplaceChip then
    self.dynPlayer.playerClientState = ExplorationEnum.ePlayerClientState.InRoom
  else
    self.dynPlayer.playerClientState = ExplorationEnum.ePlayerClientState.OutSideRoom
  end
  self.sceneCtrl:FirstEnterScene(BindCallback(self, self.OnSceneLoadComplete), BindCallback(self, self.OnStartTimelineComplete))
end

function EpMainCtrlBase:IsFirstEnterNewFloor()
  return self.__isFirstFloor
end

function EpMainCtrlBase:SetEpAfterEnterSceneExit()
  self._afterEnterSceneExit = true
end

function EpMainCtrlBase:GetEpAfterEnterSceneExit()
  return self._afterEnterSceneExit
end

function EpMainCtrlBase:OnSceneLoadComplete()
  self.loadSceneComplete = true
  ExplorationManager:PlayEpAuBgm()
  ExplorationManager:PlayEpAuSelctNormalCombat()
  local epWindow = UIManager:ShowWindow(UIWindowTypeID.Exploration)
  epWindow:ShowExplorationFirst(self.dynPlayer)
  epWindow:Hide()
  local epWindow = UIManager:ShowWindow(UIWindowTypeID.DungeonStateInfo)
  epWindow:InitHeroAndChip(self.dynPlayer)
  epWindow:Hide()
  local unlockChipSuit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TagSuit)
  if unlockChipSuit then
    local epSuitWindow = UIManager:ShowWindow(UIWindowTypeID.EpChipSuit)
    epSuitWindow:InitEpChipSuit(self.dynPlayer)
    epSuitWindow:RefreshChipSuitSimpleUI()
    epSuitWindow:Hide()
    self.__onChipSuitUpdate = BindCallback(self, self.RefreshChipSuitItemPreview)
    MsgCenter:AddListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
  end
  self:__InitRoomCanvasEventCamera()
  local curRoomData = self:GetCurrentRoomData()
  MsgCenter:Broadcast(eMsgEventId.OnEpPlayerMoveComplete, curRoomData)
  GuideManager:TryTriggerGuide(eGuideCondition.InExploration)
end

function EpMainCtrlBase:__InitRoomCanvasEventCamera()
  if self.mapCtrl ~= nil and self.mapCtrl.bind ~= nil and not IsNull(self.mapCtrl.bind.roomCanvas) then
    local roomCanvas = self.mapCtrl.bind.roomCanvas.gameObject:GetComponent(typeof(cs_Canvas))
    local epMapCamera = self.sceneCtrl.epSceneEntity:GetEpMapCamera()
    if roomCanvas.worldCamera ~= epMapCamera then
      roomCanvas.worldCamera = epMapCamera
    end
  end
end

function EpMainCtrlBase:OnStartTimelineComplete()
  self.autoCtrl:OnExplorationStart()
  self:ContinueExploration()
end

function EpMainCtrlBase:ContinueExploration(isRevive)
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
    self:__EnterExplorationScene(ePlayerState.MonsterLvUpgrade)
  elseif opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_HalfOver then
    self:__EnterExplorationScene(ePlayerState.HalfOver)
  elseif opState == proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleFailure then
    self:__EnterExplorationScene(ePlayerState.BattleFailure)
  elseif opState == proto_object_ExplorationCurGridState.ExplorationCurGridStateReplaceChip then
    self:__EnterExplorationScene(ePlayerState.ReplaceChip)
  elseif opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_QuestSelect then
    self:__EnterExplorationScene(ePlayerState.EpTask)
  elseif opState == proto_object_ExplorationCurGridState.ExplorationCurGridState_OpeningBuffSelect then
    self:__EnterExplorationScene(ePlayerState.EpBuffSelect)
  else
    error("Unsupported opState : " .. tostring(opState))
  end
  self.campFetterCtrl:__OnEpOpStateChanged(nil, opState)
  self.__isReconnect = false
  self.__isFirstEnter = false
end

function EpMainCtrlBase:__EnterExplorationScene(state)
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

function EpMainCtrlBase:__OnEnterEpSceneComplete()
end

function EpMainCtrlBase:__TryShowOperationBeforeEpSceneComplete()
  if not self.__isFirstEnter then
    if not self:_TryShowFloorStartRandomBuff() then
      self:__OnEnterEpScene()
    end
    return
  end
  self:__TryShowEpBuffDescBeforeEpSceneComplete()
end

function EpMainCtrlBase:__TryShowEpBuffDescBeforeEpSceneComplete()
  if self.autoCtrl:IsAutoModeRunning() then
    self:__TryShowStoreBeforeEpSceneComplete()
    return
  end
  local hasBuff = #self.dynPlayer:GetEpBuffList() > 0
  if not hasBuff then
    self:__TryShowStoreBeforeEpSceneComplete()
    return
  end
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local oriBuffList = dynPlayer:GetEpBuffList()
  if oriBuffList == nil then
    self:__TryShowStoreBeforeEpSceneComplete()
    return
  end
  local buffList = {}
  for index, epBuff in ipairs(oriBuffList) do
    if epBuff:IsBuffNeedShowOnBuffList() then
      table.insert(buffList, epBuff)
    end
  end
  if #buffList <= 0 then
    self:__TryShowStoreBeforeEpSceneComplete()
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(win)
    win:InitEpBuffDesc(buffList, function()
      self:__TryShowStoreBeforeEpSceneComplete()
    end)
  end)
end

function EpMainCtrlBase:_TryShowFloorStartRandomBuff()
  if not self.__isFirstFloor or self.__isFirstEnter then
    return false
  end
  if self.autoCtrl:IsAutoModeRunning() then
    return false
  end
  local epBuff = self.dynPlayer:GetFloorStartRandomBuff()
  if epBuff == nil then
    return false
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(win)
    win:InitEpFloorBuffShow(epBuff, function()
      self:__OnEnterEpScene()
    end)
  end)
  return true
end

function EpMainCtrlBase:TryShowBuffSelect()
  local ok, epBuffList, unlockBuffIdDic = self.dynPlayer:TryGetNewEpBuffSelect()
  if ok then
    UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(win)
      win:InitEpBuffSelect(epBuffList, unlockBuffIdDic)
    end)
  end
end

function EpMainCtrlBase:__TryShowStoreBeforeEpSceneComplete()
  if not self.residentStoreCtrl:HasEpResidentStore() or ExplorationManager:IsInTDExp() then
    self:__OnEnterEpScene()
    return
  end
  self.residentStoreCtrl:CheckEpResidentStore(function()
    self:__OnEnterEpScene()
  end)
end

function EpMainCtrlBase:__OnEnterEpScene()
  if not self:CheckActiveChipDrop(self.__operationProcessBind) then
    self.__operationProcessBind()
  end
end

function EpMainCtrlBase:__OperationProcess()
  if self.__playerState == ePlayerState.InTheRoom then
    local currentRoom = self:GetCurrentRoomData()
    self:OnPlayerMoveComplete(currentRoom)
  elseif self.__playerState == ePlayerState.OutsideTheRoom then
    self:OutsideTheRoom()
    self.__isFirstEnter = false
    self.__isFirstFloor = false
  elseif self.__playerState == ePlayerState.SelectingChip then
    self.__ContinueSelectChipCompleteFunc = self.__ContinueSelectChipCompleteFunc or BindCallback(self, self.__ContinueSelectChipComplete)
    self:CheckChipSelect(self.__ContinueSelectChipCompleteFunc)
  elseif self.__playerState == ePlayerState.DropChip then
    self:DiscardChip()
    self.__isFirstEnter = false
    self.__isFirstFloor = false
  elseif self.__playerState == ePlayerState.BattleFailure then
    self:ExplorationFailSettle()
  elseif self.__playerState == ePlayerState.HalfOver then
    warn("未实现该功能：中场结束,自动选下一个房间")
  elseif self.__playerState == ePlayerState.ReplaceChip then
    self:OpenChipReplace()
  elseif self.__playerState == ePlayerState.MonsterLvUpgrade then
    self:OpenSelectDebuffUI()
  elseif self.__playerState == ePlayerState.EpTask then
    self:OpenEpTask()
  elseif self.__playerState == ePlayerState.EpBuffSelect then
    self:TryShowBuffSelect()
  end
end

function EpMainCtrlBase:__ContinueSelectChipComplete()
  local opState = self.dynPlayer:GetOperatorDetailState()
  if opState ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_DropAlg and opState ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Secleted then
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.OutsideSelectChip)
  end
end

function EpMainCtrlBase:CheckBossRoom(nextAction)
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
      cs_MessageCommon.ShowMessageBoxConfirm(string.format(ConfigData:GetTipContent(905), bossMonsterName), nextAction)
    elseif self.mapData:HasOverBossRoom() then
      if self.autoCtrl:IsAutoModeRunning() or self.__isRevive then
        self.autoCtrl:DisableEpAutoMode()
      end
      local stageId = ExplorationManager:GetSectorStageCfg().id
      local curFloor = ExplorationManager:GetCurLevelIndex() + 1
      ControllerManager:GetController(ControllerTypeId.AvgPlay, true):TryPlayAvg(eAvgTriggerType.MainAvgEp, stageId, curFloor, 3, function()
        UIManager:ShowWindowAsync(UIWindowTypeID.MessageBox, function(win)
          if win == nil then
            return
          end
          win:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(255), function()
            AudioManager:PlayAudioById(1125)
            if nextAction ~= nil then
              nextAction()
            end
          end, function()
            AudioManager:PlayAudioById(1125)
            self:StartCompleteExploration()
          end)
        end)
      end)
    else
      self:StartCompleteExploration()
    end
  elseif currentRoom:IsEndColRoom() then
    self:StartCompleteExploration()
  elseif nextAction ~= nil then
    nextAction()
  end
end

function EpMainCtrlBase:IsCompleteExploration()
  if self.dynPlayer:GetOperatorDetail().canFloorOver and not ExplorationManager:HasNextLevel() then
    return true
  end
  return false
end

function EpMainCtrlBase:StartCompleteExploration(endAction)
  if ExplorationManager:HasNextLevel() then
    self:__CompleteExplorationFloor(endAction)
  else
    self:__CompleteExploration(endAction)
  end
end

function EpMainCtrlBase:__CompleteExplorationFloor(endAction)
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
    UIManager:HideWindow(UIWindowTypeID.EpChipSuit)
    if endAction ~= nil then
      endAction()
    end
  end)
end

function EpMainCtrlBase:ExplorationFailSettle(clearAction)
  ExplorationManager.resultCtrl:EnterResultProcess(false, true, clearAction)
end

function EpMainCtrlBase:__CompleteExploration(endAction)
  CS.BattleManager.Instance:ForceExitBattle()
  Time.unity_time.timeScale = 1
  ExplorationManager.resultCtrl:EnterResultProcess(true, true, endAction)
end

function EpMainCtrlBase:__EnterBattleScene(roomData, isReconnect)
  if isGameDev then
    print("[Dev]battleId:", roomData.battleId)
  end
  self:RollbackTempChipCurBattleRoom(self.dynPlayer:GetEpBuffChipDic())
  self:ExecuteTempChipCurBattleRoom(self.dynPlayer:GetEpBuffChipDic())
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
  roomData.battleMap:SetPlayerRoleBattleMaxCount(self.dynPlayer:GetEnterFiledNum())
end

function EpMainCtrlBase:EnterDeployRoom()
  local epState = self.dynPlayer:GetOperatorDetailState()
  if epState ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    return
  end
  local deployRoomData = self.mapData:GetDeployRoom()
  self:__EnterBattleScene(deployRoomData)
end

function EpMainCtrlBase:GenExplorationMap()
end

function EpMainCtrlBase:OnPlayerMoveStart(roomData)
  self:OnPlayerMoveComplete(roomData)
end

function EpMainCtrlBase:__RegisterRoomTypeLogic()
  self.__roomLogicFunc = {
    [ExplorationEnum.eRoomLogicType.battle] = function(roomData)
      self:__EnterBattleScene(roomData)
    end,
    [ExplorationEnum.eRoomLogicType.chip] = function(roomData)
      self.resetRoomCtrl:OnResetRoomOpen(roomData)
    end,
    [ExplorationEnum.eRoomLogicType.store] = function(roomData)
      self.storeCtrl:OnStoreRoomOpen(roomData, true)
    end,
    [ExplorationEnum.eRoomLogicType.treasure] = function(roomData)
      self.treasureCtrl:OnTreasureRoomOpen(roomData, true)
    end,
    [ExplorationEnum.eRoomLogicType.event] = function(roomData)
      self.eventCtrl:OnEventRoomOpen(roomData, true)
    end,
    [ExplorationEnum.eRoomLogicType.excustom] = function(roomData)
      self.exRoomCtrl:OnEpExRoomOpen(roomData, true)
    end
  }
end

function EpMainCtrlBase:OnPlayerMoveComplete(roomData)
  local roomLogicType = roomData:GetRoomLogicType()
  if roomLogicType == nil then
    error("Unsupported room logicType : " .. tostring(roomLogicType))
  else
    local roomLogicFunc = self.__roomLogicFunc[roomLogicType]
    if roomLogicFunc ~= nil then
      roomLogicFunc(roomData)
    else
      error("Unsupported room logicType : " .. tostring(roomLogicType))
    end
  end
  self.dynPlayer.playerClientState = ExplorationEnum.ePlayerClientState.InRoom
  MsgCenter:Broadcast(eMsgEventId.OnEpPlayerMoveComplete, roomData)
  roomData:ResetJumpCat()
end

function EpMainCtrlBase:OutsideTheRoom()
  if self.__isReconnect or self.__isFirstFloor then
    self:CheckAfterOutSide()
    self.playerCtrl:TryShowEpTalkDialog()
    return true
  end
  return false
end

function EpMainCtrlBase:CheckAfterOutSide()
  if self.chacheWillChangeRoleSync ~= nil then
    self.epSupportCtrl:ChangeEpHero(self.chacheWillChangeRoleSync)
    self:ClearChacheWillChangeHero()
  end
  local actionList = ExplorationManager:GetEpGuideActionList(self:GetCurrentRoomData().x, ExplorationEnum.epGuideMomentType.InEpOutsideRoom)
  if actionList ~= nil and 0 < #actionList then
    local EpGuideUtil = require("Game.Exploration.Util.EpGuideUtil")
    EpGuideUtil.ExecuteEpGuideActions(actionList)
  end
end

function EpMainCtrlBase:OnExitEpRoomBegin()
  local curRoomData = self:GetCurrentRoomData(true)
  if curRoomData:IsEndColRoom() then
    self.dynPlayer.playerClientState = ExplorationEnum.ePlayerClientState.OutSideRoom
    return
  end
  self:OnExitEpRoomEnd(curRoomData)
end

function EpMainCtrlBase:OnExitEpRoomEnd(curRoomData)
  self.dynPlayer.playerClientState = ExplorationEnum.ePlayerClientState.OutSideRoom
  if curRoomData:IsCrossRoom() and not self.autoCtrl:IsAutoModeRunning() then
    GuideManager:TryTriggerGuide(eGuideCondition.AfterEpCrossRoom)
  end
end

function EpMainCtrlBase:UpdateNextRoomInfo(epGrid, epOp)
  if epGrid.monster ~= nil then
    for k, v in pairs(epGrid.monster) do
      local roomData = self.mapData:GetRoomByCoord(k)
      if roomData ~= nil and roomData:IsBattleRoom(epOp) then
        roomData:InitBattleData(v)
        roomData:ExecuteMonsterChip(self.dynPlayer)
        if roomData:IsGuardTDBattle() then
          roomData:ExecuteDungeonRoleChip(self.dynPlayer)
        end
        if self.mapCtrl ~= nil then
          self.mapCtrl:ShowFightingPower(roomData, self.dynPlayer:GetCacheFightPower())
        end
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
  for k, v in pairs(epGrid.exRoom) do
    local roomData = self.mapData:GetRoomByCoord(k)
    if roomData ~= nil then
      roomData:InitEpExRoomData(v)
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

function EpMainCtrlBase:CalculateBloodGrid()
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

function EpMainCtrlBase:SetBloodGrid(unitBlood, bossUnitBlood)
  self.unitBlood = unitBlood
  self.bossUnitBlood = bossUnitBlood
  self.bloodGridMax = ConfigData.game_config.bloodGridMax
end

function EpMainCtrlBase:UpdateResidentDetail(epResident)
  self.residentStoreCtrl:UpdateResidentStore(epResident)
end

function EpMainCtrlBase:OpenResidentStore(closeCallback)
  self.residentStoreCtrl:OnResidentStoreRoomOpen(closeCallback)
end

function EpMainCtrlBase:IsMapLogic(mapLogic)
  return self.mapData.epMapLogic == mapLogic
end

function EpMainCtrlBase:CheckActiveChipDrop(continueFunc)
  if self.__isReconnect or self.__isFirstEnter then
    return false
  end
  local tempActiveAlg = self.dynPlayer:GetDropActiveAlg()
  if tempActiveAlg == nil then
    return false
  end
  self.dynPlayer:ClearDropActiveAlg()
  local chipData = self.dynPlayer:GetNormalChipDic()[tempActiveAlg >> 4]
  if chipData == nil then
    return false
  end
  local chipDataList = {}
  table.insert(chipDataList, chipData)
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonInfoDetail, function(window)
    window:ShowChipDetail(chipDataList, 1, function()
      continueFunc()
    end, nil, true)
    self.autoCtrl:OnEnterActiveChipDrop(function()
      window:OnClickRetreat()
    end)
    window:SetSwitchBtnActive(false)
  end)
  return true
end

function EpMainCtrlBase:CheckChipSelect(noSelectEvent, toFakeCamera)
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
    self.autoCtrl:OnEpBattleSelectChip(chipList)
  end
  self.campFetterCtrl:OnEpSelectChip()
  return true
end

function EpMainCtrlBase:__ReqReFreshSelectChipAfterBtl(currencyId, remainRefreshTime, refreshPrice, lockChipIdx)
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

function EpMainCtrlBase:__UpdaterRefreshChipCountAfterBtlUI()
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

function EpMainCtrlBase:__SelectChipComplete(index, selectComplete)
  index = index - 1
  local position = self:GetCurrentRoomData():GetRoomPosition()
  self.epNetwork:CS_EXPLORATION_BATTLE_ALGSelect(position, index, function(dataList)
    if selectComplete ~= nil then
      selectComplete()
    end
    self:CheckChipSelect()
  end)
end

function EpMainCtrlBase:__GiveSelectChipComplect(selectComplete)
  self.epNetwork:CS_EXPLORATION_BATTLE_GiveUpAlg(function()
    if selectComplete ~= nil then
      selectComplete(function()
        self:CheckChipSelect()
      end)
    end
  end)
end

function EpMainCtrlBase:CheckBuffDrop(continueFunc)
  if self.__isReconnect or self.__isFirstEnter then
    return false
  end
  local tempBuffs = self.dynPlayer:GetDropBuffs()
  if tempBuffs == nil or table.count(tempBuffs) < 1 then
    return false
  end
  local buffList = {}
  for k, id in pairs(tempBuffs) do
    local epBuffData = DynBuff.CreateByEpBuffId(id)
    table.insert(buffList, epBuffData)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(win)
    win:InitDropBuffDesc(buffList, function()
      continueFunc()
    end)
  end)
  self.dynPlayer:ClearDropBuffs()
  return true
end

function EpMainCtrlBase:DiscardChip()
  local win = UIManager:GetWindow(UIWindowTypeID.EpChipDiscard)
  if win ~= nil and win.active then
    return
  end
  self._isInDiscardChip = true
  UIManager:ShowWindowAsync(UIWindowTypeID.EpChipDiscard, function(win)
    if win == nil then
      error("can't open EpChipDiscard UI")
      return
    end
    win:InitEpChipDiscard(self.dynPlayer, function()
      self._isInDiscardChip = false
      if self._nextDiscardChipFunc ~= nil then
        self._nextDiscardChipFunc()
        self._nextDiscardChipFunc = nil
      end
    end)
  end)
end

function EpMainCtrlBase:IsInDiscardChip()
  return self._isInDiscardChip
end

function EpMainCtrlBase:SetNextDiscardChipFunc(func)
  self._nextDiscardChipFunc = func
end

function EpMainCtrlBase:OpenSelectDebuffUI()
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

function EpMainCtrlBase:GetCurrentRoomData(withoutSpecialRoom)
  local currentRoom = self.playerCtrl:GetCurrentRoomData(withoutSpecialRoom)
  return currentRoom
end

function EpMainCtrlBase:GetCurrentRoomTitle()
  local currentRoom = self.playerCtrl:GetCurrentRoomData()
  local roomType = currentRoom:GetRoomType()
  local roomTypeCfg = ConfigData.exploration_roomtype[roomType]
  if roomTypeCfg == nil then
    error("exploration room type is null,id:" .. tostring(roomType))
    return ""
  end
  return LanguageUtil.GetLocaleText(roomTypeCfg.title)
end

function EpMainCtrlBase:ExecuteNormalChipBattleRoom()
  local nextRooms = self:GetCurrentRoomData(true):GetNextRoom()
  for k, roomData in pairs(nextRooms) do
    if roomData:IsBattleRoom() then
      roomData:ExecutePlayerChipForMonster(self.dynPlayer)
    end
  end
  local curRoomData = self:GetCurrentRoomData(true)
  if curRoomData:IsBattleRoom() then
    curRoomData:ExecutePlayerChipForMonster(self.dynPlayer)
  end
end

function EpMainCtrlBase:RollbackNormalChipBattleRoom()
  local nextRooms = self:GetCurrentRoomData(true):GetNextRoom()
  for k, roomData in pairs(nextRooms) do
    if roomData:IsBattleRoom() then
      roomData:RollbackPlayerChipForMonster(self.dynPlayer)
    end
  end
  local curRoomData = self:GetCurrentRoomData(true)
  if curRoomData:IsBattleRoom() then
    curRoomData:RollbackPlayerChipForMonster(self.dynPlayer)
  end
end

function EpMainCtrlBase:ExecuteTempChipCurBattleRoom(chipTemporaryDic)
  local curRoomData = self:GetCurrentRoomData()
  if curRoomData:IsBattleRoom() then
    curRoomData:ExecuteMonsterTempChip(chipTemporaryDic)
  end
end

function EpMainCtrlBase:RollbackTempChipCurBattleRoom(chipTemporaryDic)
  local curRoomData = self:GetCurrentRoomData()
  if curRoomData:IsBattleRoom() then
    curRoomData:RollbackMonsterTempChip(chipTemporaryDic)
  end
end

function EpMainCtrlBase:OpenChipReplace()
  local opDetail = self.dynPlayer:GetOperatorDetail()
  local roomData = self.mapData:GetRoomByCoord(opDetail.curPostion)
  UIManager:ShowWindowAsync(UIWindowTypeID.ChipDisplace, function(window)
    local remainCount = roomData.eventData.replaceChip.remainingReplaceChipTimes
    local isAllDisplace = roomData.eventData.replaceChip.replaceNum == 0
    window:InitChipDisplace(remainCount, isAllDisplace, self)
    self.autoCtrl:OnEnterChipReplace(true)
  end)
end

function EpMainCtrlBase:SendChipReplace(id)
  local opDetail = self.dynPlayer:GetOperatorDetail()
  local roomData = self.mapData:GetRoomByCoord(opDetail.curPostion)
  self.epNetwork:CS_EXPLORATION_EVENT_ReplaceAlg(opDetail.curPostion, id, function()
    self:ChipReplaceSuccess()
  end)
end

function EpMainCtrlBase:ChipReplaceSuccess()
  local opDetail = self.dynPlayer:GetOperatorDetail()
  local roomData = self.mapData:GetRoomByCoord(opDetail.curPostion)
  local window = UIManager:GetWindow(UIWindowTypeID.ChipDisplace)
  if window ~= nil then
    window:UpdateDiff()
    self.autoCtrl:OnEnterChipReplace(false)
  end
end

function EpMainCtrlBase:SendExitChipReplace()
  local opDetail = self.dynPlayer:GetOperatorDetail()
  self.epNetwork:CS_EXPLORATION_EVENT_ReplaceExit(opDetail.curPostion, function()
    self:ExitChipReplaceSuccess()
  end)
end

function EpMainCtrlBase:ExitChipReplaceSuccess()
  UIManager:DeleteWindow(UIWindowTypeID.ChipDisplace)
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.EventRoom)
end

function EpMainCtrlBase:ChacheWillChangeHero(roleSync)
  self.chacheWillChangeRoleSync = roleSync
end

function EpMainCtrlBase:ClearChacheWillChangeHero()
  self.chacheWillChangeRoleSync = nil
end

function EpMainCtrlBase:OpenEpTask()
  UIManager:ShowWindowAsync(UIWindowTypeID.EpTask, function(win)
    win:InitEpTask(self, self.dynPlayer:GetQuestChioceDic())
    self.autoCtrl:OnEnterTaskSelect(true)
  end)
end

function EpMainCtrlBase:SendGetTask(id)
  self.epNetwork:CS_EXPLORATION_QuestSelect(id, function()
    self:ExitTaskSuccess()
  end)
end

function EpMainCtrlBase:SendGiveUpTask()
  self.epNetwork:CS_EXPLORATION_QuestExit(function()
    self:ExitTaskSuccess()
    for id, count in pairs(ConfigData.game_config.epTaskGiveUpReward) do
      local itemCfg = ConfigData.item[id]
      if itemCfg ~= nil then
        CS.MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(119), LanguageUtil.GetLocaleText(itemCfg.name), tostring(count)))
      end
      break
    end
  end)
end

function EpMainCtrlBase:ExitTaskSuccess()
  UIManager:DeleteWindow(UIWindowTypeID.EpTask)
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.TaskSelect)
end

function EpMainCtrlBase:OnMapDataUpdate(epMap)
  if epMap.step ~= nil then
    self.mapData:UpdateTotalStep(epMap.step)
  end
  if epMap.reCardGradeUp ~= nil then
    self.mapData:UpdateReCardGradeUp(epMap.reCardGradeUp)
  end
  if epMap.reCardGradeDown ~= nil then
    self.mapData:UpdateReCardGradeDown(epMap.reCardGradeDown)
  end
end

function EpMainCtrlBase:RefreshChipSuitItemPreview()
  local win = UIManager:GetWindow(UIWindowTypeID.EpChipSuit)
  win:RefreshChipSuitSimpleUI()
end

function EpMainCtrlBase:GetSupportAutoEpType()
  return ExplorationEnum.eAutoEpSwitchType.None
end

function EpMainCtrlBase:IsEpAutoSelectRoom()
  return false
end

function EpMainCtrlBase:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnEpGridDetailDiff, self.__onUpdateNextRoomInfo)
  MsgCenter:RemoveListener(eMsgEventId.OnEpResidentDiff, self.__onEpResidentDiff)
  for k, v in pairs(self.ctrls) do
    v:OnDelete()
  end
  self.ctrls = nil
  self.loadSceneComplete = false
  if self.__onChipSuitUpdate ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
    self.__onChipSuitUpdate = nil
  end
end

return EpMainCtrlBase
