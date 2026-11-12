local BreakOutResultPanel = class("BreakOutResultPanel", BasePanel)
BreakOutResultPanel._nSnapshotPrePanel = 1
BreakOutResultPanel._sUIResRootPath = "UI_Activity/"
BreakOutResultPanel._tbDefine = {
  {
    sPrefabPath = "30102/Play/BreakOutAllResultPanel.prefab",
    sCtrlName = "Game.UI.Play_BreakOut_30101.BreakOutResultCtrl"
  }
}

function BreakOutResultPanel:Awake()
end

function BreakOutResultPanel:OnEnable()
end

function BreakOutResultPanel:OnAfterEnter()
end

function BreakOutResultPanel:OnDisable()
end

function BreakOutResultPanel:OnDestroy()
end

function BreakOutResultPanel:OnRelease()
end

return BreakOutResultPanel
