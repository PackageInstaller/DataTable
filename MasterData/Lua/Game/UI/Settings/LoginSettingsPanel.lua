local LoginSettingsPanel = class("LoginSettingsPanel", BasePanel)
LoginSettingsPanel._bAddToBackHistory = false
LoginSettingsPanel._nSnapshotPrePanel = 1
LoginSettingsPanel._bIsMainPanel = false
local LocalSettingData = require("GameCore.Data.LocalSettingData")
LoginSettingsPanel._tbDefine = {
  {
    sPrefabPath = "Settings/LoginSettingsPanel.prefab",
    sCtrlName = "Game.UI.Settings.LoginSettingsCtrl"
  }
}

function LoginSettingsPanel:LoadLocalData(key)
  return LocalSettingData.GetLocalSettingData(key)
end

function LoginSettingsPanel:SaveLocalData(subKey, value)
  LocalSettingData.SetLocalSettingData(subKey, value)
end

function LoginSettingsPanel:Awake()
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
  self.ShowUserCenter = false
end

function LoginSettingsPanel:OnEnable()
end

function LoginSettingsPanel:OnDisable()
end

function LoginSettingsPanel:OnDestroy()
end

return LoginSettingsPanel
