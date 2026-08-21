_class("UIN28HardLevel", UIController)
UIN28HardLevel = UIN28HardLevel

function UIN28HardLevel:LoadDataOnEnter(TT, res)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._activityConst = UIActivityN28Const:New()
  self._activityConst:LoadData(TT, res)
  self._line_component, self._line_info = self._activityConst:GetNormalLineMissionComponent()
  self._levelCpt, self._levelCptInfo = self._activityConst:GetHardLineMissionComponent()
  self._levelCpt2, self._levelCptInfo2 = self._activityConst:GetTryPetComponent()
  self._campaign = self._activityConst:GetCampaign()
  local openTime = self._line_info.m_unlock_time
  local closeTime = self._line_info.m_close_time
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
  if not self._line_info.m_b_unlock then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_UNLOCK
    local cfgv = Cfg.cfg_campaign_mission[self._line_info.m_need_mission_id]
    if cfgv then
      local lvName = StringTable.Get(cfgv.Name)
      local msg = StringTable.Get("str_activity_common_will_open_after_clearance", lvName)
      ToastManager.ShowToast(msg)
    end
    return
  end
end

function UIN28HardLevel:OnShow(uiParams)
  self.isChangeLevel = false
  local fromBattle = false
  local isWin = false
  local comID
  if uiParams[1] and uiParams[1] ~= -1 then
    fromBattle = uiParams[1][1]
    isWin = uiParams[1][2]
    comID = uiParams[1][3]
  end
  if comID then
    if comID == ECampaignN28ComponentID.ECAMPAIGN_N28_DIFFICULT_MISSION then
      if not self.isChangeLevel then
        self.isChangeLevel = true
        self._showLevel1 = true
      end
    elseif comID == ECampaignN28ComponentID.ECAMPAIGN_N28_FIRST_MEET and not self.isChangeLevel then
      self.isChangeLevel = true
      self._showLevel1 = false
    end
  end
  self._taskID = nil
  self:AttachEvent(GameEventType.ActivityComponentCloseEvent, self.OnComponentClose)
  self._rootAni = self:GetUIComponent("Animation", "rootAni")
  self:InitWidget()
  self:InitCommonTopButton()
  self:InitLevelCfg()
  local spine, bgm = self:GetSpineAndBgm()
  if bgm then
    AudioHelperController.PlayBGM(bgm, AudioConstValue.BGMCrossFadeTime)
  end
  self:RefreshCurrentIndex()
  self._atlas = self:GetAsset("UIN28Hard.spriteatlas", LoadType.SpriteAtlas)
  self._time = self:GetUIComponent("UILocalizationText", "RemainTime")
  self:RefreshTime()
  self:SetLevelBtns()
  self:_RefreshPoint()
  self._isShow = true
  self._bg2loader.gameObject:SetActive(not self._showLevel1)
  if self._showLevel1 then
    self._rootAni:Play("uieff_UIN28HardLevel_in_01")
  else
    self._rootAni:Play("uieff_UIN28HardLevel_in_02")
  end
  self:FadeInAnim()
  if uiParams[2] then
    self:ClickLevelBtn1()
  end
end

