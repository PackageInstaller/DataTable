local ExplorationNetworkCtrl = class("ExplorationNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local EpActCheckCmdTimelinessFunc = require("Game.Exploration.EpActCheckCmdTimelinessFunc")
local NetworkQueueData = require("Framework.Network.NetworkQueueData")
local NetworkQueueDataPool = CommonPool.New(function()
  return NetworkQueueData.New()
end, function(p)
  p:ResetNetworkQueueData()
  return true
end)
local LastSendType = {Select = 1, NextFloor = 2}
local cacheActionType = {StartBattle = 1, BattleSettle = 2}

function ExplorationNetworkCtrl:ctor()
  self.epSendStartData = {
    formInfo = {}
  }
  self.epSelectData = {}
  self.nextFloorData = {}
  self.settleData = {}
  self.algSelectData = {}
  self.residentStoreData = {}
  self.residentStoreLockTab = {}
  self.refreshFormationData = {}
  self.lastSendDataList = {}
  self.sendOverclockBuy = {}
  self.epAlgSoldTab = {}
  self.cacheAction = {}
  self.weeklyBattle = {}
  self.weeklyBattleSelectDebuff = {}
  self.selectTaskTable = {}
  self.cstChangeTable = {}
  self.weekScorePreTab = {}
  self._openinBuffSelectTab = {}
  self._reqDetailTable = {}
  self._recordRestartBattleTable = {}
  self._queue_HeroFmtDetail = {}
end

function ExplorationNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Start, self, proto_csmsg.SC_EXPLORATION_Start, self.SC_EXPLORATION_Start)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SyncUpdateDiff, self, proto_csmsg.SC_EXPLORATION_SyncUpdateDiff, self.SC_EXPLORATION_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Select, self, proto_csmsg.SC_EXPLORATION_Select, self.SC_EXPLORATION_Select)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_NextFloor, self, proto_csmsg.SC_EXPLORATION_NextFloor, self.SC_EXPLORATION_NextFloor)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Settle, self, proto_csmsg.SC_EXPLORATION_Settle, self.SC_EXPLORATION_Settle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_ALGSelect, self, proto_csmsg.SC_EXPLORATION_BATTLE_ALGSelect, self.SC_EXPLORATION_BATTLE_ALGSelect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_RefreshAlg, self, proto_csmsg.SC_EXPLORATION_BATTLE_RefreshAlg, self.SC_EXPLORATION_BATTLE_RefreshAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Detail, self, proto_csmsg.SC_EXPLORATION_Detail, self.SC_EXPLORATION_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_Purchase, self, proto_csmsg.SC_EXPLORATION_RESIDENT_STORE_Purchase, self.SC_EXPLORATION_RESIDENT_STORE_Purchase)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Start, self, proto_csmsg.SC_EXPLORATION_BATTLE_Start, self.SC_EXPLORATION_BATTLE_Start)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Restart, self, proto_csmsg.SC_EXPLORATION_BATTLE_Restart, self.SC_EXPLORATION_BATTLE_Restart)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Settle, self, proto_csmsg.SC_EXPLORATION_BATTLE_Settle, self.SC_EXPLORATION_BATTLE_Settle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_FreshFromation, self, proto_csmsg.SC_EXPLORATION_FreshFromation, self.SC_EXPLORATION_FreshFromation)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_NtfServerEnter, self, proto_csmsg.SC_EXPLORATION_NtfServerEnter, self.SC_EXPLORATION_NtfServerEnter)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Focus, self, proto_csmsg.SC_EXPLORATION_BATTLE_Focus, self.SC_EXPLORATION_BATTLE_Focus)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Ambush, self, proto_csmsg.SC_EXPLORATION_BATTLE_Ambush, self.SC_EXPLORATION_BATTLE_Ambush)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Stealth, self, proto_csmsg.SC_EXPLORATION_BATTLE_Stealth, self.SC_EXPLORATION_BATTLE_Stealth)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SettleFloor, self, proto_csmsg.SC_EXPLORATION_SettleFloor, self.SC_EXPLORATION_SettleFloor)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_Sold, self, proto_csmsg.SC_EXPLORATION_AlgUpperLimit_Sold, self.SC_EXPLORATION_AlgUpperLimit_Sold)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_Exit, self, proto_csmsg.SC_EXPLORATION_AlgUpperLimit_Exit, self.SC_EXPLORATION_AlgUpperLimit_Exit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_PurchaseLimit, self, proto_csmsg.SC_EXPLORATION_AlgUpperLimit_PurchaseLimit, self.SC_EXPLORATION_AlgUpperLimit_PurchaseLimit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RewardsShow, self, proto_csmsg.SC_EXPLORATION_RewardsShow, self.SC_EXPLORATION_RewardsShow)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_CAMP_FETTER_USE, self, proto_csmsg.SC_EXPLORATION_CAMP_FETTER_USE, self.SC_EXPLORATION_CAMP_FETTER_USE)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_ReplaceAlg, self, proto_csmsg.SC_EXPLORATION_EVENT_ReplaceAlg, self.SC_EXPLORATION_EVENT_ReplaceAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_ReplaceExit, self, proto_csmsg.SC_EXPLORATION_EVENT_ReplaceExit, self.SC_EXPLORATION_EVENT_ReplaceExit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_GiveUpAlg, self, proto_csmsg.SC_EXPLORATION_BATTLE_GiveUpAlg, self.SC_EXPLORATION_BATTLE_GiveUpAlg)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_OVERCLOCK_BUY, self, proto_csmsg.SC_EXPLORATION_OVERCLOCK_BUY, self.SC_EXPLORATION_OVERCLOCK_BUY)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Alg_Sold, self, proto_csmsg.SC_EXPLORATION_Alg_Sold, self.SC_EXPLORATION_Alg_Sold)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_Refresh, self, proto_csmsg.SC_EXPLORATION_RESIDENT_STORE_Refresh, self.SC_EXPLORATION_RESIDENT_STORE_Refresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_PurchaseExp, self, proto_csmsg.SC_EXPLORATION_RESIDENT_STORE_PurchaseExp, self.SC_EXPLORATION_RESIDENT_STORE_PurchaseExp)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_LockUnlock, self, proto_csmsg.SC_EXPLORATION_RESIDENT_STORE_LockUnlock, self.SC_EXPLORATION_RESIDENT_STORE_LockUnlock)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SnapshotRollback, self, proto_csmsg.SC_EXPLORATION_SnapshotRollback, self.SC_EXPLORATION_SnapshotRollback)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_Start, self, proto_csmsg.SC_WEEKLYCHALLENGE_Start, self.SC_WEEKLYCHALLENGE_Start)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_Start, self, proto_csmsg.SC_DAILYCHALLENGE_Start, self.SC_DAILYCHALLENGE_Start)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_SelectBuff, self, proto_csmsg.SC_WEEKLYCHALLENGE_SelectBuff, self.SC_WEEKLYCHALLENGE_SelectBuff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_SelectBuffExit, self, proto_csmsg.SC_WEEKLYCHALLENGE_SelectBuffExit, self.SC_WEEKLYCHALLENGE_SelectBuffExit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_ScorePreview, self, proto_csmsg.SC_WEEKLYCHALLENGE_ScorePreview, self.SC_WEEKLYCHALLENGE_ScorePreview)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_QuestSelect, self, proto_csmsg.SC_EXPLORATION_QuestSelect, self.SC_EXPLORATION_QuestSelect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_QuestExit, self, proto_csmsg.SC_EXPLORATION_QuestExit, self.SC_EXPLORATION_QuestExit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_QuestDrop, self, proto_csmsg.SC_EXPLORATION_QuestDrop, self.SC_EXPLORATION_QuestDrop)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_RefreshCommandSkillTree, self, proto_csmsg.SC_EXPLORATION_BATTLE_RefreshCommandSkillTree, self.SC_EXPLORATION_BATTLE_RefreshCommandSkillTree)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_FixedHeroNtf, self, proto_csmsg.SC_EXPLORATION_FixedHeroNtf, self.SC_EXPLORATION_FixedHeroNtf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EX_OVER, self, proto_csmsg.SC_EXPLORATION_EX_OVER, self.SC_EXPLORATION_EX_OVER)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_OpeninBuffSelect, self, proto_csmsg.SC_EXPLORATION_OpeninBuffSelect, self.SC_EXPLORATION_OpeninBuffSelect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RecordRestartBattle, self, proto_csmsg.SC_EXPLORATION_RecordRestartBattle, self.SC_EXPLORATION_RecordRestartBattle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_HERO_FormationFresh, self, proto_csmsg.SC_EXPLORATION_HERO_FormationFresh, self.SC_EXPLORATION_HERO_FormationFresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_HERO_Formation_Detail, self, proto_csmsg.SC_EXPLORATION_HERO_Formation_Detail, self.SC_EXPLORATION_HERO_Formation_Detail)
end

