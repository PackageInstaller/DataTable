local ActivityFrameNetworkCtrl = class("ActivityFrameNetworkCtrl", NetworkCtrlBase)
local base = NetworkCtrlBase
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local NetworkQueueData = require("Framework.Network.NetworkQueueData")
local NetworkQueueDataPool = CommonPool.New(function()
  return NetworkQueueData.New()
end, function(p)
  p:ResetNetworkQueueData()
  return true
end)

function ActivityFrameNetworkCtrl:ctor()
  self.techRefreshMsg = {}
  self.techUpgradeMsg = {}
  self._singleConcreteInfo = {}
  self._concreteInfos = {}
  self._techReset = {}
  self._tinyGame = {}
  self._actDungeonTable = {}
  self._techResetAll = {}
  self._singleTaskTable = {}
  self._tasklistTable = {}
  self._autoRefTask = {}
  self._queue_RefreshQuestDaily = {}
  self._manualRefTask = {}
  self._termRefTable = {}
  self._monsterCard = {}
  self._questBPTable = {}
  self._giftSendTable = {}
  self._giftReceiveTable = {}
  self._memoryDemandTable = {}
  self._memoryDemandMultiTable = {}
  self._commonRewardBpTable = {}
  self._deliverySectorFinTable = {}
end

function ActivityFrameNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Detail, self, proto_csmsg.SC_ACTIVITY_Detail, self.SC_ACTIVITY_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Wechat_Follow_Take, self, proto_csmsg.SC_ACTIVITY_Wechat_Follow_Take, self.SC_ACTIVITY_Wechat_Follow_Take)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Wechat_Detail, self, proto_csmsg.SC_ACTIVITY_Wechat_Detail, self.SC_ACTIVITY_Wechat_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Wechat_Followed_NTF, self, proto_csmsg.SC_ACTIVITY_Wechat_Followed_NTF, self.SC_ACTIVITY_Wechat_Followed_NTF)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_ConcreteInfos, self, proto_csmsg.SC_ACTIVITY_ConcreteInfos, self.SC_ACTIVITY_ConcreteInfos)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_SingleConcreteInfo, self, proto_csmsg.SC_ACTIVITY_SingleConcreteInfo, self.SC_ACTIVITY_SingleConcreteInfo)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityTech_Refresh, self, proto_csmsg.SC_ActivityTech_Refresh, self.SC_ActivityTech_Refresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityTech_Upgrade, self, proto_csmsg.SC_ActivityTech_Upgrade, self.SC_ActivityTech_Upgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityQuest_Detail, self, proto_csmsg.SC_ActivityQuest_Detail, self.SC_ActivityQuest_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityTech_ResetBranch, self, proto_csmsg.SC_ActivityTech_ResetBranch, self.SC_ActivityTech_ResetBranch)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TinyGame_Settle, self, proto_csmsg.SC_TinyGame_Settle, self.SC_TinyGame_Settle)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_DUNGEON_GeneralEnter, self, proto_csmsg.SC_ACTIVITY_DUNGEON_GeneralEnter, self.SC_ACTIVITY_DUNGEON_GeneralEnter)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityTech_ResetAll, self, proto_csmsg.SC_ActivityTech_ResetAll, self.SC_ActivityTech_ResetAll)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_Quest_Select_Commit, self, proto_csmsg.SC_Activity_Quest_Select_Commit, self.SC_Activity_Quest_Select_Commit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_Quest_Commit, self, proto_csmsg.SC_Activity_Quest_Commit, self.SC_Activity_Quest_Commit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_RefreshQuestDaily, self, proto_csmsg.SC_ACTIVITY_RefreshQuestDaily, self.SC_ACTIVITY_RefreshQuestDaily)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_RefreshSingleQuestByUser, self, proto_csmsg.SC_ACTIVITY_RefreshSingleQuestByUser, self.SC_ACTIVITY_RefreshSingleQuestByUser)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_TermTask, self, proto_csmsg.SC_ACTIVITY_TermTask, self.SC_ACTIVITY_TermTask)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_MonsterCard_Save, self, proto_csmsg.SC_Activity_MonsterCard_Save, self.SC_Activity_MonsterCard_Save)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_General_QuestBP_Reward, self, proto_csmsg.SC_ACTIVITY_General_QuestBP_Reward, self.SC_ACTIVITY_General_QuestBP_Reward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_General_Gift_Item_Send, self, proto_csmsg.SC_ACTIVITY_General_Gift_Item_Send, self.SC_ACTIVITY_General_Gift_Item_Send)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_General_Gift_Item_Receive, self, proto_csmsg.SC_ACTIVITY_General_Gift_Item_Receive, self.SC_ACTIVITY_General_Gift_Item_Receive)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival24_Demand, self, proto_csmsg.SC_ACTIVITY_Carnival24_Demand, self.SC_ACTIVITY_Carnival24_Demand)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival24_Demand_Multi, self, proto_csmsg.SC_ACTIVITY_Carnival24_Demand_Multi, self.SC_ACTIVITY_Carnival24_Demand_Multi)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_General_BP_Reward, self, proto_csmsg.SC_Activity_General_BP_Reward, self.SC_Activity_General_Bp_Reward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_Bond_Reward, self, proto_csmsg.SC_Activity_Bond_Reward, self.SC_Activity_Bond_Reward)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Delivery_Sector_Fin, self, proto_csmsg.SC_ACTIVITY_Delivery_Sector_Fin, self.SC_ACTIVITY_Delivery_Sector_Fin)
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_Detail(callback)
  self.__firstCallback = callback
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Detail, proto_csmsg.CS_ACTIVITY_Detail, table.emptytable)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_Detail(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  ControllerManager:GetController(ControllerTypeId.ActivityFrame, true):UpdateActivity(msg.data)
  if self.__firstCallback ~= nil then
    self.__firstCallback()
    self.__firstCallback = nil
  end
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_Wechat_Follow_Take(id, callback)
  local msg = {}
  msg.id = id
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Wechat_Follow_Take, proto_csmsg.CS_ACTIVITY_Wechat_Follow_Take, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Wechat_Follow_Take, function()
    local actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    actFrameCtr:UpdateWechatActivityRedeemed(id)
    callback()
  end, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Wechat_Follow_Take)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_Wechat_Follow_Take(msg)
  if msg.ret ~= 0 then
    local err = "ActivityFrameNetworkCtrl:ACTIVITY_Wechat_Follow_Take error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Achievement)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_Wechat_Detail(ids, callback)
  local msg = {}
  msg.ids = ids
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Wechat_Detail, proto_csmsg.CS_ACTIVITY_Wechat_Detail, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Wechat_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Wechat_Detail)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_Wechat_Detail(msg)
  local actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  actFrameCtr:UpdateWechatActivityElems(msg.data)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_Wechat_Followed_NTF(msg)
  local actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  actFrameCtr:UpdateWechatActivityFollowed(msg.id, true)
  MsgCenter:Broadcast(eMsgEventId.WechatUpdata)
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_ConcreteInfos()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_ConcreteInfos, proto_csmsg.CS_ACTIVITY_ConcreteInfos, table.emptytable)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_ConcreteInfos(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.activityGeneralTasks ~= nil then
    local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    actFrameCtrl:InitAllActDailyTaskData(msg.activityGeneralTasks)
  end
  if msg.activtySectorHero ~= nil then
    local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow, true)
    heroGrowCtrl:UpdateHeroGrow(msg.activtySectorHero)
  end
  if msg.activitySectorIIData ~= nil then
    local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
    if sectorIICtrl ~= nil then
      sectorIICtrl:UpdataSectorIIActivityByMsg(msg.activitySectorIIData)
    end
  end
  if msg.activityValentine ~= nil then
    local whiteDayCtrl = ControllerManager:GetController(ControllerTypeId.WhiteDay, true)
    if whiteDayCtrl ~= nil then
      whiteDayCtrl:UpdateAllWhiteDayActivity(msg.activityValentine)
    end
  end
  if msg.activityUserReturn ~= nil then
    local activityComebackCtrl = ControllerManager:GetController(ControllerTypeId.ActivityComeback, true)
    if activityComebackCtrl ~= nil then
      activityComebackCtrl:AddComebackList(msg.activityUserReturn)
    end
  end
  if msg.activityQuest ~= nil then
    local activityTaskCtrl = ControllerManager:GetController(ControllerTypeId.ActivityTask, true)
    if activityTaskCtrl ~= nil then
      activityTaskCtrl:AddActivityTaskList(msg.activityQuest)
    end
  end
  if msg.activityRound ~= nil then
    local activityRoundCtrl = ControllerManager:GetController(ControllerTypeId.ActivityRound, true)
    if activityRoundCtrl ~= nil then
      activityRoundCtrl:AddRoundList(msg.activityRound)
    end
  end
  if msg.activityRefreshDungeon ~= nil then
    local refreshDunCtrl = ControllerManager:GetController(ControllerTypeId.ActRefreshDungeon)
    if refreshDunCtrl ~= nil then
      refreshDunCtrl:UpdateAllRefreshDunActivity(msg.activityRefreshDungeon)
    end
  end
  if msg.activityCarnival ~= nil then
    local carnivalCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival, true)
    carnivalCtrl:InitAllCarnival(msg.activityCarnival)
  end
  if msg.tinyGameCenter ~= nil then
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    activityFrameCtrl:UpdateAllTinyGame(msg.tinyGameCenter)
  end
  if msg.activityTinyGame ~= nil then
    local historyTinyGameCtrl = ControllerManager:GetController(ControllerTypeId.HistoryTinyGameActivity, true)
    historyTinyGameCtrl:UpdataSingleActivity(msg.activityTinyGame)
  end
  if msg.activityDailyChallenge ~= nil then
    local adcCtrl = ControllerManager:GetController(ControllerTypeId.ActivityDailyChallenge, true)
    adcCtrl:AddADC(msg.activityDailyChallenge)
  end
  if msg.activityAnnivSign ~= nil then
    local signMiniGameCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySignInMiniGame, true)
    signMiniGameCtrl:InitNetWrorkData(msg.activityAnnivSign)
  end
  if msg.activitySummer2022 ~= nil then
    local sectorIIICtrl = ControllerManager:GetController(ControllerTypeId.ActivitySectorIII, true)
    sectorIIICtrl:InitSectorIIIData(msg.activitySummer2022)
  end
  if msg.activityHalloween ~= nil then
    local hallowmasCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas, true)
    hallowmasCtrl:InitHallowmas(msg.activityHalloween)
  end
  if msg.activitySpring ~= nil then
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring, true)
    springCtrl:AddSpring(msg.activitySpring)
  end
  if msg.activityWinter23 ~= nil then
    local winter23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23, true)
    winter23Ctrl:AddWinter23(msg.activityWinter23)
  end
  if msg.activityInvitation ~= nil then
    local invitationCtrl = ControllerManager:GetController(ControllerTypeId.ActivityInvitation, true)
    for i, v in ipairs(msg.activityInvitation) do
      invitationCtrl:AddInvitation(v)
    end
  end
  if msg.activityKeyExertion ~= nil then
    local keyExertionCtrl = ControllerManager:GetController(ControllerTypeId.ActivityKeyExertion, true)
    keyExertionCtrl:UpdateAllKeyExertionData(msg.activityKeyExertion)
  end
  if #msg.activitySeason > 0 then
    local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason, true)
    seasonCtrl:InitSeasons(msg.activitySeason)
  end
  if msg.activityAnswer ~= nil and not table.IsEmptyTable(msg.activityAnswer) then
    local weeklyQACtrl = ControllerManager:GetController(ControllerTypeId.EventWeeklyQA, true)
    weeklyQACtrl:InitWeeklyQA(msg.activityAnswer)
    weeklyQACtrl:ShowWindowByWeeklyQAData()
  end
  if msg.activitySaveMoney ~= nil then
    local saveMoneyCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySaveMoney, true)
    saveMoneyCtrl:InitSaveMoney(msg.activitySaveMoney)
    saveMoneyCtrl:UpdateSaveMoneyUI()
  end
  PlayerDataCenter.activityStarUpData:InitActivityStarUp(msg.activityRookieStar)
  if msg.activityCarnival2023 ~= nil then
    local carnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23, true)
    carnival23Ctrl:AddCarnival23(msg.activityCarnival2023)
  end
  if msg.activityLuckyRaffle ~= nil then
    local luckyRaffleCtrl = ControllerManager:GetController(ControllerTypeId.LuckyRaffle, true)
    luckyRaffleCtrl:InitLuckyRaffle(msg.activityLuckyRaffle)
  end
  if msg.activityHeroDivergent ~= nil then
    local divergentCtrl = ControllerManager:GetController(ControllerTypeId.ActivityDivergent, true)
    for _, divergentMsg in ipairs(msg.activityHeroDivergent) do
      divergentCtrl:InitDivergent(divergentMsg)
    end
  end
  if msg.ActivityCards ~= nil then
    local actCardSetCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet, true)
    actCardSetCtrl:InitActCardSetData(msg.ActivityCards)
  end
  if msg.activityExploreFund ~= nil then
    local explorationFundCtrl = ControllerManager:GetController(ControllerTypeId.ActivityExplorationFund, true)
    for _, explorationFundMsg in ipairs(msg.activityExploreFund) do
      explorationFundCtrl:InitExplorationFund(explorationFundMsg)
    end
  end
  if msg.activitySignTheater ~= nil then
    local shortTheatreCtrl = ControllerManager:GetController(ControllerTypeId.ShortTheatre, true)
    local mdata = msg.activitySignTheater[1]
    if mdata ~= nil then
      shortTheatreCtrl:InitNetWrorkData(mdata)
    end
  end
  if msg.activityFlipCards ~= nil then
    local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard, true)
    flipCardCtrl:InitFlipCard(msg.activityFlipCards)
  end
  if msg.activityAnniv ~= nil then
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23, true)
    anniversary23Ctrl:AddAnniversary23(msg.activityAnniv)
  end
  if msg.activitySkinLimit ~= nil then
    local skinLimitCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySkinLimit, true)
    skinLimitCtrl:InitSkinLimit(msg.activitySkinLimit)
  end
  if msg.activityBlackHole ~= nil then
    local actBlackHoleCtrl = ControllerManager:GetController(ControllerTypeId.ActBlackHole, true)
    actBlackHoleCtrl:InitBlackHole(msg.activityBlackHole)
  end
  if msg.activityMashUp ~= nil then
    local actSteinsGateMiniGameCtrl = ControllerManager:GetController(ControllerTypeId.ActSteinsGateMiniGame, true)
    actSteinsGateMiniGameCtrl:AddSteinsGateMiniGame(msg.activityMashUp)
  end
  if msg.activitySteinsGate ~= nil then
    local actSteinsGateCtrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate, true)
    actSteinsGateCtrl:AddSteinsGate(msg.activitySteinsGate)
  end
  if msg.activityHazeGift ~= nil then
    local actHazeGiftCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHazeGift, true)
    actHazeGiftCtrl:InitHazeGiftData(msg.activityHazeGift)
  end
  if 0 < #msg.activityDrawLottery then
    local eventDrawLotteryCtrl = ControllerManager:GetController(ControllerTypeId.EventDrawLottery, true)
    eventDrawLotteryCtrl:InitEventDrawLottery(msg.activityDrawLottery)
  end
  if msg.activityCollectFortune ~= nil then
    local actCollectFortuneCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCollectFortune, true)
    actCollectFortuneCtrl:InitCollectFortune(msg.activityCollectFortune)
  end
  if msg.activityTreasureHunt ~= nil then
    local spring24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring24, true)
    spring24Ctrl:AddActData(msg.activityTreasureHunt)
  end
  if msg.activtySectorHeroLite ~= nil then
    local heroGrowV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3, true)
    heroGrowV3Ctrl:UpdateHGV3DataByMsgs(msg.activtySectorHeroLite)
  end
  if msg.activtyOrder ~= nil then
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActSigninLiveStreamCtrl, true)
    ctrl:UpdateSILSDataByMsgList(msg.activtyOrder)
  end
  if msg.activityBound ~= nil then
    local bondCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBond, true)
    bondCtrl:AddActData(msg.activityBound)
  end
  if msg.activityAnniv24 ~= nil then
    local actAn24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24, true)
    actAn24Ctrl:AddActData(msg.activityAnniv24)
  end
  if msg.activityCarnival24 ~= nil then
    if msg.activityCarnival24.cur ~= nil then
      local carnival24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24, true)
      carnival24Ctrl:AddActData(msg.activityCarnival24.cur)
    end
    local count = #msg.activityCarnival24.history
    if 0 < count then
      for i, tempMsg in pairs(msg.activityCarnival24.history) do
        local data = PlayerDataCenter.actHisSpecialData
        data:RefreshCarnival24HisData(tempMsg)
      end
    end
  end
  if msg.activityDelivery ~= nil then
    local dsCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator, true)
    dsCtrl:AddActData(msg.activityDelivery)
  end
  if msg.interact ~= nil then
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if springCtrl then
      for activityId, v in pairs(msg.interact.interact) do
        local springData = springCtrl:GetActSpringDataByFrameId(activityId)
        if springData then
          local storyData = springData:GetSpringStoryData()
          storyData:UpdateInteractList(v.interacted)
          storyData:UpdateStoryLevel(v.storyLevel, v.storyLevelAwardGot, v.heroStoryLevel)
          springData:RefreshRedTeamPerformance()
          springData:AddRefreshRedTalk()
        end
      end
    end
    local steinsGateCtrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
    if steinsGateCtrl then
      for activityId, v in pairs(msg.interact.interact) do
        local steinsGateData = steinsGateCtrl:GetActSteinsGateDataByFrameId(activityId)
        if steinsGateData then
          local interactData = steinsGateData:GetSteinsGateInteractData()
          interactData:UpdateInteractList(v.interacted)
          steinsGateData:RefreshAllStoryData()
        end
      end
    end
  end
  if msg.activityMonsterCard ~= nil and 0 < #msg.activityMonsterCard then
    local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    for _, elem in pairs(msg.activityMonsterCard) do
      local actFrameId = elem.actLongId
      local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
      if actFrameData then
        local actBaseData = actFrameData:GetActivityData()
        actBaseData:RefreshActivityMonsterCardData(elem)
      end
    end
  end
  if msg.activityReturnNewSystem ~= nil then
    local activityComebackCtrl = ControllerManager:GetController(ControllerTypeId.ActivityComeback, true)
    if activityComebackCtrl ~= nil then
      activityComebackCtrl:AddComebackNewSystemList(msg.activityReturnNewSystem)
    end
  end
  if msg.activityHardDungeon ~= nil then
    local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local elem = msg.activityHardDungeon
    local actFrameId = elem.actLongId
    local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
    if actFrameData then
      local actBaseData = actFrameData:GetActivityData()
      actBaseData:RefreshCommonHardLevelPlayData(elem)
    end
  end
  if msg.activityGeneralNormal ~= nil then
    if msg.activityGeneralNormal.taskRecord ~= nil then
      local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
      actFrameCtrl:UpdateActivityTaskCompleted(msg.activityGeneralNormal.taskRecord)
    end
    if msg.activityGeneralNormal.normal ~= nil then
      for actFrameId, elem in pairs(msg.activityGeneralNormal.normal) do
        local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
        local tempActFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
        if tempActFrameData then
          local actBaseData = tempActFrameData:GetActivityData()
          if actBaseData then
            actBaseData:RefreshActivityTechData(elem.tech)
            actBaseData:RefreshActivityBpPoint(elem.questBP)
            actBaseData:RefreshActivityGiftItems(elem.giftItem)
          end
        end
      end
    end
    if msg.activityGeneralNormal.bp ~= nil then
      for actFrameId, elem in pairs(msg.activityGeneralNormal.bp) do
        local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
        local tempActFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
        if tempActFrameData then
          local actBaseData = tempActFrameData:GetActivityData()
          if actBaseData then
            actBaseData:RefreshActivityCommonRewardBp(elem)
          end
        end
      end
    end
    if msg.activityGeneralNormal.highScore ~= nil then
      MsgCenter:Broadcast(eMsgEventId.ActivityRankScoreChange, msg.activityGeneralNormal.highScore)
    end
  end
