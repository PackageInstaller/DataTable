local BuildAttrPreviewPanel = class("BuildAttrPreviewPanel", BasePanel)
BuildAttrPreviewPanel._bIsMainPanel = false
BuildAttrPreviewPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
BuildAttrPreviewPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerBuild/BuildAttrPreviewPanel.prefab",
    sCtrlName = "Game.UI.StarTower.Build.BuildAttrPreviewCtrl"
  }
}

function BuildAttrPreviewPanel:Awake()
end

function BuildAttrPreviewPanel:OnEnable()
end

function BuildAttrPreviewPanel:OnAfterEnter()
end

function BuildAttrPreviewPanel:OnDisable()
end

function BuildAttrPreviewPanel:OnDestroy()
end

function BuildAttrPreviewPanel:OnRelease()
end

return BuildAttrPreviewPanel
