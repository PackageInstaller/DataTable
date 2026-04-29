_class("UIActivtiyN25HardLevelController", UIController)
UIActivtiyN25HardLevelController = UIActivtiyN25HardLevelController

function UIActivtiyN25HardLevelController:LoadDataOnEnter(TT, res)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N25, ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION, ECampaignN25ComponentID.ECAMPAIGN_N25_DIFFICULT_MISSION)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  if res and res:GetSucc() then
    local camp = self._campaign:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_DIFFICULT_MISSION)
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
    self._line_component = self._campaign:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION)
    self._line_info = self._line_component:GetComponentInfo()
  end
end

function UIActivtiyN25HardLevelController:OnShow(uiParams)
  local enterType = uiParams[1]
  self:InitWidget()
  self.topButtonWidget = self.topbuttons:SpawnObject("UINewCommonTopButton")
  self.topButtonWidget:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN25MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  local spine, bgm = self:GetSpineAndBgm()
  if bgm then
    AudioHelperController.PlayBGM(bgm, AudioConstValue.BGMCrossFadeTime)
  end
  UIActivtiyN25HardLevelController.LevelCfg = {
    [1] = {
      normal = "n25_kng_stage1_1",
      click = "n25_kng_stage1_1",
      close = "n25_kng_stage1_1close"
    },
    [2] = {
      normal = "n25_kng_stage1_2",
      click = "n25_kng_stage1_2",
      close = "n25_kng_stage1_2close"
    },
    [3] = {
      normal = "n25_kng_stage1_3",
      click = "n25_kng_stage1_3",
      close = "n25_kng_stage1_3close"
    },
    [4] = {
      normal = "n25_kng_stage1_4",
      click = "n25_kng_stage1_4",
      close = "n25_kng_stage1_4close"
    },
    [5] = {
      normal = "n25_kng_stage1_5",
      click = "n25_kng_stage1_5",
      close = "n25_kng_stage1_5close"
    },
    [6] = {
      normal = "n25_kng_stage1_6",
      click = "n25_kng_stage1_6",
      close = "n25_kng_stage1_6close"
    },
    [7] = {
      normal = "n25_kng_stage2_1",
      click = "n25_kng_stage2_1",
      close = "n25_kng_stage2_1close"
    },
    [8] = {
      normal = "n25_kng_stage2_2",
      click = "n25_kng_stage2_2",
      close = "n25_kng_stage2_2close"
    },
    [9] = {
      normal = "n25_kng_stage2_3",
      click = "n25_kng_stage2_3",
      close = "n25_kng_stage2_3close"
    },
    [10] = {
      normal = "n25_kng_stage2_4",
      click = "n25_kng_stage2_4",
      close = "n25_kng_stage2_4close"
    },
    [11] = {
      normal = "n25_kng_stage2_5",
      click = "n25_kng_stage2_5",
      close = "n25_kng_stage2_5close"
    },
    [12] = {
      normal = "n25_kng_stage2_6",
      click = "n25_kng_stage2_6",
      close = "n25_kng_stage2_6close"
    },
    bghard = {
      Bg = "n25_kng_bg2",
      Bg2 = "n25_kng_bg1",
      Bg1 = "n25_kng_bg1"
    },
    bgevil = {
      Bg = "n25_kng_bg1",
      Bg2 = "n25_kng_bg2",
      Bg1 = "n25_kng_bg2"
    }
  }
  self._atlas = self:GetAsset("UIN25.spriteatlas", LoadType.SpriteAtlas)
  self._levelCpt = self._campaign:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_DIFFICULT_MISSION)
  self._levelCptInfo = self._levelCpt:GetComponentInfo()
  local cptID = self._levelCpt:GetComponentCfgId()
  local allMissions = Cfg.cfg_component_line_mission({ComponentID = cptID})
  table.sort(allMissions, function(a, b)
    return a.SortId < b.SortId
  end)
  if #allMissions ~= 12 then
    Log.exception("N25高难关的数量必须是12")
  end
  self._passInfo = self._levelCptInfo.m_pass_mission_info
  self._levelCfgs = allMissions
  self._level1AllPass = false
  local cur = 1
  for i, cfg in ipairs(allMissions) do
    if self._passInfo[cfg.CampaignMissionId] then
      cur = i
      if i == 6 then
        self._level1AllPass = true
      end
    else
      if self:MissionIsOpen(cfg) then
        cur = i
      end
      break
    end
  end
  self._curIndex = cur
  self._isLevel2Lock = 6 >= self._curIndex
  if enterType and enterType == 2 then
    if self._isLevel2Lock then
      self._showLevel1 = true
    else
      self._showLevel1 = false
    end
  else
    self._showLevel1 = self._isLevel2Lock
  end
  self._secondOpenTime = nil
  local isOpen, openTime = self:MissionIsOpen(allMissions[7])
  if not isOpen then
    self._secondOpenTime = openTime
  end
  self:SetLevelBtns()
  self._time = self:GetUIComponent("UILocalizationText", "RemainTime")
  local timecolor = {
    day = "str_n25_reset_time_day",
    hour = "str_n25_reset_time_hour",
    min = "str_n25_reset_time_only_min",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107"
  }
  local closeTime = self._levelCptInfo.m_close_time
  
  local function countDown()
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    local time = math.ceil(closeTime - now)
    local seconds = UICommonHelper.CalcLeftSeconds(closeTime)
    local timeStr = UIActivityN25Const.GetTimeString(seconds)
    local timeStr = StringTable.Get("str_n25_activity_remain_time", timeStr)
    if self._timeString ~= timeStr then
      self._time:SetText(timeStr)
      self._timeString = timeStr
    end
    if time < 0 and self._countdownTimer then
      GameGlobal.Timer():CancelEvent(self._countdownTimer)
      self._countdownTimer = nil
    end
  end
  
  countDown()
  self._countdownTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, countDown)
  self._firstShow = true
  self:FadeInAnim()
  self._isShow = true
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  LocalDB.SetInt("UIActivityN25HardLevel_fk" .. pstid, 1)
end

