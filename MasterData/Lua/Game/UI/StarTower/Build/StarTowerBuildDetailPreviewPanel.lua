local StarTowerBuildDetailPreviewPanel = class("StarTowerBuildDetailPreviewPanel", BasePanel)
StarTowerBuildDetailPreviewPanel._bIsMainPanel = false
StarTowerBuildDetailPreviewPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
StarTowerBuildDetailPreviewPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerBuild/StarTowerBuildDetailPanel.prefab",
    sCtrlName = "Game.UI.StarTower.Build.StarTowerBuildDetailCtrl"
  }
}

function StarTowerBuildDetailPreviewPanel:Awake()
end

function StarTowerBuildDetailPreviewPanel:OnEnable()
end

function StarTowerBuildDetailPreviewPanel:OnDisable()
end

function StarTowerBuildDetailPreviewPanel:OnDestroy()
end

function StarTowerBuildDetailPreviewPanel:OnRelease()
end

return StarTowerBuildDetailPreviewPanel
