local PopupMonthCardComp = System.NewClass("PopupMonthCardComp", PopupBaseComp)

function PopupMonthCardComp:ctor()
end

function PopupMonthCardComp:OnBind(binder)
  self.binder = binder
  self.binder:BindEvent(EventMgr.Instance.OnDayRefresh, System.fn(self, self.OnDayRefresh))
  self.binder:BindEvent(EventMgr.Instance.CloseUIPanel, System.fn(self, self.OnPanelClose))
  self.binder:BindEvent(EventMgr.Instance.OnEnterScene, System.fn(self, self.OnEnterScene))
end

function PopupMonthCardComp:Clear()
end

function PopupMonthCardComp:CheckPopup()
  if self.monthCardModel then
    return
  end
  local childBinder = self.binder:createChild()
  self._monthCardBinder = childBinder
  self.monthCardModel = childBinder:createModel(MonthCardModel)
  self.monthCardModel:RequestMonthCardInfo(function(state)
    if state == CommonDefine.RewardState.Available then
      self:_ShowMonthCardReceiveRewardsPanel(self.monthCardModel)
    else
      self:SetBusy(false)
    end
  end, CommonDefine.MonthCardType.Diamond)
  self:SetBusy(true)
end

function PopupMonthCardComp:_ShowMonthCardReceiveRewardsPanel(monthCardModel)
  local expiredTimestamp = monthCardModel:GetExpiredTimestamp()
  self._safeCheckUrl = Urls.MainShopMonthCardRewardPanel
  UIManager.Instance:Reopen(Urls.MainShopMonthCardRewardPanel, expiredTimestamp, function()
    monthCardModel:ReceiveRewards(function()
      local itemInfo = monthCardModel:GetItemInfo()
      local dailyItemTid = itemInfo.dailyItem.tid
      local dailyItemCount = itemInfo.dailyItem.count
      ItemDataUtils.ShowItemGain({
        {tid = dailyItemTid, changedNum = dailyItemCount}
      }, function()
        self:SetBusy(false)
      end)
    end)
  end)
end

function PopupMonthCardComp:OnPanelClose(url)
  if url == Urls.MainShopMonthCardRewardPanel then
    self:SetBusy(false)
  end
end

function PopupMonthCardComp:OnEnterScene(scene)
  if scene == cd.SceneType.Login then
    self:ClearMonthCardModel()
  end
end

function PopupMonthCardComp:OnDayRefresh()
  self.binder:BindTimer(3, 0, nil, function()
    MainShopDataUtils.ResetAll()
    MainShopDataUtils.ReqShopData()
    self:ClearMonthCardModel()
  end)
end

function PopupMonthCardComp:ClearMonthCardModel()
  if self._monthCardBinder then
    self._monthCardBinder:teardown()
  end
  self._monthCardBinder = nil
  self.monthCardModel = nil
end

return PopupMonthCardComp
