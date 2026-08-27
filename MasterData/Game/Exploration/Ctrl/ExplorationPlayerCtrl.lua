local ExplorationPlayerCtrl = class("ExplorationPlayerCtrl", ExplorationCtrlBase)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_ColorUtility = CS.UnityEngine.ColorUtility
local cs_coroutine = require("XLua.Common.cs_coroutine")

function ExplorationPlayerCtrl:ctor(epCtrl)
  self.dynPlayer = epCtrl.dynPlayer
  self.epNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.__onRoomSelected = BindCallback(self, self.OnMove)
  MsgCenter:AddListener(eMsgEventId.OnRoomSelected, self.__onRoomSelected)
  self.__onEpOperatorUpdate = BindCallback(self, self.UpdateEpOp)
  MsgCenter:AddListener(eMsgEventId.OnEpOpStore, self.__onEpOperatorUpdate)
  self.__onEpOperatorDiff = BindCallback(self, self.OnEpOperatorDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpOperatorDiff, self.__onEpOperatorDiff)
  self.__onEpFormDetailDiff = BindCallback(self, self.OnEpFormationDetailDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpFormationDetailDiff, self.__onEpFormDetailDiff)
  self.__onEpBackpackDiff = BindCallback(self, self.OnEpBackpackDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpBackpackDiff, self.__onEpBackpackDiff)
  self.__OnEpBuffDiff = BindCallback(self, self.OnEpBuffDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffDiff, self.__OnEpBuffDiff)
  self.__OnExitRoomComplete = BindCallback(self, self.__OnRoomExitComplete)
  MsgCenter:AddListener(eMsgEventId.OnExitRoomComplete, self.__OnExitRoomComplete)
  self.__OnChipDataDiff = BindCallback(self, self.OnChipDataDiff)
  MsgCenter:AddListener(eMsgEventId.OnChipDataDiff, self.__OnChipDataDiff)
  self.__OnEpServerGridDiff = BindCallback(self, self.OnEpServerGridDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpServerGridDiff, self.__OnEpServerGridDiff)
  self.__OnEpRewardBagDiff = BindCallback(self, self.OnEpRewardBagDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpRewardBagDiff, self.__OnEpRewardBagDiff)
  self.__OnEpCommonDataDiff = BindCallback(self, self.OnEpCommonDataDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpCommonDataDiff, self.__OnEpCommonDataDiff)
  self.__OnWcEpScoreChange = BindCallback(self, self.OnWcEpScoreChange)
  MsgCenter:AddListener(eMsgEventId.OnWCEpScoreChange, self.__OnWcEpScoreChange)
  self.__OnSpecEffectDiff = BindCallback(self, self.OnSpecEffectDiff)
  MsgCenter:AddListener(eMsgEventId.OnSpecEffectDiff, self.__OnSpecEffectDiff)
end

function ExplorationPlayerCtrl:__OnRoomExitComplete(roomType)
  local inBattleRoomSelectChip = roomType == ExplorationEnum.eExitRoomCompleteType.BattleToEp and self.dynPlayer:GetOperatorDetailState() == proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleALGWaiting
  if self.dynPlayer:GetOperatorDetailState() == proto_object_ExplorationCurGridState.ExplorationCurGridState_DropAlg then
    self.epCtrl:DiscardChip()
  elseif not inBattleRoomSelectChip then
    self.dynPlayer.playerClientState = ExplorationEnum.ePlayerClientState.Exting
    self.epCtrl:CheckAfterOutSide()
    self.epCtrl:OnExitEpRoomBegin()
  end
  self:__TryShowNewReward()
  self.leaveRoomCoroutine = cs_coroutine.start(function()
    self.__waitingLeaveRoomCo = false
    self:TryShowMonsterLvUp(roomType)
    while self.__waitingLeaveRoomCo do
      coroutine.yield(nil)
    end
    self:TryShowSelectDebuff()
    while self.__waitingLeaveRoomCo do
      coroutine.yield(nil)
    end
    self:TryShowEpTalkDialog()
    while self.__waitingLeaveRoomCo do
      coroutine.yield(nil)
    end
    self.leaveRoomCoroutine = nil
  end)
end

function ExplorationPlayerCtrl:__TryShowNewReward()
  local lastRewardDataList = self.dynPlayer.dynRewardBag:TryGetLastEpRewardBagDataList()
  if lastRewardDataList == nil then
    return
  end
  if 0 < #lastRewardDataList then
    local epWindow = UIManager:GetWindow(UIWindowTypeID.Exploration)
    if epWindow ~= nil then
      epWindow:StartFlyRewardBag()
    end
  end
