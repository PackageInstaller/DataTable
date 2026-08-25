local PopupLimitGiftActivityComp, Super = System.NewClass("PopupLimitGiftActivityComp", PopupBaseComp)

function PopupLimitGiftActivityComp:ctor()
  self.popupLimitGiftActivityMap = {}
end

function PopupLimitGiftActivityComp:OnBind(binder)
  self.binder = binder
  self:BindActivityChange()
end

function PopupLimitGiftActivityComp:BindActivityChange()
  self.binder:BindToRaw(function(cbinder, list)
    for _, act in ipairs(list or {}) do
      local actId = act.activityTid
      local actIdStr = tostring(actId)
      if ClientDataUtils.GetData(cd.ClientDataMainKey.LimitGiftPopUp, actIdStr) then
      else
        self.popupLimitGiftActivityMap[actId] = act
      end
    end
  end, function()
    local giftList = ActivityManager.Instance.model:GetTimeLimitGiftActivities()
    return giftList
  end)
end

function PopupLimitGiftActivityComp:OnUnbind()
  Super.OnUnbind(self)
end

function PopupLimitGiftActivityComp:Clear()
  table.clear(self.popupLimitGiftActivityMap)
end

function PopupLimitGiftActivityComp:CheckPopup()
  if self:IsInCopyView() then
    return
  end
  if table.next(self.popupLimitGiftActivityMap) then
    local stopUrls = {
      Urls.SummonPanel,
      Urls.AvgDialogPanelNew,
      Urls.AvgFinishPanel,
      Urls.ShowRewardPanel,
      Urls.ShowRewardSharePanel
    }
    for _, url in ipairs(stopUrls) do
      if UIManager.Instance:GetWindow(url) then
        return
      end
    end
    for actId, _ in pairs(self.popupLimitGiftActivityMap) do
      ClientDataUtils.SetData(cd.ClientDataMainKey.LimitGiftPopUp, tostring(actId), 1)
    end
    self._safeCheckUrl = Urls.LimitTimeGiftPanel
    UIManager.Instance:Reopen(Urls.LimitTimeGiftPanel, table.values(self.popupLimitGiftActivityMap), nil, function()
      self:SetBusy(false)
    end)
    table.clear(self.popupLimitGiftActivityMap)
    self:SetBusy(true)
  end
end

return PopupLimitGiftActivityComp
