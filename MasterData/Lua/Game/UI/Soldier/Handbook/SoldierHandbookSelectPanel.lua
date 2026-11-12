local SoldierHandbookSelectPanel = class("SoldierHandbookSelectPanel", BasePanel)
SoldierHandbookSelectPanel._bIsMainPanel = true
SoldierHandbookSelectPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
SoldierHandbookSelectPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/SoldierHandbookSelectPanel.prefab",
    sCtrlName = "Game.UI.Soldier.Handbook.SoldierHandbookSelectCtrl"
  }
}

function SoldierHandbookSelectPanel:Awake()
end

function SoldierHandbookSelectPanel:OnEnable()
end

function SoldierHandbookSelectPanel:OnAfterEnter()
end

function SoldierHandbookSelectPanel:OnDisable()
end

function SoldierHandbookSelectPanel:OnDestroy()
end

function SoldierHandbookSelectPanel:OnRelease()
end

return SoldierHandbookSelectPanel
