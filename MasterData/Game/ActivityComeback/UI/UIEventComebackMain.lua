local UIEventComebackMain = class("UIEventComebackMain", UIBaseWindow)
local base = UIBaseWindow
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local UINActivityComebackTap = require("Game.ActivityComeback.UI.UINActivityComebackTap")
local JumpManager = require("Game.Jump.JumpManager")
local ActivityUIType = {
  ComebackSign = 1,
  ComebackFund = 2,
  ComebackTask = 3,
  ComebackExchage = 4,
  ComebackShop = 5,
  ComebackSystem = 6
}
local ActivityPanemParam = {
  [ActivityUIType.ComebackSign] = {
    UIName = "UI_EventComebackSignNode",
    InitFunction = "InitCombackSingIn",
    UITable = "Game.ActivityComeback.UI.UINEventComebackSignIn"
  },
  [ActivityUIType.ComebackFund] = {
    UIName = "UI_EventComebackGrowNode",
    InitFunction = "InitCombackFund",
    UITable = "Game.ActivityComeback.UI.UINEventComebackFund"
  },
  [ActivityUIType.ComebackTask] = {
    UIName = "UI_EventComebackTaskNode",
    InitFunction = "InitCombackTask",
    UITable = "Game.ActivityComeback.UI.UINEventComebackTask"
  },
  [ActivityUIType.ComebackExchage] = {
    UIName = "UI_EventComebackExchangeNode",
    InitFunction = "InitComebackExchange",
    UITable = "Game.ActivityComeback.UI.UINEventComebackExchange"
  },
  [ActivityUIType.ComebackShop] = {
    UIName = "UI_EventComebackShopNode",
    InitFunction = "InitComebackShop",
    UITable = "Game.ActivityComeback.UI.UINEventComebackShop"
  },
  [ActivityUIType.ComebackSystem] = {
    UIName = "UI_EventComebackSystemNode",
    InitFunction = "InitComebackSystem",
    UITable = "Game.ActivityComeback.UI.UINEventComebackSystem"
  }
}

function UIEventComebackMain:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickBack)
  self._tapPool = UIItemPool.New(UINActivityComebackTap, self.ui.pageItem)
  self.ui.pageItem:SetActive(false)
  self.__ClickTapFunc = BindCallback(self, self.__ClickTap)
  self._resloader = CS.ResLoader.Create()
  self._waitLoadingTable = {}
  UIUtil.AddButtonListener(self.ui.btn_lotteyJump, self, self.OnClickLotteryJumpBtn)
end

function UIEventComebackMain:InitActivityCombackMain(activityId)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local activityDataDic = self._activityCtrl:GetShowByEnterType(ActivityFrameEnum.eActivityEnterType.Comeback)
  self._tapPool:HideAll()
  local list = {}
  for activityId, activityFrameData in pairs(activityDataDic) do
    table.insert(list, activityFrameData)
  end
  table.sort(list, function(a, b)
    if a.order ~= b.order then
      return a.order < b.order
    end
    return a:GetActivityFrameId() < b:GetActivityFrameId()
  end)
  if #list == 0 then
    error("回归活动没有内容")
    return
  end
  self:__ActivityParamDeal(list)
  local comebackCtrl = ControllerManager:GetController(ControllerTypeId.ActivityComeback)
  local comebackData = comebackCtrl:GetTheLatestComebackData()
  local comebackCfg = comebackData:GetComebackCfg()
  self._showItemIds = comebackCfg.showitem_id
  local selectActFrameData
  for i, actData in ipairs(list) do
    if actData:GetActivityFrameCat() ~= ActivityFrameEnum.eActivityType.Comeback or comebackCfg.inPage ~= 0 then
      local item = self._tapPool:GetOne()
      item:InitActivityCombackTap(actData, self.__ClickTapFunc, self._resloader)
      local isSelect = actData:GetActivityFrameId() == activityId
      item:RefreshCombackTapSelect(isSelect)
      if isSelect then
        selectActFrameData = actData
      end
    end
  end
  if selectActFrameData == nil then
    selectActFrameData = self._tapPool.listItem[1]:GetActivityCombackData()
  end
  self:__ClickTap(selectActFrameData)
  self._finishTime = selectActFrameData.destoryTime
  self._timerId = TimerManager:StartTimer(1, self.__CutDown, self)
  self:__CutDown()
  self:__SetReddotListener()
  self:RefreshJumpBtnShow()
