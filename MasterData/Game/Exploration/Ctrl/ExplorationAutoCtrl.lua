local ExplorationAutoCtrl = class("ExplorationAutoCtrl", ExplorationCtrlBase)
local base = ExplorationCtrlBase
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local EpAutoUtil = require("Game.Exploration.Util.EpAutoUtil")

function ExplorationAutoCtrl:ctor(epCtrl)
  self.__enableAutoMode = false
  self.__autoModeRunning = false
  self.__autoTime = 0
  self.__isBreakAutoMode = false
  self.__defaultAutoMode = false
  self.__onEpOpStateChanged = BindCallback(self, self.OnEpOpStateChanged)
  self.__onEpSceneStateChanged = BindCallback(self, self.OnEpSceneStateChanged)
  MsgCenter:AddListener(eMsgEventId.OnEpSceneStateChanged, self.__onEpSceneStateChanged)
  self.__onEpBattleReady = BindCallback(self, self.OnEpBattleReady)
  MsgCenter:AddListener(eMsgEventId.OnBattleReady, self.__onEpBattleReady)
  self.__onEpExitRoomComplete = BindCallback(self, self.OnEpExitRoomComplete)
  MsgCenter:AddListener(eMsgEventId.OnExitRoomComplete, self.__onEpExitRoomComplete)
  self.__onEnterEpChipDiscard = BindCallback(self, self.OnEnterEpChipDiscard)
  MsgCenter:AddListener(eMsgEventId.OnChipDiscardChanged, self.__onEnterEpChipDiscard)
  self.__DisableEpAutoMode = BindCallback(self, self.DisableEpAutoMode)
end

function ExplorationAutoCtrl:IsEnableAutoMode()
  return self.__enableAutoMode
end

function ExplorationAutoCtrl:IsAutoModeRunning()
  return self.__autoModeRunning
end

function ExplorationAutoCtrl:SetDefaultAutoEp(active)
  self.__defaultAutoMode = active
end

function ExplorationAutoCtrl:IsDefaultAutoEp()
  return self.__defaultAutoMode
end

function ExplorationAutoCtrl:GetEpAutoPath()
  return self.__autoPath
end

function ExplorationAutoCtrl:_AbleToSwitchOpenAuto()
  local supportAutoType = ExplorationManager.epCtrl:GetSupportAutoEpType()
  local state = ExplorationManager:GetDynPlayer():GetOperatorDetail().state
  if supportAutoType == ExplorationEnum.eAutoEpSwitchType.EpWindow then
    if state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
      return false
    end
  elseif supportAutoType == ExplorationEnum.eAutoEpSwitchType.Battle then
    if state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
      return true
    elseif state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Secleted then
      local roomData = ExplorationManager.epCtrl:GetCurrentRoomData()
      if roomData == nil or not roomData:IsBattleRoom() then
        return false
      end
    end
  else
    return false
  end
  return true
end

function ExplorationAutoCtrl:EnableEpAutoMode()
  self.epCtrl.campFetterCtrl:SetAllActiveFetterVisible(false)
  if not self:_AbleToSwitchOpenAuto() then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(299))
    return
  end
  if self:IsDefaultAutoEp() then
    self:__RealEnableEpAutoMode(true)
    return
  end
  local originFightPower = ExplorationManager:GetDynPlayer():GetMirrorTeamFightPower(true, false)
  local recommendPower = ExplorationManager:GetSectorStageCfg().combat
  if originFightPower < recommendPower then
    CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(280), ConfigData:GetTipContent(281), ConfigData:GetTipContent(282), function()
      self:__RealEnableEpAutoMode()
    end, nil)
  else
    self:__RealEnableEpAutoMode()
  end
end

function ExplorationAutoCtrl:__RealEnableEpAutoMode(isRunning)
  self.__enableAutoMode = true
  self:CalcAutoEpPath()
  if self.epCtrl.mapCtrl ~= nil then
    local curRoomData = self.epCtrl:GetCurrentRoomData(true)
    self.epCtrl.mapCtrl:RefreshMapShowState(ExplorationManager:GetDynPlayer():GetOperatorDetail(), curRoomData)
  end
  MsgCenter:Broadcast(eMsgEventId.OnRefreshAutoModeState, true, isRunning)
end

function ExplorationAutoCtrl:DisableEpAutoMode()
  if not self:IsEnableAutoMode() and not self:IsAutoModeRunning() then
    return
  end
  self.epCtrl.campFetterCtrl:SetAllActiveFetterVisible(true)
  self:__ClearAutoData()
  if self.epCtrl.mapCtrl ~= nil then
    local curRoomData = self.epCtrl:GetCurrentRoomData(true)
    self.epCtrl.mapCtrl:RefreshMapShowState(ExplorationManager:GetDynPlayer():GetOperatorDetail(), curRoomData)
  end
  MsgCenter:Broadcast(eMsgEventId.OnRefreshAutoModeState, false)
end

function ExplorationAutoCtrl:CloseAutoMode()
  if not self:IsAutoModeRunning() then
    return
  end
  self:__ClearAutoData()
end

function ExplorationAutoCtrl:__ClearAutoData()
  self.__enableAutoMode = false
  self.__autoModeRunning = false
  self.__waitSelectRoom = nil
  self.__autoTime = 0
  self.__isBreakAutoMode = false
  self.__defaultAutoMode = false
  TimerManager:StopTimer(self.__autoWaitTimerId)
  UIManager:DeleteWindow(UIWindowTypeID.EpAutoMode)
  self.epAutoWindow = nil
  MsgCenter:Broadcast(eMsgEventId.OnRefreshAutoModeState, false)
end

function ExplorationAutoCtrl:OnExplorationStart()
  if not self:IsDefaultAutoEp() then
    return
  end
  if self:IsEnableAutoMode() then
    return
  end
  self:__RealEnableEpAutoMode(true)
  self:StartOrStopEpAutoMode()
end

