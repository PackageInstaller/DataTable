_class("UIN38HardLevel", UIController)
UIN38HardLevel = UIN38HardLevel

function UIN38HardLevel:LoadDataOnEnter(TT, res)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_N9, ECampaignCN9ComponentID.ECAMPAIGN_N9_LINE_MISSION, ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION, ECampaignCN9ComponentID.ECAMPAIGN_N9_HEIXIA)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  if res and res:GetSucc() then
    local camp = self._campaign:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION)
    local campInfo = camp:GetComponentInfo()
    local openTime = campInfo.m_unlock_time
    local closeTime = campInfo.m_close_time
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
    if not campInfo.m_b_unlock then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_UNLOCK
      local cfgv = Cfg.cfg_campaign_mission[campInfo.m_need_mission_id]
      if cfgv then
        local lvName = StringTable.Get(cfgv.Name)
        local msg = StringTable.Get("str_activity_common_will_open_after_clearance", lvName)
        ToastManager.ShowToast(msg)
      end
      return
    end
    self._line_component = self._campaign:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_LINE_MISSION)
    self._line_info = self._line_component:GetComponentInfo()
  end
end

function UIN38HardLevel:OnShow(uiParams)
  self._activityConst = UIN38Const:New()
  self._activityConst:ClearHardLineNew()
  self._rootAni = self:GetUIComponent("Animation", "rootAni")
  self._paintingAni = self:GetUIComponent("Animation", "paintingAni")
  self:InitWidget()
  self:SetCommonTopButton()
  self:InitLevelCfg()
  local spine, bgm = self:GetSpineAndBgm()
  if bgm then
    AudioHelperController.PlayBGM(bgm, AudioConstValue.BGMCrossFadeTime)
  end
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._interval = 0
  self._levelComponent = self._campaign:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION)
  self._levelComponentInfo = self._levelComponent:GetComponentInfo()
  self._blevelComponent = self._campaign:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_HEIXIA)
  self._blevelComponentInfo = self._blevelComponent:GetComponentInfo()
  self._isBlack = false
  self._blackIsUnlock = false
  if self._blevelComponent:ComponentIsOpen() and table.count(self._levelComponentInfo.m_pass_mission_info) >= 4 then
    self._isBlack = true
    self._blackIsUnlock = true
    self._activityConst:ClearBlackNew()
  end
  self._atlas = self:GetAsset("UIN26Hard.spriteatlas", LoadType.SpriteAtlas)
  self._time = self:GetUIComponent("UILocalizationText", "RemainTime")
  self:_InitCfgs()
  self:_RefreshTime()
  self:_SetLevelBtns()
  if self._isBlack and self._blackIsUnlock then
    local record = UIN38Helper.LocalDB_Has("UIN38HardLevelBlackAnimation", "New")
    if not record then
      self:Lock("UIN38HardLevelBlackAnimation")
      self:StartTask(function(TT)
        UIN38Helper.LocalDB_Set("UIN38HardLevelBlackAnimation", "New")
        self._paintingAni:Play("uieff_N38_HardLevel_huandong")
        self._level2OpenTip:SetActive(true)
        self._rootAni:Play("uieff_N38_HardLevel_switch_black")
        YIELD(TT, 1833)
        self:UnLock("UIN38HardLevelBlackAnimation")
      end)
    else
      self:_RefreshLevel()
    end
  else
    self:_RefreshLevel()
  end
  self:AttachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  local fromBattle = false
  local isWin = false
  if uiParams[1] then
    fromBattle = uiParams[1][1]
    isWin = uiParams[1][2]
  end
  self:_SetHardLevelInfo()
  self:_SetBlackLevelInfo()
  self:_SwitchLevels()
  UIN38Helper.SetFirstEnterTodayFlag("UIN38Helper_EnterTime_Hard")
end

function UIN38HardLevel:InitLevelCfg()
  UIN38HardLevel.LevelCfg = {
    bghard = {
      Bg = "n25_kng_bg2",
      Bg2 = "n26_kng_bg01",
      Bg1 = "n26_kng_bg01"
    },
    bgevil = {
      Bg = "n25_kng_bg1",
      Bg2 = "n26_kng_bg02",
      Bg1 = "n26_kng_bg02"
    }
  }
end

