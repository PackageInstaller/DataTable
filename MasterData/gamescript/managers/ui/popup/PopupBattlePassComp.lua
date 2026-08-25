local PopupBattlePassComp = System.NewClass("PopupBattlePassComp", PopupBaseComp)

function PopupBattlePassComp:ctor()
end

function PopupBattlePassComp:OnBind(binder)
  self.binder = binder
end

function PopupBattlePassComp:Clear()
end

function PopupBattlePassComp:CheckPopup()
  if BattlePassDataUtils.CheckOpenBpUnlockTips(System.fn(self, self.CancelBusy)) then
    self._safeCheckUrl = Urls.FeatureUnlockPanel
    self:SetBusy(true)
  end
end

function PopupBattlePassComp:CancelBusy()
  self:SetBusy(false)
end

return PopupBattlePassComp