end

function ExplorationPlayerCtrl:TryShowMonsterLvUp(roomType)
  if roomType == ExplorationEnum.eExitRoomCompleteType.BattleToEp and self.epCtrl.residentStoreCtrl:HasEpResidentStore() then
    return
  end
  local hasMonsterLvUp, oldLevel, newLevel = self.dynPlayer:HasEpMonsterLvUp(true)
  if not hasMonsterLvUp then
    return
  end
  local curRoomData = self.epCtrl:GetCurrentRoomData()
  if not ExplorationManager:HasNextLevel() and (curRoomData:IsBossRoom() or curRoomData:IsEndColRoom()) then
    return
  end
  self.__waitingLeaveRoomCo = true
  UIManager:ShowWindowAsync(UIWindowTypeID.EpMonsterLevelUp, function(window)
    if window == nil then
      return
    end
    window:InitEpMonsterLevelUp(oldLevel, newLevel, function()
      self.__waitingLeaveRoomCo = false
    end)
  end)
end

function ExplorationPlayerCtrl:TryShowSelectDebuff()
  if self.dynPlayer:HasDebuffSelect() then
    self.__waitingLeaveRoomCo = true
    UIManager:ShowWindowAsync(UIWindowTypeID.EpSelectDebuff, function(win)
      if win == nil then
        return
      end
      win:InitEpSelectDebuff(self.dynPlayer, function()
        self.__waitingLeaveRoomCo = false
      end)
    end)
  end
end

function ExplorationPlayerCtrl:TryShowEpTalkDialog()
  local opState = self.dynPlayer:GetOperatorDetailState()
  if opState ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    return
  end
  if GuideManager.inGuide then
    return
  end
  if self.epCtrl.autoCtrl:IsEnableAutoMode() then
    return
  end
  local isNeedBlock = false
  local opDetail = self.dynPlayer:GetOperatorDetail()
  local curPostion = opDetail.curPostion
  local mapData = self.epCtrl.mapData
  local isHave, talkId = mapData:GetIsRoomHavePreviousTalkDialog(curPostion)
  if isHave then
    local epTalkCfg = ConfigData.exploration_tip[talkId]
    self.__waitingLeaveRoomCo = true
    UIManager:ShowWindowAsync(UIWindowTypeID.EPTalkDialog, function(win)
      if win == nil then
        return
      end
      win:StartEpTalkDialog(epTalkCfg, function()
        self.__waitingLeaveRoomCo = false
      end)
    end)
  end
end

function ExplorationPlayerCtrl:AutoRoomSelect()
  local opDetail = self.dynPlayer:GetOperatorDetail()
  if opDetail.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_HalfOver then
    local currentRoomData = self:GetCurrentRoomData()
    self:Move(currentRoomData, true)
  end
end

function ExplorationPlayerCtrl:Move(roomData, auto)
  local opDetail = self.dynPlayer:GetOperatorDetail()
  if opDetail.state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over and not auto then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Player_CantSelectRoom))
    return
  end
  if opDetail.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    self.dynPlayer:RecordLastMoney()
  end
  self.dynPlayer.playerClientState = ExplorationEnum.ePlayerClientState.Entering
  if roomData:IsWormholeRoom() then
    local roomUI = self.epCtrl:GetRoomUI(roomData.position)
    if roomUI ~= nil then
      roomUI:PlayWormholeEffect(function()
        self.epNetwork:CS_EXPLORATION_Select(roomData.position)
      end)
    end
  else
    self.epNetwork:CS_EXPLORATION_Select(roomData.position)
  end
end

function ExplorationPlayerCtrl:OnMove()
  local currentRoom = self:GetCurrentRoomData()
  self.epCtrl:OnPlayerMoveStart(currentRoom)
end

function ExplorationPlayerCtrl:CheckEpRoomAccess(roomData)
  local opDetail = self.dynPlayer:GetOperatorDetail()
  if opDetail.epFloorWalked[roomData.position] then
    return false
  end
  local currentRoom = self:GetCurrentRoomData(true)
  if currentRoom == nil then
    return false
  end
  if currentRoom:IsCrossRoom() and currentRoom.x == roomData.x and currentRoom.y ~= roomData.y then
    return true
  end
  local unlimieChoose = self.dynPlayer:GetEpUnlimitChooseRoom()
  local mapData = self.epCtrl.mapData
  if unlimieChoose and roomData.x > currentRoom.x and roomData.x <= mapData.depth then
    return true
  end
  local nextRooms = currentRoom:GetNextRoom()
  return table.contain(nextRooms, roomData)
