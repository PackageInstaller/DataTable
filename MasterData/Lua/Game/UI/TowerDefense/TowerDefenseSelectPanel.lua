local TowerDefenseSelectPanel = class("TowerDefenseSelectPanel", BasePanel)
TowerDefenseSelectPanel._bIsMainPanel = true
TowerDefenseSelectPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
TowerDefenseSelectPanel._tbDefine = {
  {
    sPrefabPath = "Play_TowerDefence/TowerDefenseSelectPanel.prefab",
    sCtrlName = "Game.UI.TowerDefense.TowerDefenseSelectCtrl"
  }
}

function TowerDefenseSelectPanel:Awake()
  self.nlevelId = 0
  self.nSelectedTabIndex = 0
end

function TowerDefenseSelectPanel:OnEnable()
end

function TowerDefenseSelectPanel:OnAfterEnter()
end

function TowerDefenseSelectPanel:OnDisable()
end

function TowerDefenseSelectPanel:OnDestroy()
end

function TowerDefenseSelectPanel:OnRelease()
end

return TowerDefenseSelectPanel
