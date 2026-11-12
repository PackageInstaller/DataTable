local StarTowerFastBattleLogPanel = class("StarTowerFastBattleLogPanel", BasePanel)
StarTowerFastBattleLogPanel._bIsMainPanel = false
StarTowerFastBattleLogPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
StarTowerFastBattleLogPanel._tbDefine = {
  {
    sPrefabPath = "StarTowerFastBattle/StarTowerFastBattleLogPanel.prefab",
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerFastBattleLogCtrl"
  }
}

function StarTowerFastBattleLogPanel:Awake()
  self.tbHistoryLog = self:GetPanelParam()[1]
end

function StarTowerFastBattleLogPanel:OnEnable()
end

function StarTowerFastBattleLogPanel:OnDisable()
end

function StarTowerFastBattleLogPanel:OnDestroy()
end

return StarTowerFastBattleLogPanel
