local BasePanel = require("GameCore.UI.BasePanel")
local DreamThemePanel = class("DreamThemePanel", BasePanel)
DreamThemePanel._sUIResRootPath = "UI_Activity/"
DreamThemePanel._tbDefine = {
  {
    sPrefabPath = "10102/DreamThemePanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10102.DreamThemeCtrl"
  }
}

function DreamThemePanel:Awake()
end

function DreamThemePanel:OnEnable()
end

function DreamThemePanel:OnDisable()
end

function DreamThemePanel:OnDestroy()
end

function DreamThemePanel:OnRelease()
end

return DreamThemePanel
