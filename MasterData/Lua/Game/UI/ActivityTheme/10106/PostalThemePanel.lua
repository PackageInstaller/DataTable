local BasePanel = require("GameCore.UI.BasePanel")
local PostalThemePanel = class("PostalThemePanel", BasePanel)
PostalThemePanel._sUIResRootPath = "UI_Activity/"
PostalThemePanel._tbDefine = {
  {
    sPrefabPath = "10106/PostalPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10106.PostalThemeCtrl"
  }
}

function PostalThemePanel:Awake()
end

function PostalThemePanel:OnEnable()
end

function PostalThemePanel:OnDisable()
end

function PostalThemePanel:OnDestroy()
end

function PostalThemePanel:OnRelease()
end

return PostalThemePanel
