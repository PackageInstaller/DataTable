local LotteryPage = CommonDefine.LotteryPage
local ActivityDrawPrizeMainView, Super = NewClass("ActivityDrawPrizeMainView", BaseView)
ActivityDrawPrizeMainView.uiResCls = UI_Event_Activity_MainResource

function ActivityDrawPrizeMainView:ctor()
  Super.ctor(self)
  self.model = ActivityDrawPrizeModel.Instance
  self.model:InitViewData()
  self.childrenTapViews = {
    [LotteryPage.Pool] = {
      UIUrl = Urls.ActivityDrawPrizePoolView,
      UINodeName = "UI_Event_Activity_RewardList",
      viewInstance = nil,
      Name = "ActivityDrawPrizePoolView"
    },
    [LotteryPage.Result] = {
      UIUrl = Urls.ActivityDrawPrizeResultView,
      UINodeName = "UI_Event_Activity_RewardResult",
      viewInstance = nil,
      Name = "ActivityDrawPrizeResultView"
    }
  }
  self.toggleInfoGroup = {}
  self.oldSelectTab = nil
  self.oldSelectPage = nil
  self.rewComp = nil
end

function ActivityDrawPrizeMainView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnActivityDrawPrizePoolTabChanged, self._RefreshView, self)
  self:RegisterLocalNotify(NotifyId.OnActivityLotteryDataUpdated, self._RefreshView, self)
  self:RegisterLocalNotify(NotifyId.OnActivityPageChanged, self.SwitchPage, self)
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
end

function ActivityDrawPrizeMainView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Role, function()
    local lotteryTid = self.model.tabGroupViewsData[1]
    if not lotteryTid then
      return
    end
    local ruleContent = DT.Lottery[lotteryTid].RuleContent
    UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("LotteryRuleTitle"), LT.Text(ruleContent))
  end)
end

function ActivityDrawPrizeMainView:_OnBagItemDataChanged(_, tid)
  local singleDrawconsume = ActivityDrawPrizeModel.Instance:GetLotteryCfgByField("SingleDrawconsume", self.model.curSelectTab)
  local costTid = singleDrawconsume[1] or 0
  if costTid == tid then
    self:_RefreshDrawComp()
  end
end

function ActivityDrawPrizeMainView:_RefreshCoinGroup()
  local currencyList = self.model:GetLotteryCfgByField("CurrencyColumn", self.model.curSelectTab)
  self:AddViewComponentOnce(self.ui.Coin_Group, UICompCommonCurrencyGroupItem, currencyList)
end

function ActivityDrawPrizeMainView:SwitchPage(page)
  if not self.oldSelectPage then
    self.oldSelectPage = page
  elseif self.oldSelectPage ~= page then
    self.oldSelectPage = page
    if self.uiAnimationCtr then
      self.uiAnimationCtr:StopPlayableGraph()
      if page == CommonDefine.LotteryPage.Pool then
        self.uiAnimationCtr:PlayState("UI_Event_Activity_Main_Result_Close")
      else
        self.uiAnimationCtr:PlayState("UI_Event_Activity_Main_Result_Open")
      end
    end
  end
  self:SwitchChildTapView(page)
  self:_RefreshView()
end

function ActivityDrawPrizeMainView:OnEnterView()
  Super.OnEnterView(self)
  self.uiAnimationCtr = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self:_InitCompToggle()
  self:_InitCompCloseBtn()
  self:SwitchPage(LotteryPage.Pool)
  local titleDesc = DT.Lottery[self.model.tabGroupViewsData[1]].DrawTitle
  self:SetText(self.ui.Text_Title, LT.Text(titleDesc))
end

local function CreateToggleInfo(gameObj, lotteryTid)
  return {gameObj = gameObj, lotteryTid = lotteryTid}
end

function ActivityDrawPrizeMainView:_InitCompToggle()
  for _, lotteryTid in ipairs(self.model.tabGroupViewsData) do
    local gameObj = GameObject.Instantiate(self.ui.UI_Common_Toggle_Item, self.ui.TabCon.transform)
    gameObj:SetActive(true)
    gameObj:GetComponent(typeof(CS.Z1Client.Z1Toggle)).group = self.ui.TabCon:GetComponent(typeof(CS.Z1Client.Z1ToggleGroup))
    table.insert(self.toggleInfoGroup, CreateToggleInfo(gameObj, lotteryTid))
    local cfg = DT.Lottery[lotteryTid]
    local selectIcon = cfg.Icon and cfg.Icon[1] or nil
    local normalIcon = cfg.Icon and cfg.Icon[2] or nil
    local toggleResUI = UI_Common_Item_Toggle_2Resource(gameObj)
    self:SetImage(toggleResUI.Image_Sel_Icon, selectIcon)
    self:SetImage(toggleResUI.Image_Nor_Icon, normalIcon)
    local now = TimeUtils.GetServerTime()
    local openTime = cfg.OpenDate or 0
    local isOpen = now > openTime
    self:SetActive(toggleResUI.Group_Disable, not isOpen)
    self:SetZ1ToggleInteractable(gameObj, isOpen)
    if not isOpen then
      self:BindTimer(openTime - now, 0, nil, function()
        self:SetActive(toggleResUI.Group_Disable, false)
        self:SetZ1ToggleInteractable(gameObj, true)
      end)
      self:AddButtonClickListener(toggleResUI.Group_Disable, function()
        if now < openTime then
          local leftTimeStr = TimeUtils.format2Hour(openTime - now)
          Alert.ShowWithParams(20217, {
            LT.Text(cfg.Name),
            leftTimeStr
          })
          return
        end
      end)
    end
    self:AddZ1ToggleValueChangedListener(gameObj, function()
      self.model:Set_curSelectTab(lotteryTid)
      RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.NewLotteryOpen, RedPointDataUtils.RedAttrType.IsNew, lotteryTid)
    end)
  end
  for index = 1, #self.toggleInfoGroup do
    local toggleInfo = self.toggleInfoGroup[index]
    local lotteryTid = toggleInfo.lotteryTid
    local gameObj = toggleInfo.gameObj
    if self.model.curSelectTab == lotteryTid then
      self:SetZ1Toggle(gameObj, true)
    end
  end