end

function ActivityFrameNetworkCtrl:__SendSingleConcreteInfo(concreteData)
  local actframeId = concreteData.datas[1]
  local callback = concreteData.datas[2]
  self._singleConcreteInfo.id = actframeId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_SingleConcreteInfo, proto_csmsg.CS_ACTIVITY_SingleConcreteInfo, self._singleConcreteInfo)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_SingleConcreteInfo, function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local msg = args[0]
    if msg.activityGeneralTask ~= nil then
      local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
      actFrameCtrl:AddActDailyTaskData(actframeId, msg.activityGeneralTask)
    end
    if callback ~= nil then
      callback(args)
    end
  end, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_SingleConcreteInfo)
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_SingleConcreteInfo(actframeId, callback)
  local concreteData = NetworkQueueDataPool:PoolGet()
  concreteData:InitNetworkQueueData(actframeId, callback)
  table.insert(self._concreteInfos, concreteData)
  if #self._concreteInfos == 1 then
    self:__SendSingleConcreteInfo(concreteData)
  end
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_SingleConcreteInfo(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_SingleConcreteInfo, msg)
  TimerManager:StopTimer(self._reqSingleConcreteTimer)
  self.__reqSingleConcreteTimer = TimerManager:StartTimer(1, function()
    local concreteData = table.remove(self._concreteInfos, 1)
    NetworkQueueDataPool:PoolPut(concreteData)
    if #self._concreteInfos == 0 then
      return
    end
    self:__SendSingleConcreteInfo(self._concreteInfos[1])
  end, self, true, true)
