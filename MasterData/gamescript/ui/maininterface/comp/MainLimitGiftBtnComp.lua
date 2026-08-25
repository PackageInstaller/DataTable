local MainLimitGiftBtnComp, Super = System.NewComponent("MainLimitGiftBtnComp")

function MainLimitGiftBtnComp:ctor(uiNode)
  Super.ctor(self)
  self.ui = UI_Main_LimitGiftBagResource(uiNode)
end

function MainLimitGiftBtnComp:OnBind(binder)
  self.binder = binder
  self.binder:BindToRaw(function(cbinder, giftList)
    self.binder:SetActive(self.ui.uiNode, #giftList > 0)
    self.binder:SetText(self.ui.Text_Count, 0 == #giftList and "" or #giftList)
    cbinder:BindToRaw(function(_, isHaveReward)
      if 1 == #giftList then
        self.binder:SetActive(self.ui.Image_RedDot, isHaveReward)
        self.binder:SetActive(self.ui.Group_Count, false)
      else
        self.binder:SetActive(self.ui.Image_RedDot, isHaveReward)
        self.binder:SetActive(self.ui.Group_Count, not isHaveReward)
      end
    end, function()
      do return self.IsHaveReward, self end
      return self.IsHaveReward, self, giftList
    end)
    self:TickNextMiniEndTimeActivity(cbinder, giftList)
  end, function()
    local giftList = ActivityManager.Instance.model:GetTimeLimitGiftActivities()
    return giftList
  end)
  self.binder:BindButtonClick(self.ui.uiNode, function()
    local giftList = ActivityManager.Instance.model:GetTimeLimitGiftActivities()
    if #giftList > 0 then
      local _, miniTimeGiftIndex = self:GetMiniEndTimeAndIndex(giftList)
      UIManager.Instance:Reopen(Urls.LimitTimeGiftPanel, giftList, miniTimeGiftIndex)
    end
  end)
end

function MainLimitGiftBtnComp:TickNextMiniEndTimeActivity(cbinder, giftList)
  if self._tickerTimer then
    TimerManager.Instance:StopTimer(self._tickerTimer)
    self._tickerTimer = nil
  end
  local miniTime = self:GetMiniEndTimeAndIndex(giftList)
  cbinder:SetActive(self.ui.Image_LimitTime, nil ~= miniTime)
  if miniTime then
    cbinder:SetActive(self.ui.Image_LimitTime, true)
    self._tickerTimer = cbinder:BindTimer(1, -1, function()
      local serverTime = TimeUtils.GetServerTime()
      if serverTime >= miniTime then
        self:RemoveEndTimeActivity(giftList)
        self:TickNextMiniEndTimeActivity(cbinder, giftList)
      else
        cbinder:SetText(self.ui.Text_LimitTime, TimeUtils.format(miniTime - serverTime, cd.TimeParseType.hms))
      end
    end)
    cbinder:SetText(self.ui.Text_LimitTime, TimeUtils.format(miniTime - TimeUtils.GetServerTime(), cd.TimeParseType.hms))
  else
    cbinder:SetActive(self.ui.Image_LimitTime, false)
    local currentGiftList = ActivityManager.Instance.model:GetTimeLimitGiftActivities()
    self.binder:SetActive(self.ui.uiNode, #currentGiftList > 0)
  end
end

function MainLimitGiftBtnComp:IsHaveReward(actList)
  for _, actData in ipairs(actList) do
    if ActivityDataUtils.IsHaveLimitTimeReward(actData.activityTid) then
      return true
    end
  end
end

function MainLimitGiftBtnComp:GetMiniEndTimeAndIndex(actList)
  local miniEndTime, miniTimeActIndex = nil, 1
  local serverTime = TimeUtils.GetServerTime()
  for index, actData in ipairs(actList) do
    local endTime = actData.endTime
    if endTime and serverTime < endTime and endTime < (miniEndTime or math.huge) then
      miniEndTime = endTime
      miniTimeActIndex = index
    end
  end
  return miniEndTime, miniTimeActIndex
end

function MainLimitGiftBtnComp:RemoveEndTimeActivity(giftList)
  if not giftList or #giftList <= 0 then
    return
  end
  local model = ActivityManager.Instance and ActivityManager.Instance.model
  if not model then
    return
  end
  local now = TimeUtils.GetServerTime()
  local hasRemoved = false
  for index = #giftList, 1, -1 do
    local actData = giftList[index]
    local endTime = actData and actData.endTime
    local activityTid = actData and actData.activityTid
    if endTime and endTime > 0 and now >= endTime and activityTid then
      model:RemoveActivity(activityTid)
      table.remove(giftList, index)
      hasRemoved = true
    end
  end
  if hasRemoved then
    EventMgr.Instance.OnActivityDisplayChanged:Dispatch()
  end
end

return MainLimitGiftBtnComp
