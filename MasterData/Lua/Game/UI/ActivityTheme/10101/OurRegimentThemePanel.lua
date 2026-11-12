local BasePanel = require("GameCore.UI.BasePanel")
local OurRegimentThemePanel = class("OurRegimentThemePanel", BasePanel)
OurRegimentThemePanel._sUIResRootPath = "UI_Activity/"
OurRegimentThemePanel._tbDefine = {
  {
    sPrefabPath = "10101/OurRegimentThemePanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10101.OurRegimentThemeCtrl"
  }
}

function OurRegimentThemePanel:Awake()
end

function OurRegimentThemePanel:OnEnable()
end

function OurRegimentThemePanel:OnDisable()
end

function OurRegimentThemePanel:OnDestroy()
end

function OurRegimentThemePanel:OnRelease()
end

return OurRegimentThemePanel
