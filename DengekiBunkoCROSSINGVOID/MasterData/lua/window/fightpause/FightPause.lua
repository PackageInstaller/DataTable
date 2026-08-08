local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local m_configDataManager = S:Get("ConfigDataManager")

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonExit, OnUIExit)
  REF.ButtonContinue["$SetCallback"](OnUIContinue)
  REF.Preset.UIToggleGroup:Init(OnPresetChanged)
end

function InitWindow()
  local preferences = m_configDataManager.GetPreferences()
  REF.Preset.UIToggleGroup.value = preferences.presetLevel
  REF.BgmSlider.UISlider.value = preferences.audioSetting.bgmVolume
  REF.SfxSlider.UISlider.value = preferences.audioSetting.sfxVolume
end

function OnPresetChanged(obj)
  local settings
  local presetLevel = REF.Preset.UIToggleGroup.value
  local isCustom = m_configDataManager.IsPresetCustom(presetLevel)
  if isCustom then
    settings = m_configDataManager.GetPreferences().customSettings
  else
    settings = m_configDataManager.GetPresetSettings(presetLevel)
  end
  if settings ~= nil then
    REF.Framerate.UIToggleGroup.value = settings.targetFramerate
    REF.Resolution.UIToggleGroup.value = settings.resolution
    REF.RoleQuality.UIToggleGroup.value = settings.roleQuality
    REF.ShadowQuality.UIToggleGroup.value = settings.shadowQuality
    REF.AntiAlias.UIToggleGroup.value = settings.antiAlias
    REF.PostEffect.UIToggleGroup.value = settings.postEffect
    REF.SceneEffect.UIToggleGroup.value = settings.sceneEffect
  end
  REF.Framerate.UIToggleGroup.enable = isCustom
  REF.Resolution.UIToggleGroup.enable = isCustom
  REF.RoleQuality.UIToggleGroup.enable = isCustom
  REF.ShadowQuality.UIToggleGroup.enable = isCustom
  REF.AntiAlias.UIToggleGroup.enable = isCustom
  REF.PostEffect.UIToggleGroup.enable = isCustom
  REF.SceneEffect.UIToggleGroup.enable = isCustom
end

function OnUIContinue(obj)
  local updateSetting = false
  local presetLevel = REF.Preset.UIToggleGroup.value
  local preferences = m_configDataManager.GetPreferences()
  preferences.presetLevel = presetLevel
  if m_configDataManager.IsPresetCustom(presetLevel) then
    preferences.customSettings = {
      resolution = REF.Resolution.UIToggleGroup.value,
      roleQuality = REF.RoleQuality.UIToggleGroup.value,
      shadowQuality = REF.ShadowQuality.UIToggleGroup.value,
      antiAlias = REF.AntiAlias.UIToggleGroup.value,
      postEffect = REF.PostEffect.UIToggleGroup.value,
      sceneEffect = REF.SceneEffect.UIToggleGroup.value
    }
  end
  preferences.fpsControl = true
  local val = REF.Framerate.UIToggleGroup.value
  if val ~= 0 then
    preferences.fpsControl = false
  end
  preferences.audioSetting = {
    bgmVolume = REF.BgmSlider.UISlider.value,
    sfxVolume = REF.SfxSlider.UISlider.value
  }
  m_configDataManager.SetPreferences(preferences)
  local sceneFight = CS.SceneFight.Instance
  if sceneFight ~= nil then
    sceneFight:PauseGame(false)
  end
  this:BroadcastGameEvent("OnFightGamePause")
  WU.RecycleWindow(this)
end

function OnUIExit(obj)
  this:SetData("FightDataRecord", nil)
  CS.FightBase.Instance:LeaveGameLua("")
end
