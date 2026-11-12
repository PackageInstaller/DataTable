local RankBuildDetailPanel = class("RankBuildDetailPanel", BasePanel)
RankBuildDetailPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerBuild/RankBuildDetailPanel.prefab",
    sCtrlName = "Game.UI.StarTower.Build.RankBuildDetailCtrl"
  }
}

function RankBuildDetailPanel:Awake()
end

function RankBuildDetailPanel:OnEnable()
end

function RankBuildDetailPanel:OnDisable()
end

function RankBuildDetailPanel:OnDestroy()
end

function RankBuildDetailPanel:OnRelease()
end

return RankBuildDetailPanel
