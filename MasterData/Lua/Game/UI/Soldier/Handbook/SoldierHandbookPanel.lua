local SoldierHandbookPanel = class("SoldierHandbookPanel", BasePanel)
SoldierHandbookPanel._bIsMainPanel = true
SoldierHandbookPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
SoldierHandbookPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/SoldierHandbookPanel.prefab",
    sCtrlName = "Game.UI.Soldier.Handbook.SoldierHandbookCtrl"
  }
}

function SoldierHandbookPanel:Awake()
end

function SoldierHandbookPanel:OnEnable()
end

function SoldierHandbookPanel:OnAfterEnter()
end

function SoldierHandbookPanel:OnDisable()
end

function SoldierHandbookPanel:OnDestroy()
end

function SoldierHandbookPanel:OnRelease()
end

return SoldierHandbookPanel
