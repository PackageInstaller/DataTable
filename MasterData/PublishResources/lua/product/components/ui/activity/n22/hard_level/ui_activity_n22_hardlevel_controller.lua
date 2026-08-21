_class("UIActivtiyN22HardLevelController", UIController)
UIActivtiyN22HardLevelController = UIActivtiyN22HardLevelController

function UIActivtiyN22HardLevelController:LoadDataOnEnter(TT, res)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N22, ECampaignN22ComponentID.ECAMPAIGN_N22_DIFFICULT_MISSION)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  if res and res:GetSucc() then
    local camp = self._campaign:GetComponent(ECampaignN22ComponentID.ECAMPAIGN_N22_DIFFICULT_MISSION)
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
  end
end

function UIActivtiyN22HardLevelController:OnShow(uiParams)
  self:InitWidget()
  self.topButtonWidget = self.topbuttons:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN22MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  local fromBattle = false
  local isWin = false
  if uiParams[1] then
    fromBattle = uiParams[1][1]
    isWin = uiParams[1][2]
  end
  UIActivtiyN22HardLevelController.LevelCfg = {
    [1] = {
      title = "n22_kng_spot1",
      normal = "n22_kng_stage1_1",
      click = "n22_kng_stage01_click",
      close = "n22_kng_stage01_close"
    },
    [2] = {
      title = "n22_kng_spot1",
      normal = "n22_kng_stage1_3",
      click = "n22_kng_stage02_click",
      close = "n22_kng_stage02_close"
    },
    [3] = {
      title = "n22_kng_spot1",
      normal = "n22_kng_stage1_5",
      click = "n22_kng_stage03_click",
      close = "n22_kng_stage03_close"
    },
    [4] = {
      title = "n22_kng_spot1",
      normal = "n22_kng_stage1_2",
      click = "n22_kng_stage04_click",
      close = "n22_kng_stage04_close"
    },
    [5] = {
      title = "n22_kng_spot1",
      normal = "n22_kng_stage1_4",
      click = "n22_kng_stage05_click",
      close = "n22_kng_stage05_close"
    },
    [6] = {
      title = "n22_kng_spot1",
      normal = "n22_kng_stage1_6",
      click = "n22_kng_stage06_click",
      close = "n22_kng_stage06_close"
    },
    [7] = {
      title = "n22_kng_spot2",
      normal = "n22_kng_stage2_1",
      click = "n22_kng2_stage01_click",
      close = "n22_kng2_stage01_close"
    },
    [8] = {
      title = "n22_kng_spot2",
      normal = "n22_kng_stage2_3",
      click = "n22_kng2_stage02_click",
      close = "n22_kng2_stage02_close"
    },
    [9] = {
      title = "n22_kng_spot2",
      normal = "n22_kng_stage2_5",
      click = "n22_kng2_stage03_click",
      close = "n22_kng2_stage03_close"
    },
    [10] = {
      title = "n22_kng_spot2",
      normal = "n22_kng_stage2_2",
      click = "n22_kng2_stage04_click",
      close = "n22_kng2_stage04_close"
    },
    [11] = {
      title = "n22_kng_spot2",
      normal = "n22_kng_stage2_4",
      click = "n22_kng2_stage05_click",
      close = "n22_kng2_stage05_close"
    },
    [12] = {
      title = "n22_kng_spot2",
      normal = "n22_kng_stage2_6",
      click = "n22_kng2_stage06_click",
      close = "n22_kng2_stage06_close"
    },
    bghard = {
      Bg = "n22_kng_bg2",
      Bg2 = "n22_kng_bg1",
      Bg1 = "n22_kng_bg1",
      TimeBg = "n22_xxg_timedi"
    },
    bgevil = {
      Bg = "n22_kng_bg1",
      Bg2 = "n22_kng_bg2",
      Bg1 = "n22_kng_bg2",
      TimeBg = "n22_kng2_timedi"
    }
  }
  self._atlas = self:GetAsset("UIN22.spriteatlas", LoadType.SpriteAtlas)
  self._levelCpt = self._campaign:GetComponent(ECampaignN22ComponentID.ECAMPAIGN_N22_DIFFICULT_MISSION)
  self._levelCptInfo = self._levelCpt:GetComponentInfo()
  local cptID = self._levelCpt:GetComponentCfgId()
  local allMissions = Cfg.cfg_component_line_mission({ComponentID = cptID})
  table.sort(allMissions, function(a, b)
    return a.SortId < b.SortId
  end)
  if #allMissions ~= 12 then
    Log.exception("N22高难关的数量必须是12")
  end
  self._passInfo = self._levelCptInfo.m_pass_mission_info
  self._levelCfgs = allMissions
  local cur = 1
  for i, cfg in ipairs(allMissions) do
    if cfg.CampaignMissionId == self._levelCptInfo.m_cur_mission then
      cur = i + 1
    end
  end
  self._curIndex = cur
  self._isLevel2Lock = 6 >= self._curIndex
  self._showLevel1 = self._isLevel2Lock
  self._time = self:GetUIComponent("UILocalizationText", "RemainTime")
  local timecolor = {
    day = "str_n22_reset_time_day",
    hour = "str_n22_reset_time_hour",
    min = "str_n22_reset_time_min",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107"
  }
  local closeTime = self._levelCptInfo.m_close_time
  
  local function countDown()
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    local time = math.ceil(closeTime - now)
    local timeStr = UIActivityHelper.GetFormatTimerStr(time, timecolor)
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
  if fromBattle and isWin then
    self:FadeInAnim()
  else
    self:_RefreshPoint()
  end
  self._isShow = true
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  LocalDB.SetInt("UIActivityN22HardLevel" .. pstid, 1)
end

