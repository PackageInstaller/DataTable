local MathParkourResultPanel = class("MathParkourResultPanel", BasePanel)
MathParkourResultPanel._nSnapshotPrePanel = 1
MathParkourResultPanel._sUIResRootPath = "UI_Activity/"
MathParkourResultPanel._bIsMainPanel = false
MathParkourResultPanel._tbDefine = {
  {
    sPrefabPath = "_400018/MathParkourResultPanel.prefab",
    sCtrlName = "Game.UI.Activity.MathParkour.MathParkourResultCtrl"
  }
}

function MathParkourResultPanel:Awake()
end

function MathParkourResultPanel:OnEnable()
end

function MathParkourResultPanel:OnAfterEnter()
end

function MathParkourResultPanel:OnDisable()
end

function MathParkourResultPanel:OnDestroy()
end

function MathParkourResultPanel:OnRelease()
end

return MathParkourResultPanel
