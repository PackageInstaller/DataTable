local ActivityShopPopupPanel = class("ActivityShopPopupPanel", BasePanel)
ActivityShopPopupPanel._sUIResRootPath = "UI_Activity/"
ActivityShopPopupPanel._bIsMainPanel = false
ActivityShopPopupPanel._tbDefine = {
  {
    sPrefabPath = "20101/Shop/ActivityShopPopupPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.20101.Shop.ActivityShopPopupCtrl"
  }
}

function ActivityShopPopupPanel:Awake()
end

function ActivityShopPopupPanel:OnEnable()
end

function ActivityShopPopupPanel:OnDisable()
end

function ActivityShopPopupPanel:OnDestroy()
end

return ActivityShopPopupPanel