function ExplorationNetworkCtrl:CS_EXPLORATION_Start(dungeonId, formId, moduleId, ezMode, callBack, support, challengeMode, challengeTaskIdList, starting, substitute, selectBuffIds, isQiutMode, epInifinityData, isEnvBuff, reinforceCardData)
  self.epSendStartData.dungeonId = dungeonId
  self.epSendStartData.formInfo.formationId = formId
  self.epSendStartData.formInfo.support = support
  self.epSendStartData.moduleId = moduleId or proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration
  self.epSendStartData.ezMode = ezMode
  self.epSendStartData.challengeMode = challengeMode
  self.epSendStartData.challengeQuests = challengeTaskIdList
  if epInifinityData == nil then
    local fmtData = PlayerDataCenter.formationDic[formId]
    local officeAssist
    if fmtData == nil then
      if formId ~= nil then
        error("fmtData == nil, formId:" .. tostring(formId))
      end
    else
      officeAssist = fmtData:GetFmtOfficeAssistData()
    end
    self.epSendStartData.assist = officeAssist
  end
  starting = starting or 0
  if starting < 0 then
    error("starting power low then 0, starting:" .. tostring(starting))
  end
  substitute = substitute or 0
  if substitute < 0 then
    error("substitute power low then 0, substitute:" .. tostring(substitute))
  end
  self.epSendStartData.starting = starting
  self.epSendStartData.substitute = substitute
  self.epSendStartData.buffGroup = {}
  self.epSendStartData.exEnvbuffIds = {}
  if selectBuffIds ~= nil then
    if isEnvBuff then
      for i, v in ipairs(selectBuffIds) do
        table.insert(self.epSendStartData.exEnvbuffIds, v)
      end
    else
      for i, v in ipairs(selectBuffIds) do
        self.epSendStartData.buffGroup[v] = true
      end
    end
  end
  self.epSendStartData.qiutMode = isQiutMode or false
  self.epSendStartData.exEnvHeroGroup = nil
  self.epSendStartData.commandTrees = nil
  self.epSendStartData.tree = nil
  if epInifinityData ~= nil then
    self.epSendStartData.exEnvHeroGroup = epInifinityData.epInifinityEnvID
    self.epSendStartData.commandTrees = epInifinityData.cstDataList
    self.epSendStartData.tree = epInifinityData.tree
    self.epSendStartData.assist = nil
  end
  self.epSendStartData.reinforceCardId = nil
  self.epSendStartData.reinforceDiffId = nil
  self.epSendStartData.factorCardId = nil
  self.epSendStartData.highExploration = nil
  if reinforceCardData ~= nil then
    self.epSendStartData.reinforceCardId = reinforceCardData.reinforceCardId
    self.epSendStartData.reinforceDiffId = reinforceCardData.reinforceDiffId
    self.epSendStartData.factorCardId = reinforceCardData.factorCardId
    self.epSendStartData.highExploration = reinforceCardData.highExploration
    self.epSendStartData.friendfactorCardId = reinforceCardData.supportfacCardUID
    self.epSendStartData.layerLevel = reinforceCardData.layerLevel
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Start, proto_csmsg.CS_EXPLORATION_Start, self.epSendStartData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Start, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Start)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_Start(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_Start error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Start)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Start, msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ExplorationNetworkCtrl:CS_DAILYCHALLENGE_Start(fomationId, callback)
  local msg = {formId = fomationId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Start, proto_csmsg.CS_DAILYCHALLENGE_Start, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Start, callback, proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_Start)
