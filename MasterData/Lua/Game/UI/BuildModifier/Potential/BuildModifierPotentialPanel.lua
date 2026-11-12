local BuildModifierPotentialPanel = class("BuildModifierPotentialPanel", BasePanel)
BuildModifierPotentialPanel._tbDefine = {
  {
    sPrefabPath = "BuildFunction/BuildModifierPotentialPanel.prefab",
    sCtrlName = "Game.UI.BuildModifier.Potential.BuildModifierPotentialCtrl"
  }
}

function BuildModifierPotentialPanel:Awake()
  self.nTotalAddCount = 0
  self.nTotalReduceCount = 0
  self.nMaxPotentialLevel = 6
  self.mapChangedPotential = {}
  self.hasData = false
end

function BuildModifierPotentialPanel:OnEnable()
end

function BuildModifierPotentialPanel:OnAfterEnter()
end

function BuildModifierPotentialPanel:OnDisable()
end

function BuildModifierPotentialPanel:OnDestroy()
end

function BuildModifierPotentialPanel:OnRelease()
end

return BuildModifierPotentialPanel