function UIN38HardLevel:SetCommonTopButton()
  self.topButtonWidget = self.topbuttons:SpawnObject("UINewCommonTopButton")
  self.topButtonWidget:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN38MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
end

function UIN38HardLevel:_RefreshTime()
  local endTime = self._levelComponentInfo.m_close_time
  if self._isBlack then
    endTime = self._blevelComponentInfo.m_close_time
  end
  local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  if endTime <= curTime then
    self._time:SetText(StringTable.Get("str_activity_common_notice_content"))
  else
    self._time:SetText(StringTable.Get("str_n26_hard_remain_time_title") .. UIN38Line:GetFormatTimerStr(math.max(endTime - curTime, 0), "FEFCFC"))
  end
end

function UIN38HardLevel:OnUpdate(deltaTime)
  self._interval = self._interval + deltaTime
  if self._interval >= 1000 then
    self._interval = 0
    self:_RefreshTime()
    self:_RefreshBlackTime()
  end
end

function UIN38HardLevel:_RefreshBlackTime()
  if self.level2Btn then
    self._blackIsUnlock = false
    if table.count(self._levelComponentInfo.m_pass_mission_info) >= 4 then
      local endTime = self._blevelComponentInfo.m_close_time
      local unlockTime = self._blevelComponentInfo.m_unlock_time
      local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
      if unlockTime <= curTime and endTime > curTime then
        self._blackIsUnlock = true
      end
    end
    self.level2Btn:Refresh(self._blackIsUnlock)
  end
end

function UIN38HardLevel:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN26ActivityMainRedStatusRefresh)
  UIN38HardLevel.LevelCfg = nil
end

function UIN38HardLevel:InitWidget()
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self._levels = {}
  for i = 1, 4 do
    self._levels[i] = UIN38HardLevelItem:New(self:GetUIComponent("UIView", "Level" .. i))
  end
  self._blevels = {}
  for i = 1, 3 do
    self._blevels[i] = UIN38HardLevelItem:New(self:GetUIComponent("UIView", "BLevel" .. i))
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
  self._bg1loader = self:GetUIComponent("RawImageLoader", "Bg1")
  self._bg2PatternLoader = self:GetUIComponent("RawImageLoader", "Bg2Pattern")
  self._bg1PatternLoader = self:GetUIComponent("RawImageLoader", "Bg1Pattern")
  self._hardGO = self:GetGameObject("Hard")
  self._blackGO = self:GetGameObject("Black")
  self._introBtnGO = self:GetGameObject("IntroBtn")
end

function UIN38HardLevel:_EnterLevel(index)
  local endTime = self._levelComponentInfo.m_close_time
  if self._isBlack then
    endTime = self._blevelComponentInfo.m_close_time
  end
  local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  if endTime <= curTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN38MainController, UIStateType.UIMain, nil, self._campaign._id)
    return
  end
  if self._isBlack then
    local isUnlock = self._blevels[index]:IsUnlock()
    if isUnlock then
      self:Lock("OpenUIActivityDiffLevelDetail")
      self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        res:SetSucc(true)
        self._campaign:ReLoadCampaignInfo_Force(TT, res)
        if res and res:GetSucc() then
          self._blevelComponent = self._campaign:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_HEIXIA)
          self:ShowDialog("UIActivityDiffLevelDetail", self._blevelDatas[index], self._blevelComponent)
        end
        self:UnLock("OpenUIActivityDiffLevelDetail")
      end)
    else
      ToastManager.ShowToast(StringTable.Get("str_activity_diff_unlock_tips"))
    end
  else
    local cfg = self._levelCfgs[index]
    if cfg.NeedMissionId > 0 and not self._levelComponentInfo.m_pass_mission_info[cfg.NeedMissionId] then
      local cfg = self._levelCfgs[index]
      local missionCfg = Cfg.cfg_campaign_mission[cfg.NeedMissionId]
      ToastManager.ShowToast(StringTable.Get("str_n38_hard_level_lock_tips", StringTable.Get(missionCfg.Name)))
      return
    end
    local missionID = cfg.CampaignMissionId
    self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    self._shot:CleanRenderTexture()
    local missionCfg = Cfg.cfg_campaign_mission[missionID]
    local autoFightShow = self:_CheckSerialAutoFightShow(missionCfg.Type, missionID)
    self:ShowDialog("UIActivityLevelStageNew", missionID, self._levelComponentInfo.m_pass_mission_info[missionID], self._levelComponent, autoFightShow, nil, true, true)
  end
