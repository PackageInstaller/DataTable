_class("UIActivityN28Entry", UISideEnterCenterContentBase)
UIActivityN28Entry = UIActivityN28Entry

function UIActivityN28Entry:Constructor()
end

function UIActivityN28Entry:DoInit()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaign = self._data
  local sample = self._campaign:GetSample()
  self._endTime = sample.end_time
  local localProcess = self._campaign:GetLocalProcess()
  self._component = localProcess:GetComponent(ECampaignN11CenterComponentID.ECAMPAIGN_N11_LUCK_LAND)
  self._compoentInfo = localProcess:GetComponentInfo(ECampaignN11CenterComponentID.ECAMPAIGN_N11_LUCK_LAND)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UIActivityN28Entry:DoShow()
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self:_GetComponents()
  self.taskId = self:StartTask(function(TT)
    while true do
      self:_OnValue()
      YIELD(TT, 1000)
    end
  end)
end

function UIActivityN28Entry:DoHide()
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
    self.taskId = nil
  end
end

function UIActivityN28Entry:DoDestroy()
  UIActivityN28Entry.super:Dispose()
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
    self.taskId = nil
  end
end

function UIActivityN28Entry:_GetComponents()
  self._remainTime = self:GetUIComponent("UILocalizationText", "RemainTimeText")
  self._remainTime2 = self:GetUIComponent("UILocalizationText", "RemainTimeText2")
end

function UIActivityN28Entry:_OnValue()
  if self._remainTime then
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local endTime = self._endTime
    if curTime < endTime then
      self._remainTime:SetText(StringTable.Get("str_activity_common_remainingtime_3", ""))
      self._remainTime2:SetText(UIActivityHelper.GetFormatTimerStr(endTime - curTime))
      self._remainTime2.gameObject:SetActive(true)
    else
      self._remainTime:SetText(StringTable.Get("str_activity_common_state_over"))
      self._remainTime2.gameObject:SetActive(false)
    end
  end
end

function UIActivityN28Entry:AfterUILayerChanged()
  self:_OnValue()
end

function UIActivityN28Entry:PlayBtnOnClick(go)
  if self:CheckActivityOver() then
    return
  end
  UIActivityHelper.PlayFirstPlot_Campaign(self._campaign, function()
    self:ShowDialog(UIStateType.UIN28GronruPlatform, nil, function()
      self:CheckActivityOver()
    end)
  end)
end

function UIActivityN28Entry:IntroBtnOnClick(go)
  if self:CheckActivityOver() then
    return
  end
  self:ShowDialog("UIIntroLoader", "UIActivityN28Entry")
end

function UIActivityN28Entry:CheckActivityOver()
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local endTime = self._endTime
  if curTime < endTime then
    return false
  else
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    return true
  end
end
