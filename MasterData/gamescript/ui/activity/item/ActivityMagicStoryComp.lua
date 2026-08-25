local UIAnimationController = CS.Z1Client.UIAnimationController
local TaskState = CommonDefine.TaskState
local ActivityMagicStoryComp, Super = System.NewClass("ActivityMagicStoryComp", ActivityBaseComp)

function ActivityMagicStoryComp:ctor(res, activityTid, model)
  Super.ctor(self)
  self.ui = UI_Events_Panel_MagicStoryResource(res)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.resonanceGroupId = CommonDefine.MagicStoryResonance
end

function ActivityMagicStoryComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:_BindActivityTimer()
  self:_BindPortraitComp()
  self:_SetActivityPlot()
  self:BindLockState()
  self:BindResonanceProgress()
  self:BindShopItem()
  self:BindAchievementProgress()
  self:BindSubPlotRecord()
  self:BindBtnChallenge()
  if self.ui.Btn_PlayPV then
    self.binder:BindButtonClick(self.ui.Btn_PlayPV, System.fn(self, self._OnClickPlayPV))
  end
end

function ActivityMagicStoryComp:_OnClickPlayPV()
  local storyId = 45062
  AvgStoryManager.Instance:StartStoryById(storyId, nil, function()
    WorldStageManager.Instance:ReplayBGM()
    AudioManager.Instance:PostSoundEvent("MAININTERFACE_MUSIC")
  end, function()
  end)
end

function ActivityMagicStoryComp:BindLockState()
  local isOpen = self.model:CheckCondition(table.clone(self.activityData))
  local hasFinishedActivity = ActivityManager.Instance:IsActivityFinishedByTid(self.activityTid)
  if hasFinishedActivity then
    self.ui.Group_UnLock:SetActive(false)
    self.ui.Group_Locked:SetActive(false)
  else
    self.ui.Group_UnLock:SetActive(isOpen)
    self.ui.Group_Locked:SetActive(not isOpen)
  end
  if not isOpen then
    self.binder:SetText(self.ui.Text_Lock, LT.Text(self.activityConfig.UnlockConditionExplanation or ""))
  end
  self:_SetFinishTips()
end

function ActivityMagicStoryComp:_SetFinishTips()
  local desc = ""
  local hasFinishedActivity = ActivityManager.Instance:IsActivityFinishedByTid(self.activityTid)
  if self.activityConfig and self.activityConfig.ActivityStageEndContent and hasFinishedActivity then
    desc = LT.Text(self.activityConfig.ActivityStageEndContent)
  end
  if self.ui.Group_Finish then
    self.ui.Group_Finish:SetActive("" ~= desc)
  end
  if self.ui.Text_Finish_Tips then
    self.binder:SetText(self.ui.Text_Finish_Tips, desc)
  end
end

function ActivityMagicStoryComp:BindResonanceProgress()
  if not self.resonanceGroupId or not self.ui.Btn_Resonance then
    return
  end
  xpcall(function()
    self.binder:BindComponent(ResonanceGroupComp(self.resonanceGroupId, self.ui.Btn_Resonance, self.ui.Text_ResonanceProgress, self.ui.Text_TotalProgress, self.ui.Red_Resonance, self.activityTid, self, true))
  end, function(err)
    Logger.Error(err)
  end)
end

function ActivityMagicStoryComp:BindShopItem()
  local _, shopTypeId = table.unpack(self.activityConfig.ActivityPara1)
  local shopTypeCfg = shopTypeId and DT.ShopType[shopTypeId]
  if not shopTypeCfg then
    self.ui.Btn_Shop:SetActive(false)
    return
  end
  self.ui.Btn_Shop:SetActive(true)
  self.binder:SetText(self.ui.Text_C_Shop, LT.Text(shopTypeCfg.ShopName))
  local showMoneyId = shopTypeCfg.ShowMoney and shopTypeCfg.ShowMoney[1]
  local moneyItemCfg = showMoneyId and ItemDataUtils.GetItemConfig(showMoneyId)
  if moneyItemCfg then
    self.binder:SetImageSync(self.ui.Image_ShopItem, ItemDataUtils.GetIcon(showMoneyId))
    self.binder:BindToText(self.ui.Text_OwnCount, function()
      do return ItemDataUtils.GetItemNum end
      return ItemDataUtils.GetItemNum, showMoneyId
    end)
  end
  self.binder:BindZ1Button(self.ui.Btn_Shop, function()
    MainShopDataUtils.OnOpenShop(shopTypeCfg.TypeTag)
  end, nil, nil, System.fn(self, self.GetShopRedPoint))