function UIN28HardLevel:InitLevelCfg()
  UIN28HardLevel.LevelCfg = {
    [1] = {
      normal = "n28_kng_spot01",
      click = "n28_kng_btn01",
      close = "n28_kng_mask01",
      titleColor = Color(0.37254901960784315, 0.24705882352941178, 0.15294117647058825),
      titleOutlineColor = Color(0.9254901960784314, 0.9058823529411765, 0.8549019607843137),
      passTxtColor = Color(0.35294117647058826, 0.25882352941176473, 0.01568627450980392),
      lock = "n28_kng_lock01",
      passBg = "n28_kng_complete"
    },
    [2] = {
      normal = "n28_kng_spot02",
      click = "n28_kng_btn01",
      close = "n28_kng_mask01",
      titleColor = Color(0.37254901960784315, 0.24705882352941178, 0.15294117647058825),
      titleOutlineColor = Color(0.9254901960784314, 0.9058823529411765, 0.8549019607843137),
      passTxtColor = Color(0.35294117647058826, 0.25882352941176473, 0.01568627450980392),
      lock = "n28_kng_lock01",
      passBg = "n28_kng_complete"
    },
    [3] = {
      normal = "n28_kng_spot03",
      click = "n28_kng_btn01",
      close = "n28_kng_mask01",
      titleColor = Color(0.37254901960784315, 0.24705882352941178, 0.15294117647058825),
      titleOutlineColor = Color(0.9254901960784314, 0.9058823529411765, 0.8549019607843137),
      passTxtColor = Color(0.35294117647058826, 0.25882352941176473, 0.01568627450980392),
      lock = "n28_kng_lock01",
      passBg = "n28_kng_complete"
    },
    [4] = {
      normal = "n28_kng_spot04",
      click = "n28_kng_btn01",
      close = "n28_kng_mask01",
      titleColor = Color(0.37254901960784315, 0.24705882352941178, 0.15294117647058825),
      titleOutlineColor = Color(0.9254901960784314, 0.9058823529411765, 0.8549019607843137),
      passTxtColor = Color(0.35294117647058826, 0.25882352941176473, 0.01568627450980392),
      lock = "n28_kng_lock01",
      passBg = "n28_kng_complete"
    },
    [5] = {
      normal = "n28_kng_spot05",
      click = "n28_kng_btn01",
      close = "n28_kng_mask01",
      titleColor = Color(0.37254901960784315, 0.24705882352941178, 0.15294117647058825),
      titleOutlineColor = Color(0.9254901960784314, 0.9058823529411765, 0.8549019607843137),
      passTxtColor = Color(0.35294117647058826, 0.25882352941176473, 0.01568627450980392),
      lock = "n28_kng_lock01",
      passBg = "n28_kng_complete"
    },
    [6] = {
      normal = "n28_kng_spot06",
      click = "n28_kng_btn01",
      close = "n28_kng_mask01",
      titleColor = Color(0.37254901960784315, 0.24705882352941178, 0.15294117647058825),
      titleOutlineColor = Color(0.9254901960784314, 0.9058823529411765, 0.8549019607843137),
      passTxtColor = Color(0.35294117647058826, 0.25882352941176473, 0.01568627450980392),
      lock = "n28_kng_lock01",
      passBg = "n28_kng_complete"
    },
    [7] = {
      normal = "n28_jng_spot01",
      click = "n28_jng_btn01",
      close = "n28_kng_mask01",
      titleColor = Color(1.0, 0.9882352941176471, 0.996078431372549),
      titleOutlineColor = nil,
      passTxtColor = Color(0.4392156862745098, 0.33725490196078434, 0.5019607843137255),
      lock = "n28_jng_lock01",
      passBg = "n28_jng_complete"
    },
    [8] = {
      normal = "n28_jng_spot02",
      click = "n28_jng_btn01",
      close = "n28_kng_mask01",
      titleColor = Color(1.0, 0.9882352941176471, 0.996078431372549),
      titleOutlineColor = nil,
      passTxtColor = Color(0.4392156862745098, 0.33725490196078434, 0.5019607843137255),
      lock = "n28_jng_lock01",
      passBg = "n28_jng_complete"
    },
    [9] = {
      normal = "n28_jng_spot03",
      click = "n28_jng_btn01",
      close = "n28_kng_mask01",
      titleColor = Color(1.0, 0.9882352941176471, 0.996078431372549),
      titleOutlineColor = nil,
      passTxtColor = Color(0.4392156862745098, 0.33725490196078434, 0.5019607843137255),
      lock = "n28_jng_lock01",
      passBg = "n28_jng_complete"
    },
    [10] = {
      normal = "n28_jng_spot04",
      click = "n28_jng_btn01",
      close = "n28_kng_mask01",
      titleColor = Color(1.0, 0.9882352941176471, 0.996078431372549),
      titleOutlineColor = nil,
      passTxtColor = Color(0.4392156862745098, 0.33725490196078434, 0.5019607843137255),
      lock = "n28_jng_lock01",
      passBg = "n28_jng_complete"
    },
    [11] = {
      normal = "n28_jng_spot05",
      click = "n28_jng_btn01",
      close = "n28_kng_mask01",
      titleColor = Color(1.0, 0.9882352941176471, 0.996078431372549),
      titleOutlineColor = nil,
      passTxtColor = Color(0.4392156862745098, 0.33725490196078434, 0.5019607843137255),
      lock = "n28_jng_lock01",
      passBg = "n28_jng_complete"
    },
    [12] = {
      normal = "n28_jng_spot06",
      click = "n28_jng_btn01",
      close = "n28_kng_mask01",
      titleColor = Color(1.0, 0.9882352941176471, 0.996078431372549),
      titleOutlineColor = nil,
      passTxtColor = Color(0.4392156862745098, 0.33725490196078434, 0.5019607843137255),
      lock = "n28_jng_lock01",
      passBg = "n28_jng_complete"
    },
    bghard = {
      Bg = "n25_kng_bg2",
      Bg2 = "n28_kng_bg01",
      Bg1 = "n28_kng_bg01"
    },
    bgevil = {
      Bg = "n25_kng_bg1",
      Bg2 = "n28_kng_bg02",
      Bg1 = "n28_kng_bg02"
    }
  }
  return self.LevelCfg