end

function ExplorationNetworkCtrl:SC_DAILYCHALLENGE_Start(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    ExplorationManager:RecvEnterExploration(msg.explorationStart)
  else
    local err = "SC_DAILYCHALLENGE_Detail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_Start)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ExplorationNetworkCtrl:CS_WEEKLYCHALLENGE_Start(id, buffIds, heroPos, cstSavingData, starting, substitute)
  self.weeklyBattle.id = id
  self.weeklyBattle.buffGroup = {}
  for i, v in ipairs(buffIds) do
    self.weeklyBattle.buffGroup[v] = true
  end
  self.weeklyBattle.form = {heroGroup = heroPos, cst = cstSavingData}
  self.weeklyBattle.starting = starting
  self.weeklyBattle.substitute = substitute
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_Start, proto_csmsg.CS_WEEKLYCHALLENGE_Start, self.weeklyBattle)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_Start, proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_Start)
end

function ExplorationNetworkCtrl:SC_WEEKLYCHALLENGE_Start(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    ExplorationManager:RecvEnterExploration(msg.explorationStart)
  else
    local err = "SC_WEEKLYCHALLENGE_Start error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_Start)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_SyncUpdateDiff(msg)
  local isLastNextFloor = #self.lastSendDataList > 0 and self.lastSendDataList[1].type == LastSendType.NextFloor
  local lastData
  if #self.lastSendDataList > 0 then
    lastData = table.remove(self.lastSendDataList, 1)
  end
  if lastData ~= nil and lastData.type ~= LastSendType.NextFloor and msg.epMap ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpMapDiff, msg.epMap)
  end
  if msg.epOp ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpOpStore, msg.epOp)
  end
  if msg.epBuff ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpBuffDiff, msg.epBuff)
  end
  if msg.epRoleDyc ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpFormationDetailDiff, msg.epRoleDyc)
  end
  if msg.epBackpack ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpBackpackDiff, msg.epBackpack)
  end
  if msg.epResident ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpResidentDiff, msg.epResident)
  end
  if msg.epBattleGrid ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpServerGridDiff, msg.epBattleGrid)
  end
  if msg.epClock ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpOverclockDiff, msg.epClock)
  end
  if msg.epCommon ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpCommonDataDiff, msg.epCommon)
  end
  if not isLastNextFloor and msg.epGrid ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpGridDetailDiff, msg.epGrid, msg.epOp)
  end
  if 0 < #msg.epStmGoods then
    MsgCenter:Broadcast(eMsgEventId.OnEpRewardBagDiff, msg.epStmGoods)
  end
  if msg.epOp ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnEpOperatorDiff, msg.epOp)
  end
  if msg.epWCscore ~= nil then
    MsgCenter:Broadcast(eMsgEventId.OnWCEpScoreChange, msg.epWCscore)
  end
  if lastData ~= nil then
    if lastData.type == LastSendType.Select then
      if msg.epOp ~= nil then
        MsgCenter:Broadcast(eMsgEventId.OnRoomSelected)
      end
    elseif lastData.type == LastSendType.NextFloor then
      ExplorationManager:OnEnterNextSectionExploration(msg)
    end
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_Select(position)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self.epSelectData.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Select, proto_csmsg.CS_EXPLORATION_Select, self.epSelectData)
  local saveList = {}
  saveList.type = LastSendType.Select
  table.insert(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Select, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Select)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_Select(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if isGameDev then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.exploration_SelectRoomFailure) .. tostring(msg.ret))
    end
    error("SC_EXPLORATION_Select，error：" .. tostring(msg.ret))
    table.remove(self.lastSendDataList, 1)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Select)
    return
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_NextFloor(briefId)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self.nextFloorData.id = briefId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NextFloor, proto_csmsg.CS_EXPLORATION_NextFloor, self.nextFloorData)
  local saveList = {}
  saveList.type = LastSendType.NextFloor
  table.insert(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NextFloor, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_NextFloor)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_NextFloor(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_NextFloor error：" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    table.remove(self.lastSendDataList, 1)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NextFloor)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ExplorationNetworkCtrl:CS_EXPLORATION_Settle(position, isAutoSettle, isGiveUpLastEp, costumeStm, mvpHeroId, pickInfo, refreshLastEp, suitLevelMap, callBack)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self.__isAutoSettle = isAutoSettle
  self.__isGiveUpLastEp = isGiveUpLastEp
  self.__refreshLastEp = refreshLastEp
  self.settleData.position = position
  self.settleData.costumeStm = costumeStm or false
  self.settleData.mvpHero = mvpHeroId
  self.settleData.pickInfo = pickInfo
  self.settleData.funcSuit = suitLevelMap
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Settle, proto_csmsg.CS_EXPLORATION_Settle, self.settleData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Settle, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Settle)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_Settle(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.syncUpdateDiff ~= nil and msg.syncUpdateDiff.resource ~= nil and msg.syncUpdateDiff.resource.backpack ~= nil then
    local randomPackage = msg.syncUpdateDiff.resource.backpack.randomPackage
    if randomPackage ~= nil then
      for parentItemId, data in pairs(randomPackage) do
        msg.rewards.rewards[parentItemId] = (msg.rewards.rewards[parentItemId] or 0) - data.itemNum
        if msg.rewards.rewards[parentItemId] <= 0 then
          msg.rewards.rewards[parentItemId] = nil
        end
        local resultDic = data.product
        for itemId, num in pairs(resultDic) do
          msg.rewards.rewards[itemId] = (msg.rewards.rewards[itemId] or 0) + num
        end
      end
    end
    local overflow = msg.syncUpdateDiff.resource.backpack.overflow
    if overflow ~= nil then
      msg.overflowRewardTurnInfo = overflow
    end
  end
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_Settle error：" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Settle)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Settle, msg)
  if self.__isAutoSettle or self.__isGiveUpLastEp or self.__refreshLastEp then
    self:CS_EXPLORATION_Detail()
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_SettleFloor(position, callBack)
  if not self:__CheckCmdTimeliness() then
    return
  end
  local sendMsg = {position = position}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_SettleFloor, proto_csmsg.CS_EXPLORATION_SettleFloor, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_SettleFloor, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SettleFloor)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_SettleFloor(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_SettleFloor error：" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_SettleFloor)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_SettleFloor, msg)
end

function ExplorationNetworkCtrl:CS_EXPLORATION_BATTLE_ALGSelect(position, rewardIndex, callBack)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self.algSelectData.position = position
  self.algSelectData.idx = rewardIndex
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_ALGSelect, proto_csmsg.CS_EXPLORATION_BATTLE_ALGSelect, self.algSelectData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_ALGSelect, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_ALGSelect)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_BATTLE_ALGSelect(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_BATTLE_ALGSelect error：" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_ALGSelect)
    return
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_BATTLE_RefreshAlg(idxList, callBack)
  if not self:__CheckCmdTimeliness() then
    return
  end
  local sendMsg = {locked = idxList}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_RefreshAlg, proto_csmsg.CS_EXPLORATION_BATTLE_RefreshAlg, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_RefreshAlg, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_RefreshAlg)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_BATTLE_RefreshAlg(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_BATTLE_RefreshAlg error：" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_RefreshAlg)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_SnapshotRollback(callBack)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_SnapshotRollback, proto_csmsg.CS_EXPLORATION_SnapshotRollback, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_SnapshotRollback, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_SnapshotRollback)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_SnapshotRollback(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.EXPLORATION_ROLLBACK_IN_CD then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(199))
    else
      local err = "SC_EXPLORATION_SnapshotRollback error：" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_SnapshotRollback)
    return
  end
  ExplorationManager:OnRestartEpFloor(msg.detail)
