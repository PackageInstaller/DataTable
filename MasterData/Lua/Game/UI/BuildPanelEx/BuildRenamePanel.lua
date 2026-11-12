local BuildRenamePanel = class("BuildRenamePanel", BasePanel)
BuildRenamePanel._bIsMainPanel = false
BuildRenamePanel._tbDefine = {
  {
    sPrefabPath = "StarTowerBuild/BuildRenamePanel.prefab",
    sCtrlName = "Game.UI.BuildPanelEx.BuildRenameCtrl"
  }
}

function BuildRenamePanel:Awake()
end

function BuildRenamePanel:OnEnable()
end

function BuildRenamePanel:OnDisable()
end

function BuildRenamePanel:OnDestroy()
end

return BuildRenamePanel
