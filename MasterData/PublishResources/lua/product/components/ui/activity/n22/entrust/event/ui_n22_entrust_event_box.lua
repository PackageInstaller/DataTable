_class("UIN22EntrustEventBox", UIN22EntrustEventBase)
UIN22EntrustEventBox = UIN22EntrustEventBox

function UIN22EntrustEventBox:Refresh()
  self:_SetRoot(false)
  local pass = self._component:IsEventPass(self._levelId, self._eventId)
  if pass then
    local tips = StringTable.Get("str_n22_entrust_event_box_got_tips")
    ToastManager.ShowToast(tips)
    self:CloseDialog()
  else
    self:RequestEvent()
  end
end

function UIN22EntrustEventBox:OnEventFinish(rewards)
  Log.info("UIN22EntrustEventBox:OnEventFinish()")
  local title = StringTable.Get("str_activity_battlepass_buy_deluxe_claim")
  self:ShowDialog("UIN22EntrustRewardsController", title, rewards, function()
    self:CloseDialog()
  end)
end
