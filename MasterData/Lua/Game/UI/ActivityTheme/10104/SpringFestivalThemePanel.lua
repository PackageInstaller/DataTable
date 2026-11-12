local BasePanel = require("GameCore.UI.BasePanel")
local SpringFestivalThemePanel = class("SpringFestivalThemePanel", BasePanel)
SpringFestivalThemePanel._sUIResRootPath = "UI_Activity/"
SpringFestivalThemePanel._tbDefine = {
  {
    sPrefabPath = "10104/SpringThemePanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10104.SpringFestivalThemeCtrl"
  }
}

function SpringFestivalThemePanel:Awake()
end

function SpringFestivalThemePanel:OnEnable()
end

function SpringFestivalThemePanel:OnDisable()
end

function SpringFestivalThemePanel:OnDestroy()
end

function SpringFestivalThemePanel:OnRelease()
end

return SpringFestivalThemePanel
