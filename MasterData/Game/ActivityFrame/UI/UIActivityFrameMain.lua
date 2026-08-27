local UIActivityFrameMain = class("UIActivityFrameMain", UIBaseWindow)
local base = UIBaseWindow
local ActivityFrameData = require("Game.ActivityFrame.ActivityFrameData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local UINActivityFrameItem = require("Game.ActivityFrame.UI.UINActivityFrameItem")
local openActivityPanelParam = {
  [ActivityFrameEnum.eActivityUIType.StarUp] = {
    UIType = UIWindowTypeID.ActivityStarUp,
    InitFunction = "InitWindow"
  },
  [ActivityFrameEnum.eActivityUIType.BattlePass] = {
    UIType = UIWindowTypeID.EventBattlePass,
    InitFunction = "InitBattlePassUI"
  },
  [ActivityFrameEnum.eActivityUIType.BattlePassV2] = {
    UIType = UIWindowTypeID.EventBattlePassV2,
    InitFunction = "InitBattlePassUIV2"
  },
  [ActivityFrameEnum.eActivityUIType.EventGrowBag] = {
    UIType = UIWindowTypeID.EventGrowBag,
    InitFunction = "InitEventGrow"
  },
  [ActivityFrameEnum.eActivityUIType.SevenDayLogin] = {
    UIType = UIWindowTypeID.EventNoviceSign,
    InitFunction = "InitNoviceSign"
  },
  [ActivityFrameEnum.eActivityUIType.FestivalSign] = {
    UIType = UIWindowTypeID.EventFestivalSignIn,
    InitFunction = "InitEventFestivalSignIn"
  },
  [ActivityFrameEnum.eActivityUIType.dailySignIn] = {
    UIType = UIWindowTypeID.EventSignin,
    InitFunction = "InitEventSignin"
  },
  [ActivityFrameEnum.eActivityUIType.Tickets] = {
    UIType = UIWindowTypeID.EventWeChat,
    InitFunction = "InitWeChat"
  },
  [ActivityFrameEnum.eActivityUIType.LimitTask] = {
    UIType = UIWindowTypeID.ActivityLimitTask,
    InitFunction = "InitActivityLimitTask"
  },
  [ActivityFrameEnum.eActivityUIType.SignInMiniGame] = {
    UIType = UIWindowTypeID.SignInMiniGame,
    InitFunction = "InitSignInMiniGame"
  },
  [ActivityFrameEnum.eActivityUIType.EventInvitation] = {
    UIType = UIWindowTypeID.EventInvitation,
    InitFunction = "InitInvitation"
  },
  [ActivityFrameEnum.eActivityUIType.EventWeeklyQA] = {
    UIType = UIWindowTypeID.EventWeeklyQA,
    InitFunction = "InitEventWeeklyQA"
  },
  [ActivityFrameEnum.eActivityUIType.EventAngelaGift] = {
    UIType = UIWindowTypeID.EventAngelaGift,
    InitFunction = "InitEventAngelaGiftMain"
  },
  [ActivityFrameEnum.eActivityUIType.Gift] = {
    UIType = UIWindowTypeID.EventOptionalGift,
    InitFunction = "InitEventOptionalGift"
  },
  [ActivityFrameEnum.eActivityUIType.SaveMoney] = {
    UIType = UIWindowTypeID.SaveMoney,
    InitFunction = "InitSaveMoneyMain"
  },
  [ActivityFrameEnum.eActivityUIType.LuckyRaffle] = {
    UIType = UIWindowTypeID.LuckyRaffle,
    InitFunction = "InitLuckyRaffle"
  },
  [ActivityFrameEnum.eActivityUIType.ExplorationFund] = {
    UIType = UIWindowTypeID.ExplorationFund,
    InitFunction = "InitExplorationFundMain"
  },
  [ActivityFrameEnum.eActivityUIType.FlipCard] = {
    UIType = UIWindowTypeID.ActivityFlipCardMain,
    InitFunction = "InitFlipCardMain"
  },
  [ActivityFrameEnum.eActivityUIType.SkinLimit] = {
    UIType = UIWindowTypeID.ActivitySkinLimitMain,
    InitFunction = "InitSkinLimitMain"
  },
  [ActivityFrameEnum.eActivityUIType.LadderGift] = {
    UIType = UIWindowTypeID.EventLadderGift,
    InitFunction = "InitEventLadderGift"
  },
  [ActivityFrameEnum.eActivityUIType.HazeGift] = {
    UIType = UIWindowTypeID.ActivityHazeGiftMain,
    InitFunction = "InitHazeGiftMain"
  },
  [ActivityFrameEnum.eActivityUIType.DrawLottery] = {
    UIType = UIWindowTypeID.EventDrawLottery,
    InitFunction = "InitEventDrawLottery"
  }
}
local GetActivityParamDealFunc = {
  [ActivityFrameEnum.eActivityType.StarUp] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.StarUp
  end,
  [ActivityFrameEnum.eActivityType.BattlePass] = function(actFrameData)
    local cfg = ConfigData.battlepass_type[actFrameData.actId]
    if cfg ~= nil then
      if cfg.condition == BattlePassEnum.ConditionType.AchievementLevel then
        return ActivityFrameEnum.eActivityUIType.EventGrowBag
      elseif cfg.condition == BattlePassEnum.ConditionType.BattlePassLevel then
        if cfg.version > 0 then
          return ActivityFrameEnum.eActivityUIType.BattlePassV2
        else
          return ActivityFrameEnum.eActivityUIType.BattlePass
        end
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.SevenDayLogin] = function(actFrameData)
    local signData = PlayerDataCenter.eventNoviceSignData.dataDic[actFrameData.actId]
    if signData ~= nil and signData:IsFestivalSign() then
      return ActivityFrameEnum.eActivityUIType.FestivalSign
    else
      return ActivityFrameEnum.eActivityUIType.SevenDayLogin
    end
  end,
  [ActivityFrameEnum.eActivityType.dailySignIn] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.dailySignIn
  end,
  [ActivityFrameEnum.eActivityType.Tickets] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.Tickets
  end,
  [ActivityFrameEnum.eActivityType.ActvtLimitTask] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.LimitTask
  end,
  [ActivityFrameEnum.eActivityType.SignInMiniGame] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.SignInMiniGame
  end,
  [ActivityFrameEnum.eActivityType.Invitation] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.EventInvitation
  end,
  [ActivityFrameEnum.eActivityType.EventWeeklyQA] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.EventWeeklyQA
  end,
  [ActivityFrameEnum.eActivityType.EventAngelaGift] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.EventAngelaGift
  end,
  [ActivityFrameEnum.eActivityType.Gift] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.Gift
  end,
  [ActivityFrameEnum.eActivityType.SaveMoney] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.SaveMoney
  end,
  [ActivityFrameEnum.eActivityType.LuckyRaffle] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.LuckyRaffle
  end,
  [ActivityFrameEnum.eActivityType.ExplorationFund] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.ExplorationFund
  end,
  [ActivityFrameEnum.eActivityType.FlipCard] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.FlipCard
  end,
  [ActivityFrameEnum.eActivityType.SkinLimit] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.SkinLimit
  end,
  [ActivityFrameEnum.eActivityType.LadderGift] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.LadderGift
  end,
  [ActivityFrameEnum.eActivityType.HazeGift] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.HazeGift
  end,
  [ActivityFrameEnum.eActivityType.DrawLottery] = function(actFrameData)
    return ActivityFrameEnum.eActivityUIType.DrawLottery
  end
}

