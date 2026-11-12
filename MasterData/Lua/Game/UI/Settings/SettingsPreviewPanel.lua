local SettingsPreviewPanel = class("SettingsPreviewPanel", BasePanel)
SettingsPreviewPanel._bIsMainPanel = false
local LocalSettingData = require("GameCore.Data.LocalSettingData")
SettingsPreviewPanel._tbDefine = {
  {
    sPrefabPath = "Settings/SettingsPreviewPanel.prefab",
    sCtrlName = "Game.UI.Settings.SettingsPreviewCtrl"
  }
}

function SettingsPreviewPanel:LoadLocalData(key)
  return LocalSettingData.GetLocalSettingData(key)
end

function SettingsPreviewPanel:SaveLocalData(subKey, value)
  LocalSettingData.SetLocalSettingData(subKey, value)
end

function SettingsPreviewPanel:Awake()
end

function SettingsPreviewPanel:OnEnable()
end

function SettingsPreviewPanel:OnDisable()
end

function SettingsPreviewPanel:OnDestroy()
end

return SettingsPreviewPanel
