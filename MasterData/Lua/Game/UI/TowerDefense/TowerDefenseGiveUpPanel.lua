local TowerDefenseGiveUpPanel = class("TowerDefenseGiveUpPanel", BasePanel)
TowerDefenseGiveUpPanel._bIsMainPanel = true
TowerDefenseGiveUpPanel._bAddToBackHistory = true
TowerDefenseGiveUpPanel._tbDefine = {
  {
    sPrefabPath = "Play_TowerDefence/TowerDefenseGiveUpPanel.prefab",
    sCtrlName = "Game.UI.TowerDefense.TowerDefenseGiveUpCtrl"
  }
}

function TowerDefenseGiveUpPanel:Awake()
end

function TowerDefenseGiveUpPanel:OnEnable()
end

function TowerDefenseGiveUpPanel:OnAfterEnter()
end

function TowerDefenseGiveUpPanel:OnDisable()
end

function TowerDefenseGiveUpPanel:OnDestroy()
end

function TowerDefenseGiveUpPanel:OnRelease()
end

return TowerDefenseGiveUpPanel