end

function UIN28HardLevel:InitCommonTopButton()
  self.topButtonWidget = self.topbuttons:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    CutsceneManager.ExcuteCutsceneIn_Shot()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN28MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
end

function UIN28HardLevel:RefreshTime()
  local endTime = self._levelCptInfo.m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local remainTime = endTime - curTime
  remainTime = math.max(remainTime, 0)
  local timeStr = UIN28Line:GetFormatTimerStr(remainTime, "544C4C")
  if self._timeString ~= timeStr then
    self._time:SetText(timeStr)
    self._timeString = timeStr
  end
  local state1, timeStr1 = self._activityConst:GetTryPetComponentStatus()
  if self.level2Btn then
    if timeStr1 == 0 and state1 ~= ActivityN28ComponentStatus.Close and state1 ~= ActivityN28ComponentStatus.ActivityEnd and self._taskID == nil then
      self._taskID = self:StartTask(function(TT)
        YIELD(TT, 50)
        self._activityConst:ForceUpdate(TT)
      end, self)
      state1, timeStr1 = self._activityConst:GetTryPetComponentStatus()
    end
    self.level2Btn:SetLockVisible(self._isLevel2Lock)
    self.level2Btn:SetTime(state1 == ActivityN28ComponentStatus.TimeLock, UIActivityN28Helper.GetRemainString(timeStr1))
  end
end

function UIN28HardLevel:OnUpdate()
  self:RefreshCurrentIndex()
  self:RefreshTime()
  self:PlayLevel2Anim()
end

function UIN28HardLevel:IsLevel2Open()
  local states, time = self._activityConst:GetTryPetComponentStatus()
  return states == ActivityN28ComponentStatus.Open
end

function UIN28HardLevel:FadeInAnim()
  if self._curIndex == 7 and self:IsLevel2Open() and UIActivityN28Helper.GetNewFlagStatus("N28Level2Open") then
    UIActivityN28Helper.SetNewFlagStatus("N28Level2Open", false)
    self:UnlockEvilAnimation()
    self._levels[1]:Anim_Open()
    return
  end
  local idx = self._curIndex > 6 and self._curIndex - 6 or self._curIndex
  if self._levels[idx] then
    self._levels[idx]:Anim_Open()
  end
  if self._levels[idx - 1] then
    self._levels[idx - 1]:Anim_Pass()
  end
