_class("UICN17N46FishingGameEntry", UISideEnterCenterContentBase)
UICN17N46FishingGameEntry = UICN17N46FishingGameEntry

function UICN17N46FishingGameEntry:Constructor()
end

function UICN17N46FishingGameEntry:DoInit()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaign = self._data
  local sample = self._campaign:GetSample()
  self._endTime = sample.end_time
  local localProcess = self._campaign:GetLocalProcess()
  self._component = localProcess:GetComponent(ECampaignFishGameComponentID.ECAMPAIGN_FISH_GAME)
  self._compoentInfo = localProcess:GetComponentInfo(ECampaignFishGameComponentID.ECAMPAIGN_FISH_GAME)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UICN17N46FishingGameEntry:DoShow()
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

function UICN17N46FishingGameEntry:DoHide()
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
    self.taskId = nil
  end
end

function UICN17N46FishingGameEntry:DoDestroy()
  UICN17N46FishingGameEntry.super:Dispose()
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
    self.taskId = nil
  end
end

function UICN17N46FishingGameEntry:_GetComponents()
  self._remainTime = self:GetUIComponent("UILocalizationText", "RemainTimeText")
  self.redObj = self:GetGameObject("RedPoint")
  self.redObj:SetActive(false)
end

function UICN17N46FishingGameEntry:_OnValue()
  local sampleInfo = self._campaign:GetSample()
  if sampleInfo == nil then
    return
  end
  if self._remainTime then
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local endTime = self._endTime
    if curTime < endTime then
      self._remainTime:SetText(StringTable.Get("str_activity_common_remainingtime_3", UIActivityHelper.GetFormatTimerStr(endTime - curTime)))
    else
      self._remainTime:SetText(StringTable.Get("str_activity_common_state_over"))
    end
  end
  local red = sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD)
  self.redObj:SetActive(red)
end

function UICN17N46FishingGameEntry:AfterUILayerChanged()
  self:_OnValue()
end

function UICN17N46FishingGameEntry:PlayBtnOnClick(go)
  self.originBgm = AudioHelperController.GetCurrentBgm()
  self:ShowDialog("UICN17N46FishingGameStageController", self._component, self._compoentInfo, function()
    AudioHelperController.PlayBGM(self.originBgm, AudioConstValue.BGMCrossFadeTime)
  end)
end

function UICN17N46FishingGameEntry:IntroBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UICN17N46FishingGameEntry")
end
