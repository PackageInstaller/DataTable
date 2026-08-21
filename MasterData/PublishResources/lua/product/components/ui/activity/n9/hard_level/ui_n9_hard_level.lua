_class("UIN9HardLevel", UIController)
UIN9HardLevel = UIN9HardLevel

function UIN9HardLevel:LoadDataOnEnter(TT, res)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N9, ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD)
  if res and res:GetSucc() then
    local camp = self._campaign:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD)
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
      else
        Log.error("UIN9HardLevel:LoadDataOnEnter() Cfg.cfg_campaign_mission[campInfo.m_need_mission_id] == nil, campInfo.m_need_mission_id = ", campInfo.m_need_mission_id)
      end
      return
    end
  end
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIN9HardLevel:OnShow(uiParams)
  self:InitWidget()
  self.topButtonWidget = self.topbuttons:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN9MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  local fromBattle = false
  local isWin = false
  if uiParams[1] then
    fromBattle = uiParams[1][1]
    isWin = uiParams[1][2]
    local shotRT = uiParams[1][3]
    if shotRT then
      self._screenShot.texture = shotRT
      self._screenShot.gameObject:SetActive(true)
    else
      self._screenShot.gameObject:SetActive(false)
    end
  end
  UIN9HardLevel.LevelCfg = {
    [1] = {
      normal = "n9_kng_stage01",
      press = "n9_kng_stage01_click",
      close = "n9_kng_stage01_close"
    },
    [2] = {
      normal = "n9_kng_stage02",
      press = "n9_kng_stage02_click",
      close = "n9_kng_stage02_close"
    },
    [3] = {
      normal = "n9_kng_stage03",
      press = "n9_kng_stage03_click",
      close = "n9_kng_stage03_close"
    },
    [4] = {
      normal = "n9_kng_stage04",
      press = "n9_kng_stage04_click",
      close = "n9_kng_stage04_close"
    },
    [5] = {
      normal = "n9_kng_stage05",
      press = "n9_kng_stage05_click",
      close = "n9_kng_stage05_close"
    },
    [6] = {
      normal = "n9_kng_stage06",
      press = "n9_kng_stage06_click",
      close = "n9_kng_stage06_close"
    },
    [7] = {
      normal = "n9_kng2_stage01",
      press = "n9_kng2_stage01_click",
      close = "n9_kng2_stage01_close"
    },
    [8] = {
      normal = "n9_kng2_stage02",
      press = "n9_kng2_stage02_click",
      close = "n9_kng2_stage02_close"
    },
    [9] = {
      normal = "n9_kng2_stage03",
      press = "n9_kng2_stage03_click",
      close = "n9_kng2_stage03_close"
    },
    [10] = {
      normal = "n9_kng2_stage04",
      press = "n9_kng2_stage04_click",
      close = "n9_kng2_stage04_close"
    },
    [11] = {
      normal = "n9_kng2_stage05",
      press = "n9_kng2_stage05_click",
      close = "n9_kng2_stage05_close"
    },
    [12] = {
      normal = "n9_kng2_stage06",
      press = "n9_kng2_stage06_click",
      close = "n9_kng2_stage06_close"
    }
  }
  self._atlas = self:GetAsset("UIN9HardLevel.spriteatlas", LoadType.SpriteAtlas)
  self._levelCpt = self._campaign:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD)
  self._levelCptInfo = self._levelCpt:GetComponentInfo()
  local cptID = self._levelCpt:GetComponentCfgId()
  local allMissions = Cfg.cfg_component_line_mission({ComponentID = cptID})
  table.sort(allMissions, function(a, b)
    return a.SortId < b.SortId
  end)
  if #allMissions ~= 12 then
    Log.exception("N9高难关的数量必须是12")
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
  self._time = self:GetUIComponent("RollingText", "RemainTime")
  local closeTime = self._levelCptInfo.m_close_time
  
  local function countDown()
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    local time = math.ceil(closeTime - now)
    local timeStr = UIActivityHelper.GetFormatTimerStr(time)
    if self._timeString ~= timeStr then
      self._time:RefreshText(timeStr)
      self._timeString = timeStr
    end
    if time < 0 and self._countdownTimer then
      GameGlobal.Timer():CancelEvent(self._countdownTimer)
      self._countdownTimer = nil
    end
  end
  
  countDown()
  self._countdownTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, countDown)
  if fromBattle and isWin then
    self:fadeInAnim()
  else
    self:refreshPoint()
  end
  self._isShow = true
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  LocalDB.SetInt("UIActivityN9HardLevel" .. pstid, 1)
end

