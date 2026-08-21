_class("UICN21N50HardLevel", UIController)
UICN21N50HardLevel = UICN21N50HardLevel

function UICN21N50HardLevel:Constructor()
  self._isReview = false
end

function UICN21N50HardLevel:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaignType = UICN21N50Helper.GetCampaignType(self._isReview)
  self._componentId_BlackMission = UICN21N50Helper.GetComponentId("black", self._isReview)
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

function UICN21N50HardLevel:OnShow(uiParams)
  self._black_component = self._campaign:GetComponent(self._componentId_BlackMission)
  self._blackHardCompInfo = self._campaign:GetComponentInfo(self._componentId_BlackMission)
  self:AttachEvent(GameEventType.ActivityComponentCloseEvent, self.OnComponentClose)
  self:AttachEvent(GameEventType.OnCampDiffTeamReset, self.ClearTeam)
  self:InitWidget()
  self:InitCommonTopButton()
  self:_InitLevelData()
  self:SetTimeTex()
end

function UICN21N50HardLevel:_InitLevelData()
  if not self._levelDatas then
    self._levelDatas = {}
    local componentCfgId = self._black_component:GetComponentCfgId()
    local cfgs = Cfg.cfg_difficulty_parent_mission({ComponentID = componentCfgId})
    cfgs = self:_SortCfg(cfgs)
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

function UICN21N50HardLevel:_SortCfg(cfgs)
  table.sort(cfgs, function(a, b)
    return a.ID < b.ID
  end)
  return cfgs
end

function UICN21N50HardLevel:_Refresh(playAnim)
  for i = 1, 6 do
    local data = self._levelDatas[i]
    self._levels[i]:SetData(i, data, self._passInfo, self._curIndex)
  end
end

function UICN21N50HardLevel:SetTimeTex()
  if not self._isReview then
    local endTime = self._black_component:GetComponentInfo().m_close_time
    self:_SetRemainingTime("_time", "str_cn21_n50_remain_time_in_activity", endTime)
  end
end

function UICN21N50HardLevel:_SetRemainingTime(widgetName, descId, endTime)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetExtraRollingText()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UICN21N50HardLevel:InitCommonTopButton()
  self.topButtonWidget = self.topbuttons:SpawnObject("UINewCommonTopButton")
  self.topButtonWidget:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UICN21N50MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
end

function UICN21N50HardLevel:OnHide()
  self:DetachEvent(GameEventType.ActivityComponentCloseEvent, self.OnComponentClose)
  self:DetachEvent(GameEventType.OnCampDiffTeamReset, self.ClearTeam)
  self._isShow = false
end

function UICN21N50HardLevel:ClearTeam()
  self:_InitLevelData()
end

function UICN21N50HardLevel:OnComponentClose(componentCfgId)
end

function UICN21N50HardLevel:_Back()
  local campaignMain = CampaignConst.GetSafeStateInfo(self._campaign._id, nil, UIStateType.UICN21N50MainController, nil)
  local uiMain = CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIMain, nil)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:SwitchState_Safe(true, {campaignMain, uiMain})
end

function UICN21N50HardLevel:InitWidget()
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self._levels = {}
  for i = 1, 6 do
    self._levels[i] = UICN21N50HardLevelItem:New(self:GetUIComponent("UIView", "Level" .. i))
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
  self._bg2loader = self:GetUIComponent("RawImageLoader", "Bg2")
end

function UICN21N50HardLevel:_EnterLevel(idx)
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
    campaignModule:CampaignSwitchState(true, UIStateType.UICN21N50MainController, UIStateType.UIMain, nil, self._campaign._id)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIActivityDiffLevelDetail", leveldata, self._black_component)
end

function UICN21N50HardLevel:Press1OnClick()
  self:_EnterLevel(1)
end

function UICN21N50HardLevel:Press2OnClick()
  self:_EnterLevel(2)
end

function UICN21N50HardLevel:Press3OnClick()
  self:_EnterLevel(3)
end

function UICN21N50HardLevel:Press4OnClick()
  self:_EnterLevel(4)
end

function UICN21N50HardLevel:Press5OnClick()
  self:_EnterLevel(5)
end

function UICN21N50HardLevel:Press6OnClick()
  self:_EnterLevel(6)
end

function UICN21N50HardLevel:InfoBtnOnClick()
  local endTime = self._blackHardCompInfo.m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local remainTime = endTime - curTime
  remainTime = math.max(remainTime, 0)
  if remainTime <= 0 then
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UICN21N50HardLevel, UIStateType.UIMain, nil, self._campaign._id)
    return
  end
  self:ShowDialog("UIIntroLoader", "UICN21N50HardLevel")
end

function UICN21N50HardLevel:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end
