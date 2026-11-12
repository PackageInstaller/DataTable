local BasePanel = require("GameCore.UI.BasePanel")
local MiracleThemePanel = class("MiracleThemePanel", BasePanel)
MiracleThemePanel._sUIResRootPath = "UI_Activity/"
MiracleThemePanel._tbDefine = {
  {
    sPrefabPath = "10103/MiracleThemePanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10103.MiracleThemeCtrl"
  }
}

function MiracleThemePanel:Awake()
end

function MiracleThemePanel:OnEnable()
end

function MiracleThemePanel:OnDisable()
end

function MiracleThemePanel:OnDestroy()
end

function MiracleThemePanel:OnRelease()
end

return MiracleThemePanel