end

function UIN28HardLevel:PlayLevel2Anim()
  if self._curIndex == 7 and self:IsLevel2Open() and UIActivityN28Helper.GetNewFlagStatus("N28Level2Open") then
    UIActivityN28Helper.SetNewFlagStatus("N28Level2Open", false)
    self:UnlockEvilAnimation()
    self._levels[1]:Anim_Open()
  end
end

function UIN28HardLevel:OnHide()
  self:DetachEvent(GameEventType.ActivityComponentCloseEvent, self.OnComponentClose)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN28ActivityMainRedStatusRefresh)
  UIN28HardLevel.LevelCfg = nil
  self._isShow = false
end

function UIN28HardLevel:OnComponentClose(componentCfgId)
  local blackHardComponent = self._levelCpt2
  if blackHardComponent and blackHardComponent:GetComponentCfgId() == componentCfgId then
    self:_Back()
    return
  end
  local levelComponent = self._levelCpt
  if levelComponent and levelComponent:GetComponentCfgId() == componentCfgId then
    self:_Back()
    return
  end
end

function UIN28HardLevel:_Back()
  local campaignMain = CampaignConst.GetSafeStateInfo(self._campaign._id, nil, UIStateType.UIActivityN28MainController, nil)
  local uiMain = CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIMain, nil)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:SwitchState_Safe(true, {campaignMain, uiMain})
end

function UIN28HardLevel:InitWidget()
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self._levels = {}
  for i = 1, 6 do
    self._levels[i] = UIN28HardLevelItem:New(self:GetUIComponent("UIView", "Level" .. i))
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
  self._atc = self:GetUIComponent("ATransitionComponent", "lv2OpenTip")
  self._atc.enabled = false
end

function UIN28HardLevel:_EnterLevel(idx)
  local state, time = self._activityConst:GetHardLineMissionComponentStatus()
  if state == ActivityN28ComponentStatus.Close then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    self:SwitchState(UIStateType.UIActivityN28MainController)
    return
  elseif status == ActivityN28ComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    self:SwitchState(UIStateType.UIMain)
  end
  local state1, time1 = self._activityConst:GetTryPetComponentStatus()
  if state1 == ActivityN28ComponentStatus.Close then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    self:SwitchState(UIStateType.UIActivityN28MainController)
    return
  elseif state1 == ActivityN28ComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
    self:SwitchState(UIStateType.UIMain)
  end
  if idx < 1 and 6 < idx then
    return
  end
  local levelIndex
  if self._showLevel1 then
    levelIndex = idx
  else
    levelIndex = idx + 6
  end
  local missionID = self._levelCfgs[levelIndex].CampaignMissionId
  if levelIndex > self._curIndex then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_clear_mission_to_unlock"))
    return
  end
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  self._shot:CleanRenderTexture()
  local missionCfg = Cfg.cfg_campaign_mission[missionID]
  local autoFightShow = self:_CheckSerialAutoFightShow(missionCfg.Type, missionID)
  if 6 < levelIndex then
    self:ShowDialog("UIActivityHardStage", missionID, self._levelCptInfo2.m_pass_mission_info[missionID], self._levelCpt2)
  else
    self:ShowDialog("UIActivityHardStage", missionID, self._levelCptInfo.m_pass_mission_info[missionID], self._levelCpt)
  end
end

