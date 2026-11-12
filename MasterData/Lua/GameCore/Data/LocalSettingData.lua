local LocalSettingData = {}
local LocalData = require("GameCore.Data.LocalData")
local WwiseManger = CS.WwiseAudioManager
local UIGameSystemSetup = CS.UIGameSystemSetup
local DefaultSoundValue = 100

local function LoadLocalData(key, defaultValue)
  local value = LocalData.GetLocalData("GameSystemSettingsData", key)
  if value ~= nil then
    return value
  else
    return defaultValue
  end
end

local function InitCurSignInData()
  LocalData.DelLocalData("UpgradeMat", "Presents")
  LocalData.DelLocalData("UpgradeMat", "Outfit")
end

local function LoadSoundData()
  LocalSettingData.mapData.NumMusic = LoadLocalData("NumMusic", DefaultSoundValue)
  LocalSettingData.mapData.OpenMusic = LoadLocalData("OpenMusic", true)
  LocalSettingData.mapData.NumSfx = LoadLocalData("NumSfx", DefaultSoundValue)
  LocalSettingData.mapData.OpenSfx = LoadLocalData("OpenSfx", true)
  LocalSettingData.mapData.NumChar = LoadLocalData("NumChar", DefaultSoundValue)
  LocalSettingData.mapData.OpenChar = LoadLocalData("OpenChar", true)
  LocalSettingData.mapData.WwiseMuteInBackground = LoadLocalData("WwiseMuteInBackground", true)
end

local function LoadBattleData()
  LocalSettingData.mapData.Animation = LoadLocalData("Animation", AllEnum.BattleAnimSetting.DayOnce)
  if LocalSettingData.mapData.Animation == 1 then
    UIGameSystemSetup.Instance.PlayType = UIGameSystemSetup.TimeLinePlayType.dayOnce
  elseif LocalSettingData.mapData.Animation == 2 then
    UIGameSystemSetup.Instance.PlayType = UIGameSystemSetup.TimeLinePlayType.everyTime
  elseif LocalSettingData.mapData.Animation == 3 then
    UIGameSystemSetup.Instance.PlayType = UIGameSystemSetup.TimeLinePlayType.none
  end
  LocalSettingData.mapData.AnimationSub = LoadLocalData("AnimationSub", AllEnum.BattleAnimSetting.DayOnce)
  if not NovaAPI.IsMobilePlatform() then
    LocalSettingData.mapData.Mouse = LoadLocalData("Mouse", false)
    UIGameSystemSetup.Instance.EnableMouseInputDir = LocalSettingData.mapData.Mouse
  end
  LocalSettingData.mapData.JoyStick = LoadLocalData("JoyStick", true)
  UIGameSystemSetup.Instance.EnableFloatingJoyStick = LocalSettingData.mapData.JoyStick
  LocalSettingData.mapData.Gizmos = LoadLocalData("Gizmos", true)
  UIGameSystemSetup.Instance.EnableAttackGizmos = LocalSettingData.mapData.Gizmos
  LocalSettingData.mapData.AutoUlt = LoadLocalData("AutoUlt", true)
  UIGameSystemSetup.Instance.EnableAutoUlt = LocalSettingData.mapData.AutoUlt
  if not NovaAPI.IsMobilePlatform() then
    LocalSettingData.mapData.BattleHUD = LoadLocalData("BattleHUD", AllEnum.BattleHudType.Horizontal)
  else
    LocalSettingData.mapData.BattleHUD = LoadLocalData("BattleHUD", AllEnum.BattleHudType.Sector)
  end
  LocalSettingData.mapData.HudDamageShow = LoadLocalData("HudDamageShow", AllEnum.BattleHudDamageSetting.Default)
end

local function LoadNotificationData()
  LocalSettingData.mapData.Notification = LoadLocalData("NotificationFirst", true)
  LocalSettingData.mapData.Energy = LoadLocalData("Energy", true)
  LocalSettingData.mapData.Dispatch = LoadLocalData("Dispatch", true)
end

function LocalSettingData.Init()
  LocalSettingData.mapData = {}
  LocalSettingData.mapData.UseLive2D = LoadLocalData("UseLive2D", true)
  LoadSoundData()
  LoadBattleData()
  InitCurSignInData()
  LoadNotificationData()
end

function LocalSettingData.GetLocalSettingData(subKey)
  return LocalSettingData.mapData[subKey]
end

function LocalSettingData.SetLocalSettingData(subKey, value)
  if type(subKey) ~= "string" or value == nil then
    return
  end
  LocalData.SetLocalData("GameSystemSettingsData", subKey, value)
  LocalSettingData.mapData[subKey] = value
end

return LocalSettingData
