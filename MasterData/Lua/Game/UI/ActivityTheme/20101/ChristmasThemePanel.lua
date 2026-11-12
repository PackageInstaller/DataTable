local BasePanel = require("GameCore.UI.BasePanel")
local ChristmasThemePanel = class("ChristmasThemePanel", BasePanel)
ChristmasThemePanel._sUIResRootPath = "UI_Activity/"
ChristmasThemePanel._tbDefine = {
  {
    sPrefabPath = "20101/ChristmasThemePanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.20101.ChristmasThemeCtrl"
  }
}

function ChristmasThemePanel:Awake()
end

function ChristmasThemePanel:OnEnable()
end

function ChristmasThemePanel:OnDisable()
end

function ChristmasThemePanel:OnDestroy()
end

function ChristmasThemePanel:OnRelease()
end

return ChristmasThemePanel
