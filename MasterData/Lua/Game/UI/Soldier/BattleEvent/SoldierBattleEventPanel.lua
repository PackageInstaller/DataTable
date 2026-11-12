local SoldierBattleEventPanel = class("SoldierBattleEventPanel", BasePanel)
SoldierBattleEventPanel._bIsMainPanel = false
SoldierBattleEventPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Level/SoldierBattleEventPanel.prefab",
    sCtrlName = "Game.UI.Soldier.BattleEvent.SoldierBattleEventCtrl"
  }
}

function SoldierBattleEventPanel:Awake()
end

function SoldierBattleEventPanel:OnEnable()
end

function SoldierBattleEventPanel:OnAfterEnter()
end

function SoldierBattleEventPanel:OnDisable()
end

function SoldierBattleEventPanel:OnDestroy()
end

function SoldierBattleEventPanel:OnRelease()
end

return SoldierBattleEventPanel