function UIN9HardLevel:fadeInAnim()
  self:refreshPoint()
  self:prepareForFadeIn()
  self._fadeInTimer = GameGlobal.Timer():AddEvent(500, function()
    self._fadeInTimer = nil
    if not self._isLevel2Lock and self._curIndex == 7 then
      self._level2OpenTip:SetActive(true)
      self._tipAnim:Play("uieff_Activity_Summer1_lv2OpenTip_In")
    else
      local idx = self._curIndex
      if 6 < idx then
        idx = idx - 6
      end
      if idx <= 6 then
        self._levels[idx]:Anim_Open()
      end
    end
  end)
end

function UIN9HardLevel:prepareForFadeIn()
  if not self._isLevel2Lock and self._curIndex == 7 then
  else
    local idx = self._curIndex
    if 6 < idx then
      idx = idx - 6
    end
    if idx <= 6 then
      self._levels[idx]:SetUiState(N9HardLevelItemState.Lock)
    end
  end
end

function UIN9HardLevel:OnHide()
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  if self._fadeInTimer then
    GameGlobal.Timer():CancelEvent(self._fadeInTimer)
    self._fadeInTimer = nil
  end
  UIN9HardLevel.LevelCfg = nil
  self._isShow = false
end

function UIN9HardLevel:InitWidget()
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self._levels = {}
  for i = 1, 6 do
    self._levels[i] = UIN9HardLevelItem:New(self:GetUIComponent("UIView", "Level" .. i))
  end
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "BlurHelper")
  self._shotRect = self:GetUIComponent("RectTransform", "BlurHelper")
  self._width = self._shotRect.rect.width
  self._height = self._shotRect.rect.height
  self._shot.width = self._width
  self._shot.height = self._height
  self._shot.blurTimes = 0
  self._scale = 1.2
  self._bgLoader = self:GetUIComponent("RawImageLoader", "bg")
  self._level1Btn = self:GetUIComponent("Button", "level1")
  self._level2Btn = self:GetUIComponent("Button", "level2")
  self._level1BtnRect = self:GetUIComponent("RectTransform", "level1")
  self._level2BtnRect = self:GetUIComponent("RectTransform", "level2")
  self._level1BtnImg = self:GetUIComponent("Image", "level1")
  self._level2BtnImg = self:GetUIComponent("Image", "level2")
  self._level2ArtFont = self:GetUIComponent("ArtFont", "SwitchName2")
  self._level2LockTextCanv = self:GetUIComponent("CanvasGroup", "LevelLockTextCanv")
  self._level2Locker = self:GetGameObject("locker")
  self._level2OpenTip = self:GetGameObject("lv2OpenTip")
  self._level2OpenTip:SetActive(false)
  self._screenShot = self:GetUIComponent("RawImage", "shot")
  self._tipAnim = self:GetUIComponent("Animation", "uianim")
end

function UIN9HardLevel:enterLevel(idx)
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
  local rt = self._shot:RefreshBlurTexture()
  local maxOffset = 529.0
  local pos = self._levels[idx]:LocalPosition()
  local posX = -pos.x
  local posY = -pos.y
  posX = math.max(math.min(posX, maxOffset), -maxOffset)
  self._offset = Vector2(posX, posY)
  self:ShowDialog("UIActivityStage", missionID, self._passInfo[missionID], self._levelCpt, rt, self._offset * self._scale, self._width, self._height, self._scale, false)
