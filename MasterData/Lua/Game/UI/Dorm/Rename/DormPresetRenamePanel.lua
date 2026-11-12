local DormPresetRenamePanel = class("DormPresetRenamePanel", BasePanel)
DormPresetRenamePanel._bIsMainPanel = false
DormPresetRenamePanel._tbDefine = {
  {
    sPrefabPath = "Dorm/DormRenamePanel.prefab",
    sCtrlName = "Game.UI.Dorm.Rename.DormPresetRenameCtrl"
  }
}

function DormPresetRenamePanel:Awake()
end

function DormPresetRenamePanel:OnEnable()
end

function DormPresetRenamePanel:OnDisable()
end

function DormPresetRenamePanel:OnDestroy()
end

return DormPresetRenamePanel
