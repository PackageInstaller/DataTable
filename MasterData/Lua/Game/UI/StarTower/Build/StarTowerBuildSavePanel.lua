local StarTowerBuildSavePanel = class("StarTowerBuildSavePanel", BasePanel)
StarTowerBuildSavePanel._bAddToBackHistory = false
StarTowerBuildSavePanel._tbDefine = {
  {
    sPrefabPath = "StarTowerBuild/StarTowerBuildSavePanel.prefab",
    sCtrlName = "Game.UI.StarTower.Build.StarTowerBuildSaveCtrl"
  }
}

function StarTowerBuildSavePanel:Awake()
end

function StarTowerBuildSavePanel:OnEnable()
end

function StarTowerBuildSavePanel:OnDisable()
end

function StarTowerBuildSavePanel:OnDestroy()
end

return StarTowerBuildSavePanel