end

function UIN9HardLevel:refreshPoint()
  for i = 1, 6 do
    local idx = i
    if not self._showLevel1 then
      idx = idx + 6
    end
    self._levels[i]:SetData(idx, self._levelCfgs[idx], self._passInfo[self._levelCfgs[idx].CampaignMissionId], self._curIndex, self._atlas)
    self._levels[i]:Anim_In()
  end
  self._level1Btn.interactable = not self._showLevel1
  self._level2Btn.interactable = self._showLevel1
  self._level2Locker:SetActive(self._isLevel2Lock)
  if self._isLevel2Lock then
    self._level2ArtFont.enabled = false
    self._level2LockTextCanv.alpha = 0.3
  else
    self._level2ArtFont.enabled = true
    self._level2LockTextCanv.alpha = 1
  end
  self:doLevelBtnSwitch(true)
  if self._showLevel1 then
    self._bgLoader:LoadImage("n9_kng_bg1")
  else
    self._bgLoader:LoadImage("n9_kng_bg2")
  end
end

function UIN9HardLevel:press1OnClick()
  self:enterLevel(1)
end

function UIN9HardLevel:press2OnClick()
  self:enterLevel(2)
end

function UIN9HardLevel:press3OnClick()
  self:enterLevel(3)
end

function UIN9HardLevel:press4OnClick()
  self:enterLevel(4)
end

function UIN9HardLevel:press5OnClick()
  self:enterLevel(5)
end

function UIN9HardLevel:press6OnClick()
  self:enterLevel(6)
end

function UIN9HardLevel:level1OnClick()
  if self._showLevel1 then
    return
  end
  self._showLevel1 = true
  self:doLevelBtnSwitch(false)
  self:StartTask(function(TT)
    self:Lock(self:GetName())
    YIELD(TT, 260)
    if self._isShow then
      self:refreshPoint()
    end
    self:UnLock(self:GetName())
  end)
end

function UIN9HardLevel:doLevelBtnSwitch(bNoAnim)
  local tarShowX = -384.5
  local tarHideX = -463.8
  local showImageRes = "n9_kng_btn2"
  local hideImageRes = "n9_kng_btn1"
  local tarBtn1X = 0
  local tarBtn2X = 0
  local btn1Image = ""
  local btn2Image = ""
  if self._showLevel1 then
    tarBtn1X = tarShowX
    btn1Image = showImageRes
    tarBtn2X = tarHideX
    btn2Image = hideImageRes
  else
    tarBtn1X = tarHideX
    btn1Image = hideImageRes
    tarBtn2X = tarShowX
    btn2Image = showImageRes
  end
  if bNoAnim then
    self._level1BtnRect:DOAnchorPosX(tarBtn1X, 0)
  else
    self._level1BtnRect:DOAnchorPosX(tarBtn1X, 0.2)
  end
  self._level1BtnImg.sprite = self._atlas:GetSprite(btn1Image)
  if bNoAnim then
    self._level2BtnRect:DOAnchorPosX(tarBtn2X, 0)
  else
    self._level2BtnRect:DOAnchorPosX(tarBtn2X, 0.2)
  end
  self._level2BtnImg.sprite = self._atlas:GetSprite(btn2Image)
end

function UIN9HardLevel:level2OnClick()
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
  self:doLevelBtnSwitch(false)
  self:StartTask(function(TT)
    self:Lock(self:GetName())
    YIELD(TT, 260)
    if self._isShow then
      self:refreshPoint()
    end
    self:UnLock(self:GetName())
  end)
end

function UIN9HardLevel:closeTipBtnOnClick()
  self:StartTask(function(TT)
    self:Lock(self:GetName())
    self._tipAnim:Play("uieff_Activity_Summer1_lv2OpenTip_Out")
    YIELD(TT, 350)
    self:UnLock(self:GetName())
  end)
end
