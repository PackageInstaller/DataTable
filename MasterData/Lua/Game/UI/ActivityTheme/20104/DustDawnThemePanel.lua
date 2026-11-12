local BasePanel = require("GameCore.UI.BasePanel")
local DustDawnThemePanel = class("DustDawnThemePanel", BasePanel)
DustDawnThemePanel._sUIResRootPath = "UI_Activity/"
DustDawnThemePanel._tbDefine = {
  {
    sPrefabPath = "20104/DustDawnPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.20104.DustDawnThemeCtrl"
  }
}

function DustDawnThemePanel:Awake()
end

function DustDawnThemePanel:OnEnable()
end

function DustDawnThemePanel:OnDisable()
end

function DustDawnThemePanel:OnDestroy()
end

function DustDawnThemePanel:OnRelease()
end

return DustDawnThemePanel
