local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local HomeEnum = require("Game.Home.HomeEnum")
local __isSendingSingle = false
local __singleQueue = {}

local function SendSingle(callback)
  if __isSendingSingle then
    table.insert(__singleQueue, callback)
    return
  else
    __isSendingSingle = true
    if callback ~= nil then
      callback()
    end
  end
end

local function SendSingleOver()
  __isSendingSingle = false
  if 0 < #__singleQueue then
    local callback = __singleQueue[1]
    table.remove(__singleQueue, 1)
    callback()
  end
end

local ActivityFrameOpenFunc = {
  [ActivityFrameEnum.eActivityType.StarUp] = function(activityFrameData)
    local activityId = activityFrameData:GetActId()
    local data = PlayerDataCenter.activityStarUpData.dataDic[activityId]
    if data ~= nil then
      data:UpdateStarUpRedddot()
    end
  end,
  [ActivityFrameEnum.eActivityType.BattlePass] = function(activityFrameData)
    local activityId = activityFrameData:GetActId()
    if PlayerDataCenter.battlepassData.passInfos[activityId] ~= nil then
      return
    end
    NetworkManager:GetNetwork(NetworkTypeID.BattlePass):CS_BATTLEPASS_Detail()
  end,
  [ActivityFrameEnum.eActivityType.SevenDayLogin] = function(activityFrameData)
    local activityId = activityFrameData:GetActId()
    if PlayerDataCenter.eventNoviceSignData.dataDic[activityId] ~= nil then
      return
    end
    local defaultData = {
      id = activityId,
      times = 0,
      nextExpiredTm = 0
    }
    PlayerDataCenter.eventNoviceSignData:UpdateNoviceSignData(defaultData)
    local HomeEnum = require("Game.Home.HomeEnum")
    local HomeController = ControllerManager:GetController(ControllerTypeId.HomeController)
    if HomeController ~= nil and HomeController.homeState == HomeEnum.eHomeState.Normal then
      HomeController:AddAutoShowGuide(HomeEnum.eAutoShwoCommand.NoviceSign)
    end
  end,
  [ActivityFrameEnum.eActivityType.HeroBackOff] = function(activityFrameData)
    NetworkManager:GetNetwork(NetworkTypeID.Hero):CS_HEROREVERT_Detail()
  end,
  [ActivityFrameEnum.eActivityType.HeroGrow] = function(activityFrameData)
    TimerManager:StartTimer(1, function()
      SendSingle(function()
        NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
          if args.Count == 0 then
            error("args.Count == 0")
            return
          end
          local msg = args[0]
          if msg.activtySectorHero ~= nil then
            local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow, true)
            heroGrowCtrl:UpdateHeroGrowSingle(msg.activtySectorHero)
          elseif isGameDev then
            error(" hero activity is nil frameId:" .. tostring(activityFrameData:GetActivityFrameId()))
          end
          SendSingleOver()
        end)
      end)
    end, nil, true)
  end,
  [ActivityFrameEnum.eActivityType.SectorII] = function(activityFrameData)
    local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII, true)
    local actId = activityFrameData.actId
    SendSingle(function()
      local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
      cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_SECTOR_Detail, function()
        SendSingleOver()
      end, proto_csmsg_MSG_ID.MSG_SC_SECTOR_Detail)
      NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_SECTOR_Detail()
    end)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        sectorIICtrl:OnSectorIIActivityOpen(actId)
        sectorIICtrl:UpdataSectorIIActivityBySingleMsg(msg.activitySectorIIData)
        local sectorIIData = sectorIICtrl:GetSectorIIDataByActId(actId)
        sectorIIData:RefreshAWSectorLevelState()
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.WhiteDay] = function(activityFrameData)
    local actId = activityFrameData.actId
    local whiteDayCtrl = ControllerManager:GetController(ControllerTypeId.WhiteDay, true)
    whiteDayCtrl:OnWhiteDayActivityOpen(actId)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        whiteDayCtrl:UpdataSingleWhiteDayActivity(msg.activityValentine)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Comeback] = function(activityFrameData)
    local actId = activityFrameData.actId
    local comebackCtrl = ControllerManager:GetController(ControllerTypeId.ActivityComeback, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        comebackCtrl:AddComebackActivity(msg.activityUserReturn)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Task] = function(activityFrameData)
    local actId = activityFrameData.actId
    local actTaskCtrl = ControllerManager:GetController(ControllerTypeId.ActivityTask, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        actTaskCtrl:AddActivityTask(msg.activityQuest)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Round] = function(activityFrameData)
    local actId = activityFrameData.actId
    local actRoundCtrl = ControllerManager:GetController(ControllerTypeId.ActivityRound, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        actRoundCtrl:AddActivityRound(msg.activityRound)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.RefreshDun] = function(activityFrameData)
    local actId = activityFrameData.actId
    local refreshDunCtrl = ControllerManager:GetController(ControllerTypeId.ActRefreshDungeon, true)
    refreshDunCtrl:OnRefreshDunActivityOpen(actId)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        refreshDunCtrl:UpdataSingleRefreshDunActivity(msg.activityRefreshDungeon)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Carnival] = function(activityFrameData)
    local actId = activityFrameData.actId
    local carnivalCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        carnivalCtrl:AddCarnivalAct(msg.activityCarnival)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.HistoryTinyGame] = function(activityFrameData)
    local actId = activityFrameData.actId
    local historyTinyGameCtrl = ControllerManager:GetController(ControllerTypeId.HistoryTinyGameActivity, true)
    historyTinyGameCtrl:OnActivityOpen(actId)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        historyTinyGameCtrl:AddCarnivalAct(msg.activityTinyGame)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.DailyChallenge] = function(activityFrameData)
    local actId = activityFrameData.actId
    local adcCtrl = ControllerManager:GetController(ControllerTypeId.ActivityDailyChallenge, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        adcCtrl:AddADC(msg.activityDailyChallenge)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.SectorIII] = function(activityFrameData)
    local actId = activityFrameData.actId
    local sectorIIICtrl = ControllerManager:GetController(ControllerTypeId.ActivitySectorIII, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        sectorIIICtrl:UpdateSectorIIIAct(msg.activitySummer2022)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.SignInMiniGame] = function(activityFrameData)
    local actId = activityFrameData.actId
    local signMiniGameCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySignInMiniGame, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        signMiniGameCtrl:InitNetWrorkData(msg.activityAnnivSign)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Hallowmas] = function(activityFrameData)
    local actId = activityFrameData.actId
    local hallowmasCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        hallowmasCtrl:AddHallowmas(msg.activityHalloween)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Spring] = function(activityFrameData)
    local actId = activityFrameData.actId
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        springCtrl:AddSpring(msg.activitySpring)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Winter23] = function(activityFrameData)
    local actId = activityFrameData.actId
    local winter23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        winter23Ctrl:AddWinter23(msg.activityWinter23)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Invitation] = function(activityFrameData)
    local actId = activityFrameData.actId
    local invitationCtrl = ControllerManager:GetController(ControllerTypeId.ActivityInvitation, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        invitationCtrl:AddInvitation(msg.activityInvitation)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Season] = function(activityFrameData)
    local actId = activityFrameData.actId
    local activitySeasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        activitySeasonCtrl:InitSeasons(msg.activitySeason)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.EventWeeklyQA] = function(activityFrameData)
    local weeklyQACtrl = ControllerManager:GetController(ControllerTypeId.EventWeeklyQA, true)
    SendSingle(function()
      local actFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
      actFrameNet:CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(objList)
        local msg = objList[0]
        if msg ~= nil and msg.activityAnswer ~= nil then
          weeklyQACtrl:InitWeeklyQA(msg.activityAnswer)
          weeklyQACtrl:ShowWindowByWeeklyQAData()
        end
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.SaveMoney] = function(activityFrameData)
    local saveMoneyCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySaveMoney, true)
    SendSingle(function()
      local actFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
      actFrameNet:CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(objList)
        local msg = objList[0]
        if msg ~= nil and msg.activitySaveMoney ~= nil then
          saveMoneyCtrl:InitSaveMoney(msg.activitySaveMoney)
          saveMoneyCtrl:UpdateSaveMoneyUI()
        end
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.ActivityCarnival23] = function(activityFrameData)
    local actId = activityFrameData.actId
    local carnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        carnival23Ctrl:AddCarnival23(msg.activityCarnival2023)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.LuckyRaffle] = function(activityFrameData)
    local luckyRaffleCtrl = ControllerManager:GetController(ControllerTypeId.LuckyRaffle, true)
    TimerManager:StartTimer(1, function()
      SendSingle(function()
        local actFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
        actFrameNet:CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(objList)
          local msg = objList[0]
          if msg ~= nil and msg.activityLuckyRaffle ~= nil then
            luckyRaffleCtrl:InitLuckyRaffle(msg.activityLuckyRaffle)
          end
          SendSingleOver()
        end)
      end)
    end, nil, true)
  end,
  [ActivityFrameEnum.eActivityType.CardSet] = function(activityFrameData)
    local actCardSetCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        actCardSetCtrl:InitActCardSet(msg.ActivityCard)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.ExplorationFund] = function(activityFrameData)
    local explorationFundCtrl = ControllerManager:GetController(ControllerTypeId.ActivityExplorationFund, true)
    TimerManager:StartTimer(1, function()
      SendSingle(function()
        local actFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
        actFrameNet:CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(objList)
          local msg = objList[0]
          if msg ~= nil and msg.activityExploreFund ~= nil then
            explorationFundCtrl:InitExplorationFund(msg.activityExploreFund)
          end
          SendSingleOver()
        end)
      end)
    end, nil, true)
  end,
  [ActivityFrameEnum.eActivityType.ShortTheatre] = function(activityFrameData)
    local actId = activityFrameData.actId
    local shortTheatreCtrl = ControllerManager:GetController(ControllerTypeId.ShortTheatre, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        shortTheatreCtrl:InitNetWrorkData(msg.activitySignTheater)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Anniversary23] = function(activityFrameData)
    local actId = activityFrameData.actId
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        anniversary23Ctrl:AddAnniversary23(msg.activityAnniv)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.FlipCard] = function(activityFrameData)
    local actId = activityFrameData.actId
    local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        flipCardCtrl:InitFlipCard(msg.activityFlipCards)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.SkinLimit] = function(activityFrameData)
    local actId = activityFrameData.actId
    local skinLimitCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySkinLimit, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        skinLimitCtrl:InitSkinLimit(msg.activitySkinLimit)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.ActBlackHole] = function(activityFrameData)
    local actId = activityFrameData.actId
    local actBlackHoleCtrl = ControllerManager:GetController(ControllerTypeId.ActBlackHole, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        actBlackHoleCtrl:InitBlackHole(msg.activityBlackHole)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.SteinsGateMiniGame] = function(activityFrameData)
    local actId = activityFrameData.actId
    local actSteinsGateMinGameCtrl = ControllerManager:GetController(ControllerTypeId.ActSteinsGateMiniGame, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        actSteinsGateMinGameCtrl:AddSteinsGateMiniGame(msg.activityMashUp)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.SteinsGate] = function(activityFrameData)
    local actId = activityFrameData.actId
    local steinsGate23Ctrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        steinsGate23Ctrl:AddSteinsGate(msg.activitySteinsGate)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.HazeGift] = function(activityFrameData)
    local actId = activityFrameData.actId
    local hazeGiftCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHazeGift, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        hazeGiftCtrl:InitHazeGiftData(msg.activityHazeGift)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.DrawLottery] = function(activityFrameData)
    local actId = activityFrameData.actId
    local drawLotteryCtrl = ControllerManager:GetController(ControllerTypeId.EventDrawLottery, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        drawLotteryCtrl:AddEventDrawLottery(msg.activityDrawLottery)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Spring24] = function(activityFrameData)
    local actId = activityFrameData.actId
    local spring24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring24, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        spring24Ctrl:AddActData(msg.activityTreasureHunt)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.CollectFortune] = function(activityFrameData)
    local actId = activityFrameData.actId
    local collectFortuneCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCollectFortune, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        collectFortuneCtrl:InitCollectFortune(msg.activityCollectFortune)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.SoundPlayMiniGame] = function(activityFrameData)
    local actType = activityFrameData:GetActivityFrameCat()
    local actId = activityFrameData.actId
    local miniGameMusicCtrl = ControllerManager:GetController(ControllerTypeId.MiniGameMusic, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        if msg.tinyGameCenterGame ~= nil then
          local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
          activityFrameCtrl:UpdateAllTinyGame(msg.tinyGameCenterGame)
        end
        miniGameMusicCtrl:InitTiniGameActivityData(actType, actId, activityFrameData)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.HeroGrowV3] = function(activityFrameData)
    local heroGrowV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        heroGrowV3Ctrl:UpdateHGV3DataByMsg(msg.activtySectorHeroLite)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.SignInLiveStream] = function(activityFrameData)
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActSigninLiveStreamCtrl, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        ctrl:UpdateSILSDataByMsgList(msg.activtyOrder)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Carnival24] = function(activityFrameData)
    local actId = activityFrameData.actId
    local carnival24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        carnival24Ctrl:AddActData(msg.activityCarnival24)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Bond] = function(activityFrameData)
    local bondCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBond, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        bondCtrl:AddActData(msg.activityBound)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.Brotato] = function(activityFrameData)
    local actType = activityFrameData:GetActivityFrameCat()
    local actId = activityFrameData.actId
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        if msg.tinyGameCenterGame ~= nil then
          local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
          activityFrameCtrl:UpdateSingleTinyGame(msg.tinyGameCenterGame)
        end
        local activityBrotatoLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby, true)
        local endtime = activityFrameData:GetActivityEndTime()
        actCtrl:InitBrotatoLobbyCtrl(endtime, actId, nil)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.DeliverySimulator] = function(activityFrameData)
    local actDsCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        actDsCtrl:AddActData(msg.activityDelivery)
        SendSingleOver()
      end)
    end)
  end,
  [ActivityFrameEnum.eActivityType.ActAnniversary24] = function(activityFrameData)
    local an24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24, true)
    SendSingle(function()
      NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(activityFrameData:GetActivityFrameId(), function(args)
        if args.Count == 0 then
          error("args.Count == 0")
          return
        end
        local msg = args[0]
        an24Ctrl:AddActData(msg.activityAnniv24)
        SendSingleOver()
      end)
    end)
  end
}
return ActivityFrameOpenFunc
