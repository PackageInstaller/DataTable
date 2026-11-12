local TDClassUpgradePanel = class("TDClassUpgradePanel", BasePanel)
TDClassUpgradePanel._bIsMainPanel = false
TDClassUpgradePanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
TDClassUpgradePanel._tbDefine = {
  {
    sPrefabPath = "TravelerDuelLevelSelect/TDClassUpgradePanel.prefab",
    sCtrlName = "Game.UI.TravelerDuelLevelSelect.TDClassUpgradeCtrl"
  }
}

function TDClassUpgradePanel:Awake()
end

function TDClassUpgradePanel:OnEnable()
end

function TDClassUpgradePanel:OnDisable()
end

function TDClassUpgradePanel:OnDestroy()
end

return TDClassUpgradePanel
