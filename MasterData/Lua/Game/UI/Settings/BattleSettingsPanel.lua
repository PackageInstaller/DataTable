local BattleSettingsPanel = class("BattleSettingsPanel", BasePanel)
BattleSettingsPanel._bIsMainPanel = false
local LocalSettingData = require("GameCore.Data.LocalSettingData")
BattleSettingsPanel._tbDefine = {
  {
    sPrefabPath = "Settings/BattleSettingsPanel.prefab",
    sCtrlName = "Game.UI.Settings.BattleSettingsCtrl"
  }
}

function BattleSettingsPanel:LoadLocalData(key)
  return LocalSettingData.GetLocalSettingData(key)
end

function BattleSettingsPanel:SaveLocalData(subKey, value)
  LocalSettingData.SetLocalSettingData(subKey, value)
end

function BattleSettingsPanel:Awake()
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

function BattleSettingsPanel:OnEnable()
end

function BattleSettingsPanel:OnDisable()
end

function BattleSettingsPanel:OnDestroy()
end

return BattleSettingsPanel
