local PotentialPreselectionEditPanel = class("PotentialPreselectionEditPanel", BasePanel)
PotentialPreselectionEditPanel._tbDefine = {
  {
    sPrefabPath = "PotentialPreselection/PotentialPreselectionEditPanel.prefab",
    sCtrlName = "Game.UI.PotentialPreselection.PotentialPreselectionEditCtrl"
  }
}

function PotentialPreselectionEditPanel:Awake()
  self.nPanelType = 0
end

function PotentialPreselectionEditPanel:OnEnable()
end

function PotentialPreselectionEditPanel:OnDisable()
end

function PotentialPreselectionEditPanel:OnDestroy()
end

return PotentialPreselectionEditPanel
