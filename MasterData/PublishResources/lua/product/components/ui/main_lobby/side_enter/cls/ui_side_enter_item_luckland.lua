require("ui_side_enter_item_base")
_class("UISideEnterItem_LuckLand", UISideEnterItem_Base)
UISideEnterItem_LuckLand = UISideEnterItem_LuckLand

function UISideEnterItem_LuckLand:OnShow(uiParams)
  self:_AttachEvents()
end

function UISideEnterItem_LuckLand:OnHide()
  self:_DetachEvents()
end

function UISideEnterItem_LuckLand:_LoadCampaign(TT)
  local campaignType, campaignId = self._btnCfg.CampaignType, self._btnCfg.CampaignId
  local customFunc = UIActivityHelper.CheckCampaignSampleRedPoint_CustomFunc(campaignType)
  self._campaign = nil
  if customFunc then
    local res = AsyncRequestRes:New()
    self._campaign = UIActivityHelper.LoadCampaign(TT, res, campaignType, campaignId)
  else
    self._campaign = UIActivityHelper.LoadCampaign_Local(campaignType, campaignId)
  end
  local localProcess = self._campaign:GetLocalProcess()
  self._component = localProcess:GetComponent(ECampaignN11CenterComponentID.ECAMPAIGN_N11_LUCK_LAND)
  self._componentInfo = localProcess:GetComponentInfo(ECampaignN11CenterComponentID.ECAMPAIGN_N11_LUCK_LAND)
end

function UISideEnterItem_LuckLand:_CheckOpen(TT)
  self:_LoadCampaign(TT)
  return self._campaign:CheckCampaignOpen()
end

function UISideEnterItem_LuckLand:GetSideEnterRawImage()
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  return cfg and cfg.SideEnterIcon
end

function UISideEnterItem_LuckLand:DoShow()
  self:_SetTitle()
  self:_SetBg()
end

function UISideEnterItem_LuckLand:_CalcNew()
  return UIActivityHelper.CheckCampaignSampleNewPoint(self._campaign) and 1 or 0
end

function UISideEnterItem_LuckLand:_CalcRed()
  if not self._component then
    return false
  end
  self._lineDatas = {}
  local cfgs = Cfg.cfg_component_luck_land({
    ComponentID = self._component:GetComponentCfgId()
  })
  if cfgs then
    for _, cfg in pairs(cfgs) do
      if not self._lineDatas[cfg.Line] then
        self._lineDatas[cfg.Line] = {}
      end
      table.insert(self._lineDatas[cfg.Line], cfg)
    end
  end
  for _, lineDatas in pairs(self._lineDatas) do
    table.sort(lineDatas, function(a, b)
      return a.MissionID < b.MissionID
    end)
  end
  for i = 1, #self._lineDatas do
    local r1 = self:IsUnlock(self._lineDatas[i][1])
    local r2 = LocalDB.GetInt("LuckLandLevel_Unlock_Line_" .. GameGlobal.GetModule(RoleModule):GetPstId() .. i, 0) <= 0
    if r1 and r2 then
      return true
    end
  end
  return false
end

function UISideEnterItem_LuckLand:IsUnlock(cfg)
  local preMissionUnlock = false
  local timeUnlock = false
  if cfg then
    preMissionUnlock = cfg.NeedMissionId <= 0 or self._componentInfo.m_pass_mission_info[cfg.NeedMissionId] ~= nil
    timeUnlock = self:_IsUnlock(cfg.UnlockTime)
  end
  return preMissionUnlock and timeUnlock
end

function UISideEnterItem_LuckLand:_IsUnlock(UnlockTime)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local unlockTime = loginModule:GetTimeStampByTimeStr(UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local curTime = svrTimeModule:GetServerTime() * 0.001
  return unlockTime <= curTime
end

function UISideEnterItem_LuckLand:_SetTitle()
  local widgetName = self._btnCfg.AutoUITitle
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  local strId = cfg and cfg.CampaignName
  if widgetName and strId then
    UIWidgetHelper.SetLocalizationText(self, widgetName, StringTable.Get(strId))
  end
end

function UISideEnterItem_LuckLand:_SetBg()
  local widgetName = self._btnCfg.AutoUIBg
  local sideEnterIcon = self:GetSideEnterRawImage()
  if widgetName and sideEnterIcon then
    UIWidgetHelper.SetRawImage(self, widgetName, sideEnterIcon)
  end
end

function UISideEnterItem_LuckLand:_AttachEvents()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._OnCampaignClose)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UISideEnterItem_LuckLand:_DetachEvents()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._OnCampaignClose)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UISideEnterItem_LuckLand:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckPoint()
  end
end

function UISideEnterItem_LuckLand:_OnQuestUpdate()
  if self._campaign then
    self:_CheckPoint()
  end
end

function UISideEnterItem_LuckLand:_OnAfterUILayerChanged()
  if self._campaign then
    self:_CheckPoint()
  end
end

function UISideEnterItem_LuckLand:_OnCampaignClose(id)
  if self._campaign and self._campaign._id == id then
    self._setShowCallback(false)
  end
end