end

function ExplorationNetworkCtrl:CS_EXPLORATION_Detail(actLongId)
  self._reqDetailTable.actLongId = actLongId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Detail, proto_csmsg.CS_EXPLORATION_Detail, self._reqDetailTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Detail, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Detail)
end

function ExplorationNetworkCtrl:CS_EXPLORATION_Detail_NoWait()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Detail, proto_csmsg.CS_EXPLORATION_Detail, table.emptytable)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_Detail(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  ExplorationManager:RecordLastEpData(msg.detail)
end

function ExplorationNetworkCtrl:CS_EXPLORATION_NtfServerEnter(callBack)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NtfServerEnter, proto_csmsg.CS_EXPLORATION_NtfServerEnter, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NtfServerEnter, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_NtfServerEnter)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_NtfServerEnter(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_NtfServerEnter error：" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_NtfServerEnter)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_Alg_Sold(id, callBack)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self.epAlgSoldTab.id = id
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Alg_Sold, proto_csmsg.CS_EXPLORATION_Alg_Sold, self.epAlgSoldTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Alg_Sold, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_Alg_Sold)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_Alg_Sold(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_Alg_Sold error：" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_Alg_Sold)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_RESIDENT_STORE_Refresh(callBack)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Refresh, proto_csmsg.CS_EXPLORATION_RESIDENT_STORE_Refresh, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Refresh, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_Refresh)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_RESIDENT_STORE_Refresh(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_RESIDENT_STORE_Refresh error：" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Refresh)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_RESIDENT_STORE_PurchaseExp(callBack)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_PurchaseExp, proto_csmsg.CS_EXPLORATION_RESIDENT_STORE_PurchaseExp, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_PurchaseExp, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_PurchaseExp)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_RESIDENT_STORE_PurchaseExp(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_RESIDENT_STORE_PurchaseExp error：" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_PurchaseExp)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_RESIDENT_STORE_Purchase(idx, callBack)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self.residentStoreData.idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Purchase, proto_csmsg.CS_EXPLORATION_RESIDENT_STORE_Purchase, self.residentStoreData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Purchase, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_Purchase)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_RESIDENT_STORE_Purchase(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_RESIDENT_STORE_Purchase error：" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_Purchase)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_RESIDENT_STORE_LockUnlock(idx, callBack)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self.residentStoreLockTab.idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_LockUnlock, proto_csmsg.CS_EXPLORATION_RESIDENT_STORE_LockUnlock, self.residentStoreLockTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_LockUnlock, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RESIDENT_STORE_LockUnlock)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_RESIDENT_STORE_LockUnlock(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_RESIDENT_STORE_LockUnlock error：" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RESIDENT_STORE_LockUnlock)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_BATTLE_Start(sendMsg, action)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Start, proto_csmsg.CS_EXPLORATION_BATTLE_Start, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Start, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Start)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_BATTLE_Start(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.HERO_FORMATION_LENGTH_LIMIT then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(59027))
    end
    local err = "SC_EXPLORATION_BATTLE_Start" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Start)
  else
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Start, msg)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_BATTLE_Restart(action)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Restart, proto_csmsg.CS_EXPLORATION_BATTLE_Restart, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Restart, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Restart)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_BATTLE_Restart(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_BATTLE_Restart error：" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Restart)
  end
  if msg.data ~= nil then
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Restart, msg.data)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_BATTLE_Settle(sendMsg, action)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Settle, proto_csmsg.CS_EXPLORATION_BATTLE_Settle, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Settle, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Settle)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_BATTLE_Settle(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if ExplorationManager:IsInExploration() then
    ExplorationManager.dynPlayer:SetDropActiveAlg(msg.dropActiveAlg)
  end
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_BATTLE_Settle" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Settle)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Settle, msg)
end

function ExplorationNetworkCtrl:CS_EXPLORATION_FreshFromation(posDic)
  self.refreshFormationData.data = posDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_FreshFromation, proto_csmsg.CS_EXPLORATION_FreshFromation, self.refreshFormationData)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_FreshFromation(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "EXPLORATION_FreshFromation，error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_BATTLE_Focus(pos, isAmbush, callBack)
  local msg = {}
  msg.position = pos
  msg.ambush = isAmbush
  self.rejudgeCallback = callBack
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Focus, proto_csmsg.CS_EXPLORATION_BATTLE_Focus, msg)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_BATTLE_Focus(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "EXPLORATION rejudge error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  elseif self.rejudgeCallback ~= nil then
    self.rejudgeCallback(msg.value)
    self.rejudgeCallback = nil
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_BATTLE_Ambush(sendMsg, action)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Ambush, proto_csmsg.CS_EXPLORATION_BATTLE_Ambush, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Ambush, action, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Ambush)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_BATTLE_Ambush(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_BATTLE_Ambush" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Ambush)
  else
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Ambush, msg)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_BATTLE_Stealth(position)
  local msg = {}
  msg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Stealth, proto_csmsg.CS_EXPLORATION_BATTLE_Stealth, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Stealth, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_Stealth)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_BATTLE_Stealth(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "Exploration stealth error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_Stealth)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_AlgUpperLimit_Sold(position, chipId, callback)
  if not self:__CheckCmdTimeliness() then
    return
  end
  local msg = {}
  msg.position = position
  msg.algId = chipId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Sold, proto_csmsg.CS_EXPLORATION_AlgUpperLimit_Sold, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Sold, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_Sold)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_AlgUpperLimit_Sold(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_AlgUpperLimit_Sold error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Sold)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_AlgUpperLimit_PurchaseLimit(position)
  if not self:__CheckCmdTimeliness() then
    return
  end
  local msg = {}
  msg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_PurchaseLimit, proto_csmsg.CS_EXPLORATION_AlgUpperLimit_PurchaseLimit, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_PurchaseLimit, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_PurchaseLimit)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_AlgUpperLimit_PurchaseLimit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_AlgUpperLimit_PurchaseLimit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_PurchaseLimit)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_AlgUpperLimit_Exit(position, callBack)
  if not self:__CheckCmdTimeliness() then
    return
  end
  local msg = {}
  msg.position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Exit, proto_csmsg.CS_EXPLORATION_AlgUpperLimit_Exit, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Exit, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_AlgUpperLimit_Exit)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_AlgUpperLimit_Exit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_AlgUpperLimit_Sold error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_AlgUpperLimit_Exit)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_CAMP_FETTER_USE(uid, callback)
  local msg = {}
  msg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_CAMP_FETTER_USE, proto_csmsg.CS_EXPLORATION_CAMP_FETTER_USE, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_CAMP_FETTER_USE, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_CAMP_FETTER_USE)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_CAMP_FETTER_USE(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_EXPLORATION_CAMP_FETTER_USE error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_CAMP_FETTER_USE)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_RewardsShow(callBack)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RewardsShow, proto_csmsg.CS_EXPLORATION_RewardsShow, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RewardsShow, callBack, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RewardsShow)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_RewardsShow(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "CS_EXPLORATION_RewardsShow error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RewardsShow)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RewardsShow, msg)
end

function ExplorationNetworkCtrl:CS_EXPLORATION_EVENT_ReplaceAlg(position, algId, callback)
  if not self:__CheckCmdTimeliness() then
    return
  end
  local data = {postion = position, algId = algId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_ReplaceAlg, proto_csmsg.CS_EXPLORATION_EVENT_ReplaceAlg, data)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_ReplaceAlg, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_ReplaceAlg)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_EVENT_ReplaceAlg(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.EXPLORATION_CANT_REPLACE_RAINBOWBUFF then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(767))
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_ReplaceAlg)
      return
    end
    local err = "MSG_SC_EXPLORATION_EVENT_ReplaceAlg error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_EVENT_ReplaceExit(position, callback)
  if not self:__CheckCmdTimeliness() then
    return
  end
  local data = {position = position}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_ReplaceExit, proto_csmsg.CS_EXPLORATION_EVENT_ReplaceExit, data)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EVENT_ReplaceExit, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EVENT_ReplaceExit)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_EVENT_ReplaceExit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "MSG_SC_EXPLORATION_EVENT_ReplaceExit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_BATTLE_GiveUpAlg(callback)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_GiveUpAlg, proto_csmsg.CS_EXPLORATION_BATTLE_GiveUpAlg, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_GiveUpAlg, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_GiveUpAlg)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_BATTLE_GiveUpAlg(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "MSG_SC_EXPLORATION_BATTLE_GiveUpAlg error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_GiveUpAlg)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_OVERCLOCK_BUY(clockId, level, param)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self.sendOverclockBuy.id = clockId
  self.sendOverclockBuy.level = level
  self.sendOverclockBuy.param = param
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_OVERCLOCK_BUY, proto_csmsg.CS_EXPLORATION_OVERCLOCK_BUY, self.sendOverclockBuy)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_OVERCLOCK_BUY, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_OVERCLOCK_BUY)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_OVERCLOCK_BUY(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_EXPLORATION_OVERCLOCK_BUY error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_OVERCLOCK_BUY)
  else
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.OverlockSuccess))
    AudioManager:PlayAudioById(1076)
  end
