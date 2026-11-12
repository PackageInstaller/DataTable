local BasePanel = require("GameCore.UI.BasePanel")
local SummerAdvPanel = class("SummerAdvPanel", BasePanel)
SummerAdvPanel._sUIResRootPath = "UI_Activity/"
SummerAdvPanel._tbDefine = {
  {
    sPrefabPath = "10110/SummerAdvPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10110.SummerAdvCtrl"
  }
}

function SummerAdvPanel:Awake()
end

function SummerAdvPanel:OnEnable()
end

function SummerAdvPanel:OnDisable()
end

function SummerAdvPanel:OnDestroy()
end

function SummerAdvPanel:OnRelease()
end

return SummerAdvPanel
