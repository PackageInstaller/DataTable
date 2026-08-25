local PopupDayRefreshComp = System.NewClass("PopupDayRefreshComp", PopupBaseComp)

function PopupDayRefreshComp:ctor()
  self.dayRefreshQueue = {}
end

function PopupDayRefreshComp:OnBind(binder)
  self.binder = binder
  self:BindDayRefresh()
end

function PopupDayRefreshComp:Clear()
  table.clear(self.dayRefreshQueue)
end

function PopupDayRefreshComp:CheckPopup()
  if #self.dayRefreshQueue > 0 then
    self.dayRefreshQueue = {}
    if not self:_IsInPvpDrafting() then
      UIManager.Instance:CloseAllExcept({
        Urls.MainPanel,
        Urls.PopMsgPanel,
        Urls.PvPFriendGameTeamPanel,
        Urls.PvPMatchingPanel
      })
      UIManager.Instance:Reopen(Urls.MainPanel)
      if not PvPMatchDataUtils.GetIsMatching() then
        UIManager.Instance:Show(Urls.PopMsgPanel, LT.Text("DailyResetTips"))
      end
    end
    self:OnDailyRefresh()
    self.binder:BindTimer(3, 0, nil, function()
      self:SetBusy(false)
    end)
    self:SetBusy(true)
  end
end

function PopupDayRefreshComp:_IsInPvpDrafting()
  return UIManager.Instance:GetWindow(Urls.PvpDraftView) or UIManager.Instance:GetWindow(Urls.PvpDraftAdjustTeamView) or UIManager.Instance:GetWindow(Urls.PvPMatchRstPanel)
end

function PopupDayRefreshComp:BindDayRefresh()
  self.binder:BindEvent(EventMgr.Instance.OnDayRefresh, function()
    if SceneMgr.Instance:IsInTown() or SceneMgr.Instance:IsNullScene() then
      self:SetBusy(false)
    end
    table.insert(self.dayRefreshQueue, true)
  end)
end

function PopupDayRefreshComp:OnDailyRefresh()
  MainShopDataUtils.ResetAll()
  MainShopDataUtils.ReqShopData()
  ClientDataUtils.OnDayChanged()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.PVP, 0)
  if unlocked then
    PvPSeasonDataUtils.ReqOnOpen()
  end
  DailyChallengeController.Instance:ReqOnOpenDailyChallenge()
end

return PopupDayRefreshComp
