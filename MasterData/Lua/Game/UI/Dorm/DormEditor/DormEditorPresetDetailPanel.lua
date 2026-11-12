local DormEditorPresetDetailPanel = class("DormEditorPresetDetailPanel", BasePanel)
DormEditorPresetDetailPanel._bIsMainPanel = false
DormEditorPresetDetailPanel._tbDefine = {
  {
    sPrefabPath = "Dorm/DormPresetDetailPanel.prefab",
    sCtrlName = "Game.UI.Dorm.DormEditor.DormEditorPresetDetailCtrl"
  }
}

function DormEditorPresetDetailPanel:Awake()
end

function DormEditorPresetDetailPanel:OnEnable()
end

function DormEditorPresetDetailPanel:OnAfterEnter()
end

function DormEditorPresetDetailPanel:OnDisable()
end

function DormEditorPresetDetailPanel:OnDestroy()
end

function DormEditorPresetDetailPanel:OnRelease()
end

return DormEditorPresetDetailPanel
