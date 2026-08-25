local PersisSaveTxtFileName = "PlayerPrefs.txt"
local WindowID = DT.CommonID.Window.ID
local FullScreenID = DT.CommonID.FullScreen.ID
local SettingUniqueName = CommonDefine.SettingUniqueName
local MACHINE_DEFAULT_LEVEL = CommonDefine.MatchingLevel.Middle
local _IsNull = CS.Z1Client.UnityEngineObjectExtensionForLua.IsNull
local serverUseSettingList = {
  SettingUniqueName.EnergyFull,
  SettingUniqueName.InfomationPush,
  SettingUniqueName.TaskFinish,
  SettingUniqueName.ResBuildingFullPush,
  SettingUniqueName.AutoDecompositionOfRWeapon,
  SettingUniqueName.AutoDecompositionOfSRWeapon,
  SettingUniqueName.AutoLockOfSRWeapon,
  SettingUniqueName.AutoLockOfSSRWeapon
}
local graphicSetting = {
  SettingUniqueName.GraphicQuality,
  SettingUniqueName.Brightness,
  SettingUniqueName.Resolution,
  SettingUniqueName.FPSLimit,
  SettingUniqueName.Bloom,
  SettingUniqueName.AntiAliasing,
  SettingUniqueName.ShadowmapResolution,
  SettingUniqueName.DepthOfField,
  SettingUniqueName.Dispersion,
  SettingUniqueName.ChromaticAberration,
  SettingUniqueName.TextureQuality,
  SettingUniqueName.ParticleQuality,
  SettingUniqueName.ScenesEffects,
  SettingUniqueName.RealTimeLight,
  SettingUniqueName.UseSoftMask,
  SettingUniqueName.WindowResolution,
  SettingUniqueName.WindowSetting,
  SettingUniqueName.Outline
}
local SettingManager, Super = System.NewClass("SettingManager", Manager, IUpdater)

function SettingManager:ctor()
  Super.ctor(self)
  self.settingManager = CS.UnityEngine.GameObject.Find("GameApp"):GetComponent(typeof(CS.SettingManager))
  if not self.settingManager then
    self.settingManager = CS.UnityEngine.GameObject.Find("GameApp"):AddComponent(typeof(CS.SettingManager))
  end
  self.rpAsset = CS.UnityEngine.Rendering.GraphicsSettings.renderPipelineAsset
  self.firstRedemptionCode = true
  self.machineLevel = MACHINE_DEFAULT_LEVEL
end

function SettingManager:Awake(binder)
  Super.Awake(self)
  self:_InitFPSForPC()
  self.settingManager:Init()
  self:_CreateFuncMap()
  self:InitTextLanguage()
  self:SetDisplayShortcutKey()
  binder:BindTimer(1, 0, nil, System.fn(self, self.BindShortCut))
  if SdkMgr.Instance:HasInitSuccess() then
    self:Init()
  else
    binder:BindOnceEvent(EventMgr.Instance.OnSdkInitSuccess, System.fn(self, self.Init))
  end
  binder:BindEvent(EventMgr.Instance.OnClientDataChanged, System.fn(self, self.OnClientDataChanged))
end

function SettingManager:_InitFPSForPC()
  for _, cfg in pairs(DT.Setup) do
    if cfg.UniqueName == cd.SettingUniqueName.FPSLimit and (ApplicationUtils.IsWindows() or ApplicationUtils.IsEditor()) then
      cfg.Range = "30,60,120"
      cfg.ExHighImageQuality = 120
      break
    end
  end
end

function SettingManager:OnClientDataChanged()
  self:SetDisplayShortcutKey()
end

function SettingManager:GetLangNameByLangCode(langCode)
  local constKey = "LanguageKey_" .. langCode
  local constValue = DT.GetConstant(constKey)
  assert(constValue, "常量表：LanguageKey_" .. langCode .. " not found")
  return constValue
end

