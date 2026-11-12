local BasePanel = require("GameCore.UI.BasePanel")
local SwimTheme_11100Panel = class("SwimTheme_11100Panel", BasePanel)
SwimTheme_11100Panel._sUIResRootPath = "UI_Activity/"
SwimTheme_11100Panel._tbDefine = {
  {
    sPrefabPath = "11100/SwimThemePanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.11100.SwimTheme_11100Ctrl"
  }
}

function SwimTheme_11100Panel:Awake()
end

function SwimTheme_11100Panel:OnEnable()
end

function SwimTheme_11100Panel:OnDisable()
end

function SwimTheme_11100Panel:OnDestroy()
end

function SwimTheme_11100Panel:OnRelease()
end

return SwimTheme_11100Panel