function UIN28HardLevel:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIN28HardLevel:RefreshCurrentIndex()
  local cptID = self._levelCpt:GetComponentCfgId()
  local cpt2ID = self._levelCpt2:GetComponentCfgId()
  local allMissions = Cfg.cfg_component_line_mission({ComponentID = cptID})
  local hard2 = Cfg.cfg_component_line_mission({ComponentID = cpt2ID})
  for i = 1, #hard2 do
    table.insert(allMissions, hard2[i])
  end
  table.sort(allMissions, function(a, b)
    return a.SortId < b.SortId
  end)
  if #allMissions ~= 12 then
    Log.exception("N28高难关的数量必须是12")
  end
  self._passInfo = self._levelCptInfo.m_pass_mission_info
  for k, v in pairs(self._levelCptInfo2.m_pass_mission_info) do
    self._passInfo[k] = v
  end
  self._levelCfgs = allMissions
  local cur = 1
  for i, cfg in ipairs(allMissions) do
    if cfg.CampaignMissionId == self._levelCptInfo.m_cur_mission then
      cur = i + 1
    end
    if 6 < cur and cfg.CampaignMissionId == self._levelCptInfo2.m_cur_mission then
      cur = i + 1
    end
  end
  self._curIndex = cur
  local stat, time = self._activityConst:GetTryPetComponentStatus()
  self._isLevel2Lock = 6 >= self._curIndex or stat ~= ActivityN28ComponentStatus.Open
  if not self.isChangeLevel then
    self.isChangeLevel = true
    self._showLevel1 = self._isLevel2Lock
  end
end

function UIN28HardLevel:Press1OnClick()
  self:_EnterLevel(1)
end

function UIN28HardLevel:Press2OnClick()
  self:_EnterLevel(2)
end

function UIN28HardLevel:Press3OnClick()
  self:_EnterLevel(3)
end

function UIN28HardLevel:Press4OnClick()
  self:_EnterLevel(4)
end

function UIN28HardLevel:Press5OnClick()
  self:_EnterLevel(5)
end

function UIN28HardLevel:Press6OnClick()
  self:_EnterLevel(6)
end

function UIN28HardLevel:SetLevelBtns()
  self.level1Btn = self:_SpawnObject("level1", "UIN28HardLevelBtn")
  self.level2Btn = self:_SpawnObject("level2", "UIN28HardLevelBtn")
  self.level1Btn:SetData(self._atlas, 1, function()
    self:ClickLevelBtn1()
  end)
  self.level2Btn:SetData(self._atlas, 2, function()
    self:ClickLevelBtn2()
  end)
  local state, timeStr = self._activityConst:GetTryPetComponentStatus()
  self.level2Btn:SetTime(state == ActivityN28ComponentStatus.TimeLock, UIActivityN28Helper.GetRemainString(timeStr))
  self:RefreshLevelBtnSelect(true)
end

function UIN28HardLevel:RefreshLevelBtnSelect(localPosition)
  if localPosition then
    if self._showLevel1 then
      self.level1Btn:SetSelect(true, self._level1pos2.localPosition)
      self.level2Btn:SetSelect(false, self._level2pos1.localPosition)
    else
      self.level1Btn:SetSelect(false, self._level1pos2.localPosition)
      self.level2Btn:SetSelect(true, self._level2pos1.localPosition)
    end
  elseif self._showLevel1 then
    self.level1Btn:SetSelect(true)
    self.level2Btn:SetSelect(false)
  else
    self.level1Btn:SetSelect(false)
    self.level2Btn:SetSelect(true)
  end
end

function UIN28HardLevel:ClickLevelBtn1()
  if self._showLevel1 then
    return
  end
  self._showLevel1 = true
  self:DoLevelBtnSwitch(true)
  self:RefreshLevelBtnSelect(false)
end