function ExplorationAutoCtrl:StartOrStopEpAutoMode()
  if not self:IsEnableAutoMode() then
    return false, false
  end
  if self:IsAutoModeRunning() then
    self:DisableEpAutoMode()
    return false, false
  end
  local aliveRoleCount = ExplorationManager:GetDynPlayer():GetDeployAliveHeroCount()
  if aliveRoleCount <= 0 then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(284))
    return true, false
  end
  self.__autoModeRunning = true
  self.epAutoWindow = UIManager:ShowWindow(UIWindowTypeID.EpAutoMode)
  self.epAutoWindow:SetAutoMaskClickFunc(self.__DisableEpAutoMode)
  local opDetail = ExplorationManager:GetDynPlayer():GetOperatorDetail()
  if opDetail.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    self:OnEpOpStateChanged(opDetail)
  elseif opDetail.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Secleted then
    local curRoomData = self.epCtrl:GetCurrentRoomData()
    if curRoomData:IsBattleRoom() and self.epCtrl.battleCtrl:ReadyEnterBattleRunning() then
      self:OnEpBattleReady()
    end
  end
  return true, true
end

function ExplorationAutoCtrl:BreakAutoMode()
  if TimerManager:ContainTimer(self.__autoWaitTimerId) then
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.__isBreakAutoMode = true
    self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal)
    return true
  end
  return false
end

function ExplorationAutoCtrl:BreakAutoModeForce()
  if not self:IsAutoModeRunning() then
    return
  end
  self.__isBreakAutoMode = true
  if self.epAutoWindow == nil then
    return
  end
  self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal)
  self.epAutoWindow:SetAutoTitleActive(false)
end

function ExplorationAutoCtrl:OnAutoStageOver()
  if self.__isBreakAutoMode then
    self.__isBreakAutoMode = false
    self.epAutoWindow:SetAutoTitleActive(true)
  end
end

function ExplorationAutoCtrl:OnEpExitRoomComplete(exitFromType)
  if exitFromType ~= ExplorationEnum.eExitRoomCompleteType.BattleToEp then
    self:OnAutoStageOver()
  end
  local dynplayer = BattleUtil.GetCurDynPlayer()
  if dynplayer ~= nil then
    self:OnEpOpStateChanged(dynplayer:GetOperatorDetail())
  else
    error("CurDynPlayer is NIL")
  end
end

function ExplorationAutoCtrl:OnEpOpStateChanged(opDetail)
  if self.epCtrl:IsEpAutoSelectRoom() then
    return
  end
  if self:IsAutoModeRunning() and opDetail.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    for k, position in pairs(self.__autoPath) do
      if position == opDetail.curPostion and k < #self.__autoPath then
        local nextRoomPos = self.__autoPath[k + 1]
        if self.epCtrl.sceneCtrl:InBattleScene() then
          self.__waitSelectRoom = nextRoomPos
          return
        end
        self:__StartSelectRoomTimer(nextRoomPos)
        break
      end
    end
  end
end

function ExplorationAutoCtrl:OnEpSceneStateChanged(epBattleState)
  if not self:IsAutoModeRunning() then
    return
  end
  if epBattleState ~= ExplorationEnum.eEpSceneState.InEpScene then
    return
  end
  if self.__waitSelectRoom ~= nil then
    local nextRoomPos = self.__waitSelectRoom
    self.__waitSelectRoom = nil
    self:__StartSelectRoomTimer(nextRoomPos)
  end
end

function ExplorationAutoCtrl:__StartSelectRoomTimer(nextRoomPos)
  self.__autoTime = ConfigData.game_config.autoEpTime.selectRoom
  self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.SelectRoom, self.__autoTime)
  TimerManager:StopTimer(self.__autoWaitTimerId)
  self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.SelectRoom, self.__autoTime)
      return
    end
    TimerManager:StopTimer(self.__autoWaitTimerId)
    local playerCtrl = ExplorationManager.epCtrl.playerCtrl
    local mapData = self.epCtrl.mapData
    local roomData = mapData:GetRoomByCoord(nextRoomPos)
    playerCtrl:Move(roomData)
    self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal)
  end, nil, false, false, false)
end

function ExplorationAutoCtrl:OnEpBattleEnter()
  if not self:IsAutoModeRunning() then
    return
  end
  self.epAutoWindow:SetAutoMaskActive(true)
end

function ExplorationAutoCtrl:OnEpBattleReady()
  if not self:IsAutoModeRunning() then
    return
  end
  if self.__isBreakAutoMode then
    return
  end
  self.epAutoWindow:SetAutoMaskActive(true)
  TimerManager:StopTimer(self.__autoWaitTimerId)
  self.__autoWaitTimerId = TimerManager:StartTimer(ConfigData.game_config.autoEpTime.meaningless, function()
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.epCtrl.battleCtrl:EnterEpBattleRunning()
    if self.epAutoWindow ~= nil then
      self.epAutoWindow:SetAutoMaskActive(false)
    end
  end, nil, true, false, false)
end

function ExplorationAutoCtrl:OnEpBattleResultShow()
  if not self:IsAutoModeRunning() then
    return
  end
  self.epAutoWindow:SetAutoMaskActive(true)
  TimerManager:StopTimer(self.__autoWaitTimerId)
  self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    TimerManager:StopTimer(self.__autoWaitTimerId)
    if self.epAutoWindow ~= nil then
      self.epAutoWindow:SetAutoMaskActive(false)
    end
    local battleResultWindow = UIManager:GetWindow(UIWindowTypeID.BattleResult)
    if battleResultWindow ~= nil then
      battleResultWindow:ExitBattleResult()
    end
  end, nil, false, false, false)
end

