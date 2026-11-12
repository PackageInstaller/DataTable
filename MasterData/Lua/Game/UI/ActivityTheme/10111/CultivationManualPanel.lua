local BasePanel = require("GameCore.UI.BasePanel")
local CultivationManualPanel = class("CultivationManualPanel", BasePanel)
CultivationManualPanel._sUIResRootPath = "UI_Activity/"
CultivationManualPanel._tbDefine = {
  {
    sPrefabPath = "10111/CultivationManualPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10111.CultivationManualCtrl"
  }
}

function CultivationManualPanel:Awake()
end

function CultivationManualPanel:OnEnable()
end

function CultivationManualPanel:OnDisable()
end

function CultivationManualPanel:OnDestroy()
end

function CultivationManualPanel:OnRelease()
end

return CultivationManualPanel