function UIActivtiyN22HardLevelController:FadeInAnim()
  self:_RefreshPoint()
  self._fadeInTimer = GameGlobal.Timer():AddEvent(500, function()
    self._fadeInTimer = nil
    if not self._isLevel2Lock and self._curIndex == 7 then
      self._level2OpenTip:SetActive(true)
      self._switchAnim:Play("uieff_UIN22HardLevelController_unlock")
    else
      local idx = self._curIndex
      if 6 < idx then
        idx = idx - 6
      end
      self._levels[idx - 1]:Anim_Pass()
      if idx <= 6 then
        self._levels[idx]:Anim_Open()
      end
    end
  end)
end

function UIActivtiyN22HardLevelController:OnHide()
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  if self._fadeInTimer then
    GameGlobal.Timer():CancelEvent(self._fadeInTimer)
    self._fadeInTimer = nil
  end
  UIActivtiyN22HardLevelController.LevelCfg = nil
  self._isShow = false
end

function UIActivtiyN22HardLevelController:InitWidget()
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self._levels = {}
  for i = 1, 6 do
    self._levels[i] = UIActivityN22HardLevelItem:New(self:GetUIComponent("UIView", "Level" .. i))
  end
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "BlurHelper")
  self._shotRect = self:GetUIComponent("RectTransform", "BlurHelper")
  self._width = self._shotRect.rect.width
  self._height = self._shotRect.rect.height
  self._shot.width = self._width
  self._shot.height = self._height
  self._shot.blurTimes = 0
  self._scale = 1.2
  self._level1Btn = self:GetUIComponent("Button", "level1")
  self._level2Btn = self:GetUIComponent("Button", "level2")
  self._level1BtnRect = self:GetUIComponent("RectTransform", "level1")
  self._level2BtnRect = self:GetUIComponent("RectTransform", "level2")
  self._level1BtnImg = self:GetUIComponent("Image", "level1")
  self._level2BtnImg = self:GetUIComponent("Image", "level2")
  self._timeBgImg = self:GetUIComponent("Image", "timeBg")
  self._level2OpenTip = self:GetGameObject("lv2OpenTip")
  self._level2Locker = self:GetGameObject("locker")
  self._txtDeschard = self:GetGameObject("txtDeschard")
  self._level2OpenTip:SetActive(false)
  self._switchAnim = self:GetUIComponent("Animation", "anim")
  self._tipAnim = self:GetUIComponent("Animation", "lv2OpenTip")
  self._bg2loader = self:GetUIComponent("RawImageLoader", "Bg2")
  self._bg1loader = self:GetUIComponent("RawImageLoader", "Bg1")
  self._masklv1 = self:GetGameObject("masklv1")
  self._masklv2 = self:GetGameObject("masklv2")
