_class("UIN26HardLevel", UIController)
UIN26HardLevel = UIN26HardLevel

function UIN26HardLevel:LoadDataOnEnter(TT, res)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N26, ECampaignN26ComponentID.ECAMPAIGN_N26_LINE_MISSION, ECampaignN26ComponentID.ECAMPAIGN_N26_DIFFICULT_MISSION)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  if res and res:GetSucc() then
    local camp = self._campaign:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_DIFFICULT_MISSION)
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
    self._line_component = self._campaign:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_LINE_MISSION)
    self._line_info = self._line_component:GetComponentInfo()
  end
end

function UIN26HardLevel:OnShow(uiParams)
  self._rootAni = self:GetUIComponent("Animation", "rootAni")
  self._paintingAni = self:GetUIComponent("Animation", "paintingAni")
  self._paintingAni.gameObject:SetActive(false)
  self:InitWidget()
  self:InitCommonTopButton()
  self:InitLevelCfg()
  local spine, bgm = self:GetSpineAndBgm()
  if bgm then
    AudioHelperController.PlayBGM(bgm, AudioConstValue.BGMCrossFadeTime)
  end
  self._levelCpt = self._campaign:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_DIFFICULT_MISSION)
  self._levelCptInfo = self._levelCpt:GetComponentInfo()
  self:RefreshCurrentIndex()
  self._atlas = self:GetAsset("UIN26Hard.spriteatlas", LoadType.SpriteAtlas)
  self._time = self:GetUIComponent("UILocalizationText", "RemainTime")
  self:RefreshTime()
  self:SetLevelBtns()
  self:_RefreshPoint()
  self._isShow = true
  self._bg2loader.gameObject:SetActive(not self._showLevel1)
  self._bg1loader.gameObject:SetActive(self._showLevel1)
  self._bg2PatternLoader.gameObject:SetActive(not self._showLevel1)
  self._bg1PatternLoader.gameObject:SetActive(self._showLevel1)
  local fromBattle = false
  local isWin = false
  if uiParams[1] then
    fromBattle = uiParams[1][1]
    isWin = uiParams[1][2]
  end
  if self._showLevel1 then
    self._rootAni:Play("uieff_N26_HardLevel_in")
  else
    self._rootAni:Play("uieff_N26_HardLevel_start")
  end
  if fromBattle and isWin then
    self:FadeInAnim()
  else
  end
end

function UIN26HardLevel:InitLevelCfg()
  UIN26HardLevel.LevelCfg = {
    [1] = {
      normal = "n26_kng_icon01",
      click = "n26_kng_btn03",
      close = "n26_kng_mask03"
    },
    [2] = {
      normal = "n26_kng_icon02",
      click = "n26_kng_btn03",
      close = "n26_kng_mask03"
    },
    [3] = {
      normal = "n26_kng_icon03",
      click = "n26_kng_btn03",
      close = "n26_kng_mask03"
    },
    [4] = {
      normal = "n26_kng_icon04",
      click = "n26_kng_btn03",
      close = "n26_kng_mask03"
    },
    [5] = {
      normal = "n26_kng_icon05",
      click = "n26_kng_btn03",
      close = "n26_kng_mask03"
    },
    [6] = {
      normal = "n26_kng_icon06",
      click = "n26_kng_btn03",
      close = "n26_kng_mask03"
    },
    [7] = {
      normal = "n26_kng_icon07",
      click = "n26_kng_btn04",
      close = "n26_kng_mask04"
    },
    [8] = {
      normal = "n26_kng_icon08",
      click = "n26_kng_btn04",
      close = "n26_kng_mask04"
    },
    [9] = {
      normal = "n26_kng_icon09",
      click = "n26_kng_btn04",
      close = "n26_kng_mask04"
    },
    [10] = {
      normal = "n26_kng_icon10",
      click = "n26_kng_btn04",
      close = "n26_kng_mask04"
    },
    [11] = {
      normal = "n26_kng_icon11",
      click = "n26_kng_btn04",
      close = "n26_kng_mask04"
    },
    [12] = {
      normal = "n26_kng_icon12",
      click = "n26_kng_btn04",
      close = "n26_kng_mask04"
    },
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
  return self.LevelCfg
end

function UIN26HardLevel:InitCommonTopButton()
  self.topButtonWidget = self.topbuttons:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN26MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
end

function UIN26HardLevel:RefreshTime()
  local endTime = self._levelCptInfo.m_close_time
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local remainTime = endTime - curTime
  remainTime = math.max(remainTime, 0)
  local timeStr = UIN26Line:GetFormatTimerStr(remainTime, "FEFCFC")
  if self._timeString ~= timeStr then
    self._time:SetText(timeStr)
    self._timeString = timeStr
  end
end

function UIN26HardLevel:OnUpdate()
  self:RefreshTime()
end

function UIN26HardLevel:FadeInAnim()
  if self._curIndex == 7 then
    self:UnlockEvilAnimation()
  end
end

function UIN26HardLevel:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN26ActivityMainRedStatusRefresh)
  UIN26HardLevel.LevelCfg = nil
  self._isShow = false
