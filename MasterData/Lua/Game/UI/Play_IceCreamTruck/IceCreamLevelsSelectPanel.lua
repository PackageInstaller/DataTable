local IceCreamLevelsSelectPanel = class("IceCreamLevelsSelectPanel", BasePanel)
IceCreamLevelsSelectPanel._bIsMainPanel = true
IceCreamLevelsSelectPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
IceCreamLevelsSelectPanel._sUIResRootPath = "UI_Activity/"
IceCreamLevelsSelectPanel._tbDefine = {
  {
    sPrefabPath = "_400013/IceCreamLevelsSelectPanel.prefab",
    sCtrlName = "Game.UI.Play_IceCreamTruck.IceCreamLevelsSelectCtrl"
  }
}

function IceCreamLevelsSelectPanel:Awake()
  self.nQuestPanelId = PanelId.Task_20103
end

return IceCreamLevelsSelectPanel