function SettingManager:_CreateFuncMap()
  self.SettingFuncMap = {
    [SettingUniqueName.GraphicQuality] = System.fn(self, self.SetGraphicQuality),
    [SettingUniqueName.ParticleQuality] = System.fn(self, self.SetParticleQuality),
    [SettingUniqueName.TextureQuality] = System.fn(self, self.SetTextureQuality),
    [SettingUniqueName.Resolution] = System.fn(self, self.SetResolution),
    [SettingUniqueName.FPSLimit] = System.fn(self, self.SetFPSLimit),
    [SettingUniqueName.Bloom] = System.fn(self, self.SetBloom),
    [SettingUniqueName.AntiAliasing] = System.fn(self, self.SetAntiAliasing),
    [SettingUniqueName.ShadowmapResolution] = System.fn(self, self.SetShadowmapResolution),
    [SettingUniqueName.DepthOfField] = System.fn(self, self.SetDepthOfField),
    [SettingUniqueName.ChromaticAberration] = System.fn(self, self.SetChromaticAberration),
    [SettingUniqueName.LanguageWord] = SettingUniqueName.LanguageWord,
    [SettingUniqueName.RedemptionCode] = System.fn(self, self.ClickRedemptionCode),
    [SettingUniqueName.UserCenter] = System.fn(self, self.OpenUserCenter),
    [SettingUniqueName.UserAgreement] = System.fn(self, self.OpenUserAgreement),
    [SettingUniqueName.UltiSkillConfirm] = SettingUniqueName.UltiSkillConfirm,
    [SettingUniqueName.HealthBarIntegration] = SettingUniqueName.HealthBarIntegration,
    [SettingUniqueName.BattleSpeed] = SettingUniqueName.BattleSpeed,
    [SettingUniqueName.AwakerLevelUpConfirm] = SettingUniqueName.AwakerLevelUpConfirm,
    [SettingUniqueName.TeamImbalanceConfirm] = SettingUniqueName.TeamImbalanceConfirm,
    [SettingUniqueName.CombatInsufficientConfirm] = SettingUniqueName.CombatInsufficientConfirm,
    [SettingUniqueName.EnergyFull] = SettingUniqueName.EnergyFull,
    [SettingUniqueName.AutoDecompositionOfRWeapon] = SettingUniqueName.AutoDecompositionOfRWeapon,
    [SettingUniqueName.AutoDecompositionOfSRWeapon] = SettingUniqueName.AutoDecompositionOfSRWeapon,
    [SettingUniqueName.AutoLockOfSRWeapon] = SettingUniqueName.AutoLockOfSRWeapon,
    [SettingUniqueName.AutoLockOfSSRWeapon] = SettingUniqueName.AutoLockOfSSRWeapon,
    [SettingUniqueName.TaskFinish] = SettingUniqueName.TaskFinish,
    [SettingUniqueName.BackTrackItemHideRed] = SettingUniqueName.BackTrackItemHideRed,
    [SettingUniqueName.ScenesEffects] = System.fn(self, self.SetScenesEffects),
    [SettingUniqueName.RealTimeLight] = SettingUniqueName.RealTimeLight,
    [SettingUniqueName.UseSoftMask] = System.fn(self, self.UseSoftMask),
    [SettingUniqueName.CustomerService] = System.fn(self, self.CustomerService),
    [SettingUniqueName.PlayPV] = System.fn(self, self.PlayPV),
    [SettingUniqueName.LoginPVModify] = System.fn(self, self.LoginPVModify),
    [SettingUniqueName.GyroscopeSwitch] = System.fn(self, self.GyroscopeSwitch),
    [SettingUniqueName.BindPhone] = System.fn(self, self.BindPhone),
    [SettingUniqueName.WindowResolution] = System.fn(self, self.SetWindowResolution),
    [SettingUniqueName.WindowSetting] = System.fn(self, self.SetWindowSetting),
    [SettingUniqueName.DisplayShortcutKey] = System.fn(self, self.SetDisplayShortcutKey),
    [SettingUniqueName.ShotDownGame] = System.fn(self, self.ShowDownGame),
    [SettingUniqueName.Outline] = System.fn(self, self.SetOutline),
    [SettingUniqueName.TranslationProgress] = SettingUniqueName.TranslationProgress,
    [SettingUniqueName.BindPhoneOrEmail] = System.fn(self, self.BindPhoneOrEmail)
  }
  self.confirmFuncMap = {
    [SettingUniqueName.LanguageWord] = System.fn(self, self.SetTextLanguageConfirm)
  }
  self.SettingRedFuncMap = {
    [SettingUniqueName.BindPhone] = System.fn(self, self.BindPhoneHasReward)
  }
end

function SettingManager:Init()
  self:InitMachineLevel()
  self:InitSetting()
  self:UpdateCSharpSettingData()
end

function SettingManager:GetConfirmFunc(settingUid)
  if not settingUid or not self.confirmFuncMap then
    return
  end
  return self.confirmFuncMap[settingUid]
end

function SettingManager:BindShortCut()
  ShortCutKeyManager.Instance:RegisterExtraDealFunc(System.fn(self, self.OnShortCut))
end

function SettingManager:ClickRedemptionCode(_, _, _)
  UIManager.Instance:Reopen(Urls.SettingRedemptionCodePanel)
end

function SettingManager:OpenUserCenter()
  SdkMgr.Instance:OpenUserCenter()
end

function SettingManager:BindPhoneOrEmail()
  SdkMgr.Instance:OpenBindPhoneOrEmail()
end

function SettingManager:OpenUserAgreement()
  SdkMgr.ShowUserAgreement()
end

function SettingManager:InitTextLanguage()
  local langCode = self:GetTextLanguage()
  local ignoreSave = true
  self:SetTextLanguage(langCode, ignoreSave)
end

function SettingManager:GetTextLanguage()
  local key = CommonDefine.LocalSaveKeyCommon.SystemSetting .. SettingUniqueName.LanguageWord .. "_val"
  local langCode = MobileFileDataManager.Instance:GetCommFileValue(key)
  if "ENAI" == langCode then
    langCode = "EN"
  end
  if not langCode then
    if SteamSdk.Instance:IsSteam() then
      langCode = SteamSdk.Instance:GetSteamLang()
    elseif ApplicationUtils.get_publish_region() == "JP" then
      langCode = "JP"
    end
    langCode = "JP"
  end
  if not langCode then
    local publishRegion = ApplicationUtils.get_publish_region()
    local tmpKey = "InitLanguageCode_TW"
    if publishRegion then
      tmpKey = "InitLanguageCode_" .. publishRegion
    end
    langCode = DT.GetConstant(tmpKey)
  end
  return langCode
end

function SettingManager:SetTextLanguage(langCode, ignoreSave)
  if nil == langCode then
    return
  end
  Logger.Info("设置当前游戏文字语言", langCode)
  SdkMgr.Instance:SetGameLangByLangCode(langCode)
  DataCenter.gameData.CurrTextLanguage = langCode
  Logger.Info("设置当前游戏文字语言成功", langCode)
  if ignoreSave then
    return
  end
  if not self:IsServerUseSetting(SettingUniqueName.LanguageWord) then
    local key = CommonDefine.LocalSaveKeyCommon.SystemSetting .. SettingUniqueName.LanguageWord .. "_val"
    MobileFileDataManager.Instance:SetCommFileValue(key, langCode)
    MobileFileDataManager.Instance:OnSaveCommInfo()
  end
end

function SettingManager:SetTextLanguageConfirm(langCode, callback)
  local function confirm()
    Main.DisableNextTick()
    
    if callback then
      callback()
    end
    self:SetTextLanguage(langCode)
    ApplicationUtils.ExitGame()
  end
  
  Alert.Show(10641, nil, confirm)
end

function SettingManager:InitServerUseSetting(svrData)
  self.serverSettingMap = svrData[1]