end

function UIN26HardLevel:InitWidget()
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self._levels = {}
  for i = 1, 6 do
    self._levels[i] = UIN26HardLevelItem:New(self:GetUIComponent("UIView", "Level" .. i))
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
end

function UIN26HardLevel:_EnterLevel(idx)
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
  local localProcess = self._campaign:GetLocalProcess()
  localProcess:HardLineMissionChallenge(missionID)
end

function UIN26HardLevel:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIN26HardLevel:RefreshCurrentIndex()
  local cptID = self._levelCpt:GetComponentCfgId()
  local allMissions = Cfg.cfg_component_line_mission({ComponentID = cptID})
  table.sort(allMissions, function(a, b)
    return a.SortId < b.SortId
  end)
  if #allMissions ~= 12 then
    Log.exception("N26高难关的数量必须是12")
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
  self._isLevel2Lock = self._curIndex <= 6
  self._showLevel1 = self._isLevel2Lock
end

function UIN26HardLevel:_RefreshPoint()
  for i = 1, 6 do
    local idx = i
    if not self._showLevel1 then
      idx = idx + 6
    end
    self._levels[i]:SetData(idx, self._levelCfgs[idx], self._passInfo[self._levelCfgs[idx].CampaignMissionId], self._curIndex, self._atlas)
  end
  local bgs = {}
  if self._showLevel1 then
    bgs = UIN26HardLevel.LevelCfg.bghard
  else
    bgs = UIN26HardLevel.LevelCfg.bgevil
  end
  self:DoLevelBtnSwitch(self._showLevel1)
  self._bg2loader:LoadImage(bgs.Bg2)
  self._bg1loader:LoadImage(bgs.Bg1)
end

function UIN26HardLevel:Press1OnClick()
  self:_EnterLevel(1)
end

function UIN26HardLevel:Press2OnClick()
  self:_EnterLevel(2)
end

function UIN26HardLevel:Press3OnClick()
  self:_EnterLevel(3)
end

function UIN26HardLevel:Press4OnClick()
  self:_EnterLevel(4)
end

function UIN26HardLevel:Press5OnClick()
  self:_EnterLevel(5)
end

function UIN26HardLevel:Press6OnClick()
  self:_EnterLevel(6)
end

function UIN26HardLevel:SetLevelBtns()
  self.level1Btn = self:_SpawnObject("level1", "UIN26HardLevelBtn")
  self.level2Btn = self:_SpawnObject("level2", "UIN26HardLevelBtn")
  self.level1Btn:SetData(self._atlas, 1, function()
    self:ClickLevelBtn1()
  end)
  self.level2Btn:SetData(self._atlas, 2, function()
    self:ClickLevelBtn2()
  end)
  self:RefreshLevelBtnSelect(true)
end

function UIN26HardLevel:RefreshLevelBtnSelect(localPosition)
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

function UIN26HardLevel:ClickLevelBtn1()
  if self._showLevel1 then
    return
  end
  self._showLevel1 = true
  self:DoLevelBtnSwitch(true)
  self:RefreshLevelBtnSelect(false)
