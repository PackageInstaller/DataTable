_class("UIN19HardLevelController", UIController)
UIN19HardLevelController = UIN19HardLevelController

function UIN19HardLevelController:LoadDataOnEnter(TT, res)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N19_COMMON, ECampaignN19CommonComponentID.HARD_LEVEL)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  if res and res:GetSucc() then
    local camp = self._campaign:GetComponent(ECampaignN19CommonComponentID.HARD_LEVEL)
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

function UIN19HardLevelController:OnShow(uiParams)
  self:InitWidget()
  self.topButtonWidget = self.topbuttons:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN19MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  local fromBattle = false
  local isWin = false
  if uiParams[1] then
    fromBattle = uiParams[1][1]
    isWin = uiParams[1][2]
  end
  UIN19HardLevelController.LevelCfg = {
    [1] = {
      title = "n11_kng_title",
      normal = "n11_kng_stage01",
      click = "n11_kng_stage01_click",
      close = "n11_kng_stage01_close"
    },
    [2] = {
      title = "n11_kng_title2",
      normal = "n11_kng_stage02",
      click = "n11_kng_stage02_click",
      close = "n11_kng_stage02_close"
    },
    [3] = {
      title = "n11_kng_title",
      normal = "n11_kng_stage03",
      click = "n11_kng_stage03_click",
      close = "n11_kng_stage03_close"
    },
    [4] = {
      title = "n11_kng_title",
      normal = "n11_kng_stage04",
      click = "n11_kng_stage04_click",
      close = "n11_kng_stage04_close"
    },
    [5] = {
      title = "n11_kng_title2",
      normal = "n11_kng_stage05",
      click = "n11_kng_stage05_click",
      close = "n11_kng_stage05_close"
    },
    [6] = {
      title = "n11_kng_title2",
      normal = "n11_kng_stage06",
      click = "n11_kng_stage06_click",
      close = "n11_kng_stage06_close"
    },
    [7] = {
      title = "n11_kng2_title",
      normal = "n11_kng2_stage01",
      click = "n11_kng2_stage01_click",
      close = "n11_kng2_stage01_close"
    },
    [8] = {
      title = "n11_kng2_title2",
      normal = "n11_kng2_stage02",
      click = "n11_kng2_stage02_click",
      close = "n11_kng2_stage02_close"
    },
    [9] = {
      title = "n11_kng2_title",
      normal = "n11_kng2_stage03",
      click = "n11_kng2_stage03_click",
      close = "n11_kng2_stage03_close"
    },
    [10] = {
      title = "n11_kng2_title",
      normal = "n11_kng2_stage04",
      click = "n11_kng2_stage04_click",
      close = "n11_kng2_stage04_close"
    },
    [11] = {
      title = "n11_kng2_title2",
      normal = "n11_kng2_stage05",
      click = "n11_kng2_stage05_click",
      close = "n11_kng2_stage05_close"
    },
    [12] = {
      title = "n11_kng2_title2",
      normal = "n11_kng2_stage06",
      click = "n11_kng2_stage06_click",
      close = "n11_kng2_stage06_close"
    },
    bghard = {
      Bg = "n11_kng_bg",
      Bg2 = "n11_kng_bg3",
      Bg1 = "n11_kng_bg2",
      Bg3 = "n11_kng_edge_l",
      Bg4 = "n11_kng_edge_r",
      TimeBg = "n11_xxg_timedi"
    },
    bgevil = {
      Bg = "n11_kng2_bg",
      Bg2 = "n11_kng2_bg3",
      Bg1 = "n11_kng2_bg2",
      Bg3 = "n11_kng2_edge_l",
      Bg4 = "n11_kng2_edge_r",
      TimeBg = "n11_kng2_timedi"
    }
  }
  self._atlas = self:GetAsset("N11hardlevel.spriteatlas", LoadType.SpriteAtlas)
  self._levelCpt = self._campaign:GetComponent(ECampaignN19CommonComponentID.HARD_LEVEL)
  self._levelCptInfo = self._levelCpt:GetComponentInfo()
  local cptID = self._levelCpt:GetComponentCfgId()
  local allMissions = Cfg.cfg_component_line_mission({ComponentID = cptID})
  table.sort(allMissions, function(a, b)
    return a.SortId < b.SortId
  end)
  if #allMissions ~= 12 then
    Log.exception("N19高难关的数量必须是12  -- 等美术资源和测试配置")
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
  local closeTime = self._levelCptInfo.m_close_time
  
  local function countDown()
    local now = self:GetModule(SvrTimeModule):GetServerTime() / 1000
    local time = math.ceil(closeTime - now)
    local timeStr = UIActivityHelper.GetFormatTimerStr(time)
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
    self:_FadeInAnim()
  else
    self:_RefreshPoint()
  end
  self._isShow = true
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  LocalDB.SetInt("UIN19HardLevel" .. pstid, 1)
end