end

function ActivityFrameNetworkCtrl:CS_ActivityTech_Upgrade(actLongId, techId, callback)
  self.techUpgradeMsg.actLongId = actLongId
  self.techUpgradeMsg.techId = techId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityTech_Upgrade, proto_csmsg.CS_ActivityTech_Upgrade, self.techUpgradeMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityTech_Upgrade, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityTech_Upgrade)
end

function ActivityFrameNetworkCtrl:SC_ActivityTech_Upgrade(msg)
  if msg.ret ~= 0 then
    local err = "ActivityFrameNetworkCtrl:SC_ActivityTech_Upgrade error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ActivityTech_Upgrade)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ActivityTech_Upgrade, msg.techElem)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActivityFrameNetworkCtrl:CS_ActivityTech_Refresh(actLongId, callback)
  self.techRefreshMsg.actLongId = actLongId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityTech_Refresh, proto_csmsg.CS_ActivityTech_Refresh, self.techRefreshMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityTech_Refresh, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityTech_Refresh)
end

function ActivityFrameNetworkCtrl:SC_ActivityTech_Refresh(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= 0 then
    local err = "ActivityFrameNetworkCtrl:SC_ActivityTech_Refresh error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ActivityTech_Refresh)
    return
  end
end

function ActivityFrameNetworkCtrl:CS_ActivityTech_ResetBranch(actLongId, branchId, callback)
  self._techReset.actLongId = actLongId
  self._techReset.branchId = branchId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityTech_ResetBranch, proto_csmsg.CS_ActivityTech_ResetBranch, self._techReset)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityTech_ResetBranch, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityTech_ResetBranch)
