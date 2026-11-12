local WorldClassUpgradePanel = class("WorldClassUpgradePanel", BasePanel)
WorldClassUpgradePanel._bIsMainPanel = false
WorldClassUpgradePanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
WorldClassUpgradePanel._tbDefine = {
  {
    sPrefabPath = "WorldClassEx/WorldClassUpgradePanel.prefab",
    sCtrlName = "Game.UI.WorldClassEx.WorldClassUpgradeCtrl"
  }
}

function WorldClassUpgradePanel:Awake()
end

function WorldClassUpgradePanel:OnEnable()
end

function WorldClassUpgradePanel:OnDisable()
end

function WorldClassUpgradePanel:OnDestroy()
end

return WorldClassUpgradePanel