end

function SettingManager:UpdateServerUseSetting(tid, val)
  if not self.serverSettingMap then
    return
  end
  self.serverSettingMap[tid] = val
end

function SettingManager:GetServerUseSetting(tid)
  if not self.serverSettingMap then
    return nil
  end
  return self.serverSettingMap[tid]
end

function SettingManager:IsServerUseSetting(uniqueName)
  do return table.contains, serverUseSettingList end
  return table.contains, serverUseSettingList, uniqueName
end

function SettingManager:IsHardWareSetting(uName)
  local cfg = self:GetUNameCfg(uName)
  if cfg.SetupTab == cd.SettingTab.Image then
    return true
  end
  if cfg.SetupTab == cd.SettingTab.Voice then
    return true
  end
end

function SettingManager:SetGraphicQuality(_, newVal, rangeList)
  local targetQuality = "Low"
  for key, value in pairs(rangeList) do
    if value == newVal then
      targetQuality = value
      break
    end
  end
  for _, val in pairs(graphicSetting) do
    if val ~= SettingUniqueName.GraphicQuality and val ~= SettingUniqueName.Brightness then
      local setConfig = SetupDataUtils.GetCfgByUniqueName(val)
      if setConfig then
        local setVal = setConfig.LowImageQuality
        if "VeryLow" == targetQuality then
          setVal = setConfig.ExLowImageQuality
        elseif "Low" == targetQuality then
          setVal = setConfig.LowImageQuality
        elseif "Middle" == targetQuality then
          setVal = setConfig.MiddleImageQuality
        elseif "High" == targetQuality then
          setVal = setConfig.HighImageQuality
        elseif "VeryHigh" == targetQuality then
          setVal = setConfig.ExHighImageQuality
        end
        MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.SystemSetting .. val .. "_val", setVal)
        MobileFileDataManager.Instance:OnSaveCommInfo()
        self:EnableSetting(setConfig.ID)
      end
    end
  end
end

function SettingManager:SetParticleQuality(config, newVal, rangeList)
  rangeList = rangeList or SetupDataUtils.GetRangeList(config)
  local levelMap = {
    [1] = 0,
    [2] = 1,
    [3] = 2
  }
  local setVal = 0
  for key, val in pairs(rangeList) do
    if val == newVal then
      setVal = levelMap[key]
      break
    end
  end
  CS.ParticleQualityManager.SetQuality(setVal)
end

function SettingManager:SetTextureQuality(config, newVal, rangeList)
  rangeList = rangeList or SetupDataUtils.GetRangeList(config)
  local levelMap = {
    [1] = 1,
    [2] = 0
  }
  local setVal = 0
  for key, val in pairs(rangeList) do
    if val == newVal then
      setVal = levelMap[key]
      break
    end
  end
  CS.UnityEngine.QualitySettings.masterTextureLimit = setVal
end

function SettingManager:SetResolution(_, newVal)
  local targetHeight = self:_GetCacheScreenTargetHeight(newVal)
  local screenWidth, screenHeight
  if ScreenUtils.IsAlwaysFullScreen() then
    screenWidth = PerformanceManager.Instance.originScreenWidth
    screenHeight = PerformanceManager.Instance.originScreenHeight
  else
    screenWidth, screenHeight = self:_GetWindowResolution()
  end
  PerformanceManager.Instance:ChangeScreenResolutionByHeight(targetHeight, screenWidth, screenHeight)
end

