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

local ActivityDailyFlushFunc = {
  [ActivityFrameEnum.eActivityType.SevenDayLogin] = function(frameIdDic, actFrameCtrl)
    TimerManager:StartTimer(1, function()
      MsgCenter:Broadcast(eMsgEventId.NoviceSignTime)
      local eventSignWindow = UIManager:GetWindow(UIWindowTypeID.EventNoviceSign)
      if eventSignWindow ~= nil then
        eventSignWindow:RefreshNoviceSign()
      end
      local festivalSignWindow = UIManager:GetWindow(UIWindowTypeID.EventFestivalSignIn)
      if festivalSignWindow ~= nil then
        festivalSignWindow:UpdUIFestivalSignIn()
      end
      local HomeController = ControllerManager:GetController(ControllerTypeId.HomeController)
      local isAddGuide = false
      for actFrameId, v in pairs(frameIdDic) do
        local actInfo = actFrameCtrl:GetActivityFrameData(actFrameId)
        if actInfo ~= nil and actInfo:GetCouldShowActivity() then
          local signData = PlayerDataCenter.eventNoviceSignData.dataDic[actInfo:GetActId()]
          local reddotNode = actInfo:GetActivityReddotNode()
          if reddotNode ~= nil then
            reddotNode:SetRedDotCount(signData ~= nil and signData:IsAllowReceive() and 1 or 0)
          end
          if signData ~= nil and signData:IsCanPop() then
            isAddGuide = true
            if HomeController ~= nil and HomeController.homeState == HomeEnum.eHomeState.Normal then
              HomeController:AddAutoShowGuide(HomeEnum.eAutoShwoCommand.NoviceSign, true)
            end
          end
        end
      end
      if isAddGuide and HomeController ~= nil then
        HomeController:TryRunAutoShow()
      end
    end, nil, true)
  end,
  [ActivityFrameEnum.eActivityType.HeroGrow] = function(frameIdDic, actFrameCtrl)
    TimerManager:StartTimer(2, function()
      local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow, true)
      for actFrameId, v in pairs(frameIdDic) do
        local actInfo = actFrameCtrl:GetActivityFrameData(actFrameId)
        local heroGrowData = heroGrowCtrl:GetHeroGrowActivity(actInfo:GetActId())
        if heroGrowData ~= nil and not heroGrowData:IsHeroGrowTaskAllUnlock() then
          SendSingle(function()
            NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(actFrameId, function(args)
              local activtySectorHero = args[0].activtySectorHero
              if activtySectorHero ~= nil then
                local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow, true)
                heroGrowCtrl:UpdateHeroGrowSingle(activtySectorHero)
              end
              SendSingleOver()
              heroGrowCtrl:RefreshHeroGrowStateDailyFlush()
            end)
          end)
        end
      end
    end, nil, true)
  end,
  [ActivityFrameEnum.eActivityType.HeroGrowV3] = function(frameIdDic, actFrameCtrl)
    TimerManager:StartTimer(2, function()
      local heroGrowV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3, true)
      for actFrameId, v in pairs(frameIdDic) do
        local actInfo = actFrameCtrl:GetActivityFrameData(actFrameId)
        local heroGrowData = heroGrowV3Ctrl:GetHeroGrowActivity(actInfo:GetActId())
        if heroGrowData ~= nil and not heroGrowData:IsHeroGrowTaskAllUnlock() then
          SendSingle(function()
            NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(actFrameId, function(args)
              local msg = args[0]
              heroGrowV3Ctrl:UpdateHGV3DataByMsg(msg.activtySectorHeroLite)
              SendSingleOver()
            end)
          end)
        end
      end
    end, nil, true)
  end,
  [ActivityFrameEnum.eActivityType.DailyChallenge] = function(frameIdDic, actFrameCtrl)
    local adcCtrl = ControllerManager:GetController(ControllerTypeId.ActivityDailyChallenge)
    if adcCtrl ~= nil then
      adcCtrl:RefreshADCDailyFlush()
    end
  end,
  [ActivityFrameEnum.eActivityType.BattlePass] = function(frameIdDic, actFrameCtrl)
    NetworkManager:GetNetwork(NetworkTypeID.BattlePass):CS_BATTLEPASS_Detail()
  end,
  [ActivityFrameEnum.eActivityType.CardSet] = function(frameIdDic, actFrameCtrl)
    for actFrameId, v in pairs(frameIdDic) do
      SendSingle(function()
        NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(actFrameId, function(args)
          if args.Count == 0 then
            error("args.Count == 0")
            return
          end
          local msg = args[0]
          local actCardSetCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
          if actCardSetCtrl ~= nil then
            actCardSetCtrl:InitActCardSet(msg.ActivityCard)
          end
          SendSingleOver()
        end)
      end)
    end
  end,
  [ActivityFrameEnum.eActivityType.Divergent] = function(frameIdDic, actFrameCtrl)
    local divergentCtrl = ControllerManager:GetController(ControllerTypeId.ActivityDivergent, true)
    for actFrameId, v in pairs(frameIdDic) do
      local actInfo = actFrameCtrl:GetActivityFrameData(actFrameId)
      local divergentData = divergentCtrl:GetDivergentDataByActId(actInfo:GetActId())
      if divergentData ~= nil then
        SendSingle(function()
          NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(actFrameId, function(args)
            SendSingleOver()
          end)
        end)
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.HazeGift] = function(frameIdDic, actFrameCtrl)
    local hazeGiftCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHazeGift, true)
    if hazeGiftCtrl ~= nil then
      hazeGiftCtrl:RefreshHazeGiftFlush()
    end
    local hazeGiftWindow = UIManager:GetWindow(UIWindowTypeID.ActivityHazeGiftMain)
    if hazeGiftWindow ~= nil then
      hazeGiftWindow:UpdateActHazeGiftByDayPass()
    end
  end,
  [ActivityFrameEnum.eActivityType.Spring24] = function(frameIdDic, actFrameCtrl)
    TimerManager:StartTimer(1, function()
      local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring24)
      if actCtrl == nil then
        return
      end
      for actFrameId, v in pairs(frameIdDic) do
        local actInfo = actFrameCtrl:GetActivityFrameData(actFrameId)
        local actData = actCtrl:GetActDataByActId(actInfo:GetActId())
        if actData ~= nil then
          SendSingle(function()
            NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(actFrameId, function(args)
              local msg = args[0]
              actCtrl:UpdateActData(msg.activityTreasureHunt)
              actCtrl:DoDailyFlush(msg.activityTreasureHunt.actId)
              SendSingleOver()
            end)
          end)
        end
      end
    end, nil, true)
  end,
  [ActivityFrameEnum.eActivityType.CollectFortune] = function(frameIdDic, actFrameCtrl)
    local collectFortuneWindow = UIManager:GetWindow(UIWindowTypeID.UI24SpringCollectFortuneMain)
    if collectFortuneWindow ~= nil then
      collectFortuneWindow:UpdateActCollectFortuneByDayPass()
    end
  end,
  [ActivityFrameEnum.eActivityType.SignInLiveStream] = function(frameIdDic, actFrameCtrl)
    TimerManager:StartTimer(1, function()
      local actCtrl = ControllerManager:GetController(ControllerTypeId.ActSigninLiveStreamCtrl, true)
      if actCtrl == nil then
        return
      end
      for actFrameId, v in pairs(frameIdDic) do
        local actInfo = actFrameCtrl:GetActivityFrameData(actFrameId)
        local actData = actCtrl:GetSILSDataByActId(actInfo:GetActId())
        if actData ~= nil then
          SendSingle(function()
            NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame):CS_ACTIVITY_SingleConcreteInfo(actFrameId, function(args)
              local msg = args[0]
              actCtrl:UpdateSILSDataByMsg(msg.activtyOrder)
              local win = UIManager:GetWindow(UIWindowTypeID.SignInLiveStream)
              if win ~= nil then
                win:OnSILSDataRTefresh()
              end
              SendSingleOver()
            end)
          end)
        end
      end
    end, nil, true)
  end
}
return ActivityDailyFlushFunc
