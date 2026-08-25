local PopupPopupAdComp = System.NewClass("PopupPopupAdComp", PopupBaseComp)

function PopupPopupAdComp:ctor()
end

function PopupPopupAdComp:OnBind(binder)
  self.binder = binder
  self.binder:BindEvent(EventMgr.Instance.OnDayRefresh, System.fn(self, self.ClearPopupAdTime))
end

function PopupPopupAdComp:Clear()
end

function PopupPopupAdComp:CheckPopup()
  local _, isUnlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.PopUp, 0)
  if not isUnlocked then
    return
  end
  if not GuidePanelUtils.IsViewAtTop(Urls.MainPanel) then
    return
  end
  local nextDayRefreshTime
  local now = TimeUtils.GetServerTime()
  local popupAdList = {}
  for adTid, adCfg in pairs(DT.PopupAd) do
    local forbidPopTime = ClientDataUtils.GetData(cd.ClientDataMainKey.PopupAd, adTid)
    if forbidPopTime and now < forbidPopTime then
    elseif now < (adCfg.PopUpStartTime or 0) or now > (adCfg.PopUpEndTime or math.huge) then
    else
      nextDayRefreshTime = nextDayRefreshTime or TimeUtils.GetNextClockTime(now + 5, DT.GetConstant("Server_Refresh_Time"), 0)
      if nextDayRefreshTime > 0 and now >= nextDayRefreshTime then
        nextDayRefreshTime = nextDayRefreshTime + 86400
      end
      ClientDataUtils.SetData(cd.ClientDataMainKey.PopupAd, adTid, nextDayRefreshTime)
      if PopupQueManager.Instance:IsPopupAddOpen(adTid) then
        table.insert(popupAdList, adTid)
      end
    end
  end
  if #popupAdList > 0 then
    self._safeCheckUrl = Urls.PopUpAdPanel
    UIManager.Instance:Reopen(Urls.PopUpAdPanel, popupAdList, function()
      self:SetBusy(false)
    end)
    self:SetBusy(true)
  end
end

function PopupPopupAdComp:ClearPopupAdTime()
  for adTid, _ in pairs(DT.PopupAd) do
    ClientDataUtils.SetData(cd.ClientDataMainKey.PopupAd, adTid, 0, false)
  end
  ClientDataUtils.ReqSaveClientData(cd.ClientDataMainKey.PopupAd)
end

return PopupPopupAdComp
