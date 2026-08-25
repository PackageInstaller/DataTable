local ActivityPVPReRoundComp, Super = System.NewClass("ActivityPVPReRoundComp", ActivityMagicStoryComp)
local UIAnimationController = CS.Z1Client.UIAnimationController

function ActivityPVPReRoundComp:ctor(res, activityTid, model, params)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.activtyDefine = ActivityDefine.ActivityCompClsInfo[self.activityConfig.ActivityType]
  self.resonanceGroupId = self.activtyDefine.resonanceGroup
  self.ui = self.activtyDefine.resPath(res)
  self.hasFinishedActivity = ActivityManager.Instance:IsActivityFinishedByTid(self.activityTid)
  self.audioPlay = true
  if params then
    self.audioPlay = params.audioPlay
  end
end

function ActivityPVPReRoundComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.binder:SetText(self.ui.Text_C_Topic, ActivityDataUtils.GetActivityName(self.activityTid))
  self:_BindActivityTimer()
  self:_BindPortraitComp()
  self:BindLockState()
  self:BindScoreTask()
  self:BindLottery()
  self:BindAchievementProgress()
  self:_SetActivityPlot()
  self:BindPVPBtn()
  self:BindPlotBtn()
  self:BindDonationBoxEntrance()
  if self.ui.Btn_PlayPV then
    self.binder:BindButtonClick(self.ui.Btn_PlayPV, System.fn(self, self._OnClickPlayPV))
  end
end

function ActivityPVPReRoundComp:BindPVPBtn()
  self.binder:BindZ1Button(self.ui.Btn_Challenge, function()
    UIManager.Instance:Reopen(Urls.MainPanelPVP)
  end)
  self.binder:SetActive(self.ui.NewTag_Challenge, false)
end

function ActivityPVPReRoundComp:BindPlotBtn()
  local subPlotGroupId = table.unpack(self.activityConfig.ActivityPara4)
  self.binder:BindZ1Button(self.ui.Btn_Record, function()
    CopyDataUtils.OnClickSubPlotEntry(subPlotGroupId, self.activityTid, true)
  end)
  self.binder:SetActive(self.ui.NewTag_Record, false)
end

function ActivityPVPReRoundComp:BindScoreTask()
  local title = LT.Text("ReRoundRewardTitle")
  local coinTid = self.activityConfig.ActivityPara2
  local showMoneyGroup = {coinTid}
  self:BindCoin(showMoneyGroup)
  local taskList = TaskDataUtils.GetTaskListParentTask(DT.GetConstant("PVPReRoundScoreTask"))
  self.binder:BindZ1Button(self.ui.Btn_Shop, function()
    local extraData = {
      title = title,
      bottomText = LT.Textf("ReRoundScoreStr", ItemDataUtils.GetItemNum(coinTid))
    }
    UIManager.Instance:Reopen(Urls.ActivityTaskListPanel, self.activityTid, taskList, extraData)
  end)
  self.binder:SetText(self.ui.Text_C_Shop, title)
  self.binder:BindComponent(NewRedCom(self.ui.Red_Shop)):BindTaskList(taskList)
end

function ActivityPVPReRoundComp:BindLottery()
  local lotteryIdList = ActivityDataUtils.GetLotteryList(self.activityTid)
  if not table.next(lotteryIdList) then
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

function ActivityPVPReRoundComp:BindCoin(showMoneyGroup)
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

function ActivityPVPReRoundComp:BindAchievementProgress()
  self.binder:BindToVisible(self.ui.Btn_Reward, function()
    local taskList = self.activityData.taskList
    return taskList and table.next(taskList)
  end)
  self.binder:BindZ1Button(self.ui.Btn_Reward, function()
    local ActivityPara1 = self.activityConfig.ActivityPara1
    UIManager.Instance:Reopen(Urls.ActivityPVPReRoundAchieve, self.activityData, ActivityPara1)
  end)
  self.binder:BindToRaw(function(cbinder)
    local activityData = ActivityDataUtils.GetActivityData(self.activityTid)
    local taskList = activityData and activityData.taskList or {}
    local ActivityPara1 = self.activityConfig.ActivityPara1
    local parentTaskMap = {}
    for _, taskId in pairs(ActivityPara1) do
      parentTaskMap[taskId] = true
    end
    local redTaskList = {}
    for taskId, taskData in pairs(taskList) do
      local taskCfg = DT.Task[taskId] or {}
      local belongTask = taskCfg.BelongTaskGroup
      if parentTaskMap[belongTask] then
        redTaskList[taskId] = taskData
      end
    end
    cbinder:BindComponent(NewRedCom(self.ui.Red_Achieve)):BindTaskList(redTaskList)
  end, function()
    do return ActivityDataUtils.GetActivityData end
    return ActivityDataUtils.GetActivityData, self.activityTid
  end)
end

function ActivityPVPReRoundComp:BindSubPlotRecord()
  Super.BindSubPlotRecord(self)
end

function ActivityPVPReRoundComp:_RedFunc()
  local shopTypeList = ShopExtModel.Instance:GetShopTypeListByActivityTid(self.activityTid)
  do return RedPointDataUtils.GetShopRedByShopTypes end
  return RedPointDataUtils.GetShopRedByShopTypes, shopTypeList
end

function ActivityPVPReRoundComp:PlayTimeline(timelinePath)
  self:ClearTimeline()
  self.player = self.ui.uiNode
  self.timelinePlayer = PortraitTimelinePlayer(self.player)
  local timelineConfig = TimelineConfig()
  timelineConfig.assetPath = timelinePath
  self.timelinePlayer:Play(timelineConfig)
end

function ActivityPVPReRoundComp:ClearTimeline()
  if self.timelinePlayer then
    self.timelinePlayer:Stop()
    self.timelinePlayer:Dispose()
    self.timelinePlayer = nil
  end
end

function ActivityPVPReRoundComp:OnOpenAnim(callback)
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

function ActivityPVPReRoundComp:OnCloseAnim(callback)
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(false)
  if self.activtyDefine.closeAnim then
    self.uiAnimController:PlayState(self.activtyDefine.closeAnim, callback)
  elseif self.activtyDefine.endTimeline then
    self:PlayTimeline(self.activtyDefine.endTimeline)
  else
    self.ui.uiNode:SetActive(false)
    if callback then
      callback()
    end
  end
end

function ActivityPVPReRoundComp:OnUnbind()
  Super.OnUnbind(self)
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(false)
  self:ClearTimeline()
end

return ActivityPVPReRoundComp