function SettingManager:_GetCacheScreenTargetHeight(nowVal)
  if CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsPlayer then
    return 1080
  end
  local cfg = SetupDataUtils.GetCfgByUniqueName(SettingUniqueName.Resolution)
  nowVal = nowVal or MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.SystemSetting .. cfg.UniqueName .. "_val")
  local rangeList = SetupDataUtils.GetRangeList(cfg)
  local functionValue = cfg.FunctionValue_1
  local levelList = {}
  while string.find(functionValue, "P") do
    local tailIdx = string.find(functionValue, "P")
    local subStr = string.sub(functionValue, 1, tailIdx - 1)
    functionValue = string.sub(functionValue, tailIdx + 2, #functionValue)
    table.insert(levelList, tonumber(subStr))
  end
  local targetHeight = 720
  for key, value in pairs(rangeList) do
    if value == nowVal then
      targetHeight = levelList[key]
      break
    end
  end
  return targetHeight
end

function SettingManager:SetFPSLimit(_, newVal, _)
  Logger.ForcePrint("SetFPSLimit==", newVal, debug.traceback())
  newVal = newVal or self:GetLocalSaveValue(SettingUniqueName.FPSLimit)
  newVal = newVal or 30
  PerformanceManager.Instance:ChangeMaxFPS(newVal)
end

function SettingManager:SetBloom(_, newVal)
  local newState = self:GetBoolSettingData(CommonDefine.SettingUniqueName.Bloom)
  local volume = CS.UnityEngine.GameObject.Find("Volume")
  if not volume then
    return
  end
  local volumeObj = volume:GetComponent(typeof(CS.UnityEngine.Rendering.Volume))
  local effect = CS.Framework.UIUtilTool.GetBloom(volumeObj.profile)
  if effect then
    effect.active = newState
  end
end

function SettingManager:SetOutline(_, newVal)
end

function SettingManager:SetDepthOfField(_, newVal)
  local newState = self:GetBoolSettingData(CommonDefine.SettingUniqueName.DepthOfField)
  local volume = CS.UnityEngine.GameObject.Find("Volume")
  if not volume then
    return
  end
  local volumeObj = volume:GetComponent(typeof(CS.UnityEngine.Rendering.Volume))
  local effect = CS.Framework.UIUtilTool.GetDepthOfField(volumeObj.profile)
  if effect then
    effect.active = newState
  end
end

function SettingManager:SetChromaticAberration(_, newVal)
  local newState = self:GetBoolSettingData(CommonDefine.SettingUniqueName.ChromaticAberration)
  local volume = CS.UnityEngine.GameObject.Find("Volume")
  if not volume then
    return
  end
  local volumeObj = volume:GetComponent(typeof(CS.UnityEngine.Rendering.Volume))
  local effect = CS.Framework.UIUtilTool.GetChromaticAberration(volumeObj.profile)
  if effect then
    effect.active = newState
  end
end

function SettingManager:SetAntiAliasing(_, newVal)
  local setVal = self:GetBoolSettingData(CommonDefine.SettingUniqueName.AntiAliasing) and 2 or 1
  self.rpAsset.msaaSampleCount = setVal
end

function SettingManager:SetShadowmapResolution(config, newVal, rangeList)
  rangeList = rangeList or SetupDataUtils.GetRangeList(config)
  local functionValue = config.FunctionValue_1
  local levelList = {}
  local startIdx = string.find(functionValue, ":")
  functionValue = string.sub(functionValue, startIdx + 1, #functionValue)
  while string.find(functionValue, ",") do
    local tailIdx = string.find(functionValue, ",")
    local subStr = string.sub(functionValue, 1, tailIdx - 1)
    functionValue = string.sub(functionValue, tailIdx + 1, #functionValue)
    table.insert(levelList, tonumber(subStr))
  end
  table.insert(levelList, tonumber(functionValue))
  local setVal = 0
  for key, value in pairs(rangeList) do
    if value == newVal then
      setVal = levelList[key]
      break
    end
  end
  if 0 == setVal then
    self.settingManager.AdditionalLightCastShadows = false
  else
    self.settingManager.AdditionalLightCastShadows = true
    self.settingManager.AdditionalLightShadowResolution = setVal
  end
end

function SettingManager:SetWindowResolution(_, newVal)
  if not self._isInitWindowResolution then
    self._isInitWindowResolution = true
    return
  end
  self._isInitWindowResolution = true
  local width, height = self:_GetWindowResolution(newVal)
  self:SetSettingData(SettingUniqueName.WindowSetting, WindowID)
  self:SetSettingData(SettingUniqueName.WindowResolution, newVal)
  Logger.Info("SettingManager:SetWindowResolution ", width, height)
  ScreenUtils._SetResolution(width, height, false)
end

function SettingManager:SetWindowResolutionConfirm(newVal, callback)
  local function confirm()
    Main.DisableNextTick()
    
    if callback then
      callback()
    end
    local width, height = self:_GetWindowResolution(newVal)
    self:SaveResolution(width, height, self:IsFullScreen())
    self:SetWindowResolution(nil, newVal)
    ApplicationUtils.ExitGame()
  end
  
  Alert.Show(100001, nil, confirm)
end

function SettingManager:_GetWindowResolution(nowVal)
  nowVal = nowVal or MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.SystemSetting .. SettingUniqueName.WindowResolution .. "_val")
  if not nowVal then
    local screenWidth, screenHeight = CS.UnityEngine.Screen.width, CS.UnityEngine.Screen.height
    MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.SystemSetting .. SettingUniqueName.WindowResolution .. "_val", screenWidth .. "x" .. screenHeight)
    MobileFileDataManager.Instance:OnSaveCommInfo()
    return screenWidth, screenHeight
  end
  local width, height = string.match(nowVal, "(%d+)%D+(%d+)")
  width = tonumber(width)
  height = tonumber(height)
  if not width or not height then
    Logger.Error("SettingManager:_GetWindowResolution 分辨率格式无法解析: ", nowVal)
    return CS.UnityEngine.Screen.width, CS.UnityEngine.Screen.height
  end
  return width, height
end

function SettingManager:SetWindowSetting(_, newVal)
  newVal = newVal or MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.SystemSetting .. SettingUniqueName.WindowSetting .. "_val")
  local setVal
  if not newVal then
    local cacheVal = CS.UnityEngine.Screen.fullScreen and FullScreenID or WindowID
    MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.SystemSetting .. SettingUniqueName.WindowSetting .. "_val", cacheVal)
    MobileFileDataManager.Instance:OnSaveCommInfo()
    setVal = CS.UnityEngine.Screen.fullScreen
  elseif newVal == FullScreenID then
    setVal = true
  elseif newVal == WindowID then
    setVal = false
  end
  local width = CS.UnityEngine.Screen.width
  local height = CS.UnityEngine.Screen.height
  if setVal then
    width = CS.UnityEngine.Screen.currentResolution.width
    height = CS.UnityEngine.Screen.currentResolution.height
  elseif WindowsResolutionManager.Instance then
    width = WindowsResolutionManager.Instance:GetScreenWidth()
    height = WindowsResolutionManager.Instance:GetScreenHeight()
  end
  Logger.Info("SettingManager:SetWindowSetting newVal setVal ", newVal, setVal)
  ScreenUtils._SetResolution(width, height, setVal)
end

function SettingManager:SetDisplayShortcutKey()
  local uName = cd.SettingUniqueName.DisplayShortcutKey
  DataCenter.gameData.IsShowShortCut = self:GetBoolSettingData(uName)
end

function SettingManager:SetScenesEffects(_, newVal)
  if not SceneMgr.Instance then
    return
  end
  local setVal = self:GetBoolSettingData(CommonDefine.SettingUniqueName.ScenesEffects)
  if SceneMgr.Instance:IsInBattle() then
    local scenesEffectsObj = CS.UnityEngine.GameObject.Find("SceneEffects")
    if scenesEffectsObj then
      self.scenesEffectsObj = scenesEffectsObj
    end
    if self.scenesEffectsObj and not _IsNull(self.scenesEffectsObj) then
      self.scenesEffectsObj:SetActive(setVal)
    end
  else
    local mScenesEffectsObj = CS.UnityEngine.GameObject.Find("SceneEffects_M")
    if mScenesEffectsObj then
      self.mScenesEffectsObj = mScenesEffectsObj
    end
    if self.mScenesEffectsObj and not _IsNull(self.mScenesEffectsObj) then
      self.mScenesEffectsObj:SetActive(setVal)
    end
  end