end

function ExplorationPlayerCtrl:CheckIsEpRoomWatchingMap(roomData)
  local currentRoom = self:GetCurrentRoomData(true)
  if currentRoom == roomData then
    MsgCenter:Broadcast(eMsgEventId.OnShowingMapRoomClick)
    return true
  end
  return false
end

function ExplorationPlayerCtrl:CheckHasSpBattleRewardEpRoom()
  local currentRoom = self:GetCurrentRoomData(true)
  if currentRoom:IsRoomHasSpbattleReward() == true then
    return true
  end
  return false
end

function ExplorationPlayerCtrl:GetCurrentRoomData(withoutSpecialRoom)
  local mapData = self.epCtrl.mapData
  local opDetail = self.dynPlayer:GetOperatorDetail()
  local currentRoom
  if not withoutSpecialRoom and opDetail.specialCat > 0 then
    currentRoom = mapData:GetEpSpecialRoomData()
  else
    currentRoom = mapData:GetRoomByCoord(opDetail.curPostion)
  end
  return currentRoom
end

function ExplorationPlayerCtrl:UpdateEpOp(epOp)
  self.dynPlayer:UpdateOperatorDetail(epOp)
end

function ExplorationPlayerCtrl:OnEpOperatorDiff(epOp)
  MsgCenter:Broadcast(eMsgEventId.OnEpOpStateChanged, self.dynPlayer:GetOperatorDetail())
  self:UpdEpRoomDataByEpOp(self.dynPlayer:GetOperatorDetail())
  if epOp.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_DropAlg then
    if not ExplorationManager:IsInExplorationLight() and not ExplorationManager:IsInGuardExp() and not self:CheckHasSpBattleRewardEpRoom() then
      self.epCtrl:DiscardChip()
    end
  elseif epOp.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Secleted then
    local isInBattleSceen = self.epCtrl.sceneCtrl:InBattleScene()
    if not isInBattleSceen then
      local currentRoom = self:GetCurrentRoomData()
      if currentRoom.jumpCat ~= nil and currentRoom.jumpCat > 0 and self.dynPlayer.playerClientState == ExplorationEnum.ePlayerClientState.InRoom then
        self.epCtrl.eventCtrl:JumpEpEventRoomComplete()
        self.epCtrl:OnPlayerMoveComplete(currentRoom)
      end
    end
  elseif epOp.state == proto_object_ExplorationCurGridState.ExplorationCurGridStateReplaceChip then
    self.epCtrl:OpenChipReplace()
  elseif epOp.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_QuestSelect then
    local isInBattleSceen = self.epCtrl.sceneCtrl:InBattleScene()
    if not isInBattleSceen then
      self.epCtrl:OpenEpTask()
    end
  elseif epOp.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_OpeningBuffSelect then
    local isInBattleSceen = self.epCtrl.sceneCtrl:InBattleScene()
    if not isInBattleSceen then
      self.epCtrl:TryShowBuffSelect()
    end
  end
end

function ExplorationPlayerCtrl:UpdEpRoomDataByEpOp(opDetail)
  local curRoomData = self:GetCurrentRoomData()
  curRoomData:SetEpRoomEpOpStateChanged(opDetail)
  if opDetail.deco then
    if self.dynPlayer ~= nil then
      if opDetail.deco[1] then
        self.dynPlayer:UpdateEpSaveMoneyList(opDetail.deco[1].arrParams)
      else
        self.dynPlayer:UpdateEpSaveMoneyList()
      end
      if opDetail.deco[2] then
        self.dynPlayer:UpdateEpBattleSkillLockDic(opDetail.deco[2].mapParams)
      else
        self.dynPlayer:UpdateEpBattleSkillLockDic()
      end
    end
  else
    self.dynPlayer:UpdateEpSaveMoneyList()
    self.dynPlayer:UpdateEpBattleSkillLockDic()
  end
  self.epCtrl.mapData:ClearPassedRoomData(opDetail, curRoomData)
  if opDetail.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    local playerPower = self.dynPlayer:GetCacheFightPower()
    self.nextRoomList = curRoomData:GetNextRoom()
    for k, tmpRoomData in pairs(self.nextRoomList) do
      if self.epCtrl.mapCtrl ~= nil then
        self.epCtrl.mapCtrl:ShowFightingPower(tmpRoomData, playerPower)
      end
      local visible = tmpRoomData:GetVisible()
      if visible == false then
        tmpRoomData:SetVisible(true)
        if self.epCtrl.mapCtrl ~= nil then
          self.epCtrl.mapCtrl:RefreshRoomVisible(tmpRoomData)
        end
      end
    end
    if self.epCtrl.mapCtrl ~= nil then
      self.epCtrl.mapCtrl:RefreshNightBattleView(curRoomData)
      self.epCtrl.mapCtrl:UpdateViewRangeLine()
    end
    if opDetail.deco and opDetail.deco[1] then
      MsgCenter:Broadcast(eMsgEventId.EpSaveMoneyChange)
    end
  end
