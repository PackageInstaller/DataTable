local ActivityTwentyFourComp, Super = System.NewClass("ActivityTwentyFourComp", ActivityMagicStoryComp)

function ActivityTwentyFourComp:ctor(res, activityTid, model)
  self.ui = UI_Events_Panel_TwentyFourResource(res)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.resonanceGroupId = CommonDefine.TwentyFourResonance
  self.produceTid = ActivityDataUtils.GetProduceTid(self.activityTid)
  self.hasFinishedActivity = ActivityManager.Instance:IsActivityFinishedByTid(self.activityTid)
  DonationBoxController.Instance:ReqDonationBoxData()
end

function ActivityTwentyFourComp:OnBind(binder)
  Super.OnBind(self, binder)
  self.ui.Image_Limit_Award:SetActive(false)
  self.ui.Image_Bgeffect:SetActive(false)
  self:_SetFinishTips(binder)
  self:BindDonationBoxEntrance(binder)
end

function ActivityTwentyFourComp:_SetFinishTips(binder)
  binder = binder or self.binder
  local desc = ""
  if self.activityConfig and self.activityConfig.ActivityStageEndContent and self.hasFinishedActivity then
    desc = LT.Text(self.activityConfig.ActivityStageEndContent)
  end
  self.ui.Group_Finish:SetActive("" ~= desc)
  binder:SetText(self.ui.Text_Finish_Tips, desc)
end

function ActivityTwentyFourComp:BindDonationBoxEntrance(binder)
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
    local isFullReward = DonationBoxModel.Instance:IsReachMaxReward(self.produceTid)
    self.ui.Text_C_Finished:SetActive(isDonationBoxFinished and not enableGainReward)
    self.ui.Text_C_Not_unlocked:SetActive(not isDonationBoxActive and not isDonationBoxFinished)
    self.ui.FundraisingTimeView:SetActive(isDonationBoxActive and not enableGainReward)
    self.ui.UnlockableView:SetActive(isDonationBoxActive and enableGainReward)
    self.ui.Image_Max:SetActive(isFullReward)
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

function ActivityTwentyFourComp:_OnClickDonationBox()
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

function ActivityTwentyFourComp:_ClearDonationBoxTimer(binder)
  if self.donationBoxTimer then
    binder:StopTimer(self.donationBoxTimer)
    self.donationBoxTimer = nil
  end
end

function ActivityTwentyFourComp:_BindBoxTimer(binder, enableGainReward, isFullReward)
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

function ActivityTwentyFourComp:BindLockState()
  if self.hasFinishedActivity then
    self.ui.Group_Locked:SetActive(false)
    return
  end
  Super.BindLockState(self)
end

function ActivityTwentyFourComp:BindShopItem()
  local binder = self.binder
  self.ui.Btn_Shop:SetActive(true)
  local currencyTidList = {}
  local shopTypeList = ShopExtModel.Instance:GetShopTypeListByActivityTid(self.activityTid)
  for idx, tid in ipairs(shopTypeList) do
    local shopTypeConfig = ShopExtModel.Instance:GetShopTypeConfig(tid)
    local currencyTid = shopTypeConfig and shopTypeConfig.ShowMoney and shopTypeConfig.ShowMoney[1]
    local currencyIconObj = self.ui["Image_Currency_0" .. idx]
    local currencyTextObj = self.ui["Text_Currency_0" .. idx]
    if currencyIconObj and currencyTextObj then
      table.insert(currencyTidList, currencyTid)
      local isValidCurrency = currencyTid and currencyTid > 0
      currencyIconObj:SetActive(isValidCurrency)
      if isValidCurrency then
        binder:BindToText(currencyTextObj, function()
          do return ItemDataUtils.GetItemNum end
          return ItemDataUtils.GetItemNum, currencyTid
        end)
        binder:SetImageSync(currencyIconObj, ItemDataUtils.GetIcon(currencyTid))
      end
    end
  end
  binder:BindToRaw(function(_, nValTbl)
    if not nValTbl then
      return
    end
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Currency)
  end, function()
    local valueTable = {}
    for _, tid in ipairs(currencyTidList) do
      if tid then
        valueTable[tid] = {
          ItemDataUtils.GetItemNum(tid)
        }
      end
    end
    return valueTable
  end)
  self.binder:BindZ1Button(self.ui.Btn_Shop, function()
    ShopController.Instance:OpenActivityShopView(self.activityTid)
  end)
  self.binder:BindComponent(RedDotComponent(self.ui.Red_Shop, nil, nil, System.fn(self, self._RedFunc)))
end

function ActivityTwentyFourComp:BindSubPlotRecord()
  if self.hasFinishedActivity then
    self.ui.Btn_Record:SetActive(false)
    return
  end
  Super.BindSubPlotRecord(self)
end

function ActivityTwentyFourComp:BindBtnChallenge()
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

function ActivityTwentyFourComp:_RedFunc()
  local shopTypeList = ShopExtModel.Instance:GetShopTypeListByActivityTid(self.activityTid)
  do return RedPointDataUtils.GetShopRedByShopTypes end
  return RedPointDataUtils.GetShopRedByShopTypes, shopTypeList
end

function ActivityTwentyFourComp:OnOpenAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_MagicStory_Open", callback)
end

function ActivityTwentyFourComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_MagicStory_Close")
  callback()
end

return ActivityTwentyFourComp