function UIActivityFrameMain:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickClose)
  self.swithItemPool = UIItemPool.New(UINActivityFrameItem, self.ui.tog_SwitchItem)
  self.ui.tog_SwitchItem:SetActive(false)
  self.__OnSelectActivityItem = BindCallback(self, self.OnSelectActivityItem)
  self.resloader = CS.ResLoader.Create()
  self.__ListerShowActivityCallback = BindCallback(self, self.__ListerShowActivity)
  MsgCenter:AddListener(eMsgEventId.ActivityShowChange, self.__ListerShowActivityCallback)
end

function UIActivityFrameMain:ActivityParamDeal(actFrameData)
  local UIType
  if GetActivityParamDealFunc[actFrameData.actCat] ~= nil then
    UIType = GetActivityParamDealFunc[actFrameData.actCat](actFrameData)
  end
  self.activityTypeDic[actFrameData.id] = UIType
end

function UIActivityFrameMain:InitFrameMain(enterType, activityId)
  self._enterType = enterType
  self.frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actDic = self.frameCtrl:GetShowByEnterType(enterType)
  if actDic == nil or table.count(actDic) == 0 then
    error("该活动入口没有已开启活动： enterType is " .. tostring(enterType))
    return
  end
  local list = {}
  for _, activityFrameDate in pairs(actDic) do
    table.insert(list, activityFrameDate)
  end
  table.sort(list, function(a, b)
    return a.order < b.order
  end)
  self.activityTypeDic = {}
  for _, actFrameData in ipairs(list) do
    self:ActivityParamDeal(actFrameData)
  end
  if #list == 0 then
    error("该活动入口没有已开启活动： enterType is " .. tostring(enterType))
    return
  end
  self.swithItemPool:HideAll()
  self._swithItemDic = {}
  local targetInedx
  local listCount = #list
  for index, activityFrameDate in ipairs(list) do
    local item = self.swithItemPool:GetOne()
    item:InitActivitySwitchItem(activityFrameDate, self.__OnSelectActivityItem, self.resloader)
    if activityId ~= nil and activityFrameDate:GetActivityFrameId() == activityId then
      targetInedx = index
    end
    item:SetActivitySwitchLineState(index < listCount)
    self._swithItemDic[activityFrameDate:GetActivityFrameId()] = item
  end
  self:CancelAndSetActivityFrameListener(enterType)
  if targetInedx == nil then
    targetInedx = 1
  end
  self.swithItemPool.listItem[targetInedx]:SelectActivityTag()
end