end

function UIN26HardLevel:ClickLevelBtn2()
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
  self:RefreshLevelBtnSelect(false)
end

function UIN26HardLevel:ClickLevelBtn2_TestBlock()
  if not self._showLevel1 then
    return
  end
  self._showLevel1 = false
  self:DoLevelBtnSwitch(false)
  self:RefreshLevelBtnSelect(false)
end

function UIN26HardLevel:UnlockLevel(curIndex)
  self._curIndex = curIndex
  self._isLevel2Lock = self._curIndex <= 6
  self._showLevel1 = self._isLevel2Lock
  if self._curIndex == 7 then
    self:UnlockEvilAnimation()
  end
  self:RefreshLevelBtnSelect(false)
  self:_RefreshPoint()
end

function UIN26HardLevel:UnlockEvilAnimation()
  local lockName = self:GetName() .. ".EvilOpenAnim"
  self:StartTask(function(TT)
    self:Lock(lockName)
    YIELD(TT, 1000)
    self._bg2loader.gameObject:SetActive(true)
    self._bg1loader.gameObject:SetActive(true)
    self._bg2PatternLoader.gameObject:SetActive(true)
    self._bg1PatternLoader.gameObject:SetActive(true)
    self._rootAni:Play("uieff_N26_HardLevel_loop")
    self._paintingAni.gameObject:SetActive(true)
    self._level2OpenTip:SetActive(true)
    YIELD(TT, 1833)
    self._bg2loader.gameObject:SetActive(not self._showLevel1)
    self._bg1loader.gameObject:SetActive(self._showLevel1)
    self._bg2PatternLoader.gameObject:SetActive(not self._showLevel1)
    self._bg1PatternLoader.gameObject:SetActive(self._showLevel1)
    self._paintingAni.gameObject:SetActive(false)
    self._level2OpenTip:SetActive(false)
    self:UnLock(lockName)
  end)
end

function UIN26HardLevel:CloseTipBtnOnClick()
  local lockName = self:GetName() .. ".EvilCloseAnim"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._level2OpenTip:SetActive(false)
    YIELD(TT, 350)
    self:UnLock(lockName)
  end)
end

function UIN26HardLevel:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIN26HardLevel:Level2OnClick()
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

function UIN26HardLevel:_RefreshPoint()
  for i = 1, 6 do
    local idx = i
    if not self._showLevel1 then
      idx = idx + 6
    end
    self._levels[i]:SetData(idx, self._levelCfgs[idx], self._passInfo[self._levelCfgs[idx].CampaignMissionId], self._curIndex, self._atlas)
  end
  self.level2Btn:SetLockVisible(self._isLevel2Lock)
end

function UIN26HardLevel:DoLevelBtnSwitch(blevel1)
  self:StartTask(function(TT)
    self:Lock(self:GetName())
    self._bg2loader.gameObject:SetActive(true)
    self._bg1loader.gameObject:SetActive(true)
    self._bg2PatternLoader.gameObject:SetActive(true)
    self._bg1PatternLoader.gameObject:SetActive(true)
    if self._showLevel1 then
      self._rootAni:Play("uieff_N26_HardLevel_out")
      YIELD(TT, 300)
      self:_RefreshPoint()
      YIELD(TT, 533)
    else
      self._rootAni:Play("uieff_N26_HardLevel_loop")
      self._paintingAni.gameObject:SetActive(true)
      YIELD(TT, 800)
      self:_RefreshPoint()
      YIELD(TT, 1033)
      self._paintingAni.gameObject:SetActive(false)
    end
    self._bg2loader.gameObject:SetActive(not blevel1)
    self._bg1loader.gameObject:SetActive(blevel1)
    self._bg2PatternLoader.gameObject:SetActive(not blevel1)
    self._bg1PatternLoader.gameObject:SetActive(blevel1)
    self:UnLock(self:GetName())
  end)
end

function UIN26HardLevel:GetSpineAndBgm()
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