end

function UIN38HardLevel:_CheckSerialAutoFightShow(stageType, stageId)
  local autoFightShow = false
  if stageType == DiscoveryStageType.Plot then
    autoFightShow = false
  else
    local missionCfg = Cfg.cfg_campaign_mission[stageId]
    if missionCfg then
      local enableParam = missionCfg.EnableSerialAutoFight
      if enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_DISABLE then
        autoFightShow = false
      elseif enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_ENABLE then
        autoFightShow = true
      elseif enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_NEED_UNLOCK then
        autoFightShow = true
      end
    end
  end
  return autoFightShow
end

function UIN38HardLevel:_InitCfgs()
  local cptID = self._levelComponent:GetComponentCfgId()
  local hardMissions = Cfg.cfg_component_line_mission({ComponentID = cptID})
  table.sort(hardMissions, function(a, b)
    return a.SortId < b.SortId
  end)
  self._levelCfgs = hardMissions
  cptID = self._blevelComponent:GetComponentCfgId()
  local blackMissions = Cfg.cfg_component_difficulty_mission({ComponentID = cptID})
  table.sort(blackMissions, function(a, b)
    return a.SortId < b.SortId
  end)
  self._blevelCfgs = blackMissions
  UIActivityDiffLevelCupData.CreateEntiesDesc()
  self._blevelDatas = {}
  local cfgs = Cfg.cfg_difficulty_parent_mission({
    ComponentID = self._blevelComponent:GetComponentCfgId()
  })
  if cfgs ~= nil then
    table.sort(cfgs, function(a, b)
      return a.ID < b.ID
    end)
    for k, cfg in pairs(cfgs) do
      local data = UIActivityDiffLevelData:New()
      data:InitParentLevel(self._blevelComponent, self._blevelComponentInfo, cfg)
      self._blevelDatas[#self._blevelDatas + 1] = data
    end
  end
end

function UIN38HardLevel:_RefreshLevel()
  self._bg1loader.gameObject:SetActive(not self._isBlack)
  self._bg1PatternLoader.gameObject:SetActive(not self._isBlack)
  self._bg2loader.gameObject:SetActive(self._isBlack)
  self._bg2PatternLoader.gameObject:SetActive(self._isBlack)
  if self._isBlack then
    self._rootAni:Play("uieff_N38_HardLevel_in_black")
  else
    self._rootAni:Play("uieff_N38_HardLevel_in_hard")
  end
end

function UIN38HardLevel:Press1OnClick()
  self:_EnterLevel(1)
end

function UIN38HardLevel:Press2OnClick()
  self:_EnterLevel(2)
end

function UIN38HardLevel:Press3OnClick()
  self:_EnterLevel(3)
end

function UIN38HardLevel:Press4OnClick()
  self:_EnterLevel(4)
end

function UIN38HardLevel:Bpress1OnClick()
  self:_EnterLevel(1)
end

function UIN38HardLevel:Bpress2OnClick()
  self:_EnterLevel(2)
end

function UIN38HardLevel:Bpress3OnClick()
  self:_EnterLevel(3)
end

function UIN38HardLevel:_SetLevelBtns()
  self.level1Btn = self:_SpawnObject("level1", "UIN38HardLevelBtn")
  self.level1Btn:SetData(self._atlas, false, self._blackIsUnlock, function(isBlack)
    self:OnClickLevelBtn(isBlack)
  end)
  self.level2Btn = self:_SpawnObject("level2", "UIN38HardLevelBtn")
  self.level2Btn:SetData(self._atlas, true, self._blackIsUnlock, function(isBlack)
    self:OnClickLevelBtn(isBlack)
  end)
end

function UIN38HardLevel:OnClickLevelBtn(isBlack)
  local endTime = self._levelComponentInfo.m_close_time
  if isBlack then
    endTime = self._blevelComponentInfo.m_close_time
  end
  local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  if endTime <= curTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN38MainController, UIStateType.UIMain, nil, self._campaign._id)
    return
  end
  if isBlack and not self._blackIsUnlock then
    if table.count(self._levelComponentInfo.m_pass_mission_info) < 4 then
      local cfg = self._levelCfgs[4]
      local missionCfg = Cfg.cfg_campaign_mission[cfg.CampaignMissionId]
      ToastManager.ShowToast(StringTable.Get("str_n38_hard_level_lock_tips", StringTable.Get(missionCfg.Name)))
      return
    end
    if not self._blevelComponent:ComponentIsOpen() then
      local unlockTime = self._blevelComponentInfo.m_unlock_time
      local curTime = self._svrTimeModule:GetServerTime() * 0.001
      if unlockTime > curTime then
        ToastManager.ShowToast(StringTable.Get("str_n38_hard_level_time_lock", UIN38Line:GetFormatTimerStr(math.max(unlockTime - curTime, 0))))
      end
      return
    end
  end
  if self._isBlack == isBlack then
    return
  end
  self._isBlack = isBlack
  self:_SwitchBG()
  self:_RefreshTime()
