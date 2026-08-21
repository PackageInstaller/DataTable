_class("UILuckLandEntry", UISideEnterCenterContentBase)
UILuckLandEntry = UILuckLandEntry

function UILuckLandEntry:Constructor()
end

function UILuckLandEntry:DoInit()
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

function UILuckLandEntry:DoShow()
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

function UILuckLandEntry:DoHide()
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
    self.taskId = nil
  end
end

function UILuckLandEntry:DoDestroy()
  UILuckLandEntry.super:Dispose()
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
    self.taskId = nil
  end
end

function UILuckLandEntry:_GetComponents()
  self._remainTime = self:GetUIComponent("UILocalizationText", "RemainTimeText")
end

function UILuckLandEntry:_OnValue()
  if self._remainTime then
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local endTime = self._endTime
    if curTime < endTime then
      self._remainTime:SetText(StringTable.Get("str_activity_common_remainingtime_3", UIActivityHelper.GetFormatTimerStr(endTime - curTime)))
    else
      self._remainTime:SetText(StringTable.Get("str_activity_common_state_over"))
    end
  end
end

function UILuckLandEntry:AfterUILayerChanged()
  self:_OnValue()
end

function UILuckLandEntry:PlayBtnOnClick(go)
  UIActivityHelper.PlayFirstPlot_Campaign(self._campaign, function()
    self:ShowDialog("UILuckLandLevel", self._component, self._compoentInfo)
  end)
end

function UILuckLandEntry:IntroBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UILuckLandEntry")
end
