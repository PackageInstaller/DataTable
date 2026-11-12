local SoldierResolveadisputePanel = class("SoldierResolveadisputePanel", BasePanel)
SoldierResolveadisputePanel._bIsMainPanel = false
SoldierResolveadisputePanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Level/SoldierResolveadisputePanel.prefab",
    sCtrlName = "Game.UI.Soldier.BattleEvent.SoldierResolveadisputeCtrl"
  }
}

function SoldierResolveadisputePanel:Awake()
end

function SoldierResolveadisputePanel:OnEnable()
end

function SoldierResolveadisputePanel:OnAfterEnter()
end

function SoldierResolveadisputePanel:OnDisable()
end

function SoldierResolveadisputePanel:OnDestroy()
end

function SoldierResolveadisputePanel:OnRelease()
end

return SoldierResolveadisputePanel
