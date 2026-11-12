local BasePanel = require("GameCore.UI.BasePanel")
local BreakOutThemePanel = class("BreakOutThemePanel", BasePanel)
BreakOutThemePanel._sUIResRootPath = "UI_Activity/"
BreakOutThemePanel._tbDefine = {
  {
    sPrefabPath = "30101/BreakOutThemePanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.30101.BreakOutThemeCtrl"
  }
}

function BreakOutThemePanel:Awake()
end

function BreakOutThemePanel:OnEnable()
end

function BreakOutThemePanel:OnDisable()
end

function BreakOutThemePanel:OnDestroy()
end

function BreakOutThemePanel:OnRelease()
end

return BreakOutThemePanel