end

function ActivityDrawPrizeMainView:_RefreshDrawComp()
  local viewData = {
    lotteryTid = self.model.curSelectTab,
    drawBtnText = DT.Lottery[self.model.tabGroupViewsData[1]].DrawBtnText
  }
  if self.ui and self.ui.UI_Event_Activity_RewardPool then
    self.rewComp = self:AddViewComponentOnce(self.ui.UI_Event_Activity_RewardPool, CompActivityDrawGroup, viewData)
  end
end

function ActivityDrawPrizeMainView:_InitCompCloseBtn()
  self:AddViewComponent(self.ui.Btn_Close, UICompBtnCloseItem, function()
    if self.model.curPage == CommonDefine.LotteryPage.Result then
      self.model:Set_curPage(CommonDefine.LotteryPage.Pool)
      return
    end
    self:Close()
  end)
end

function ActivityDrawPrizeMainView:_RefreshToggleState()
  for index = 1, #self.toggleInfoGroup do
    local toggleInfo = self.toggleInfoGroup[index]
    local lotteryTid = toggleInfo.lotteryTid
    local gameObj = toggleInfo.gameObj
    self:AddViewComponentOnce(UI_Common_Item_Toggle_2Resource(gameObj).Com_RedDot, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, function()
      do return RedPointDataUtils.GetLotteryPoolRed end
      return RedPointDataUtils.GetLotteryPoolRed, lotteryTid
    end)
  end
end

function ActivityDrawPrizeMainView:_RefreshView(curSelectTab)
  curSelectTab = curSelectTab or self.model.curSelectTab
  local needPlayChange = false
  if curSelectTab then
    if not self.oldSelectTab then
      self.oldSelectTab = curSelectTab
    elseif self.oldSelectTab ~= curSelectTab then
      self.oldSelectTab = curSelectTab
      needPlayChange = true
    end
  end
  self:_RefreshCoinGroup()
  self:_RefreshDrawComp()
  self:_RefreshToggleState()
  if needPlayChange and self.uiAnimationCtr then
    self.uiAnimationCtr:StopPlayableGraph()
    self.uiAnimationCtr:PlayState("UI_Event_Activity_Main_Change", function()
      self:_OnCloseAnimCompleted()
    end)
  end
  local closeBtnImage = self.model.curPage == CommonDefine.LotteryPage.Result and "UIResources/AtlasSource/UI_Common_Image/UI_Common_D_Image_Btn_Back_Icon.png" or "UIResources/AtlasSource/HD/UI_Common_Image/UI_Common_D_Image_Btn_Close_Icon.png"
  self:SetImage(self.ui.Image_Icon, closeBtnImage)
  local showTab = #self.model.tabGroupViewsData > 1 and self.model.curPage ~= CommonDefine.LotteryPage.Result
  self.ui.TabCon:SetActive(showTab)
  local BgPath = ActivityDrawPrizeModel.Instance:GetLotteryCfgByField("BgResources", curSelectTab)
  if not string.isempty(BgPath) then
    self:SetImageSync(self.ui.Image_Bg, BgPath)
  end
end

function ActivityDrawPrizeMainView:_OnCloseAnimCompleted()
  if not (self.ui and self.ui.uiNode) or IsNil(self.ui.uiNode) then
    return
  end
  local poolView = self.childrenTapViews and self.childrenTapViews[LotteryPage.Pool] and self.childrenTapViews[LotteryPage.Pool].viewInstance
  if poolView and poolView._RestoreCanvasGroupAlpha then
    poolView:_RestoreCanvasGroupAlpha()
  end
  local drawComp = self.rewComp
  if self.ui and self.ui.UI_Event_Activity_RewardPool and drawComp and drawComp._RestoreNpcAlpha then
    drawComp:_RestoreNpcAlpha()
  end
end

function ActivityDrawPrizeMainView:OnExitView()
  self.oldSelectTab = nil
  self.rewComp = nil
  self:_DestroyTimer()
  Super.OnExitView(self)
end

function ActivityDrawPrizeMainView:_DestroyTimer()
  if self.timer then
    self:StopTimer(self.timer)
    self.timer = nil
  end
end

return ActivityDrawPrizeMainView