function UIActivtiyN25HardLevelController:MissionIsOpen(cfg)
  local openTimeStr = cfg.OpenTime
  if openTimeStr then
    local loginModule = GameGlobal.GetModule(LoginModule)
    local now = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
    local openTime = loginModule:GetTimeStampByTimeStr(openTimeStr, Enum_DateTimeZoneType.E_ZoneType_GMT)
    if now < openTime then
      return false, openTime
    else
      return true
    end
  else
    return true
  end
end

function UIActivtiyN25HardLevelController:FadeInAnim()
  self:_RefreshPoint()
  self._fadeInTimer = GameGlobal.Timer():AddEvent(500, function()
    self._fadeInTimer = nil
    if not self._isLevel2Lock and self._curIndex == 7 then
      local roleModule = GameGlobal.GetModule(RoleModule)
      local pstid = roleModule:GetPstId()
      local key = "UIActivityN25HardLevelOpenTips_fk" .. pstid
      if LocalDB.GetInt(key, 0) == 0 then
        self._level2OpenTip:SetActive(true)
        LocalDB.SetInt(key, 1)
      else
      end
    else
    end
  end)
end

function UIActivtiyN25HardLevelController:OnHide()
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  if self._fadeInTimer then
    GameGlobal.Timer():CancelEvent(self._fadeInTimer)
    self._fadeInTimer = nil
  end
  UIActivtiyN25HardLevelController.LevelCfg = nil
  self._isShow = false
end

function UIActivtiyN25HardLevelController:InitWidget()
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self._levels = {}
  for i = 1, 6 do
    self._levels[i] = UIActivityN25HardLevelItem:New(self:GetUIComponent("UIView", "Level" .. i))
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
  self._txtDeschard = self:GetGameObject("txtDeschard")
  self._level2OpenTip:SetActive(false)
  self._switchAnim = self:GetUIComponent("Animation", "anim")
  self._tipAnim = self:GetUIComponent("Animation", "lv2OpenTip")
  self._bg2loader = self:GetUIComponent("RawImageLoader", "Bg2")
  self._bg1loader = self:GetUIComponent("RawImageLoader", "Bg1")
end

function UIActivtiyN25HardLevelController:_EnterLevel(idx)
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
  self:ShowDialog("UIActivityLevelStageNew", missionID, self._levelCptInfo.m_pass_mission_info[missionID], self._levelCpt, autoFightShow, nil)
end

function UIActivtiyN25HardLevelController:_CheckSerialAutoFightShow(stageType, stageId)
  local autoFightShow = false
  if stageType == DiscoveryStageType.Plot then
    autoFightShow = false
  else
    local missionCfg = Cfg.cfg_campaign_mission[stageId]
    if missionCfg then
      local enableParam = missionCfg.EnableSerialAutoFight
      if enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_DISABLE then
        autoFightShow = false
      elseif enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_ENABLE or enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_NEED_UNLOCK then
        autoFightShow = true
      end
    end
  end
  return autoFightShow
