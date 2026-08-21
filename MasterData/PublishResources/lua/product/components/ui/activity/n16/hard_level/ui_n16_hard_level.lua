_class("UIN16HardLevel", UIController)
UIN16HardLevel = UIN16HardLevel

function UIN16HardLevel:LoadDataOnEnter(TT, res)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N16, ECampaignN16ComponentID.ECAMPAIGN_N16_LEVEL_HARD)
  if res and res:GetSucc() then
    local camp = self._campaign:GetComponent(ECampaignN16ComponentID.ECAMPAIGN_N16_LEVEL_HARD)
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
        Log.error("UIN16HardLevel:LoadDataOnEnter() Cfg.cfg_campaign_mission[campInfo.m_need_mission_id] == nil, campInfo.m_need_mission_id = ", campInfo.m_need_mission_id)
      end
      return
    end
  end
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIN16HardLevel:OnShow(uiParams)
  self:InitWidget()
  self.topButtonWidget = self.topbuttons:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN16MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end)
  local fromBattle = false
  local isWin = false
  if uiParams[1] then
    fromBattle = uiParams[1][1]
    isWin = uiParams[1][2]
    local shotRT = uiParams[1][3]
  end
  UIN16HardLevel.LevelCfg = {
    [1] = {
      normal = "n16_kng_btn04",
      press = "n16_kng_btn04",
      close = "n16_kng_btn04",
      img = "n16_kng_ordinary01"
    },
    [2] = {
      normal = "n16_kng_btn04",
      press = "n16_kng_btn04",
      close = "n16_kng_btn04",
      img = "n16_kng_ordinary02"
    },
    [3] = {
      normal = "n16_kng_btn04",
      press = "n16_kng_btn04",
      close = "n16_kng_btn04",
      img = "n16_kng_ordinary03"
    },
    [4] = {
      normal = "n16_kng_btn04",
      press = "n16_kng_btn04",
      close = "n16_kng_btn04",
      img = "n16_kng_ordinary04"
    },
    [5] = {
      normal = "n16_kng_btn04",
      press = "n16_kng_btn04",
      close = "n16_kng_btn04",
      img = "n16_kng_ordinary05"
    },
    [6] = {
      normal = "n16_kng_btn04",
      press = "n16_kng_btn04",
      close = "n16_kng_btn04",
      img = "n16_kng_ordinary06"
    },
    [7] = {
      normal = "n16_kng_btn03",
      press = "n16_kng_btn03",
      close = "n16_kng_btn03",
      img = "n16_kng_difficulty01"
    },
    [8] = {
      normal = "n16_kng_btn03",
      press = "n16_kng_btn03",
      close = "n16_kng_btn03",
      img = "n16_kng_difficulty02"
    },
    [9] = {
      normal = "n16_kng_btn03",
      press = "n16_kng_btn03",
      close = "n16_kng_btn03",
      img = "n16_kng_difficulty03"
    },
    [10] = {
      normal = "n16_kng_btn03",
      press = "n16_kng_btn03",
      close = "n16_kng_btn03",
      img = "n16_kng_difficulty04"
    },
    [11] = {
      normal = "n16_kng_btn03",
      press = "n16_kng_btn03",
      close = "n16_kng_btn03",
      img = "n16_kng_difficulty05"
    },
    [12] = {
      normal = "n16_kng_btn03",
      press = "n16_kng_btn03",
      close = "n16_kng_btn03",
      img = "n16_kng_difficulty06"
    }
  }
  self._atlas = self:GetAsset("UIN16.spriteatlas", LoadType.SpriteAtlas)
  self._levelCpt = self._campaign:GetComponent(ECampaignN16ComponentID.ECAMPAIGN_N16_LEVEL_HARD)
  self._levelCptInfo = self._levelCpt:GetComponentInfo()
  local cptID = self._levelCpt:GetComponentCfgId()
  local allMissions = Cfg.cfg_component_line_mission({ComponentID = cptID})
  table.sort(allMissions, function(a, b)
    return a.SortId < b.SortId
  end)
  if #allMissions ~= 12 then
    Log.exception("N16高难关的数量必须是12")
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
  self:OnClickSwitchMat()
  self:SetGray(self._isLevel2Lock, self._level2BtnImg)
  self._level2Tmp.color = self._isLevel2Lock and Color(0, 0, 0, 0.5) or Color(1, 1, 1, 1)
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
  LocalDB.SetInt("UIActivityN16HardLevel" .. pstid, 1)
end

