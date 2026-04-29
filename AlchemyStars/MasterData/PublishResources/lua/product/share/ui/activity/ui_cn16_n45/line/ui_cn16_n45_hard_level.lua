_class("UICN16N45HardLevel", UIController)
UICN16N45HardLevel = UICN16N45HardLevel

function UICN16N45HardLevel:Constructor()
  self._isReview = false
end

function UICN16N45HardLevel:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaignType = UICN16N45Helper.GetCampaignType(self._isReview)
  self._componentId_BlackMission = UICN16N45Helper.GetComponentId("black", self._isReview)
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, self._campaignType, {
    self._componentId_BlackMission
  })
  self._blackHardCompInfo = self._campaign:GetComponentInfo(self._componentId_BlackMission)
  local openTime = self._blackHardCompInfo.m_unlock_time
  local closeTime = self._blackHardCompInfo.m_close_time
  local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
  if openTime > now then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
    campaignModule:ShowErrorToast(res.m_result, true)
    return
  elseif closeTime < now then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
    campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
  if not self._blackHardCompInfo.m_b_unlock then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_UNLOCK
    local cfgv = Cfg.cfg_campaign_mission[self._blackHardCompInfo.m_need_mission_id]
    if cfgv then
      local lvName = StringTable.Get(cfgv.Name)
      local msg = StringTable.Get("str_activity_common_will_open_after_clearance", lvName)
      ToastManager.ShowToast(msg)
    end
    return
  end
  local fRes = AsyncRequestRes:New()
  self._campaign:ReLoadCampaignInfo_Force(TT, fRes)
  UIActivityDiffLevelCupData.CreateEntiesDesc()
end

function UICN16N45HardLevel:OnShow(uiParams)
  self._black_component = self._campaign:GetComponent(self._componentId_BlackMission)
  self._blackHardCompInfo = self._campaign:GetComponentInfo(self._componentId_BlackMission)
  self:AttachEvent(GameEventType.ActivityComponentCloseEvent, self.OnComponentClose)
  self:AttachEvent(GameEventType.OnCampDiffTeamReset, self.ClearTeam)
  self:InitWidget()
  self:InitCommonTopButton()
  self:_InitLevelData()
end

function UICN16N45HardLevel:_InitLevelData()
  if not self._levelDatas then
    self._levelDatas = {}
    local componentCfgId = self._black_component:GetComponentCfgId()
    local cfgs = Cfg.cfg_difficulty_parent_mission({ComponentID = componentCfgId})
    cfgs = self:_sortCfg(cfgs)
    if cfgs ~= nil then
      for k, cfg in pairs(cfgs) do
        local data = UIActivityDiffLevelData:New()
        data:InitParentLevel(self._black_component, self._blackHardCompInfo, cfg)
        self._levelDatas[#self._levelDatas + 1] = data
      end
    end
  else
    for i = 1, #self._levelDatas do
      self._levelDatas[i]:RefreshParentLevel(self._black_component, self._blackHardCompInfo)
    end
  end
  self._curIndex = 1
  self._passInfo = self._blackHardCompInfo.infos
  self._curIndex = table.count(self._passInfo) + 1
  if table.count(self._passInfo) > #self._levelDatas then
    self._curIndex = #self._levelDatas
  end
  self:_Refresh()
end

function UICN16N45HardLevel:_sortCfg(cfgs)
  table.sort(cfgs, function(a, b)
    return a.ID < b.ID
  end)
  return cfgs
end

function UICN16N45HardLevel:_Refresh(playAnim)
  for i = 1, 6 do
    local data = self._levelDatas[i]
    self._levels[i]:SetData(i, data, self._passInfo, self._curIndex)
  end
end

function UICN16N45HardLevel:InitCommonTopButton()
  self.topButtonWidget = self.topbuttons:SpawnObject("UINewCommonTopButton")
  self.topButtonWidget:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UICN16N45MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
end

function UICN16N45HardLevel:RefreshTime()
  local endTime = self._blackHardCompInfo.m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local remainTime = endTime - curTime
  remainTime = math.max(remainTime, 0)
  if 0 < remainTime then
    local timeStr = StringTable.Get("str_cn16_n45_remain_time_in_activity", self:GetFormatTimerStr(remainTime))
    if self._timeString ~= timeStr then
      self._time:SetText(timeStr)
      self._timeString = timeStr
    end
  else
    self._time:SetText(StringTable.Get("str_activity_error_107"))
  end
end

function UICN16N45HardLevel:GetFormatTimerStr(time, id)
  local default_id = {
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107"
  }
  id = id or default_id
  local timeStr = StringTable.Get(id.over)
  if time < 0 then
    return timeStr
  end
  local day, hour, min, second = UIActivityHelper.Time2Str(time)
  if 0 < day then
    timeStr = day .. StringTable.Get(id.day)
    if hour ~= 0 then
      timeStr = timeStr .. hour .. StringTable.Get(id.hour)
    end
  elseif 0 < hour then
    timeStr = hour .. StringTable.Get(id.hour)
    if min ~= 0 then
      timeStr = timeStr .. min .. StringTable.Get(id.min)
    end
  elseif 0 < min then
    timeStr = min .. StringTable.Get(id.min)
  else
    timeStr = StringTable.Get(id.zero)
  end
  return timeStr
end

function UICN16N45HardLevel:OnUpdate()
  self:RefreshTime()
end

function UICN16N45HardLevel:OnHide()
  self:DetachEvent(GameEventType.ActivityComponentCloseEvent, self.OnComponentClose)
  self:DetachEvent(GameEventType.OnCampDiffTeamReset, self.ClearTeam)
  self._isShow = false
end

function UICN16N45HardLevel:ClearTeam()
  self:_InitLevelData()
end

function UICN16N45HardLevel:OnComponentClose(componentCfgId)
end

function UICN16N45HardLevel:_Back()
  local campaignMain = CampaignConst.GetSafeStateInfo(self._campaign._id, nil, UIStateType.UICN16N45MainController, nil)
  local uiMain = CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIMain, nil)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:SwitchState_Safe(true, {campaignMain, uiMain})
