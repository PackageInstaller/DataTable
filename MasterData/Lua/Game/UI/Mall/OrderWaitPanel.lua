local OrderWaitPanel = class("OrderWaitPanel", BasePanel)
OrderWaitPanel._bAddToBackHistory = false
OrderWaitPanel._sSortingLayerName = AllEnum.SortingLayerName.UI_Top
OrderWaitPanel._tbDefine = {
  {
    sPrefabPath = "Mall/OrderWaitPanel.prefab",
    sCtrlName = "Game.UI.Mall.OrderWaitCtrl"
  }
}

function OrderWaitPanel:Awake()
end

function OrderWaitPanel:OnEnable()
end

function OrderWaitPanel:OnDisable()
end

function OrderWaitPanel:OnDestroy()
end

return OrderWaitPanel
