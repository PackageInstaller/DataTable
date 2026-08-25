local ActivityAwakerTopicComp, Super = System.NewClass("ActivityAwakerTopicComp", ActivityMagicStoryComp)
local UIAnimationController = CS.Z1Client.UIAnimationController
local FindChild = CS.Framework.GameObjectUtil.FindChild

function ActivityAwakerTopicComp:ctor(res, activityTid, model, params)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.activtyDefine = ActivityDataUtils.GetActivityCompInfoByTid(activityTid)
  self.resonanceGroupId = self.activtyDefine.resonanceGroup
  self.ui = self.activtyDefine.resPath(res)
  self.hasFinishedActivity = ActivityManager.Instance:IsActivityFinishedByTid(self.activityTid)
  self.audioPlay = true
  if params then
    self.audioPlay = params.audioPlay
  end
end

function ActivityAwakerTopicComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:_BindActivityTimer()
  self:_BindPortraitComp()
  self:_SetActivityPlot()
  self:BindLockState()
  self:BindResonanceProgress()
  self:BindShopItem()
  self:BindLottery()
  self:BindAchievementProgress()
  self:BindSubPlotRecord()
  self:BindBtnChallenge()
  self:BindDonationBoxEntrance()
  self:_BindSkinTaskComp()
  if self.ui.Btn_PlayPV then
    self.binder:BindButtonClick(self.ui.Btn_PlayPV, System.fn(self, self._OnClickPlayPV))
  end
end

function ActivityAwakerTopicComp:BindShopItem()
  local shopList = ActivityDataUtils.GetShopList(self.activityTid)
  if not table.next(shopList) then
    if not table.next(ActivityDataUtils.GetLotteryList(self.activityTid)) then
      self.binder:SetActive(self.ui.Btn_Shop, false)
    end
    return
  end
  self.binder:SetActive(self.ui.Btn_Shop, true)
  local showMoneyGroup = {}
  for idx, tid in ipairs(shopList) do
    local shopTypeConfig = ShopExtModel.Instance:GetShopTypeConfig(tid)
    local shopMoney = shopTypeConfig and shopTypeConfig.ShowMoney or {}
    for _, itemId in ipairs(shopMoney) do
      if not table.contains(showMoneyGroup, itemId) then
        table.insert(showMoneyGroup, itemId)
      end
    end
  end
  self:BindCoin(showMoneyGroup)
  self.binder:BindZ1Button(self.ui.Btn_Shop, function()
    ShopController.Instance:OpenActivityShopView(self.activityTid)
  end)
  local groupRedDot = FindChild(self.ui.Red_Shop, "Group_RedDot")
  if groupRedDot then
    self.binder:SetActive(groupRedDot.gameObject, false)
  end
  self.binder:BindComponent(UICompRedDotNewVue(self.ui.Red_Shop, RedDotDefine.DynamicRedDotID.ActivityShopEntry, {
    activityTid = self.activityTid
  }))
end

function ActivityAwakerTopicComp:BindLottery()
  local lotteryIdList = ActivityDataUtils.GetLotteryList(self.activityTid)
  if not table.next(lotteryIdList) then
    if not table.next(ActivityDataUtils.GetShopList(self.activityTid)) then
      self.binder:SetActive(self.ui.Btn_Shop, false)
    end
    return
  end
  local showMoneyGroup = {}
  for _, lotteryId in pairs(lotteryIdList) do
    local cfg = DT.Lottery[lotteryId]
    for _, itemId in pairs(cfg.CurrencyColumn) do
      if not table.contains(showMoneyGroup, itemId) then
        table.insert(showMoneyGroup, itemId)
      end
    end
  end
  self:BindCoin(showMoneyGroup)
  self.binder:SetActive(self.ui.Btn_Shop, true)
  self.binder:BindZ1Button(self.ui.Btn_Shop, function()
    ActivityDrawPrizeController.Instance:OpenActivityDrawPrizePoolView(lotteryIdList)
  end)
  self.binder:BindComponent(RedDotComponent(self.ui.Red_Shop, nil, nil, function()
    local isRed = false
    for _, lotteryTid in pairs(lotteryIdList) do
      isRed = isRed or RedPointDataUtils.GetLotteryPoolRed(lotteryTid)
    end
    return isRed
  end))
end