end

function ActivityFrameNetworkCtrl:SC_ActivityTech_ResetBranch(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= 0 then
    local err = "ActivityFrameNetworkCtrl:SC_ActivityTech_ResetBranch error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
end

function ActivityFrameNetworkCtrl:CS_ActivityTech_ResetAll(actLongId, callback)
  self._techResetAll.actLongId = actLongId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityTech_ResetAll, proto_csmsg.CS_ActivityTech_ResetAll, self._techResetAll)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityTech_ResetAll, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityTech_ResetAll)
end

function ActivityFrameNetworkCtrl:SC_ActivityTech_ResetAll(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= 0 then
    local err = "ActivityFrameNetworkCtrl:SC_ActivityTech_ResetAll error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
end

function ActivityFrameNetworkCtrl:ApplyActivityDiff(diffMsg)
  if diffMsg.update ~= nil then
  end
  if diffMsg == nil or diffMsg.delete ~= nil then
  end
end

function ActivityFrameNetworkCtrl:CS_ActivityQuest_Detail(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityQuest_Detail, proto_csmsg.CS_ActivityQuest_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityQuest_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityQuest_Detail)
end

function ActivityFrameNetworkCtrl:SC_ActivityQuest_Detail(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ActivityQuest_Detail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActivityFrameNetworkCtrl:CS_TinyGame_Settle(uid, score, callback, param)
  self._tinyGame.uid = uid
  self._tinyGame.score = score
  self._tinyGame.param = param
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TinyGame_Settle, proto_csmsg.CS_TinyGame_Settle, self._tinyGame)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_TinyGame_Settle, callback, proto_csmsg_MSG_ID.MSG_SC_TinyGame_Settle)
end

