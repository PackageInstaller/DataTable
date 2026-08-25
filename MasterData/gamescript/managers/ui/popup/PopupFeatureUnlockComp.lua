local PopupFeatureUnlockComp, Super = System.NewClass("PopupFeatureUnlockComp", PopupBaseComp)

function PopupFeatureUnlockComp:ctor()
end

function PopupFeatureUnlockComp:OnBind(binder)
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.ClosePanelEvent, System.fn(self, self.OnPanelClose))
end

function PopupFeatureUnlockComp:Clear()
end

function PopupFeatureUnlockComp:CheckPopup()
  if not PlayerDataUtils.CanShowUnlockPanel() then
    return
  end
  if self:IsInCopyView() then
    return
  end
  if UIManager.Instance:GetWindow(Urls.SummonPanel) or UIManager.Instance:GetWindow(Urls.SummonResultPanel) or UIManager.Instance:GetWindow(Urls.SummonedAwakerPanel) then
    return
  end
  local showData = PlayerDataUtils.PopFeatureUnlockShowQueue()
  if showData then
    local function closeCb()
      self:SetBusy(false)
    end
    
    PlayerDataUtils.SetEnabledShow(false)
    self._safeCheckUrl = Urls.FeatureUnlockPanel
    UIManager.Instance:Reopen(Urls.FeatureUnlockPanel, showData, closeCb)
    self:SetBusy(true)
  end
  do return self.DealBtnUnlockFx end
  return self.DealBtnUnlockFx, self, self, true, showData, closeCb
end

function PopupFeatureUnlockComp:DealBtnUnlockFx()
  if UIManager.Instance:GetWindow(Urls.FeatureUnlockPanel) then
    return
  end
  local info = PlayerDataUtils.PopBtnUnlockFx()
  if info then
    EventMgr.Instance.PlayUnlockBtnFx:Dispatch(info.btnName, info.featureTid)
    EventMgr.Instance.OpenClickMask:Dispatch("DealBtnUnlockFx", 2)
    self.binder:BindTimer(2, 0, nil, function()
      EventMgr.Instance.CloseClickMask:Dispatch("DealBtnUnlockFx")
      self:SetBusy(false)
    end)
    self._safeCheckUrl = nil
    self:SetBusy(true)
  end
end

function PopupFeatureUnlockComp:OnPanelClose(url)
  if url == Urls.FeatureUnlockPanel then
    self:SetBusy(false)
  end
end

function PopupFeatureUnlockComp:SetBusy(isBusy)
  Super.SetBusy(self, isBusy)
end

return PopupFeatureUnlockComp