end

function ActivityMagicStoryComp:GetShopRedPoint()
  return false
end

function ActivityMagicStoryComp:BindAchievementProgress()
  local para = self.activityConfig.ActivityPara2 or ""
  local parentTaskList = string.split(para, ",")
  for i, v in ipairs(parentTaskList) do
    parentTaskList[i] = tonumber(v)
  end
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

function ActivityMagicStoryComp:GetTaskProgressPercent(taskList, parentTaskList)
  local totalCount = 0
  local finishCount = 0
  local state
  for _, taskData in pairs(taskList) do
    if not table.contains(parentTaskList, taskData.tid) then
      totalCount = totalCount + 1
      state = taskData.state
      if state == TaskState.Receive or state == TaskState.Done then
        finishCount = finishCount + 1
      end
    end
  end
  do return math.ceil end
  return math.ceil, finishCount / totalCount * 100, pairs(taskList)
end

function ActivityMagicStoryComp:BindSubPlotRecord()
  if self.hasFinishedActivity or not self.activityConfig.ActivityPara3 then
    self.ui.Btn_Record:SetActive(false)
    return
  end
  local subPlotGroupId = table.unpack(self.activityConfig.ActivityPara3)
  self.binder:BindZ1Button(self.ui.Btn_Record, function()
    CopyDataUtils.OnClickSubPlotEntry(subPlotGroupId, self.activityTid, true)
  end)
  self.binder:BindComponent(UICompRedDotNewVue(self.ui.NewTag_Record, RedDotDefine.DynamicRedDotID.ActivitySubplotEntry, {
    stageGroupTidList = self.activityConfig.ActivityPara3,
    activityTid = self.activityTid
  }))
end

function ActivityMagicStoryComp:BindBtnChallenge()
  self.binder:BindZ1Button(self.ui.Btn_Challenge, System.fn(self, self._OnClickBtnChallenge))
end

function ActivityMagicStoryComp:BindNewStageGroupRed(stageGroupList)
  if not stageGroupList or not self.ui.NewTag_Challenge then
    return
  end
  self.binder:SetActive(self.ui.NewTag_Challenge, true)
  self.binder:BindComponent(UICompRedDotNewVue(self.ui.NewTag_Challenge, RedDotDefine.DynamicRedDotID.ActivityStageGroupEntry, {
    activityTid = self.activityTid
  }))
end

function ActivityMagicStoryComp:_OnClickBtnChallenge()
  local stageGroupId = table.unpack(self.activityConfig.ActivityPara1)
  CopyDataUtils.PrepareActivityChallengeStageData(stageGroupId, function()
    UIManager.Instance:Reopen(Urls.ActivityChallengePanel, stageGroupId, self.activityTid)
  end)
end

function ActivityMagicStoryComp:BindDonationBoxEntrance()
  if not self.ui.Image_Limit_Award then
    return
  end
  self.produceTid = ActivityDataUtils.GetProduceTid(self.activityTid)
  if not self.produceTid then
    self.ui.Image_Limit_Award:SetActive(false)
    return
  end
  local hasDonationBox = DonationBoxModel.Instance:GetProductConfig(self.produceTid) ~= nil
  self.ui.Image_Limit_Award:SetActive(hasDonationBox)
  if not hasDonationBox then
    return
  end
  self.binder:SetText(self.ui.Text_Fundraising, DonationBoxModel.Instance:GetBoxName(self.produceTid))
  self.binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_1, nil, nil, function()
    do return RedPointDataUtils.GetDonationBoxRed end
    return RedPointDataUtils.GetDonationBoxRed, {
      self.produceTid
    }, self.produceTid
  end))
  self.binder:BindZ1Button(self.ui.Btn_Limit_1, System.fn(self, self._OnClickDonationBox))
  self:SetDonationBoxState()
  self.binder:BindEvent(EventMgr.Instance.OnDonationBoxDataUpdate, function()
    self:SetDonationBoxState()
  end)
end