end

function ExplorationNetworkCtrl:CS_WEEKLYCHALLENGE_SelectBuff(buff, callback)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self.weeklyBattleSelectDebuff.buff = buff
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_SelectBuff, proto_csmsg.CS_WEEKLYCHALLENGE_SelectBuff, self.weeklyBattleSelectDebuff)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_SelectBuff, callback, proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_SelectBuff)
end

function ExplorationNetworkCtrl:SC_WEEKLYCHALLENGE_SelectBuff(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_WEEKLYCHALLENGE_SelectBuff error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_SelectBuff)
  end
end

function ExplorationNetworkCtrl:CS_WEEKLYCHALLENGE_SelectBuffExit(callback)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_SelectBuffExit, proto_csmsg.CS_WEEKLYCHALLENGE_SelectBuffExit, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_SelectBuffExit, callback, proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_SelectBuffExit)
end

function ExplorationNetworkCtrl:SC_WEEKLYCHALLENGE_SelectBuffExit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_WEEKLYCHALLENGE_SelectBuffExit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_SelectBuffExit)
  end
end

function ExplorationNetworkCtrl:CS_WEEKLYCHALLENGE_ScorePreview(valid, tdHpPerDic, callback)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self.weekScorePreTab.valid = valid
  self.weekScorePreTab.tdHpPer = tdHpPerDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_ScorePreview, proto_csmsg.CS_WEEKLYCHALLENGE_ScorePreview, self.weekScorePreTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_ScorePreview, callback, proto_csmsg_MSG_ID.MSG_SC_WEEKLYCHALLENGE_ScorePreview)
