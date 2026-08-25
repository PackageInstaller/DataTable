local ActivitySalvadorComp, Super = System.NewClass("ActivitySalvadorComp", ActivityMagicStoryComp)

function ActivitySalvadorComp:ctor(res, activityTid, model, params)
  self.ui = UI_Events_Panel_BanquetResource(res)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.resonanceGroupId = CommonDefine.SalvadorResonance
  self.produceTid = ActivityDataUtils.GetProduceTid(self.activityTid)
  self.hasFinishedActivity = ActivityManager.Instance:IsActivityFinishedByTid(self.activityTid)
  DonationBoxController.Instance:ReqDonationBoxData()
  self.audioPlay = true
  if params then
    self.audioPlay = params.audioPlay
  end
end

function ActivitySalvadorComp:OnBind(binder)
  Super.OnBind(self, binder)
  self:_SetFinishTips(binder)
  self:BindDonationBoxEntrance(binder)
end

function ActivitySalvadorComp:_SetFinishTips(binder)
  if not binder then
    return
  end
  local desc = ""
  if self.activityConfig and self.activityConfig.ActivityStageEndContent and self.hasFinishedActivity then
    desc = LT.Text(self.activityConfig.ActivityStageEndContent)
  end
  self.ui.Group_Finish:SetActive("" ~= desc)
  binder:SetText(self.ui.Text_Finish_Tips, desc)
end

function ActivitySalvadorComp:BindDonationBoxEntrance(binder)
  if not binder then
    return
  end
  local hasDonationBox = DonationBoxModel.Instance:GetProductConfig(self.produceTid) ~= nil
  self.ui.Image_Limit_Award:SetActive(hasDonationBox)
  if not hasDonationBox then
    return
  end
  binder:SetText(self.ui.Text_Fundraising, DonationBoxModel.Instance:GetBoxName(self.produceTid))
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot_1, nil, nil, function()
    do return RedPointDataUtils.GetDonationBoxRed end
    return RedPointDataUtils.GetDonationBoxRed, {
      self.produceTid
    }, self.produceTid
  end))
  binder:BindZ1Button(self.ui.Btn_Limit_1, System.fn(self, self._OnClickDonationBox))
  binder:BindEvent(EventMgr.Instance.OnDonationBoxDataUpdate, function()
    self:_ClearDonationBoxTimer(binder)
    local isDonationBoxFinished = DonationBoxModel.Instance:IsBoxFinish(self.produceTid)
    local isDonationBoxActive = DonationBoxModel.Instance:IsBoxActive(self.produceTid)
    local enableGainReward = DonationBoxModel.Instance:EnableGainReward(self.produceTid)
    self.ui.Text_C_Finished:SetActive(isDonationBoxFinished)
    self.ui.Text_C_Not_unlocked:SetActive(not isDonationBoxActive and not isDonationBoxFinished)
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
    self:_BindBoxTimer(binder, enableGainReward)
  end)
end

function ActivitySalvadorComp:_OnClickDonationBox()
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

function ActivitySalvadorComp:_ClearDonationBoxTimer(binder)
  if self.donationBoxTimer then
    binder:StopTimer(self.donationBoxTimer)
    self.donationBoxTimer = nil
  end
end

function ActivitySalvadorComp:_BindBoxTimer(binder, enableGainReward, isFullReward)
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

function ActivitySalvadorComp:BindLockState()
  if self.hasFinishedActivity then
    self.ui.Group_Locked:SetActive(false)
    return
  end
  Super.BindLockState(self)
end

function ActivitySalvadorComp:BindShopItem()
  self.ui.Btn_Shop:SetActive(true)
  local paras = table.clone(self.activityConfig.ActivityPara1)
  table.remove(paras, 1)
  local lotteryIdList = paras
  local showMoneyGroup = {}
  for lotteryId, cfg in pairs(DT.Lottery) do
    if table.contains(lotteryIdList, lotteryId) then
      for _, itemId in pairs(cfg.CurrencyColumn) do
        if not table.contains(showMoneyGroup, itemId) then
          table.insert(showMoneyGroup, itemId)
        end
      end
    end
  end
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
  self.binder:BindZ1Button(self.ui.Btn_Shop, function()
    ActivityDrawPrizeController.Instance:OpenActivityDrawPrizePoolView(lotteryIdList)
  end)
  self.binder:BindComponent(RedDotComponent(self.ui.Red_Shop, nil, nil, function()
    local isRed = false
    for _, lotteryTid in pairs(lotteryIdList) do
      local value = RedPointDataUtils.GetLotteryPoolRed(lotteryTid)
      if value == RedPointDataUtils.RedAttrType.IsNew then
        return value
      end
      isRed = isRed or value
    end
    return isRed
  end))
end

function ActivitySalvadorComp:BindSubPlotRecord()
  if self.hasFinishedActivity then
    self.ui.Btn_Record:SetActive(false)
    return
  end
  Super.BindSubPlotRecord(self)
end

function ActivitySalvadorComp:BindBtnChallenge()
  if self.hasFinishedActivity then
    self.ui.Btn_Challenge:SetActive(false)
    return
  end
  self.binder:BindZ1Button(self.ui.Btn_Challenge, function()
    ActivityController.Instance:OpenActivityStageGroupPanel(self.activityData, self.resonanceGroupId)
  end)
  local stageGroupTypeId = self.activityConfig.ActivityPara1[1]
  local stageGroupList = CopyDataUtils.GetStageGroupIdList(stageGroupTypeId)
  self:BindNewStageGroupRed(stageGroupList)
end

function ActivitySalvadorComp:OnOpenAnim(callback)
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(self.audioPlay)
  if not self.audioPlay then
    self.audioPlay = true
  end
  self.uiAnimController:PlayState("UI_Events_Panel_MagicStory_Open", callback)
end

function ActivitySalvadorComp:OnCloseAnim(callback)
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(false)
  self.uiAnimController:PlayState("UI_Events_Panel_MagicStory_Close")
  if callback then
    callback()
  end
end

function ActivitySalvadorComp:OnUnbind()
  Super.OnUnbind(self)
  self.ui.UI_Events_Panel_Lily_Audio:SetActive(false)
end

return ActivitySalvadorComp
