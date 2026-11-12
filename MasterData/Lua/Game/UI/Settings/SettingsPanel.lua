local SettingsPanel = class("SettingsPanel", BasePanel)
SettingsPanel._bAddToBackHistory = false
SettingsPanel._nSnapshotPrePanel = 1
local LocalSettingData = require("GameCore.Data.LocalSettingData")
SettingsPanel._tbDefine = {
  {
    sPrefabPath = "Settings/SettingsPanel.prefab",
    sCtrlName = "Game.UI.Settings.SettingsCtrl"
  }
}

function SettingsPanel:LoadLocalData(key)
  return LocalSettingData.GetLocalSettingData(key)
end

function SettingsPanel:SaveLocalData(subKey, value)
  LocalSettingData.SetLocalSettingData(subKey, value)
end

function SettingsPanel:Awake()
  self.mapKeyboardBind = {}
  self.mapGamepadBind = {}
  self.Action = {
    "Fire1",
    "Fire2",
    "Fire4",
    "Interactive",
    "ActorSwitch1",
    "ActorSwitch2",
    "SwitchWithUltra1",
    "SwitchWithUltra2"
  }
  self.Move = {
    "Up",
    "Down",
    "Left",
    "Right"
  }
  self.ControlType = {Gamepad = 0, Keyboard = 1}
end

function SettingsPanel:OnEnable()
end

function SettingsPanel:OnDisable()
end

function SettingsPanel:OnDestroy()
end

return SettingsPanel
