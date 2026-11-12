local BasePanel = require("GameCore.UI.BasePanel")
local SolodanceThemePanel = class("SolodanceThemePanel", BasePanel)
SolodanceThemePanel._sUIResRootPath = "UI_Activity/"
SolodanceThemePanel._tbDefine = {
  {
    sPrefabPath = "20102/SolodanceThemePanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.20102.SolodanceThemeCtrl"
  }
}

function SolodanceThemePanel:Awake()
end

function SolodanceThemePanel:OnEnable()
end

function SolodanceThemePanel:OnDisable()
end

function SolodanceThemePanel:OnDestroy()
end

function SolodanceThemePanel:OnRelease()
end

return SolodanceThemePanel