end

function SettingManager:UseSoftMask(_, newVal)
  local setVal = self:GetBoolSettingData(CommonDefine.SettingUniqueName.UseSoftMask)
  local SoftMaskCtrl = CS.SoftMaskCtrl
  if SoftMaskCtrl then
    setVal = false
    SoftMaskCtrl.EnableSoftMask(setVal)
    if not setVal then
      return
    end
    local panelList = UIManager.Instance.panelList
    if not panelList then
      return
    end
    for _, v in pairs(panelList) do
      if v.ui and not IsNil(v.ui.uiNode) then
        SoftMaskCtrl.ApplySoftMaskCtrl(v.ui.uiNode)
      end
    end
  end
end

function SettingManager:CustomerService()
  SdkMgr.Instance.GetCustomerService()
end

function SettingManager:GyroscopeSwitch(_, newVal)
  local setVal = self:GetBoolSettingData(CommonDefine.SettingUniqueName.GyroscopeSwitch)
  GyroscopeManager.Instance:SwitchGyroscope(setVal, true)
end

function SettingManager:EnableRedByTab(tabList)
  for _, group in pairs(tabList or {}) do
    for _2, iData in ipairs(group.contents) do
      local redResult = self:EnableRed(iData.tid)
      if redResult then
        return redResult
      end
    end
  end
  return false
end

function SettingManager:EnableRed(tid)
  local config = DT.Setup[tid]
  local func = self.SettingRedFuncMap[config.UniqueName]
  if func then
    do return end
    return func
  else
    return false
  end
end

function SettingManager:BindPhone(_)
  local hasEmail = SdkMgr.Instance.model:HasEmail()
  local hasMobile = SdkMgr.Instance.model:HasMobile()
  if (hasEmail or hasMobile) and not DataCenter.gameData.BindPhoneReward then
    ProtoManager.Instance:ReqServer("SettingRequest", "ReqBindPhoneReward", function(_)
      DataCenter.gameData.BindPhoneReward = true
    end)
  else
    SdkMgr.Instance:OpenUserinfo(function(succ)
      if succ then
        LoginMgr.Instance:AcquireToken()
      end
    end)
  end
end

function SettingManager:BindPhoneHasReward(_)
  local hasEmail = SdkMgr.Instance.model:HasEmail()
  local hasMobile = SdkMgr.Instance.model:HasMobile()
  return hasEmail or hasMobile
end

function SettingManager:PlayPV()
  local settingPanel = UIManager.Instance:GetWindow(Urls.SettingMainPanel)
  settingPanel.ui.uiNode:SetActive(false)
  local storyId = DT.GetConstant("LoginScreenPV")
  AvgStoryManager.Instance:StartStoryById(storyId, nil, function()
    WorldStageManager.Instance:ReplayBGM()
    AudioManager.Instance:PostSoundEvent("MAININTERFACE_MUSIC")
  end, function()
    settingPanel.ui.uiNode:SetActive(true)
  end)
end

function SettingManager:LoginPVModify()
  UIManager.Instance:Reopen(Urls.ArtCollectionLoginPVModifyView)
end

function SettingManager:GetUNameCfg(uName)
  do return SetupDataUtils.GetCfgByUniqueName end
  return SetupDataUtils.GetCfgByUniqueName, uName
end

function SettingManager:GetBoolSettingData(settingUniqueName)
  local value = self:GetUNameValue(settingUniqueName)
  return 1 == value or "Open" == value
end

function SettingManager:GetSettingData(settingUniqueName)
  local value = self:GetUNameValue(settingUniqueName)
  return value
end

function SettingManager:GetLanguageSetting()
  local lang = ClientDataUtils.GetSubTable(cd.ClientDataMainKey.Language)
  do return table.next end
  return table.next, lang
end

function SettingManager:SetLanguageSetting(lang)
  ClientDataUtils.SetSubTable(cd.ClientDataMainKey, {lang = 1}, true)
end

function SettingManager:GetUNameValue(uName)
  local value = ClientDataUtils.GetData(cd.ClientDataMainKey.Setting, uName)
  if value then
    return value
  end
  if self:IsServerUseSetting(uName) then
    local cfg = self:GetUNameCfg(uName)
    local serverUseValue = self:GetServerUseSetting(cfg.ID)
    return serverUseValue
  end
  if self:IsHaveSettingRange(uName) then
    local tmpValue = self:GetRangeSetting(uName)
    if tmpValue then
      return tmpValue
    end
  end
  if self:IsShortCutSetting(uName) then
    do return self.GetShortCutByUName, self end
    return self.GetShortCutByUName, self, uName, cfg.ID
  end
  do return self.GetLocalSaveValue, self end
  return self.GetLocalSaveValue, self, uName, cfg.ID
end

function SettingManager:GetLocalSaveValue(uName)
  local key = string.format("%s%s_val", CommonDefine.LocalSaveKeyCommon.SystemSetting, uName)
  local value = MobileFileDataManager.Instance:GetCommFileValue(key)
  if not value then
    local setting = SetupDataUtils.GetCfgByUniqueName(uName)
    if not setting then
      return
    end
    if self.machineLevel == cd.MatchingLevel.Low then
      return setting.DefaultValueOfLowEquipment
    elseif self.machineLevel == cd.MatchingLevel.Middle then
      return setting.DefaultValueOfMiddleEquipment
    else
      return setting.DefaultValueOfHighEquipment
    end
  end
  return value
end

