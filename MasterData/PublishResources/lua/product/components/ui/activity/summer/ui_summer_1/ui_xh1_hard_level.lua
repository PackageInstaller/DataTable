_class("UIXH1HardLevel", UIController)
UIXH1HardLevel = UIXH1HardLevel

function UIXH1HardLevel:LoadDataOnEnter(TT, res)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SUMMER_I, ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_HARD)
  if res and res:GetSucc() then
    local camp = self._campaign:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_HARD)
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
        local msg = StringTable.Get("str_activity_summer_i_will_open_after_clearance", lvName)
        ToastManager.ShowToast(msg)
      end
      return
    end
  end
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIXH1HardLevel:OnShow(uiParams)
  self:InitWidget()
  self.topButtonWidget = self.topbuttons:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UISummer1, UIStateType.UIMain, nil, self._campaign._id)
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
  UIXH1HardLevel.LevelCfg = {
    [1] = {
      normal = "summer_guanqia_btn1",
      close = "summer_guanqia_btn4"
    },
    [2] = {
      normal = "summer_guanqia_btn9",
      close = "summer_guanqia_btn12"
    },
    [3] = {
      normal = "summer_guanqia_btn5",
      close = "summer_guanqia_btn8"
    },
    [4] = {
      normal = "summer_guanqia_btn13",
      close = "summer_guanqia_btn16"
    },
    [5] = {
      normal = "summer_guanqia_btn17",
      close = "summer_guanqia_btn20"
    },
    [6] = {
      normal = "summer_guanqia_btn21",
      close = "summer_guanqia_btn24"
    },
    [7] = {
      normal = "summer_guanqia_btnhard1",
      close = "summer_guanqia_btnhard2"
    },
    [8] = {
      normal = "summer_guanqia_btnhard5",
      close = "summer_guanqia_btnhard6"
    },
    [9] = {
      normal = "summer_guanqia_btnhard3",
      close = "summer_guanqia_btnhard4"
    },
    [10] = {
      normal = "summer_guanqia_btnhard7",
      close = "summer_guanqia_btnhard8"
    },
    [11] = {
      normal = "summer_guanqia_btnhard9",
      close = "summer_guanqia_btnhard10"
    },
    [12] = {
      normal = "summer_guanqia_btnhard11",
      close = "summer_guanqia_btnhard12"
    }
  }
  self._atlas = self:GetAsset("UIXH1HardLevel.spriteatlas", LoadType.SpriteAtlas)
  self._levelCpt = self._campaign:GetComponent(ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_HARD)
  self._levelCptInfo = self._levelCpt:GetComponentInfo()
  local cptID = self._levelCpt:GetComponentCfgId()
  local allMissions = Cfg.cfg_component_line_mission({ComponentID = cptID})
  table.sort(allMissions, function(a, b)
    return a.SortId < b.SortId
  end)
  if #allMissions ~= 12 then
    Log.exception("夏活1高难关的数量必须是12")
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
      self._time:RefreshText(StringTable.Get("str_activity_summer_i_countdown", timeStr))
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
end

function UIXH1HardLevel:fadeInAnim()
  self:refreshPoint()
  self._fadeInTimer = GameGlobal.Timer():AddEvent(650, function()
    self._fadeInTimer = nil
    if not self._isLevel2Lock and self._curIndex == 7 then
      self._tipAnim:Play("uieff_Activity_Summer1_lv2OpenTip_In")
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

function UIXH1HardLevel:OnHide()
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  if self._fadeInTimer then
    GameGlobal.Timer():CancelEvent(self._fadeInTimer)
    self._fadeInTimer = nil
  end
  UIXH1HardLevel.LevelCfg = nil
  self._isShow = false
end

function UIXH1HardLevel:InitWidget()
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self._levels = {}
  for i = 1, 6 do
    self._levels[i] = UIXH1HardLevelItem:New(self:GetUIComponent("UIView", "Level" .. i))
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
  self._level2Locker = self:GetGameObject("locker")
  self._level2OpenTip = self:GetGameObject("lv2OpenTip")
  self._level2OpenTip:SetActive(false)
  self._switchAnim = self:GetUIComponent("Animation", "uieff_SummerActivity_Switch")
  self._screenShot = self:GetUIComponent("RawImage", "shot")
  self._tipAnim = self:GetUIComponent("Animation", "uianim")
end

function UIXH1HardLevel:ShopButtonOnClick(go)
  self:ShowDialog("UIXH1Shop")
end

function UIXH1HardLevel:SwitchButtonOnClick(go)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:CampaignSwitchState(true, UIStateType.UIXH1SimpleLevel, UIStateType.UISummer1, nil, self._campaign._id)
end

function UIXH1HardLevel:enterLevel(idx)
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
    ToastManager.ShowToast(StringTable.Get("str_activity_summer_i_locked"))
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

function UIXH1HardLevel:refreshPoint()
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
  if self._showLevel1 then
    self._bgLoader:LoadImage("summer_guanqia_di2")
  else
    self._bgLoader:LoadImage("summer_guanqia_hardbg")
  end
end

function UIXH1HardLevel:press1OnClick()
  self:enterLevel(1)
end

function UIXH1HardLevel:press2OnClick()
  self:enterLevel(2)
end

function UIXH1HardLevel:press3OnClick()
  self:enterLevel(3)
end

function UIXH1HardLevel:press4OnClick()
  self:enterLevel(4)
end

function UIXH1HardLevel:press5OnClick()
  self:enterLevel(5)
end

function UIXH1HardLevel:press6OnClick()
  self:enterLevel(6)
end

function UIXH1HardLevel:level1OnClick()
  if self._showLevel1 then
    return
  end
  self._showLevel1 = true
  self._switchAnim.gameObject:SetActive(true)
  self._switchAnim:Play("uieff_summer2_switch2")
  self:StartTask(function(TT)
    self:Lock(self:GetName())
    YIELD(TT, 260)
    if self._isShow then
      self:refreshPoint()
    end
    self:UnLock(self:GetName())
  end)
end

function UIXH1HardLevel:level2OnClick()
  if self._isLevel2Lock then
    local cfgv = Cfg.cfg_campaign_mission[self._levelCfgs[6].CampaignMissionId]
    local lvName = StringTable.Get(cfgv.Name)
    ToastManager.ShowToast(StringTable.Get("str_activity_summer_i_will_open_after_clearance", lvName))
    return
  end
  if not self._showLevel1 then
    return
  end
  self._showLevel1 = false
  self._switchAnim.gameObject:SetActive(true)
  self._switchAnim:Play("uieff_summer2_switch2")
  self:StartTask(function(TT)
    self:Lock(self:GetName())
    YIELD(TT, 260)
    if self._isShow then
      self:refreshPoint()
    end
    self:UnLock(self:GetName())
  end)
end

function UIXH1HardLevel:closeTipBtnOnClick()
  self:StartTask(function(TT)
    self:Lock(self:GetName())
    self._tipAnim:Play("uieff_Activity_Summer1_lv2OpenTip_Out")
    YIELD(TT, 350)
    self:UnLock(self:GetName())
  end)
end
