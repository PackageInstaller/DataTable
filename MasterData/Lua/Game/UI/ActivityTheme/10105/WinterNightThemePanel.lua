local BasePanel = require("GameCore.UI.BasePanel")
local WinterNightThemePanel = class("WinterNightThemePanel", BasePanel)
WinterNightThemePanel._sUIResRootPath = "UI_Activity/"
WinterNightThemePanel._tbDefine = {
  {
    sPrefabPath = "10105/WinterNightPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10105.WinterNightThemeCtrl"
  }
}

function WinterNightThemePanel:Awake()
end

function WinterNightThemePanel:OnEnable()
end

function WinterNightThemePanel:OnDisable()
end

function WinterNightThemePanel:OnDestroy()
end

function WinterNightThemePanel:OnRelease()
end

return WinterNightThemePanel