end

function UIEventComebackMain:RefreshJumpBtnShow()
  self.ui.btn_lotteyJump.gameObject:SetActive(false)
  local poolGroupDataList = PlayerDataCenter.allLtrData:GetOpeningLtrGroupPoolDataList()
  for index, poolGroupData in ipairs(poolGroupDataList) do
    self.canJump, self.jumpPoolId = poolGroupData:CanJumpByExternal()
    if self.canJump then
      self.ui.btn_lotteyJump.gameObject:SetActive(true)
      break
    end
  end
end

function UIEventComebackMain:OnClickLotteryJumpBtn()
  if not self.canJump then
    return
  end
  JumpManager:Jump(JumpManager.eJumpTarget.DynLottery, nil, nil, {
    self.jumpPoolId,
    nil
  })
end

function UIEventComebackMain:__ActivityParamDeal(activityList)
  self._activityUItype = {}
  self._activityUIEntity = {}
  for _, actFrameData in ipairs(activityList) do
    local UIType
    if actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.SevenDayLogin then
      UIType = ActivityUIType.ComebackSign
    elseif actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.BattlePass then
      UIType = ActivityUIType.ComebackFund
    elseif actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Task then
      UIType = ActivityUIType.ComebackTask
    elseif actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Round then
      UIType = ActivityUIType.ComebackExchage
    elseif actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Comeback then
      UIType = ActivityUIType.ComebackShop
      self:__RecordAvg(actFrameData)
      local activityCfg = ConfigData.activity[actFrameData:GetActivityFrameId()]
      if activityCfg ~= nil and activityCfg.rule_id > 0 then
        UIUtil.SetTopStateInfoFunc(self, function()
          UIManager:CreateWindowAsync(UIWindowTypeID.CommonRuleInfo, function(window)
            if window == nil then
              return
            end
            window:InitCommonRule(activityCfg.rule_id)
          end)
        end)
      end
    elseif actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.ComebackNewSystem then
      UIType = ActivityUIType.ComebackSystem
    else
      error("活动没有面板 " .. tostring(actFrameData:GetActivityFrameId()))
    end
    if UIType ~= nil then
      local frameId = actFrameData:GetActivityFrameId()
      self._activityUItype[frameId] = UIType
    end
  end
end

function UIEventComebackMain:__ClickTap(activityData)
  if activityData == nil then
    return
  end
  local frameId = activityData:GetActivityFrameId()
  if self._activityUItype[frameId] == nil then
    return
  end
  if self._selectActData ~= nil then
    local uiType = self._activityUItype[self._selectActData:GetActivityFrameId()]
    local entity = self._activityUIEntity[uiType]
    if entity ~= nil then
      entity:Hide()
    end
  end
  self._selectActData = activityData
  for _, tap in ipairs(self._tapPool.listItem) do
    local actData = tap:GetActivityCombackData()
    if actData ~= nil then
      local isSelect = actData:GetActivityFrameId() == frameId
      tap:RefreshCombackTapSelect(isSelect)
    else
      tap:RefreshCombackTapSelect(false)
    end
  end
  local uiType = self._activityUItype[frameId]
  local entity = self._activityUIEntity[uiType]
  local panelParam = ActivityPanemParam[uiType]
  if uiType == ActivityUIType.ComebackFund then
    UIUtil.RefreshTopResId(nil)
  else
    UIUtil.RefreshTopResId(self._showItemIds)
  end
  if entity ~= nil then
    entity:Show()
    entity[panelParam.InitFunction](entity, activityData:GetActId())
  elseif not self._waitLoadingTable[uiType] then
    self._waitLoadingTable[uiType] = true
    self._resloader:LoadABAssetAsync(PathConsts:GetActivityComebackPrefab(panelParam.UIName), function(prefab)
      if IsNull(self.transform) or IsNull(prefab) then
        return
      end
      local obj = prefab:Instantiate(self.ui.frameHolder.transform)
      obj.transform.localPosition = Vector3.zero
      obj.transform.localScale = Vector3.one
      local newEntity = require(panelParam.UITable).New()
      self._activityUIEntity[uiType] = newEntity
      self._waitLoadingTable[uiType] = nil
      newEntity:Init(obj)
      local isNeedShow = activityData == self._selectActData
      if isNeedShow then
        newEntity[panelParam.InitFunction](newEntity, activityData:GetActId())
      else
        newEntity:Hide()
      end
      if uiType == ActivityUIType.ComebackSign then
        if self.__PlayAvgCallback == nil then
          self.__PlayAvgCallback = BindCallback(self, self.__PlayAvg)
        end
        newEntity:SetPlayComebackAvg(self.__PlayAvgCallback)
      end
    end)
  end
