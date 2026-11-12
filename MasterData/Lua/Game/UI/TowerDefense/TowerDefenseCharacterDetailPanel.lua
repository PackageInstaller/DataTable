local TowerDefenseCharacterDetailPanel = class("TowerDefenseCharacterDetailPanel", BasePanel)
TowerDefenseCharacterDetailPanel._nSnapshotPrePanel = 1
TowerDefenseCharacterDetailPanel._bIsMainPanel = false
TowerDefenseCharacterDetailPanel._tbDefine = {
  {
    sPrefabPath = "Play_TowerDefence/TowerDefenseCharacterDetailPanel.prefab",
    sCtrlName = "Game.UI.TowerDefense.TowerDefenseCharacterDetailCtrl"
  }
}

function TowerDefenseCharacterDetailPanel:Awake()
end

function TowerDefenseCharacterDetailPanel:OnEnable()
end

function TowerDefenseCharacterDetailPanel:OnAfterEnter()
end

function TowerDefenseCharacterDetailPanel:OnDisable()
end

function TowerDefenseCharacterDetailPanel:OnDestroy()
end

function TowerDefenseCharacterDetailPanel:OnRelease()
end

return TowerDefenseCharacterDetailPanel