function ActivityMagicStoryComp:SetDonationBoxState()
  self:_ClearDonationBoxTimer(self.binder)
  local isDonationBoxFinished = DonationBoxModel.Instance:IsBoxFinish(self.produceTid)
  local isDonationBoxActive = DonationBoxModel.Instance:IsBoxActive(self.produceTid)
  local enableGainReward = DonationBoxModel.Instance:EnableGainReward(self.produceTid)
  self.ui.Text_C_Finished:SetActive(isDonationBoxFinished)
  self.ui.Text_C_Not_unlocked:SetActive(not isDonationBoxActive and not isDonationBoxFinished)
  self.ui.Text_C_Receive:SetActive(isDonationBoxActive and not enableGainReward)
  self.ui.Text_C_Can_Unlockable:SetActive(isDonationBoxActive and enableGainReward)
  self.ui.FundraisingTimeView:SetActive(isDonationBoxActive and not enableGainReward)
  self.ui.UnlockableView:SetActive(isDonationBoxActive and enableGainReward)
  if not isDonationBoxActive then
    return
  end
  local isFullReward = DonationBoxModel.Instance:IsReachMaxReward(self.produceTid)
  self.ui.Image_Max:SetActive(isFullReward)
  self.ui.Text_C_Fill_Up:SetActive(not isFullReward)
  self.ui.Text_Fill_Up_Time:SetActive(not isFullReward)
  if isFullReward then
    return
  end
  self:_BindBoxTimer(self.binder, enableGainReward)
end

function ActivityMagicStoryComp:_OnClickDonationBox()
  local hasDonationBox = DonationBoxModel.Instance:GetProductConfig(self.produceTid) ~= nil
  if not hasDonationBox then
    return
  end
  local isDonationBoxActive = DonationBoxModel.Instance:IsBoxActive(self.produceTid)
  local isDonationBoxFinish = DonationBoxModel.Instance:IsBoxFinish(self.produceTid)
  if not isDonationBoxActive and not isDonationBoxFinish then
    local tips = DonationBoxModel.Instance:GetBoxUnlockTips(self.produceTid)
    if tips then
      Alert.ShowStr(tips)
    end
    return
  end
  DonationBoxController.Instance:OpenActivityDonationBoxView(self.produceTid)
end

function ActivityMagicStoryComp:_ClearDonationBoxTimer(binder)
  if self.donationBoxTimer then
    binder:StopTimer(self.donationBoxTimer)
    self.donationBoxTimer = nil
  end
end

function ActivityMagicStoryComp:_BindBoxTimer(binder, enableGainReward, isFullReward)
  local textObj, leftTime
  if enableGainReward then
    textObj = self.ui.Text_Fill_Up_Time
    leftTime = DonationBoxModel.Instance:GetFullGainLeftTime(self.produceTid)
  else
    textObj = self.ui.Text_Fundraising_Time
    leftTime = DonationBoxModel.Instance:GetNextGainRewardLeftTime(self.produceTid)
  end
  binder:SetText(textObj, DonationBoxModel.Instance:GetCountdownTimeFormatText(leftTime))
  self.donationBoxTimer = binder:BindTimer(1, -1, function()
    leftTime = leftTime - 1
    if leftTime <= 0 then
      self:_ClearDonationBoxTimer(binder)
      return
    end
    binder:SetText(textObj, DonationBoxModel.Instance:GetCountdownTimeFormatText(leftTime))
  end, function()
    binder:SetText(textObj, "")
    self:_ClearDonationBoxTimer(binder)
  end)
end

function ActivityMagicStoryComp:OnOpenAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_MagicStory_Open", callback)
end

function ActivityMagicStoryComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_MagicStory_Close", callback)
end

function ActivityMagicStoryComp:_BindActivityTimer()
  if not (self.activityData and self.binder and self.ui) or not self.ui.Text_Time then
    Logger.Warn("_BindActivityTimer wrong activityData:%s binder:%s Text_Time:%s", self.activityData, self.binder, self.ui and self.ui.Text_Time)
    return
  end
  local timeType = ActivityDataUtils.GetTimeType(self.activityData.activityTid)
  if timeType == ActivityDefine.ActivityTimeType.Permanent then
    self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimePermanent"))
    return
  end
  self:_ClearTimer()
  self:_TimerFixedUpdate()
  local now = TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime())
  if now > self.activityData.endTime then
    self.binder:SetActive(self.ui.Text_Time, false)
    return
  end
  self.activityTimer = self.binder:BindTimer(1, -1, System.bind(self._TimerFixedUpdate, self))
end

function ActivityMagicStoryComp:_TimerFixedUpdate()
  local now = TimeUtils.GetFixedTimestamp(TimeUtils.GetServerTime())
  local finishTimeCountdown = (self.activityData.finishTime or 0) - now
  local endTimeCountdown = (self.activityData.endTime or 0) - now
  if finishTimeCountdown < 0 and endTimeCountdown < 0 then
    self:_ClearTimer()
  end
  ActivityUiUtils.RefreshActivityCountDown(self.binder, self.ui.Text_Time, self.activityData)
end

return ActivityMagicStoryComp