function ExplorationAutoCtrl:OnEpBattleSelectChip(chipList)
  if not self:IsAutoModeRunning() then
    return
  end
  self.__autoTime = ConfigData.game_config.autoEpTime.roomOperator
  local showTitleType, chipPanel = self:__AutoEpSelectChipLogic(chipList, true)
  local showOperator = chipPanel ~= nil
  if showOperator then
    local autoChipHolder = chipPanel:GetAutoTipsHolder()
    self.epAutoWindow:SetAutoOperatorActive(true, autoChipHolder)
    self.epAutoWindow:SetAutoOperatorText(self.__autoTime)
  end
  self.epAutoWindow:SetAutoTitleState(showTitleType, self.__autoTime)
  self.epAutoWindow:SetAutoMaskActive(true)
  TimerManager:StopTimer(self.__autoWaitTimerId)
  self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      if showOperator then
        self.epAutoWindow:SetAutoOperatorText(self.__autoTime)
      end
      self.epAutoWindow:SetAutoTitleState(showTitleType, self.__autoTime)
      return
    end
    if showOperator then
      self.epAutoWindow:SetAutoOperatorText(0)
    end
    self.epAutoWindow:SetAutoTitleState(showTitleType, 0)
    if self.epCtrl.sceneCtrl.epSceneEntity:IsExitBattleTLPlaying() then
      return
    end
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self:__AutoEpSelectChipLogic(chipList)
    self.epAutoWindow:SetAutoMaskActive(false)
    self.epAutoWindow:SetAutoOperatorActive(false)
    self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal)
  end, nil, false, false, false)
end

function ExplorationAutoCtrl:__AutoEpSelectChipLogic(originChipList, noSend)
  local send = not noSend
  local selectChipWindow = UIManager:GetWindow(UIWindowTypeID.SelectChip)
  if selectChipWindow == nil then
    return ExplorationEnum.eAutoTitleType.Normal
  end
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local isOverLimit, ableGetNew = EpAutoUtil.AbleGetNewChip(dynPlayer)
  local chipList = {}
  local totalPowerDic = {}
  for _, chipData in pairs(originChipList) do
    local isNew, ableUpgrade = dynPlayer:IsChipNewAndUpgradeState(chipData.dataId)
    if ableUpgrade or isNew and ableGetNew then
      local power = dynPlayer:GetChipCombatEffect(chipData)
      if not (power <= 0) then
        table.insert(chipList, chipData)
        totalPowerDic[chipData] = power
      end
    end
  end
  if #chipList == 0 then
    if send then
      selectChipWindow:StartGiveUpLogic()
    end
    return ExplorationEnum.eAutoTitleType.GiveupChip
  end
  local chipData = EpAutoUtil.GetAutoBestValueChip(dynPlayer, chipList, totalPowerDic)
  local chipPanel
  if chipData ~= nil then
    for index, chip in pairs(originChipList) do
      if chip == chipData then
        chipPanel = selectChipWindow:GetChipPanelByIndex(index)
        break
      end
    end
  end
  if chipPanel == nil then
    if send then
      selectChipWindow:StartGiveUpLogic()
    end
    return ExplorationEnum.eAutoTitleType.GiveupChip
  end
  if send then
    selectChipWindow:ComfirmSelectChip(chipPanel)
  end
  return ExplorationEnum.eAutoTitleType.SelectChip, chipPanel
end

function ExplorationAutoCtrl:OnEnterEpTreasureRoom(treasureData, isFirstOpen)
  if not self:IsAutoModeRunning() then
    return
  end
  if isFirstOpen then
    self.epAutoWindow:SetAutoMaskActive(true)
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
      self.__autoTime = ConfigData.game_config.autoEpTime.roomOperator
      local showTitleType, chipPanel = self:__AutoEpTreasureLogic(treasureData, true)
      local showOperator = chipPanel ~= nil
      if showOperator then
        local autoChipHolder = chipPanel:GetAutoTipsHolder()
        self.epAutoWindow:SetAutoOperatorActive(true, autoChipHolder)
        self.epAutoWindow:SetAutoOperatorText(self.__autoTime)
      end
      self.epAutoWindow:SetAutoTitleState(showTitleType, self.__autoTime)
      TimerManager:StopTimer(self.__autoWaitTimerId)
      self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
        self.__autoTime = self.__autoTime - 1
        if self.__autoTime > 0 then
          if showOperator then
            self.epAutoWindow:SetAutoOperatorText(self.__autoTime)
          end
          self.epAutoWindow:SetAutoTitleState(showTitleType, self.__autoTime)
          return
        end
        TimerManager:StopTimer(self.__autoWaitTimerId)
        self:__AutoEpTreasureLogic(treasureData)
        self.epAutoWindow:SetAutoMaskActive(false)
        self.epAutoWindow:SetAutoOperatorActive(false)
        self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal)
      end, nil, false, false, false)
    end, nil, true, true, false)
  else
    self:__AutoEpTreasureLogic(treasureData)
  end
end

function ExplorationAutoCtrl:__AutoEpTreasureLogic(treasureData, noSend)
  local treasureWindow = UIManager:GetWindow(UIWindowTypeID.EpTreasureRoom)
  if treasureWindow == nil then
    return ExplorationEnum.eAutoTitleType.Normal
  end
  local send = not noSend
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local isOverLimit, ableGetNew = EpAutoUtil.AbleGetNewChip(dynPlayer)
  local chipList = {}
  local totalPowerDic = {}
  for _, tData in pairs(treasureData.chipDatas) do
    local chipData = tData.data
    local isNew, ableUpgrade = dynPlayer:IsChipNewAndUpgradeState(chipData.dataId)
    if ableUpgrade or isNew and ableGetNew then
      local power = dynPlayer:GetChipCombatEffect(chipData)
      if not (power <= 0) then
        table.insert(chipList, chipData)
        totalPowerDic[chipData] = power
      end
    end
  end
  if #chipList == 0 then
    if send then
      treasureWindow:TreasureGiveupLogic()
    end
    return ExplorationEnum.eAutoTitleType.GiveupChip
  end
  local chipData = EpAutoUtil.GetAutoBestValueChip(dynPlayer, chipList, totalPowerDic)
  local chipPanel
  if chipData ~= nil then
    for index, tData in pairs(treasureData.chipDatas) do
      if tData.data == chipData then
        chipPanel = treasureWindow:GetChipPanelByIndex(index)
        break
      end
    end
  end
  if chipPanel == nil then
    if send then
      treasureWindow:StartGiveUpLogic()
    end
    return ExplorationEnum.eAutoTitleType.GiveupChip
  end
  if send then
    treasureWindow:OnComfirmClick(chipPanel)
  end
  return ExplorationEnum.eAutoTitleType.SelectChip, chipPanel