function ActivityFrameNetworkCtrl:SC_TinyGame_Settle(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_TinyGame_Settle error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  activityFrameCtrl:UpdateSingleTinyGame(msg.game)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_TinyGame_Settle, msg.game)
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_DUNGEON_GeneralEnter(dungeonId, formationData, buffDic, callback, isDouble, challengeModeEnter)
  self._actDungeonTable.dungeonId = dungeonId
  if self._actDungeonTable.formInfo == nil then
    self._actDungeonTable.formInfo = {}
  end
  self._actDungeonTable.formInfo.formationId = formationData.id
  self._actDungeonTable.formInfo.support = formationData:GetSupportHeroData()
  self._actDungeonTable.formInfo.fairyUid = formationData:GetFmtFairyUID()
  self._actDungeonTable.formInfo.officeAssit = formationData:GetFmtOfficeAssistData()
  self._actDungeonTable.buffGroup = buffDic
  self._actDungeonTable.summerDouble = isDouble or false
  self._actDungeonTable.challenge = challengeModeEnter
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter, proto_csmsg.CS_ACTIVITY_DUNGEON_GeneralEnter, self._actDungeonTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_DUNGEON_GeneralEnter, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_DUNGEON_GeneralEnter, proto_csmsg_MSG_ID.MSG_SC_BATTLE_NtfEnter)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_DUNGEON_GeneralEnter(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_DUNGEON_GeneralEnter error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    return
  end
end

function ActivityFrameNetworkCtrl:CS_Activity_Quest_Commit(id, questId, callback)
  self._singleTaskTable.id = id
  self._singleTaskTable.questId = questId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_Quest_Commit, proto_csmsg.CS_Activity_Quest_Commit, self._singleTaskTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Quest_Commit, function(args)
    MsgCenter:Broadcast(eMsgEventId.TaskCommitComplete, ConfigData.task[questId])
    if callback ~= nil then
      callback(args)
    end
  end, proto_csmsg_MSG_ID.MSG_SC_Activity_Quest_Commit)