function SettingManager:SetSettingData(settingUniqueName, value)
  if self:IsServerUseSetting(settingUniqueName) then
    self:SetServerUseSettingData(settingUniqueName, value)
  end
  if self:IsHardWareSetting(settingUniqueName) then
    self:SetLocalSaveValue(settingUniqueName, value)
    return
  end
  if self:IsHaveSettingRange(settingUniqueName) then
    do return self.SaveRangeSetting, self, settingUniqueName end
    return self.SaveRangeSetting, self, settingUniqueName, value, nil
  end
  if self:IsShortCutSetting(settingUniqueName) then
    local cfg = self:GetUNameCfg(settingUniqueName)
    if cfg then
      self:SetNewShortCut(value, cfg.ID)
    end
    return
  end
  ClientDataUtils.SetData(cd.ClientDataMainKey.Setting, settingUniqueName, value, true)
end

function SettingManager:SetLocalSaveValue(settingUniqueName, value)
  local key = string.format("%s%s_val", CommonDefine.LocalSaveKeyCommon.SystemSetting, settingUniqueName)
  MobileFileDataManager.Instance:SetCommFileValue(key, value, true)
end

function SettingManager:SetServerUseSettingData(settingUniqueName, settingValue)
  local curValue = self:GetSettingData(settingUniqueName)
  local newServerValue = self:ConvertToServerUseValue(settingValue)
  if curValue ~= newServerValue then
    local cfg = self:GetUNameCfg(settingUniqueName)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "ChangeSetting", function(svrData)
      Logger.Debug("ChangeSetting Successful", table.tostring(svrData))
    end, function()
    end, cfg.ID, newServerValue)
    SettingManager.Instance:UpdateServerUseSetting(cfg.ID, newServerValue)
  end
end

function SettingManager:ConvertToServerUseValue(settingValue)
  return cd.SettingToServerUse[settingValue or cd.SettingValue.Close] or settingValue
end

function SettingManager:ConvertToSettingValue(serverUseValue)
  if not serverUseValue or 0 == serverUseValue then
    return cd.SettingValue.Close
  end
  return cd.SettingValue.Open
end

function SettingManager:_IsReverseSaving(uName)
end

function SettingManager:IsShortCutSetting(uName)
  local cfg = self:GetUNameCfg(uName)
  return cfg and cfg.ComponenType == cd.SettingItemType.BundleShortcutKey
end

function SettingManager:IsLanguageSetting(uName)
  return uName == cd.SettingUniqueName.LanguageWord
end

function SettingManager:IsHaveSettingRange(uName)
  local cfg = self:GetUNameCfg(uName)
  return cfg and cfg.Range
end

function SettingManager:GetRangeSetting(uName)
  local clientKey = cd.ClientDataMainKey.SettingRange .. uName
  local lang = ClientDataUtils.GetSubTable(clientKey)
  if not lang then
    return
  end
  do return table.next end
  return table.next, lang
end

function SettingManager:SaveRangeSetting(uName, value)
  local clientKey = cd.ClientDataMainKey.SettingRange .. uName
  ClientDataUtils.SetSubTable(clientKey, {
    [value] = 1
  }, true)
end

function SettingManager:UpdateCSharpSettingData()
  local localData = MobileFileDataManager.Instance.commFileInfo.data
  self.settingManager:LoadSettingData(localData)
end

function SettingManager:EnableSetting(tid, rangeList, isSingleSet)
  local config = DT.Setup[tid]
  if not SettingManager.Instance:CheckSetupEnable(config) then
    return
  end
  local newVal = self:GetUNameValue(config.UniqueName)
  if not self.SettingFuncMap[config.UniqueName] then
    return
  elseif type(self.SettingFuncMap[config.UniqueName]) == "function" then
    self.SettingFuncMap[config.UniqueName](config, newVal, rangeList, isSingleSet)
  end
  if isSingleSet then
    MobileFileDataManager.Instance:SetCommFileValue(CommonDefine.LocalSaveKeyCommon.SystemSetting .. SettingUniqueName.GraphicQuality .. "_val", "Custom")
    MobileFileDataManager.Instance:OnSaveCommInfo()
  end
  Logger.ReportApusInfo("EnableSetting:{uName} newVal:{newVal}", config.UniqueName, newVal)
  EventMgr.Instance.GraphicSetting:Dispatch()
  self:UpdateCSharpSettingData()
end

function SettingManager:InitSetting()
  for _, val in pairs(graphicSetting) do
    if val ~= SettingUniqueName.GraphicQuality and val ~= SettingUniqueName.Brightness then
      local setConfig = SetupDataUtils.GetCfgByUniqueName(val)
      if setConfig then
        self:EnableSetting(setConfig.ID)
      end
    end
  end
end

function SettingManager:ResetParticleSystemLights(obj)
  local setVal = self:GetBoolSettingData(CommonDefine.SettingUniqueName.RealTimeLight)
  local comps = obj:GetComponentsInChildren(typeof(CS.UnityEngine.Transform), true)
  for j = 1, comps.Length do
    local comp = comps:GetValue(j - 1)
    local lightComp = comp:GetComponent(typeof(CS.UnityEngine.Light))
    if lightComp then
      local particleSystem = comp.transform.parent.gameObject:GetComponent(typeof(CS.UnityEngine.ParticleSystem))
      if particleSystem then
        particleSystem.lights.enabled = setVal
      end
    end
  end
end

function SettingManager:ResetSceneEffects()
  local setVal = self:GetBoolSettingData(CommonDefine.SettingUniqueName.ScenesEffects)
  self:SetScenesEffects(nil, setVal)
end

