local SoldierLevelPanel = class("SoldierLevelPanel", BasePanel)
SoldierLevelPanel._bIsMainPanel = true
SoldierLevelPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
SoldierLevelPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Level/SoldierLevelPanel.prefab",
    sCtrlName = "Game.UI.Soldier.SoldierLevelCtrl"
  }
}

function SoldierLevelPanel:Awake()
end

function SoldierLevelPanel:OnEnable()
end

function SoldierLevelPanel:OnAfterEnter()
end

function SoldierLevelPanel:OnDisable()
end

function SoldierLevelPanel:OnDestroy()
end

function SoldierLevelPanel:OnRelease()
end

return SoldierLevelPanel
