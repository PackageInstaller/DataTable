local SoldierEventPanel = class("SoldierEventPanel", BasePanel)
SoldierEventPanel._bIsMainPanel = false
SoldierEventPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Level/SoldierEventPanel.prefab",
    sCtrlName = "Game.UI.Soldier.BattleEvent.SoldierEventCtrl"
  }
}

function SoldierEventPanel:Awake()
end

function SoldierEventPanel:OnEnable()
end

function SoldierEventPanel:OnAfterEnter()
end

function SoldierEventPanel:OnDisable()
end

function SoldierEventPanel:OnDestroy()
end

function SoldierEventPanel:OnRelease()
end

return SoldierEventPanel
