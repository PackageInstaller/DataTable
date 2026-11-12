local SoldierLevelSelectPanel = class("SoldierLevelSelectPanel", BasePanel)
SoldierLevelSelectPanel._bIsMainPanel = true
SoldierLevelSelectPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
SoldierLevelSelectPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/SoldierLevelSelectPanel.prefab",
    sCtrlName = "Game.UI.Soldier.SoldierLevelSelectCtrl"
  }
}

function SoldierLevelSelectPanel:Awake()
end

function SoldierLevelSelectPanel:OnEnable()
end

function SoldierLevelSelectPanel:OnAfterEnter()
end

function SoldierLevelSelectPanel:OnDisable()
end

function SoldierLevelSelectPanel:OnDestroy()
end

function SoldierLevelSelectPanel:OnRelease()
end

return SoldierLevelSelectPanel
