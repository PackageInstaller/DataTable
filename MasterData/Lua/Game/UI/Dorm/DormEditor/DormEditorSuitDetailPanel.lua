local DormEditorSuitDetailPanel = class("DormEditorSuitDetailPanel", BasePanel)
DormEditorSuitDetailPanel._bIsMainPanel = false
DormEditorSuitDetailPanel._tbDefine = {
  {
    sPrefabPath = "Dorm/DormLayoutInfo.prefab",
    sCtrlName = "Game.UI.Dorm.DormEditor.DormEditorSuitDetailCtrl"
  }
}

function DormEditorSuitDetailPanel:Awake()
end

function DormEditorSuitDetailPanel:OnEnable()
end

function DormEditorSuitDetailPanel:OnAfterEnter()
end

function DormEditorSuitDetailPanel:OnDisable()
end

function DormEditorSuitDetailPanel:OnDestroy()
end

function DormEditorSuitDetailPanel:OnRelease()
end

return DormEditorSuitDetailPanel
