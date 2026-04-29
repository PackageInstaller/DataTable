_class("UIN22EntrustEventTransfer", UIN22EntrustEventBase)
UIN22EntrustEventTransfer = UIN22EntrustEventTransfer

function UIN22EntrustEventTransfer:Refresh()
  self:_SetRoot(false)
  local cfg = self:GetCfgCampaignEntrustEvent()
  local params = cfg.Params[1]
  local desc = params.Desc
  self._targetId = cfg.TargetID
  local pass = self._component:IsEventPass(self._levelId, self._eventId)
  if pass then
    self:SetPlayer(self._targetId)
    self:CloseDialog()
    return
  end
  if not self._targetId then
    self:RequestEvent()
    return
  end
  self:_SetRoot(true)
  self:_SetMainDesc(StringTable.Get(desc))
  local txtConfirm = StringTable.Get("str_n22_entrust_event_transfer_desc_confirm")
  self:_SetConfirmBtn(true, txtConfirm, function()
    self:RequestEvent()
  end)
  local txtExit = StringTable.Get("str_n22_entrust_event_exits_leave")
  self:_SetExitBtn(txtExit, function()
    self:CloseDialog()
  end)
end

function UIN22EntrustEventTransfer:OnEventFinish(rewards)
  Log.info("UIN22EntrustEventTransfer:OnEventFinish()")
  if self._targetId then
    self:SetPlayer(self._targetId)
    local targetPass = self._component:IsEventPass(self._levelId, self._targetId)
    if not targetPass then
      local targetType = self._component:GetEventType(self._targetId)
      if targetType == EntrustEventType.EntrustEventType_Transfer then
        local targetCfg = self:GetCfgCampaignEntrustEvent(self._targetId)
        if not targetCfg.TargetID or targetCfg.TargetID == self._eventId then
          self:RequestEvent(self._targetId)
          return
        end
      end
    end
  end
  self:CloseDialog()
end
