local SoldierMainViewPanel = class("SoldierMainViewPanel", BasePanel)
SoldierMainViewPanel._bIsMainPanel = true
SoldierMainViewPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
SoldierMainViewPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/SoldierMainViewPanel.prefab",
    sCtrlName = "Game.UI.Soldier.SoldierMainViewCtrl"
  }
}

function SoldierMainViewPanel:Awake()
end

function SoldierMainViewPanel:OnEnable()
end

function SoldierMainViewPanel:OnAfterEnter()
end

function SoldierMainViewPanel:OnDisable()
end

function SoldierMainViewPanel:OnDestroy()
end

function SoldierMainViewPanel:OnRelease()
end

return SoldierMainViewPanel
