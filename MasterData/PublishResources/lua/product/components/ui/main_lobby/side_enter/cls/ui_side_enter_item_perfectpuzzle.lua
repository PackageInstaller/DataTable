require("ui_side_enter_item_base")
_class("UISideEnterItem_PerfectPuzzle", UISideEnterItem_Base)
UISideEnterItem_PerfectPuzzle = UISideEnterItem_PerfectPuzzle

function UISideEnterItem_PerfectPuzzle:OnShow(uiParams)
  self:_AttachEvents()
end

function UISideEnterItem_PerfectPuzzle:OnHide()
  self:_DetachEvents()
end

function UISideEnterItem_PerfectPuzzle:_LoadCampaign(TT)
  local campaignType, campaignId = self._btnCfg.CampaignType, self._btnCfg.CampaignId
  local customFunc = UIActivityHelper.CheckCampaignSampleRedPoint_CustomFunc(campaignType)
  self._campaign = nil
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityHelper.LoadCampaign(TT, res, campaignType, campaignId)
  local localProcess = self._campaign:GetLocalProcess()
  if localProcess == nil then
    return
  end
  self._component = localProcess:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE)
  self._componentInfo = localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE)
  self.personProcess = localProcess:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
  self.personProcessInfo = localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
  self._questComponent = localProcess:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST)
  self.questcmptInfo = localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST)
  self._lineDatas = {}
  self._svrTimeModule = self:GetModule(SvrTimeModule)
end

function UISideEnterItem_PerfectPuzzle:_CheckOpen(TT)
  self:_LoadCampaign(TT)
  return self._campaign:CheckCampaignOpen()
end

function UISideEnterItem_PerfectPuzzle:GetSideEnterRawImage()
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  return cfg and cfg.SideEnterIcon
end

function UISideEnterItem_PerfectPuzzle:DoShow()
  self:_SetTitle()
  self:_SetBg()
end

function UISideEnterItem_PerfectPuzzle:_CalcNew()
  return UIActivityHelper.CheckCampaignSampleNewPoint(self._campaign) and 1 or 0
end

function UISideEnterItem_PerfectPuzzle:_CalcRed()
  self._lineDatas = {}
  local questList = self._questComponent:GetQuestInfo()
  local questRed = false
  if self._questComponent:HasQuestCanClaim(questList) then
    return true
  end
  local planRed = self.personProcess:HasCanGetReward()
  if planRed then
    return true
  end
  local cfgs = Cfg.cfg_component_perfect_puzzle({
    ComponentID = self._component:GetComponentCfgId()
  })
  if cfgs then
    for _, cfg in pairs(cfgs) do
      table.insert(self._lineDatas, cfg)
    end
  end
  table.sort(self._lineDatas, function(a, b)
    return a.MissionID < b.MissionID
  end)
  if self._componentInfo.m_pass_mission_info ~= nil and table.count(self._componentInfo.m_pass_mission_info) < 5 then
    local count = table.count(self._componentInfo.m_pass_mission_info) + 1
    local curMissionCfg = self._lineDatas[count]
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local time = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(curMissionCfg.UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local endTime = time
    if curTime < endTime then
      return false
    else
      local day, hour, min, second = UIActivityHelper.Time2Str(curTime)
      local timeStr = "PerfectPuzzle_RedCheck" .. day .. curMissionCfg.MissionID
      if UIActivityHelper.HasLocalDB(timeStr) then
        return false
      end
    end
    return true
  end
  return false
end

function UISideEnterItem_PerfectPuzzle:IsUnlock(cfg)
  local preMissionUnlock = false
  local timeUnlock = false
  if cfg then
    preMissionUnlock = cfg.NeedMissionId <= 0 or self._componentInfo.m_pass_mission_info[cfg.NeedMissionId] ~= nil
    timeUnlock = self:_IsUnlock(cfg.UnlockTime)
  end
  return preMissionUnlock and timeUnlock
end

function UISideEnterItem_PerfectPuzzle:_IsUnlock(UnlockTime)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local unlockTime = loginModule:GetTimeStampByTimeStr(UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local curTime = svrTimeModule:GetServerTime() * 0.001
  return unlockTime <= curTime
end

function UISideEnterItem_PerfectPuzzle:_SetTitle()
  local widgetName = self._btnCfg.AutoUITitle
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  local strId = cfg and cfg.CampaignName
  if widgetName and strId then
    UIWidgetHelper.SetLocalizationText(self, widgetName, StringTable.Get(strId))
  end
end

function UISideEnterItem_PerfectPuzzle:_SetBg()
  local widgetName = self._btnCfg.AutoUIBg
  local sideEnterIcon = self:GetSideEnterRawImage()
  if widgetName and sideEnterIcon then
    UIWidgetHelper.SetRawImage(self, widgetName, sideEnterIcon)
  end
end

function UISideEnterItem_PerfectPuzzle:_AttachEvents()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._OnCampaignClose)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UISideEnterItem_PerfectPuzzle:_DetachEvents()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._OnCampaignClose)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UISideEnterItem_PerfectPuzzle:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckPoint()
  end
end

function UISideEnterItem_PerfectPuzzle:_OnQuestUpdate()
  if self._campaign then
    self:_CheckPoint()
  end
end

function UISideEnterItem_PerfectPuzzle:_OnAfterUILayerChanged()
  if self._campaign then
    self:_CheckPoint()
  end
end

function UISideEnterItem_PerfectPuzzle:_OnCampaignClose(id)
  if self._campaign and self._campaign._id == id then
    self._setShowCallback(false)
  end
end