function ActivityAwakerTopicComp:BindCoin(showMoneyGroup)
  for index = 1, 3 do
    local showMoneyId = showMoneyGroup[index]
    local imageGo = self.ui["Image_Currency_0" .. index]
    local numTextGo = self.ui["Text_Currency_0" .. index]
    if not showMoneyId then
      if imageGo then
        imageGo:SetActive(false)
      end
      if numTextGo then
        numTextGo:SetActive(false)
      end
    else
      if imageGo then
        imageGo:SetActive(true)
      end
      if numTextGo then
        numTextGo:SetActive(true)
      end
      local moneyItemCfg = showMoneyId and ItemDataUtils.GetItemConfig(showMoneyId)
      if moneyItemCfg and imageGo and numTextGo then
        self.binder:BindToText(numTextGo, function()
          do return ItemDataUtils.GetItemNum end
          return ItemDataUtils.GetItemNum, showMoneyId
        end)
        self.binder:SetImageSync(imageGo, ItemDataUtils.GetIcon(showMoneyId))
      end
    end
  end
  self.binder:BindToRaw(function()
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Currency)
  end, function()
    local listenedItemList = {}
    for index = 1, 3 do
      local showMoneyId = showMoneyGroup[index]
      table.insert(listenedItemList, ItemDataUtils.GetItemNum(showMoneyId))
    end
    return listenedItemList
  end)
end

function ActivityAwakerTopicComp:BindAchievementProgress()
  local parentTaskList = ActivityDataUtils.GetTaskList(self.activityTid)
  self.binder:BindToVisible(self.ui.Btn_Reward, function()
    local taskList = self.activityData.taskList
    return taskList and table.next(taskList)
  end)
  self.binder:BindZ1Button(self.ui.Btn_Reward, function()
    local taskList = self.activityData.taskList
    UIManager.Instance:Reopen(Urls.ActivityAchievementPanel, self.activityData, parentTaskList, taskList)
  end)
  self.binder:BindToText(self.ui.Text_AchieveProgress, function()
    local taskList = self.activityData.taskList
    local percent = self:GetTaskProgressPercent(taskList, parentTaskList)
    do return string.format, "%s%%" end
    return string.format, "%s%%", percent
  end)
  self.binder:BindComponent(NewRedCom(self.ui.Red_Achieve)):BindActivityTask(self.activityData)
end

function ActivityAwakerTopicComp:BindSubPlotRecord()
  Super.BindSubPlotRecord(self)
end

function ActivityAwakerTopicComp:BindBtnChallenge()
  if self.hasFinishedActivity then
    self.ui.Btn_Challenge:SetActive(false)
    return
  end
  local stageGroupList = ActivityCfgUtils.GetStageGroupList(self.activityTid)
  if not stageGroupList or not table.next(stageGroupList) then
    self.binder:SetActive(self.ui.Btn_Challenge, false)
    return
  end
  self.binder:SetActive(self.ui.Btn_Challenge, true)
  self.binder:BindZ1Button(self.ui.Btn_Challenge, function()
    ActivityController.Instance:OpenActivityStageGroupPanel(self.activityData, self.resonanceGroupId)
  end)
  self:BindNewStageGroupRed(stageGroupList)
end

function ActivityAwakerTopicComp:PlayTimeline(timelinePath)
  self:ClearTimeline()
  self.player = self.ui.uiNode
  self.timelinePlayer = PortraitTimelinePlayer(self.player)
  local timelineConfig = TimelineConfig()
  timelineConfig.assetPath = timelinePath
  self.timelinePlayer:Play(timelineConfig)
end

function ActivityAwakerTopicComp:ClearTimeline()
  if self.timelinePlayer then
    self.timelinePlayer:Stop()
    self.timelinePlayer:Dispose()
    self.timelinePlayer = nil
  end
end

function ActivityAwakerTopicComp:OnOpenAnim(callback)
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(self.audioPlay)
  if not self.audioPlay then
    self.audioPlay = true
  end
  if self.activtyDefine.openAnim then
    self.uiAnimController:PlayState(self.activtyDefine.openAnim, callback)
  elseif self.activtyDefine.openTimeline then
    self.ui.uiNode:SetActive(true)
    self:PlayTimeline(self.activtyDefine.openTimeline)
  else
    self.ui.uiNode:SetActive(true)
    if callback then
      callback()
    end
  end
end

function ActivityAwakerTopicComp:OnCloseAnim(callback)
  self:ClearTimeline()
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(false)
  if self.activtyDefine.closeAnim then
    self.uiAnimController:PlayState(self.activtyDefine.closeAnim, callback)
    return
  end
  if self.activtyDefine.endTimeline then
    self:PlayTimeline(self.activtyDefine.endTimeline)
    return
  end
  self.ui.uiNode:SetActive(false)
  if callback then
    callback()
  end
end

function ActivityAwakerTopicComp:OnUnbind()
  Super.OnUnbind(self)
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(false)
  self:ClearTimeline()
end

return ActivityAwakerTopicComp