end

function ExplorationAutoCtrl:OnEnterEpStoreRoom(storeDataList, currencyId, isFirstOpen)
  if not self:IsAutoModeRunning() then
    return
  end
  if self.__isBreakAutoMode then
    return
  end
  if isFirstOpen then
    local showTitleType = self:__AutoEpStoreLogic(storeDataList, currencyId, true)
    self.__autoTime = ConfigData.game_config.autoEpTime.roomOperator
    self.epAutoWindow:SetAutoTitleState(showTitleType, self.__autoTime)
    self.epAutoWindow:SetAutoMaskActive(true)
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
      self.__autoTime = self.__autoTime - 1
      if self.__autoTime > 0 then
        self.epAutoWindow:SetAutoTitleState(showTitleType, self.__autoTime)
        return
      end
      TimerManager:StopTimer(self.__autoWaitTimerId)
      self:__AutoEpStoreLogic(storeDataList, currencyId)
      self.epAutoWindow:SetAutoMaskActive(false)
      self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal)
    end, nil, false, false, false)
  else
    self:__AutoEpStoreLogic(storeDataList, currencyId)
  end
end

function ExplorationAutoCtrl:__AutoEpStoreLogic(storeDataList, currencyId, noSend)
  local send = not noSend
  local storeWindow = UIManager:GetWindow(UIWindowTypeID.EpStoreRoom)
  if storeWindow == nil then
    return ExplorationEnum.eAutoTitleType.Normal
  end
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local isOverLimit, nowCount, nowLimit = dynPlayer:IsChipOverLimitNum()
  if isOverLimit then
    if send then
      self.epCtrl.storeCtrl:SendStoreQuit()
    end
    return ExplorationEnum.eAutoTitleType.ExitRoom
  end
  local noLimit = nowCount < nowLimit
  local money = dynPlayer:GetItemCount(currencyId)
  local couldLoanMoney = self.epCtrl.campFetterCtrl:GetCouldLeonMoney()
  local useMoney = money + couldLoanMoney
  local chipList = {}
  local totalPowerDic = {}
  for _, storeData in pairs(storeDataList) do
    if not storeData.saled then
      local chipData = storeData.chipData
      if chipData ~= nil then
        local isNew, ableUpgrade = dynPlayer:IsChipNewAndUpgradeState(chipData.dataId)
        if ableUpgrade or isNew and noLimit then
          local buyPrice = chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId())
          if not (useMoney < buyPrice) then
            local power = dynPlayer:GetChipCombatEffect(chipData)
            if not (power <= 0) then
              table.insert(chipList, chipData)
              totalPowerDic[chipData] = power
            end
          end
        end
      end
    end
  end
  if #chipList == 0 then
    if money < ConfigData.game_config.epAutoStoreMoney or money < self.epCtrl.storeCtrl:GetEpStoreRefreshPrice() then
      if send then
        self.epCtrl.storeCtrl:SendStoreQuit()
      end
      return ExplorationEnum.eAutoTitleType.ExitRoom
    end
    local haveNoFullLevel = false
    local chipDic = dynPlayer:GetNormalChipDic()
    for _, chipData in pairs(chipDic) do
      if not chipData:IsChipFullLevel() then
        haveNoFullLevel = true
        break
      end
    end
    if haveNoFullLevel then
      if send then
        self.epCtrl.storeCtrl:ReqEpStoreRefresh()
      end
      return ExplorationEnum.eAutoTitleType.BuyChip
    else
      if send then
        self.epCtrl.storeCtrl:SendStoreQuit()
      end
      return ExplorationEnum.eAutoTitleType.ExitRoom
    end
  end
  local chipData = EpAutoUtil.GetAutoBestValueChip(dynPlayer, chipList, totalPowerDic)
  local storeData
  if chipData ~= nil then
    for _, tstoreData in pairs(storeDataList) do
      if tstoreData.chipData == chipData then
        storeData = tstoreData
        break
      end
    end
  end
  if storeData == nil then
    if send then
      self.epCtrl.storeCtrl:SendStoreQuit()
    end
    return ExplorationEnum.eAutoTitleType.ExitRoom
  end
  if send then
    local buyPrice = storeData.chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId())
    self.epCtrl.storeCtrl:SendStorePurchase(storeData.idx, buyPrice)
  end
  return ExplorationEnum.eAutoTitleType.BuyChip
end