function UIN19HardLevelController:_FadeInAnim()
  self:_RefreshPoint()
  self._fadeInTimer = GameGlobal.Timer():AddEvent(650, function()
    self._fadeInTimer = nil
    if not self._isLevel2Lock and self._curIndex == 7 then
      self._level2OpenTip:SetActive(true)
      local ani = self:GetUIComponent("Animation", "lv2OpenTip")
      ani:Play("uieff_N11_Hard_Unlock")
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

function UIN19HardLevelController:OnHide()
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  if self._fadeInTimer then
    GameGlobal.Timer():CancelEvent(self._fadeInTimer)
    self._fadeInTimer = nil
  end
  UIN19HardLevelController.LevelCfg = nil
  self._isShow = false
end

function UIN19HardLevelController:InitWidget()
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self._levels = {}
  for i = 1, 6 do
    self._levels[i] = UIN19HardLevelItem:New(self:GetUIComponent("UIView", "Level" .. i))
  end
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "BlurHelper")
  self._shotRect = self:GetUIComponent("RectTransform", "BlurHelper")
  self._width = self._shotRect.rect.width
  self._height = self._shotRect.rect.height
  self._shot.width = self._width
  self._shot.height = self._height
  self._shot.blurTimes = 0
  self._scale = 1.2
  self._bgR1Loader = self:GetUIComponent("RawImageLoader", "bg")
  self._bgR2Loader = self:GetUIComponent("RawImageLoader", "bg2")
  self._level1Btn = self:GetUIComponent("Button", "level1")
  self._level2Btn = self:GetUIComponent("Button", "level2")
  self._level1BtnRect = self:GetUIComponent("RectTransform", "level1")
  self._level2BtnRect = self:GetUIComponent("RectTransform", "level2")
  self._level1BtnImg = self:GetUIComponent("Image", "level1")
  self._level2BtnImg = self:GetUIComponent("Image", "level2")
  self._level2ArtFont = self:GetUIComponent("ArtFont", "SwitchName2")
  self._timeBgImg = self:GetUIComponent("Image", "timeBg")
  self._level2OpenTip = self:GetGameObject("lv2OpenTip")
  self._txtDescevil = self:GetGameObject("txtDescevil")
  self._txtDeschard = self:GetGameObject("txtDeschard")
  self._level2OpenTip:SetActive(false)
  self._switchAnim = self:GetUIComponent("Animation", "anim")
  self._tipAnim = self:GetUIComponent("Animation", "lv2OpenTip")
  self._bg2loader = self:GetUIComponent("RawImageLoader", "Bg2")
  self._bg1loader = self:GetUIComponent("RawImageLoader", "Bg1")
  self._bg3loader = self:GetUIComponent("RawImageLoader", "Bg3")
  self._bg4loader = self:GetUIComponent("RawImageLoader", "Bg4")
  self._level1Btn = self:GetUIComponent("Button", "Image1")
  self._level2Btn = self:GetUIComponent("Button", "Image2")
  self._switchAnim:Play("uieff_N11_Hard_In")
