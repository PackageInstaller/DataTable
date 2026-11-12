local BasePanel = require("GameCore.UI.BasePanel")
local SummerCheckinThemePanel = class("SummerCheckinThemePanel", BasePanel)
SummerCheckinThemePanel._sUIResRootPath = "UI_Activity/"
SummerCheckinThemePanel._tbDefine = {
  {
    sPrefabPath = "20103/SummerCheckinPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.20103.SummerCheckinThemeCtrl"
  }
}

function SummerCheckinThemePanel:Awake()
end

function SummerCheckinThemePanel:OnEnable()
end

function SummerCheckinThemePanel:OnDisable()
end

function SummerCheckinThemePanel:OnDestroy()
end

function SummerCheckinThemePanel:OnRelease()
end

return SummerCheckinThemePanel