function ExplorationAutoCtrl:OnEnterEpEventRoom(eventRoomData, isFirstOpen)
  if not self:IsAutoModeRunning() then
    return
  end
  if self.__isBreakAutoMode then
    return
  end
  self.epAutoWindow:SetAutoMaskActive(true)
  TimerManager:StopTimer(self.__autoWaitTimerId)
  self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    local eventWindow = UIManager:GetWindow(UIWindowTypeID.EpEventRoom)
    if eventWindow == nil then
      return
    end
    local ableChoiceList = {}
    local autoChoiceList = {}
    local choicePriorityDic = {}
    local choiceDatalist = eventRoomData.choiceDatalist
    for _, choiceData in pairs(choiceDatalist) do
      if choiceData.isAble then
        table.insert(ableChoiceList, choiceData)
        choicePriorityDic[choiceData] = 0
        local choiceCfg = self.epCtrl.eventCtrl:GetEpEventChoiceCfg(choiceData)
        if choiceCfg ~= nil then
          choicePriorityDic[choiceData] = choiceCfg.auto_priority or 0
          goto lbl_40
          goto lbl_58
          ::lbl_40::
          if choiceCfg.auto_choice_type ~= 0 then
            local dynPlayer = ExplorationManager:GetDynPlayer()
            local autoSuccess = EpAutoUtil.IsEventChoiceAutoSuccess(choiceCfg.auto_choice_type, choiceCfg.auto_choice_arg, dynPlayer)
            if autoSuccess then
              table.insert(autoChoiceList, choiceData)
            end
          end
        end
      end
      ::lbl_58::
    end
    local resultIndex = 0
    if 0 < #autoChoiceList then
      resultIndex = self:__AutoSelectEventChoice(autoChoiceList, choicePriorityDic)
    else
      resultIndex = self:__AutoSelectEventChoice(ableChoiceList, choicePriorityDic)
    end
    if resultIndex == 0 then
      ExplorationManager.epCtrl.eventCtrl:SendExit()
      return
    end
    local choiceData = choiceDatalist[resultIndex]
    local choiceCfg
    local catId = choiceData.catId
    if choiceData.catId == ExplorationEnum.eEventRoomChoiceType.Normal then
      choiceCfg = ConfigData.event_choice[choiceData.choiceId]
    elseif choiceData.catId == ExplorationEnum.eEventRoomChoiceType.Upgrade then
      choiceCfg = ConfigData.event_upgrade[choiceData.choiceId]
    elseif choiceData.catId == ExplorationEnum.eEventRoomChoiceType.Jump then
      choiceCfg = ConfigData.event_jump[choiceData.choiceId]
    elseif choiceData.catId == ExplorationEnum.eEventRoomChoiceType.Assist then
      choiceCfg = ConfigData.event_assist[choiceData.choiceId]
    elseif choiceData.catId == ExplorationEnum.eEventRoomChoiceType.AssistEx then
      choiceCfg = ConfigData.event_assist_ex[choiceData.choiceId]
    else
      error("Unsupported eEventRoomChoiceType, id = " .. tostring(choiceData.catId))
      return
    end
    local choiceItem = eventWindow:GetEventChoiceItem(resultIndex)
    if choiceItem ~= nil then
      local autoChipHolder = choiceItem:GetAutoTipsHolder()
      self.epAutoWindow:SetAutoOperatorActive(true, autoChipHolder)
    end
    self.__autoTime = ConfigData.game_config.autoEpTime.roomOperator
    self.epAutoWindow:SetAutoOperatorText(self.__autoTime)
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
      self.__autoTime = self.__autoTime - 1
      if self.__autoTime > 0 then
        self.epAutoWindow:SetAutoOperatorText(self.__autoTime)
        return
      end
      TimerManager:StopTimer(self.__autoWaitTimerId)
      self.epCtrl.eventCtrl:OnChoiceItemClick(choiceCfg, resultIndex - 1, true, catId)
      self.epAutoWindow:SetAutoMaskActive(false)
      self.epAutoWindow:SetAutoOperatorActive(false)
      if eventRoomData.eRoomType == ExplorationEnum.eRoomType.eventShop and choiceCfg.event_exit ~= 1 then
        ExplorationManager.epCtrl.eventCtrl:SendExit()
      end
    end, nil, false, false, false)
  end, nil, true, true, false)
end

function ExplorationAutoCtrl:__AutoSelectEventChoice(choiceList, choicePriorityDic)
  if #choiceList == 0 then
    return 0
  end
  if #choiceList == 1 then
    return choiceList[1].idx + 1
  end
  table.sort(choiceList, function(c1, c2)
    return choicePriorityDic[c1] < choicePriorityDic[c2]
  end)
  while 2 <= #choiceList and choicePriorityDic[choiceList[1]] ~= choicePriorityDic[choiceList[#choiceList]] do
    table.remove(choiceList)
  end
  local idx = choiceList[math.random(#choiceList)].idx + 1
  return idx
end

function ExplorationAutoCtrl:OnEnterEpEventRoomUpgrade(eventRoomData, isFirstOpen)
  if not self:IsAutoModeRunning() then
    return
  end
  if self.__isBreakAutoMode then
    return
  end
  if isFirstOpen then
    self.__autoTime = ConfigData.game_config.autoEpTime.roomOperator
    self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.UpgradeChip, self.__autoTime)
    self.epAutoWindow:SetAutoMaskActive(true)
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
      self.__autoTime = self.__autoTime - 1
      if self.__autoTime > 0 then
        self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.UpgradeChip, self.__autoTime)
        return
      end
      TimerManager:StopTimer(self.__autoWaitTimerId)
      self:AutoEpEventRoomUpgradeLogic()
      self.epAutoWindow:SetAutoMaskActive(false)
      self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal)
    end, nil, false, false, false)
  else
    self:AutoEpEventRoomUpgradeLogic()
  end
end

function ExplorationAutoCtrl:AutoEpEventRoomUpgradeLogic()
  local epUpgradeWindow = UIManager:GetWindow(UIWindowTypeID.EpUpgradeRoom)
  if epUpgradeWindow == nil then
    return
  end
  if not epUpgradeWindow:CheckRefreshTimeEnough() then
    return
  end
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local currencyNum = dynPlayer:GetMoneyCount()
  local upgradePrice = ConfigData:CalculateEpChipUpgradePrice(epUpgradeWindow.roomId, epUpgradeWindow.refreshTime)
  if currencyNum < upgradePrice and 0 < upgradePrice then
    self.epCtrl.eventCtrl:SendSpecifyExit()
    return
  end
  local chipDataList = dynPlayer:GetChipList()
  if chipDataList == nil or #chipDataList == 0 then
    self.epCtrl.eventCtrl:SendSpecifyExit()
    return
  end
  local fightPower = -1
  local chipData
  for k, tmpChipData in pairs(chipDataList) do
    if not tmpChipData:IsChipFullLevel() then
      local curFightPower = dynPlayer:GetChipCombatEffect(tmpChipData, true, true)
      if fightPower < curFightPower then
        fightPower = curFightPower
        chipData = tmpChipData
      end
    end
  end
  if chipData == nil then
    self.epCtrl.eventCtrl:SendSpecifyExit()
    return
  end
  if fightPower <= 0 and 0 < upgradePrice then
    self.epCtrl.eventCtrl:SendSpecifyExit()
    return
  end
  self.epCtrl.eventCtrl:SendMsgChipUpgrade(chipData, nil)