end

function ActivityFrameNetworkCtrl:SC_Activity_Quest_Commit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_Quest_Commit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Quest_Commit)
    return
  end
  local addInfo = {}
  if msg.syncUpdateDiff.resource ~= nil and msg.syncUpdateDiff.resource.backpack ~= nil then
    local randomPackage = msg.syncUpdateDiff.resource.backpack.randomPackage
    if randomPackage ~= nil then
      addInfo.task_randomPackage = randomPackage
    end
    local overflow = msg.syncUpdateDiff.resource.backpack.overflow
    if overflow ~= nil then
      addInfo.task_overflowInfo = overflow
    end
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Activity_Quest_Commit, addInfo)
end

function ActivityFrameNetworkCtrl:CS_Activity_Quest_Select_Commit(actLongId, taskids, callback)
  self._tasklistTable.actLongId = actLongId
  self._tasklistTable.questIds = taskids
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_Quest_Select_Commit, proto_csmsg.CS_Activity_Quest_Select_Commit, self._tasklistTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Quest_Select_Commit, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_Quest_Select_Commit)
end

function ActivityFrameNetworkCtrl:SC_Activity_Quest_Select_Commit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_Quest_Select_Commit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Quest_Select_Commit)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_RefreshQuestDaily(actLongId, callback)
  local function func(objList)
    if callback then
      callback(objList)
    end
    self:_TryNext_CS_ACTIVITY_RefreshQuestDaily()
  end
  
  if cs_WaitNetworkResponse:ContainWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_RefreshQuestDaily) then
    local queueeData = NetworkQueueDataPool:PoolGet()
    queueeData:InitNetworkQueueData(actLongId, func)
    table.insert(self._queue_RefreshQuestDaily, queueeData)
    return
  end
  self:_CS_ACTIVITY_RefreshQuestDaily(actLongId, func)
end

