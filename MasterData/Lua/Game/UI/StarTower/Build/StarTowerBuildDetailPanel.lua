local StarTowerBuildDetailPanel = class("StarTowerBuildDetailPanel", BasePanel)
StarTowerBuildDetailPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerBuild/StarTowerBuildDetailPanel.prefab",
    sCtrlName = "Game.UI.StarTower.Build.StarTowerBuildDetailCtrl"
  }
}

function StarTowerBuildDetailPanel:Awake()
end

function StarTowerBuildDetailPanel:OnEnable()
end

function StarTowerBuildDetailPanel:OnDisable()
end

function StarTowerBuildDetailPanel:OnDestroy()
end

function StarTowerBuildDetailPanel:OnRelease()
end

return StarTowerBuildDetailPanel