end

function ExplorationAutoCtrl:OnEnterEpEventSupportEx(isFirstOpen)
  if not self:IsAutoModeRunning() then
    return
  end
  if TimerManager:ContainTimer(self.__autoWaitTimerId) then
    return
  end
  if self.__isBreakAutoMode and not isFirstOpen then
    return
  end
  if isFirstOpen then
    local showTitleType = self:__AutoEpEventSupportEx(true)
    self.__autoTime = ConfigData.game_config.autoEpTime.roomOperator
    self.epAutoWindow:SetAutoTitleState(showTitleType, self.__autoTime)
    self.epAutoWindow:SetAutoMaskActive(true)
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
      self.__autoTime = self.__autoTime - 1
      if self.__autoTime > 0 then
        self.epAutoWindow:SetAutoTitleState(showTitleType, self.__autoTime)
        return
      end
      TimerManager:StopTimer(self.__autoWaitTimerId)
      self:__AutoEpEventSupportEx()
      self.epAutoWindow:SetAutoMaskActive(false)
      self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal)
    end, nil, false, false, false)
  else
    self:__AutoEpEventSupportEx()
  end
end

local function supHeroPowerSort(heroItem1, heroItem2)
  local fp1, id1 = heroItem1:GetSupHeroItemPowerAndId()
  local fp2, id2 = heroItem2:GetSupHeroItemPowerAndId()
  if fp1 ~= fp2 then
    return fp1 > fp2
  end
  return id1 < id2
end

function ExplorationAutoCtrl:__AutoEpEventSupportEx(noSend)
  local send = not noSend
  local supportRoom = UIManager:GetWindow(UIWindowTypeID.EpSupportRoom)
  if supportRoom == nil then
    return ExplorationEnum.eAutoTitleType.Normal
  end
  local inFormationDic, maxHeroCount, supHeroItemList = supportRoom:GetSupportRoomData()
  local hasCount = table.count(inFormationDic)
  if maxHeroCount <= hasCount or #supHeroItemList <= 0 then
    if send then
      supportRoom:EpSupportCancel()
    end
    return ExplorationEnum.eAutoTitleType.ExitRoom
  end
  if not send then
    return ExplorationEnum.eAutoTitleType.EventSupport
  end
  local ableSelectCount = math.min(maxHeroCount - hasCount, ConfigData.game_config.supportHeroMaxNum)
  local tmpHeroList = {}
  for _, v in pairs(supHeroItemList) do
    table.insert(tmpHeroList, v)
  end
  if ableSelectCount >= #tmpHeroList then
    for _, heroItem in pairs(tmpHeroList) do
      heroItem:ClickSupHeroItem()
    end
  else
    table.sort(tmpHeroList, supHeroPowerSort)
    for i = 1, ableSelectCount do
      local heroItem = tmpHeroList[i]
      heroItem:ClickSupHeroItem()
    end
  end
  supportRoom:EpSupportConfirm()
  return ExplorationEnum.eAutoTitleType.EventSupport
end

function ExplorationAutoCtrl:OnEnterEpChipDiscard(isFirstOpen)
  if not self:IsAutoModeRunning() then
    return
  end
  if TimerManager:ContainTimer(self.__autoWaitTimerId) then
    return
  end
  if self.__isBreakAutoMode and not isFirstOpen then
    return
  end
  if isFirstOpen then
    local showTitleType = self:__AutoEpChipDiscardLogic(true)
    self.__autoTime = ConfigData.game_config.autoEpTime.roomOperator
    self.epAutoWindow:SetAutoTitleState(showTitleType, self.__autoTime)
    self.epAutoWindow:SetAutoMaskActive(true)
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
      self.__autoTime = self.__autoTime - 1
      if self.__autoTime > 0 then
        self.epAutoWindow:SetAutoTitleState(showTitleType, self.__autoTime)
        return
      end
      TimerManager:StopTimer(self.__autoWaitTimerId)
      self:__AutoEpChipDiscardLogic()
      self.epAutoWindow:SetAutoMaskActive(false)
      self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal)
    end, nil, false, false, false)
  else
    self:__AutoEpChipDiscardLogic()
  end
end

function ExplorationAutoCtrl:__AutoEpChipDiscardLogic(noSend)
  local send = not noSend
  local chipDiscardWindow = UIManager:GetWindow(UIWindowTypeID.EpChipDiscard)
  if chipDiscardWindow == nil then
    return ExplorationEnum.eAutoTitleType.Normal
  end
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local isOverLimit, nowCount, nowLimit = dynPlayer:IsChipOverLimitNum()
  if not isOverLimit then
    if CS.WaitNetworkResponse.Instance:ContainWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Exit) then
      return ExplorationEnum.eAutoTitleType.Normal
    end
    if send then
      chipDiscardWindow:CloseEpDiscard()
    end
    return ExplorationEnum.eAutoTitleType.Normal
  end
  local chipDataList = dynPlayer:GetChipList()
  local fightPower = CommonUtil.Int32Max
  local chipData
  for _, tmpChipData in pairs(dynPlayer:GetChipList()) do
    local tmpFightPower = dynPlayer:GetChipDiscardFightPower(tmpChipData, true)
    if tmpFightPower <= 0 then
      fightPower = 0
      chipData = tmpChipData
      break
    elseif tmpFightPower < fightPower then
      fightPower = tmpFightPower
      chipData = tmpChipData
    end
  end
  if fightPower == 0 then
    if send then
      chipDiscardWindow:StartDiscardChip(chipData)
    end
    return ExplorationEnum.eAutoTitleType.DiscardChip
  end
  local currentItemNum = dynPlayer:GetItemCount(chipDiscardWindow.costItemId)
  if currentItemNum >= chipDiscardWindow.costItemNum then
    if send then
      chipDiscardWindow:AddChipLimit()
    end
    return ExplorationEnum.eAutoTitleType.UpgradeChipLimit
  end
  if send then
    chipDiscardWindow:StartDiscardChip(chipData)
  end
  return ExplorationEnum.eAutoTitleType.DiscardChip