function UIN28HardLevel:ClickLevelBtn2()
  if self._isLevel2Lock then
    local status, time = self._activityConst:GetTryPetComponentStatus()
    if status == ActivityN28ComponentStatus.Close or status == ActivityN28ComponentStatus.ActivityEnd then
      ToastManager.ShowToast(StringTable.Get("str_n28_activity_end"))
      return
    elseif status == ActivityN28ComponentStatus.TimeLock then
      ToastManager.ShowToast(StringTable.Get("str_n28_activity_hard_level_lock_time_tips", UIActivityN28Helper.GetTimeString(time)))
      return
    elseif status == ActivityN28ComponentStatus.MissionLock then
      local cfgv = Cfg.cfg_campaign_mission[self._levelCfgs[6].CampaignMissionId]
      local lvName = StringTable.Get(cfgv.Name)
      ToastManager.ShowToast(StringTable.Get("str_activity_common_will_open_after_clearance", lvName))
      return
    end
  end
  if not self._showLevel1 then
    return
  end
  self._showLevel1 = false
  self:DoLevelBtnSwitch(false)
  self:RefreshLevelBtnSelect(false)
end

function UIN28HardLevel:UnlockEvilAnimation()
  local lockName = self:GetName() .. ".EvilOpenAnim"
  self:StartTask(function(TT)
    self:Lock(lockName)
    YIELD(TT, 500)
    self._level2OpenTip:SetActive(true)
    self._atc.enabled = true
    self._atc:PlayEnterAnimation(true)
    YIELD(TT, 500)
    self._bg2loader.gameObject:SetActive(true)
    YIELD(TT, 500)
    self._bg2loader.gameObject:SetActive(not self._showLevel1)
    self:UnLock(lockName)
  end)
end

function UIN28HardLevel:CloseTipBtnOnClick()
  local lockName = self:GetName() .. ".EvilCloseAnim"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._atc:PlayLeaveAnimation(true)
    YIELD(TT, 1500)
    self._level2OpenTip:SetActive(false)
    self:UnLock(lockName)
  end)
end

function UIN28HardLevel:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIN28HardLevel:Level2OnClick()
  if self._isLevel2Lock then
    local cfgv = Cfg.cfg_campaign_mission[self._levelCfgs[6].CampaignMissionId]
    local lvName = StringTable.Get(cfgv.Name)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_will_open_after_clearance", lvName))
    return
  end
  if not self._showLevel1 then
    return
  end
  self._showLevel1 = false
  self:DoLevelBtnSwitch(false)
  if self._isShow then
    self:_RefreshPoint()
  end
end

function UIN28HardLevel:_RefreshPoint()
  for i = 1, 6 do
    local idx = i
    if not self._showLevel1 then
      idx = idx + 6
    end
    self._levels[i]:SetData(idx, self._levelCfgs[idx], self._passInfo[self._levelCfgs[idx].CampaignMissionId], self._curIndex, self._atlas)
  end
  self.level2Btn:SetLockVisible(self._isLevel2Lock)
end

function UIN28HardLevel:DoLevelBtnSwitch(blevel1)
  self:StartTask(function(TT)
    self:Lock(self:GetName())
    self._bg2loader.gameObject:SetActive(true)
    if self._showLevel1 then
      self._rootAni:Play("uieff_UIN28HardLevel_in_normal")
      YIELD(TT, 300)
      self:_RefreshPoint()
      YIELD(TT, 533)
    else
      self._rootAni:Play("uieff_UIN28HardLevel_in_hard")
      YIELD(TT, 200)
      self:_RefreshPoint()
      YIELD(TT, 500)
    end
    self._bg2loader.gameObject:SetActive(not blevel1)
    self:UnLock(self:GetName())
  end)
end

function UIN28HardLevel:GetSpineAndBgm()
  local cfg = Cfg.cfg_n25_const[1]
  if self._line_info and cfg then
    local missionModule = GameGlobal.GetModule(MissionModule)
    local passInfo = self._line_info.m_pass_mission_info
    for _, info in pairs(passInfo) do
      local storyId = missionModule:GetStoryByStageIdStoryType(info.mission_id, StoryTriggerType.Node)
      if storyId == cfg.StoryID then
        return cfg.Spine2, cfg.Bgm2
      end
    end
    return cfg.Spine1, cfg.Bgm1
  end
  return nil, nil
end
