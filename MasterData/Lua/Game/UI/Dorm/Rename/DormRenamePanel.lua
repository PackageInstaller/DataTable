local DormRenamePanel = class("DormRenamePanel", BasePanel)
DormRenamePanel._bIsMainPanel = false
DormRenamePanel._tbDefine = {
  {
    sPrefabPath = "Dorm/DormRenamePanel.prefab",
    sCtrlName = "Game.UI.Dorm.Rename.DormRenameCtrl"
  }
}

function DormRenamePanel:Awake()
end

function DormRenamePanel:OnEnable()
end

function DormRenamePanel:OnDisable()
end

function DormRenamePanel:OnDestroy()
end

return DormRenamePanel