function SettingManager:InitMachineLevel()
  if ApplicationUtils.is_editor_mode() or SdkMgr.Instance:IsSimulator() or ApplicationUtils.IsWindows() then
    self.machineLevel = CommonDefine.MatchingLevel.High
    return
  end
  if ApplicationUtils.IsIOS() then
    self.machineLevel = self:_GetMachineLevelSafety()
    return
  end
  local lowMiddleScore, middleHighScore
  if CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.Android then
    lowMiddleScore = DT.GetConstant("LowMiddleMachineScore")
    middleHighScore = DT.GetConstant("MiddleHighMachineScore")
  elseif CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.IPhonePlayer then
    lowMiddleScore = DT.GetConstant("LowMiddleIOSMachineScore")
    middleHighScore = DT.GetConstant("MiddleHighIOSMachineScore")
  end
  local retLevel
  local cpu = SdkMgr.Instance.model.machineCPUScore
  local gpu = SdkMgr.Instance.model.machineGPUScore
  Logger.Info("cpu ", cpu)
  Logger.Info("gpu ", gpu)
  if not (cpu and lowMiddleScore) or not middleHighScore then
    self.machineLevel = self:_GetMachineLevelSafety()
    return
  end
  if cpu < 0 then
    retLevel = self:_GetMachineLevelSafety()
  elseif lowMiddleScore > cpu then
    retLevel = CommonDefine.MatchingLevel.Low
  elseif lowMiddleScore <= cpu and middleHighScore > cpu then
    retLevel = CommonDefine.MatchingLevel.Middle
  else
    retLevel = CommonDefine.MatchingLevel.High
  end
  Logger.Info("Reset MachineLevel ", retLevel)
  self.machineLevel = retLevel
end

function SettingManager:_GetMachineLevelSafety()
  local SystemInfo = CS.UnityEngine.SystemInfo
  if not SystemInfo then
    return MACHINE_DEFAULT_LEVEL
  end
  if CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.Android then
    Logger.ForcePrint(string.format("processorFrequency: %s, processorCount: %s, systemMemorySize: %s, graphicsShaderLevel: %s", SystemInfo.processorFrequency, SystemInfo.processorCount, SystemInfo.systemMemorySize, SystemInfo.graphicsShaderLevel))
    if not (SystemInfo.processorCount and SystemInfo.systemMemorySize) or not SystemInfo.graphicsShaderLevel then
      return MACHINE_DEFAULT_LEVEL
    end
    if SystemInfo.processorCount > 7 and SystemInfo.systemMemorySize > 4000 then
      if SystemInfo.graphicsShaderLevel >= 60 then
        if SystemInfo.systemMemorySize > 6000 then
          return CommonDefine.MatchingLevel.High
        else
          return CommonDefine.MatchingLevel.Middle
        end
      elseif SystemInfo.graphicsShaderLevel >= 50 then
        return CommonDefine.MatchingLevel.Middle
      else
        return CommonDefine.MatchingLevel.Low
      end
    else
      return CommonDefine.MatchingLevel.Low
    end
  elseif CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.IPhonePlayer then
    local _deviceModel = SystemInfo.deviceModel or ""
    print("HardwareQuality deviceModel:", _deviceModel)
    if "iPhone14,7" == _deviceModel or "iPhone14,8" == _deviceModel then
      return CommonDefine.MatchingLevel.High
    end
    local iPhoneNumStr = string.match(_deviceModel, "iPhone(%d+)")
    if iPhoneNumStr then
      local iPhoneVersion = tonumber(iPhoneNumStr) or 0
      if iPhoneVersion >= 15 then
        return CommonDefine.MatchingLevel.High
      end
      if iPhoneVersion >= 13 then
        return CommonDefine.MatchingLevel.Middle
      end
    end
    local iPadNumStr = string.match(_deviceModel, "iPad(%d+)")
    if iPadNumStr then
      local iPadVersion = tonumber(iPadNumStr) or 0
      if iPadVersion >= 13 then
        return CommonDefine.MatchingLevel.High
      end
      if iPadVersion >= 11 then
        return CommonDefine.MatchingLevel.Middle
      end
    end
    return CommonDefine.MatchingLevel.Low
  end
  return MACHINE_DEFAULT_LEVEL
end

function SettingManager:OnShortCut(shortCutStrs)
  if self:_TryToggleFullScreenByShortCut(shortCutStrs) then
    return
  end
  local shortCuts = self:GetShortCuts()
  for tid, v in pairs(DT.Setup) do
    if v.SetupTab ~= cd.SettingTab.Key then
    elseif not self:CheckSetupEnable(v) then
    else
      local shortCut = self:GetShortCutByTid(tid, shortCuts)
      if shortCut and table.contains(shortCutStrs, shortCut) then
        EventMgr.Instance.SettingShortCut:Dispatch(v.UniqueName)
        if v.UniqueName == cd.SettingUniqueName.KeyShortName then
          LangManager.Instance:SwitchShowLangKey()
        end
      end
    end
  end
end

function SettingManager:_TryToggleFullScreenByShortCut(shortCutStrs)
  if not ApplicationUtils.IsWindowsOrEditor() then
    return false
  end
  if not shortCutStrs or not table.contains(shortCutStrs, "Alt+Enter") then
    return false
  end
  local settingCfg = SetupDataUtils.GetCfgByUniqueName(SettingUniqueName.WindowSetting)
  if not settingCfg or not self:CheckSetupEnable(settingCfg) then
    return false
  end
  local targetVal = self:IsFullScreen() and WindowID or FullScreenID
  self:SetSettingData(SettingUniqueName.WindowSetting, targetVal)
  self:EnableSetting(settingCfg.ID)
  return true
end

function SettingManager:GetShortCutByUName(uName)
  local setting = self:GetUNameCfg(uName)
  if setting and self:CheckSetupEnable(setting) then
    do return self.GetShortCutByTid, self end
    return self.GetShortCutByTid, self, setting.ID
  end
end

function SettingManager:GetShortCutByTid(tid, shortCuts)
  shortCuts = shortCuts or self:GetShortCuts()
  local setting = DT.Setup[tid] or {}
  local savedShortCut = shortCuts[tid]
  if savedShortCut then
    if "" == savedShortCut then
      return
    end
    return savedShortCut
  end
  local defaultKey = setting.PCDefaultShortcutKey
  if not defaultKey or "" == defaultKey then
    return
  end
  local owner = self:GetTidByShortCut(defaultKey, shortCuts)
  if owner and owner ~= tid then
    return
  end
  return defaultKey