end

function UICN16N45HardLevel:InitWidget()
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self._levels = {}
  for i = 1, 6 do
    self._levels[i] = UICN16N45HardLevelItem:New(self:GetUIComponent("UIView", "Level" .. i))
  end
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "BlurHelper")
  self._shotRect = self:GetUIComponent("RectTransform", "BlurHelper")
  self._width = self._shotRect.rect.width
  self._height = self._shotRect.rect.height
  self._shot.width = self._width
  self._shot.height = self._height
  self._shot.blurTimes = 0
  self._scale = 1.2
  self._level1pos1 = self:GetUIComponent("RectTransform", "level1pos1")
  self._level1pos2 = self:GetUIComponent("RectTransform", "level1pos2")
  self._level2pos1 = self:GetUIComponent("RectTransform", "level2pos1")
  self._level2pos2 = self:GetUIComponent("RectTransform", "level2pos2")
  self._level2OpenTip = self:GetGameObject("lv2OpenTip")
  self._level2OpenTip:SetActive(false)
  self._tipAnim = self:GetUIComponent("Animation", "lv2OpenTip")
  self._bg2loader = self:GetUIComponent("RawImageLoader", "Bg2")
  self._time = self:GetUIComponent("UILocalizationText", "RemainTime")
  self:RefreshTime()
end

function UICN16N45HardLevel:_EnterLevel(idx)
  local leveldata = self._levelDatas[idx]
  local isOpen = leveldata._isOpen
  if not isOpen then
    ToastManager.ShowToast(StringTable.Get("str_activity_diff_unlock_tips"))
    return
  end
  local endTime = self._blackHardCompInfo.m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local remainTime = endTime - curTime
  remainTime = math.max(remainTime, 0)
  if remainTime <= 0 then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    ToastManager.ShowToast(StringTable.Get("str_activity_error_107"))
    campaignModule:CampaignSwitchState(true, UIStateType.UICN16N45MainController, UIStateType.UIMain, nil, self._campaign._id)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIActivityDiffLevelDetail", leveldata, self._black_component)
end

function UICN16N45HardLevel:Press1OnClick()
  self:_EnterLevel(1)
end

function UICN16N45HardLevel:Press2OnClick()
  self:_EnterLevel(2)
end

function UICN16N45HardLevel:Press3OnClick()
  self:_EnterLevel(3)
end

function UICN16N45HardLevel:Press4OnClick()
  self:_EnterLevel(4)
end

function UICN16N45HardLevel:Press5OnClick()
  self:_EnterLevel(5)
end

function UICN16N45HardLevel:Press6OnClick()
  self:_EnterLevel(6)
end

function UICN16N45HardLevel:InfoBtnOnClick()
  local endTime = self._blackHardCompInfo.m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local remainTime = endTime - curTime
  remainTime = math.max(remainTime, 0)
  if remainTime <= 0 then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UICN16N45HardLevel, UIStateType.UIMain, nil, self._campaign._id)
    return
  end
  self:ShowDialog("UIIntroLoader", "UICN16N45HardLevel", MaskType.MT_BlurMask)
end

function UICN16N45HardLevel:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end
