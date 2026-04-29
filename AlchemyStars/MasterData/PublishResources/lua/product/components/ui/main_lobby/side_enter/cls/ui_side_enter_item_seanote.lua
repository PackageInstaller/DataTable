require("ui_side_enter_item_base")
_class("UISideEnterItem_SeaNote", UISideEnterItem_Base)
UISideEnterItem_SeaNote = UISideEnterItem_SeaNote

function UISideEnterItem_SeaNote:OnShow(uiParams)
  self:_AttachEvents()
end

function UISideEnterItem_SeaNote:OnHide()
  self:_DetachEvents()
end

function UISideEnterItem_SeaNote:_LoadCampaign(TT)
  local campaignType, campaignId = self._btnCfg.CampaignType, self._btnCfg.CampaignId
  local customFunc = UIActivityHelper.CheckCampaignSampleRedPoint_CustomFunc(campaignType)
  self._campaign = nil
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityHelper.LoadCampaign(TT, res, campaignType, campaignId)
  local localProcess = self._campaign:GetLocalProcess()
  self._component = localProcess:GetComponent(ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP)
  self._componentInfo = localProcess:GetComponentInfo(ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP)
  self._lineDatas = {}
  self._svrTimeModule = self:GetModule(SvrTimeModule)
end

function UISideEnterItem_SeaNote:_CheckOpen(TT)
  self:_LoadCampaign(TT)
  return self._campaign:CheckCampaignOpen()
end

function UISideEnterItem_SeaNote:GetSideEnterRawImage()
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  return cfg and cfg.SideEnterIcon
end

function UISideEnterItem_SeaNote:DoShow()
  self:_SetTitle()
  self:_SetBg()
end

function UISideEnterItem_SeaNote:_CalcNew()
  return UIActivityHelper.CheckCampaignSampleNewPoint(self._campaign) and 1 or 0
end

function UISideEnterItem_SeaNote:_CalcRed()
  self._lineDatas = {}
  if self._component == nil then
    return false
  end
  if not self._campaign:CheckComponentOpen() then
    return
  end
  local cfgs = Cfg.cfg_component_asheep_mission({
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
  local subkey = 3011
  local curPass = 0
  for key, value in pairs(self._componentInfo.m_info.m_pass_mission_info) do
    if key ~= subkey then
      curPass = curPass + 1
    end
  end
  if self._componentInfo.m_info.m_pass_mission_info ~= nil then
    if curPass < 10 then
      local count = curPass + 1
      local curMissionCfg = self._lineDatas[count]
      local curTime = self._svrTimeModule:GetServerTime() * 0.001
      if curMissionCfg.OpenTime ~= nil then
        local time = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(curMissionCfg.OpenTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
        local endTime = time
        if curTime < endTime then
          return false
        else
          local day, hour, min, second = UIActivityHelper.Time2Str(curTime)
          local timeStr = "SeaNoteEnter_RedCheck" .. day .. curMissionCfg.MissionID
          if UIActivityHelper.HasLocalDB(timeStr) then
            return false
          end
        end
        return true
      end
    else
      return false
    end
  end
  local count = curPass + 1
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local day, hour, min, second = UIActivityHelper.Time2Str(curTime)
  local timeStr = "SeaNoteEnter_RedCheck" .. day .. self._lineDatas[count].MissionID
  if not UIActivityHelper.HasLocalDB(timeStr) then
    return true
  end
  return false
end

function UISideEnterItem_SeaNote:_SetTitle()
  local widgetName = self._btnCfg.AutoUITitle
  local cfg = Cfg.cfg_campaign[self._campaign._id]
  local strId = cfg and cfg.CampaignName
  if widgetName and strId then
    UIWidgetHelper.SetLocalizationText(self, widgetName, StringTable.Get(strId))
  end
end

function UISideEnterItem_SeaNote:_SetBg()
  local widgetName = self._btnCfg.AutoUIBg
  local sideEnterIcon = self:GetSideEnterRawImage()
  if widgetName and sideEnterIcon then
    UIWidgetHelper.SetRawImage(self, widgetName, sideEnterIcon)
  end
end

function UISideEnterItem_SeaNote:_AttachEvents()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._OnCampaignClose)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UISideEnterItem_SeaNote:_DetachEvents()
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._OnAfterUILayerChanged)
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._OnCampaignClose)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
end

function UISideEnterItem_SeaNote:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckPoint()
  end
end

function UISideEnterItem_SeaNote:_OnAfterUILayerChanged()
  if self._campaign then
    self:_CheckPoint()
  end
end

function UISideEnterItem_SeaNote:_OnCampaignClose(id)
  if self._campaign and self._campaign._id == id then
    self._setShowCallback(false)
  end
end
