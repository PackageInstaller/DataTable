local PreselectionRenamePanel = class("PreselectionRenamePanel", BasePanel)
PreselectionRenamePanel._bIsMainPanel = false
PreselectionRenamePanel._tbDefine = {
  {
    sPrefabPath = "PotentialPreselection/PreselectionRenamePanel.prefab",
    sCtrlName = "Game.UI.PotentialPreselection.PreselectionRenameCtrl"
  }
}

function PreselectionRenamePanel:Awake()
end

function PreselectionRenamePanel:OnEnable()
end

function PreselectionRenamePanel:OnDisable()
end

function PreselectionRenamePanel:OnDestroy()
end

return PreselectionRenamePanel
