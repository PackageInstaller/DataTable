local SettingsGraphicCtrl = class("SettingsGraphicCtrl", BaseCtrl)
local ModuleManager = require("GameCore.Module.ModuleManager")
local GameRenderingSettingManager = CS.GameRenderingSettingManager
local UIGameSystemSetup = CS.UIGameSystemSetup
local GraphicQualityLevelEnum = {
  GameRenderingSettingManager.QualityLevel.Low,
  GameRenderingSettingManager.QualityLevel.Medium,
  GameRenderingSettingManager.QualityLevel.High
}
local GraphicOptionIndex = {
  ResolutionRatio = 1,
  FrameRate = 2,
  ShadingQuality = 3,
  LightShadow = 4,
  AntAliasing = 5
}
SettingsGraphicCtrl._mapNodeConfig = {
  txtPageTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Display"
  },
  txtShadingQuality = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Display_ShadingQuality"
  },
  txtWindowResolution = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Display_WindowResolution"
  },
  btnWindowResolution = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_WindowResolution"
  },
  imgResolutionGray = {},
  txtResolutionValue = {nCount = 2, sComponentName = "TMP_Text"},
  Screen = {
    sCtrlName = "Game.UI.Settings.OptionUpdateChooseCtrl"
  },
  WindowResolution = {},
  L2dSwitch = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  VsyncSwitch = {
    sCtrlName = "Game.UI.Settings.OptionSwitchCtrl"
  },
  ShadingQuality = {
    sCtrlName = "Game.UI.Settings.OptionChooseCtrl"
  },
  ResolutionRatio = {
    sCtrlName = "Game.UI.Settings.OptionChooseCtrl"
  },
  FrameRate = {
    sCtrlName = "Game.UI.Settings.OptionChooseCtrl"
  },
  Shadow = {
    sCtrlName = "Game.UI.Settings.OptionChooseCtrl"
  },
  AntAliasing = {
    sCtrlName = "Game.UI.Settings.OptionChooseCtrl"
  },
  txtWidescreen = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Display_Widescreen"
  },
  txtBtnWidescreen = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Btn_Go"
  },
  btnWidescreen = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Widescreen"
  }
}
SettingsGraphicCtrl._mapEventConfig = {
  SettingsSetResolution = "OnEvent_SetResolution"
}

function SettingsGraphicCtrl:RefreshText()
  if not NovaAPI.IsMobilePlatform() then
    self._mapNode.Screen:SetText(ConfigTable.GetUIText("Settings_Display_Screen_Full"), ConfigTable.GetUIText("Settings_Display_Screen_Window"), nil, ConfigTable.GetUIText("Settings_Display_Screen"))
  end
  self._mapNode.L2dSwitch:SetText(ConfigTable.GetUIText("Settings_L2d"))
  self._mapNode.ShadingQuality:SetText(ConfigTable.GetUIText("Settings_Display_ShadingQuality_Low"), ConfigTable.GetUIText("Settings_Display_ShadingQuality_Medium"), ConfigTable.GetUIText("Settings_Display_ShadingQuality_High"), ConfigTable.GetUIText("Settings_Display_ShadingQuality"))
  if NovaAPI.IsMobilePlatform() then
    self._mapNode.ResolutionRatio:SetText(ConfigTable.GetUIText("Settings_Display_ResolutionRatio_Low"), ConfigTable.GetUIText("Settings_Display_ResolutionRatio_Medium"), ConfigTable.GetUIText("Settings_Display_ResolutionRatio_High"), ConfigTable.GetUIText("Settings_Display_ResolutionRatio"))
  end
  self._mapNode.FrameRate:SetText(ConfigTable.GetUIText("Settings_Display_FrameRate_Low"), ConfigTable.GetUIText("Settings_Display_FrameRate_Medium"), ConfigTable.GetUIText("Settings_Display_FrameRate_High"), ConfigTable.GetUIText("Settings_Display_FrameRate"))
  self._mapNode.Shadow:SetText(ConfigTable.GetUIText("Settings_Display_Shadow_Low"), ConfigTable.GetUIText("Settings_Display_Shadow_Medium"), ConfigTable.GetUIText("Settings_Display_Shadow_High"), ConfigTable.GetUIText("Settings_Display_Shadow"))
  self._mapNode.AntAliasing:SetText(ConfigTable.GetUIText("Settings_Display_AntAliasing_Low"), ConfigTable.GetUIText("Settings_Display_AntAliasing_Medium"), ConfigTable.GetUIText("Settings_Display_AntAliasing_High"), ConfigTable.GetUIText("Settings_Display_AntAliasing"))
  if not NovaAPI.IsMobilePlatform() then
    self._mapNode.VsyncSwitch:SetText(ConfigTable.GetUIText("Settings_Vsync"))
  end
