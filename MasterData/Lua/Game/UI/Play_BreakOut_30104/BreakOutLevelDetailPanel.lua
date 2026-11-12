local BasePanel = require("GameCore.UI.BasePanel")
local BreakOutLevelDetailPanel = class("BreakOutLevelDetailPanel", BasePanel)
BreakOutLevelDetailPanel._sUIResRootPath = "UI_Activity/"
BreakOutLevelDetailPanel._tbDefine = {
  {
    sPrefabPath = "30104/Play/BreakOutLevelDetailPanel.prefab",
    sCtrlName = "Game.UI.Play_BreakOut_30101.BreakOutLevelDetailCtrl"
  }
}

function BreakOutLevelDetailPanel:Awake()
end

function BreakOutLevelDetailPanel:OnEnable()
end

function BreakOutLevelDetailPanel:OnDisable()
end

function BreakOutLevelDetailPanel:OnDestroy()
end

function BreakOutLevelDetailPanel:OnRelease()
end

return BreakOutLevelDetailPanel