end

function ExplorationNetworkCtrl:SC_WEEKLYCHALLENGE_ScorePreview(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_WEEKLYCHALLENGE_ScorePreview error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_ScorePreview)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_WEEKLYCHALLENGE_ScorePreview, msg)
end

function ExplorationNetworkCtrl:CS_EXPLORATION_QuestSelect(questId, callback)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self.selectTaskTable.questId = questId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_QuestSelect, proto_csmsg.CS_EXPLORATION_QuestSelect, self.selectTaskTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_QuestSelect, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_QuestSelect)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_QuestSelect(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_EXPLORATION_QuestSelect error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_QuestSelect)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_QuestExit(callback)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_QuestExit, proto_csmsg.CS_EXPLORATION_QuestExit, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_QuestExit, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_QuestExit)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_QuestExit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_EXPLORATION_QuestExit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_QuestExit)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_QuestDrop()
  if not self:__CheckCmdTimeliness() then
    return
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_QuestDrop, proto_csmsg.CS_EXPLORATION_QuestDrop, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_QuestDrop, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_QuestDrop)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_QuestDrop(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_EXPLORATION_QuestDrop error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_QuestDrop)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_BATTLE_RefreshCommandSkillTree(msgDic, selectedTreeId, callback)
  if not self:__CheckCmdTimeliness() then
    return
  end
  self.cstChangeTable.commandTrees = msgDic
  self.cstChangeTable.tree = selectedTreeId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_RefreshCommandSkillTree, proto_csmsg.CS_EXPLORATION_BATTLE_RefreshCommandSkillTree, self.cstChangeTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_RefreshCommandSkillTree, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_BATTLE_RefreshCommandSkillTree)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_BATTLE_RefreshCommandSkillTree(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_EXPLORATION_BATTLE_RefreshCommandSkillTree error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_BATTLE_RefreshCommandSkillTree)
  end
