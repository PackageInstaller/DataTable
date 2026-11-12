local ActivityShopPopupPanel = class("ActivityShopPopupPanel", BasePanel)
ActivityShopPopupPanel._bIsMainPanel = false
ActivityShopPopupPanel._tbDefine = {
  {
    sPrefabPath = "ShopPopup/ActivityShopPopupPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.ShopCommon.ActivityShopPopupCtrl"
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
