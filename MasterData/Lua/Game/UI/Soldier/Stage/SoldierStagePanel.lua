local SoldierStagePanel = class("SoldierStagePanel", BasePanel)
SoldierStagePanel._bIsMainPanel = false
SoldierStagePanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Battle/SoldierStagePanel.prefab",
    sCtrlName = "Game.UI.Soldier.Stage.SoldierStageCtrl"
  }
}

function SoldierStagePanel:Awake()
end

function SoldierStagePanel:OnEnable()
end

function SoldierStagePanel:OnAfterEnter()
end

function SoldierStagePanel:OnDisable()
end

function SoldierStagePanel:OnDestroy()
end

function SoldierStagePanel:OnRelease()
end

return SoldierStagePanel