end

function SettingManager:GetTidByShortCut(shortCut, shortCuts)
  if not shortCut then
    return
  end
  for tid, sc in pairs(shortCuts) do
    if sc == shortCut then
      return tid
    end
  end
  for tid, v in pairs(DT.Setup) do
    if not shortCuts[tid] and v.PCDefaultShortcutKey == shortCut then
      return tid
    end
  end
end

function SettingManager:GetShortCuts()
  local clientSaveData = ClientDataUtils.GetSubTable(cd.ClientDataMainKey.ShortCut)
  if clientSaveData then
    do return table.reverseKV end
    return table.reverseKV, clientSaveData, nil
  end
  return MobileFileDataManager.Instance:GetCommFileValue(cd.ClientDataMainKey.ShortCut) or {}
end

function SettingManager:SetNewShortCut(newShortCurKey, tid)
  local shortCuts = self:GetShortCuts()
  local oldTid = self:GetTidByShortCut(newShortCurKey, shortCuts)
  local oldShortCut = self:GetShortCutByTid(tid, shortCuts)
  if oldTid == tid then
    return
  end
  if oldTid then
    EventMgr.Instance.ShortCutChange:Dispatch(oldTid, SetupDataUtils.GetCfgByField("UniqueName", oldTid), oldShortCut)
    shortCuts[oldTid] = oldShortCut
  end
  shortCuts[tid] = newShortCurKey
  MobileFileDataManager.Instance:SetCommFileValue(cd.ClientDataMainKey.ShortCut, shortCuts, true)
  local clientSaveShortKeys = table.reverseKV(shortCuts)
  local clientSaveData = ClientDataUtils.GetSubTable(cd.ClientDataMainKey.ShortCut) or {}
  for k, v in pairs(clientSaveData) do
    if clientSaveShortKeys[k] then
      clientSaveData[k] = clientSaveShortKeys[k]
    else
      clientSaveData[k] = -1
    end
  end
  for k, v in pairs(clientSaveShortKeys) do
    clientSaveData[k] = v
  end
  ClientDataUtils.SetSubTable(cd.ClientDataMainKey.ShortCut, clientSaveData)
  EventMgr.Instance.ShortCutChange:Dispatch(tid, SetupDataUtils.GetCfgByField("UniqueName", tid), newShortCurKey)
end

function SettingManager:IsAutoFight()
  return 1 == ClientDataUtils.GetData(cd.ClientDataMainKey.Client, cd.ClientSubKey.AutoBattle)
end

function SettingManager:SetAutoFight(isAutoFight)
  ClientDataUtils.SetData(cd.ClientDataMainKey.Client, cd.ClientSubKey.AutoBattle, isAutoFight and 1 or 0)
end

function SettingManager:IsCloseBattleBgMovement()
  return not self:GetBoolSettingData(CommonDefine.SettingUniqueName.BattleDynamicBackground)
end

function SettingManager:ShowDownGame()
  if CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor then
    CS.UnityEditor.EditorApplication.isPlaying = false
    return
  end
  ApplicationUtils.ExitGame()
end

function SettingManager:CheckSetupEnable(cfg)
  local isPC = ApplicationUtils.IsWindowsOrEditor()
  local isSteam = SteamSdk.Instance:IsSteam()
  if cfg.PCEffect and not isPC then
    return false
  elseif cfg.PCBan and isPC then
    return false
  elseif cfg.SteamBan and isSteam then
    return false
  end
  if ApplicationUtils.is_tishen_pcode() and cfg.UniqueName == cd.SettingUniqueName.RedemptionCode and ApplicationUtils.IsIOS() then
    return false
  end
  if cfg.UniqueName == cd.SettingUniqueName.TranslationProgress and self:_CheckTranslationProgressBan() then
    return false
  end
  return true
end

function SettingManager:_CheckTranslationProgressBan()
  local currLang
  if DataCenter and DataCenter.gameData and DataCenter.gameData.CurrTextLanguage then
    currLang = DataCenter.gameData.CurrTextLanguage
  else
    currLang = self:GetTextLanguage()
  end
  if currLang == cd.Lang.CN or currLang == cd.Lang.TW then
    return true
  end
  return false
end

function SettingManager:SaveResolution(width, height, fullScreen)
  if ApplicationUtils.IsWindows() then
    local isFullScreen = fullScreen and 0 or 1
    ApplicationUtils.OnWriteGameFile(PersisSaveTxtFileName, tostring(width) .. "," .. tostring(height) .. "," .. tostring(isFullScreen))
  end
end

function SettingManager:IsFullScreen()
  if not ApplicationUtils.IsWindows() then
    return true
  end
  local newVal = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.SystemSetting .. SettingUniqueName.WindowSetting .. "_val")
  return newVal == FullScreenID
end

function SettingManager:OnDestroy()
end

function SettingManager:IsTranslationProgressEnabled(params)
  if self:_CheckTranslationProgressBan() then
    return false
  end
  if not self:GetBoolSettingData(CommonDefine.SettingUniqueName.TranslationProgress) then
    return false
  end
  if params.stageGroupTid then
    do return AvgTransProgressCfgUtils.IsStageGroupLocalized end
    return AvgTransProgressCfgUtils.IsStageGroupLocalized, params.stageGroupTid, CommonDefine.SettingUniqueName.TranslationProgress
  end
  if params.stageTid then
    do return AvgTransProgressCfgUtils.IsStageLocalized end
    return AvgTransProgressCfgUtils.IsStageLocalized, params.stageTid, CommonDefine.SettingUniqueName.TranslationProgress
  end
  return false
end

return SettingManager
