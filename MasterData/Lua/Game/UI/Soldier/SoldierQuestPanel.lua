local SoldierMainViewPanel = class("SoldierMainViewPanel", BasePanel)
SoldierMainViewPanel._bIsMainPanel = false
SoldierMainViewPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
SoldierMainViewPanel._nSnapshotPrePanel = 1
SoldierMainViewPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/SoldierQuestPanel.prefab",
    sCtrlName = "Game.UI.Soldier.SoldierQuestCtrl"
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