function UIActivityFrameMain:__ListerShowActivity(ids, flag)
  if flag then
    for _, id in ipairs(ids) do
      local activityFrameDate = self.frameCtrl:GetActivityFrameData(id)
      if self._swithItemDic[id] == nil and activityFrameDate ~= nil and activityFrameDate:GetEnterType() == self._enterType then
        self:ActivityParamDeal(activityFrameDate)
        local item = self.swithItemPool:GetOne()
        item:InitActivitySwitchItem(activityFrameDate, self.__OnSelectActivityItem, self.resloader)
        self._swithItemDic[activityFrameDate:GetActivityFrameId()] = item
      end
    end
  else
    for _, id in ipairs(ids) do
      if id ~= self.selectedId and self._swithItemDic[id] ~= nil then
        local item = self._swithItemDic[id]
        self.swithItemPool:HideOne(item)
        self._swithItemDic[id] = nil
      end
    end
  end
  for i, item in ipairs(self.swithItemPool.listItem) do
    item:SetActivitySwitchLineState(self.swithItemPool.listItem[i + 1] ~= nil)
  end
end

function UIActivityFrameMain:OnSelectActivityItem(tag, flag)
  if flag then
    local id = tag.activityFrameData.id
    if id == self.selectedId then
      return
    end
    if self.activityTypeDic[id] == nil then
      return
    end
    local openParam = openActivityPanelParam[self.activityTypeDic[self.selectedId]]
    if self.selectedId ~= nil and self.activityTypeDic[id] ~= self.activityTypeDic[self.selectedId] then
      UIManager:DeleteWindow(openParam.UIType, true)
      local activityFrameDate = self.frameCtrl:GetActivityFrameData(self.selectedId)
      if activityFrameDate == nil then
        local item = self._swithItemDic[self.selectedId]
        self.swithItemPool:HideOne(item)
        self._swithItemDic[self.selectedId] = nil
      end
      for i, item in ipairs(self.swithItemPool.listItem) do
        item:SetActivitySwitchLineState(self.swithItemPool.listItem[i + 1] ~= nil)
      end
    end
    self.selectedId = id
    openParam = openActivityPanelParam[self.activityTypeDic[self.selectedId]]
    UIManager:ShowWindowAsync(openParam.UIType, function(window)
      window.transform:SetParent(self.ui.pageNode)
      window[openParam.InitFunction](window, tag.activityFrameData.actId)
      if UIUtil.CheckTopIsWindow(openParam.UIType) then
        UIUtil.PopFromBackStackByWinId(openParam.UIType)
        UIUtil.ReShowTopStatus()
      end
    end)
  end
end

function UIActivityFrameMain:CancelAndSetActivityFrameListener(enterType)
  self.entertype = enterType
  local oldRedDotDynPath = self.redDotDynPath
  local node
  if enterType == ActivityFrameEnum.eActivityEnterType.Novice then
    self.redDotDynPath = RedDotDynPath.ActivityFrameNovicePath
    _, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityInHome, RedDotStaticTypeId.ActivityFrameNovice)
  elseif enterType == ActivityFrameEnum.eActivityEnterType.LimitTime then
    self.redDotDynPath = RedDotDynPath.ActivityFrameLimitTimePath
    _, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityInHome, RedDotStaticTypeId.ActivityFrameLimitTime)
  else
    self.redDotDynPath = nil
  end
  if node ~= nil then
    self:OnListenerActivityCallback(node)
  end
  if oldRedDotDynPath ~= self.redDotDynPath then
    if self.__OnListenerActivityCallback == nil then
      self.__OnListenerActivityCallback = BindCallback(self, self.OnListenerActivityCallback)
    end
    if oldRedDotDynPath ~= nil then
      RedDotController:RemoveListener(oldRedDotDynPath, self.__OnListenerActivityCallback)
    end
    if self.redDotDynPath ~= nil then
      RedDotController:AddListener(self.redDotDynPath, self.__OnListenerActivityCallback)
    end
  end
end

function UIActivityFrameMain:OnListenerActivityCallback(node)
  for _, swithItem in pairs(self.swithItemPool.listItem) do
    local childNode = node:GetChild(swithItem.activityFrameData.id)
    swithItem:ActivityTagReddotShow(childNode ~= nil and childNode:GetRedDotCount() > 0)
  end
end

function UIActivityFrameMain:SetTagPageNodeState(flag)
  self.ui.tagPageNode:SetActive(flag)
end

function UIActivityFrameMain:OnClickClose()
  self:OnCloseWin()
  self:Delete()
end

function UIActivityFrameMain:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.ActivityShowChange, self.__ListerShowActivityCallback)
  self:CancelAndSetActivityFrameListener(nil)
  if self.selectedId ~= nil then
    local openParam = openActivityPanelParam[self.activityTypeDic[self.selectedId]]
    UIManager:DeleteWindow(openParam.UIType, true)
  end
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self.swithItemPool:DeleteAll()
  local openParam = openActivityPanelParam[self.activityTypeDic[self.selectedId]]
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIActivityFrameMain
