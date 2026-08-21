_class("UIMainLobbyCampCenter", UICustomWidget)
UIMainLobbyCampCenter = UIMainLobbyCampCenter

function UIMainLobbyCampCenter:OnShow(uiParams)
  self._BtnGo = self:GetGameObject("Btn")
  self._newGo = self:GetGameObject("_new")
  self._redGo = self:GetGameObject("_red")
  self:_AttachEvents()
end

function UIMainLobbyCampCenter:OnHide()
end

function UIMainLobbyCampCenter:SetData(data)
  self._data = data
  self:_CheckPoint()
  self:PlayEnterAnim()
end

function UIMainLobbyCampCenter:PlayEnterAnim()
  local anim = self:GetUIComponent("Animation", "UIMainLobbyCampCenter")
  anim:Play("uieff_UIMainLobbyCampCenter_in")
end

function UIMainLobbyCampCenter:_Refresh()
  self:Lock("UIMainLobbyCampCenter:_Refresh")
  GameGlobal.TaskManager():StartTask(self.ReLoadData, self)
end

function UIMainLobbyCampCenter:ReLoadData(TT)
  if self._data then
    self._data:ReLoadData(TT)
  end
  self:UnLock("UIMainLobbyCampCenter:_Refresh")
end

function UIMainLobbyCampCenter:_CheckPoint()
  local openList = self._data:GetOpenList()
  local open = false
  if openList and next(openList) then
    open = true
  end
  self._BtnGo:SetActive(open)
  if open then
    local redCount = self._data:CheckRed()
    local newCount = self._data:CheckNew()
    self._newGo:SetActive(0 < newCount)
    self._redGo:SetActive(newCount == 0 and 0 < redCount)
  end
end

function UIMainLobbyCampCenter:BtnOnClick()
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_CAMPAIGN_CENTER)
  self:ShowDialog("UISideEnterCenterController")
end

function UIMainLobbyCampCenter:_AttachEvents()
  self:AttachEvent(GameEventType.SideEnterRefresh, self._OnSideEnterRefresh)
end

function UIMainLobbyCampCenter:_OnSideEnterRefresh()
  self:_Refresh()
end

function UIMainLobbyCampCenter:RefreshCampSampleInfo(data)
  self._data = data
  self:_CheckPoint()
end

_class("MainLobbyCenterData", Object)
MainLobbyCenterData = MainLobbyCenterData

function MainLobbyCenterData:Constructor()
  self._cfgid2loaddata = {}
end

function MainLobbyCenterData:SetAllList()
  local campModule = GameGlobal.GetModule(CampaignModule)
  local campDic = campModule:GetCampaignSampleDic()
  local cfgs = Cfg.cfg_main_side_enter_center({IsActive = true})
  self._allList = {}
  if cfgs and next(cfgs) then
    local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
    for idx, cfg in pairs(cfgs) do
      local inner = false
      local contentParams = cfg.ContentParams
      if contentParams and table.count(contentParams) > 0 then
        local campType = contentParams.campaign_type
        local sampleInfo = campModule:GetSampleByType(campType)
        if sampleInfo and sampleInfo:IsShow(svrTime) then
          local campid = sampleInfo.id
          if campDic[campid] then
            inner = true
          end
        end
      else
        inner = true
      end
      if inner then
        local data
        if cfg.GetDataClassName then
          data = _createInstance(cfg.GetDataClassName, cfg)
        else
          data = MainLobbyCenterCampData:New(cfg)
        end
        table.insert(self._allList, data)
      end
    end
  end
end

function MainLobbyCenterData:LoadCampaignData(TT)
  self:SetAllList()
  self:LoadDataWithRequest(TT)
  self:SetOpenList()
end

function MainLobbyCenterData:LoadDataWithRequest(TT)
  if self._allList and next(self._allList) then
    for key, value in pairs(self._allList) do
      value:LoadData(TT)
    end
  end
end

function MainLobbyCenterData:RefreshCampSampleInfo(TT)
  self:SetAllList()
  self:LoadDataWithRequest(TT)
  self:SetOpenList()
end

function MainLobbyCenterData:ReLoadData(TT)
  self:SetAllList()
  if self._allList and next(self._allList) then
    for key, value in pairs(self._allList) do
      value:LoadData(TT)
    end
  end
  self:SetOpenList()
end

function MainLobbyCenterData:SetOpenList()
  self._openList = {}
  if self._allList and next(self._allList) then
    for key, value in pairs(self._allList) do
      if value:CheckOpen() then
        table.insert(self._openList, value)
      end
    end
  end
end

function MainLobbyCenterData:GetOpenList()
  return self._openList
end

function MainLobbyCenterData:CheckRed()
  local redCount = 0
  if self._openList and next(self._openList) then
    for key, value in pairs(self._openList) do
      local redNum = value:CheckRed()
      redCount = redCount + redNum
    end
  end
  return redCount
end

function MainLobbyCenterData:CheckNew()
  local newCount = 0
  if self._openList and next(self._openList) then
    for key, value in pairs(self._openList) do
      local newNum = value:CheckNew()
      newCount = newCount + newNum
    end
  end
  return newCount
end

function MainLobbyCenterData.FixedTime(beginTime, endTime)
  if beginTime == nil or endTime == nil then
    Log.exception("###[MainLobbyCenterData] CheckOpen time = nil", debug.traceback())
    return false
  end
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local beginTime = loginModule:GetTimeStampByTimeStr(beginTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local endTime = loginModule:GetTimeStampByTimeStr(endTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  if curTime >= beginTime and curTime < endTime then
    return true
  end
  return false
end

function MainLobbyCenterData.ServerTime(beginTime, endTime)
  if beginTime == nil or endTime == nil then
    Log.exception("###[MainLobbyCenterData] CheckOpen time = nil", debug.traceback())
    return false
  end
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local beginTime = loginModule:GetTimeStampByTimeStr(beginTime, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
  local endTime = loginModule:GetTimeStampByTimeStr(endTime, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
  if curTime >= beginTime and curTime < endTime then
    return true
  end
  return false
end

function MainLobbyCenterData.Sample(campType, campID)
  local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  local campModule = GameGlobal.GetModule(CampaignModule)
  local sampleInfo
  if campID then
    sampleInfo = campModule:GetReviewCampaignSampleByCampaignId(campID)
  else
    sampleInfo = campModule:GetSampleByType(campType)
  end
  return sampleInfo and sampleInfo:IsShow(svrTime) or false
end

function MainLobbyCenterData.SampleHide(campType, campID)
  local campModule = GameGlobal.GetModule(CampaignModule)
  local sampleInfo
  if campID then
    sampleInfo = campModule:GetReviewCampaignSampleByCampaignId(campID)
  else
    sampleInfo = campModule:GetSampleByType(campType)
  end
  local hide = not sampleInfo or sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_HIDE)
  return hide
end

function MainLobbyCenterData.Channel(campType, campID)
  if EDITOR then
    return true
  end
  local current_channel_id = GCloud.MSDK.MSDKTools.GetConfigChannel()
  Log.info("###[MainLobbyCenterData.Channel] CheckChannelOpen channel:", current_channel_id)
  local cfg_msdk_channel = Cfg.cfg_msdk_channel[current_channel_id]
  local campModule = GameGlobal.GetModule(CampaignModule)
  local camp_id
  if campID then
    camp_id = campID
  else
    local sampleInfo = campModule:GetSampleByType(campType)
    camp_id = sampleInfo.id
  end
  if cfg_msdk_channel then
    local openlist = cfg_msdk_channel.ChannelActivityOpenList
    if openlist and table.icontains(openlist, camp_id) then
      return true
    end
  end
  return false
end

function MainLobbyCenterData.Author(campType, campID)
  if EDITOR then
    return true
  end
  local info = GameGlobal.GameLogic().ClientInfo
  local source = info.m_login_source
  Log.debug("###[MainLobbyCenterData] source:", source)
  if not source then
    return false
  end
  local cfg = Cfg.cfg_activity_author[source]
  if not cfg then
    Log.error("###[MainLobbyCenterData] cfg_activity_author is nil !")
    return false
  end
  local openlist = cfg.AuthorActivityOpenList
  local campModule = GameGlobal.GetModule(CampaignModule)
  local camp_id
  if campID then
    camp_id = campID
  else
    local sampleInfo = campModule:GetSampleByType(campType)
    camp_id = sampleInfo.id
  end
  if openlist and table.icontains(openlist, camp_id) then
    return true
  end
  return false
end
