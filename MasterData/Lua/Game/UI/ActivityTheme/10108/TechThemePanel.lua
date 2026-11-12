local BasePanel = require("GameCore.UI.BasePanel")
local TechThemePanel = class("TechThemePanel", BasePanel)
TechThemePanel._sUIResRootPath = "UI_Activity/"
TechThemePanel._tbDefine = {
  {
    sPrefabPath = "10108/TechPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10108.TechThemeCtrl"
  }
}

function TechThemePanel:Awake()
end

function TechThemePanel:OnEnable()
end

function TechThemePanel:OnDisable()
end

function TechThemePanel:OnDestroy()
end

function TechThemePanel:OnRelease()
end

return TechThemePanel