end

function SettingsGraphicCtrl:Init()
  if self.bInit then
    return
  end
  self.bInit = true
  self:LoadSetting()
end

function SettingsGraphicCtrl:Quit()
  if not self.bInit then
    return
  end
end

function SettingsGraphicCtrl:LoadSetting()
  self.optionLevelIndex = {}
  if NovaAPI.IsMobilePlatform() then
    self.optionLevelIndex[GraphicOptionIndex.ResolutionRatio] = 1
  end
  self.optionLevelIndex[GraphicOptionIndex.FrameRate] = 1
  self.optionLevelIndex[GraphicOptionIndex.ShadingQuality] = 1
  self.optionLevelIndex[GraphicOptionIndex.LightShadow] = 1
  self.optionLevelIndex[GraphicOptionIndex.AntAliasing] = 1
  for i = 1, #GraphicQualityLevelEnum do
    if NovaAPI.IsMobilePlatform() and GameRenderingSettingManager.Instance.resolutionScaleQualityTier == GraphicQualityLevelEnum[i] then
      self.optionLevelIndex[GraphicOptionIndex.ResolutionRatio] = i
      self._mapNode.ResolutionRatio:Init(function(index)
        GameRenderingSettingManager.Instance.resolutionScaleQualityTier = GraphicQualityLevelEnum[index]
        self.optionLevelIndex[GraphicOptionIndex.ResolutionRatio] = index
        EventManager.Hit(EventId.MarkFullRectWH)
      end, i)
    end
    if GameRenderingSettingManager.Instance.frameRateQualityTier == GraphicQualityLevelEnum[i] then
      self.optionLevelIndex[GraphicOptionIndex.FrameRate] = i
      self._mapNode.FrameRate:Init(function(index)
        GameRenderingSettingManager.Instance.frameRateQualityTier = GraphicQualityLevelEnum[index]
        self.optionLevelIndex[GraphicOptionIndex.FrameRate] = index
      end, i)
    end
    if GameRenderingSettingManager.Instance.shadingQualityTier == GraphicQualityLevelEnum[i] then
      self.optionLevelIndex[GraphicOptionIndex.ShadingQuality] = i
      self._mapNode.ShadingQuality:Init(function(index)
        GameRenderingSettingManager.Instance.shadingQualityTier = GraphicQualityLevelEnum[index]
        self.optionLevelIndex[GraphicOptionIndex.ShadingQuality] = index
      end, i)
    end
    if GameRenderingSettingManager.Instance.lightShadowQualityTier == GraphicQualityLevelEnum[i] then
      self.optionLevelIndex[GraphicOptionIndex.LightShadow] = i
      self._mapNode.Shadow:Init(function(index)
        GameRenderingSettingManager.Instance.lightShadowQualityTier = GraphicQualityLevelEnum[index]
        self.optionLevelIndex[GraphicOptionIndex.LightShadow] = index
      end, i)
    end
    if GameRenderingSettingManager.Instance.antialiasingQualityTier == GraphicQualityLevelEnum[i] then
      self.optionLevelIndex[GraphicOptionIndex.AntAliasing] = i
      self._mapNode.AntAliasing:Init(function(index)
        GameRenderingSettingManager.Instance.antialiasingQualityTier = GraphicQualityLevelEnum[index]
        self.optionLevelIndex[GraphicOptionIndex.AntAliasing] = index
      end, i)
    end
  end
  if not NovaAPI.IsMobilePlatform() then
    self.nScreen = GameRenderingSettingManager.Instance:IsFullScreen() and 1 or 2
    self:RefreshScreen()
    self.timer = self:AddTimer(0, 0.034, function()
      self.nScreen = GameRenderingSettingManager.Instance:IsFullScreen() and 1 or 2
      if self.nBeforeScreen ~= self.nScreen then
        self:ForceChange1080p(self.nBeforeScreen, self.nScreen)
        self:RefreshScreen()
      end
    end, true, true, true)
    self.nResolution = GameRenderingSettingManager.Instance:GetCurrentResolutionIndex() + 1
    self:ChangeWindowResolution(self.nResolution)
  end
  self.bUseLive2D = self._panel:LoadLocalData("UseLive2D")
  self._mapNode.L2dSwitch:Init(function()
    self.bUseLive2D = not self.bUseLive2D
    EventManager.Hit("SettingsChangeL2d", self.bUseLive2D)
    self._panel:SaveLocalData("UseLive2D", self.bUseLive2D)
  end, self.bUseLive2D)
  if not NovaAPI.IsMobilePlatform() then
    self.bVsync = GameRenderingSettingManager.Instance.vSyncEnabled
    self._mapNode.VsyncSwitch:Init(function()
      self.bVsync = not self.bVsync
      GameRenderingSettingManager.Instance.vSyncEnabled = self.bVsync
    end, self.bVsync)
  end