function ActivityFrameNetworkCtrl:_CS_ACTIVITY_RefreshQuestDaily(actLongId, callback)
  self._autoRefTask.actLongId = actLongId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_RefreshQuestDaily, proto_csmsg.CS_ACTIVITY_RefreshQuestDaily, self._autoRefTask)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_RefreshQuestDaily, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_RefreshQuestDaily)
end

function ActivityFrameNetworkCtrl:_TryNext_CS_ACTIVITY_RefreshQuestDaily()
  if #self._queue_RefreshQuestDaily > 0 then
    local qData = table.remove(self._queue_RefreshQuestDaily, 1)
    self:_CS_ACTIVITY_RefreshQuestDaily(qData.datas[1], qData.datas[2])
    NetworkQueueDataPool:PoolPut(qData)
  end
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_RefreshQuestDaily(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_RefreshQuestDaily error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_RefreshQuestDaily)
    TimerManager:AddLateCommand(function()
      self:_TryNext_CS_ACTIVITY_RefreshQuestDaily()
    end)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_RefreshQuestDaily, msg)
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_RefreshSingleQuestByUser(actLongId, taskId, callback)
  self._manualRefTask.actLongId = actLongId
  self._manualRefTask.taskId = taskId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_RefreshSingleQuestByUser, proto_csmsg.CS_ACTIVITY_RefreshSingleQuestByUser, self._manualRefTask)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_RefreshSingleQuestByUser, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_RefreshSingleQuestByUser)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_RefreshSingleQuestByUser(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_RefreshSingleQuestByUser error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_RefreshSingleQuestByUser)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_RefreshSingleQuestByUser, msg.newTaskId)
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_TermTask(actLongId, callback)
  self._termRefTable.actLongId = actLongId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TermTask, proto_csmsg.CS_ACTIVITY_TermTask, self._termRefTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TermTask, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_TermTask)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_TermTask(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_TermTask error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_TermTask)
    return
  end
end

function ActivityFrameNetworkCtrl:CS_Activity_MonsterCard_Save(actFrameId, cardIds, callback)
  self._monsterCard.actLongId = actFrameId
  self._monsterCard.cardIds = cardIds
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_MonsterCard_Save, proto_csmsg.CS_Activity_MonsterCard_Save, self._monsterCard)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_MonsterCard_Save, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_MonsterCard_Save)
end

function ActivityFrameNetworkCtrl:SC_Activity_MonsterCard_Save(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_MonsterCard_Save error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_MonsterCard_Save)
    return
  end
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_General_QuestBP_Reward(actLongId, term, point, callback)
  self._questBPTable.actLongId = actLongId
  self._questBPTable.term = term
  self._questBPTable.point = point
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_General_QuestBP_Reward, proto_csmsg.CS_ACTIVITY_General_QuestBP_Reward, self._questBPTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_General_QuestBP_Reward, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_General_QuestBP_Reward)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_General_QuestBP_Reward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_General_QuestBP_Reward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_General_QuestBP_Reward)
    return
  end
  if msg.msgCS ~= nil then
    local bpTable = {}
    bpTable[msg.msgCS.term] = {}
    bpTable[msg.msgCS.term].rewardGotPoint = msg.msgCS.point
    local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local tempActFrameData = actFrameCtrl:GetActivityFrameData(msg.msgCS.actLongId)
    if tempActFrameData then
      local actBaseData = tempActFrameData:GetActivityData()
      actBaseData:RefreshActivityBpPoint(bpTable)
    end
  end
  if msg.rewards ~= nil then
    UIUtil.ShowCommonReward(msg.rewards)
  end
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_General_Gift_Item_Send(actLongId, receiver, sendItem, callback)
  self._giftSendTable.actLongId = actLongId
  self._giftSendTable.receiver = receiver
  self._giftSendTable.sendItem = sendItem
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_General_Gift_Item_Send, proto_csmsg.CS_ACTIVITY_General_Gift_Item_Send, self._giftSendTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_General_Gift_Item_Send, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_General_Gift_Item_Send)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_General_Gift_Item_Send(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.err ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_General_Gift_Item_Send error:" .. tostring(msg.err)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_General_Gift_Item_Send)
    return
  end
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_General_Gift_Item_Receive(actLongId, sender, sendTm, isAll, callback)
  self._giftReceiveTable.actLongId = actLongId
  self._giftReceiveTable.sender = sender
  self._giftReceiveTable.sendTm = sendTm
  self._giftReceiveTable.all = isAll
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_General_Gift_Item_Receive, proto_csmsg.CS_ACTIVITY_General_Gift_Item_Receive, self._giftReceiveTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_General_Gift_Item_Receive, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_General_Gift_Item_Receive)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_General_Gift_Item_Receive(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.err ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_General_Gift_Item_Receive error:" .. tostring(msg.err)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_General_Gift_Item_Receive)
    return
  end
  if msg.rewards ~= nil then
    UIUtil.ShowCommonReward(msg.rewards)
  end
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_Carnival24_Demand(stageId, demandId, callback)
  self._memoryDemandTable.stageId = stageId
  self._memoryDemandTable.demandId = demandId
  self._memoryDemandTable.callback = callback
  print("CS_ACTIVITY_Carnival24_Demand")
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival24_Demand, proto_csmsg.CS_ACTIVITY_Carnival24_Demand, self._memoryDemandTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival24_Demand, nil, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival24_Demand)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_Carnival24_Demand(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local ret = "SC_ACTIVITY_Carnival24_Demand error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(ret)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival24_Demand)
    return
  end
  local carnival24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
  if carnival24Ctrl ~= nil then
    carnival24Ctrl:UpdateMemoryDemandPicked(msg.msgOri)
  end
  if self._memoryDemandTable.callback ~= nil then
    self._memoryDemandTable.callback(msg)
    self._memoryDemandTable.callback = nil
  end
  MsgCenter:Broadcast(eMsgEventId.ActivityCarnival24DataChange)
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_Carnival24_Demand_Multi(stageId, demandIds, callback)
  self._memoryDemandMultiTable.stageId = stageId
  self._memoryDemandMultiTable.demandIds = demandIds
  self._memoryDemandMultiTable.callback = callback
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival24_Demand_Multi, proto_csmsg.CS_ACTIVITY_Carnival24_Demand_Multi, self._memoryDemandMultiTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival24_Demand_Multi, nil, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Carnival24_Demand_Multi)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_Carnival24_Demand_Multi(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local ret = "SC_ACTIVITY_Carnival24_Demand_Multi error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(ret)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Carnival24_Demand_Multi)
    return
  end
  local carnival24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
  if carnival24Ctrl ~= nil then
    carnival24Ctrl:UpdateMemoryDemandPickedList(msg.msgOri)
  end
  if self._memoryDemandMultiTable.callback ~= nil then
    self._memoryDemandMultiTable.callback(msg)
    self._memoryDemandMultiTable.callback = nil
  end
  MsgCenter:Broadcast(eMsgEventId.ActivityCarnival24DataChange)
end

function ActivityFrameNetworkCtrl:CS_Activity_General_Bp_Reward(actFrameId, diff, callback)
  self._commonRewardBpTable.actLongId = actFrameId
  self._commonRewardBpTable.difficultyId = diff
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_General_BP_Reward, proto_csmsg.CS_Activity_General_BP_Reward, self._commonRewardBpTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_General_BP_Reward, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_General_BP_Reward)
end

