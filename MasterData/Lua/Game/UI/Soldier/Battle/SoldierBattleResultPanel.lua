local SoldierBattleResultPanel = class("SoldierBattleResultPanel", BasePanel)
SoldierBattleResultPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Battle/SoldierResult.prefab",
    sCtrlName = "Game.UI.Soldier.Battle.SoldierBattleResultCtrl"
  }
}

function SoldierBattleResultPanel:Awake()
end

function SoldierBattleResultPanel:OnEnable()
end

function SoldierBattleResultPanel:OnDisable()
end

function SoldierBattleResultPanel:OnDestroy()
end

return SoldierBattleResultPanel