end

function UIN38HardLevel:_SwitchLevels()
end

function UIN38HardLevel:CloseTipBtnOnClick()
  local lockName = self:GetName() .. ".EvilCloseAnim"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._level2OpenTip:SetActive(false)
    YIELD(TT, 350)
    self:UnLock(lockName)
  end)
end

function UIN38HardLevel:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIN38HardLevel:_SetHardLevelInfo()
  for i = 1, 4 do
    self._levels[i]:SetData(false, i, self._levelCfgs[i], self._levelComponentInfo, self._atlas)
  end
end

function UIN38HardLevel:_SetBlackLevelInfo()
  for i = 1, 3 do
    self._blevels[i]:SetData(true, i, self._blevelCfgs[i], self._blevelComponentInfo, self._atlas, self._blevelDatas[i])
  end
end

function UIN38HardLevel:_SwitchBG()
  self:StartTask(function(TT)
    self:Lock(self:GetName())
    self._bg1loader.gameObject:SetActive(true)
    self._bg1PatternLoader.gameObject:SetActive(true)
    self._bg2loader.gameObject:SetActive(true)
    self._bg2PatternLoader.gameObject:SetActive(true)
    if self._isBlack then
      self._rootAni:Play("uieff_N38_HardLevel_switch_black")
      YIELD(TT, 1833)
    else
      self._rootAni:Play("uieff_N38_HardLevel_switch_hard")
      YIELD(TT, 1233)
    end
    self:_SwitchLevels()
    self:UnLock(self:GetName())
  end)
end

function UIN38HardLevel:GetSpineAndBgm()
  return nil, nil
end

function UIN38HardLevel:IntroBtnOnClick(go)
  self:ShowDialog("UIIntroLoader", "UIN38IntroHard")
end

function UIN38HardLevel:OnTeamReset()
  self:StartTask(self.OnTeamResetCoro, self)
end

function UIN38HardLevel:OnTeamResetCoro(TT)
  self:Lock("UIN38HardLevel_OnTeamResetCoro")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self:LoadData(TT, res)
  for i = 1, #self._blevelDatas do
    self._blevelDatas[i]:RefreshParentLevel(self._blevelComponent, self._blevelComponentInfo)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampDiffTeamResetInternal)
  self:UnLock("UIN38HardLevel_OnTeamResetCoro")
end

function UIN38HardLevel:LoadData(TT, res)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_N9, ECampaignCN9ComponentID.ECAMPAIGN_N9_LINE_MISSION, ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION, ECampaignCN9ComponentID.ECAMPAIGN_N9_HEIXIA)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  if res and res:GetSucc() then
    local camp = self._campaign:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION)
    local campInfo = camp:GetComponentInfo()
    local openTime = campInfo.m_unlock_time
    local closeTime = campInfo.m_close_time
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
    if not campInfo.m_b_unlock then
      res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_UNLOCK
      local cfgv = Cfg.cfg_campaign_mission[campInfo.m_need_mission_id]
      if cfgv then
        local lvName = StringTable.Get(cfgv.Name)
        local msg = StringTable.Get("str_activity_common_will_open_after_clearance", lvName)
        ToastManager.ShowToast(msg)
      end
      return
    end
    self._line_component = self._campaign:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_LINE_MISSION)
    self._line_info = self._line_component:GetComponentInfo()
    self._levelComponent = self._campaign:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION)
    self._levelComponentInfo = self._levelComponent:GetComponentInfo()
    self._blevelComponent = self._campaign:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_HEIXIA)
    self._blevelComponentInfo = self._blevelComponent:GetComponentInfo()
  end
end
