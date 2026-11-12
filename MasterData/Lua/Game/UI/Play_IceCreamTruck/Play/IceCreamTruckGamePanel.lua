local IceCreamTruckGamePanel = class("IceCreamTruckGamePanel", BasePanel)
IceCreamTruckGamePanel._bIsMainPanel = true
IceCreamTruckGamePanel._sSortingLayerName = AllEnum.SortingLayerName.UI
IceCreamTruckGamePanel._sUIResRootPath = "UI_Activity/"
IceCreamTruckGamePanel._tbDefine = {
  {
    sPrefabPath = "_400013/IceCreamPlayPanel.prefab",
    sCtrlName = "Game.UI.Play_IceCreamTruck.Play.IceCreamTruckGameCtrl"
  }
}

function IceCreamTruckGamePanel:Awake()
  PlayerData.Base:SetSkipNewDayWindow(true)
end

function IceCreamTruckGamePanel:OnEnable()
end

function IceCreamTruckGamePanel:OnDisable()
end

function IceCreamTruckGamePanel:OnDestroy()
end

return IceCreamTruckGamePanel