end

function ExplorationAutoCtrl:OnEnterChipReplace(isFirstOpen)
  if not self:IsAutoModeRunning() then
    return
  end
  if self.__isBreakAutoMode and not isFirstOpen then
    return
  end
  local window = UIManager:GetWindow(UIWindowTypeID.ChipDisplace)
  if window == nil then
    return
  end
  if isFirstOpen then
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.__autoTime = ConfigData.game_config.autoEpTime.roomOperator
    self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal, self.__autoTime)
    self.epAutoWindow:SetAutoMaskActive(true)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
      self.__autoTime = self.__autoTime - 1
      if self.__autoTime > 0 then
        self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal, self.__autoTime)
        return
      end
      TimerManager:StopTimer(self.__autoWaitTimerId)
      self:AutoChipReplace()
      self.epAutoWindow:SetAutoMaskActive(false)
      self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal)
    end, nil, false, false, false)
  else
    self:AutoChipReplace()
  end
end

function ExplorationAutoCtrl:AutoChipReplace()
  local window = UIManager:GetWindow(UIWindowTypeID.ChipDisplace)
  if window == nil then
    return
  end
  if window.remainCount <= 0 then
    self.epCtrl:SendExitChipReplace()
    return
  end
  if 0 >= #window.chipList then
    self.epCtrl:SendExitChipReplace()
    return
  end
  if window.isAllDisplace then
    self.epCtrl:SendChipReplace(0)
  else
    local selectIdex = 1
    local chipData = window.chipList[selectIdex]
    for i = 2, #window.chipList do
      local item = window.chipList[i]
      if chipData:GetQuality() > item:GetQuality() then
        chipData = item
        selectIdex = i
      elseif chipData:GetQuality() == item:GetQuality() and chipData:GetCount() > item:GetCount() then
        chipData = item
        selectIdex = i
      end
    end
    window.selectIndex = selectIdex
    self.epCtrl:SendChipReplace(chipData.chipCfg.id)
  end
end

function ExplorationAutoCtrl:OnEnterTaskSelect(isFirstOpen)
  if not self:IsAutoModeRunning() then
    return
  end
  if self.__isBreakAutoMode and not isFirstOpen then
    return
  end
  local window = UIManager:GetWindow(UIWindowTypeID.EpTask)
  if window == nil then
    return
  end
  if isFirstOpen then
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.__autoTime = ConfigData.game_config.autoEpTime.roomOperator
    self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal, self.__autoTime)
    self.epAutoWindow:SetAutoMaskActive(true)
    self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
      self.__autoTime = self.__autoTime - 1
      if self.__autoTime > 0 then
        self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal, self.__autoTime)
        return
      end
      TimerManager:StopTimer(self.__autoWaitTimerId)
      self:AutoTaskSelect()
      self.epAutoWindow:SetAutoMaskActive(false)
      self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal)
    end, nil, false, false, false)
  else
    self:AutoTaskSelect()
  end
end

function ExplorationAutoCtrl:AutoTaskSelect()
  local window = UIManager:GetWindow(UIWindowTypeID.EpTask)
  if window == nil then
    return
  end
  local taskId = window:GetDefaultSelectTaskId()
  if (taskId or 0) == 0 then
    self.epCtrl:SendGiveUpTask()
  else
    self.epCtrl:SendGetTask(taskId)
  end
end

function ExplorationAutoCtrl:OnEnterActiveChipDrop(func)
  if not self:IsAutoModeRunning() then
    return
  end
  if self.__isBreakAutoMode then
    return
  end
  local window = UIManager:GetWindow(UIWindowTypeID.DungeonInfoDetail)
  if window == nil then
    return
  end
  TimerManager:StopTimer(self.__autoWaitTimerId)
  self.__autoTime = ConfigData.game_config.autoEpTime.roomOperator
  self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal, self.__autoTime)
  self.epAutoWindow:SetAutoMaskActive(true)
  self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    self.__autoTime = self.__autoTime - 1
    if self.__autoTime > 0 then
      self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal, self.__autoTime)
      return
    end
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.epAutoWindow:SetAutoMaskActive(false)
    self.epAutoWindow:SetAutoTitleState(ExplorationEnum.eAutoTitleType.Normal)
    self:AutoActiveChipDrop(func)
  end, nil, false, false, false)
end

function ExplorationAutoCtrl:AutoActiveChipDrop(func)
  local window = UIManager:GetWindow(UIWindowTypeID.DungeonInfoDetail)
  if window == nil then
    return
  end
  func()
end

function ExplorationAutoCtrl:OnEnterEpExRoom(exRoomType, isFirstOpen)
  if not self:IsAutoModeRunning() then
    return
  end
  if self.__isBreakAutoMode then
    return
  end
  self.epAutoWindow:SetAutoMaskActive(true)
  if exRoomType == ExplorationEnum.exRoomType.AvgRoom then
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
    if avgCtrl ~= nil then
      avgCtrl:SetStartAutoPlayAvg()
    end
  end
end

function ExplorationAutoCtrl:OnExitEpExRoom()
  if not self:IsAutoModeRunning() then
    return
  end
  if self.__isBreakAutoMode then
    return
  end
  self.epAutoWindow:SetAutoMaskActive(false)
end