end

function SettingsGraphicCtrl:SaveSetting()
  GameRenderingSettingManager.Instance:SaveSetting()
end

function SettingsGraphicCtrl:ChangeWindowResolution(nIndex)
  if nIndex then
    for i = 1, 2 do
      NovaAPI.SetTMPText(self._mapNode.txtResolutionValue[i], self.tbResolution[nIndex])
    end
  end
end

function SettingsGraphicCtrl:RefreshScreen()
  self._mapNode.Screen:Init(function(index, callback)
    GameRenderingSettingManager.Instance:SetScreenResolution(self.nResolution - 1, index == 1)
    local nCur = GameRenderingSettingManager.Instance:IsFullScreen() and 1 or 2
    if nCur == index then
      callback()
      self.nBeforeScreen = self.nScreen
      self.nScreen = index
      self:ForceChange1080p(self.nBeforeScreen, index)
    end
  end, self.nScreen, 2)
  self.nBeforeScreen = self.nScreen
end

function SettingsGraphicCtrl:ForceChange1080p(nBefore, nAfter)
  if nBefore == 1 and nAfter == 2 then
    local nCount = #self.tbResolution
    local nMax = nCount
    for i = 1, nMax do
      if string.find(self.tbResolution[i], "1920") then
        EventManager.Hit("SettingsSetResolution", i)
        return
      end
    end
  end
end

function SettingsGraphicCtrl:Awake()
  self.bInit = false
  local bMobile = NovaAPI.IsMobilePlatform()
  self._mapNode.Screen.gameObject:SetActive(not bMobile)
  self._mapNode.WindowResolution.gameObject:SetActive(not bMobile)
  self._mapNode.ResolutionRatio.gameObject:SetActive(bMobile)
  self._mapNode.VsyncSwitch.gameObject:SetActive(not bMobile)
  if not bMobile then
    local tbSupport = GameRenderingSettingManager.Instance:GetSupportScreenResolutions()
    self.tbResolution = {}
    for i = 0, tbSupport.Length - 1 do
      table.insert(self.tbResolution, tbSupport[i].x .. "×" .. tbSupport[i].y)
    end
  end
  self:RefreshText()
end

function SettingsGraphicCtrl:OnEnable()
end

function SettingsGraphicCtrl:OnDisable()
  if not self.bInit then
    return
  end
  self:SaveSetting()
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
end

function SettingsGraphicCtrl:OnDestroy()
end

function SettingsGraphicCtrl:OnBtnClick_WindowResolution()
  if next(self.tbResolution) == nil then
    return
  end
  EventManager.Hit("SettingsResolution", self.nResolution, self.tbResolution)
end

function SettingsGraphicCtrl:OnEvent_SetResolution(nIndex)
  self.nResolution = nIndex
  GameRenderingSettingManager.Instance:SetScreenResolution(self.nResolution - 1, self.nScreen == 1)
  self:ChangeWindowResolution(self.nResolution)
end

function SettingsGraphicCtrl:OnBtnClick_Widescreen()
  if ModuleManager.GetIsAdventure() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Settings_Widescreen_BattleUnable"))
  elseif Settings.CURRENT_CANVAS_FULL_RECT_WIDTH / Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT <= 2 then
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("Settings_Widescreen_ScreenUnable"),
      callbackConfirm = function()
        EventManager.Hit(EventId.OpenPanel, PanelId.SettingsPreview)
      end,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  else
    EventManager.Hit(EventId.OpenPanel, PanelId.SettingsPreview)
  end
end

return SettingsGraphicCtrl
