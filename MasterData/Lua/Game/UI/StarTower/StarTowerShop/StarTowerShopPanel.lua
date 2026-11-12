local StarTowerShopPanel = class("StarTowerShopPanel", BasePanel)
StarTowerShopPanel._bIsMainPanel = false
StarTowerShopPanel._tbDefine = {
  {
    sPrefabPath = "StarTower/StarTowerShopPanel.prefab",
    sCtrlName = "Game.UI.StarTower.StarTowerShop.StarTowerShopCtrl"
  }
}
return StarTowerShopPanel
