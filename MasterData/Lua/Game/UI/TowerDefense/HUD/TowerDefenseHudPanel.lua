local TowerDefenseHudPanel = class("TowerDefenseHudPanel", BasePanel)
TowerDefenseHudPanel._bAddToBackHistory = false
TowerDefenseHudPanel._bIsMainPanel = false
TowerDefenseHudPanel._sSortingLayerName = AllEnum.SortingLayerName.HUD
TowerDefenseHudPanel._tbDefine = {
  {
    sPrefabPath = "Play_TowerDefence/HUD/HUDROOT.prefab",
    sCtrlName = "Game.UI.TowerDefense.HUD.TowerDefenseHUDCtrl"
  }
}
return TowerDefenseHudPanel
