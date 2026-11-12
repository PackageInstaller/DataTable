local BattlePassUpgradePanel = class("BattlePassUpgradePanel", BasePanel)
BattlePassUpgradePanel._bIsMainPanel = false
BattlePassUpgradePanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
BattlePassUpgradePanel._tbDefine = {
  {
    sPrefabPath = "BattlePass/BattlePassUpgradePanel.prefab",
    sCtrlName = "Game.UI.BattlePass.BattlePassUpgradeCtrl"
  }
}

function BattlePassUpgradePanel:Awake()
end

function BattlePassUpgradePanel:OnEnable()
end

function BattlePassUpgradePanel:OnDisable()
end

function BattlePassUpgradePanel:OnDestroy()
end

return BattlePassUpgradePanel
