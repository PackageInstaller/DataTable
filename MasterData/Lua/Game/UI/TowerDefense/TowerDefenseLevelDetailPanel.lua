local TowerDefenseLevelDetailPanel = class("TowerDefenseLevelDetailPanel", BasePanel)
TowerDefenseLevelDetailPanel._bIsMainPanel = true
TowerDefenseLevelDetailPanel._bAddToBackHistory = true
TowerDefenseLevelDetailPanel._tbDefine = {
  {
    sPrefabPath = "Play_TowerDefence/TowerDefenseLevelDetailPanel.prefab",
    sCtrlName = "Game.UI.TowerDefense.TowerDefenseLevelDetailCtrl"
  }
}

function TowerDefenseLevelDetailPanel:Awake()
end

function TowerDefenseLevelDetailPanel:OnEnable()
end

function TowerDefenseLevelDetailPanel:OnAfterEnter()
end

function TowerDefenseLevelDetailPanel:OnDisable()
end

function TowerDefenseLevelDetailPanel:OnDestroy()
end

function TowerDefenseLevelDetailPanel:OnRelease()
end

return TowerDefenseLevelDetailPanel
