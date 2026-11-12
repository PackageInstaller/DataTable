local BasePanel = require("GameCore.UI.BasePanel")
local SwimThemePanel = class("SwimThemePanel", BasePanel)
SwimThemePanel._sUIResRootPath = "UI_Activity/"
SwimThemePanel._tbDefine = {
  {
    sPrefabPath = "Swim/SwimThemePanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.Swim.SwimThemeCtrl"
  }
}

function SwimThemePanel:Awake()
end

function SwimThemePanel:OnEnable()
end

function SwimThemePanel:OnDisable()
end

function SwimThemePanel:OnDestroy()
end

function SwimThemePanel:OnRelease()
end

return SwimThemePanel