function ExplorationAutoCtrl:OnEpFloorSettle()
  if not self:IsAutoModeRunning() then
    return
  end
  self.epAutoWindow:SetAutoMaskActive(true)
  TimerManager:StopTimer(self.__autoWaitTimerId)
  self.__autoWaitTimerId = TimerManager:StartTimer(ConfigData.game_config.autoEpTime.meaningless, function()
    TimerManager:StopTimer(self.__autoWaitTimerId)
    ExplorationManager:EnterNextSectionExploration()
    self.epAutoWindow:SetAutoMaskActive(false)
  end, nil, true, false, false)
end

function ExplorationAutoCtrl:CalcAutoEpPath()
  self.__autoPath = {}
  local mapData = self.epCtrl.mapData
  local opDetail = self.epCtrl.dynPlayer:GetOperatorDetail()
  local curPostion = opDetail.curPostion
  local roomData = mapData:GetRoomByCoord(curPostion)
  local closeRooms = {}
  table.insert(self.__autoPath, curPostion)
  if not roomData:IsEndColRoom() then
    repeat
      local priorRoom, priorValue
      local priorFightPower = 0
      local nextRoom = roomData:GetNextRoom()
      for k, tmpRoomData in pairs(nextRoom) do
        if not closeRooms[tmpRoomData] and tmpRoomData:IsCanMove() then
          local roomType = tmpRoomData:GetRoomType()
          local roomTypeCfg = ConfigData.exploration_roomtype[roomType]
          local curPriority = roomTypeCfg.priority
          local curFightPower = roomData:GetTotalFightingPower()
          if priorRoom == nil then
            priorRoom = tmpRoomData
            priorValue = curPriority
            priorFightPower = curFightPower
          elseif curPriority < priorValue then
            priorRoom = tmpRoomData
            priorValue = curPriority
            priorFightPower = curFightPower
          elseif curPriority == priorValue and (curFightPower < priorFightPower or curFightPower == priorFightPower and tmpRoomData.y < priorRoom.y) then
            priorRoom = tmpRoomData
            priorValue = curPriority
          end
        end
      end
      if priorRoom == nil then
        do
          local count = #self.__autoPath
          closeRooms[roomData] = true
          table.remove(self.__autoPath, count)
          local pos = self.__autoPath[count - 1]
          if pos == nil then
            return
          end
          priorRoom = mapData:GetRoomByCoord(pos)
          if priorRoom == roomData then
            return
          end
          roomData = priorRoom
        end
      else
        roomData = priorRoom
        table.insert(self.__autoPath, roomData.position)
      end
    until roomData:IsEndColRoom()
  end
end

function ExplorationAutoCtrl:CheckAutoModeRoomClick(keyRoom)
  if not self:IsEnableAutoMode() then
    return false
  end
  if self:IsAutoModeRunning() then
    return true
  end
  if not keyRoom:IsCanMove() then
    return false
  end
  local keyIndex
  local newAutoPath = {}
  for k, position in pairs(self.__autoPath) do
    local x, y = ExplorationManager.Coordination2Pos(position)
    if x == keyRoom.x and y ~= keyRoom.y then
      keyIndex = k
    end
    newAutoPath[k] = position
  end
  if keyIndex == nil then
    return true
  end
  newAutoPath[keyIndex] = keyRoom.position
  local curRoomData = keyRoom
  for i = keyIndex - 1, 1, -1 do
    local roomList = curRoomData:GetLastRoom()
    local cRoom
    local pos = newAutoPath[i]
    local x, y = ExplorationManager.Coordination2Pos(pos)
    local distance = CommonUtil.Int32Max
    for k, tmpRoomData in pairs(roomList) do
      if tmpRoomData:IsCanMove() then
        local tmpDistance = math.abs(tmpRoomData.y - y)
        if distance > tmpDistance then
          newAutoPath[i] = tmpRoomData.position
          cRoom = tmpRoomData
          distance = tmpDistance
        end
      end
    end
    if cRoom == nil then
      return true
    end
    curRoomData = cRoom
  end
  if newAutoPath[1] ~= self.__autoPath[1] then
    return true
  end
  curRoomData = keyRoom
  for i = keyIndex + 1, #newAutoPath do
    local roomList = curRoomData:GetNextRoom()
    local cRoom
    local pos = newAutoPath[i]
    local x, y = ExplorationManager.Coordination2Pos(pos)
    local distance = CommonUtil.Int32Max
    for k, tmpRoomData in pairs(roomList) do
      if tmpRoomData:IsCanMove() then
        local tmpDistance = math.abs(tmpRoomData.y - y)
        if distance > tmpDistance then
          newAutoPath[i] = tmpRoomData.position
          cRoom = tmpRoomData
          distance = tmpDistance
        end
      end
    end
    if cRoom == nil then
      return true
    end
    curRoomData = cRoom
  end
  if newAutoPath[#newAutoPath] ~= self.__autoPath[#self.__autoPath] then
    return true
  end
  self.__autoPath = newAutoPath
  if self.epCtrl.mapCtrl ~= nil then
    local curRoomData = self.epCtrl:GetCurrentRoomData(true)
    self.epCtrl.mapCtrl:RefreshMapShowState(ExplorationManager:GetDynPlayer():GetOperatorDetail(), curRoomData)
  end
  return true
end

function ExplorationAutoCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnEpOpStateChanged, self.__onEpOpStateChanged)
  MsgCenter:RemoveListener(eMsgEventId.OnEpOpStateChanged, self.__onEpSceneStateChanged)
  MsgCenter:RemoveListener(eMsgEventId.OnBattleReady, self.__onEpBattleReady)
  MsgCenter:RemoveListener(eMsgEventId.OnExitRoomComplete, self.__onEpExitRoomComplete)
  MsgCenter:RemoveListener(eMsgEventId.OnChipDiscardChanged, self.__onEnterEpChipDiscard)
  self:__ClearAutoData()
  base.OnDelete(self)
end

return ExplorationAutoCtrl