end

function UIActivtiyN25HardLevelController:Press1OnClick()
  self:_EnterLevel(1)
end

function UIActivtiyN25HardLevelController:Press2OnClick()
  self:_EnterLevel(2)
end

function UIActivtiyN25HardLevelController:Press3OnClick()
  self:_EnterLevel(3)
end

function UIActivtiyN25HardLevelController:Press4OnClick()
  self:_EnterLevel(4)
end

function UIActivtiyN25HardLevelController:Press5OnClick()
  self:_EnterLevel(5)
end

function UIActivtiyN25HardLevelController:Press6OnClick()
  self:_EnterLevel(6)
end

function UIActivtiyN25HardLevelController:SetLevelBtns()
  self.level1Btn = self:_SpawnObject("level1", "UIN25HardLevelBtn")
  self.level2Btn = self:_SpawnObject("level2", "UIN25HardLevelBtn")
  self.level1Btn:SetData("n25_kng_stage1_zi", function()
    self:ClickLevelBtn1()
  end)
  self.level2Btn:SetData("n25_kng_stage2_zi", function()
    self:ClickLevelBtn2()
  end)
  self:RefreshLevelBtnSelect()
end

function UIActivtiyN25HardLevelController:RefreshLevelBtnSelect()
  if self._showLevel1 then
    self.level1Btn:SetSelect(true, self._level1pos2.localPosition)
    self.level2Btn:SetSelect(false, self._level2pos1.localPosition)
  else
    self.level2Btn:SetSelect(true, self._level2pos2.localPosition)
    self.level1Btn:SetSelect(false, self._level1pos1.localPosition)
  end
end

function UIActivtiyN25HardLevelController:ClickLevelBtn1()
  if self._showLevel1 then
    return
  end
  self._showLevel1 = true
  self:RefreshLevelBtnSelect()
  self:DoLevelBtnSwitch(true)
  if self._isShow then
    self:_RefreshPoint()
  end
end

function UIActivtiyN25HardLevelController:ClickLevelBtn2()
  if self._secondOpenTime then
    Log.debug("###[UIActivtiyN25HardLevelController] time lock !")
    return
  end
  if self._isLevel2Lock and not self._level1AllPass then
    local cfgv = Cfg.cfg_campaign_mission[self._levelCfgs[6].CampaignMissionId]
    local lvName = StringTable.Get(cfgv.Name)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_will_open_after_clearance", lvName))
    return
  end
  if not self._showLevel1 then
    return
  end
  self._showLevel1 = false
  self:RefreshLevelBtnSelect()
  self:DoLevelBtnSwitch(false)
  if self._isShow then
    self:_RefreshPoint()
  end
end

function UIActivtiyN25HardLevelController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIActivtiyN25HardLevelController:Level2OnClick()
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

function UIActivtiyN25HardLevelController:CloseTipBtnOnClick()
  self:StartTask(function(TT)
    self:Lock(self:GetName())
    self._level2OpenTip:SetActive(false)
    YIELD(TT, 350)
    self:UnLock(self:GetName())
  end)
end

function UIActivtiyN25HardLevelController:_RefreshPoint()
  for i = 1, 6 do
    local idx = i
    if not self._showLevel1 then
      idx = idx + 6
    end
    self._levels[i]:SetData(idx, self._levelCfgs[idx], self._passInfo[self._levelCfgs[idx].CampaignMissionId], self._curIndex, self._atlas)
  end
  self.level2Btn:SetLockVisible(self._isLevel2Lock, self._secondOpenTime)
  self:DoLevelBtnSwitch(self._showLevel1)
end

function UIActivtiyN25HardLevelController:DoLevelBtnSwitch(blevel1)
  self:StartTask(function(TT)
    local bg = (blevel1 or self._isLevel2Lock) and UIActivtiyN25HardLevelController.LevelCfg.bghard or UIActivtiyN25HardLevelController.LevelCfg.bgevil
    self._bg2loader:LoadImage(bg.Bg2)
    if self._showLevel1 then
      self._switchAnim:Play("uieff_UIN25HardLevelController_in2")
      self._firstShow = false
    else
      self._switchAnim:Play("uieff_UIN25HardLevelController_in1")
    end
    self:Lock(self:GetName())
    self._bg1loader:LoadImage(bg.Bg1)
    YIELD(TT, 500)
    self:UnLock(self:GetName())
  end)
end

function UIActivtiyN25HardLevelController:GetSpineAndBgm()
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
