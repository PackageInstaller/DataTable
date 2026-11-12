local SoldierBattleEndingPanel = class("SoldierBattleEndingPanel", BasePanel)
SoldierBattleEndingPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Battle/SoldierBattleEndingPanel.prefab",
    sCtrlName = "Game.UI.Soldier.Battle.SoldierBattleEndingCtrl"
  }
}

function SoldierBattleEndingPanel:Awake()
end

function SoldierBattleEndingPanel:OnEnable()
end

function SoldierBattleEndingPanel:OnDisable()
end

function SoldierBattleEndingPanel:OnDestroy()
end

return SoldierBattleEndingPanel