end

function ExplorationPlayerCtrl:OnEpFormationDetailDiff(epForm)
  self.dynPlayer:UpdateFormationDetail(epForm)
end

function ExplorationPlayerCtrl:OnEpBackpackDiff(epBackpack)
  self.dynPlayer:UpdateEpBackpack(epBackpack)
end

function ExplorationPlayerCtrl:OnEpBuffDiff(epBuff)
  self.dynPlayer:UpdateEpBuff(epBuff)
end

function ExplorationPlayerCtrl:OnChipDataDiff(diffData)
  local chipDiff = diffData[proto_csmsg_AlgModule.AlgModuleExploration]
  if chipDiff ~= nil then
    self.dynPlayer:UpdateChipDiff(chipDiff)
    if BattleUtil.IsInGuardBattle() then
      local roomData = self:GetCurrentRoomData()
      if roomData ~= nil then
        roomData:ExecuteDungeonRoleChip(self.dynPlayer)
      end
    end
  end
end

function ExplorationPlayerCtrl:OnSpecEffectDiff(diffData)
  local effectDiff = diffData[proto_csmsg_EffectModule.EffectModuleExploration]
  if effectDiff ~= nil then
    self.dynPlayer:UpdateDynSpecEffect(effectDiff)
  end
end

function ExplorationPlayerCtrl:OnEpServerGridDiff(epBattleGrid)
  self.dynPlayer:UpdateAllDynServerGrid(epBattleGrid)
end

function ExplorationPlayerCtrl:OnEpRewardBagDiff(epStmGoods)
  self.dynPlayer.dynRewardBag:UpdateEpDynRewardBag(epStmGoods)
end

function ExplorationPlayerCtrl:OnEpCommonDataDiff(epCommon)
  local freeChoose = self.dynPlayer:GetEpUnlimitChooseRoom()
  self.dynPlayer:UpdateEpCommonData(epCommon)
  local afterFreeChoose = self.dynPlayer:GetEpUnlimitChooseRoom()
  if freeChoose ~= afterFreeChoose then
    local curRoomData = self.epCtrl:GetCurrentRoomData(true)
    self.epCtrl.mapCtrl:RefreshMapShowState(self.dynPlayer:GetOperatorDetail(), curRoomData)
  end
end

function ExplorationPlayerCtrl:OnWcEpScoreChange(epWCscore)
  self.dynPlayer:UpdateWcCurrentScore(epWCscore)
end

function ExplorationPlayerCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnRoomSelected, self.__onRoomSelected)
  MsgCenter:RemoveListener(eMsgEventId.OnEpOpStore, self.__onEpOperatorUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnEpOperatorDiff, self.__onEpOperatorDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnEpFormationDetailDiff, self.__onEpFormDetailDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnEpBackpackDiff, self.__onEpBackpackDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffDiff, self.__OnEpBuffDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnExitRoomComplete, self.__OnExitRoomComplete)
  MsgCenter:RemoveListener(eMsgEventId.OnChipDataDiff, self.__OnChipDataDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnEpServerGridDiff, self.__OnEpServerGridDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnEpRewardBagDiff, self.__OnEpRewardBagDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnEpCommonDataDiff, self.__OnEpCommonDataDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnWCEpScoreChange, self.__OnWcEpScoreChange)
  MsgCenter:RemoveListener(eMsgEventId.OnWCEpScoreChange, self.__OnSpecEffectDiff)
end

return ExplorationPlayerCtrl
