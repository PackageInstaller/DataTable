local BuildDetailPanel = class("BuildDetailPanel", BasePanel)
BuildDetailPanel._tbDefine = {
  {
    sPrefabPath = "RoguelikeBuildEX/RoguelikeBuildDetailPanel.prefab",
    sCtrlName = "Game.UI.BuildPanelEx.BuildDetailCtrl"
  }
}

function BuildDetailPanel:Awake()
end

function BuildDetailPanel:OnEnable()
end

function BuildDetailPanel:OnDisable()
end

function BuildDetailPanel:OnDestroy()
end

function BuildDetailPanel:OnRelease()
end

return BuildDetailPanel