end

function UIActivtiyN22HardLevelController:_EnterLevel(idx)
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

function UIActivtiyN22HardLevelController:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIActivtiyN22HardLevelController:_RefreshPoint()
  for i = 1, 6 do
    local idx = i
    if not self._showLevel1 then
      idx = idx + 6
    end
    self._levels[i]:SetData(idx, self._levelCfgs[idx], self._passInfo[self._levelCfgs[idx].CampaignMissionId], self._curIndex, self._atlas)
  end
  local bgs = {}
  if self._showLevel1 then
    bgs = UIActivtiyN22HardLevelController.LevelCfg.bghard
    self._level1BtnRect:SetAsLastSibling()
  else
    bgs = UIActivtiyN22HardLevelController.LevelCfg.bgevil
    self._level2BtnRect:SetAsLastSibling()
  end
  if self._firstShow then
  end
  self:DoLevelBtnSwitch(self._showLevel1)
  self._bg2loader:LoadImage(bgs.Bg2)
  self._bg1loader:LoadImage(bgs.Bg1)
  self._txtDeschard:SetActive(self._showLevel1)
end

function UIActivtiyN22HardLevelController:Press1OnClick()
  self:_EnterLevel(1)
end

function UIActivtiyN22HardLevelController:Press2OnClick()
  self:_EnterLevel(2)
end

function UIActivtiyN22HardLevelController:Press3OnClick()
  self:_EnterLevel(3)
end

function UIActivtiyN22HardLevelController:Press4OnClick()
  self:_EnterLevel(4)
end

function UIActivtiyN22HardLevelController:Press5OnClick()
  self:_EnterLevel(5)
end

function UIActivtiyN22HardLevelController:Press6OnClick()
  self:_EnterLevel(6)
end

function UIActivtiyN22HardLevelController:Level1OnClick()
  if self._showLevel1 then
    return
  end
  self._showLevel1 = true
  self:DoLevelBtnSwitch(true)
  if self._isShow then
    self:_RefreshPoint()
  end
end

function UIActivtiyN22HardLevelController:Level2OnClick()
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

function UIActivtiyN22HardLevelController:DoLevelBtnSwitch(blevel1)
  self:StartTask(function(TT)
    local bg = (blevel1 or self._isLevel2Lock) and UIActivtiyN22HardLevelController.LevelCfg.bghard or UIActivtiyN22HardLevelController.LevelCfg.bgevil
    self._bg2loader:LoadImage(bg.Bg2)
    if self._showLevel1 then
      self._switchAnim:Play("uieff_UIN22HardLevelController_in")
    else
      self._switchAnim:Play("uieff_UIN22HardLevelController_in2")
    end
    self._masklv1:SetActive(not self._showLevel1)
    self._masklv2:SetActive(self._showLevel1)
    self:Lock(self:GetName())
    self._bg1loader:LoadImage(bg.Bg1)
    YIELD(TT, 500)
    self:UnLock(self:GetName())
  end)
end

function UIActivtiyN22HardLevelController:CloseTipBtnOnClick()
  self:StartTask(function(TT)
    self:Lock(self:GetName())
    self._level2OpenTip:SetActive(false)
    YIELD(TT, 350)
    self:UnLock(self:GetName())
  end)
end

function UIActivtiyN22HardLevelController:_RefreshPoint()
  for i = 1, 6 do
    local idx = i
    if not self._showLevel1 then
      idx = idx + 6
    end
    self._levels[i]:SetData(idx, self._levelCfgs[idx], self._passInfo[self._levelCfgs[idx].CampaignMissionId], self._curIndex, self._atlas)
  end
  self._level1Btn.interactable = not self._showLevel1
  self._level2Btn.interactable = self._showLevel1
  self._level2Locker:SetActive(self._isLevel2Lock)
  self:DoLevelBtnSwitch(self._showLevel1)
end