end

function UIEventComebackMain:__CutDown()
  if self._finishTime == -1 then
    if self._timerId ~= nil then
      TimerManager:StopTimer(self._timerId)
      self._timerId = nil
    end
    self.ui.tex_Time:SetIndex(2, "0")
    return
  end
  local diff = self._finishTime - PlayerDataCenter.timestamp
  if diff <= 0 then
    if self._timerId ~= nil then
      TimerManager:StopTimer(self._timerId)
      self._timerId = nil
    end
    self.ui.tex_Time:SetIndex(2, "0")
    UIUtil.OnClickBackByUiTab(self)
    return
  end
  if diff < 60 then
    self.ui.tex_Time:SetIndex(2, "0")
  elseif diff < 3600 then
    self.ui.tex_Time:SetIndex(2, tostring(math.floor(diff // 60)))
  elseif diff < 86400 then
    self.ui.tex_Time:SetIndex(1, tostring(math.floor(diff // 3600)))
  else
    self.ui.tex_Time:SetIndex(0, tostring(math.floor(diff // 86400)))
  end
end

function UIEventComebackMain:__RecordAvg(actFrameData)
  local comebackCtrl = ControllerManager:GetController(ControllerTypeId.ActivityComeback)
  if comebackCtrl == nil then
    return
  end
  local comebackData = comebackCtrl:GetComebackData(actFrameData:GetActId())
  if comebackData == nil then
    return
  end
  self._avgId = comebackData:GetComebackAvgId()
  local comebackCfg = comebackData:GetComebackCfg()
  self._showItemIds = comebackCfg.showitem_id
end

function UIEventComebackMain:__PlayAvg()
  if self._avgId == nil then
    return
  end
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  avgCtrl:StartAvg(nil, self._avgId)
end

function UIEventComebackMain:__OnClickBack()
  self:OnCloseWin()
  self:Delete()
end

function UIEventComebackMain:__SetReddotListener()
  if self.__reddotListenerCallback == nil then
    self.__reddotListenerCallback = BindCallback(self, self.__RefreshReddot)
    RedDotController:AddListener(RedDotDynPath.ActivityComebackPath, self.__reddotListenerCallback)
  end
  local _, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivityInHome, RedDotStaticTypeId.ActivityComeback)
  if node ~= nil then
    self:__RefreshReddot(node)
  end
end

function UIEventComebackMain:__CancleReddotListener()
  if self.__reddotListenerCallback ~= nil then
    RedDotController:RemoveListener(RedDotDynPath.ActivityComebackPath, self.__reddotListenerCallback)
    self.__reddotListenerCallback = nil
  end
end

function UIEventComebackMain:__RefreshReddot(node)
  for _, tap in pairs(self._tapPool.listItem) do
    local actFrameData = tap:GetActivityCombackData()
    local childNode = node:GetChild(actFrameData.id)
    tap:SetComebackTabReddot(childNode ~= nil and childNode:GetRedDotCount() > 0)
  end
end

function UIEventComebackMain:OnDelete()
  base.OnDelete(self)
  self:__CancleReddotListener()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  if self._activityUIEntity ~= nil then
    for k, v in pairs(self._activityUIEntity) do
      v:Delete()
    end
    self._activityUIEntity = nil
  end
  self._activityUItype = nil
end

return UIEventComebackMain
