local GoldenSpyResultPanel = class("GoldenSpyResultPanel", BasePanel)
GoldenSpyResultPanel._bIsMainPanel = true
GoldenSpyResultPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
GoldenSpyResultPanel._nSnapshotPrePanel = 1
GoldenSpyResultPanel._sUIResRootPath = "UI_Activity/"
GoldenSpyResultPanel._tbDefine = {
  {
    sPrefabPath = "_400017/GoldenSpyResultPanel.prefab",
    sCtrlName = "Game.UI.Activity.GoldenSpy.GoldenSpyResultCtrl"
  }
}

function GoldenSpyResultPanel:Awake()
end

function GoldenSpyResultPanel:OnEnable()
end

function GoldenSpyResultPanel:OnAfterEnter()
end

function GoldenSpyResultPanel:OnDisable()
end

function GoldenSpyResultPanel:OnDestroy()
end

function GoldenSpyResultPanel:OnRelease()
end

return GoldenSpyResultPanel
