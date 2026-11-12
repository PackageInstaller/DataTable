local TowerDefenseResultPanel = class("TowerDefenseResultPanel", BasePanel)
TowerDefenseResultPanel._nSnapshotPrePanel = 1
TowerDefenseResultPanel._tbDefine = {
  {
    sPrefabPath = "Play_TowerDefence/TowerDefenseResultPanel.prefab",
    sCtrlName = "Game.UI.TowerDefense.TowerDefenseResultCtrl"
  }
}

function TowerDefenseResultPanel:Awake()
end

function TowerDefenseResultPanel:OnEnable()
end

function TowerDefenseResultPanel:OnAfterEnter()
end

function TowerDefenseResultPanel:OnDisable()
end

function TowerDefenseResultPanel:OnDestroy()
end

function TowerDefenseResultPanel:OnRelease()
end

return TowerDefenseResultPanel