end

function ExplorationNetworkCtrl:__CheckCmdTimeliness()
  if ExplorationManager ~= nil and ExplorationManager:IsInExploration() then
    if ExplorationManager.moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
      local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
      local counterElem = timePassCtrl:getCounterElemData(proto_object_CounterModule.CounterModuleWeeklyChallengeFresh, 0)
      return counterElem ~= nil and counterElem.nextExpiredTm > PlayerDataCenter.timestamp + 1
    elseif ExplorationManager.moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
      local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
      local counterElem = timePassCtrl:getCounterElemData(proto_object_CounterModule.CounterModuleDailyChallenge, 0)
      return counterElem ~= nil and counterElem.nextExpiredTm > PlayerDataCenter.timestamp + 1
    else
      local stageCfg = ExplorationManager:GetSectorStageCfg()
      local sectorId = stageCfg ~= nil and stageCfg.sector or 0
      local actType, actId, actFrameData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(sectorId)
      if actType ~= nil and EpActCheckCmdTimelinessFunc[actType] ~= nil then
        return EpActCheckCmdTimelinessFunc[actType](actId, sectorId)
      end
    end
  end
  return true
end

function ExplorationNetworkCtrl:SC_EXPLORATION_FixedHeroNtf(msg)
  if not ExplorationManager:IsInExploration() then
    warn("SC_EXPLORATION_FixedHeroNtf, not in exploration")
    return
  end
  ExplorationManager.epCtrl:ChacheWillChangeHero(msg.roleSync)