function ActivityFrameNetworkCtrl:SC_Activity_General_Bp_Reward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local ret = "SC_Activity_General_Bp_Reward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(ret)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_General_BP_Reward)
    return
  end
  UIUtil.ShowCommonReward(msg.reward)
end

function ActivityFrameNetworkCtrl:CS_Activity_Bond_Reward(actId, callback)
  local msg = {actId = actId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_Bond_Reward, proto_csmsg.CS_Activity_Bond_Reward, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Bond_Reward, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_Bond_Reward)
end

function ActivityFrameNetworkCtrl:SC_Activity_Bond_Reward(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local ret = "SC_Activity_General_Bp_Reward error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(ret)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Bond_Reward)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_Activity_Bond_Reward, msg)
end

function ActivityFrameNetworkCtrl:CS_ACTIVITY_Delivery_Sector_Fin(actId, sectorId, score, goodsList, orderList, callback)
  self._deliverySectorFinTable.actId = actId
  self._deliverySectorFinTable.sectorId = sectorId
  self._deliverySectorFinTable.score = score
  self._deliverySectorFinTable.items = {}
  self._deliverySectorFinTable.orders = {}
  for good_id, count in pairs(goodsList) do
    self._deliverySectorFinTable.items[good_id] = count
  end
  for index, order in pairs(orderList) do
    if self._deliverySectorFinTable.orders[order.cfg.order_id] == nil then
      self._deliverySectorFinTable.orders[order.cfg.order_id] = 0
    end
    self._deliverySectorFinTable.orders[order.cfg.order_id] = self._deliverySectorFinTable.orders[order.cfg.order_id] + 1
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Delivery_Sector_Fin, proto_csmsg.CS_ACTIVITY_Delivery_Sector_Fin, self._deliverySectorFinTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Delivery_Sector_Fin, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Delivery_Sector_Fin)
end

function ActivityFrameNetworkCtrl:SC_ACTIVITY_Delivery_Sector_Fin(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.ACTIVITY_NO_ELEM then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(6033))
    end
    local ret = "SC_ACTIVITY_Delivery_Sector_Fin error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(ret)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Delivery_Sector_Fin)
    return
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Delivery_Sector_Fin, msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function ActivityFrameNetworkCtrl:OnDelete()
  TimerManager:StopTimer(self._reqSingleConcreteTimer)
  base.OnDelete(self)
end

function ActivityFrameNetworkCtrl:Reset()
end

return ActivityFrameNetworkCtrl
