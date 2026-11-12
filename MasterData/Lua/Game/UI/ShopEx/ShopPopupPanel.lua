local ShopPopupPanel = class("ShopPopupPanel", BasePanel)
ShopPopupPanel._bIsMainPanel = false
ShopPopupPanel._tbDefine = {
  {
    sPrefabPath = "ShopEx/ShopPopupPanel.prefab",
    sCtrlName = "Game.UI.ShopEx.ShopPopupCtrl"
  }
}

function ShopPopupPanel:Awake()
end

function ShopPopupPanel:OnEnable()
end

function ShopPopupPanel:OnDisable()
end

function ShopPopupPanel:OnDestroy()
end

return ShopPopupPanel