end

function UIN19HardLevelController:_EnterLevel(idx)
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

function UIN19HardLevelController:_RefreshPoint()
  for i = 1, 6 do
    local idx = i
    if not self._showLevel1 then
      idx = idx + 6
    end
    self._levels[i]:SetData(idx, self._levelCfgs[idx], self._passInfo[self._levelCfgs[idx].CampaignMissionId], self._curIndex, self._atlas)
  end
  local bgs = {}
  if self._showLevel1 then
    bgs = UIN19HardLevelController.LevelCfg.bghard
    self._level1BtnRect:SetAsLastSibling()
  else
    bgs = UIN19HardLevelController.LevelCfg.bgevil
    self._level2BtnRect:SetAsLastSibling()
  end
  if self._firstShow then
    self._bgR1Loader:LoadImage(bgs.Bg)
  end
  self:_DoLevelBtnSwitch(self._showLevel1)
  self._bg2loader:LoadImage(bgs.Bg2)
  self._bg1loader:LoadImage(bgs.Bg1)
  self._bg3loader:LoadImage(bgs.Bg3)
  self._bg4loader:LoadImage(bgs.Bg4)
  self._timeBgImg.sprite = self._atlas:GetSprite(bgs.TimeBg)
  self._txtDescevil:SetActive(not self._showLevel1)
  self._txtDeschard:SetActive(self._showLevel1)
end

function UIN19HardLevelController:Press1OnClick()
  self:_EnterLevel(1)
end

function UIN19HardLevelController:Press2OnClick()
  self:_EnterLevel(2)
end

function UIN19HardLevelController:Press3OnClick()
  self:_EnterLevel(3)
end

function UIN19HardLevelController:Press4OnClick()
  self:_EnterLevel(4)
end

function UIN19HardLevelController:Press5OnClick()
  self:_EnterLevel(5)
end

function UIN19HardLevelController:Press6OnClick()
  self:_EnterLevel(6)
end

function UIN19HardLevelController:Level1OnClick()
  if self._showLevel1 then
    return
  end
  self._showLevel1 = true
  self._level1BtnRect:SetAsLastSibling()
  self:_DoLevelBtnSwitch(true)
  if self._isShow then
    self:_RefreshPoint()
  end
end

function UIN19HardLevelController:_DoLevelBtnSwitch(blevel1)
  self:StartTask(function(TT)
    for i = 1, #self._levels do
      self._levels[i]:SetActive(false)
    end
    local bg = (blevel1 or self._isLevel2Lock) and UIN19HardLevelController.LevelCfg.bghard or UIN19HardLevelController.LevelCfg.bgevil
    self._bgR2Loader:LoadImage(bg.Bg)
    if self._firstShow then
      self._switchAnim:Play("uieff_N11_Hard_In")
      self._firstShow = false
    else
      self._switchAnim:Play("uieff_N11_Hard_Switch")
    end
    self:Lock(self:GetName())
    YIELD(TT, 300)
    for i = 1, #self._levels do
      self._levels[i]:SetActive(true)
    end
    self._bgR1Loader:LoadImage(bg.Bg)
    YIELD(TT, 500)
    self:UnLock(self:GetName())
  end)
end

function UIN19HardLevelController:Level2OnClick()
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
  self._level2BtnRect:SetAsLastSibling()
  self:_DoLevelBtnSwitch(false)
  if self._isShow then
    self:_RefreshPoint()
  end
end

function UIN19HardLevelController:CloseTipBtnOnClick()
  self:StartTask(function(TT)
    self:Lock(self:GetName())
    self._level2OpenTip:SetActive(false)
    YIELD(TT, 350)
    self:UnLock(self:GetName())
  end)
end