function UIN16HardLevel:fadeInAnim()
  self:refreshPoint()
  self:prepareForFadeIn()
  self._fadeInTimer = GameGlobal.Timer():AddEvent(500, function()
    self._fadeInTimer = nil
    if not self._isLevel2Lock and self._curIndex == 7 then
      self._level2OpenTip:SetActive(true)
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

function UIN16HardLevel:prepareForFadeIn()
  if not self._isLevel2Lock and self._curIndex == 7 then
  else
    local idx = self._curIndex
    if 6 < idx then
      idx = idx - 6
    end
    if idx <= 6 then
      self._levels[idx]:SetUiState(N16HardLevelItemState.Lock)
    end
  end
end

function UIN16HardLevel:OnHide()
  if self._countdownTimer then
    GameGlobal.Timer():CancelEvent(self._countdownTimer)
    self._countdownTimer = nil
  end
  if self._fadeInTimer then
    GameGlobal.Timer():CancelEvent(self._fadeInTimer)
    self._fadeInTimer = nil
  end
  UIN16HardLevel.LevelCfg = nil
  self._isShow = false
  self._matRes = {}
end

function UIN16HardLevel:InitWidget()
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self.topbuttons = self:GetUIComponent("UISelectObjectPath", "topbuttons")
  self._levels = {}
  for i = 1, 6 do
    self._levels[i] = UIN16HardLevelItem:New(self:GetUIComponent("UIView", "Level" .. i))
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
  self._level2Locker = self:GetGameObject("locker")
  self._level2OpenTip = self:GetGameObject("lv2OpenTip")
  self._coverBg = self:GetGameObject("CoverBg")
  self._level2OpenTip:SetActive(false)
  self._switchAnim = self:GetUIComponent("Animation", "go")
  self._screenShot = self:GetUIComponent("RawImage", "shot")
  self._tipAnim = self:GetUIComponent("Animation", "uianim")
  self._level1Tmp = self:GetUIComponent("UILocalizedTMP", "level1TMP")
  self._level2Tmp = self:GetUIComponent("UILocalizedTMP", "level2TMP")
  self._matRes = {}
  self:SetFontMat(self._level1Tmp, "uieff_n16_hardlevel_hard.mat")
  self:SetFontMat(self._level2Tmp, "uieff_n16_hardlevel_evil.mat")
end

function UIN16HardLevel:enterLevel(idx)
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

function UIN16HardLevel:refreshPoint()
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
  self:doLevelBtnSwitch(true)
  if self._showLevel1 then
    self._bgLoader:LoadImage("n16_kng_beijin02")
  else
    self._bgLoader:LoadImage("n16_kng_beijin01")
  end
end

function UIN16HardLevel:press1OnClick()
  self:enterLevel(1)
end

function UIN16HardLevel:press2OnClick()
  self:enterLevel(2)
end

function UIN16HardLevel:press3OnClick()
  self:enterLevel(3)
end

function UIN16HardLevel:press4OnClick()
  self:enterLevel(4)
end

function UIN16HardLevel:press5OnClick()
  self:enterLevel(5)
end

function UIN16HardLevel:press6OnClick()
  self:enterLevel(6)
end

function UIN16HardLevel:level1OnClick()
  if self._showLevel1 then
    return
  end
  self._showLevel1 = true
  self:OnClickSwitchMat()
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

function UIN16HardLevel:doLevelBtnSwitch(bNoAnim)
  local showImageRes = "n16_kng_bnt02"
  local hideImageRes = "n16_kng_bnt01"
  local btn1Image = showImageRes
  local btn2Image = hideImageRes
  self._level1BtnImg.sprite = self._atlas:GetSprite(btn1Image)
  self._level2BtnImg.sprite = self._atlas:GetSprite(btn2Image)
end

function UIN16HardLevel:level2OnClick()
  if self._isLevel2Lock then
    local cfgv = Cfg.cfg_campaign_mission[self._levelCfgs[6].CampaignMissionId]
    local lvName = StringTable.Get(cfgv.Name)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_will_open_after_clearance", lvName))
    return
  end
  if not self._showLevel1 then
    return
  end
  self._showLevel1 = not self._showLevel1
  self:OnClickSwitchMat()
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

function UIN16HardLevel:closeTipBtnOnClick()
  self:StartTask(function(TT)
    self:Lock(self:GetName())
    self._tipAnim:Play("uieff_Activity_Summer1_lv2OpenTip_Out")
    YIELD(TT, 350)
    self:UnLock(self:GetName())
  end)
end

function UIN16HardLevel:SetFontMat(lable, resname)
  local res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  table.insert(self._matRes, res)
  if not res then
    return
  end
  local obj = res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIN16HardLevel:SetGray(gray, image)
  self._EMIMat = UnityEngine.Material:New(image.material)
  image.material = self._EMIMat
  if gray then
    image.material:SetFloat("_LuminosityAmount", 1)
  else
    image.material:SetFloat("_LuminosityAmount", 0)
  end
end

function UIN16HardLevel:OnClickSwitchMat()
  local level1 = "uieff_n16_hardlevel_hard.mat"
  local level2 = "uieff_n16_hardlevel_evil.mat"
  local str1 = "str_activity_n16_hardlevel_level_1"
  local str2 = "str_activity_n16_hardlevel_level_2"
  local ani = "uieffanim_N16_HardLevel_01"
  if self._showLevel1 then
    level1 = "uieff_n16_hardlevel_hard.mat"
    level2 = "uieff_n16_hardlevel_evil.mat"
    str1 = "str_activity_n16_hardlevel_level_1"
    str2 = "str_activity_n16_hardlevel_level_2"
    ani = "uieffanim_N16_HardLevel_01"
  else
    level1 = "uieff_n16_hardlevel_evil.mat"
    level2 = "uieff_n16_hardlevel_hard.mat"
    str1 = "str_activity_n16_hardlevel_level_2"
    str2 = "str_activity_n16_hardlevel_level_1"
    ani = "uieffanim_N16_HardLevel_02"
  end
  self._coverBg:SetActive(not self._showLevel1)
  self._switchAnim:Play(ani)
end
