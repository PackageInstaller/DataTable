local BuildSavePanel = class("BuildSavePanel", BasePanel)
BuildSavePanel._tbDefine = {
  {
    sPrefabPath = "RoguelikeBuildEX/RoguelikeBuildSavePanel.prefab",
    sCtrlName = "Game.UI.BuildPanelEx.BuildSaveCtrl"
  }
}

function BuildSavePanel:Awake()
end

function BuildSavePanel:OnEnable()
end

function BuildSavePanel:OnDisable()
end

function BuildSavePanel:OnDestroy()
end

function BuildSavePanel:OnRelease()
end

return BuildSavePanel