end

function ExplorationNetworkCtrl:CS_EXPLORATION_EX_OVER(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EX_OVER, proto_csmsg.SC_EXPLORATION_EX_OVER, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EX_OVER, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_EX_OVER)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_EX_OVER(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_EXPLORATION_EX_OVER error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_EX_OVER)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_OpeninBuffSelect(buffId, callback)
  self._openinBuffSelectTab.buffId = buffId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_OpeninBuffSelect, proto_csmsg.CS_EXPLORATION_OpeninBuffSelect, self._openinBuffSelectTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_OpeninBuffSelect, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_OpeninBuffSelect)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_OpeninBuffSelect(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_EXPLORATION_OpeninBuffSelect error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_OpeninBuffSelect)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_RecordRestartBattle(buffs, mp, hmp, callback)
  self._recordRestartBattleTable.data = {}
  self._recordRestartBattleTable.data.buffs = buffs
  self._recordRestartBattleTable.data.playerDync = {}
  local playerDync = self._recordRestartBattleTable.data.playerDync
  playerDync.mp = mp
  playerDync.hmp = hmp
  playerDync.tdmp = 0
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RecordRestartBattle, proto_csmsg.CS_EXPLORATION_RecordRestartBattle, self._recordRestartBattleTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RecordRestartBattle, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RecordRestartBattle)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_RecordRestartBattle(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "ExplorationNetworkCtrl:SC_EXPLORATION_RecordRestartBattle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RecordRestartBattle)
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_HERO_FormationFresh(dungeonId, chipDic, score, save, dropChipIdList, callback)
  local envId = ConfigData.act_general_ep_env.actGenrEpEnvIdStageIdMap[dungeonId]
  PlayerDataCenter.epSavingDataCenter:SetEpSavingDataCacheDirty(envId)
  self._FmtSaveTab = self._FmtSaveTab or {}
  self._FmtSaveTab.dungeonId = dungeonId
  self._FmtSaveTab.alg = chipDic
  self._FmtSaveTab.score = score
  self._FmtSaveTab.isSave = save
  self._FmtSaveTab.dropEndlessAlg = dropChipIdList
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_HERO_FormationFresh, proto_csmsg.CS_EXPLORATION_HERO_FormationFresh, self._FmtSaveTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_HERO_FormationFresh, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_HERO_FormationFresh)
end

function ExplorationNetworkCtrl:SC_EXPLORATION_HERO_FormationFresh(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "CS_EXPLORATION_HERO_FormationFresh error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_HERO_FormationFresh)
    return
  end
end

function ExplorationNetworkCtrl:CS_EXPLORATION_HERO_Formation_Detail(envId, callback)
  local function func(objList)
    if callback then
      callback(objList)
    end
    self:_TryNext_CS_EXPLORATION_HERO_Formation_Detail()
  end
  
  if cs_WaitNetworkResponse:ContainWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_HERO_Formation_Detail) then
    local queueeData = NetworkQueueDataPool:PoolGet()
    queueeData:InitNetworkQueueData(envId, func)
    table.insert(self._queue_HeroFmtDetail, queueeData)
    return
  end
  self:_CS_EXPLORATION_HERO_Formation_Detail(envId, func)
end

function ExplorationNetworkCtrl:_CS_EXPLORATION_HERO_Formation_Detail(envId, callback)
  self._HeroFmtDetailTab = self._HeroFmtDetailTab or {}
  self._HeroFmtDetailTab.envExplorationId = envId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_HERO_Formation_Detail, proto_csmsg.CS_EXPLORATION_HERO_Formation_Detail, self._HeroFmtDetailTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_HERO_Formation_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_HERO_Formation_Detail)
end

function ExplorationNetworkCtrl:_TryNext_CS_EXPLORATION_HERO_Formation_Detail()
  if #self._queue_HeroFmtDetail > 0 then
    local qData = table.remove(self._queue_HeroFmtDetail, 1)
    self:_CS_EXPLORATION_HERO_Formation_Detail(qData.datas[1], qData.datas[2])
    NetworkQueueDataPool:PoolPut(qData)
  end
end

function ExplorationNetworkCtrl:SC_EXPLORATION_HERO_Formation_Detail(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.EXPLORATION_HEROGROUP_ENV_NONE then
      cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_HERO_Formation_Detail, msg)
      return
    end
    local err = "CS_EXPLORATION_HERO_Formation_Detail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_HERO_Formation_Detail)
    TimerManager:AddLateCommand(function()
      self:_TryNext_CS_EXPLORATION_HERO_Formation_Detail()
    end)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_HERO_Formation_Detail, msg)
end

function ExplorationNetworkCtrl:Reset()
  self.lastSendDataList = {}
  self.cacheAction = {}
end

return ExplorationNetworkCtrl
