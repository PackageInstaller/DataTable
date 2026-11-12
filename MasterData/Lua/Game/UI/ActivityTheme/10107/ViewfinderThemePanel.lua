local BasePanel = require("GameCore.UI.BasePanel")
local ViewfinderThemePanel = class("ViewfinderThemePanel", BasePanel)
ViewfinderThemePanel._sUIResRootPath = "UI_Activity/"
ViewfinderThemePanel._tbDefine = {
  {
    sPrefabPath = "10107/ViewfinderPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10107.ViewfinderThemeCtrl"
  }
}

function ViewfinderThemePanel:Awake()
end

function ViewfinderThemePanel:OnEnable()
end

function ViewfinderThemePanel:OnDisable()
end

function ViewfinderThemePanel:OnDestroy()
end

function ViewfinderThemePanel:OnRelease()
end

return ViewfinderThemePanel
